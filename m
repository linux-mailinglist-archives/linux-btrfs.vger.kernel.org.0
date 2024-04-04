Return-Path: <linux-btrfs+bounces-3926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87639898CE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 19:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB77FB22A1B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6218212C819;
	Thu,  4 Apr 2024 17:03:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579AF125B9;
	Thu,  4 Apr 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250228; cv=none; b=G/nmcgH7x+oX4ZlH9kLxojqeyHLy+Izat+AlqcfMSLcriGEA2bIl43FsJF1eI3bD6urVvJ6r4l3LwwwUtlb9i3i+TDANf6g0mgQOSqJ7TDHDT409B5TV9eXW92hin3HdRrEM9xIxjii9/RjhLtLN+ugnEv0FtzF8/eHFi8Sp8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250228; c=relaxed/simple;
	bh=Xnv2uiszBs0jiaq31td06gaclmE49Myad3VbfF45qDI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/ZUO84wCP3gyTv1EQyvFNG2pZxbdZlueH5zXDn9j1Xoqg2UDoY5VE4jiAp0OZUx+7QBp2eJmaaX32sD/C+GOXkiwwvFZFRaO3Vt069VV/Y6Q5T8l3Tv+RwgmmdYeeL0cGqA1JSTgZETEEVqqlHq1Yl388fs7tJUJXvrJztjUQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9SbH6klNz6J9fy;
	Fri,  5 Apr 2024 01:02:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9534E140A86;
	Fri,  5 Apr 2024 01:03:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 18:03:42 +0100
Date: Thu, 4 Apr 2024 18:03:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/26] cxl/mem: Handle DCD add & release capacity
 events.
Message-ID: <20240404180341.000011ec@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-18-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-18-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:21 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> A dynamic capacity devices (DCD) send events to signal the host about
> changes in the availability of Dynamic Capacity (DC) memory.  These
> events contain extents, the addition or removal of which may occur at
> any time.
> 
> Adding memory is straight forward.  If no region exists the extent is
> rejected.  If a region does exist, a region extent is formed and
> surfaced.
> 
> Removing memory requires checking if the memory is currently in use.
> Memory use tracking is added in a subsequent patch so here the memory is
> never in use and the removal occurs immediately.
> 
> Most often extents will be offered to and accepted by the host in well
> defined chunks.  However, part of an extent may be requested for
> release.  Simplify extent tracking by signaling removal of any extent
> which overlaps the requested release range.
> 
> Force removal is intended as a mechanism between the FM and the device
> and intended only when the host is unresponsive or otherwise broken.
> Purposely ignore force removal events.
> 
> Process DCD extents.
> 
> Recall that all devices of an interleave set must offer a corresponding
> extent for the region extent to be realized.  This patch limits
> interleave to 1.  Thus the 1:1 mapping between device extent and DAX
> region extent allows immediate surfacing.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

...

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 6b00e717e42b..7babac2d1c95 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -870,6 +870,37 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static int cxl_notify_dc_extent(struct cxl_memdev_state *mds,
> +				enum dc_event event,
> +				struct cxl_dc_extent *dc_extent)
> +{
> +	struct cxl_drv_nd nd = (struct cxl_drv_nd) {
> +		.event = event,
> +		.dc_extent = dc_extent
> +	};
> +	struct device *dev;
> +	int rc = -ENXIO;
> +
> +	dev = &mds->cxlds.cxlmd->dev;
> +	dev_dbg(dev, "Notify: type %d DPA:%#llx LEN:%#llx\n",
> +		event, le64_to_cpu(dc_extent->start_dpa),
> +		le64_to_cpu(dc_extent->length));
> +
> +	device_lock(dev);

	guard(device)(dev);
	if (!dev->driver)
		return -ENXIO;

	...


> +	if (dev->driver) {
> +		struct cxl_driver *mem_drv = to_cxl_drv(dev->driver);
> +
> +		if (mem_drv->notify) {
> +			dev_dbg(dev, "Notify driver type %d DPA:%#llx LEN:%#llx\n",
> +				event, le64_to_cpu(dc_extent->start_dpa),
> +				le64_to_cpu(dc_extent->length));
> +			rc = mem_drv->notify(dev, &nd);
> +		}
> +	}
> +	device_unlock(dev);
> +	return rc;
> +}


...

> +static int cxl_handle_dcd_add_event(struct cxl_memdev_state *mds,
> +				    struct cxl_dc_extent *dc_extent)
> +{
> +	struct range alloc_range, *resp_range;
> +	struct device *dev = mds->cxlds.dev;
> +	int rc;
> +
> +	alloc_range = (struct range){
> +		.start = le64_to_cpu(dc_extent->start_dpa),
> +		.end = le64_to_cpu(dc_extent->start_dpa) +
> +			le64_to_cpu(dc_extent->length) - 1,
> +	};
> +	resp_range = &alloc_range;
Code structure is a little odd to follow as sets up a bunch of stuff
that may or may not be used, perhaps duplicate final call.
I'm not 100% convinced it is worth it though.


	rc = cxl_notify_dc_extents(mds, DCD_ADD_CAPACITY, dc_extent);
	if (rc) {
		dev_dbg(dev, "unconsumed DC extent DPA:%#llx LEN:%#llx\n",
			le64_to_cpu(dc_extent->start_dpa),
			le64_to_cpu(dc_extent->length));
		return cxl_send_dc_cap_response(mds, NULL,
						CXL_MBOX_OP_ADD_DC_RESPONSE);
	}

	alloc_range = (struct range){
		.start = le64_to_cpu(dc_extent->start_dpa),
		.end = le64_to_cpu(dc_extent->start_dpa) +
			le64_to_cpu(dc_extent->length) - 1,
	};

	return cxl_send_dc_cap_response(mds, &alloc_range,
					CXL_MBOX_OP_ADD_DC_RESPONSE);


> +
> +	rc = cxl_notify_dc_extent(mds, DCD_ADD_CAPACITY, dc_extent);
> +	if (rc) {
> +		dev_dbg(dev, "unconsumed DC extent DPA:%#llx LEN:%#llx\n",
> +			le64_to_cpu(dc_extent->start_dpa),
> +			le64_to_cpu(dc_extent->length));
> +		resp_range = NULL;
> +	}
> +
> +	return cxl_send_dc_cap_response(mds, resp_range,
> +					CXL_MBOX_OP_ADD_DC_RESPONSE);
> +}

> +static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
> +					struct cxl_event_record_raw *raw_rec)
> +{
> +	struct cxl_event_dcd *event = &raw_rec->event.dcd;
> +	struct cxl_dc_extent *dc_extent = &event->extent;
> +	struct device *dev = mds->cxlds.dev;
> +	uuid_t *id = &raw_rec->id;
> +
> +	if (!uuid_equal(id, &CXL_EVENT_DC_EVENT_UUID))
> +		return -EINVAL;
> +
> +	dev_dbg(dev, "DCD event %s : DPA:%#llx LEN:%#llx\n",
> +		cxl_dcd_evt_type_str(event->event_type),
> +		le64_to_cpu(dc_extent->start_dpa),
> +		le64_to_cpu(dc_extent->length));
> +
> +	switch (event->event_type) {
> +	case DCD_ADD_CAPACITY:
> +		return cxl_handle_dcd_add_event(mds, dc_extent);
> +	case DCD_RELEASE_CAPACITY:
> +		return cxl_handle_dcd_release_event(mds, dc_extent);
> +	case DCD_FORCED_CAPACITY_RELEASE:
> +		dev_err_ratelimited(dev, "Forced release event ignored.\n");
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

dead code.

> +}
> +
>  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  				    enum cxl_event_log_type type)
>  {
> @@ -1109,9 +1225,17 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		if (!nr_rec)
>  			break;
>  
> -		for (i = 0; i < nr_rec; i++)
> +		for (i = 0; i < nr_rec; i++) {
>  			__cxl_event_trace_record(cxlmd, type,
>  						 &payload->records[i]);
> +			if (type == CXL_EVENT_TYPE_DCD) {

Perhaps flip condition so we can reduce indent.

			if (type != CXL_EVENT_TYPE_DCD)
				continue;
			rc = 
> +				rc = cxl_handle_dcd_event_records(mds,
> +								  &payload->records[i]);
> +				if (rc)
> +					dev_err_ratelimited(dev, "dcd event failed: %d\n",
> +							    rc);
> +			}
> +		}
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 7635ff109578..a07d95136f0d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1450,6 +1450,57 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> +int cxl_region_notify_extent(struct cxl_region *cxlr, enum dc_event event,
> +			     struct region_extent *reg_ext)
> +{
> +	struct cxl_dax_region *cxlr_dax;
> +	struct device *dev;
> +	int rc = -ENXIO;
> +
> +	cxlr_dax = cxlr->cxlr_dax;
> +	dev = &cxlr_dax->dev;
> +	dev_dbg(dev, "Trying notify: type %d HPA %#llx - %#llx\n",
> +		event, reg_ext->hpa_range.start, reg_ext->hpa_range.end);
> +
> +	device_lock(dev);

guard(device)(dev);
or scoped_guard() if you are adding things in later patches (I haven't checked yet)

> +	if (dev->driver) {
> +		struct cxl_driver *reg_drv = to_cxl_drv(dev->driver);
> +		struct cxl_drv_nd nd = (struct cxl_drv_nd) {
> +			.event = event,
> +			.reg_ext = reg_ext,
> +		};
> +
> +		if (reg_drv->notify) {
> +			dev_dbg(dev, "Notify: type %d HPA %#llx - %#llx\n",
> +				event, reg_ext->hpa_range.start,
> +				reg_ext->hpa_range.end);
> +			rc = reg_drv->notify(dev, &nd);
> +		}
> +	}
> +	device_unlock(dev);
> +	return rc;
> +}
> +
> +static void calc_hpa_range(struct cxl_endpoint_decoder *cxled,

I'd be tempted to drag this to earlier patch. 
Whilst it may look over the top there to have a separate function 
I think that is cleaner than introducing the code and then factoring
it out in a patch doing lots of stuff like this one.

> +			   struct cxl_dax_region *cxlr_dax,
> +			   struct cxl_dc_extent *dc_extent,
> +			   struct range *dpa_range,
> +			   struct range *hpa_range)
> +{
> +	resource_size_t dpa_offset, hpa;
> +
> +	/*
> +	 * Without interleave...
> +	 * HPA offset == DPA offset
> +	 * ... but do the math anyway
> +	 */
> +	dpa_offset = dpa_range->start - cxled->dpa_res->start;
> +	hpa = cxled->cxld.hpa_range.start + dpa_offset;
> +
> +	hpa_range->start = hpa - cxlr_dax->hpa_range.start;
> +	hpa_range->end = hpa_range->start + range_len(dpa_range) - 1;
> +}
> +
>  static int extent_check_overlap(struct device *dev, void *arg)
>  {
>  	struct range *new_range = arg;
> @@ -1480,7 +1531,6 @@ int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_region *cxlr = cxled->cxld.region;
>  	struct range ext_dpa_range, ext_hpa_range;
>  	struct device *dev = &cxlr->dev;
> -	resource_size_t dpa_offset, hpa;
>  
>  	/*
>  	 * Interleave ways == 1 means this coresponds to a 1:1 mapping between
> @@ -1502,18 +1552,7 @@ int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
>  	dev_dbg(dev, "Adding DC extent DPA %#llx - %#llx\n",
>  		ext_dpa_range.start, ext_dpa_range.end);
>  
> -	/*
> -	 * Without interleave...
> -	 * HPA offset == DPA offset
> -	 * ... but do the math anyway
> -	 */
> -	dpa_offset = ext_dpa_range.start - cxled->dpa_res->start;
> -	hpa = cxled->cxld.hpa_range.start + dpa_offset;
> -
> -	ext_hpa_range = (struct range) {
> -		.start = hpa - cxlr->cxlr_dax->hpa_range.start,
> -		.end = ext_hpa_range.start + range_len(&ext_dpa_range) - 1,
> -	};
> +	calc_hpa_range(cxled, cxlr->cxlr_dax, dc_extent, &ext_dpa_range, &ext_hpa_range);
>  
>  	if (extent_overlaps(cxlr->cxlr_dax, &ext_hpa_range))
>  		return -EINVAL;
> @@ -1527,6 +1566,80 @@ int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
>  				     cxled);
>  }

> +static int cxl_rm_reg_ext_by_range(struct device *dev, void *data)
> +{
> +	struct rm_data *rm_data = data;
> +	struct region_extent *reg_ext;
> +
> +	if (!is_region_extent(dev))
> +		return 0;
> +	reg_ext = to_region_extent(dev);
> +
> +	/*
> +	 * Any extent which 'touches' the released range is notified
> +	 * for removal.  No partials of the extent are released.
> +	 */
> +	if (range_overlaps(rm_data->range, &reg_ext->hpa_range)) {
> +		struct cxl_region *cxlr = rm_data->cxlr;
> +
> +		dev_dbg(dev, "Remove DAX region ext HPA %#llx - %#llx\n",
> +			reg_ext->hpa_range.start, reg_ext->hpa_range.end);
> +		cxl_ed_rm_region_extent(cxlr, reg_ext);

Is it worth improving efficiency if we have a precise match and returning 1
to stop iterating?  Perhaps premature optimization.

> +	}
> +	return 0;
> +}
> +
> +static int cxl_ed_rm_extent(struct cxl_endpoint_decoder *cxled,
> +			    struct cxl_dc_extent *dc_extent)
> +{
> +	struct cxl_region *cxlr = cxled->cxld.region;
> +	struct range hpa_range;
> +
> +	struct range rel_dpa_range = {
> +		.start = le64_to_cpu(dc_extent->start_dpa),
> +		.end = le64_to_cpu(dc_extent->start_dpa) +
> +			le64_to_cpu(dc_extent->length) - 1,
> +	};
> +
> +	calc_hpa_range(cxled, cxlr->cxlr_dax, dc_extent, &rel_dpa_range, &hpa_range);
> +
> +	struct rm_data rm_data = {
> +		.cxlr = cxlr,
> +		.range = &hpa_range,
> +	};
> +
> +	return device_for_each_child(&cxlr->cxlr_dax->dev, &rm_data,
> +				     cxl_rm_reg_ext_by_range);
> +}
> +

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5379ad7f5852..156d7c9a8de5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -10,6 +10,7 @@
>  #include <linux/log2.h>
>  #include <linux/node.h>
>  #include <linux/io.h>
> +#include <linux/cxl-event.h>
>  
>  /**
>   * DOC: cxl objects
> @@ -613,6 +614,14 @@ struct cxl_pmem_region {
>  	struct cxl_pmem_region_mapping mapping[];
>  };
>  
> +/* See CXL 3.0 8.2.9.2.1.5 */

Add a name for the section to help searching future spec

> +enum dc_event {
> +	DCD_ADD_CAPACITY,
> +	DCD_RELEASE_CAPACITY,
> +	DCD_FORCED_CAPACITY_RELEASE,
> +	DCD_REGION_CONFIGURATION_UPDATED,
> +};

> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 0c79d9ce877c..20832f09c40c 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -103,6 +103,50 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_debugfs_poison_clear, "%llx\n");
>  

> +static int cxl_mem_notify(struct device *dev, struct cxl_drv_nd *nd)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_dc_extent *dc_extent;
> +	struct device *ep_dev;
> +	int rc;
> +
> +	dc_extent = nd->dc_extent;
> +	dev_dbg(dev, "notify DC action %d DPA:%#llx LEN:%#llx\n",
> +		nd->event, le64_to_cpu(dc_extent->start_dpa),
> +		le64_to_cpu(dc_extent->length));
> +
> +	ep_dev = device_find_child(&endpoint->dev, dc_extent,

Can use __free(put_device) magic here to deal with the trailing put device.
Minor tidy up, but nice to avoid the rc = / put / return rc dance

> +				   match_ep_decoder_by_range);
> +	if (!ep_dev) {
> +		dev_dbg(dev, "Extent DPA:%#llx LEN:%#llx not mapped; evt %d\n",
> +			le64_to_cpu(dc_extent->start_dpa),
> +			le64_to_cpu(dc_extent->length), nd->event);
> +		return -ENXIO;
> +	}
> +
> +	cxled = to_cxl_endpoint_decoder(ep_dev);
> +	rc = cxl_ed_notify_extent(cxled, nd);
> +	put_device(ep_dev);
> +	return rc;
> +}


> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 03fa6d50d46f..6b745c913f96 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -91,11 +91,42 @@ struct cxl_event_mem_module {
>  	u8 reserved[0x3d];
>  } __packed;
>  
> +/*
> + * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-51

Carries forward from earlier. Throw a table heading
in there for easy of searching future specs.

> + */
> +#define CXL_DC_EXTENT_TAG_LEN 0x10
> +struct cxl_dc_extent {
> +	__le64 start_dpa;
> +	__le64 length;
> +	u8 tag[CXL_DC_EXTENT_TAG_LEN];
> +	__le16 shared_extn_seq;
> +	u8 reserved[0x6];
> +} __packed;
> +
> +/*
> + * Dynamic Capacity Event Record
> + * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-50
> + */
> +struct cxl_event_dcd {
> +	struct cxl_event_record_hdr hdr;
> +	u8 event_type;
> +	u8 validity_flags;
> +	__le16 host_id;

Could perhaps add a comment that this field isn't ever set for host.
It's there for FM event records when the host has sent the device
an Add capacity response or Capacity is released.

> +	u8 region_index;
> +	u8 flags;
> +	u8 reserved1[0x2];
> +	struct cxl_dc_extent extent;
> +	u8 reserved2[0x18];
> +	__le32 num_avail_extents;
> +	__le32 num_avail_tags;
> +} __packed;
> +
>  union cxl_event {
>  	struct cxl_event_generic generic;
>  	struct cxl_event_gen_media gen_media;
>  	struct cxl_event_dram dram;
>  	struct cxl_event_mem_module mem_module;
> +	struct cxl_event_dcd dcd;
>  } __packed;
>  
>  /*
> 


