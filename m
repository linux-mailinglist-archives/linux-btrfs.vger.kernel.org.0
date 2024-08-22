Return-Path: <linux-btrfs+bounces-7415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD0595C057
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 23:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E99285DE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 21:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAB01D1759;
	Thu, 22 Aug 2024 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyhLNEty"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824BAA933;
	Thu, 22 Aug 2024 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724362758; cv=none; b=SkVWiBTY2+wmnOd3ShkMB3Au+YBX9OBPlZ21IkZSg+DUsP2B/lZq5N+o62oc2IZjoD1Ja+9pucdDX8+q1Mwe9Ch/HeNhjFthXUIBNWU6uuWDKcwD31zYtL/uZlK+oxRudg5v/aOyXNvtop0N0CimEkqZpbZx1UDzOvCyxEaniE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724362758; c=relaxed/simple;
	bh=+39veRksgq9Q04CTRb52aRC0jGhyFgQuRQSLZwaTmY0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxD5KIE0AN1paqWTSlz73dgGxxXXVEc8135tHnEaNxBY3/qF41RLrPveBj7DZOCq9VTgwsk+H5Zj6o42I+9OnVX8mvqW7rMFhuEpJcUJTHbptiDDlTbU7tK375/+lad/UWiva/IoNAZtuAEBqJlW/wjuaI6+cKcwlMzS+YZyhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyhLNEty; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7bcf8077742so934014a12.0;
        Thu, 22 Aug 2024 14:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724362756; x=1724967556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4lapMsfxqEHGeVn8F/nOKzcEtprNP+KFTP6KpIca0dc=;
        b=IyhLNEtyWdoLCIRIGv/+8iLplWqiyB8kgODtehKAgLGoLfTcMUfC9N/nx69Fgizws9
         95sVkads7Di/CGo1sKkistOmgM4h7oQteZ44DhMAwWoCvpWm7LSVfV8u1c3Hqp+5HCIk
         LqTp2L9vCjwTYqerIxydIR9HidBMdbjGHnsdnGKM7Zir0pHxwgl/9ZVwSYUSHqASGxbP
         H16nq551WfAXYJYDaqfiemvSqyhZWBkNiZB0hSRhfOZ3zhBAMjrTeQrzM/oCIkygC91u
         Tpgds3uuRzcn/7jUJeacpZsZzZH+cbLlOxnQbVzK5VXNOHb/VP87gNZRLXVbtkcqwZql
         IAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724362756; x=1724967556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lapMsfxqEHGeVn8F/nOKzcEtprNP+KFTP6KpIca0dc=;
        b=oIzJiauqsh3upcsKd3Si+MzhjObiyDF90tjzdPL3Q0IVeCoP7iG7l6D++6cVqqE1MF
         OQv88QJmENpvjj4pr3hPEbtKmE4zcOMAW/3C+lOg61jeS7AsG/6Wr+QMIaU1u58eVm13
         8nvwzKn46NDOeo8s+Pa9Qsxhf10ScHuQj89fYRJYSy5l7+ACWwZFNHRqmRnfvDyQsjzl
         SCqLtinJfkWDZi87haJbC/2TPOBXuZ3S8EShiaiLpb8ne4sLxhxvygNULCa1pOHFZoM2
         0tvtWAKe2CcIlA0bQXPDsuJyf+Y7Rt6Kux/GEodShc7nEuWHsqpF5aDpWyzs2Ja1s9TS
         q0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVxszB6yxUOMXikt+d814EX9je2k2lm4qKEX/NpuMgpITBEk3FhQY+LmXRG89420KJVhy2N/v4Ra8gq@vger.kernel.org, AJvYcCWP1YGtLFQ+qCXho1IPr+W3U5k6x0YsmD4FxKHanntRJoLyyRy/waUzMRYdizPvHIBQWEAVCoZTu61LSEz5@vger.kernel.org, AJvYcCXIe/Kqbr+NZi7RHIQs9wBQmnwXzbN6DGfInM+JjuhSzh4JEebT/fH0PA/uMVyOY7oI4rF/fJ8YPnLo5w==@vger.kernel.org, AJvYcCXud81Ik1puSbhcZRs6L/NLuvML9ohPtD7Wxrhisr9stW90TG7M+0rZRYhZhWFzS8IIG9In9J1qdujZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzPd942kkeztXTkMAlRghvmBkRFiIgoAWQwuvg9W6AKm0iwmAGz
	bWK77Er5CTNX0IxzPT6f0A2pR5ZOlONkdHpn/6i9LUl1bMo9dEwE
X-Google-Smtp-Source: AGHT+IEOtp11CIsD6bvJ9HhdPD7yo7y8zut7NgWkbt/YY3g8PaQOXy2xj43HqtE9c5QlyIIaVo8m0A==
X-Received: by 2002:a05:6a20:2d13:b0:1c6:ed5e:24f with SMTP id adf61e73a8af0-1cc89d7dde9mr472696637.23.1724362755692;
        Thu, 22 Aug 2024 14:39:15 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:3cd4:f45f:79d:1096])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343405f6sm1822047b3a.186.2024.08.22.14.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 14:39:15 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 22 Aug 2024 14:39:12 -0700
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
Subject: Re: [PATCH v3 14/25] cxl/events: Split event msgnum configuration
 from irq setup
Message-ID: <ZsewAA6VxM4U4inw@fan>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-14-7c9b96cba6d7@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-dcd-type2-upstream-v3-14-7c9b96cba6d7@intel.com>

On Fri, Aug 16, 2024 at 09:44:22AM -0500, Ira Weiny wrote:
> Dynamic Capacity Devices (DCD) require event interrupts to process
> memory addition or removal.  BIOS may have control over non-DCD event
> processing.  DCD interrupt configuration needs to be separate from
> memory event interrupt configuration.
> 
> Split cxl_event_config_msgnums() from irq setup in preparation for
> separate DCD interrupts configuration.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/pci.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f7f03599bc83..17bea49bbf4d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -698,35 +698,31 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  	return cxl_event_get_int_policy(mds, policy);
>  }
>  
> -static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
> +static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
> +			      struct cxl_event_interrupt_policy *policy)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
> -	struct cxl_event_interrupt_policy policy;
>  	int rc;
>  
> -	rc = cxl_event_config_msgnums(mds, &policy);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_event_req_irq(cxlds, policy.info_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->info_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
>  		return rc;
>  	}
>  
> -	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->warn_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
>  		return rc;
>  	}
>  
> -	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->failure_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
>  		return rc;
>  	}
>  
> -	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->fatal_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
>  		return rc;
> @@ -745,7 +741,7 @@ static bool cxl_event_int_is_fw(u8 setting)
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
> -	struct cxl_event_interrupt_policy policy;
> +	struct cxl_event_interrupt_policy policy = { 0 };
>  	int rc;
>  
>  	/*
> @@ -773,11 +769,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  		return -EBUSY;
>  	}
>  
> +	rc = cxl_event_config_msgnums(mds, &policy);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_mem_alloc_event_buf(mds);
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_event_irqsetup(mds);
> +	rc = cxl_event_irqsetup(mds, &policy);
>  	if (rc)
>  		return rc;
>  
> 
> -- 
> 2.45.2
> 

