Return-Path: <linux-btrfs+bounces-3614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C975A88C978
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 17:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE4F1F81E86
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CAC15EA6;
	Tue, 26 Mar 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eknk38Ai"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A9E4C65;
	Tue, 26 Mar 2024 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470930; cv=none; b=TtFBHar+urpBoVVYyzEUXAGAs/+UB1vk0kOYOC8u8xGEL6e+aL48h2CPSklnTj9kB6pZTnLzdQPCongNYABPitk/NZKuYVAdGGSS91VLHWr8weryjgu2Ad9TQjo6tC27fUwBybVrivecvWlkPHquKH0h5FazmsKZtv1LGSyso3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470930; c=relaxed/simple;
	bh=CFqQchIyPIzRsUeJ/rg+uqvzWrlRpidgL7wMY10wNLE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl4THNa5UJX1QtvuOo18FsRXMeRWi702myYunIZG8CCObpiMhsxcBBAhxkam/k2M1L/v1vj4GIpV1578/2dwbqi6qqf+IovhLJppoml+sTfAAF2DhSz8xokTROsx2lKCyU2+CI0Z9up3PuRAENO9YIuCrfvFnGFNwucuVU+B36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eknk38Ai; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e8f51d0bf0so4571528b3a.3;
        Tue, 26 Mar 2024 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711470927; x=1712075727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CK3impwWJ72tM59fZvJpJBu1tBnhrzrXHR4AUN5lySw=;
        b=eknk38AiG+vAOZubWmmoCy/5WhZsR1zTxcnzxYUdob5fVLUHLu3rpoma7CZGmMTG2X
         liQaN95ewRKviLxaiJsqNabDeLybRKtOR45MobOb+ESlRETK9POIdOpW1JpRdbSyb+5i
         3DCZRb0UUc9umxaqdaqrjTevwOMlkz2HqmKq207IKh9H191wfo3iCrQxJ9ser9Q9FcM/
         p64CYnNx6n+CyUxFGFW8FZ5mvDQXvHdAr4Bfc1N5+p1C0JHsfr8s4mAA8YPN0NHvTlQT
         1I3VxPKDEKarqBu0mswCq/bgdfDLq9iTLPWySHtGPrmaujLNwd78D6kVf7YeRb1ZbWh2
         cmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470927; x=1712075727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK3impwWJ72tM59fZvJpJBu1tBnhrzrXHR4AUN5lySw=;
        b=Zw2/+p6b9EB8gh0PN4aR+FVLSlb8B8zeVszoRanboT+raOA5JqKpR3VSyH/aWrYFen
         ei8a0cOuRvSr45RgxmGwJs2Yg/dSaylx8EUvZXF/e6XlTGpYB4JhRQjNhzSk/Td9VdsG
         jFUEhIjkOO7CSZiYeFgxgnzLYvhhMrGvMYAFJEa393lBFUt8kJCfDe/xEqpRvTefBnTb
         HUZr2udYdabU5ZZvkg2hFOwpDLtJtADpmGkkObXGuflmmEbTIeJ1z+rTg0OYeX7/Kbit
         0FdZV9bnYf5oDU3krluvij+7plA59JzYl9SN3DuM7RKMJUSr4VHx1kIncx4J0U4nAwWB
         KT7A==
X-Forwarded-Encrypted: i=1; AJvYcCXBJ2n4lZegYQa0w7ODsGxv0lIXABtZuYSqPOdp3qv3yZ7/RX5S6g2/TuSWh6LbNURH4oU6WX4nVHQFG/TIIXCw17dHHS67dq4leoYwew6Y6yduvuUKxYF7T6WLULMgDQdP5cpqBaQiyfbUKWlCJrx5s961EVKdVUhlS9BWkIag9tbdlxk=
X-Gm-Message-State: AOJu0YwWsLd8MrFms/mzyGybUa3kTYlY0g2i6JAWWehn5DWlvAJyGOcB
	Qp73DViuvGP5GerQpa3F2d0fuUCw/x1Fnp57UuDlpXeWQGBfvE8f8LGIEFEI
X-Google-Smtp-Source: AGHT+IEUwKYaUfi9JjyN7Z6XAZKu7wPXR4jMdNx0iiFb5+fN830vWsGeqH07RQ9Nu45uPutvAIel9w==
X-Received: by 2002:a05:6a00:99c:b0:6e7:4ab3:f8fe with SMTP id u28-20020a056a00099c00b006e74ab3f8femr4243470pfg.7.1711470927552;
        Tue, 26 Mar 2024 09:35:27 -0700 (PDT)
Received: from debian ([2601:641:300:14de:69a2:b1ff:1efd:f4a9])
        by smtp.gmail.com with ESMTPSA id bx41-20020a056a02052900b005dc120fa3b2sm6623851pgb.18.2024.03.26.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:35:27 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 26 Mar 2024 09:35:21 -0700
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/26] cxl/port: Add Dynamic Capacity mode support to
 endpoint decoders
Message-ID: <ZgL5SdGCori3Dh3O@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:09PM -0700, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Endpoint decoders which are used to map Dynamic Capacity must be
> configured to point to the correct Dynamic Capacity (DC) Region.  The
> decoder mode currently represents the partition the decoder points to
> such as ram or pmem.
> 
> Expand the mode to include DC regions [partitions].
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Minor comments below.

> 
> ---
> Changes for v1:
> [iweiny: eliminate added gotos]
> [iweiny: Mark DC support for 6.10 kernel]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 21 +++++++++++----------
>  drivers/cxl/core/hdm.c                  | 19 +++++++++++++++++++
>  drivers/cxl/core/port.c                 | 16 ++++++++++++++++
>  3 files changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index fff2581b8033..8b3efaf6563c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -316,23 +316,24 @@ Description:
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
> -Date:		May, 2022
> -KernelVersion:	v6.0
> +Date:		May, 2022, June 2024
> +KernelVersion:	v6.0, v6.10 (dcY)
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
>  		translates from a host physical address range, to a device local
>  		address range. Device-local address ranges are further split
> -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> -		'mixed', or 'none'. The 'mixed' indication is for error cases
> -		when a decoder straddles the volatile/persistent partition
> -		boundary, and 'none' indicates the decoder is not actively
> -		decoding, or no DPA allocation policy has been set.
> +		into a 'ram' (volatile memory) range, 'pmem' (persistent
> +		memory) range, or Dynamic Capacity (DC) range. The 'mode'
> +		attribute emits one of 'ram', 'pmem', 'dcY', 'mixed', or
> +		'none'. The 'mixed' indication is for error cases when a
> +		decoder straddles the volatile/persistent partition boundary,
> +		and 'none' indicates the decoder is not actively decoding, or
> +		no DPA allocation policy has been set.
>  
>  		'mode' can be written, when the decoder is in the 'disabled'
> -		state, with either 'ram' or 'pmem' to set the boundaries for the
> -		next allocation.
> +		state, with 'ram', 'pmem', or 'dcY' to set the boundaries for
> +		the next allocation.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 66b8419fd0c3..e22b6f4f7145 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -255,6 +255,14 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	__cxl_dpa_release(cxled);
>  }
>  
> +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> +{
> +	if (mode < CXL_DECODER_DC0 || CXL_DECODER_DC7 < mode)

To me, it is more natural to have something like x<a || x>b other than
x<a || b < x for out of range check.

> +		return -EINVAL;
> +
> +	return mode - CXL_DECODER_DC0;
> +}
> +
>  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			     resource_size_t base, resource_size_t len,
>  			     resource_size_t skipped)
> @@ -411,6 +419,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
> +	int rc;
>  
>  	guard(rwsem_write)(&cxl_dpa_rwsem);
>  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> @@ -433,6 +442,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  			return -ENXIO;
>  		}
>  		break;
> +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> +		rc = dc_mode_to_region_index(mode);
> +		if (rc < 0)
> +			return rc;
> +
> +		if (resource_size(&cxlds->dc_res[rc]) == 0) {

The other similar checks above use "!resource_size(...)".

Fan

> +			dev_dbg(dev, "no available dynamic capacity\n");
> +			return -ENXIO;
> +		}
> +		break;
>  	default:
>  		dev_dbg(dev, "unsupported mode: %d\n", mode);
>  		return -EINVAL;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e59d9d37aa65..80c0651794eb 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -208,6 +208,22 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  		mode = CXL_DECODER_PMEM;
>  	else if (sysfs_streq(buf, "ram"))
>  		mode = CXL_DECODER_RAM;
> +	else if (sysfs_streq(buf, "dc0"))
> +		mode = CXL_DECODER_DC0;
> +	else if (sysfs_streq(buf, "dc1"))
> +		mode = CXL_DECODER_DC1;
> +	else if (sysfs_streq(buf, "dc2"))
> +		mode = CXL_DECODER_DC2;
> +	else if (sysfs_streq(buf, "dc3"))
> +		mode = CXL_DECODER_DC3;
> +	else if (sysfs_streq(buf, "dc4"))
> +		mode = CXL_DECODER_DC4;
> +	else if (sysfs_streq(buf, "dc5"))
> +		mode = CXL_DECODER_DC5;
> +	else if (sysfs_streq(buf, "dc6"))
> +		mode = CXL_DECODER_DC6;
> +	else if (sysfs_streq(buf, "dc7"))
> +		mode = CXL_DECODER_DC7;
>  	else
>  		return -EINVAL;
>  
> 
> -- 
> 2.44.0
> 

