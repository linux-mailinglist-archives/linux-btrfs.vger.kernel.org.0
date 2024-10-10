Return-Path: <linux-btrfs+bounces-8813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5C998D59
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 18:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0911F21E3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483481CEAD4;
	Thu, 10 Oct 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDuJwCz3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DF1CEAA2;
	Thu, 10 Oct 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577648; cv=none; b=CwacxO3uwn9wIoa3Riua6wbZqebZIzOv6MFxNfdg/uJhHcpPRkGFQLs7sYzpsMShr1Pcz490rpMKkeDR9/3Pz23pJQ7nFmtKWH5uHsQWtI6qrBLGuhVHLQ/kql0Xv1N5ewwA5vkvhLwXN6sNGicfRBrr8a4KCVZ6l3ACGPDLZjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577648; c=relaxed/simple;
	bh=EezNVeA2uyxOZbiJHcAoytd4T0u9uCuZE27/ZijVLTA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0/hhLaqj7VrLGKdB8TQeK1mGK6E/e8AzUmg0XE35UTDueItbHNBd0RB2bKoLXJVrjJ/EKB6vr32VBoDW8IHe3MJ6kdcOmrmLpAKL46U8fuOHOARhbX2LZ7UNSmIKdLTlNiPM9nKOhotXpeBksRrZpgBgfhUANpm+vq2+crt/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDuJwCz3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71de9e1f431so918664b3a.3;
        Thu, 10 Oct 2024 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728577645; x=1729182445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSLzl5yBihgiBmsYyY0ZLdSXzjCf12rYeXArERj6rDI=;
        b=lDuJwCz3N6IUynHgFPSSnuFU/R2IcSe4xFZaBIzyW5IZXF4sw8SCxsZAhwF89BPHf6
         XlL/tMGqiKnXboWlgWI3asRJeWWOnqW8t/fFhd/MX/Q7FgisVA1TPEKtvIsolTptH1V7
         gwLT/eTKjFEPvQlW/vSi2q76GD4b8ecnL+wViouknZJZGbGbI59dMdjTTbKKffTwENJt
         FyJzDH87vfq1Qe0sY6nY9MtU2NSbcn1EV5/VqnRRyoIprO9UbU6/ioQC3KfdZpBXytsa
         y5TXYbHjPUzerJRaVDT8eUlNtdUSZcE4SnUzudFsrwoPu3rvVDayNXx0u7ENFKHr33IF
         /bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728577645; x=1729182445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSLzl5yBihgiBmsYyY0ZLdSXzjCf12rYeXArERj6rDI=;
        b=ufUvFa0EEBMwELJGIWt0ASrioRlrZQx8YKmGS67HC34/Z/7XxCkRv+NdxGoeAf7z1Q
         dIxwWGbIOCtcMpajFyTOvaIod+0OSeXSVem5hUYSPHn5WeDm6WOLBIKSMqy7JO2E/Y3J
         peIpIrUTZfzEcbKZaAGIr5Ea8kicL5VrtwNRibaXAEFHL0oxDmx9OA6xtFWS07i6YZMY
         uFqMIyHDgMi0szdqUWKLQ72zjZRY3Hleq/WlUHF7U864+SCkLXF6HWshA6DaCNHLLAY2
         QbD21ojiEsL6k566RNU7i7+1RII6CenJQl1zwhQi0q5b1YVIia+pSY2ltbuI5JMfdtHO
         I/qA==
X-Forwarded-Encrypted: i=1; AJvYcCV4RnKIhRCM+Gy3l074rlOuPHzxEG9lajwqOFXxb2D+H4CnmxXRFVo0fTEXGBZbtDIjgdHTeqW04T8f@vger.kernel.org, AJvYcCW6Y6qCjiYL0hWYjxS+BVBUwReBl/zhMoeuz8Iu7RQjCeSuwKECJbKe7VRxxqOIkkyU9aZbE2elxcxiymNc@vger.kernel.org, AJvYcCWCPlE1XUuw6tJ2Y+Ur2hOWkYixJJJhSnNDkRi40XFkGg8v1/K+8c+4/+urXVMoMqKyQX6nUQrblPip@vger.kernel.org, AJvYcCX90iDcWlU5no+31lc8o+Tl+mim5ojdMXz4dvPPXrrNKbAmgb5alZGYaFUQhJvTtvzJdDCaq09AtFJTHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGn4vJZAXMBNnz7ybzekv+duil3/fgK+Mn1gSUOBAw6hjmuND9
	9Lv+7uJPdJAXuPTVaYOIVwccpC55N+AYrck3L9EwOfk5u5N0mn6JSI2y0w==
X-Google-Smtp-Source: AGHT+IGIsf4f/iQQgXnwF0falPkwr2nFCnUFSLBEZqjJbFXQB+jGFOTfXuGfIuYojsJ2HGj2GIYvYg==
X-Received: by 2002:a05:6a00:2e9e:b0:71e:2d2:1de4 with SMTP id d2e1a72fcca58-71e1db6485emr10418466b3a.3.1728577645027;
        Thu, 10 Oct 2024 09:27:25 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:c165:c800:4280:d79b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba3a7sm1200121b3a.169.2024.10.10.09.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 09:27:24 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 10 Oct 2024 09:27:03 -0700
To: Ira Weiny <ira.weiny@intel.com>
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
Subject: Re: [PATCH v4 15/28] cxl/region: Refactor common create region code
Message-ID: <ZwgAV81DSbpW7Ezd@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-15-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-15-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:21PM -0500, Ira Weiny wrote:
> create_pmem_region_store() and create_ram_region_store() are identical
> with the exception of the region mode.  With the addition of DC region
> mode this would end up being 3 copies of the same code.
> 
> Refactor create_pmem_region_store() and create_ram_region_store() to use
> a single common function to be used in subsequent DC code.
> 
> Suggested-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/region.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ab00203f285a..2ca6148d108c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2552,9 +2552,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
>  }
>  
> -static ssize_t create_pmem_region_store(struct device *dev,
> -					struct device_attribute *attr,
> -					const char *buf, size_t len)
> +static ssize_t create_region_store(struct device *dev, const char *buf,
> +				   size_t len, enum cxl_region_mode mode)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>  	struct cxl_region *cxlr;
> @@ -2564,31 +2563,26 @@ static ssize_t create_pmem_region_store(struct device *dev,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, CXL_REGION_PMEM, id);
> +	cxlr = __create_region(cxlrd, mode, id);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
>  	return len;
>  }
> +
> +static ssize_t create_pmem_region_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	return create_region_store(dev, buf, len, CXL_REGION_PMEM);
> +}
>  DEVICE_ATTR_RW(create_pmem_region);
>  
>  static ssize_t create_ram_region_store(struct device *dev,
>  				       struct device_attribute *attr,
>  				       const char *buf, size_t len)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> -	struct cxl_region *cxlr;
> -	int rc, id;
> -
> -	rc = sscanf(buf, "region%d\n", &id);
> -	if (rc != 1)
> -		return -EINVAL;
> -
> -	cxlr = __create_region(cxlrd, CXL_REGION_RAM, id);
> -	if (IS_ERR(cxlr))
> -		return PTR_ERR(cxlr);
> -
> -	return len;
> +	return create_region_store(dev, buf, len, CXL_REGION_RAM);
>  }
>  DEVICE_ATTR_RW(create_ram_region);
>  
> 
> -- 
> 2.46.0
> 

-- 
Fan Ni

