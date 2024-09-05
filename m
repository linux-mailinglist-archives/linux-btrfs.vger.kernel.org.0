Return-Path: <linux-btrfs+bounces-7866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4725696E363
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 21:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654111C241B3
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF540192B6B;
	Thu,  5 Sep 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZLrYLIk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E4188017;
	Thu,  5 Sep 2024 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565486; cv=none; b=Qf9luHs4IEE/TN0h/4cmKjdSN2Erx3sojrZp2oLzdlb+1WmSYaMc2VMP/DPp7DVhYnmYp8Ihkpg8pWej8M+x/agDnd40v8jm80x6IaP4rJurM3NeJjImwz6h6J9WDSkVtQveiDCMJFXiK4EmAUHL/UQGkAlNvAmOKkAhGmM2nQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565486; c=relaxed/simple;
	bh=fue0HDW/3+IS1tus8cXU1jw98GqL1Ym+HsM/Iofut+Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzPj44pxwdrt2Fs0QN1/zXKV/CYokSkqfxjxs2V7Oq/hybjHtrw087wKxpFAKV7zZeV+dfUft9u8JpAGXDoRDcmTduq5seOzs549RB0KRCEImwQTMlzUsCL4BVN97FI5oZIrEN/wcOhe2cd2SCLoWd46VQUu1/ZlnfTT+2qBb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZLrYLIk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-715abede256so1016517b3a.3;
        Thu, 05 Sep 2024 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725565485; x=1726170285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8blKARCK9hIi8qeqcpQY8FMcJR6skaNK4+MKzRO1q9A=;
        b=kZLrYLIkKkmzr/7siKqbfXf3gjohD1PsZ121BTwVhtQegYgmQ1rVY7t3r6F83xmHsD
         tf88rQWzgni/Z6cuEgx9PMSbwY0UOhndaOo5En0lW64OD7vnN+3xiNmf8V58TFFxpcdf
         hbEiQbN1WBoNx1UTcnw8pUtY0rcFBwEOkQeEFeZKMbrfXHG24YWwDWbSIe8Nt2ja9iWC
         zstKL8WJ19lSESDemqzZ7WMTNgZCnKolsqRyBH29SJG9HY2blX6YSBJ8hVY9BgLOARn5
         dOOGJfXpIu9gzzCsPHL0P1vmpeYMBX+2Jd0oHgNFcrKZxndKiYcits+OO+tRSmDmLI1L
         z7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565485; x=1726170285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8blKARCK9hIi8qeqcpQY8FMcJR6skaNK4+MKzRO1q9A=;
        b=Hl16CtTXI0MnADQGJ+k2x+31xgSEtogkBpwSysNqCA7ykqHUkWLHGnnf+4EigMAm4t
         T6ZwQMx6cYX+hHqvLNkoTvfaf/930l1AWkgoY2wmnw7mmu6/ATWdfT+7z+fb4P/AMaCc
         aB4+3g9ohG9IOiKflbAit31n2PWIRp5379AmM+tCQzHhx9tApK5oyIxVzMiibswdp+8V
         hHq0SPrvdhmDcxleB0BhulE2fcmObCPOpE/PSFxbtsgcGVBU24qZ/rtW3ziMsQ0/t1QJ
         Rrwy33VtO1n5OFXVZOeALqF0yI04F2h7VnM2LORtFfBLgbXYuPOh2UJtPqbbta+cxix4
         t69Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2lasIu6KmawZ6qDSrD7JKtxtmuWfKmrYTX8CvNe1Wq+O/SdO5l5R+NtrLQI/P5EVd0ulilDhy9ujAC5Bw@vger.kernel.org, AJvYcCUTOoWXZ/DcoeLZLINop19eunSZL/n2TgzCOAI7xgK2BXzbN5plgdmIIDbMKibWcsiHAnxSbZ5/WSi/@vger.kernel.org, AJvYcCV/jQRR9tt0n/+COjQW4JDEKEefO6DtyU54DINl4xFQXcPNpH8fPqgSB7f2kUUNS5ebJvvTB+RHv2VA@vger.kernel.org, AJvYcCV9x6ndcRcBOiOexqycY/164CmCeBBqBmPP/ws4YJfCCvqJzxEa+i0ibPPhKazeqWRjSQHb9j6YOwDEBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8aGscXD9uYSQxlaB444qqVlP51jHfcayl/ZpZgNksdP1CEvq
	MRn9CwakN3Ky75P0tf6B6xo+lo4unV4nSg/xCkZv/peLVu3+hybw
X-Google-Smtp-Source: AGHT+IH4+fX/yHmOeAuqwoSbrIHi2omPpjNgufLcJxCjb0muDVPuPNm2103Rdbup4SGV09v81le2FA==
X-Received: by 2002:a05:6300:44:b0:1ce:ebb7:dcb8 with SMTP id adf61e73a8af0-1cf1d05864amr60468637.3.1725565484771;
        Thu, 05 Sep 2024 12:44:44 -0700 (PDT)
Received: from leg ([2601:646:8f03:9fee:1d73:7db5:2b4a:dfdd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7178e39a188sm1473548b3a.219.2024.09.05.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:44:44 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 5 Sep 2024 12:44:24 -0700
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
Subject: Re: [PATCH v3 04/25] cxl/pci: Delay event buffer allocation
Message-ID: <ZtoKGEEhNHByhXyw@leg>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-4-7c9b96cba6d7@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-dcd-type2-upstream-v3-4-7c9b96cba6d7@intel.com>

On Fri, Aug 16, 2024 at 09:44:12AM -0500, Ira Weiny wrote:
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
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> Changes:
> [iweiny: keep tags for early simple patch]
> [Davidlohr, Jonathan, djiang: move to beginning of series]
> 	[Dave feel free to pick this up if you like]
> ---
>  drivers/cxl/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4be35dc22202..3a60cd66263e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -760,10 +760,6 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
> @@ -777,6 +773,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
> 2.45.2
> 

