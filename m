Return-Path: <linux-btrfs+bounces-3643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0271B88D2A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 00:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C832C7B52
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251D113DDC7;
	Tue, 26 Mar 2024 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkYlf3as"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3051E494;
	Tue, 26 Mar 2024 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494759; cv=none; b=BfPhWerhSsqL+7iovCNLZ/e/x1X8FZNIExYFxOqwOANUi2KhbmF6cZYckahv13ycbIHV6K+UGCQbE1Wpvp6I6Hk04XiTpCWVO1EYnC5MCJNf5XWgewbLgy4tWxSPCtCd0IHBUVylPmuj0eAtmRDSP3LtGBSpc98ODh8vG7nRg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494759; c=relaxed/simple;
	bh=S+UbtKE+7VXAYTZQsGDhMQnPwtMIGNxuhlcF9CQES3A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKhqjffqCLlRwKwkfM8kxuex9djpr0owKn8nS1cuLvhGEEQqF/HzQqch+bMSjPuEDTD2pZHb6hQA/5FtAjmD5ePer9GhTL3nnNdnTNJ6hz6sxtIqocn7oXkD1mBfoVmsws9vq+5yufQ0OU0jnb0tmtxqa1s/4KBURTAmh7K2Vic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkYlf3as; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-221816e3ab9so2625795fac.2;
        Tue, 26 Mar 2024 16:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711494756; x=1712099556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hKsQFAenGXxntkcve064jSRHibSWpm0z83IjTBW7B5Y=;
        b=gkYlf3asfJc8SU6aJ5PzdhUuMFR3l/n2RX8UxFxV2LGbO65iGMkMAjhmiSg6XtxUUZ
         rZMbJgECnPNnwKv2IOTklRdHSEa6Nu22UvSK8S61Xv3uFFzLTdNIduz29sWT4AiQhCce
         cZ8iUA0UgmcmaR1KN6vbmc3FSa39v1AeKeNm5JXGk3X4+vD5dJVcgQPnC8VjZ6Wq/rnv
         dGuqZx8Y/d4I2yvTAaI/ViainddxD5odeGW5nQ9OvaLtfnXZ4xgvcoMz7Ad07AFxLyt9
         /6OwvDHK+hbtEU4qxTENFWANduyukzpqOVkLcfYT0zoDflQ47R4zeINt/P7c0A8kChTZ
         jaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711494756; x=1712099556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKsQFAenGXxntkcve064jSRHibSWpm0z83IjTBW7B5Y=;
        b=cCmjhx6GP6tSRenXNsK5zmZEQSJiLQtcOtu4oWrLdjTy4z3Pj/urEItPIHFyAweO71
         FpO43BulwOR3Jf5/iVuJG7KXFqgPxhxy8NKXlgIRjzPJws+wU61571V8jIbl0txIW4Jh
         KwnhuRlAfrW7as+y4l1ZS+NYOiLuldh4kcQnTdNFt3jvliAuuxu++cjAGlWRLQYS7IH5
         9Mqveelhpvh7MoRzUABx4O+bCrTQsWORmZsS782czUi+tJ2W76+tvW81TEPFVKEvSDjP
         o0D9Scsc0HlVmduG2cEKQ+MNTy3Kl3mpuc/gHVCaKYTvpjRaMkBItPoCPsprbeBLFm1w
         X/rw==
X-Forwarded-Encrypted: i=1; AJvYcCUc/tFi9h6a1E7IA/eku0H9Y9sm3SRpWwkF9+hFo1rUoVgMAL634sCO/xuIIVtzPjmE0/UA7IC4WrNpIV7K1pFTBBcxMaOo7o0fb0ggyRoNqPaSPkuQ9mM2QbZDYBRk+vRaDf2f+A/6ILjCnqexx4rXm1op/rBjyQHNgyuDbUNyRlQDDT8=
X-Gm-Message-State: AOJu0YyDWLj47P5htByfdT9QYELLW6u0AK/UCQaJokApl0B/klnU3WKS
	jeZGlWRqDQ0zHYBG1fzPdEn+kIzgmRaHBH6rQG6wUfCRe1/VL+IHbcAxFCPb
X-Google-Smtp-Source: AGHT+IFul8KcODyrEGVw35D6g687woVOKiYbVNnkRjo2bWb/y72GUCCfHiik4OiJH71z2Ul22wHmpw==
X-Received: by 2002:a05:6870:818a:b0:22a:6b82:d11 with SMTP id k10-20020a056870818a00b0022a6b820d11mr2909061oae.53.1711494756631;
        Tue, 26 Mar 2024 16:12:36 -0700 (PDT)
Received: from debian ([2601:641:300:14de:dab1:15ff:5381:7f21])
        by smtp.gmail.com with ESMTPSA id z189-20020a6265c6000000b006e71e3d1172sm6811212pfb.101.2024.03.26.16.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 16:12:36 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 26 Mar 2024 16:12:33 -0700
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
Subject: Re: [PATCH 13/26] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <ZgNWYdTMv8gjiKj9@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-13-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-13-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:16PM -0700, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic Capacity Devices (DCD) support extent change notifications
> through the event log mechanism.  The interrupt mailbox commands were
> extended in CXL 3.1 to support these notifications.
> 
> Firmware can't configure DCD events to be FW controlled but can retain
> control of memory events.  Split irq configuration of memory events and
> DCD events to allow for FW control of memory events while DCD is host
> controlled.
> 
> Configure DCD event log interrupts on devices supporting dynamic
> capacity.  Disable DCD if interrupts are not supported.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1
> [iweiny: rebase to upstream irq code]
> [iweiny: disable DCD if irqs not supported]
> ---
>  drivers/cxl/core/mbox.c |  9 ++++++-
>  drivers/cxl/cxl.h       |  4 ++-
>  drivers/cxl/cxlmem.h    |  4 +++
>  drivers/cxl/pci.c       | 71 ++++++++++++++++++++++++++++++++++++++++---------
>  4 files changed, 74 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 14e8a7528a8b..58b31fa47b93 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1323,10 +1323,17 @@ static int cxl_get_dc_config(struct cxl_memdev_state *mds, u8 start_region,
>  	return rc;
>  }
>  
> -static bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> +bool cxl_dcd_supported(struct cxl_memdev_state *mds)
>  {
>  	return test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_dcd_supported, CXL);
> +
> +void cxl_disable_dcd(struct cxl_memdev_state *mds)
> +{
> +	clear_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_disable_dcd, CXL);
>  
>  /**
>   * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 15d418b3bc9b..d585f5fdd3ae 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -164,11 +164,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
>  #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
>  #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> +#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
>  
>  #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
>  				 CXLDEV_EVENT_STATUS_WARN |	\
>  				 CXLDEV_EVENT_STATUS_FAIL |	\
> -				 CXLDEV_EVENT_STATUS_FATAL)
> +				 CXLDEV_EVENT_STATUS_FATAL|	\
> +				 CXLDEV_EVENT_STATUS_DCD)
>  
>  /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
>  #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4624cf612c1e..01bee6eedff3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -225,7 +225,9 @@ struct cxl_event_interrupt_policy {
>  	u8 warn_settings;
>  	u8 failure_settings;
>  	u8 fatal_settings;
> +	u8 dcd_settings;
>  } __packed;
> +#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
>  
>  /**
>   * struct cxl_event_state - Event log driver state
> @@ -890,6 +892,8 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
> +bool cxl_dcd_supported(struct cxl_memdev_state *mds);
> +void cxl_disable_dcd(struct cxl_memdev_state *mds);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 12cd5d399230..ef482eae09e9 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -669,22 +669,33 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
>  }
>  
>  static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
> -				    struct cxl_event_interrupt_policy *policy)
> +				    struct cxl_event_interrupt_policy *policy,
> +				    bool native_cxl)
>  {
>  	struct cxl_mbox_cmd mbox_cmd;
> +	size_t size_in;
>  	int rc;
>  
> -	*policy = (struct cxl_event_interrupt_policy) {
> -		.info_settings = CXL_INT_MSI_MSIX,
> -		.warn_settings = CXL_INT_MSI_MSIX,
> -		.failure_settings = CXL_INT_MSI_MSIX,
> -		.fatal_settings = CXL_INT_MSI_MSIX,
> -	};
> +	if (native_cxl) {
> +		*policy = (struct cxl_event_interrupt_policy) {
> +			.info_settings = CXL_INT_MSI_MSIX,
> +			.warn_settings = CXL_INT_MSI_MSIX,
> +			.failure_settings = CXL_INT_MSI_MSIX,
> +			.fatal_settings = CXL_INT_MSI_MSIX,
> +			.dcd_settings = 0,
> +		};
> +	}
> +	size_in = CXL_EVENT_INT_POLICY_BASE_SIZE;
> +
> +	if (cxl_dcd_supported(mds)) {
> +		policy->dcd_settings = CXL_INT_MSI_MSIX;
> +		size_in += sizeof(policy->dcd_settings);
> +	}
>  
>  	mbox_cmd = (struct cxl_mbox_cmd) {
>  		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
>  		.payload_in = policy,
> -		.size_in = sizeof(*policy),
> +		.size_in = size_in,
>  	};
>  
>  	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> @@ -731,6 +742,31 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
>  	return 0;
>  }
>  
> +static int cxl_irqsetup(struct cxl_memdev_state *mds,
> +			struct cxl_event_interrupt_policy *policy,
> +			bool native_cxl)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	int rc;
> +
> +	if (native_cxl) {
> +		rc = cxl_event_irqsetup(mds, policy);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (cxl_dcd_supported(mds)) {
> +		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
> +		if (rc) {
> +			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
> +			cxl_disable_dcd(mds);
> +			return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static bool cxl_event_int_is_fw(u8 setting)
>  {
>  	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
> @@ -757,17 +793,25 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
>  	struct cxl_event_interrupt_policy policy = { 0 };
> +	bool native_cxl = host_bridge->native_cxl_error;
>  	int rc;
>  
>  	/*
>  	 * When BIOS maintains CXL error reporting control, it will process
>  	 * event records.  Only one agent can do so.
> +	 *
> +	 * If BIOS has control of events and DCD is not supported skip event
> +	 * configuration.
>  	 */
> -	if (!host_bridge->native_cxl_error)
> +	if (!native_cxl && !cxl_dcd_supported(mds))
>  		return 0;
>  
>  	if (!irq_avail) {
>  		dev_info(mds->cxlds.dev, "No interrupt support, disable event processing.\n");
> +		if (cxl_dcd_supported(mds)) {
> +			dev_info(mds->cxlds.dev, "DCD requires interrupts, disable DCD\n");
> +			cxl_disable_dcd(mds);
> +		}
>  		return 0;
>  	}
>  
> @@ -775,10 +819,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> -	if (!cxl_event_validate_mem_policy(mds, &policy))
> +	if (native_cxl && !cxl_event_validate_mem_policy(mds, &policy))
>  		return -EBUSY;
>  
> -	rc = cxl_event_config_msgnums(mds, &policy);
> +	rc = cxl_event_config_msgnums(mds, &policy, native_cxl);
>  	if (rc)
>  		return rc;
>  
> @@ -786,12 +830,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_event_irqsetup(mds, &policy);
> +	rc = cxl_irqsetup(mds, &policy, native_cxl);
>  	if (rc)
>  		return rc;
>  
>  	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
>  
> +	dev_dbg(mds->cxlds.dev, "Event config : %d %d\n",
> +		native_cxl, cxl_dcd_supported(mds));

The message will print out two numbers, seems not very clear. Should we
translate to more straightforward message, like
native_cxl? "OS...":""
cxl_dcd_supported(msd)? "DCD supported": "DCD not supported"?

Fan

> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.44.0
> 

