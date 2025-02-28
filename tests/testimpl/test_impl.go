package testimpl

import (
	"context"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/cloud"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	armEventhub "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/eventhub/armeventhub"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

func TestEventhubNamespaceModule(t *testing.T, ctx types.TestContext) {
	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}

	options := arm.ClientOptions{
		ClientOptions: azcore.ClientOptions{
			Cloud: cloud.AzurePublic,
		},
	}

	armEventhubNamespaceClient, err := armEventhub.NewNamespacesClient(subscriptionId, credential, &options)
	if err != nil {
		t.Fatalf("Error getting Eventhub namespace client: %v", err)
	}

	t.Run("doesEventhubNamespaceExist", func(t *testing.T) {
		resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
		eventhubNamespaceName := terraform.Output(t, ctx.TerratestTerraformOptions(), "eventhub_namespace_name")

		eventhubNamespace, err := armEventhubNamespaceClient.Get(context.Background(), resourceGroupName, eventhubNamespaceName, nil)
		if err != nil {
			t.Fatalf("Error getting eventhubNamespace: %v", err)
		}

		assert.Equal(t, eventhubNamespaceName, *eventhubNamespace.Name)
	})
}
