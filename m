Return-Path: <linux-btrfs+bounces-8820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4BE998F18
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 19:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C271F25D0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992CA19D083;
	Thu, 10 Oct 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJYdGDCo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6B19CD07;
	Thu, 10 Oct 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583144; cv=none; b=JvjQAM+ZMCVYLxXuE1UC95VYqhN8jsVljRThDW1moY30twwCaAKpAOMyHKO1MLVCQrkgz0PA2o2h1IXwIMeGh6eL88aNpNBkEvQ+9Voy6tb78JmyIkxJ+eTHR9O+y3rWzCvI5TJHiL32QHE+3UH9jVHaQTlCM5l1M5C7/ozy7Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583144; c=relaxed/simple;
	bh=Kge7wc2eVf7UslF+TD3gPb+FeB7D+a2MobjWWFDO3WA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP8h0sYLytWXWBbpXDUsE2cOx1prdfOtvPsJSwRr0AWhsjdGCAr/sSklRO73XzlMcBL/l6ln842wr0b2htUwx7o+Km4UfhcoyxH69x6hBoI2F095uFhhe6TpvsLohPKT6t7AHyzWpU6JA1QCwXH5dd9k0667/CK4xflcBo3Aks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJYdGDCo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b7259be6fso12959545ad.0;
        Thu, 10 Oct 2024 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728583143; x=1729187943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pjaq1ccy6Z8uwpI+HpuudFCkgY1TCeYNA3gLc2Vpidw=;
        b=YJYdGDCoT8voQXMVWvBmEFHBxTu2e6pYABtWOn0OAlW4UI03xgNWVCDQLxV2JSBsZU
         zQ1ZnlPE8Ix/koHON7JildJzYhchxpGWNQfRoywcF/qfaMDrm3HQiM+Uak1zwCI458lh
         c91SGSmE5GVTIRi0iruAsntfs05q6srPTKQCytWEcJeuukTOKgAmETIbVLLWLES659Iu
         XMyKOY5KiZbX+5CegTZN0v5Q3z2ued5m7vD620VHy/9i8WmR7jz6xS0G05AB1/M7oW4S
         OYOQ+AJZvH8OrvUQ1Qw/s26uONpdBGwEjsOb1HLDpqUKVwvSakgF+pI1UcnXsNSkNN/Q
         HUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583143; x=1729187943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pjaq1ccy6Z8uwpI+HpuudFCkgY1TCeYNA3gLc2Vpidw=;
        b=poKcsjn2BV2Q3M8DgSUcejyU/+fOtdeYZbA8O593hZ2O+ntCJEcT8yAxOAcT4fJmQn
         3SQvU2jkmF/J4QgChSR1nPyxDeot5X4YM6RNB5paHzjmgNc64o33TVdJpIDFqiw89rQ2
         SCkMPQffbkyZ3vZAOGM2nMaKXhdbL/6dFoogtVY5q/vfJSdWyofoxWnw5CSnAfRy3oaa
         nwo2Ux6JI2vv0QYJ3yW96IzgDo2bA9qnJ0TSzxJ4boJ5rhG2fq9CJ4nnzmcwV7S6reaN
         AkhZdpb7k6WQaXAu+gQ1AD2Tb+o7cZ7MDKhZfy75pLd7M2ZIizWBAZItwaYEHCKhY1Dn
         el8w==
X-Forwarded-Encrypted: i=1; AJvYcCUJZu7ozhBJb4SUx6e3qSrcDat42p2YHh2RhBron4EpbgGabLT+GsY5MQBlkkE/Slgi0AYQFQ0CJITV@vger.kernel.org, AJvYcCV/lbgsCHSGQtD9dm4hdt0bkb5tEmdMdUFnhr8UpX8HGkgSzcuk/9RooYNNHz1sp7aYZW1xQ1pvI0sgDg==@vger.kernel.org, AJvYcCXG97lEzg2JNob9GMPByXRkUccmtjg1FEIMQokypwCq1TlXMSPDXXNWiR6iIrwO4Q2gRv4h/VcHo6dc@vger.kernel.org, AJvYcCXbKR8D+3xaRmcY+cdxT3UMGbC41M2lyr+NP8ZypjwThS3Lt9wuhkI2PfB+FbQO8x70hmjhZAHyEi08wPx0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/MrQuxtUVkTDZ0yE5Sv5UrFnK+CABbsLa8vn1Dy5e1AEIbyoo
	w0ezYKVN9MdOl9T+cEwKTqPB7mhlawUqonA+nTVY6kDZpmPKLJ4+oQmirw==
X-Google-Smtp-Source: AGHT+IEyOee19JN6mF8IjynsdGZ4gyhcTytl8LOHNBi6Lt4Mwgsu9dLliHXMPgXybxOPTDtUxxBD0w==
X-Received: by 2002:a17:903:1208:b0:20c:70ab:b9c3 with SMTP id d9443c01a7336-20c9d8d2615mr5434325ad.34.1728583142564;
        Thu, 10 Oct 2024 10:59:02 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:c165:c800:4280:d79b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c340106sm11950045ad.265.2024.10.10.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:59:02 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 10 Oct 2024 10:58:56 -0700
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
Subject: Re: [PATCH v4 17/28] cxl/events: Split event msgnum configuration
 from irq setup
Message-ID: <ZwgV4D9NmcC-SAYQ@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-17-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-17-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:23PM -0500, Ira Weiny wrote:
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
One minor comment inline; otherwise

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/pci.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index fc5ab74448cc..29a863331bec 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -702,35 +702,31 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
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

There is a lot of duplicate code here, can we simplify it by
iteratting all setttings in cxl_event_interrrupt_policy like 

for setting in policy:
    rc = cxl_event_req_irq(cxlds, setting);
    if (rc) {
        ...
    }

For DCD, handle the setup separately afterwards.

Fan

> @@ -749,7 +745,7 @@ static bool cxl_event_int_is_fw(u8 setting)
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
> -	struct cxl_event_interrupt_policy policy;
> +	struct cxl_event_interrupt_policy policy = { 0 };
>  	int rc;
>  
>  	/*
> @@ -777,11 +773,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
> 2.46.0
> 

-- 
Fan Ni

