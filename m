Return-Path: <linux-btrfs+bounces-3568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF6188B3C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 23:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2807E1C3F74E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C5274404;
	Mon, 25 Mar 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktmjtw6O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3376D70CC2;
	Mon, 25 Mar 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405008; cv=none; b=jnHJiRkk+1BVgLwEbQIBFA5KV/LU7duzI+NUBC2oUbs25J0FEALpdJGz1J1TSTGduAqQqPYtfxpNzbT3gK6y9TtsahweUjH5HSFgSPI3He66Q+ZGxUbwznyQEuVLJaK4GbCXVt/zwJ/jAs3nFNh9dJSaYvQx32t13b7vSPoRwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405008; c=relaxed/simple;
	bh=nr56uDI4dsTykVLBSLuHrShEGXRxM84RwQ2Wm2KBo9I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBGnz8nbJ7yVGjNKOvX73YTcfHnDlrTsO28y+pP2qi4fe5mprlJwNgZTbKk3134TNW/mjMq/lzqTNIJaR0kAHZFPA6/Wa30K+aLq2x29LYhu1Mm2ZnyG+8T33sUAVEVNEJY8LM0hZEgOa+VHhmmhQPpJnKIU8RvqZ+eDSZOWhjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktmjtw6O; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so1223512b3a.0;
        Mon, 25 Mar 2024 15:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711405006; x=1712009806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWDVUXHZy1dy1NggSOObsYezisgpNSCRe/ZyyTRQIgA=;
        b=ktmjtw6OxFJHhGdEmxRGzHHqA9waJz0BwQeh3jaZ+zWmaHd4mQAQZoJxP846EitHhY
         JXrwFgKfb+YCTcafSdUfffckh+NcZfrKuN6PXZcnG/Jti9ytkXxE3DQjWPzCcV8L1NA4
         A6TXXPQhuydzDs2WjFbQ7i83dNwDRx57kwHbyhdyNyCLQ0Hb16RAuHNo2Fn/3D9bIbpJ
         3CEZlxwSykPIUoyck3LzmMc17/hChaHdmRpl54YZupXqT8/Ul0a5d01RpY79XgcbpnQ7
         OYcVcuUDnEaSv0aAT6QVX6x97bH5NgYHLgy9qbvB/ur78dsWCJbX9SROQm26sdBVFqKN
         HJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405006; x=1712009806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWDVUXHZy1dy1NggSOObsYezisgpNSCRe/ZyyTRQIgA=;
        b=sb4bRW4WQ7AT+RABzKQdiZzCNqAEJJD/on6wFIRTFyTJgdifXwWb3GiCJO+EHTfaYO
         a5TohW2l+1UVP3wnnmJuwgpy+Bfh5YuZMIy5mHHDpheQteryEZkInxxbnUIL4mQzKwT3
         SLhOMLNzVpuy1bOib9J8okqmeyAtKwcSCkiybJrmcyNKXFALMhUUtS2ixEViT/CiyHDj
         22u2cSCi7YGWD6Q9wJd1/7jF8PwfARPilNJsY0svPb5ED1SiHoYEV0F7Sis/Fb9P47Lk
         Af1h2g9NB+rV00n7dt19+AchZe4RJpr61ILC7MTlw3cGS9EK9gxfJPL32Y6VO/PE7ESQ
         IqUg==
X-Forwarded-Encrypted: i=1; AJvYcCX0R5ca4ocXfBsGeUR/IZdcjLBcDVgVadQBo43Po58Yr5wbVTmLczovKCFbqNwga1h1shZskuXf+b/L7ng8WBfTG2Fb74Tw/EiMAOBLjANMAh1xHGmIkHO2+ltPyGCdkMT64PHCmIWvHDFFWE255haFbbkJR9qXoKVpP9m6WEC9ezwVx3Q=
X-Gm-Message-State: AOJu0YwDQBykx1/bqCtxezEGzDIsOStJznf2UFyR9EcqEjO5DswsXFym
	TA8fZnCyJXsVyTrpJmfKxRZ/7g63rKiXWTOSASOj7dDh8/2RgoK6
X-Google-Smtp-Source: AGHT+IFoBmjnTGx2FKLWJkGlqytyAfXEM9ejP33L+WVDjrrUAyfpmzrKK59iB5rTkI1i9iTmb0o+vw==
X-Received: by 2002:a05:6a00:a0d:b0:6e7:82f4:d904 with SMTP id p13-20020a056a000a0d00b006e782f4d904mr11159603pfh.11.1711405006210;
        Mon, 25 Mar 2024 15:16:46 -0700 (PDT)
Received: from debian ([2601:641:300:14de:dbc3:c81c:2ddb:208c])
        by smtp.gmail.com with ESMTPSA id u2-20020a056a00098200b006e5a09708f8sm4737663pfg.174.2024.03.25.15.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:16:45 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 25 Mar 2024 15:16:20 -0700
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
Subject: Re: [PATCH 01/26] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <ZgH3tCnG0Bkljfdy@debian>
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

On Sun, Mar 24, 2024 at 04:18:04PM -0700, ira.weiny@intel.com wrote:
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
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

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
> -- 
> 2.44.0
> 

