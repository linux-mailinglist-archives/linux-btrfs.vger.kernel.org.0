Return-Path: <linux-btrfs+bounces-3610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D799888C8D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 17:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764A4B23CF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 16:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A373913C9D4;
	Tue, 26 Mar 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M240uKMo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D292FC0E;
	Tue, 26 Mar 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469839; cv=none; b=EDUyzLkS+CTaAGReUTvT2X/8kNE8MVQZzT7b9rqiR4one6ZTuhSxwRhxhbyEOrdIbzCQ2koGokrzO8wgXgDetsOday+2zVC5x+xJLqor9HyR+WOkI6OGAcV16RsmL/AGTtSZkOcDPfaVEZBDngYFYUOHO/lk+dJAEZAwgxi0qAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469839; c=relaxed/simple;
	bh=v+x+wIzt9WoMwClOTOi85a6vxjpW1ve14tDBOfs979k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBvs+w19KAHC1HpaKC3CUHGAj7hvxqeFKLXdstpdHp1RVVrY/ZH0463JzvsalDoly9BNy/U3pyFajnzDOmiNRahQKaDQEnqHpVFI4DQvQTHD/cQ9URrZyLNMN1KjLYxTZ1qtC8XQkRxL/GUUpOyANatEKaI67sEW1vWqZ74zYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M240uKMo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6b6f86975so3653451b3a.1;
        Tue, 26 Mar 2024 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711469838; x=1712074638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkGrsiL0PGhtupH/pRTPQX22cb/ucEuifyohzZbt/i8=;
        b=M240uKMopkR42gVN6GK0EmQa+tWSprDbxaQhvlnC71KS6xtd1mtzo1RPXfdHbLe/C6
         GB8m+JvSdDTGZGTTigscN92KCwxyj58mRwFyiTP/72eKqmsuJ2ZvFgXrDZVASP1DNJkM
         WtKSGoS38ZQezNmq14Z0QkyiElJzmB/bOQqst64zKLNHpFFw/9jZe5gxPvkgLfVuqn/e
         AdEypghPPSwEpf+V5Tm0kkJMzpGNVVeEjDgKaa4nKLY2bNGNNx2n9NFrgH0lDIv2jn2n
         Z9t5drvG3yEZvd556J4HokNRaj/vQRuoW9mmhMNQgBIcBYHpMhNLpGrM57ITU91J4zOe
         Gntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469838; x=1712074638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkGrsiL0PGhtupH/pRTPQX22cb/ucEuifyohzZbt/i8=;
        b=IWTVgnbKnTvPLK32pEk5xdhBX8z60tbENTPfLtQDzMhJadI5qAagYinv+hngmGgW7W
         YMn99ygb/3CySRt14awPnexWZTeL+PN2WHvXhqXsftj24es3EcHPEuNLV/MCgnKJPGP5
         RO2Y1NR3tdM0UbgWR1kJUtRc8PUyeTJlaGcciYggBnK6Rw4p73Qg/WZZgF09VEcNZ/D7
         fzrHh8AZ8838aGA3r7Ccp7Rs/1wcV+WY6gnRYQaiQpHjQ33i51OaEJl+ZWmXUNSqmerA
         E32JQSCFc4IhuCUtTLuHqtk6blYXqnoJdrgBC/xfIf2dW+J0AARJrSiQ/CmCzzDJ6y27
         6ZfA==
X-Forwarded-Encrypted: i=1; AJvYcCV/R4TDVEChW0KpTgNRkI9KKw1WNsV+BPqOGJ+mbIP+NXSPl2j4JCpXwbSphBFQqC0D2YcTwJwpC8W2EeoJElisMDUe34rO9TV9lRepK8skG9HJho/BN8+PxY9cVO8ZAkhoT59MPLB6GB12+O+OlAiHTEy6xQpXOY6yH3zhWGQkzaudXlw=
X-Gm-Message-State: AOJu0Ywe5KGs4ZqbVCX5GJC48jF3XVqFk4Y94Y5dwpQYsCwNvuFBppU9
	lwIPf2STD1Bo4qZNY9Kz46KoTwx/nIuLuEQ2EJWBAtALTGpgtJH5
X-Google-Smtp-Source: AGHT+IGvMT+T8wid1bYGF1iIVxBvSebpxFFTKK1GulfUHh66T+GzKie0K382YfbIrosD1nZcHoPgnA==
X-Received: by 2002:a05:6a00:883:b0:6ea:92a7:fb82 with SMTP id q3-20020a056a00088300b006ea92a7fb82mr1884116pfj.27.1711469837696;
        Tue, 26 Mar 2024 09:17:17 -0700 (PDT)
Received: from debian ([2601:641:300:14de:69a2:b1ff:1efd:f4a9])
        by smtp.gmail.com with ESMTPSA id o29-20020a637e5d000000b005dc816b2369sm7679751pgn.28.2024.03.26.09.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:17:17 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 26 Mar 2024 09:17:10 -0700
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
Subject: Re: [PATCH 04/26] cxl/region: Add dynamic capacity decoder and
 region modes
Message-ID: <ZgL1BkFwq5hRyKji@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-4-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-4-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:07PM -0700, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Region mode must reflect a general dynamic capacity type which is
> associated with a specific Dynamic Capacity (DC) partitions in each
s/partitions/partition/

Otherwise,

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> device decoder within the region.  DC partitions are also know as DC
> regions per CXL 3.1.
> 
> Decoder mode reflects a specific DC partition.
> 
> Define the new modes to use in subsequent patches and the helper
> functions required to make the association between these new modes.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes for v1
> [iweiny: split out from: Add dynamic capacity cxl region support.]
> ---
>  drivers/cxl/core/region.c |  4 ++++
>  drivers/cxl/cxl.h         | 23 +++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1723d17f121e..ec3b8c6948e9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1690,6 +1690,8 @@ static bool cxl_modes_compatible(enum cxl_region_mode rmode,
>  		return true;
>  	if (rmode == CXL_REGION_PMEM && dmode == CXL_DECODER_PMEM)
>  		return true;
> +	if (rmode == CXL_REGION_DC && cxl_decoder_mode_is_dc(dmode))
> +		return true;
>  
>  	return false;
>  }
> @@ -2824,6 +2826,8 @@ cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
>  		return CXL_REGION_RAM;
>  	case CXL_DECODER_PMEM:
>  		return CXL_REGION_PMEM;
> +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> +		return CXL_REGION_DC;
>  	case CXL_DECODER_MIXED:
>  	default:
>  		return CXL_REGION_MIXED;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9a0cce1e6fca..3b8935089c0c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -365,6 +365,14 @@ enum cxl_decoder_mode {
>  	CXL_DECODER_NONE,
>  	CXL_DECODER_RAM,
>  	CXL_DECODER_PMEM,
> +	CXL_DECODER_DC0,
> +	CXL_DECODER_DC1,
> +	CXL_DECODER_DC2,
> +	CXL_DECODER_DC3,
> +	CXL_DECODER_DC4,
> +	CXL_DECODER_DC5,
> +	CXL_DECODER_DC6,
> +	CXL_DECODER_DC7,
>  	CXL_DECODER_MIXED,
>  	CXL_DECODER_DEAD,
>  };
> @@ -375,6 +383,14 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  		[CXL_DECODER_NONE] = "none",
>  		[CXL_DECODER_RAM] = "ram",
>  		[CXL_DECODER_PMEM] = "pmem",
> +		[CXL_DECODER_DC0] = "dc0",
> +		[CXL_DECODER_DC1] = "dc1",
> +		[CXL_DECODER_DC2] = "dc2",
> +		[CXL_DECODER_DC3] = "dc3",
> +		[CXL_DECODER_DC4] = "dc4",
> +		[CXL_DECODER_DC5] = "dc5",
> +		[CXL_DECODER_DC6] = "dc6",
> +		[CXL_DECODER_DC7] = "dc7",
>  		[CXL_DECODER_MIXED] = "mixed",
>  	};
>  
> @@ -383,10 +399,16 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  	return "mixed";
>  }
>  
> +static inline bool cxl_decoder_mode_is_dc(enum cxl_decoder_mode mode)
> +{
> +	return (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7);
> +}
> +
>  enum cxl_region_mode {
>  	CXL_REGION_NONE,
>  	CXL_REGION_RAM,
>  	CXL_REGION_PMEM,
> +	CXL_REGION_DC,
>  	CXL_REGION_MIXED,
>  };
>  
> @@ -396,6 +418,7 @@ static inline const char *cxl_region_mode_name(enum cxl_region_mode mode)
>  		[CXL_REGION_NONE] = "none",
>  		[CXL_REGION_RAM] = "ram",
>  		[CXL_REGION_PMEM] = "pmem",
> +		[CXL_REGION_DC] = "dc",
>  		[CXL_REGION_MIXED] = "mixed",
>  	};
>  
> 
> -- 
> 2.44.0
> 

