  import React, { Component } from 'react';
import {Avatar, Card, List, ResourceList, FilterType, Select, TextField, TextStyle, Pagination } from '@shopify/polaris';


class ResourcesList extends Component {
  state = {
    searchValue: '',
    appliedFilters: [
      // {
      //   key: 'accountStatusFilter',
      //   value: 'Account enabled',
      // },
    ],
    page_id: 1,
    isFirstPage: true,
    isLastPage: false,
  };

  handleSearchChange = (searchValue) => {
    this.setState({searchValue: searchValue});
    this.props.fetchProducts({page_id: 1, searchValue: searchValue })

  };

  handleFiltersChange = (appliedFilters) => {
    this.setState({appliedFilters});
  };

  // PAGINATION
  nextPage = () => {
    console.log('Next');
    this.setState({page_id: this.state.page_id += 1})
    this.setState({isFirstPage: false})
    this.props.handlePageChange({page_id: this.state.page_id })
  };

  prevPage = () => {
    console.log('Previous');
    this.setState({page_id: this.state.page_id -= 1});
    (this.state.page_id == 1) ? this.setState({isFirstPage: true}) : '';
    this.props.handlePageChange({page_id: this.state.page_id });
  };
  // PAGINATION


  renderItem = (item) => {
    const {id, url, title, image, published_at} = item;
    const img_src = image ? image.src : `https://via.placeholder.com/150/`
    const media = <img style={{maxHeight: "60px", width: "60px", objectFit: "contain"}} src={img_src} />;

    return (
      <ResourceList.Item id={id} url={url} media={media}>
          <TextStyle>{title}</TextStyle>
      </ResourceList.Item>
    );
  };

  render() {
    const resourceName = {
      singular: 'product',
      plural: 'products',
    };
    const {
      isFirstPage,
      isLastPage,
    } = this.state;

    const items = this.props.products;

    const filters = [
      {
        key: 'orderCountFilter',
        label: 'Number of orders',
        operatorText: 'is greater than',
        type: FilterType.TextField,
      },
      {
        key: 'accountStatusFilter',
        label: 'Account status',
        operatorText: 'is',
        type: FilterType.Select,
        options: ['Enabled', 'Invited', 'Not invited', 'Declined'],
      },
    ];

    const filterControl = (
      <ResourceList.FilterControl
        filters={filters}
        appliedFilters={this.state.appliedFilters}
        onFiltersChange={this.handleFiltersChange}
        searchValue={this.state.searchValue}
        onSearchChange={this.handleSearchChange}
        additionalAction={{
          content: 'Save',
          onAction: () => this.props.handlePageChange({ searchValue: this.state.searchValue })
        }}
      />

    );

    return (
      <Card>
        <ResourceList
          resourceName={resourceName}
          items={items}
          renderItem={this.renderItem}
          filterControl={filterControl}

        />
        <Pagination
          hasPrevious={!isFirstPage}
          hasNext={items.length == 10 }
          onPrevious={this.prevPage}
          onNext={this.nextPage}
        />
      </Card>
    );
  }
}

export default ResourcesList;



