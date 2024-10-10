Return-Path: <linux-btrfs+bounces-8802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218F0998B8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5461F290C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3A31CC8B2;
	Thu, 10 Oct 2024 15:27:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A06A1CC179;
	Thu, 10 Oct 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574072; cv=none; b=WCGJ3iZaH/Bf3Tg6267ywHcoMwA0HzChz7zTac3k/cKqBBJEGTdjTM8pPkQUsu9w5H+zHQN8gpk7QmOrC7tkmGYqlo3iOUCD7VD6unx4Zm+o+FJt+LBBXa57wPWsUwP/SQjIMsSCvgkRebiJ/DU6UNe0mfD+Vza3I540gWIRx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574072; c=relaxed/simple;
	bh=SNVe+TdvAayhuxSjhFCoU0u7zIY9O6cAdSoJx16is/E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnPIE2Y7gpfBVdJHRlW22SFwwwHLiJAatoQTRa0zUw+otCE3LBj7pmBa29TnmYucxEUHdi6ZtGD3VenkRsv9UpwsUDekgDcZqGYNX/eVic+oFCfrydJGKifjSWSpxsk04eKplXcHdSceLp5Ted/tAk8TxG1EituoH/pYxqYhV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPYRy2q5Jz6J7sj;
	Thu, 10 Oct 2024 23:23:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 510E4140A78;
	Thu, 10 Oct 2024 23:27:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 17:27:46 +0200
Date: Thu, 10 Oct 2024 16:27:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 24/28] dax/region: Create resources on sparse DAX
 regions
Message-ID: <20241010162745.00007b31@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-24-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-24-c261ee6eeded@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 07 Oct 2024 18:16:30 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> DAX regions which map dynamic capacity partitions require that memory be
> allowed to come and go.  Recall sparse regions were created for this
> purpose.  Now that extents can be realized within DAX regions the DAX
> region driver can start tracking sub-resource information.
> 
> The tight relationship between DAX region operations and extent
> operations require memory changes to be controlled synchronously with
> the user of the region.  Synchronize through the dax_region_rwsem and by
> having the region driver drive both the region device as well as the
> extent sub-devices.
> 
> Recall requests to remove extents can happen at any time and that a host
> is not obligated to release the memory until it is not being used.  If
> an extent is not used allow a release response.
> 
> The DAX layer has no need for the details of the CXL memory extent
> devices.  Expose extents to the DAX layer as device children of the DAX
> region device.  A single callback from the driver aids the DAX layer to
> determine if the child device is an extent.  The DAX layer also
> registers a devres function to automatically clean up when the device is
> removed from the region.
> 
> There is a race between extents being surfaced and the dax_cxl driver
> being loaded.  The driver must therefore scan for any existing extents
> while still under the device lock.
> 
> Respond to extent notifications.  Manage the DAX region resource tree
> based on the extents lifetime.  Return the status of remove
> notifications to lower layers such that it can manage the hardware
> appropriately.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
More somewhat superficial review from me.
Needs DAX expert reviewers.

Jonathan

> ---
>  drivers/cxl/core/extent.c |  74 ++++++++++++--
>  drivers/cxl/cxl.h         |   6 ++
>  drivers/dax/bus.c         | 243 +++++++++++++++++++++++++++++++++++++++++-----
>  drivers/dax/bus.h         |   3 +-
>  drivers/dax/cxl.c         |  62 +++++++++++-
>  drivers/dax/dax-private.h |  42 ++++++++
>  drivers/dax/hmem/hmem.c   |   2 +-
>  drivers/dax/pmem.c        |   2 +-
>  8 files changed, 396 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> index a1eb6e8e4f1a..75fb73ce2185 100644
> --- a/drivers/cxl/core/extent.c
> +++ b/drivers/cxl/core/extent.c
> @@ -270,20 +270,65 @@ static void calc_hpa_range(struct cxl_endpoint_decoder *cxled,
>  	hpa_range->end = hpa_range->start + range_len(dpa_range) - 1;
>  }
>  
> +static int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
> +			      struct region_extent *region_extent)
> +{
> +	struct device *dev = &cxlr->cxlr_dax->dev;
> +	struct cxl_notify_data notify_data;
> +	struct cxl_driver *driver;
> +
> +	dev_dbg(dev, "Trying notify: type %d HPA %pra\n",
> +		event, &region_extent->hpa_range);
> +
> +	guard(device)(dev);
> +
> +	/*
> +	 * The lack of a driver indicates a notification has failed.  No user
> +	 * space coordiantion was possible.
spell check.
coordination

> +	 */
> +	if (!dev->driver)
> +		return 0;
> +	driver = to_cxl_drv(dev->driver);
> +	if (!driver->notify)
> +		return 0;
> +
> +	notify_data = (struct cxl_notify_data) {
> +		.event = event,
> +		.region_extent = region_extent,
> +	};
> +
> +	dev_dbg(dev, "Notify: type %d HPA %pra\n",
> +		event, &region_extent->hpa_range);
> +	return driver->notify(dev, &notify_data);
> +}

> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index f0e3f8c787df..4e19d18369de 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -183,6 +183,86 @@ static bool is_sparse(struct dax_region *dax_region)
>  	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
>  }

> +
> +int dax_region_add_resource(struct dax_region *dax_region,
> +			    struct device *device,
> +			    resource_size_t start, resource_size_t length)
> +{
> +	struct resource *new_resource;
> +	int rc;
> +
> +	struct dax_resource *dax_resource __free(kfree) =
> +				kzalloc(sizeof(*dax_resource), GFP_KERNEL);
> +	if (!dax_resource)
> +		return -ENOMEM;
> +
> +	guard(rwsem_write)(&dax_region_rwsem);
> +
> +	dev_dbg(dax_region->dev, "DAX region resource %pr\n", &dax_region->res);
> +	new_resource = __request_region(&dax_region->res, start, length, "extent", 0);
> +	if (!new_resource) {
> +		dev_err(dax_region->dev, "Failed to add region s:%pa l:%pa\n",
> +			&start, &length);
> +		return -ENOSPC;
> +	}
> +
> +	dev_dbg(dax_region->dev, "add resource %pr\n", new_resource);
> +	dax_resource->region = dax_region;
> +	dax_resource->res = new_resource;
> +	dev_set_drvdata(device, dax_resource);
> +	rc = devm_add_action_or_reset(device, dax_release_resource,
> +				      no_free_ptr(dax_resource));
> +	/*  On error; ensure driver data is cleared under semaphore */

It's not used in the dax_release_resource callback (that I can
immediately spot) so could you just not set it until after
this has succeeded?

> +	if (rc)
> +		dev_set_drvdata(device, NULL);
i.e. move
	dev_set_drvdata(device, dax_resource);
to here.

> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(dax_region_add_resource);
Adding quite a few exports. Is it time to namespace DAX exports?
Perhaps a follow up series.



>  bool static_dev_dax(struct dev_dax *dev_dax)
>  {
>  	return is_static(dev_dax->region);
> @@ -296,19 +376,44 @@ static ssize_t region_align_show(struct device *dev,
>  static struct device_attribute dev_attr_region_align =
>  		__ATTR(align, 0400, region_align_show, NULL);
>  
> +#define for_each_child_resource(extent, res) \
> +	for (res = (extent)->child; res; res = res->sibling)
> +
Extent naming in here is a little off for a general sounding macro.
Maybe for_each_child_resource(parent, res) or something like that?

Seem generally useful. Maybe move to resource.h?

> @@ -1494,8 +1679,14 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
>  	device_initialize(dev);
>  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
>  
> +	if (is_sparse(dax_region) && data->size) {
> +		dev_err(parent, "Sparse DAX region devices must be created initially with 0 size");
> +		rc = -EINVAL;
> +		goto err_id;

Right label?  This code doesn't have side effects and the next error path is goto err_range
Looks like you fail to reverse the alloc_dev_dax_id() in this error path.

> +	}
> +
>  	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
> -				 data->size);
> +				 data->size, NULL);
>  	if (rc)
>  		goto err_range;
>  
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index 783bfeef42cc..ae5029ea6047 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -9,6 +9,7 @@ struct dev_dax;
>  struct resource;
>  struct dax_device;
>  struct dax_region;
> +struct dax_sparse_ops;
>  
>  /* dax bus specific ioresource flags */
>  #define IORESOURCE_DAX_STATIC BIT(0)
> @@ -17,7 +18,7 @@ struct dax_region;
>  
>  struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>  		struct range *range, int target_node, unsigned int align,
> -		unsigned long flags);
> +		unsigned long flags, struct dax_sparse_ops *sparse_ops);
>  
>  struct dev_dax_data {
>  	struct dax_region *dax_region;
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 367e86b1c22a..df979ea2cb59 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -5,6 +5,58 @@
>  
>  #include "../cxl/cxl.h"
>  #include "bus.h"
> +#include "dax-private.h"
> +
> +static int __cxl_dax_add_resource(struct dax_region *dax_region,
> +				  struct region_extent *region_extent)
> +{
> +	resource_size_t start, length;
> +	struct device *dev;
> +
> +	dev = &region_extent->dev;
Might as well do
	struct device *dev = &region_extent->dev;


> +	start = dax_region->res.start + region_extent->hpa_range.start;
> +	length = range_len(&region_extent->hpa_range);
> +	return dax_region_add_resource(dax_region, dev, start, length);
> +}


> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index ccde98c3d4e2..e3866115243e 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
...

> +/*
> + * Similar to run_dax() dax_region_{add,rm}_resource() and dax_avail_size() are
> + * exported but are not intended to be generic operations outside the dax
> + * subsystem.  They are only generic between the dax layer and the dax drivers.
> + */
> +int dax_region_add_resource(struct dax_region *dax_region, struct device *dev,
> +			    resource_size_t start, resource_size_t length);
> +int dax_region_rm_resource(struct dax_region *dax_region,
> +			   struct device *dev);
> +resource_size_t dax_avail_size(struct resource *dax_resource);
> +
> +typedef int (*match_cb)(struct device *dev, resource_size_t *size_avail);
Why is this here?


