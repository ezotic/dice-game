function setInitialState(dice1El, dice2El, totalEl) {
    dice1El.textContent = '0';
    dice2El.textContent = '0';
    totalEl.textContent = 'Total: 0';
}

document.addEventListener('DOMContentLoaded', () => {
    const rollButton = document.getElementById('rollButton');
    const dice1El = document.getElementById('dice1');
    const dice2El = document.getElementById('dice2');
    const totalEl = document.getElementById('total');

    if (!rollButton || !dice1El || !dice2El || !totalEl) {
        console.error('Dice app failed to initialize: missing required DOM elements.');
        return;
    }

    setInitialState(dice1El, dice2El, totalEl);

    rollButton.addEventListener('click', () => {
        const dice1 = Math.floor(Math.random() * 6) + 1;
        const dice2 = Math.floor(Math.random() * 6) + 1;

        dice1El.textContent = String(dice1);
        dice2El.textContent = String(dice2);
        totalEl.textContent = `Total: ${dice1 + dice2}`;
    });
});
