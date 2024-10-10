Return-Path: <linux-btrfs+bounces-8781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52648998667
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 14:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6281F24151
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 12:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05241C7B62;
	Thu, 10 Oct 2024 12:45:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505D1C579A;
	Thu, 10 Oct 2024 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564341; cv=none; b=rCu0jMeDdFLbmu6gjzriGM5B1p4IUqBy1/RI0aVDqB27N0NBH/DTXOrfQwOvekVgBEUDLkUv2rC2htRzi3GZ1qOspFjp2jXzpcvJCKU0cyfdD6E1NMN/FnFzSVfi87QhrbxBXPQpnzIeI36BTqR1WKBU7fIt3FAB4ZIANJaJQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564341; c=relaxed/simple;
	bh=XXZ5TjTag0urHfraLP3YklOn4FDkBrCcuI/v/Qu8nU4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdHi3ekqH6WoGvNh0mmKaLHtgSaMaf2HNiKFrPkgqRv1YAWp25vluzLZgI3FbBncB5MZP0sCVCweiJkJWrbatJoAeiMw9MBwED3lJq1fxq/ncYAML2v/KIsp7iBo7AKp/LKVhn9P8EJ4kANr+i11NooaIyBHin8/KUeWQof1Tv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPTxR3zvDz6HJP4;
	Thu, 10 Oct 2024 20:45:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 16EAB140AE5;
	Thu, 10 Oct 2024 20:45:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 14:45:35 +0200
Date: Thu, 10 Oct 2024 13:45:33 +0100
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
Subject: Re: [PATCH v4 11/28] cxl/hdm: Add dynamic capacity size support to
 endpoint decoders
Message-ID: <20241010134533.00002750@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-11-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-11-c261ee6eeded@intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 07 Oct 2024 18:16:17 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> To support Dynamic Capacity Devices (DCD) endpoint decoders will need to
> map DC partitions (regions).  In addition to assigning the size of the
> DC partition, the decoder must assign any skip value from the previous
> decoder.  This must be done within a contiguous DPA space.
> 
> Two complications arise with Dynamic Capacity regions which did not
> exist with Ram and PMEM partitions.  First, gaps in the DPA space can
> exist between and around the DC partitions.  Second, the Linux resource
> tree does not allow a resource to be marked across existing nodes within
> a tree.
> 
> For clarity, below is an example of an 60GB device with 10GB of RAM,
> 10GB of PMEM and 10GB for each of 2 DC partitions.  The desired CXL
> mapping is 5GB of RAM, 5GB of PMEM, and 5GB of DC1.
> 
>      DPA RANGE
>      (dpa_res)
> 0GB        10GB       20GB       30GB       40GB       50GB       60GB
> |----------|----------|----------|----------|----------|----------|
> 
> RAM         PMEM                  DC0                   DC1
>  (ram_res)  (pmem_res)            (dc_res[0])           (dc_res[1])
> |----------|----------|   <gap>  |----------|   <gap>  |----------|
> 
>  RAM        PMEM                                        DC1
> |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXX-----|
> 0GB   5GB  10GB  15GB 20GB       30GB       40GB       50GB       60GB
> 
> The previous skip resource between RAM and PMEM was always a child of
> the RAM resource and fit nicely [see (S) below].  Because of this
> simplicity this skip resource reference was not stored in any CXL state.
> On release the skip range could be calculated based on the endpoint
> decoders stored values.
> 
> Now when DC1 is being mapped 4 skip resources must be created as
> children.  One for the PMEM resource (A), two of the parent DPA resource
> (B,D), and one more child of the DC0 resource (C).
> 
> 0GB        10GB       20GB       30GB       40GB       50GB       60GB
> |----------|----------|----------|----------|----------|----------|
>                            |                     |
> |----------|----------|    |     |----------|    |     |----------|
>         |          |       |          |          |
>        (S)        (A)     (B)        (C)        (D)
> 	v          v       v          v          v
> |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXX-----|
>        skip       skip  skip        skip      skip
> 
> Expand the calculation of DPA free space and enhance the logic to
> support this more complex skipping.  To track the potential of multiple
> skip resources an xarray is attached to the endpoint decoder.  The
> existing algorithm between RAM and PMEM is consolidated within the new
> one to streamline the code even though the result is the storage of a
> single skip resource in the xarray.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
One trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> Changes:
> [djiang: s/skip_res/skip_xa/]
> ---
>  drivers/cxl/core/hdm.c  | 196 ++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/cxl/core/port.c |   2 +
>  drivers/cxl/cxl.h       |   2 +
>  3 files changed, 184 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3df10517a327..8c7f941eaba1 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -223,6 +223,25 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, CXL);
>  
> +static void cxl_skip_release(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct device *dev = &port->dev;
> +	unsigned long index;
> +	void *entry;
> +
> +	xa_for_each(&cxled->skip_xa, index, entry) {
> +		struct resource *res = entry;

	struct resource *res;

	xa_for_each(&cxled->skip_xa, index, res) {

as can always cast form a pointer to a void *
and avoiding the extra local variable is a nice to have.


> +
> +		dev_dbg(dev, "decoder%d.%d: releasing skipped space; %pr\n",
> +			port->id, cxled->cxld.id, res);
> +		__release_region(&cxlds->dpa_res, res->start,
> +				 resource_size(res));
> +		xa_erase(&cxled->skip_xa, index);
> +	}
> +}



