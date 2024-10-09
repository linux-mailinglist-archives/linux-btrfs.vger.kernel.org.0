Return-Path: <linux-btrfs+bounces-8745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8922F9973B6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 19:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB031F24537
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 17:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCBE1E1A36;
	Wed,  9 Oct 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqSiY4lT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DC1D318A;
	Wed,  9 Oct 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496046; cv=none; b=VOoAZuIGIvCidtBov95sQBBbcsUNamdYNmLFCousY3xCjyuJH2oraD1gDrfRVXcH714UNSTzF/kSgQFP0PXPErT75tkhKDnD3eDjZxX1sgbEQ10UG4wM0EBMFMGxBUPVmTfRFP3/PUrbjxhBWTC7x834EHfvvEQ/4iS0LgR03G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496046; c=relaxed/simple;
	bh=hrduq5hX72SJbr+Ep+RCPMEc9rDr01SBnYcCDcMmYbM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8CaJbgxzXYV2HyEhkiABRuqWc/0GCj2Typqi4ezlNfciP13jydUzICgVRNC0y0k0U7VTHYXU6lnNLUY8rTBTd8cyxCPNj7ErNieaCm9vuZ17IOySRI4qyRa2F7RKX0ejLx9/Q+/6cpvFIsVp/1E29oIF865NiGbfyiqV/VbHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqSiY4lT; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dde476d3dfso1127857b3.3;
        Wed, 09 Oct 2024 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496043; x=1729100843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UC1+s/+UBvzxoqZUG6QZubGws8xau17tsJaWekZSoEE=;
        b=gqSiY4lT/WpoYkClexk4gSxjYO66pCZ26pMyWFseAJxcEsGN/1iqRh+80f9R35eeX1
         Ei6TLD4d394N/H5DAgJI2eWMjcX32B9UwOX9/MsL+Zxvt4gtmMKctGTwXk2HgTj8iixd
         PUnD7MaEylOffSyThRHb3QMfywy6cX0R2kEbkx/8IbiYtKMfDTiO1LhYOWCX+aDC0NRq
         cEymwr1MJ92YEZgOtomtVww0U+Az+oSwNhIgEg8edZhVmlbD75cpKpCqJ0N1jVsIuUeu
         PBRl0eKdtKGjAsv2ovPQsMJdClFWhvNETKDVqbcMm4m1Q/Vsu9GjjRJ1qE4EqBOTa/dB
         3dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496043; x=1729100843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC1+s/+UBvzxoqZUG6QZubGws8xau17tsJaWekZSoEE=;
        b=KjiRVxJShlNWZgB16KNkBAn+bmAI/xaPFYkhPhIy38lRARgH9acxb4oY0QaMjZ9fNp
         YaBp98J45+OJmDG25qaxmc2W3Xx+VNTh+yopDvZ1T6wGpW7Y0a4S+cfcmodHHrAWstBQ
         PnhUpYpmMX9Am+ByzzkGinDMafPI4osHaxl+EA2KsvsZ2HQfEFGydIK2fnKVS5j87vLO
         hywERyjsRJpf/Wpv3MpjgDkiFYU+6pofmu11c1uUTg2fImJREzRVmf0/Q3dGXCgxYqTT
         IXUU1yl3LRc/ZoPQNWZ1qNt+lLg4WoE2GiZmRrbKp/zACAy+wPNs6qAd3KXrO2xhyM/2
         kBOw==
X-Forwarded-Encrypted: i=1; AJvYcCUqIQB21zH/+BsM89/2e0iWBExKDKi1Y3tuf59FOL23l/69XyJM2JhAueVijYV2yY1hm43sy6K9vYMBHg==@vger.kernel.org, AJvYcCUtC5DduCXuvLEQ1S56ETX8XoB3n1+L8BJcaIPTV7BtE6XCMMExdQkKUaaH/iOwigYvXOHNqsKHpdmk@vger.kernel.org, AJvYcCVdN00GtlgUMEalDJR6nvwB0qEeyjyXbh8qgUYv4l+ZCnQpG8XtRDNyGmi33j5wK76k5eXIfZL6fBsA@vger.kernel.org, AJvYcCX4jJV+9+fHzDyGnaMcOIP6TG2IMEE0V9RXWF/2dQHMiU7DFk2ftfYMtTMJ8NwylhSjS6AGRGfg5LMZKc90@vger.kernel.org
X-Gm-Message-State: AOJu0YxZFXfgnhbYFZdj2bf8ItzLzg5ZnRgiupo0Y4ucIU93fY/E1gxH
	hgW6vMf+fcF8jh4WO9Ol/Dk4nUi3oRB+PHMomD3prw0aYE4m/Ymm
X-Google-Smtp-Source: AGHT+IF7Ewv221Glscvu1OZcOfztkqBqsRZZI6mFeYxOjowv6x9OgIFXt36jk+9E6Y2K+UdD8DipVA==
X-Received: by 2002:a05:690c:6a05:b0:6e2:63e:f087 with SMTP id 00721157ae682-6e3221f8577mr35924477b3.42.1728496043387;
        Wed, 09 Oct 2024 10:47:23 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93f7d31sm19219847b3.135.2024.10.09.10.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:47:23 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 9 Oct 2024 10:47:20 -0700
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
Subject: Re: [PATCH v4 06/28] cxl/pci: Delay event buffer allocation
Message-ID: <ZwbBqNnKXfNMTGEF@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-6-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-6-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:12PM -0500, Ira Weiny wrote:
> The event buffer does not need to be allocated if something has failed in
> setting up event irq's.
> 
> In prep for adjusting event configuration for DCD events move the buffer
> allocation to the end of the event configuration.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> Changes:
> [iweiny: keep tags for early simple patch]
> [Davidlohr, Jonathan, djiang: move to beginning of series]
> 	[Dave feel free to pick this up if you like]
> ---
>  drivers/cxl/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 37164174b5fb..0ccd6fd98b9d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -764,10 +764,6 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  		return 0;
>  	}
>  
> -	rc = cxl_mem_alloc_event_buf(mds);
> -	if (rc)
> -		return rc;
> -
>  	rc = cxl_event_get_int_policy(mds, &policy);
>  	if (rc)
>  		return rc;
> @@ -781,6 +777,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  		return -EBUSY;
>  	}
>  
> +	rc = cxl_mem_alloc_event_buf(mds);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_event_irqsetup(mds);
>  	if (rc)
>  		return rc;
> 
> -- 
> 2.46.0
> 

-- 
Fan Ni

