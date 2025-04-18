require "test_helper"

class DepositsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deposit = deposits(:one)
  end

  test "should get index" do
    get deposits_url
    assert_response :success
  end

  test "should get new" do
    get new_deposit_url
    assert_response :success
  end

  test "should create deposit" do
    assert_difference("Deposit.count") do
      post deposits_url, params: { deposit: { amount: @deposit.amount, ano: @deposit.ano, apartment_id: @deposit.apartment_id, comment: @deposit.comment, date: @deposit.date, mes: @deposit.mes, tipo_ingreso: @deposit.tipo_ingreso, user_id: @deposit.user_id } }
    end

    assert_redirected_to deposit_url(Deposit.last)
  end

  test "should show deposit" do
    get deposit_url(@deposit)
    assert_response :success
  end

  test "should get edit" do
    get edit_deposit_url(@deposit)
    assert_response :success
  end

  test "should update deposit" do
    patch deposit_url(@deposit), params: { deposit: { amount: @deposit.amount, ano: @deposit.ano, apartment_id: @deposit.apartment_id, comment: @deposit.comment, date: @deposit.date, mes: @deposit.mes, tipo_ingreso: @deposit.tipo_ingreso, user_id: @deposit.user_id } }
    assert_redirected_to deposit_url(@deposit)
  end

  test "should destroy deposit" do
    assert_difference("Deposit.count", -1) do
      delete deposit_url(@deposit)
    end

    assert_redirected_to deposits_url
  end
end
