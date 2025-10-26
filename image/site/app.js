document.getElementById('rollButton').addEventListener('click', () => {
    const dice1 = Math.floor(Math.random() * 6) + 1;
    const dice2 = Math.floor(Math.random() * 6) + 1;

    document.getElementById('dice1').textContent = dice1;
    document.getElementById('dice2').textContent = dice2;
    document.getElementById('total').textContent = `Total: ${dice1 + dice2}`;
});
