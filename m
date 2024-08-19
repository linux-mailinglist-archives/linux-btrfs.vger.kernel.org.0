Return-Path: <linux-btrfs+bounces-7321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E31957419
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 21:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B43284654
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E261D54F5;
	Mon, 19 Aug 2024 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bL8jOzJD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A726AD3;
	Mon, 19 Aug 2024 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094345; cv=none; b=NeMnksUceGjXc7nw64kUh6Fc7LlWYJdL8Og9hQBMbQfG+s/+Us36KovU10zmOtXdC7Gq9wipehse39FxG417w7n95YekGaGpEtzmdWIwl8LaruKFZT4C8AE4JzNl5L5BMrv4qRpytYQTQ14+/UNQWjrNBQS7mG2KbtZ90tC95AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094345; c=relaxed/simple;
	bh=CLTJP9CT/7sCIJ8xHsZUBTA6B7x9HhHrdnrEr3HW0bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNYqhzDUJZAZPTSRkl1VMpB7KfHHEZe1rk2E2I9tL4YBaIZEqvRkPTmLwuWe5JR5qX5GOFwugarNqUHtzJOkSUy7IkWnPWjMrBERDLdAb8oYqBtDK8DIknEdatqZdeIARUWzgk7FQfOnFwBRBem9yqd9AiZGOPsUFpE95i7uvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bL8jOzJD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724094343; x=1755630343;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CLTJP9CT/7sCIJ8xHsZUBTA6B7x9HhHrdnrEr3HW0bs=;
  b=bL8jOzJDjzjZ1l7Fl+jezt+2U41+6h+YW3TQEwoIpVU7vDwejtME+hx+
   g/nRqBC5rIujNQi2g1/pXkjKR6pL+qQ4rpNJKlus8NFrsFBsHiAoGNAD+
   lW+G9VBNmxLwPxmEQELAdgopZ3tGrIi3XNowslZ533BEqN2ohqBE+FX0+
   4bBStZ207P1ZIQHmjQTnRIlnYoi3VRhEwbAG0bZKkt2F7NxRHuEpIlx5L
   7xg+pRQmkZpk4pGRAGDRUJidu8nMBeq5cNN3rmKmFrhWdIgfNpskbmLZk
   sTfQNtsmzakOZ6Ys7kxK1aF00GKUyyiJrrEubdzBEYbND5exgs25OQKqI
   A==;
X-CSE-ConnectionGUID: +3UJ4wWBR7GxLEZBMMeofA==
X-CSE-MsgGUID: dU3zvqy/RFO4/Djswab2aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="13098808"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="13098808"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 12:05:42 -0700
X-CSE-ConnectionGUID: aT4sIghGTiOkUK+cWy04Ow==
X-CSE-MsgGUID: dS5yygMXQUKWZa26EgtDjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60124598"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.111.235]) ([10.125.111.235])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 12:05:40 -0700
Message-ID: <63cfd343-763e-4f7a-a1cc-857927a7282c@intel.com>
Date: Mon, 19 Aug 2024 12:05:38 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/25] cxl/region/extent: Expose region extent
 information in sysfs
To: ira.weiny@intel.com, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, nvdimm@lists.linux.dev
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-19-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-19-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
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
> ---
> Changes:
> [iweiny: split this out]
> [Jonathan: add documentation for extent sysfs]
> [Jonathan/djbw: s/label/tag]
> [Jonathan/djbw: treat tag as uuid]
> [djbw: use __ATTRIBUTE_GROUPS]
> [djbw: make tag invisible if it is empty]
> [djbw/iweiny: use conventional id names for extents; extentX.Y]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 13 ++++++++
>  drivers/cxl/core/extent.c               | 58 +++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3a5ee88e551b..e97e6a73c960 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -599,3 +599,16 @@ Description:
>  		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
>  		the number to the closest initiator and access1 provides the
>  		number to the closest CPU.
> +
> +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
> +		/sys/bus/cxl/devices/dax_regionX/extentX.Y/length
> +		/sys/bus/cxl/devices/dax_regionX/extentX.Y/tag

I wonder consider an entry for each with their own descriptions, which seems to be the standard practice.

DJ

> +Date:		October, 2024
> +KernelVersion:	v6.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) [For Dynamic Capacity regions only]  Extent offset and
> +		length within the region.  Users can use the extent information
> +		to create DAX devices on specific extents.  This is done by
> +		creating and destroying DAX devices in specific sequences and
> +		looking at the mappings created.
> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> index 34456594cdc3..d7d526a51e2b 100644
> --- a/drivers/cxl/core/extent.c
> +++ b/drivers/cxl/core/extent.c
> @@ -6,6 +6,63 @@
>  
>  #include "core.h"
>  
> +static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct region_extent *region_extent = to_region_extent(dev);
> +
> +	return sysfs_emit(buf, "%#llx\n", region_extent->hpa_range.start);
> +}
> +static DEVICE_ATTR_RO(offset);
> +
> +static ssize_t length_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct region_extent *region_extent = to_region_extent(dev);
> +	u64 length = range_len(&region_extent->hpa_range);
> +
> +	return sysfs_emit(buf, "%#llx\n", length);
> +}
> +static DEVICE_ATTR_RO(length);
> +
> +static ssize_t tag_show(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct region_extent *region_extent = to_region_extent(dev);
> +
> +	return sysfs_emit(buf, "%pUb\n", &region_extent->tag);
> +}
> +static DEVICE_ATTR_RO(tag);
> +
> +static struct attribute *region_extent_attrs[] = {
> +	&dev_attr_offset.attr,
> +	&dev_attr_length.attr,
> +	&dev_attr_tag.attr,
> +	NULL,
> +};
> +
> +static uuid_t empty_tag = { 0 };
> +
> +static umode_t region_extent_visible(struct kobject *kobj,
> +				     struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct region_extent *region_extent = to_region_extent(dev);
> +
> +	if (a == &dev_attr_tag.attr &&
> +	    uuid_equal(&region_extent->tag, &empty_tag))
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +static const struct attribute_group region_extent_attribute_group = {
> +	.attrs = region_extent_attrs,
> +	.is_visible = region_extent_visible,
> +};
> +
> +__ATTRIBUTE_GROUPS(region_extent_attribute);
> +
>  static void cxled_release_extent(struct cxl_endpoint_decoder *cxled,
>  				 struct cxled_extent *ed_extent)
>  {
> @@ -44,6 +101,7 @@ static void region_extent_release(struct device *dev)
>  static const struct device_type region_extent_type = {
>  	.name = "extent",
>  	.release = region_extent_release,
> +	.groups = region_extent_attribute_groups,
>  };
>  
>  bool is_region_extent(struct device *dev)
> 

