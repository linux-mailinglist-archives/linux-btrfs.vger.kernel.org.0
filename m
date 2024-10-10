Return-Path: <linux-btrfs+bounces-8797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955CD998AEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C551A1C24289
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E50E1CEAD6;
	Thu, 10 Oct 2024 15:01:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53211CEAB3;
	Thu, 10 Oct 2024 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572509; cv=none; b=E6OFWHMCzLdGTPnrDK04qmHIrMSfxKYF6UcyzElsxN9zQ1csCC/siFuPIGkCq/+6cT6OvPdYibKQd6+BPx/KLD2M4XLviM02B2UCs6r3SpY+I6EoQWIyFIsI1gGl3uC1d/SpQ5CnuKTaL0q9Q0EIj+P2MIJgCMj6yIn4ni+0Wow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572509; c=relaxed/simple;
	bh=LzsG5zy+onTdkegSw8IXtWNghv1bv/fmdCElJ/2wVQ8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQRIqtGQiNKAO6YXoqh8Y189+Fc2Vrb/DtJVn5sKp65SiX6uN/GROXFFrrGvOnoI7AFtfWlvHdVDpeZTutvez+wo7TZPUgG2V9V6rWppYQ/f9cPLv7xG60pN6nQfKs00x0tefR9vDme5IJb8Ne6WByhGUkXU5rD00cBtK7OBzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPXsv3xj1z6J7tq;
	Thu, 10 Oct 2024 22:57:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 745C7140CF4;
	Thu, 10 Oct 2024 23:01:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 17:01:43 +0200
Date: Thu, 10 Oct 2024 16:01:42 +0100
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
Subject: Re: [PATCH v4 22/28] cxl/region/extent: Expose region extent
 information in sysfs
Message-ID: <20241010160142.00005a5c@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-22-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-22-c261ee6eeded@intel.com>
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

On Mon, 07 Oct 2024 18:16:28 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Extent information can be helpful to the user to coordinate memory usage
> with the external orchestrator and FM.
> 
> Expose the details of region extents by creating the following
> sysfs entries.
> 
>         /sys/bus/cxl/devices/dax_regionX/extentX.Y
>         /sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
>         /sys/bus/cxl/devices/dax_regionX/extentX.Y/length
>         /sys/bus/cxl/devices/dax_regionX/extentX.Y/tag
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
Trivial comments inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes:
> [djiang: Split sysfs docs up]
> [iweiny: Adjust sysfs docs dates]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 32 ++++++++++++++++++
>  drivers/cxl/core/extent.c               | 58 +++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index b63ab622515f..64918180a3c9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -632,3 +632,35 @@ Description:
>  		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
>  		the number to the closest initiator and access1 provides the
>  		number to the closest CPU.
> +
> +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) [For Dynamic Capacity regions only] Users can use the
> +		extent information to create DAX devices on specific extents.
> +		This is done by creating and destroying DAX devices in specific
> +		sequences and looking at the mappings created. 

Similar to earlier patch, maybe put this doc for the directory, then
have much less duplication?


> Extent offset
> +		within the region.
> +
> +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/length
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) [For Dynamic Capacity regions only] Users can use the
> +		extent information to create DAX devices on specific extents.
> +		This is done by creating and destroying DAX devices in specific
> +		sequences and looking at the mappings created.  Extent length
> +		within the region.
> +
> +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/tag
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) [For Dynamic Capacity regions only] Users can use the
> +		extent information to create DAX devices on specific extents.
> +		This is done by creating and destroying DAX devices in specific
> +		sequences and looking at the mappings created.  Extent tag.

Maybe say we are treating it as a UUID?

> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> index 69a7614ba6a9..a1eb6e8e4f1a 100644
> --- a/drivers/cxl/core/extent.c
> +++ b/drivers/cxl/core/extent.c
> @@ -6,6 +6,63 @@

> +static struct attribute *region_extent_attrs[] = {
> +	&dev_attr_offset.attr,
> +	&dev_attr_length.attr,
> +	&dev_attr_tag.attr,
> +	NULL,
No need for trailing comma (one of my 'favourite' review comments :)

> +};

