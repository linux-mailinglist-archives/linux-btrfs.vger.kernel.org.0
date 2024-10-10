Return-Path: <linux-btrfs+bounces-8784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741C998713
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4751F242A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A951C9B88;
	Thu, 10 Oct 2024 13:04:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E01C8FBD;
	Thu, 10 Oct 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565473; cv=none; b=XY44RiI9f+8jTZoav/HFfQMqvDHMPngUPBxFC6G2Y/NG755hkGs71SnkBeqQKcvIocZrxYA+EKb/OuAOJfJKJMNf47Xv3o1g2ObSBd2WiwlCjf0LXxzkzHLTKC7+sprwno2P2/TWkB8CPpkcrty0xi3t6VXU5DMyBOc0lP9gTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565473; c=relaxed/simple;
	bh=xNDPLFjPVTy44G3E4OlkbyEJ+ZZUYrEtH8G7TV760w4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXxt+LwgDNyMHEeHiXrCdFE9XxGo8apYYj0HqceALTS4KLK82YQ/Bx6Zbz7prwNq07DV855tJ2Uh0WSG8s83sCHmvUXkSnA4Aa5HrjIdF0UNEtN7ULcpcmswl57szVRkqEr/z2kiSOK17+5xm2sbkO40aU8OQM0qqXDew5jEsss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPVGb4TxLz6LDGs;
	Thu, 10 Oct 2024 21:00:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 692D7140A36;
	Thu, 10 Oct 2024 21:04:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 15:04:27 +0200
Date: Thu, 10 Oct 2024 14:04:26 +0100
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
Subject: Re: [PATCH v4 13/28] cxl/mem: Expose DCD partition capabilities in
 sysfs
Message-ID: <20241010140426.000065aa@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-13-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-13-c261ee6eeded@intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 07 Oct 2024 18:16:19 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> To properly configure CXL regions on Dynamic Capacity Devices (DCD),
> user space will need to know the details of the DC partitions available.
> 
> Expose dynamic capacity capabilities through sysfs.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Some trivial stuff inline that I'm not that bothered about either way.

Subject to answering Fan's query
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes:
> [iweiny: Change .../memX/dc/* to .../memX/dcY/*]
> [iweiny: add read only and shareable attributes from DSMAS]
> [djiang: Split sysfs docs]
> [iweiny: Adjust sysfs doc dates]
> [iweiny: Add qos details]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  45 ++++++++++++
>  drivers/cxl/core/memdev.c               | 126 ++++++++++++++++++++++++++++++++
>  2 files changed, 171 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3f5627a1210a..b865eefdb74c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -54,6 +54,51 @@ Description:
>  		identically named field in the Identify Memory Device Output
>  		Payload in the CXL-2.0 specification.
>  
> +What:		/sys/bus/cxl/devices/memX/dcY/size
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Dynamic Capacity (DC) region information.  Devices only
> +		export dcY if DCD partition Y is supported.
> +		dcY/size is the size of each of those partitions.
> +
> +What:		/sys/bus/cxl/devices/memX/dcY/read_only
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Dynamic Capacity (DC) region information.  Devices only
> +		export dcY if DCD partition Y is supported.
> +		dcY/read_only indicates true if the region is exported
> +		read_only from the device.
> +
> +What:		/sys/bus/cxl/devices/memX/dcY/shareable
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Dynamic Capacity (DC) region information.  Devices only
> +		export dcY if DCD partition Y is supported.
> +		dcY/shareable indicates true if the region is exported
> +		shareable from the device.
> +
> +What:		/sys/bus/cxl/devices/memX/dcY/qos_class
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Dynamic Capacity (DC) region information.  Devices only
> +		export dcY if DCD partition Y is supported.  

You can document sysfs directories I think, e.g.
https://elixir.bootlin.com/linux/v6.12-rc2/source/Documentation/ABI/stable/sysfs-devices-node#L32
so maybe

What:			/sys/bus/cxl/device/memX/dcY
Date:		December, 2024
KernelVersion:	v6.13
Contact:	linux-cxl@vger.kernel.org
Description: 
		Directory containing Dynamic Capacity (DC) region information.
                Devices only export dcY if DCD partition Y is supported.

What:		/sys/bus/cxl/devices/memX/dcY/qos_class
Date:		December, 2024
KernelVersion:	v6.13
Contact:	linux-cxl@vger.kernel.org
Description:
		For CXL host...

To avoid the repetition of first bit of docs?

> +		platforms that support "QoS Telemmetry" this attribute conveys
> +		a comma delimited list of platform specific cookies that
> +		identifies a QoS performance class for the persistent partition
> +		of the CXL mem device. These class-ids can be compared against
> +		a similar "qos_class" published for a root decoder. While it is
> +		not required that the endpoints map their local memory-class to
> +		a matching platform class, mismatches are not recommended and
> +		there are platform specific performance related side-effects
> +		that may result. First class-id is displayed.
>  
>  What:		/sys/bus/cxl/devices/memX/pmem/qos_class
>  Date:		May, 2023


> +static ssize_t show_shareable_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  str_false_true(mds->dc_region[pos].shareable));

Fan has already raised that these seem backwards.

> +}
> +
> +static ssize_t show_qos_class_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%d\n", mds->dc_perf[pos].qos_class);
> +}
> +
> +#define CXL_MEMDEV_DC_ATTR_GROUP(n)						\
> +static ssize_t dc##n##_size_show(struct device *dev,				\
> +				 struct device_attribute *attr,			\
> +				 char *buf)					\
> +{										\
> +	return show_size_dcN(to_cxl_memdev(dev), buf, (n));			\
> +}										\
> +struct device_attribute dc##n##_size = {					\
> +	.attr	= { .name = "size", .mode = 0444 },				\
> +	.show	= dc##n##_size_show,						\
> +};										\
> +static ssize_t dc##n##_read_only_show(struct device *dev,			\
> +				      struct device_attribute *attr,		\
> +				      char *buf)				\
> +{										\
> +	return show_read_only_dcN(to_cxl_memdev(dev), buf, (n));		\
> +}										\
> +struct device_attribute dc##n##_read_only = {					\
> +	.attr	= { .name = "read_only", .mode = 0444 },			\
> +	.show	= dc##n##_read_only_show,					\
> +};										\
> +static ssize_t dc##n##_shareable_show(struct device *dev,			\
> +				     struct device_attribute *attr,		\
> +				     char *buf)					\
> +{										\
> +	return show_shareable_dcN(to_cxl_memdev(dev), buf, (n));		\
> +}										\
> +struct device_attribute dc##n##_shareable = {					\
> +	.attr	= { .name = "shareable", .mode = 0444 },			\
> +	.show	= dc##n##_shareable_show,					\
> +};										\
> +static ssize_t dc##n##_qos_class_show(struct device *dev,			\
> +				      struct device_attribute *attr,		\
> +				      char *buf)				\
> +{										\
> +	return show_qos_class_dcN(to_cxl_memdev(dev), buf, (n));		\
> +}										\
> +struct device_attribute dc##n##_qos_class = {					\
> +	.attr	= { .name = "qos_class", .mode = 0444 },			\
> +	.show	= dc##n##_qos_class_show,					\
> +};										\
> +static struct attribute *cxl_memdev_dc##n##_attributes[] = {			\
> +	&dc##n##_size.attr,							\
> +	&dc##n##_read_only.attr,						\
> +	&dc##n##_shareable.attr,						\
> +	&dc##n##_qos_class.attr,						\
> +	NULL,									\

No comma needed on terminator.

> +};										\
> +static umode_t cxl_memdev_dc##n##_attr_visible(struct kobject *kobj,		\
> +					       struct attribute *a,		\
> +					       int pos)				\
> +{										\
> +	struct device *dev = kobj_to_dev(kobj);					\
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
> +										\
> +	/* Not a memory device */						\
> +	if (!mds)								\
	if (!to_cxl_memdev_state(cxlmd->cxlds))
		return 0;

I dislike long macros so if we can shave them down that is always good!

We do have precedence in hdm.c for just checking the type directly so maybe
	if (cxlmd->cxlds->type != CXL_DEVTYPE_CLASSMEM)

but the above is also fine as compiler should be able to figure out it
doesn't need to do the second half of the inline.


> +		return 0;							\
> +	return a->mode;								\
> +}										\
> +static umode_t cxl_memdev_dc##n##_group_visible(struct kobject *kobj)		\
> +{										\
> +	struct device *dev = kobj_to_dev(kobj);					\
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
> +										\
> +	/* Not a memory device or partition not supported */			\
> +	if (!mds || n >= mds->nr_dc_region)					\
> +		return false;							\
> +	return true;								\

	/* Memory device and partition is supported */
	return mds && n < mds->nr_dc_region;

> +}										\
>


