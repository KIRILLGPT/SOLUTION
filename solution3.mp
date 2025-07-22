# Stratified Train/Test Split by A and B

Реализует функцию train_test_split_stratify_by_a_and_b(data: pd.DataFrame, test_ratio: float, random_seed: int) -> Tuple[pd.DataFrame, pd.DataFrame]], которая разбивает DataFrame на обучающую и тестовую выборки, сохраняя распределения по комбинациям признаков A и B.

```python
import pandas as pd
import numpy as np
from typing import Tuple

def train_test_split_stratify_by_a_and_b(
    data: pd.DataFrame,
    test_ratio: float = 0.2,
    random_seed: int = 83
) -> Tuple[pd.DataFrame, pd.DataFrame]:
    """
    Разбивает DataFrame на train/test с сохранением распределения
    по комбинациям столбцов A и B.

    Args:
        data (pd.DataFrame): Входной DataFrame с колонками 'A' и 'B'.
        test_ratio (float): Доля строк в тестовой выборке (по умолчанию 0.2).
        random_seed (int): Значение seed для воспроизводимости (по умолчанию 83).

    Returns:
        Tuple[pd.DataFrame, pd.DataFrame]: (train_df, test_df)
    """
    # Проверка наличия колонок A и B
    if not {'A', 'B'}.issubset(data.columns):
        raise ValueError("Входной DataFrame должен содержать столбцы 'A' и 'B'")

    # Формируем метки-страты на основе комбинаций A и B
    strata = data['A'].astype(str) + '_' + data['B'].astype(str)

    # Локальный генератор случайных чисел для воспроизводимости
    rng = np.random.RandomState(random_seed)

    train_indices = []
    test_indices = []

    # Для каждой страты перемешиваем индексы и распределяем в train/test
    for group in strata.unique():
        idx = data.index[strata == group].tolist()
        rng.shuffle(idx)
        n_test = int(round(len(idx) * test_ratio))
        test_indices.extend(idx[:n_test])
        train_indices.extend(idx[n_test:])

    # Собираем выборки и сбрасываем индексы
    train_df = data.loc[train_indices].reset_index(drop=True)
    test_df  = data.loc[test_indices].reset_index(drop=True)

    return train_df, test_df
