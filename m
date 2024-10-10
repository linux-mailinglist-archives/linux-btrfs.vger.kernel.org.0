Return-Path: <linux-btrfs+bounces-8795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06127998C7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9483B31EA7
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403341E32A6;
	Thu, 10 Oct 2024 14:58:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951971CC890;
	Thu, 10 Oct 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572308; cv=none; b=YfHLho6xsESofzxblCS7gFWTwX+ey0hMyr6Ka04uMDrwwE4H91bWSciie+g0nm/JS/PSy74TjQMQRQQgf7eGRSQtq+8R/cjpGFzBb8j9OWIGzZzJngcM0gy512aLMiPdoogvegTZKGGCIQJqQbUpbIDpd8d/ed384nRB7CHVUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572308; c=relaxed/simple;
	bh=6hJI0MRVsBlMGi7Ta6d9H6idg6lpjewWYMhoGxoBzy0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPipcx6ICTvk20Et/errkM5Q2kHBrne/yceiwL/DY4T1ZbpQDtqx/+rED1lQtLOXeya7aCbjubvgsc4h3Xbl/KNJEKCdx7gt4xRVKyIRxrZ440piZAf5D8dba+AaODc3k+C7rJBN/ZCDsxiguOkdV2WKABJMOaYAQGIlSC4qgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPXtf3qCJz6HJy2;
	Thu, 10 Oct 2024 22:58:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 54D37140A36;
	Thu, 10 Oct 2024 22:58:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 16:58:22 +0200
Date: Thu, 10 Oct 2024 15:58:21 +0100
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
Subject: Re: [PATCH v4 21/28] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <20241010155821.00005079@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 07 Oct 2024 18:16:27 -0500
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

True today - I think that would be an error for shared extents
though as they need to be released in one go.  We can deal with
that when it matters.  


Mind you patch seems to try to handle more bit anyway, so maybe just
remove that discussion from this description?
> 
> Simplify extent tracking with the following restrictions.
> 
> 	1) Flag for removal any extent which overlaps a requested
> 	   release range.
> 	2) Refuse the offer of extents which overlap already accepted
> 	   memory ranges.
> 	3) Accept again a range which has already been accepted by the
> 	   host.  Eating duplicates serves three purposes.  First, this
> 	   simplifies the code if the device should get out of sync with
> 	   the host. 

Maybe scream about this a little.  AFAIK that happening is a device
bug.

> And it should be safe to acknowledge the extent
> 	   again.  Second, this simplifies the code to process existing
> 	   extents if the extent list should change while the extent
> 	   list is being read.  Third, duplicates for a given region
> 	   which are seen during a race between the hardware surfacing
> 	   an extent and the cxl dax driver scanning for existing
> 	   extents will be ignored.

This last one is a good justification.

> 
> 	   NOTE: Processing existing extents is done in a later patch.
> 
> Management of the region extent devices must be synchronized with
> potential uses of the memory within the DAX layer.  Create region extent
> devices as children of the cxl_dax_region device such that the DAX
> region driver can co-drive them and synchronize with the DAX layer.
> Synchronization and management is handled in a subsequent patch.
> 
> Tag support within the DAX layer is not yet supported.  To maintain
> compatibility legacy DAX/region processing only tags with a value of 0
> are allowed.  This defines existing DAX devices as having a 0 tag which
> makes the most logical sense as a default.
> 
> Process DCD events and create region devices.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
A couple of minor comments from me.

J
> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> new file mode 100644
> index 000000000000..69a7614ba6a9
> --- /dev/null
> +++ b/drivers/cxl/core/extent.c


> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 584d7d282a97..d66beec687a0 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -889,6 +889,58 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)


> @@ -1017,6 +1069,223 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> +				struct xarray *extent_array, int cnt)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_dc_response *p;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_extent *extent;
> +	unsigned long index;
> +	u32 pl_index;
> +	int rc;
> +
> +	size_t pl_size = struct_size(p, extent_list, cnt);
> +	u32 max_extents = cnt;
> +
> +	/* May have to use more bit on response. */

I thought you argued in the patch description that it didn't matter if you
didn't set it?

> +	if (pl_size > cxl_mbox->payload_size) {
> +		max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
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
Covered in other branch of thread.

> +
> +			rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +			if (rc)
> +				return rc;
> +			pl_index = 0;
> +		}
> +	}
> +
> +	if (cnt == 0 || pl_index) {
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = opcode,
> +			.size_in = struct_size(response, extent_list,
> +					       pl_index),
> +			.payload_in = response,
> +		};
> +
> +		response->flags = 0;
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}




> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cbaacbe0f36d..b75653e9bc32 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h


>  
> +/* See CXL 3.0 8.2.9.2.1.5 */

Maybe update to 3.1? Otherwise patch reviewer needs to open two 
spec versions!  In 3.1 it is 8.2.9.2.1.6

> +enum dc_event {
> +	DCD_ADD_CAPACITY,
> +	DCD_RELEASE_CAPACITY,
> +	DCD_FORCED_CAPACITY_RELEASE,
> +	DCD_REGION_CONFIGURATION_UPDATED,
> +};


