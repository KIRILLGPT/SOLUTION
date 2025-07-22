# Remove Duplicates Preserve Order

Реализует функцию remove_duplicates_preserve_order(nums: list[int]) -> list[int], которая удаляет дубликаты из списка, сохраняя порядок первых вхождений элементов.

```python
from typing import List

def remove_duplicates_preserve_order(nums: List[int]) -> List[int]:
    """
    Убирает дубликаты из списка целых чисел, сохраняя порядок первых появлений.

    Args:
        nums (List[int]): Исходный список чисел.

    Returns:
        List[int]: Новый список без дубликатов.
    """
    seen: set[int] = set()
    result: List[int] = []
    for num in nums:
        if num not in seen:
            result.append(num)
            seen.add(num)
    return result
