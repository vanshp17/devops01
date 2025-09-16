const express = require('express');
const router = express.Router();
const Order = require('../models/orderModel');

// @route   POST /api/orders
// @desc    Create a new order
// @access  Public
router.post('/', async (req, res) => {
  try {
    // Destructure the expected data from the request body
    const { orderId, items, total, shippingDetails } = req.body;

    // Basic validation: Check if required fields are present
    if (!orderId || !items || !total || !shippingDetails) {
      return res.status(400).json({ msg: 'Please include all fields' });
    }

    // Create a new order instance using the Order model
    const newOrder = new Order({
      orderId,
      items,
      total,
      shippingDetails,
    });

    // Save the new order to the database
    const savedOrder = await newOrder.save();

    // Respond with the saved order object and a success status
    res.status(201).json(savedOrder);

  } catch (err) {
    // If an error occurs, log it to the console and send a server error response
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});

module.exports = router;
