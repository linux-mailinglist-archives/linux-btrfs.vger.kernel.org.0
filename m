Return-Path: <linux-btrfs+bounces-8821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB376998F6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 20:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456871F25FBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 18:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DB81E47A7;
	Thu, 10 Oct 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8teAtA1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B841E379F;
	Thu, 10 Oct 2024 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583634; cv=none; b=VTkl7hwtfKIfpf6wriZYVRkoLmPXvOYmKNOTZX/VqGSetgGvmJs+Gu9nYmY3NMCIP+FjJC4UAbVsB3dKNvLgX6IvNSvraHklrNZ53gQ8s2jmP6fZawh1zAhDzBuJ3q9xie5/PfwIpErAZbQOxjFpaRrVblWpo43POcJJvWwbPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583634; c=relaxed/simple;
	bh=cxG+YNl+v9iEpZmHv73E0r3KZfsBXIVJgAGWTwlWd8E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzJMVc3VajOoGa/bChGL1QR4E6fCPBH0WVpro95QPsteAeFJl6Abx+hHJ0FsmFKIzX/WNPFmTgowzu16EZ3u8xyYjGJwkPBBqF2zq+iK/SrOrMhT6y9/zlwFQu6Yzjnj+GllKzTWz4nVRn7AdWpWZR4jfBurb0qcAOqBsOVM1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8teAtA1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e0cd1f3b6so993513b3a.0;
        Thu, 10 Oct 2024 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728583632; x=1729188432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJrjmdMI96zPiPqng8kU9+m7/MaNtEw4rEx+JduNOGM=;
        b=M8teAtA16WgNPN5webbAUs98e7Liu9bCjxwQclZ3c1m3eYmsASwY5kPZARPgxvlOi6
         UFTolg3BVA8qdiR5NvYBS4NfEdEWwo5DT7XfE2hNgY8a9G9cIT21AYAwDwBBfgfhca0r
         cEDGv1TYvKKs71X5z3lL9kudh0a4WoKYe5oqfpPkvOUgRrJUOI7UD+6rNSpUiEQr64ev
         eYwPq+xulw4ON8/3MLE0jwKNhLZXtN+DIEhkPvZnL9YNLcvnuF/dHpIjOEr9MR5Oxz+W
         UbSX6K8PCVdaBHl1pu1B1PbFdbHR7JNI4Nf6+tU2XB/egQavRCzlxxsy5t6DP+awu7sS
         O++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583632; x=1729188432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJrjmdMI96zPiPqng8kU9+m7/MaNtEw4rEx+JduNOGM=;
        b=Rig6OJUQVglEbbtcS/IJSi+0y4vzny5sILHgtg1ICKsaLS3eEc0vjWrm2TXJbom41B
         ZJyxbedoCmjmed7BNM0qi5M3AQy7ss257N6o7okK2ebUd6XQm4tbxkavgDJDZmZQ1c++
         1CQTt8WdicAC6/GqzXstZc7ycsgPE4DsHH9lLmICvtlxl/kNEVLUrLlVGHuX5VMahNZd
         EgyniZWhC8L/y/obvYizaBNgiEdHLTXQUstAv3jcWlm2RcQhdAS/wzcRzGBm/vVa0V1n
         rfGQWp73tDT/qj2h4vs1RUr/swo9LM6dNq/B2ljH9glEgHEa+Pb7uZ/o8WvGcxj3hGED
         GbZg==
X-Forwarded-Encrypted: i=1; AJvYcCV+3TVDftcbsmug1wWzFkikMH+AmFdzrrt0AXFTPOgN1E8xGCIIJMlQ3ZYtlgn3WK2E2JCwuHnkfqrT@vger.kernel.org, AJvYcCVnZTq5Itt2r2HcaJ+wg2f1qA2FsCJHnNVEWd1NmttyGuRWhs5DUyZ1RLk8WvbEJgz+QysI7+7+xSU/@vger.kernel.org, AJvYcCWnpqeuYdGOyhIqX9UMi2XABRjTPijCO9Bxss5Qm4+KZTAMFbSsMG/VokQf6LneaQKpWcUqwZ134ZwazXr2@vger.kernel.org, AJvYcCXfqiFA3KqBGM16ziaOyTazro7/Yj9d8POSuE9cE99tebFIX6+qua6zP2s8imOK99MQa5JHWRIQu7CuZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzguAHtShH3GhMNhgpjTEwMNHPpb9Tesb7kzx8tTg4bQRbk4fxk
	qVMeIgNU1oK/f6vqoCprec5u5sz9SsVD3PN4BrL1aPUpxZuSPhW+
X-Google-Smtp-Source: AGHT+IEjAcQXROm73I8kzCjIfwzpA2mw6XHOqLkD8N3Qu45MZeHc2xU90RHnBEIvm8wQO7RYA0ZqHQ==
X-Received: by 2002:a05:6a00:3cd3:b0:71d:fb83:6301 with SMTP id d2e1a72fcca58-71e1db878d0mr10326087b3a.16.1728583631847;
        Thu, 10 Oct 2024 11:07:11 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:c165:c800:4280:d79b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa0ccd4sm1341853b3a.93.2024.10.10.11.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:07:11 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 10 Oct 2024 11:07:08 -0700
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
Subject: Re: [PATCH v4 18/28] cxl/pci: Factor out interrupt policy check
Message-ID: <ZwgXzOwhryyyaEds@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-18-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-18-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:24PM -0500, Ira Weiny wrote:
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
> index 29a863331bec..c6042db0653d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -742,6 +742,21 @@ static bool cxl_event_int_is_fw(u8 setting)
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
> @@ -764,14 +779,8 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
> 2.46.0
> 

-- 
Fan Ni

