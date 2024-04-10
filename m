Return-Path: <linux-btrfs+bounces-4117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E689FF91
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 20:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B1A1C232F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F1180A84;
	Wed, 10 Apr 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5kT48PE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC4F1802C9;
	Wed, 10 Apr 2024 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772938; cv=none; b=RQw1+B6xaNQt+MdyOVBBhoBc71s57UpSxUfLP7xPgCGxRSO7DZmq3SnXfGTwimHTsIBdzF9iQA43WLgj4Bq1NKaSyRJjZEKpfiopjd+t5pjkf5JL0aIvjvrtmppKNYE2sLLKkRQTwD7NsLYcowsd0ewmKOsRd+IwDbOZSw0Qi+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772938; c=relaxed/simple;
	bh=f8a/TLwsLee1zdQDc56/1tetJJOm12AaYUksCA+5quQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3uHZaIzInQOoZVgAH1NL6WdPn/gzR9zDrkvBuXZe6OWrYVteQxbxKYRdQttET1USm+2Tu6Eh+5dFtjoSplU3ltJPxv2GwZaGU0pGJBELGg5s+Dbs59Fv+3xNurjcdZd7sg0PcP4gNV/GZPwG7Q65LtPztf1dCX+/YaJWrNHJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5kT48PE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712772935; x=1744308935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f8a/TLwsLee1zdQDc56/1tetJJOm12AaYUksCA+5quQ=;
  b=l5kT48PEFSzMc84ohP762sEtE2L7iB7euMTsJe/psGLuimzNjWDoHaee
   TlZ83QlMVkxAuCzWZNzlXwLh+tEidjH5Z2lm6OydmHh6ETzrLiB7MoeeM
   kxjTxo3fJglsrbYoK+uDvwnnIFTiIegXW4LO2OPIHDO/rpndWDxp7Lfsj
   NUKZi/1PJqWe+wODSh827sW4Bd+v1O3p1vXjQoiAVhHVtCZA4go8XZ5yy
   KQUZmxTEVTRCDkViUiWJI6/tyUBoprXenAwy5GlZyjQefGCINBqbcxWaZ
   0/zkYvXC0Rpj8nnr1rV16m7ljOTqGZ+SfSchUai3V2BQ/QS3J05DrLRCT
   g==;
X-CSE-ConnectionGUID: keUz0/w5Qmaf6deUCocCTQ==
X-CSE-MsgGUID: SwNsv0N3SJCFZ2oxhTyZpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18759298"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="18759298"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:15:34 -0700
X-CSE-ConnectionGUID: jZZoytjVS6mnXiysOWcfNg==
X-CSE-MsgGUID: GAuSsfWBRg2/hfigVtzpKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="58070512"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.230.146])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:15:34 -0700
Date: Wed, 10 Apr 2024 11:15:32 -0700
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
Subject: Re: [PATCH 01/26] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <ZhbXRL16cneVXxpw@aschofie-mobl2>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-1-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-1-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:04PM -0700, Ira Weiny wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Per the CXL 3.1 specification software must check the Command Effects
> Log (CEL) to know if a device supports dynamic capacity (DC).  If the
> device does support DC the specifics of the DC Regions (0-7) are read
> through the mailbox.

Do I need to know this 'If the device...' piece to understand this
patch?  I like that below you say 'Subsequent patches will...'
That seems enough to set the scene.

> 
> Flag DC Device (DCD) commands in a device if they are supported.
Why be vague w 'Flag'. How about 'Add a bitmap of DCD enabled
commands to the driver device state structure.'

> Subsequent patches will key off these bits to configure DCD.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes for v1
> [iweiny: update to latest master]
> [iweiny: update commit message]
> [iweiny: Based on the fix:
> 	https://lore.kernel.org/all/20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com/
> [jonathan: remove unneeded format change]
> [jonathan: don't split security code in mbox.c]
> ---
>  drivers/cxl/core/mbox.c | 33 +++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 15 +++++++++++++++
>  2 files changed, 48 insertions(+)
> 

snip


>  /* Device enabled poison commands */
>  enum poison_cmd_enabled_bits {
>  	CXL_POISON_ENABLED_LIST,
> @@ -454,6 +463,7 @@ struct cxl_dev_state {
>   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
>   * @mbox_mutex: Mutex to synchronize mailbox access.
>   * @firmware_version: Firmware version for the memory device.
> + * @dcd_cmds: List of DCD commands implemented by memory device
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only

It's not a 'List' it's a bitmap. How about mimicing 'enabled_cmds' 
description:

* @dcd_cmds: DCD commands found enabled in CEL

>   * @total_bytes: sum of all possible capacities
> @@ -481,6 +491,7 @@ struct cxl_memdev_state {
>  	size_t lsa_size;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>  	char firmware_version[0x10];
> +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	u64 total_bytes;
> @@ -551,6 +562,10 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_UNLOCK		= 0x4503,
>  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> +	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
> +	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
> +	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
> +	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  
> 
> -- 
> 2.44.0
> 

