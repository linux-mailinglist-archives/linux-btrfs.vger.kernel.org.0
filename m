Return-Path: <linux-btrfs+bounces-8822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA00999034
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 20:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B6C28166E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375151CF2A8;
	Thu, 10 Oct 2024 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQW5sbk/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A831E909D;
	Thu, 10 Oct 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584720; cv=none; b=Qbzl+CWGINblhrZh5GPKddLOImjpYoS2E8UhYDPISRIGFnQWiIes9krzAJueUBeThE23gSCip+v66s9OC4WZu87eUs5IQURx28Ze6qV1lI1GMA4SKOc2CgnU751h0mkCrxkVgikB6LNJNb/ceKoJY+X4Kx+9asvm9BLNq8T1P1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584720; c=relaxed/simple;
	bh=2rGxLzL4a1zBXPkYNtUom2nw03PtlluwPsJOr68+WtY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0A1CGvShOsh5fw/E/BJxq6wuHUt6oILMHHQaP4exUyZzZt/6uhsUk0hK5iMYCLtzrpJEM+kEAazk0cFR776kmf3YSy8GD8xAgZrT6m8e/0xSEqsjHm+WFZv9x4hFlu33dS8XuTvLGozsZMSEZ3ErINAlMDV2Fu6xuP7Ej16wqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQW5sbk/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b90984971so11822985ad.3;
        Thu, 10 Oct 2024 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728584717; x=1729189517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCZKAEGut2Fz9y7VqNxcbBwx+dx2pjvlA/aSvDU2Nhg=;
        b=UQW5sbk/pF6HyAzi+3PF0yoyYMuMurfeLzdJX68bF8m5OameRNjfvWzt2p3t7v8a7V
         wnrwMYz4fnlUQw6hzaoLFblU7IFqJz6RrT5p5OFfPiqHm2TY2rkIYuLpztv+HrmnP3Qb
         v6tajAWa+npF6H5D8ufnWtgNYjfnpCkL7DuaHb+nl6ovI6PMSOgjCSCKv2y1Kq9kZNvg
         IuXSctSjTYr12rxVavmqtuRL3RZl/yyaCmeZzU8RyyJ0nNxMslDiCIIFAHliLP5O0CpC
         rOndfyeq9tl2TLckJfa/g88UP1yHhvUxdNqunUdEE9TrzVPuTcRRdzNnGlK0k14hfOjM
         IPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584717; x=1729189517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCZKAEGut2Fz9y7VqNxcbBwx+dx2pjvlA/aSvDU2Nhg=;
        b=nklUmQDslzBI70tFLz9/cT1Uqe9RTW570Crrz6Uh3cJDroWd8JxawQeinqPXj/NwK2
         hnVinYVQiq83+pfuU4z9NlQMdTkw2w5tFro7SLSh/xs7uG6rniG3ZBrJ+3eB/2UqXDlz
         mqS8403K8UYZHWsAWIhhzCaDES8GRQ7dWyGn5V3T2TtlOiG6SvYYKF/au7YumKOnLy+Q
         2YDtUF07CnKN6IAVBwE0UzVdjpyenlLN5aGR9h3IbSZswkHDoPaOKA/KE6CjFcrnGcr1
         b70qeDZHzwJM9TdZSyYdxzbfK+xUyej7r+WxdiksNx7ojZgG0D5+2WsBBaDxLy77puMi
         rzdg==
X-Forwarded-Encrypted: i=1; AJvYcCU0jNPtLjJXOyblpbVpD94pVAvmCVc6OYFoY9M7MwpCMbMlr2S74tXhIE0m6bHKqm0vi2JVqBV/Q35Pu2YK@vger.kernel.org, AJvYcCV/oAXgUbxeoxFvftS5L37lXC5ud1MUwj+q1B/zIpgInRF4GJ2zl0jhRjiM05nWwnk1bI+QEtpB1Lwc8g==@vger.kernel.org, AJvYcCVhkjuG6fer41DNuGGy+UmV20uRL6+M1jmmsqu4BkPIY2OVZWi3Qrm9lCQNaONFEQH1WRNC7F/+DxOP@vger.kernel.org, AJvYcCXmWu/bXSx6oJUh9puOpyRl4utwHW0aYRfYGYaKAtkQgtkZc9xaH/tbJoQskkknfTAtW/bKKsaMmxbL@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4WZT7HD1SN8gJzBo8mG4oK5gXDciFGnuJkjvU9z0C5nxqtu1
	0Fdpet7dVj9xBW+kff+qCjEBJCvS3DeiS4JdqUnGhcKz9UZzEzDsSsRkwQ==
X-Google-Smtp-Source: AGHT+IHc42Q5P+w1wk3Fgq7/XkeeKpbIEIscynXSdbvC3/s2GAAsoEzVIy0pSdpH3PtVv2yfyyf8lA==
X-Received: by 2002:a17:902:d548:b0:20b:8325:5a1e with SMTP id d9443c01a7336-20c9d905c2fmr7134325ad.36.1728584717333;
        Thu, 10 Oct 2024 11:25:17 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:c165:c800:4280:d79b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb470sm12140735ad.126.2024.10.10.11.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:25:17 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 10 Oct 2024 11:25:13 -0700
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
Subject: Re: [PATCH v4 19/28] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <ZwgcCRTl3x2H8Ze5@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-19-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-19-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:25PM -0500, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic Capacity Devices (DCD) support extent change notifications
> through the event log mechanism.  The interrupt mailbox commands were
> extended in CXL 3.1 to support these notifications.  Firmware can't
> configure DCD events to be FW controlled but can retain control of
> memory events.
> 
> Configure DCD event log interrupts on devices supporting dynamic
> capacity.  Disable DCD if interrupts are not supported.
> 
> Care is taken to preserve the interrupt policy set by the FW if FW first
> has been selected by the BIOS.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes:
> [iweiny: rebase on 6.12]
> ---
>  drivers/cxl/cxlmem.h |  2 ++
>  drivers/cxl/pci.c    | 72 +++++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 62 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c3b889a586d8..2d2a1884a174 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -226,7 +226,9 @@ struct cxl_event_interrupt_policy {
>  	u8 warn_settings;
>  	u8 failure_settings;
>  	u8 fatal_settings;
> +	u8 dcd_settings;
>  } __packed;
> +#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
>  
>  /**
>   * struct cxl_event_state - Event log driver state
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c6042db0653d..2ba059d313c2 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -672,23 +672,34 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
>  }
>  
>  static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
> -				    struct cxl_event_interrupt_policy *policy)
> +				    struct cxl_event_interrupt_policy *policy,
> +				    bool native_cxl)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	size_t size_in = CXL_EVENT_INT_POLICY_BASE_SIZE;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> -	*policy = (struct cxl_event_interrupt_policy) {
> -		.info_settings = CXL_INT_MSI_MSIX,
> -		.warn_settings = CXL_INT_MSI_MSIX,
> -		.failure_settings = CXL_INT_MSI_MSIX,
> -		.fatal_settings = CXL_INT_MSI_MSIX,
> -	};
> +	/* memory event policy is left if FW has control */
> +	if (native_cxl) {
> +		*policy = (struct cxl_event_interrupt_policy) {
> +			.info_settings = CXL_INT_MSI_MSIX,
> +			.warn_settings = CXL_INT_MSI_MSIX,
> +			.failure_settings = CXL_INT_MSI_MSIX,
> +			.fatal_settings = CXL_INT_MSI_MSIX,
> +			.dcd_settings = 0,
> +		};
> +	}
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
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> @@ -735,6 +746,31 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
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

If the device has both static and dynamic capacity, return an error code
here will cause cxl_event_config() return early, and
cxl_mem_get_event_records() will not be called, will it be an issue?

Fan

> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static bool cxl_event_int_is_fw(u8 setting)
>  {
>  	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
> @@ -761,17 +797,25 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
> @@ -779,10 +823,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
> @@ -790,12 +834,16 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
> +	dev_dbg(mds->cxlds.dev, "Event config : %s DCD %s\n",
> +		native_cxl ? "OS" : "BIOS",
> +		cxl_dcd_supported(mds) ? "supported" : "not supported");
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.46.0
> 

-- 
Fan Ni

