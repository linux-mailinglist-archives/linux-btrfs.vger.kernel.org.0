Return-Path: <linux-btrfs+bounces-8747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CFA99740B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 20:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841D91F21BBE
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E351DFE2B;
	Wed,  9 Oct 2024 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKHMcBkh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A31DF726;
	Wed,  9 Oct 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497170; cv=none; b=oVlN0cCuW5/ciih1ZCVMuCXKkpPQvIMnhMAVZk+QKBBRH0ahPz/arMpZ7c4T/2U78KxrzDTFA1h1I4LUJtdKmh/vOYz7/Oa0rRNCC6QiD1ueApXvae7S+Rk7aG8gEvEOII3NldLLE14fj3fV3sZcA7VGXh9Z5T7p90yLsPJyKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497170; c=relaxed/simple;
	bh=NDzUnLYi0r9hSu8chjrE9a5Xc+jfeaYwyDjiw6hwoRw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeOHYpskKq7kt/gW2I+NoLbhaV8uV1mGWNxWGKtqLCg62y3pLMYN4JSpU4JupIuuoEB8DpTAG2e1TXn5DeXXOjUWu1+KKr1hOjbKxue78WOR6YoF0Hp+CsEr4HpOw7sTWjmqMh3RWfS37/SzH+JYecPFYIs8ymjkmlCcjiJ/l70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKHMcBkh; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e2d2447181so1379367b3.1;
        Wed, 09 Oct 2024 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728497167; x=1729101967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QsgGyhgkcet2GDEntNX2xI7u3KGBLMm9Tii+k7pMzpo=;
        b=hKHMcBkhNeq9lxIZpryCvqhuwRthgGOPF1OXYfmpS5MNTOVjt+uBDnmcRlKNnz3za1
         gjMjt3q8KGTNNPzKXepoAiOWVn3WIc/50GIF1JEc7RWQn39FR8g+9AloD6Ib9yusYbre
         zZwSRskR2hzi9LfbYDsxk32cz/XsmGm8XDZp6/QdJHhe3CZSNhrJp1MBzmvblOBt+VPU
         lTS6boUZfGi/xmS0Ir0f3ZQjBRiMUCLpJ69gUheiMNf+ZY+ueAP4SbjI0ZMKNWXmwQHD
         WyDdUEUNuXwSJ28qsvB3AvH+D29qwM5C0yVF8Qj3AqO3GjC/ceXv1ZGxNUPCUP56FjXY
         PTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497167; x=1729101967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsgGyhgkcet2GDEntNX2xI7u3KGBLMm9Tii+k7pMzpo=;
        b=NJwpOll4TbUym0vVj6Mfa9Yla/Xhah3+Sek3yp66hPsBf0Xzp9Rqxbk8p3HA9+tlIt
         eaftRkKcQE+2vH0zWtyqqmsRT853YhzmGFSzvz/T6GJ4hfpSIQK+B2GRbikWXq5aRq+W
         5Hb3QlJwRWbBx7AmtUddVouxtl48qKALj71WIU/P+q9OvLYkbNuYzVoSBCf5nfbwKTHr
         Pj7jhh/NxBCfW+VOwRbyirdg6fVyphefzUK0z5rK8ja8iEQTwa44llB9bmu7tLdmU9rx
         CMGbN3Khb1arU37nkiV6yU30x9+dM+1QuIRkkF07J7xuBAJ3T0KYY2KsPjFQFluJvVse
         7Msg==
X-Forwarded-Encrypted: i=1; AJvYcCUjc0hDC0velRDmr/yYH1QvAt63ujfDVyQFeepzgA2BO6OV++HfMtaMZwQDIqJAEgN9wapZ96eqNgN5@vger.kernel.org, AJvYcCUvvPuZuBzTejC0v+DbyYertTviOs5HlTd1n8eSsbCjo2El/ZI/PAW+9NWcirQRfb3Vh2c4M2Q1ENpO@vger.kernel.org, AJvYcCVHZ3ym9ifW2HbTvlbsHYMQzXrhovtxuqkykTyARsPCL+t0Wvivr/Pkj1kf7TzYOO39jmRzzCeIPdngiWqZ@vger.kernel.org, AJvYcCWcbN+Y4Gr2ezfZaIZ0R8j5ct9wxbvRlJXdeJEJIe0Yc0uHJPRui/V6NH3/VBPy4XxsXbfFWp3cTrqfdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZiFLTUsaEchYtcQDJ5MRGrpQ50G/q3ftxtYhYa92pEL0o8t5h
	UEX35LzsP4oKSceX7QKuFd4rMHpBSg2Liw9oEJH0jApCMS+5UtG7
X-Google-Smtp-Source: AGHT+IFCdN3A6nQ/CT5czVmMRt+Qvpx+orKwJLMYDZxTZ6GxCCka1vcD5BHEwTUgS9t+hlglLnsIwg==
X-Received: by 2002:a05:690c:9:b0:6b1:2825:a3cd with SMTP id 00721157ae682-6e3224913d7mr31775077b3.35.1728497167361;
        Wed, 09 Oct 2024 11:06:07 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d9388c21sm19480857b3.68.2024.10.09.11.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 11:06:07 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 9 Oct 2024 11:06:04 -0700
To: ira.weiny@intel.com
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
Subject: Re: [PATCH v4 09/28] cxl/core: Separate region mode from decoder mode
Message-ID: <ZwbGDKfsOWDNA4m8@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-9-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-9-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:15PM -0500, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Until now region modes and decoder modes were equivalent in that both
> modes were either PMEM or RAM.  The addition of Dynamic
> Capacity partitions defines up to 8 DC partitions per device.
> 
> The region mode is thus no longer equivalent to the endpoint decoder
> mode.  IOW the endpoint decoders may have modes of DC0-DC7 while the
> region mode is simply DC.
> 
> Define a new region mode enumeration which applies to regions separate
> from the decoder mode.  Adjust the code to process these modes
> independently.
> 
> There is no equal to decoder mode dead in region modes.  Avoid
> constructing regions with decoders which have been flagged as dead.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> Changes:
> [iweiny: rebase]
> [Jonathan: remove dead code]
> [Jonathan: clarify commit message]
> ---
>  drivers/cxl/core/cdat.c   |  6 ++--
>  drivers/cxl/core/region.c | 75 ++++++++++++++++++++++++++++++++++-------------
>  drivers/cxl/cxl.h         | 26 ++++++++++++++--
>  3 files changed, 82 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 438869df241a..bd50bb655741 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -571,17 +571,17 @@ static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
>  }
>  
>  static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxled,
> -					       enum cxl_decoder_mode mode)
> +					       enum cxl_region_mode mode)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_dpa_perf *perf;
>  
>  	switch (mode) {
> -	case CXL_DECODER_RAM:
> +	case CXL_REGION_RAM:
>  		perf = &mds->ram_perf;
>  		break;
> -	case CXL_DECODER_PMEM:
> +	case CXL_REGION_PMEM:
>  		perf = &mds->pmem_perf;
>  		break;
>  	default:
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e701e4b04032..f3a56003edc1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -144,7 +144,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>  	rc = down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	if (cxlr->mode != CXL_DECODER_PMEM)
> +	if (cxlr->mode != CXL_REGION_PMEM)
>  		rc = sysfs_emit(buf, "\n");
>  	else
>  		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
> @@ -457,7 +457,7 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
>  	 * Support tooling that expects to find a 'uuid' attribute for all
>  	 * regions regardless of mode.
>  	 */
> -	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
> +	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_REGION_PMEM)
>  		return 0444;
>  	return a->mode;
>  }
> @@ -620,7 +620,7 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
>  
> -	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxlr->mode));
> +	return sysfs_emit(buf, "%s\n", cxl_region_mode_name(cxlr->mode));
>  }
>  static DEVICE_ATTR_RO(mode);
>  
> @@ -646,7 +646,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  
>  	/* ways, granularity and uuid (if PMEM) need to be set before HPA */
>  	if (!p->interleave_ways || !p->interleave_granularity ||
> -	    (cxlr->mode == CXL_DECODER_PMEM && uuid_is_null(&p->uuid)))
> +	    (cxlr->mode == CXL_REGION_PMEM && uuid_is_null(&p->uuid)))
>  		return -ENXIO;
>  
>  	div64_u64_rem(size, (u64)SZ_256M * p->interleave_ways, &remainder);
> @@ -1863,6 +1863,17 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static bool cxl_modes_compatible(enum cxl_region_mode rmode,
> +				 enum cxl_decoder_mode dmode)
> +{
> +	if (rmode == CXL_REGION_RAM && dmode == CXL_DECODER_RAM)
> +		return true;
> +	if (rmode == CXL_REGION_PMEM && dmode == CXL_DECODER_PMEM)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1882,9 +1893,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return rc;
>  	}
>  
> -	if (cxled->mode != cxlr->mode) {
> -		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> -			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> +	if (!cxl_modes_compatible(cxlr->mode, cxled->mode)) {
> +		dev_dbg(&cxlr->dev, "%s region mode: %s mismatch decoder: %s\n",
> +			dev_name(&cxled->cxld.dev),
> +			cxl_region_mode_name(cxlr->mode),
> +			cxl_decoder_mode_name(cxled->mode));
>  		return -EINVAL;
>  	}
>  
> @@ -2446,7 +2459,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
>   * devm_cxl_add_region - Adds a region to a decoder
>   * @cxlrd: root decoder
>   * @id: memregion id to create, or memregion_free() on failure
> - * @mode: mode for the endpoint decoders of this region
> + * @mode: mode of this region
>   * @type: select whether this is an expander or accelerator (type-2 or type-3)
>   *
>   * This is the second step of region initialization. Regions exist within an
> @@ -2457,7 +2470,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
>   */
>  static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  					      int id,
> -					      enum cxl_decoder_mode mode,
> +					      enum cxl_region_mode mode,
>  					      enum cxl_decoder_type type)
>  {
>  	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> @@ -2511,16 +2524,17 @@ static ssize_t create_ram_region_show(struct device *dev,
>  }
>  
>  static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> -					  enum cxl_decoder_mode mode, int id)
> +					  enum cxl_region_mode mode, int id)
>  {
>  	int rc;
>  
>  	switch (mode) {
> -	case CXL_DECODER_RAM:
> -	case CXL_DECODER_PMEM:
> +	case CXL_REGION_RAM:
> +	case CXL_REGION_PMEM:
>  		break;
>  	default:
> -		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> +		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
> +			cxl_region_mode_name(mode));
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> @@ -2548,7 +2562,7 @@ static ssize_t create_pmem_region_store(struct device *dev,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
> +	cxlr = __create_region(cxlrd, CXL_REGION_PMEM, id);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> @@ -2568,7 +2582,7 @@ static ssize_t create_ram_region_store(struct device *dev,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
> +	cxlr = __create_region(cxlrd, CXL_REGION_RAM, id);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> @@ -3215,6 +3229,22 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> +static enum cxl_region_mode
> +cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
> +{
> +	switch (mode) {
> +	case CXL_DECODER_NONE:
> +		return CXL_REGION_NONE;
> +	case CXL_DECODER_RAM:
> +		return CXL_REGION_RAM;
> +	case CXL_DECODER_PMEM:
> +		return CXL_REGION_PMEM;
> +	case CXL_DECODER_MIXED:
> +	default:
> +		return CXL_REGION_MIXED;
> +	}
> +}
> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -3223,12 +3253,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
> +	enum cxl_region_mode mode;
>  	struct cxl_region *cxlr;
>  	struct resource *res;
>  	int rc;
>  
> +	if (cxled->mode == CXL_DECODER_DEAD)
> +		return ERR_PTR(-EINVAL);
> +
> +	mode = cxl_decoder_to_region_mode(cxled->mode);
>  	do {
> -		cxlr = __create_region(cxlrd, cxled->mode,
> +		cxlr = __create_region(cxlrd, mode,
>  				       atomic_read(&cxlrd->region_id));
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
> @@ -3431,9 +3466,9 @@ static int cxl_region_probe(struct device *dev)
>  		return rc;
>  
>  	switch (cxlr->mode) {
> -	case CXL_DECODER_PMEM:
> +	case CXL_REGION_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
> -	case CXL_DECODER_RAM:
> +	case CXL_REGION_RAM:
>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'
> @@ -3445,8 +3480,8 @@ static int cxl_region_probe(struct device *dev)
>  			return 0;
>  		return devm_cxl_add_dax_region(cxlr);
>  	default:
> -		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> -			cxlr->mode);
> +		dev_dbg(&cxlr->dev, "unsupported region mode: %s\n",
> +			cxl_region_mode_name(cxlr->mode));
>  		return -ENXIO;
>  	}
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0d8b810a51f0..5d74eb4ffab3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -388,6 +388,27 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  	return "mixed";
>  }
>  
> +enum cxl_region_mode {
> +	CXL_REGION_NONE,
> +	CXL_REGION_RAM,
> +	CXL_REGION_PMEM,
> +	CXL_REGION_MIXED,
> +};
> +
> +static inline const char *cxl_region_mode_name(enum cxl_region_mode mode)
> +{
> +	static const char * const names[] = {
> +		[CXL_REGION_NONE] = "none",
> +		[CXL_REGION_RAM] = "ram",
> +		[CXL_REGION_PMEM] = "pmem",
> +		[CXL_REGION_MIXED] = "mixed",
> +	};
> +
> +	if (mode >= CXL_REGION_NONE && mode <= CXL_REGION_MIXED)
> +		return names[mode];
> +	return "mixed";
> +}
> +
>  /*
>   * Track whether this decoder is reserved for region autodiscovery, or
>   * free for userspace provisioning.
> @@ -515,7 +536,8 @@ struct cxl_region_params {
>   * struct cxl_region - CXL region
>   * @dev: This region's device
>   * @id: This region's id. Id is globally unique across all regions
> - * @mode: Endpoint decoder allocation / access mode
> + * @mode: Region mode which defines which endpoint decoder modes the region is
> + *        compatible with
>   * @type: Endpoint decoder target type
>   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
>   * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
> @@ -528,7 +550,7 @@ struct cxl_region_params {
>  struct cxl_region {
>  	struct device dev;
>  	int id;
> -	enum cxl_decoder_mode mode;
> +	enum cxl_region_mode mode;
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;
> 
> -- 
> 2.46.0
> 

-- 
Fan Ni

