  import React from 'react'
  import ReactDOM from 'react-dom'
  import Main from '../components/main'
  import '@shopify/polaris/styles.css';
  import {AppProvider, Page, Card, Button} from '@shopify/polaris';

  document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
      <AppProvider>
        <Page title="Example app">
          <Main />
          <Card sectioned>
            <Button onClick={() => alert('Button clicked!')}>Example button</Button>
          </Card>
        </Page>
      </AppProvider>,
      document.getElementById('app'),
    )
  })

