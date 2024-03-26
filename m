Return-Path: <linux-btrfs+bounces-3611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B2E88C918
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 17:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04553261B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6013CAA0;
	Tue, 26 Mar 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AShd9+Y5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AD91E484;
	Tue, 26 Mar 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470347; cv=none; b=crl4YU0eCHD4gQeJQAngbEWVGm3xY4uTz0GKO9SP5MUzstbXL8sXLrsNcvILJdbE+qB5RnGtaydOxNw9/EyXPMTtpoHX82o1q/ZNwe3wREjaXFyPCM4T2GZ9gsVwf/CPTGQS6Y4a8CryU0Dd8e7gW8oITZs/ZQ+ItxJQ5aXhz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470347; c=relaxed/simple;
	bh=+D3WTYDDLL/7LDBJigfyGOLSDV0/wuCloesfiMKCVzs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf9N1ZVJhTEEvT7xjWaI2K0LxtB9b+lBgkcHLYfEWohbY/BqiXZEkUJNA4WPmjy2Tx9EIG823hiHEoRWzniqiINgFfslTWJncWQv2aBgVRY1AoSZMc3M4D3DnszblylvfmbEKHqKhfFzzHZgzHGQwx10D1HVLyThHuTtw6om050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AShd9+Y5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e00d1e13acso34588005ad.0;
        Tue, 26 Mar 2024 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711470345; x=1712075145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/kFUig8qRoXLCD8fCSJJqRk0LqOJqkVlfRcQ39eqpc=;
        b=AShd9+Y5kDySCmJAYrPv0xPcQUDyUxfJuqdOpqtOSb29Vzlhasy7nJZiONXjFMas+m
         cjbukckHyys2rI6M5iuGKCzuccdHg2x/iZ31cy47ykZzRcA+8G0/YwXVuP+tSvigPSL0
         /vW5h8QXwLOpwdKZ4F8aDPucXUXGe9SpiUfkaT90+XVtX3i1iw7HK9AhlpVHvPteSwie
         WJ1MRl+qtYd2NisxEdwCYYy1eIqpu2qG0AszJyRi9ItpwOqVo+p2s2Mf+88Oywe9cu5X
         SSEpXTG0unbVo0X6WxhTsfxhnmYzrxtvqwNLKEybjnyrIzVK6Xww6g4UXCSc457cJIGM
         BCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470345; x=1712075145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/kFUig8qRoXLCD8fCSJJqRk0LqOJqkVlfRcQ39eqpc=;
        b=KMaz3fIW714V2nHzLYZ1MqBWo4whrWp/ed6bt7OQ2FKFkXAkfwwhqlldInbFrKHN6A
         WpGFK7qp1Su4g4oJtBiqAQHLghET61Sq6z2thJCWFJ+dULXhzvrSVUgdBkO9iQ+4W5SS
         wE+8kIGmEaXcCFQPUlJlzDD2Z5yDJ9LhBWHUlzoQZJIY4QWmTwouRxBqGQVOjWI+I+pk
         OnJFpXWilCxXDHA+CzYe3iHCpGPBT4rAOwMaE9QpxmVT1lT4Mn29QRboE9oBkD0fpJGd
         8VJS5RUH1nhpoWK9XYWk8afYPi1A8qAQvX4byXxiDCfTRkV/qidbAchEle83Ld+tfhRx
         TsHg==
X-Forwarded-Encrypted: i=1; AJvYcCWWG+xM+lN5U8XgJHB0kyO/+wElnz6F81RWn2GS6JjJQKmguIaqyPY7vchmKFIB0yFzRguwRcjEXl0V7XdR00G9VuCI23plrhLjxnaosiRyhmeQbkD/DxjgSSpSwyQPqjkGqfin2lCUtXgPsV+fQxWO5i2KfyQ32VoulAem9eDbpFXb/K0=
X-Gm-Message-State: AOJu0YzNfBaQkCHjm1s6JhZ4/noI0WVFteNpavIUZeXCS/6oFePpgzMx
	mv1UctrzK25DfTpZTANSoxV8OjFJGxylk310uMT8hUqH6V48/aI/
X-Google-Smtp-Source: AGHT+IGEMoqe2o0Xz2a6a6yOfbUF3sXOQkRfmkYWngYDiqILotwdaW0/E2vk4afYF6dmNcC/+r5fkw==
X-Received: by 2002:a17:903:1c3:b0:1e0:ed76:672d with SMTP id e3-20020a17090301c300b001e0ed76672dmr3262201plh.49.1711470344931;
        Tue, 26 Mar 2024 09:25:44 -0700 (PDT)
Received: from debian ([2601:641:300:14de:69a2:b1ff:1efd:f4a9])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001e0d70680acsm2649542plh.268.2024.03.26.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:25:44 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 26 Mar 2024 09:25:40 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Message-ID: <ZgL3BBojhyjxv82I@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:08PM -0700, Ira Weiny wrote:
> cxl_dpa_set_mode() checks the mode for validity two times, once outside
> of the DPA RW semaphore and again within.  The function is not in a
> critical path.  Prior to Dynamic Capacity the extra check was not much
> of an issue.  The addition of DC modes increases the complexity of
> the check.
> 
> Simplify the mode check before adding the more complex DC modes.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> Changes for v1:
> [iweiny: new patch]
> [Jonathan: based on getting rid of the loop in cxl_dpa_set_mode]
> [Jonathan: standardize on resource_size() == 0]
> ---
>  drivers/cxl/core/hdm.c | 45 ++++++++++++++++++---------------------------
>  1 file changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..66b8419fd0c3 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -411,44 +411,35 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
> -	int rc;
>  
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> +		return -EBUSY;
> +
> +	/*
> +	 * Check that the mode is supported by the current partition
> +	 * configuration
> +	 */
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
> +		if (!resource_size(&cxlds->ram_res)) {
> +			dev_dbg(dev, "no available ram capacity\n");
> +			return -ENXIO;
> +		}
> +		break;
>  	case CXL_DECODER_PMEM:
> +		if (!resource_size(&cxlds->pmem_res)) {
> +			dev_dbg(dev, "no available pmem capacity\n");
> +			return -ENXIO;
> +		}
>  		break;
>  	default:
>  		dev_dbg(dev, "unsupported mode: %d\n", mode);
>  		return -EINVAL;
>  	}
>  
> -	down_write(&cxl_dpa_rwsem);
> -	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Only allow modes that are supported by the current partition
> -	 * configuration
> -	 */
> -	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
> -		dev_dbg(dev, "no available pmem capacity\n");
> -		rc = -ENXIO;
> -		goto out;
> -	}
> -	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
> -		dev_dbg(dev, "no available ram capacity\n");
> -		rc = -ENXIO;
> -		goto out;
> -	}
> -
>  	cxled->mode = mode;
> -	rc = 0;
> -out:
> -	up_write(&cxl_dpa_rwsem);
> -
> -	return rc;
> +	return 0;
>  }
>  
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> 
> -- 
> 2.44.0
> 

