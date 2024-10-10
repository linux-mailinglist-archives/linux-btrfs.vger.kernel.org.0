Return-Path: <linux-btrfs+bounces-8823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBF0999153
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 20:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0001C2069E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215981CEADF;
	Thu, 10 Oct 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIcJKWGv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017F1E8853;
	Thu, 10 Oct 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585002; cv=none; b=RCAW+Xe+w5JiEk1IkSJ2whZUnre/5tQtb4ivj3gG6XSBpfW232y0K3zZ9HuCIPRz+YCPiWe0DSACR+K3iE3/+17BBpl4DN7AkZqNjMTV+DbAyQviecNgrpILJk6kRdJuoJhowdG2CMMyCJMiisjoQVdKubx2ZeeWUGR74XGFwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585002; c=relaxed/simple;
	bh=ATlE5iF1D+i8hM107h56WYkiC3V5Vr7ynZaWhizuKOg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiCbQEx9P9p5AQuu8MkXBAqQCAde3jUwtz52n8vBZ7FORpqYRuZyAt7u50ZMNGFOCaTSeizYXyvjl08sATmRA37GAWRYyie/NR14fwB9G9d79OmGiIVBPgVg2I+6cy7Nuuj6umsl/cN9LMmbtraaViWE/mj+sceZV5Nwf1BlcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIcJKWGv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so976989a91.2;
        Thu, 10 Oct 2024 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728585000; x=1729189800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YimOy7qc5N+LKT23Y0mjrXB82RJNkHep3WQxQZ801rM=;
        b=jIcJKWGvvqgcE6XaiGb2TYsaIKf0uIgJilCQDBZJPubeZm8kK0/QOgQnxSY6/0J4nR
         bX0hoLnwX5Qrf+xrlFHE+Yiis011tWchK+//WItXmdanuvXEiHgtBEkrT2mbZeOMm4K5
         DAGHARcxHoDv9LcMl7Z0LNztmUNBEDf5599hIpJRRVGOAC8OmQ6LczyqMFaOsGppF39T
         VLOz1KJzqrStxTywgQ3FTVKW7luPPeuXjUF+lopYSGc7m1HdLBMupk/rzNklUeQix8SA
         tZb1jC52n7cjo/G/4YqRoI0qt73Po/1O1Cm+yTUxUHUTGMXEkYrwlpe+/eWluhwuCYzf
         JhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728585000; x=1729189800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YimOy7qc5N+LKT23Y0mjrXB82RJNkHep3WQxQZ801rM=;
        b=JeE6KDf7RG6RH4l1QWUaWfyLYeijdrxKcqDoX7KEk5cySCDf5uYMCyV7WV+y2s6qfD
         slOIh8uEgnE1sPsyXfT4rI77YoCYJTb0T+nR6S0tffU5pvLvtZkGz5xLREcUVF5Comsz
         ZOH4HMW9S+dCu5FTvbtzpSbpg41FXJq3l55k7QBqRzLjV2LrK2ZafbLUs9uVfLNK9GgW
         05cjAgUg7fKZLm4jKTnwn9AaxF2UlrdozLlSVUGiuKfDb+zXqmDpm8bYVtNv6h1tlDoo
         MklB2Bi/METzIexNQ1s/k8xPfUYENqthUdCChS34wst7Ttb+8yX6XocWFhQKEXFFUdzD
         QbKw==
X-Forwarded-Encrypted: i=1; AJvYcCURNXdQLRam5ekckcP9kkTZJT+b4dZoE/iisCshXmLCpfC3UaaoCQYEAuzDeJytXIZoChe2Xgu0Ie5U@vger.kernel.org, AJvYcCWtXKNITvoDI/oDnfTiFoi887LKGNoYGw7L+N6MqXho/k2Nb2xsc729gj8y6zWZbpmE2avwl1tZAFP1@vger.kernel.org, AJvYcCX/4CnMSiDEAKKbbukXXMRsSmSU+NjlvSsMAclGq3Nil8qUNBD5p62ebehJ0C8jVdE3xzPIxTIV0MV7Lfrs@vger.kernel.org, AJvYcCXmn/hQYYWAsf9T/a+SBwbcUJ3arD9aCgLc+e8DyjbiiOLTaMxybd7Q8ZiGOnCpqAgavtpW61oBFIb4fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp06wyMdMr1CwQje6WdkC3bvpVT+T9CDw4lmA42bdr/z4P95cm
	sptp0V7aoBPFE3gxQ1iLIyKPEq/xng/MJlqRsHRvp5d5IHEbZDYs
X-Google-Smtp-Source: AGHT+IGZrKnj1WJs8nsWKq4t5Jq9tMpObwNCDHwnSBub3/8G7+C0G8eVp4m92pO5SYGehe8jLGH2yg==
X-Received: by 2002:a17:90a:fd0a:b0:2e2:b211:a4da with SMTP id 98e67ed59e1d1-2e2f0a710fcmr118697a91.14.1728585000069;
        Thu, 10 Oct 2024 11:30:00 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:c165:c800:4280:d79b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f0a4edsm1662161a91.31.2024.10.10.11.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:29:59 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 10 Oct 2024 11:29:56 -0700
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
Subject: Re: [PATCH v4 20/28] cxl/core: Return endpoint decoder information
 from region search
Message-ID: <ZwgdJC8bSxfJuRuR@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-20-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-20-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:26PM -0500, Ira Weiny wrote:
> cxl_dpa_to_region() finds the region from a <DPA, device> tuple.
> The search involves finding the device endpoint decoder as well.
> 
> Dynamic capacity extent processing uses the endpoint decoder HPA
> information to calculate the HPA offset.  In addition, well behaved
> extents should be contained within an endpoint decoder.
> 
> Return the endpoint decoder found to be used in subsequent DCD code.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  drivers/cxl/core/core.h   | 6 ++++--
>  drivers/cxl/core/mbox.c   | 2 +-
>  drivers/cxl/core/memdev.c | 4 ++--
>  drivers/cxl/core/region.c | 8 +++++++-
>  4 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 5d6fe7ab0a78..94ee06cfbdca 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -39,7 +39,8 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
>  int cxl_get_poison_by_endpoint(struct cxl_port *port);
> -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
> +struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
> +				     struct cxl_endpoint_decoder **cxled);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
>  
> @@ -50,7 +51,8 @@ static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
>  	return ULLONG_MAX;
>  }
>  static inline
> -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
> +struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
> +				     struct cxl_endpoint_decoder **cxled)
>  {
>  	return NULL;
>  }
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3ba465823564..584d7d282a97 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -916,7 +916,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		guard(rwsem_read)(&cxl_dpa_rwsem);
>  
>  		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
> -		cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +		cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
>  		if (cxlr)
>  			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
>  
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 2565b10a769c..31872c03006b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -313,7 +313,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (rc)
>  		goto out;
>  
> -	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +	cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
>  	if (cxlr)
>  		dev_warn_once(cxl_mbox->host,
>  			      "poison inject dpa:%#llx region: %s\n", dpa,
> @@ -377,7 +377,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (rc)
>  		goto out;
>  
> -	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +	cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
>  	if (cxlr)
>  		dev_warn_once(cxl_mbox->host,
>  			      "poison clear dpa:%#llx region: %s\n", dpa,
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 34a6f447e75b..a0c181cc33e4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2827,6 +2827,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  struct cxl_dpa_to_region_context {
>  	struct cxl_region *cxlr;
>  	u64 dpa;
> +	struct cxl_endpoint_decoder *cxled;
>  };
>  
>  static int __cxl_dpa_to_region(struct device *dev, void *arg)
> @@ -2860,11 +2861,13 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
>  			dev_name(dev));
>  
>  	ctx->cxlr = cxlr;
> +	ctx->cxled = cxled;
>  
>  	return 1;
>  }
>  
> -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
> +struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
> +				     struct cxl_endpoint_decoder **cxled)
>  {
>  	struct cxl_dpa_to_region_context ctx;
>  	struct cxl_port *port;
> @@ -2876,6 +2879,9 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
>  	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
>  		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
>  
> +	if (cxled)
> +		*cxled = ctx.cxled;
> +
>  	return ctx.cxlr;
>  }
>  
> 
> -- 
> 2.46.0
> 

-- 
Fan Ni

