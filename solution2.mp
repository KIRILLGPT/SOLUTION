# Longest Unique Sublist

Реализует функцию longest_unique_sublist(nums: List[int]) -> Tuple[int, List[int]], которая возвращает длину самого длинного непрерывного подмассива без повторяющихся элементов и сам этот подмассив.

```python
from typing import List, Tuple

def longest_unique_sublist(nums: List[int]) -> Tuple[int, List[int]]:
    """
    Находит длину самого длинного непрерывного подмассива без повторяющихся элементов,
    а также сам этот подмассив.

    Args:
        nums (List[int]): Входной список чисел.

    Returns:
        Tuple[int, List[int]]: Кортеж (длина, подмассив).
    """
    seen: set[int] = set()
    left = 0
    max_length = 0
    start_idx = 0

    for right, value in enumerate(nums):
        # Сдвигаем левый край окна, пока не уберём предыдущий дубликат
        while value in seen:
            seen.remove(nums[left])
            left += 1

        seen.add(value)

        # Обновляем максимальную длину и запоминаем начало окна
        current_length = right - left + 1
        if current_length > max_length:
            max_length = current_length
            start_idx = left

    # Восстанавливаем сам подмассив по сохранённым границам
    longest_subarray = nums[start_idx : start_idx + max_length]
    return max_length, longest_subarray
