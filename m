Return-Path: <linux-btrfs+bounces-7558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF4A960BB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 15:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2351F23C6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EED1BF801;
	Tue, 27 Aug 2024 13:19:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6241BF32A;
	Tue, 27 Aug 2024 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764739; cv=none; b=POlfDnby+pKzomO0vrjl6R0c2a4OvKvXt+FU8u5fh4gZFz5Z9m0Tsg1E2Pd73lS5M3RUol5ZRQsZc/jA++7GR81q45gCjyorTx2Bd74RAE5097cWlGO84t3hVaB7dQFVQKfEeByoBVuEpW6JVEX2NSTlv9/NW/RdjQgoklgbuUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764739; c=relaxed/simple;
	bh=6HkxQyo7TZr0Ov/YK5iQWUsXYKK/8aSoZUiuSVY9VX8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFoajkWjBRceyb2EjwtQCePTzjBhfQqVzeE3Iift2XbCaqyv0osQcGhI9msUX4Kr8MFmb/9U4oG7xUvT1TP1TxiHJwfIuGl6K/utT6u1dktKRvNt9m2Ys1af05SyQJD0oz5IjcY4PuMae2cQIZJeh5mSJBpfa05pViB1pAanZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtShp1vsNz6K9C0;
	Tue, 27 Aug 2024 21:15:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AE332140A71;
	Tue, 27 Aug 2024 21:18:53 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 14:18:53 +0100
Date: Tue, 27 Aug 2024 14:18:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 18/25] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <20240827141852.0000553d@Huawei.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-18-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-18-7c9b96cba6d7@intel.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 16 Aug 2024 09:44:26 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> A dynamic capacity device (DCD) sends events to signal the host for
> changes in the availability of Dynamic Capacity (DC) memory.  These
> events contain extents describing a DPA range and meta data for memory
> to be added or removed.  Events may be sent from the device at any time.
> 
> Three types of events can be signaled, Add, Release, and Force Release.
> 
> On add, the host may accept or reject the memory being offered.  If no
> region exists, or the extent is invalid, the extent should be rejected.
> Add extent events may be grouped by a 'more' bit which indicates those
> extents should be processed as a group.
> 
> On remove, the host can delay the response until the host is safely not
> using the memory.  If no region exists the release can be sent
> immediately.  The host may also release extents (or partial extents) at
> any time.  Thus the 'more' bit grouping of release events is of less
> value and can be ignored in favor of sending multiple release capacity
> responses for groups of release events.
> 
> Force removal is intended as a mechanism between the FM and the device
> and intended only when the host is unresponsive, out of sync, or
> otherwise broken.  Purposely ignore force removal events.
> 
> Regions are made up of one or more devices which may be surfacing memory
> to the host.  Once all devices in a region have surfaced an extent the
> region can expose a corresponding extent for the user to consume.
> Without interleaving a device extent forms a 1:1 relationship with the
> region extent.  Immediately surface a region extent upon getting a
> device extent.
> 
> Per the specification the device is allowed to offer or remove extents
> at any time.  However, anticipated use cases can expect extents to be
> offered, accepted, and removed in well defined chunks.
> 
> Simplify extent tracking with the following restrictions.
> 
> 	1) Flag for removal any extent which overlaps a requested
> 	   release range.
> 	2) Refuse the offer of extents which overlap already accepted
> 	   memory ranges.
> 	3) Accept again a range which has already been accepted by the
> 	   host.  (It is likely the device has an error because it
> 	   should already know that this range was accepted.  But from
> 	   the host point of view it is safe to acknowledge that
> 	   acceptance again.)
> 
> Management of the region extent devices must be synchronized with
> potential uses of the memory within the DAX layer.  Create region extent
> devices as children of the cxl_dax_region device such that the DAX
> region driver can co-drive them and synchronize with the DAX layer.
> Synchronization and management is handled in a subsequent patch.
> 
> Process DCD events and create region devices.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

A few minor bits and pieces inline.

Jonathan

> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> new file mode 100644
> index 000000000000..34456594cdc3
> --- /dev/null
> +++ b/drivers/cxl/core/extent.c



> +static int match_contains(struct device *dev, void *data)
> +{
> +	struct region_extent *region_extent = to_region_extent(dev);
> +	struct match_data *md = data;
> +	struct cxled_extent *entry;
> +	unsigned long index;
> +
> +	if (!region_extent)
> +		return 0;
> +
> +	xa_for_each(&region_extent->decoder_extents, index, entry) {
> +		if (md->cxled == entry->cxled &&
> +		    range_contains(&entry->dpa_range, md->new_range))
> +			return true;
As below, this returns int, so shouldn't be true or false.

> +	}
> +	return false;
> +}

> +static int match_overlaps(struct device *dev, void *data)
> +{
> +	struct region_extent *region_extent = to_region_extent(dev);
> +	struct match_data *md = data;
> +	struct cxled_extent *entry;
> +	unsigned long index;
> +
> +	if (!region_extent)
> +		return 0;
> +
> +	xa_for_each(&region_extent->decoder_extents, index, entry) {
> +		if (md->cxled == entry->cxled &&
> +		    range_overlaps(&entry->dpa_range, md->new_range))
> +			return true;

returns int, so returning true or false is odd.

> +	}
> +
> +	return false;
> +}


> +int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> +{
> +	u64 start_dpa = le64_to_cpu(extent->start_dpa);
> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct range hpa_range, dpa_range;
> +	struct cxl_region *cxlr;
> +
> +	dpa_range = (struct range) {
> +		.start = start_dpa,
> +		.end = start_dpa + le64_to_cpu(extent->length) - 1,
> +	};
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
> +	if (!cxlr) {
> +		memdev_release_extent(mds, &dpa_range);

How does this condition happen?  Perhaps a comment needed.

> +		return -ENXIO;
> +	}
> +
> +	calc_hpa_range(cxled, cxlr->cxlr_dax, &dpa_range, &hpa_range);
> +
> +	/* Remove region extents which overlap */
> +	return device_for_each_child(&cxlr->cxlr_dax->dev, &hpa_range,
> +				     cxlr_rm_extent);
> +}
> +
> +static int cxlr_add_extent(struct cxl_dax_region *cxlr_dax,
> +			   struct cxl_endpoint_decoder *cxled,
> +			   struct cxled_extent *ed_extent)
> +{
> +	struct region_extent *region_extent;
> +	struct range hpa_range;
> +	int rc;
> +
> +	calc_hpa_range(cxled, cxlr_dax, &ed_extent->dpa_range, &hpa_range);
> +
> +	region_extent = alloc_region_extent(cxlr_dax, &hpa_range, ed_extent->tag);
> +	if (IS_ERR(region_extent))
> +		return PTR_ERR(region_extent);
> +
> +	rc = xa_insert(&region_extent->decoder_extents, (unsigned long)ed_extent, ed_extent,

I'd wrap that earlier to keep the line a bit shorter.

> +		       GFP_KERNEL);
> +	if (rc) {
> +		free_region_extent(region_extent);
> +		return rc;
> +	}
> +
> +	/* device model handles freeing region_extent */
> +	return online_region_extent(region_extent);
> +}
> +
> +/* Callers are expected to ensure cxled has been attached to a region */
> +int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> +{
> +	u64 start_dpa = le64_to_cpu(extent->start_dpa);
> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct range ed_range, ext_range;
> +	struct cxl_dax_region *cxlr_dax;
> +	struct cxled_extent *ed_extent;
> +	struct cxl_region *cxlr;
> +	struct device *dev;
> +
> +	ext_range = (struct range) {
> +		.start = start_dpa,
> +		.end = start_dpa + le64_to_cpu(extent->length) - 1,
> +	};
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
> +	if (!cxlr)
> +		return -ENXIO;
> +
> +	cxlr_dax = cxled->cxld.region->cxlr_dax;
> +	dev = &cxled->cxld.dev;
> +	ed_range = (struct range) {
> +		.start = cxled->dpa_res->start,
> +		.end = cxled->dpa_res->end,
> +	};
> +
> +	dev_dbg(&cxled->cxld.dev, "Checking ED (%pr) for extent %par\n",
> +		cxled->dpa_res, &ext_range);
> +
> +	if (!range_contains(&ed_range, &ext_range)) {
> +		dev_err_ratelimited(dev,
> +				    "DC extent DPA %par (%*phC) is not fully in ED %par\n",
> +				    &ext_range.start, CXL_EXTENT_TAG_LEN,
> +				    extent->tag, &ed_range);
> +		return -ENXIO;
> +	}
> +
> +	if (extents_contain(cxlr_dax, cxled, &ext_range))

This case confuses me. If the extents are already there I think we should
error out or at least print something as that's very wrong.

> +		return 0;
> +
> +	if (extents_overlap(cxlr_dax, cxled, &ext_range))
> +		return -ENXIO;
> +
> +	ed_extent = kzalloc(sizeof(*ed_extent), GFP_KERNEL);
> +	if (!ed_extent)
> +		return -ENOMEM;
> +
> +	ed_extent->cxled = cxled;
> +	ed_extent->dpa_range = ext_range;
> +	memcpy(ed_extent->tag, extent->tag, CXL_EXTENT_TAG_LEN);
> +
> +	dev_dbg(dev, "Add extent %par (%*phC)\n", &ed_extent->dpa_range,
> +		CXL_EXTENT_TAG_LEN, ed_extent->tag);
> +
> +	return cxlr_add_extent(cxlr_dax, cxled, ed_extent);
> +}
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 01a447aaa1b1..f629ad7488ac 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -882,6 +882,48 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static int cxl_validate_extent(struct cxl_memdev_state *mds,
> +			       struct cxl_extent *extent)
> +{
> +	u64 start = le64_to_cpu(extent->start_dpa);
> +	u64 length = le64_to_cpu(extent->length);
> +	struct device *dev = mds->cxlds.dev;
> +
> +	struct range ext_range = (struct range){
> +		.start = start,
> +		.end = start + length - 1,
> +	};
> +
> +	if (le16_to_cpu(extent->shared_extn_seq) != 0) {

That's not the 'main' way to tell if an extent is shared because
we could have a single extent (so seq == 0).
Should verify it's not in a DCD region that
is shareable to make this decision.

I've lost track on the region handling so maybe you already do
this by not including those regions at all?

> +		dev_err_ratelimited(dev,
> +				    "DC extent DPA %par (%*phC) can not be shared\n",
> +				    &ext_range.start, CXL_EXTENT_TAG_LEN,
> +				    extent->tag);
> +		return -ENXIO;
> +	}
> +
> +	/* Extents must not cross DC region boundary's */
> +	for (int i = 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +		struct range region_range = (struct range) {
> +			.start = dcr->base,
> +			.end = dcr->base + dcr->decode_len - 1,
> +		};
> +
> +		if (range_contains(&region_range, &ext_range)) {
> +			dev_dbg(dev, "DC extent DPA %par (DCR:%d:%#llx)(%*phC)\n",
> +				&ext_range, i, start - dcr->base,
> +				CXL_EXTENT_TAG_LEN, extent->tag);
> +			return 0;
> +		}
> +	}
> +
> +	dev_err_ratelimited(dev,
> +			    "DC extent DPA %par (%*phC) is not in any DC region\n",
> +			    &ext_range, CXL_EXTENT_TAG_LEN, extent->tag);
> +	return -ENXIO;
> +}
> +
>  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
> @@ -1009,6 +1051,207 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> +				struct xarray *extent_array, int cnt)
> +{
> +	struct cxl_mbox_dc_response *p;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_extent *extent;
> +	unsigned long index;
> +	u32 pl_index;
> +	int rc = 0;
> +
> +	size_t pl_size = struct_size(p, extent_list, cnt);
> +	u32 max_extents = cnt;
> +
What is cnt is zero? All extents rejected so none in the
extent_array. Need to send a zero extent response to reject
them all IIRC.

> +	/* May have to use more bit on response. */
> +	if (pl_size > mds->payload_size) {
> +		max_extents = (mds->payload_size - sizeof(*p)) /
> +			      sizeof(struct updated_extent_list);
> +		pl_size = struct_size(p, extent_list, max_extents);
> +	}
> +
> +	struct cxl_mbox_dc_response *response __free(kfree) =
> +						kzalloc(pl_size, GFP_KERNEL);
> +	if (!response)
> +		return -ENOMEM;
> +
> +	pl_index = 0;
> +	xa_for_each(extent_array, index, extent) {
> +
> +		response->extent_list[pl_index].dpa_start = extent->start_dpa;
> +		response->extent_list[pl_index].length = extent->length;
> +		pl_index++;
> +		response->extent_list_size = cpu_to_le32(pl_index);
> +
> +		if (pl_index == max_extents) {
> +			mbox_cmd = (struct cxl_mbox_cmd) {
> +				.opcode = opcode,
> +				.size_in = struct_size(response, extent_list,
> +						       pl_index),
> +				.payload_in = response,
> +			};
> +
> +			response->flags = 0;
> +			if (pl_index < cnt)
> +				response->flags &= CXL_DCD_EVENT_MORE;
> +
> +			rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +			if (rc)
> +				return rc;
> +			pl_index = 0;
> +		}
> +	}
> +
> +	if (pl_index) {
|| !cnt 

I think so we send a nothing accepted message.

> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = opcode,
> +			.size_in = struct_size(response, extent_list,
> +					       pl_index),
> +			.payload_in = response,
> +		};
> +
> +		response->flags = 0;
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
		if (rc)
			return rc;
> +	}
> +

return 0;  So that reader doesn't have to check what rc was in !pl_index
case and avoids assigning rc right at the top.


> +	return rc;
> +}


> +static int cxl_add_pending(struct cxl_memdev_state *mds)
> +{
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_extent *extent;
> +	unsigned long index;
> +	unsigned long cnt = 0;
> +	int rc;
> +
> +	xa_for_each(&mds->pending_extents, index, extent) {
> +		if (validate_add_extent(mds, extent)) {


Add a comment here that not accepting an extent but
accepting some or none means this one was rejected (I'd forgotten how
that bit worked)

> +			dev_dbg(dev, "unconsumed DC extent DPA:%#llx LEN:%#llx\n",
> +				le64_to_cpu(extent->start_dpa),
> +				le64_to_cpu(extent->length));
> +			xa_erase(&mds->pending_extents, index);
> +			kfree(extent);
> +			continue;
> +		}
> +		cnt++;
> +	}
> +	rc = cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
> +				  &mds->pending_extents, cnt);
> +	xa_for_each(&mds->pending_extents, index, extent) {
> +		xa_erase(&mds->pending_extents, index);
> +		kfree(extent);
> +	}
> +	return rc;
> +}
> +
> +static int handle_add_event(struct cxl_memdev_state *mds,
> +			    struct cxl_event_dcd *event)
> +{
> +	struct cxl_extent *tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
> +	struct device *dev = mds->cxlds.dev;
> +
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	memcpy(tmp, &event->extent, sizeof(*tmp));

kmemdup?

> +	if (xa_insert(&mds->pending_extents, (unsigned long)tmp, tmp,
> +		      GFP_KERNEL)) {
> +		kfree(tmp);
> +		return -ENOMEM;
> +	}
> +
> +	if (event->flags & CXL_DCD_EVENT_MORE) {
> +		dev_dbg(dev, "more bit set; delay the surfacing of extent\n");
> +		return 0;
> +	}
> +
> +	/* extents are removed and free'ed in cxl_add_pending() */
> +	return cxl_add_pending(mds);
> +}

>  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  				    enum cxl_event_log_type type)
>  {
> @@ -1044,9 +1287,17 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		if (!nr_rec)
>  			break;
>  
> -		for (i = 0; i < nr_rec; i++)
> +		for (i = 0; i < nr_rec; i++) {
>  			__cxl_event_trace_record(cxlmd, type,
>  						 &payload->records[i]);
> +			if (type == CXL_EVENT_TYPE_DCD) {
Bit of a deep indent so maybe flip logic?

Logic wise it's a bit dubious as we might want to match other
types in future though so up to you.

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

>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  {
>  	struct cxl_memdev_state *mds;
> @@ -1628,6 +1892,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>  	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
> +	xa_init(&mds->pending_extents);
> +	devm_add_action_or_reset(dev, clear_pending_extents, mds);

Why don't you need to check if this failed? Definitely seems unlikely
to leave things in a good state. Unlikely to fail of course, but you never know.

>  
>  	return mds;
>  }

> @@ -3090,6 +3091,8 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>  
>  	dev = &cxlr_dax->dev;
>  	cxlr_dax->cxlr = cxlr;
> +	cxlr->cxlr_dax = cxlr_dax;
> +	ida_init(&cxlr_dax->extent_ida);
>  	device_initialize(dev);
>  	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
>  	device_set_pm_not_required(dev);
> @@ -3190,7 +3193,10 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  static void cxlr_dax_unregister(void *_cxlr_dax)
>  {
>  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> +	struct cxl_region *cxlr = cxlr_dax->cxlr;
>  
> +	cxlr->cxlr_dax = NULL;
> +	cxlr_dax->cxlr = NULL;

cxlr_dax->cxlr was assigned before this patch. 

I'm not seeing any new checks on these being non null so why
are the needed?  If there is a good reason for this then
a comment would be useful.

>  	device_unregister(&cxlr_dax->dev);
>  }
>  



