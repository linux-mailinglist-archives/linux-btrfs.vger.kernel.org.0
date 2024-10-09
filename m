Return-Path: <linux-btrfs+bounces-8750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3179976D9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 22:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8030F1C23401
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D479B1E282B;
	Wed,  9 Oct 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkFOcWnp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7181E1305;
	Wed,  9 Oct 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506798; cv=none; b=ni4JQfCpjv9PuSpIW/Yeg7X7Sm5a3Gd5yofGBWJ/q97x7pBL8uoNwFAiOIsZ843axeVF+0oLW+fEn0ju9Q9xC2GP+/FGkK82MXY52DPtgneDmYWOMaUL9pYsJtqM+Nw+kgWRpBYtiNOlP2EYUAQX24qmLOceurhqAoAiMAUxFe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506798; c=relaxed/simple;
	bh=Qz2j/PP1lOLYfkIT8rGz6zxJ0SpWVcP9cqhxdmqDxdU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hanxVRqMR8dMJYs+DwOlbxMMBga/armBx6g4oatH+fwN/tXKvHMl02mG2V+B+CkOPsZ0RQeJ+UYkqUGsr9BTsxVGl6hIledWEL01uiEgGFyeIMxQoC6llbhhSY7SdKyndE5k8crPE0xlBDACAK7YErfUcyPcFLq1btSXpw0HJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkFOcWnp; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e3121be692so3130787b3.1;
        Wed, 09 Oct 2024 13:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728506795; x=1729111595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vLyjlujieScv3UgYNOTdCR9B2JU1g3jTaSo//GoTfjk=;
        b=FkFOcWnpsDs2HP8JFn8p3DpyQdjUiY21AtRy1Gcb2mhE4GkADY5/99x5xxZRYg87PX
         yDXFTpCKqEW4j6qccpMIMPWLH6S+DTIlsoUsW7Ix+J12CMRE6jsTaCiVgAufB9F1XFDj
         xo5krV3c8w/8A63J2VEVhJOoV14hrvgC8RK8p8eP5BWJ3vDvNXggTGgzh0zjUIfOqJgy
         wtMtyXYZkhr0dLb98RvEfWyXK+XUn4rqtl6/iCpZQ7J1Dvytx0RXyf/GCS6zi26NpU+q
         iQzUd4iQlB077w/1JzCIv9SzWub/mYWAP7tAozoBgfjcyQUSPxjgrfFpA79ugofdhhHj
         XaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728506795; x=1729111595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLyjlujieScv3UgYNOTdCR9B2JU1g3jTaSo//GoTfjk=;
        b=lhWwZCvCAHyAWxBU9iVx/SMu34Zb2tAaOlpoU3BtbO0kEKWgr/vUFKBUJQhG2mFGNI
         CEfmb6USTjnZM1At2OdtrvqjTJE3rcDdWHvs59jvIKbPM8jKvEjScJu1jVFeDySXDUIz
         S7pLQ/IlBGQ2BUgIQCKyPwSUjv0zhH+UhrqWH03EuJETQz9T9zFUxAFE2IU0bChpIxod
         4HAuGIvtqLbm5L78EaCUGThuQ5ZyC7uBz+gMvZur1tdCrCJwVPfNWLNg4XpknDITczZ2
         83SWKVix1apC3LfiCFg/xrXtZAGS10kQO+mbQsjmT0nzXppJHM/1RTWaAKU2oUSX7mBz
         Hv5g==
X-Forwarded-Encrypted: i=1; AJvYcCUeL9uzRMRN2ERJ4cgMztezVXY6KIr6hD9pJVn41e1CfRtq1LGP8Qqx5GDSLATC4bvVfCV90YK/3HCz@vger.kernel.org, AJvYcCVTmQm4o0YUm4G5imeI1jxOb9Wf0lTrglkFMf/5+f0R///ZA2HgMxNwL/aqrgBG3cAHshib2lDxhR3UBw==@vger.kernel.org, AJvYcCWU8bJCjpo/vwCyZwdK9PDCcbe2cK+M3utK71lTDGTVOpqhfrW2IqU78LGni3X+e/HF8skaU2yJzs7j7tao@vger.kernel.org, AJvYcCXlo3bH0nU9ArVndeawhCPAZy6ry5IkUiiBHlz8JRNNY+DhiOzMNvTAd5gVpHBIdNfHKljQA1kjezex@vger.kernel.org
X-Gm-Message-State: AOJu0Yztwy8/PT1PzsMgiJXs0unuoq2Nl7RSmtqU6znzgTvigRUqUDTD
	GUGpqZWzYB+bS+lXJ5xMyk8RYb1xb2W9enK2GhOKEQ+2l+39jDRh
X-Google-Smtp-Source: AGHT+IFf4sz0TRbyD8Yi6n4r3mk7Izok61UXQMKHBV9h+m6UNoJBfctWfVmJRgfhGF7zrm5BJMEVaQ==
X-Received: by 2002:a05:690c:640d:b0:6e3:2e20:a03c with SMTP id 00721157ae682-6e32e20a24cmr20593397b3.26.1728506795085;
        Wed, 09 Oct 2024 13:46:35 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93d40c8sm20479477b3.83.2024.10.09.13.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:46:34 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 9 Oct 2024 13:46:19 -0700
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
Subject: Re: [PATCH v4 13/28] cxl/mem: Expose DCD partition capabilities in
 sysfs
Message-ID: <Zwbrm690XW_8ImRW@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-13-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-13-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:19PM -0500, ira.weiny@intel.com wrote:
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
> +		export dcY if DCD partition Y is supported.  For CXL host
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
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 84fefb76dafa..2565b10a769c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2020 Intel Corporation. */
>  
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/string_choices.h>
>  #include <linux/firmware.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
> @@ -449,6 +450,123 @@ static struct attribute *cxl_memdev_security_attributes[] = {
>  	NULL,
>  };
>  
> +static ssize_t show_size_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%#llx\n", mds->dc_region[pos].decode_len);
> +}
> +
> +static ssize_t show_read_only_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  str_false_true(mds->dc_region[pos].read_only));

For this function and below, why str_false_true instead of
str_true_false??

Fan
> +}
> +
> +static ssize_t show_shareable_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  str_false_true(mds->dc_region[pos].shareable));
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
> +}										\
> +DEFINE_SYSFS_GROUP_VISIBLE(cxl_memdev_dc##n);					\
> +static struct attribute_group cxl_memdev_dc##n##_group = {			\
> +	.name = "dc"#n,								\
> +	.attrs = cxl_memdev_dc##n##_attributes,					\
> +	.is_visible = SYSFS_GROUP_VISIBLE(cxl_memdev_dc##n),			\
> +}
> +CXL_MEMDEV_DC_ATTR_GROUP(0);
> +CXL_MEMDEV_DC_ATTR_GROUP(1);
> +CXL_MEMDEV_DC_ATTR_GROUP(2);
> +CXL_MEMDEV_DC_ATTR_GROUP(3);
> +CXL_MEMDEV_DC_ATTR_GROUP(4);
> +CXL_MEMDEV_DC_ATTR_GROUP(5);
> +CXL_MEMDEV_DC_ATTR_GROUP(6);
> +CXL_MEMDEV_DC_ATTR_GROUP(7);
> +
>  static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  				  int n)
>  {
> @@ -525,6 +643,14 @@ static struct attribute_group cxl_memdev_security_attribute_group = {
>  };
>  
>  static const struct attribute_group *cxl_memdev_attribute_groups[] = {
> +	&cxl_memdev_dc0_group,
> +	&cxl_memdev_dc1_group,
> +	&cxl_memdev_dc2_group,
> +	&cxl_memdev_dc3_group,
> +	&cxl_memdev_dc4_group,
> +	&cxl_memdev_dc5_group,
> +	&cxl_memdev_dc6_group,
> +	&cxl_memdev_dc7_group,
>  	&cxl_memdev_attribute_group,
>  	&cxl_memdev_ram_attribute_group,
>  	&cxl_memdev_pmem_attribute_group,
> 
> -- 
> 2.46.0
> 

-- 
Fan Ni

