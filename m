Return-Path: <linux-btrfs+bounces-8806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9C5998BCD
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240AD1C2359D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4F1CDFA6;
	Thu, 10 Oct 2024 15:34:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BCB1CCB46;
	Thu, 10 Oct 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574452; cv=none; b=K6TlV8pzkgu1FVAeCCtFMde2ff1xL3oTs+RwctzFHFPNLGzaORNIJvQwBCT5zgrbYFDihWfDyvNTXllZ26PK4zuZ0t6ziqQ5Ji7GNG4LmngP1HmJnyb8U8OWZcPRVhDVonLwH7juIn1pfmcggAbFKJpCB9EfNr6Aw1Sq005YeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574452; c=relaxed/simple;
	bh=EllmNvsh7fQqqPvaUW4yCBiPLtpI7eF8Gz+UCBruqL8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bivXNt5Sj70gs9fG/MaeIUtKVXZ3GXKG3xYUu21aALynV3Coc9Qz89qJ3LvvsS9JU61DERcuVSJilBfn6L/I2PD/jmM4mZ9WNrTMLavKT/sHgrI4jaj6NwdtUl2bdC3bA45t3RBUePsnk4/Ru05l75P4kC1AgMoxw2FoXFgHYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPYgs73r8z6HJyK;
	Thu, 10 Oct 2024 23:33:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E4DCF140CB1;
	Thu, 10 Oct 2024 23:34:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 17:34:00 +0200
Date: Thu, 10 Oct 2024 16:33:59 +0100
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
Subject: Re: [PATCH v4 25/28] cxl/region: Read existing extents on region
 creation
Message-ID: <20241010163359.000001f7@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-25-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-25-c261ee6eeded@intel.com>
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

On Mon, 07 Oct 2024 18:16:31 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic capacity device extents may be left in an accepted state on a
> device due to an unexpected host crash.  In this case it is expected
> that the creation of a new region on top of a DC partition can read
> those extents and surface them for continued use.
> 
> Once all endpoint decoders are part of a region and the region is being
> realized, a read of the 'devices extent list' can reveal these
> previously accepted extents.
> 
> CXL r3.1 specifies the mailbox call Get Dynamic Capacity Extent List for
> this purpose.  The call returns all the extents for all dynamic capacity
> partitions.  If the fabric manager is adding extents to any DCD
> partition, the extent list for the recovered region may change.  In this
> case the query must retry.  Upon retry the query could encounter extents
> which were accepted on a previous list query.  Adding such extents is
> ignored without error because they are entirely within a previous
> accepted extent.
> 
> The scan for existing extents races with the dax_cxl driver.  This is
> synchronized through the region device lock.  Extents which are found
> after the driver has loaded will surface through the normal notification
> path while extents seen prior to the driver are read during driver load.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
One buglet, and a request for an error message.
With those.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d66beec687a0..6b25d15403a3 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1697,6 +1697,111 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
>  
> +/* Return -EAGAIN if the extent list changes while reading */
> +static int __cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
> +{
> +	u32 current_index, total_read, total_expected, initial_gen_num;
> +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u32 max_extent_count;
> +	bool first = true;
> +
> +	struct cxl_mbox_get_extent_out *extents __free(kfree) =

__free(kvfree)

> +				kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> +	if (!extents)
> +		return -ENOMEM;

...


> +}

>  static void cxlr_dax_unregister(void *_cxlr_dax)
>  {
>  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> @@ -3224,6 +3233,9 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>  		dev_name(dev));
>  
> +	if (cxlr->mode == CXL_REGION_DC)
> +		cxlr_add_existing_extents(cxlr);

Whilst there isn't a whole lot we can do if this fails, I'd like an error
print to indicate something odd is going on.  Probably pass any error
up to here then print a message before carrying on.

> +
>  	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
>  					cxlr_dax);
>  err:


