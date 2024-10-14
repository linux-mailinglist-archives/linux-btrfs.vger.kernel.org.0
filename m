Return-Path: <linux-btrfs+bounces-8903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E4C99D448
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 18:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A738CB26645
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7331AE861;
	Mon, 14 Oct 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UalweJs2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21AE288B1;
	Mon, 14 Oct 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922136; cv=none; b=hoXmnA5wcUkVj9hTFqj4SmNSPEztLrTLyly/D+om8uceS0S0RKPZDI+pMBeYQQOnSkfUe6kGWavj2qyqn27PyKNVaZduIOEXSQOD2NV8WbXg6VIMYIekOkv52zoFjmEE5KrTRkJyFfrWaCI4ZSELAWBFcdAA2z7PqZhPPgInAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922136; c=relaxed/simple;
	bh=x0Gv6XhjavAOSlOmdm7MSOUPup2hPLoqFbL2brwshzI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgS7Pqrmb2lHbxJrFYei1153YuswbpMTumyBUuwAmF94X+D8dPjpVGui3lf+wSyZwcHbO2SsVyHKrWlNBV8D3MgcADbGkVkei8T6jc6tdeShKqCTO0/u3bJu9zzR+E7JqK3AyWA+R42Ap5oUn5K/u1nbb5h0L9lvHLxm4LpqAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UalweJs2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e292926104bso2288241276.0;
        Mon, 14 Oct 2024 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728922134; x=1729526934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X5RyIxaiFAqgyn7YTV3vu3eof3ewxJ3wbFaOqcBHMmY=;
        b=UalweJs2ivtnmL7plwFxhPy+03uawh1xDnJjH2HDcmXzbpVMN+0csiqOg/Tqf70kkC
         CUV2iIYsbn+KUD+uszh5XwOtNTFT2fS9ZQvs3oeAenbHwi4Gnp/4vp6TQ/aIzxtYooS7
         mhmcD0i2OmGmLi4gEnQIaFxM5PvIb6IxBF9eSGgakY56fZ9nm+n3c9aJgTW2J632nIdX
         gvcp3g9HxIkgztQ41k0y2HknV4clcrHn/8hlEXoG+GsQAdHnjHDEC4L7p0x/WfGrrBfF
         xWp1af8dt544Xk+92YGg5K6aZhfDzyduyshJeEUfwT5UWZ54TkFm90OYWfiJ1UxUMaEz
         Fykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728922134; x=1729526934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5RyIxaiFAqgyn7YTV3vu3eof3ewxJ3wbFaOqcBHMmY=;
        b=StwKLy1tykT2s8wMLHDTfDO9xjblE1LmdKUNdRhaiWyE0m1SHvMklr/r/CPA2EVYAa
         BtwlTK1Inwx8D0Rx5/TCec2ZNf0bfEUkaaxYojxlisMQqynJZ1iVOEMENkH96NwwjfVB
         mpUNGpUm1oPOxnJ8V15LMucdybWoL/VKSoZSDG+mBu1J3yuyEt4rxVikMU1nPelKpWKg
         5DW9QqG1ZLUpesVHvehE5taMGwH7Z50jGlao4trvDjYBaixs8cR1t8/KkVr+yXHTNJ2N
         fUbUb886NhAu0PZ2cXOXl/fXPXctBngy5dgVFqCNBbqUu2SeNfXbrqfriaxq670z/JSS
         FIVg==
X-Forwarded-Encrypted: i=1; AJvYcCUszshiv7m/IBM11JNR8dTPkthh6oYfIXVmWIxdNyNe3Baeuh9llS+rljQGZgprN4lXa9QfllbzU493@vger.kernel.org, AJvYcCVs2l8PXKZdgOQT68PAJ6y+51YIlUCEcFFh7wN4I57K36GbRmfnCBJx3ywPlUB5BWblLAjAJNCbCXuL0A==@vger.kernel.org, AJvYcCXhqwVY4HvnEe34ltSv68tIl92J6qIirCnEInO+rQbUUKxIUkjr0Gu7mwqr6c9tULNlTsYEKiJ+dh1x@vger.kernel.org, AJvYcCXj4aAqewXLCovfKxMAtvrUXySk218bjd5v9W0//aiWKe49e8ZV94cf6otd8Cdpvqf4GqTgPhHQUyhRQbeg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmfz4/S+s6RgwPTrjzfLODGiO+UKFoWwTV3EzUpXR5My0HAEdN
	GuElv7iOzH6wRU9vwUC8lhZdp0QlnWxFN+juLpg3NExTTISHNezj
X-Google-Smtp-Source: AGHT+IFm3nS/SkhhLDoqifUygslM34yLooMncY8URtqtXHAS6QEz7pQyx7s+F1mpZz8WPolBXsfnOg==
X-Received: by 2002:a05:6902:1104:b0:e25:abb9:c71b with SMTP id 3f1490d57ef6-e2919defaaemr7976293276.39.1728922133703;
        Mon, 14 Oct 2024 09:08:53 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e290edff83esm2512650276.16.2024.10.14.09.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:08:53 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 14 Oct 2024 09:08:36 -0700
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 22/28] cxl/region/extent: Expose region extent
 information in sysfs
Message-ID: <Zw1CBOBEzHm1sHaH@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-22-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-22-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:28PM -0500, ira.weiny@intel.com wrote:
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

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>

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
> +		sequences and looking at the mappings created.  Extent offset
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
> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> index 69a7614ba6a9..a1eb6e8e4f1a 100644
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
> -- 
> 2.46.0
> 

-- 
Fan Ni

