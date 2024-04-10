Return-Path: <linux-btrfs+bounces-4124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C618A03FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 01:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C328471A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 23:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43474383B5;
	Wed, 10 Apr 2024 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUoIdMUf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB7EC8DD;
	Wed, 10 Apr 2024 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791435; cv=none; b=o1qGsusIT7DM5YMNIZarSpWUis20/3imHht9SRGCmULMy5rt0x8ndZ/ap3mboKKAUaSMTaeSV9yeft96aYdhMjBo/C5SU2FjwN9Abm3UUg5EwlamRwHqg64vEDJnxAcA2YIZSt/gKOl4IdZNWaljEs+WOE6h+t1BKWLJBtWuDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791435; c=relaxed/simple;
	bh=E3Miwh3he99yG5NhScfIq3a5E86kZ8yAPEI3XNgclj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY2uFhomNHpinjSvuh8hGIPhKGlAr/aHSfff5P9GnLFoFYJOuYaEL+YDuH4/lMn/JSPDFwZXxGchDgi2iXxWTsKEpZAGcH5KJxwiypcs+LbRXCOvAj0rmenAEdzqYM7HWx/45E3ktgj6NGgorIawBlIjxlIlF30N2K/XChymXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUoIdMUf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712791434; x=1744327434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E3Miwh3he99yG5NhScfIq3a5E86kZ8yAPEI3XNgclj8=;
  b=iUoIdMUf0/WE5F5o3qkHEgiWCdHO+dFaibeWbRcAZWHi6FywXgcnNy0h
   svuby1tfE04g3docv6i+6Py51d4G/sA14GEvpQj0M7r+FCENSlbwoNmAZ
   rbqm6CfYJCA9HbFdv1YNFhWZCl816yoFssfBxnu7NXWP8Qa9oGBIwpFr5
   xY8CsAoyygPa43fVSXm6UamEzw533zyhZxh+u29vgfagHa9ouP/ra4sru
   g6lC8+A9U4hyUmk5yaxgHHOmXOnzzGv/G9w5GyI3ld9v3CW8R1uVpBcom
   wRQBYcKLFTZGGwnp87pTjRKm6PaDf4Dgx8whzCyw8lDnxL7OfzpkUbjNx
   g==;
X-CSE-ConnectionGUID: 8hTBxfs/RJy/c5+ujvEXqA==
X-CSE-MsgGUID: D+Bkb9H6TEmoECSIe/VEvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18894710"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="18894710"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:23:53 -0700
X-CSE-ConnectionGUID: LThPOoZISBepWxIsR/IWcg==
X-CSE-MsgGUID: E1TlXYYZTDm/1hnZCgfFdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="25357126"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.230.146])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:23:52 -0700
Date: Wed, 10 Apr 2024 16:23:51 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/26] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <Zhcfh/V0qI5vnMVJ@aschofie-mobl2>
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

On Sun, Mar 24, 2024 at 04:18:16PM -0700, Ira Weiny wrote:
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

snip

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 12cd5d399230..ef482eae09e9 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c

snip

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
move this..

> +			cxl_disable_dcd(mds);

to after you've done the disabling...

			dev_err(cxlds->dev, "DCD disabled: failed to get interrupt for event log\n");
> +			return rc;

not sure I got the words right.

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

Similar here - 
Maybe better to disable, and just say it's done because this sounds a bit like a request to the user.

> +			cxl_disable_dcd(mds);

			dev_info(mds->cxlds.dev, "DCD disabled: no interrupt support\n");

How come this one is dev_info() and prior case of disabling was a
dev_err()/


snip to end

-- Alison


