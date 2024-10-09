Return-Path: <linux-btrfs+bounces-8748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3C39974B5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 20:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA891C21E5E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA81E04B5;
	Wed,  9 Oct 2024 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNJTBF6U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BEC381C4;
	Wed,  9 Oct 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497815; cv=none; b=oCGb1WDYnvCZoaEoD9z36SjJupMVZHqDLUx0VyzlOTGZYXrWdb07aMBgJd/Hhsf4blsdLM68Gwt7EW1BKrrOsdj+8Xc5C5IF58fE3Mwlm0FAJUYliZXgmry4MhoNSakIgT4ECblhv8pJEbD1c4+maXFOx0OKUuRDfzkfif08yrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497815; c=relaxed/simple;
	bh=pgwXgBk4u3VDmEKtGUQEApvK2p6Cbd2W1dgFQxkkxbs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp8x8bjooMNjVU3n1JwjOYO2bKcfUO6NKm8WAaPyAdaufi2vVwa3x34m52+bGR1CtepSrLMmg9xI3Xz+4ulf5Xrc/55EKO0ZhJNBl8i5YnQHKqQCVooss55cSm5ZDKTiHtVCLbzIivvJLayIU+OvL2FOGxO9w5LGbbZfx9bKQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNJTBF6U; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso39628276.1;
        Wed, 09 Oct 2024 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728497813; x=1729102613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMJHEoItCLKNQqTYhraWfgSOwnHOJJjA5T9nEdBreoo=;
        b=PNJTBF6U8LjGniruNHsDgvw3aZxtN1J/PxckPEl419VgEyK9Q1yvkoe65R4lAqQSm7
         h40EBirQpkDFiKGF+hos+crQs7DjA3tUFbMKSO7F4Lk0DDkd6P+RV5l9e9lGPppYDMpK
         FeG8tbAzmzSNZ+aTtnKYYQU5sgBkFAP5pXiSI37lgmGHflKrmrHhouAWLJKIO49APkpW
         sNV2ghtQQqjpZBYuz50GewWgNvGSm7K3P8kq0j8Pr3l2ZLS9CdMHMidm8OOHfCOo9NpP
         1V4kLWpe8xE0xGbby7+MC5aGJArSxT6aQtd4TmB19dO3dkI8GHEQO030Ro0ebkeWrzEA
         1RjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497813; x=1729102613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMJHEoItCLKNQqTYhraWfgSOwnHOJJjA5T9nEdBreoo=;
        b=a7S4C5KbOIveRT0zHGrELO8LIr9s9ZKfixcry/LMlPOzXq2UjVZsMGwhl5VuBhWkzU
         0itj+7hU1xXr8f4C9wbPCZshoXnPFjTIZTPhhHQyFqJem9rfL21WylS2A/7kRSNtDela
         OCzJ4G2UqoVG4C/g0ELQ8j1E1i6R028Jwgg0ESoF/zStHQBmUmyGhAPcHR/ReVy5hSuM
         IgnpBk6cIuabkNlMtgySurLYP2j8Rvc55hg4nPFWKLt1OfESw7pglHeaFkSsaE4dmole
         vq05culWWNBCxeBe3cg7+e2FZFQaD2hvnj2JgwbbhnNdpqAQR3Dwp8zX9pjPd3E7S6y+
         lLnw==
X-Forwarded-Encrypted: i=1; AJvYcCUawDYmPlg+aIfZV3EZhLtFoFOD1SOMySSELqpTpbKT8t2VglC6+ccpfnrKBRnGylz+p8PRA6m8qDI9dEzZ@vger.kernel.org, AJvYcCVV/X5kP+NMQPjMUkB+T6Gq+m2iaewAzXRpc477a9V575/26XJ5xKV/A9al72XacB58AqFlMQ9wYqjd@vger.kernel.org, AJvYcCVpHxj2ySrWCYi3aJr7PbshsxPnDiqGSnNsusw5V0Kli8IsHQSSUDs8UnzBvoAogxVqysbVG2n/9/h3@vger.kernel.org, AJvYcCWH40Z6sgt0UUo5BT4TbAJnL6kqrbjrCCXNkDiQ9qS+s8F+bbzgFrrefDXQTug/uz8L3PUq4zGDqWYUkb0=@vger.kernel.org, AJvYcCXA+wTx5PzNAUA+F14TxjEllzVJdNe2q0BIPdzQB1uZUCCrJMtP0OQQiC0QhcZsLQdWRX2NEnTWEe2I@vger.kernel.org
X-Gm-Message-State: AOJu0YzmA0L6dA7VYFveE4FbgJYmJuakTWLfL9W1oEfeFEFAPWLdLyHS
	eQ0w2vGXiJEGB4BXrGfnJLJcJnWKgHkQWH1UVzrPMKhHna0ulcV8
X-Google-Smtp-Source: AGHT+IECrhvsoxz0tchfe2uj4Zhv6SF3YjPCuZouV+uInwFOYEXaWO6HLusBCmrFa51JFGrbxab3yQ==
X-Received: by 2002:a05:6902:218f:b0:e28:f176:105 with SMTP id 3f1490d57ef6-e28fe4dbdc4mr3312075276.36.1728497812917;
        Wed, 09 Oct 2024 11:16:52 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2908cde6d6sm142601276.24.2024.10.09.11.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 11:16:52 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 9 Oct 2024 11:16:49 -0700
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
	linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v4 12/28] cxl/cdat: Gather DSMAS data for DCD regions
Message-ID: <ZwbIkQCzaOoUwWki@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-12-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-12-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:18PM -0500, Ira Weiny wrote:
> Additional DCD region (partition) information is contained in the DSMAS
> CDAT tables, including performance, read only, and shareable attributes.
> 
> Match DCD partitions with DSMAS tables and store the meta data.
> 
> To: Robert Moore <robert.moore@intel.com>
> To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> To: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: acpica-devel@lists.linux.dev
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

One minor comment inline.

> ---
> Changes:
> [iweiny: new patch]
> [iweiny: Gather shareable/read-only flags for later use]
> ---
>  drivers/cxl/core/cdat.c | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/mbox.c |  2 ++
>  drivers/cxl/cxlmem.h    |  3 +++
>  include/acpi/actbl1.h   |  2 ++
>  4 files changed, 45 insertions(+)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index bd50bb655741..9b2f717a16e5 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -17,6 +17,8 @@ struct dsmas_entry {
>  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
>  	int entries;
>  	int qos_class;
> +	bool shareable;
> +	bool read_only;
>  };
>  
>  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> @@ -74,6 +76,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
>  		return -ENOMEM;
>  
>  	dent->handle = dsmas->dsmad_handle;
> +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
> +	dent->read_only = dsmas->flags & ACPI_CDAT_DSMAS_READ_ONLY;
>  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
>  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
>  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> @@ -255,6 +259,38 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>  		dent->coord[ACCESS_COORDINATE_CPU].write_latency);
>  }
>  
> +
Unwanted blank line.

Fan
> +static void update_dcd_perf(struct cxl_dev_state *cxlds,
> +			    struct dsmas_entry *dent)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct device *dev = cxlds->dev;
> +
> +	for (int i = 0; i < mds->nr_dc_region; i++) {
> +		/* CXL defines a u32 handle while cdat defines u8, ignore upper bits */
> +		u8 dc_handle = mds->dc_region[i].dsmad_handle & 0xff;
> +
> +		if (resource_size(&cxlds->dc_res[i])) {
> +			struct range dc_range = {
> +				.start = cxlds->dc_res[i].start,
> +				.end = cxlds->dc_res[i].end,
> +			};
> +
> +			if (range_contains(&dent->dpa_range, &dc_range)) {
> +				if (dent->handle != dc_handle)
> +					dev_warn(dev, "DC Region/DSMAS mis-matched handle/range; region %pra (%u); dsmas %pra (%u)\n"
> +						      "   setting DC region attributes regardless\n",
> +						&dent->dpa_range, dent->handle,
> +						&dc_range, dc_handle);
> +
> +				mds->dc_region[i].shareable = dent->shareable;
> +				mds->dc_region[i].read_only = dent->read_only;
> +				update_perf_entry(dev, dent, &mds->dc_perf[i]);
> +			}
> +		}
> +	}
> +}
> +
>  static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  				     struct xarray *dsmas_xa)
>  {
> @@ -278,6 +314,8 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  		else if (resource_size(&cxlds->pmem_res) &&
>  			 range_contains(&pmem_range, &dent->dpa_range))
>  			update_perf_entry(dev, dent, &mds->pmem_perf);
> +		else if (cxl_dcd_supported(mds))
> +			update_dcd_perf(cxlds, dent);
>  		else
>  			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
>  				&dent->dpa_range);
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4b51ddd1ff94..3ba465823564 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1649,6 +1649,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>  	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
> +	for (int i = 0; i < CXL_MAX_DC_REGION; i++)
> +		mds->dc_perf[i].qos_class = CXL_QOS_CLASS_INVALID;
>  
>  	return mds;
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0690b917b1e0..c3b889a586d8 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -466,6 +466,8 @@ struct cxl_dc_region_info {
>  	u64 blk_size;
>  	u32 dsmad_handle;
>  	u8 flags;
> +	bool shareable;
> +	bool read_only;
>  	u8 name[CXL_DC_REGION_STRLEN];
>  };
>  
> @@ -533,6 +535,7 @@ struct cxl_memdev_state {
>  
>  	u8 nr_dc_region;
>  	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
> +	struct cxl_dpa_perf dc_perf[CXL_MAX_DC_REGION];
>  
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 199afc2cd122..387fc821703a 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -403,6 +403,8 @@ struct acpi_cdat_dsmas {
>  /* Flags for subtable above */
>  
>  #define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
> +#define ACPI_CDAT_DSMAS_SHAREABLE           (1 << 3)
> +#define ACPI_CDAT_DSMAS_READ_ONLY           (1 << 6)
>  
>  /* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
>  
> 
> -- 
> 2.46.0
> 

-- 
Fan Ni

