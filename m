Return-Path: <linux-btrfs+bounces-7416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED595C05F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 23:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F7F1C220E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2311D175A;
	Thu, 22 Aug 2024 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCEOvW2r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485918EB1;
	Thu, 22 Aug 2024 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724362871; cv=none; b=UZuIJEgFtd2wQ98xJvkOiY6friJpSEgpZkiKvfqwy8pbo8XCz9sU6VFiYnQjgdnh64HOuDLpDGioyy/8d3T1zpYw+9Efd1C7eYdWsbDeug8OiRu0t9OKLP2vi9/faA2WkSo5tdSf/OteGWE0HgRBRlgXzOyR2WmTpy0Ral0eOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724362871; c=relaxed/simple;
	bh=OY0Cw4jKHYyA2YTNmNjSXtMsaRpmLSV3pecbLOsimfU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8Tgor+qRhJD/+octBax2dwdhQaIcUQXDfepGWU9uASbru+1kvQ1p2X/Si524QHqB0f89Nbp7awfWSYJX0VsmJwQsE3fz1oW7tZrqQRKZHM9FA1d0Y12eBX2AgpJIWITtVsOItiYZXycobg5dQ6O90N0i3CshR1rPXPAbRTWb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCEOvW2r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20219a0fe4dso13418675ad.2;
        Thu, 22 Aug 2024 14:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724362869; x=1724967669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fefpIDiQsvmyVmJ9DTk9OrkozwCKfzpukO3kKB0G7io=;
        b=dCEOvW2rzl4DmfE1p+TJshEFPJvnzxJhja+dhWHpentCx8mgwQmY2q8ln6UHOM5JhH
         JaT5yhmqoY/5hve8b5ux27dgk0Dh2YVDo4D1ROlJWaP9rdxVYabWvtdkC2eo+6wP0v27
         oXXWs7oPZ0VwHxpHxuKVQJ1oClYtAsYzGewy0ZFH25ueZQgCwMkVT9OFHlVAWJIxyfYH
         gCg72+wX0yV02FxXQJ7kj9xZqKc4lIv5LlJAm+5NJqtDuBOp/6rGmmdljslfo7KMU2S/
         6U0pAQLuJV+EVB/5hhdwb2ve0hJWQs8ug5d8NJSrGOUuttjrIVKxIj2yIS2R3Eh0BMWP
         OL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724362869; x=1724967669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fefpIDiQsvmyVmJ9DTk9OrkozwCKfzpukO3kKB0G7io=;
        b=HTjTXCXqUJr2h6jp+u+0VhQ7WDafZpBrb5j2VDreZo0lYFIxxxyjU8Y8trmSVNVpFo
         rd0DKrwKqKJeNFMOrQv4eKZbrSfxIcjJlzhPggZ63dC8a40IQfyBmukHGBd+BloVtIM/
         IZx2bsjyuyoYI+kk3avU31ffeE4A6OHuzRbZosd9Ia+aQ0kTCaH+t6XDD69bagjqNAD0
         CvGu3EVcENfYBl5XHahUNO23VxmbobPQ/rKsupwOn15Br3ch8xny7WR0OCue/QguxKwI
         e4jDrWO/BdSe0C8SvHh2ODY7l+mvQY4vqzU6ZPqwAIM70RQF6uxixsh9/WXuewv2eFmJ
         Mdjg==
X-Forwarded-Encrypted: i=1; AJvYcCUU8y0PhB2E0la1mcklsP2G5SmuO3hJuwrR/ZHTRx6SzoEC1gx4p5fGdR+QgUQ91QR64XWWSbFhOd0Cc68C@vger.kernel.org, AJvYcCUZ2o/NkOZpxNFrVmQY1XOURe2vF8wZKIRaVxbXNL+2uraYBJk/QLmI9T9IvwLTpCSyeQEOLwsT3mbb@vger.kernel.org, AJvYcCVKazYZBGDpqyXnV7NNxxZ01bVe2xENEgYo1EJv2eigwowLJPxN7xSSYCmLiF8Nql/Ep2JlAVgyZID5@vger.kernel.org, AJvYcCXY8K1qdghlRdRZXfNx6G/BwkB2el05oZpPDtvHWqCyB0n6W2rTfo6E7BxDCqy4TLyXxgmdaG/j9NMYlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJh7/QJFB2CKPSuUo/p0TLgaPbHBKZQBwu2ggSOjXCAtYmLiVn
	H8TdTg/mJbOX8ecz2b+xPNnGpv0Gu7MWpOHmyKKuBHvIc0ekkxyL
X-Google-Smtp-Source: AGHT+IHCWUeOTFC/rJ8NysGSN8g7BvV82Pdq7JDaAlLehwEn9Kj+6aSkyw+tasX7G1339cnBWDepbA==
X-Received: by 2002:a17:902:d2d0:b0:1fd:8c25:415c with SMTP id d9443c01a7336-2039e4891ddmr1772985ad.24.1724362869331;
        Thu, 22 Aug 2024 14:41:09 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:3cd4:f45f:79d:1096])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038b7ebe0dsm14920535ad.287.2024.08.22.14.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 14:41:09 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 22 Aug 2024 14:41:05 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 15/25] cxl/pci: Factor out interrupt policy check
Message-ID: <Zsewcfl5alK4mvZS@fan>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-15-7c9b96cba6d7@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-dcd-type2-upstream-v3-15-7c9b96cba6d7@intel.com>

On Fri, Aug 16, 2024 at 09:44:23AM -0500, Ira Weiny wrote:
> Dynamic Capacity Devices (DCD) require event interrupts to process
> memory addition or removal.  BIOS may have control over non-DCD event
> processing.  DCD interrupt configuration needs to be separate from
> memory event interrupt configuration.
> 
> Factor out event interrupt setting validation.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> Changes:
> [iweiny: reword commit message]
> [iweiny: keep review tags on simple patch]
> ---
>  drivers/cxl/pci.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 17bea49bbf4d..370c74eae323 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -738,6 +738,21 @@ static bool cxl_event_int_is_fw(u8 setting)
>  	return mode == CXL_INT_FW;
>  }
>  
> +static bool cxl_event_validate_mem_policy(struct cxl_memdev_state *mds,
> +					  struct cxl_event_interrupt_policy *policy)
> +{
> +	if (cxl_event_int_is_fw(policy->info_settings) ||
> +	    cxl_event_int_is_fw(policy->warn_settings) ||
> +	    cxl_event_int_is_fw(policy->failure_settings) ||
> +	    cxl_event_int_is_fw(policy->fatal_settings)) {
> +		dev_err(mds->cxlds.dev,
> +			"FW still in control of Event Logs despite _OSC settings\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
> @@ -760,14 +775,8 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> -	if (cxl_event_int_is_fw(policy.info_settings) ||
> -	    cxl_event_int_is_fw(policy.warn_settings) ||
> -	    cxl_event_int_is_fw(policy.failure_settings) ||
> -	    cxl_event_int_is_fw(policy.fatal_settings)) {
> -		dev_err(mds->cxlds.dev,
> -			"FW still in control of Event Logs despite _OSC settings\n");
> +	if (!cxl_event_validate_mem_policy(mds, &policy))
>  		return -EBUSY;
> -	}
>  
>  	rc = cxl_event_config_msgnums(mds, &policy);
>  	if (rc)
> 
> -- 
> 2.45.2
> 

