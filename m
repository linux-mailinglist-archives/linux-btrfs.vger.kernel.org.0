Return-Path: <linux-btrfs+bounces-3613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A188C975
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3411F81D6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C4D17543;
	Tue, 26 Mar 2024 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQpj/nRc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733F01BC57;
	Tue, 26 Mar 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470899; cv=none; b=uhY10riWLNReySWLxHbcFgyrXYPplSx104mykSSN6k8oMVWwVAo6+TNllVQUndgB13D1IG3ZgC0IpZ9/vLqh1Lj+9ZR98GRrarTvOsDICTTRtYWNF/2I0+vrvGXDUyRjUejMdSNeeYz9o4rUuVevgQYbeceNoJgw0qN7uBBwW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470899; c=relaxed/simple;
	bh=DE3oNnKuz0aiUY3ZFWUx0oolPPxdDJ8Is3O1FCFB8kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uC1WK4j5miV6WI2rEwbGrDTrEibYqVpij3y0CDM/PO/WdihAZ3uLuqydzjkdCOKCmJHyhSxxClxeV1jnrhDDmFytQ77g+Guj7dn81s7j8rXT0V7vRhf/NjQi4ZftboepPi6WeFkZMq+jv6Rva/R6MAmKxGmOCe3nzRnfbs9s1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQpj/nRc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470898; x=1743006898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DE3oNnKuz0aiUY3ZFWUx0oolPPxdDJ8Is3O1FCFB8kg=;
  b=mQpj/nRcl6SczcRR2UhagJmHlhWndFEXFdWLgGoZWFlMUSq455Eo9hFN
   H9F6IGhedyDrgqHSgCqpdpQ+XJkPGri/sSb2aaHQFRv2QuOnoZ6Tp1ski
   LHXcy3WiM1byP7OSgB6cy4VvFF0QoUQGNPolaWi5Qmvdkagcj5pmkgAMu
   QHmGXXC6YNJrvk6snl7djjWnbbdP8Edmv1xpMAI8/3EnEsiO5tYGUJFFo
   ic9i7sYiuHVyJsuKc+OH9Yt8hak4QEeHtoOa1BYPsTZwJWnaZg/f5MOYW
   mVOeNrBgyD8wm+nocr3svkkNrhvOPBI7OTxOMD3lpOf/587loLCUIJtW2
   w==;
X-CSE-ConnectionGUID: KJZMQIhAQ8i5CY5jt4ZzrA==
X-CSE-MsgGUID: IPln4vwMSlWPY8Tw2CWb2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17265473"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17265473"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16072989"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.112.247]) ([10.212.112.247])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:34:47 -0700
Message-ID: <d3bcac81-35ee-4876-8f2c-6c66a7fdd960@intel.com>
Date: Tue, 26 Mar 2024 09:34:46 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/26] cxl/mbox: Flag support for Dynamic Capacity Devices
 (DCD)
Content-Language: en-US
To: ira.weiny@intel.com, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-1-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-1-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Per the CXL 3.1 specification software must check the Command Effects
> Log (CEL) to know if a device supports dynamic capacity (DC).  If the
> device does support DC the specifics of the DC Regions (0-7) are read
> through the mailbox.
> 
> Flag DC Device (DCD) commands in a device if they are supported.
> Subsequent patches will key off these bits to configure DCD.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

small formatting nit below

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
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..ed4131c6f50b 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -161,6 +161,34 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
>  	}
>  }
>  
> +static bool cxl_is_dcd_command(u16 opcode)
> +{
> +#define CXL_MBOX_OP_DCD_CMDS 0x48
> +
> +	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
> +}
> +
> +static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
> +					u16 opcode)

This seems misaligned.

DJ

> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_DC_CONFIG:
> +		set_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> +		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> +		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_RELEASE_DC:
> +		set_bit(CXL_DCD_ENABLED_RELEASE, mds->dcd_cmds);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static bool cxl_is_poison_command(u16 opcode)
>  {
>  #define CXL_MBOX_OP_POISON_CMDS 0x43
> @@ -733,6 +761,11 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  			enabled++;
>  		}
>  
> +		if (cxl_is_dcd_command(opcode)) {
> +			cxl_set_dcd_cmd_enabled(mds, opcode);
> +			enabled++;
> +		}
> +
>  		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
>  			enabled ? "enabled" : "unsupported by driver");
>  	}
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 20fb3b35e89e..79a67cff9143 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -238,6 +238,15 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>  
> +/* Device enabled DCD commands */
> +enum dcd_cmd_enabled_bits {
> +	CXL_DCD_ENABLED_GET_CONFIG,
> +	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> +	CXL_DCD_ENABLED_ADD_RESPONSE,
> +	CXL_DCD_ENABLED_RELEASE,
> +	CXL_DCD_ENABLED_MAX
> +};
> +
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

