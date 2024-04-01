Return-Path: <linux-btrfs+bounces-3812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D583389448E
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 19:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1151D1C217D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975A15103E;
	Mon,  1 Apr 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ0nbBF8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70D51C2B;
	Mon,  1 Apr 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711994187; cv=none; b=h3hbd/VfwyiIp2RBHiOPInAbwcLQ5H/KGAohJuYtgNaVw1gkRSdSwSHsGDdyTe2qzLgzhQWvAJqbk5YNj2kF0wLXvh8+vYcAqXsHTQ2xKrRoUxiqDnNht5nhiq3S7E8rhbe9tBuDY6v/qwqKAYQ7JmzhJz4D13ZWfMnPzl6zwTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711994187; c=relaxed/simple;
	bh=j95tFIo4/eRVdfaUBkxCGG3P+3iJymcsi9ZPT1Ohsd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZqdNKFgYfZx8zvGk6726KcWqEfZFa8cMr0VAd08utCR83wDoYwbn7m8c7R0P+HIJsEhriqda0nfRrh4cNuI0aQ1I2zOkswyMRg/3ap3l76omwn14vvw5GbUxtLDX4f87SCu08W9L+pbFbPn5lHmeFRohrUfmOHuyrBfMb9Nxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZ0nbBF8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711994186; x=1743530186;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j95tFIo4/eRVdfaUBkxCGG3P+3iJymcsi9ZPT1Ohsd0=;
  b=QZ0nbBF8U28jIYAtnLwvaWHbN7Jxe77WF2Lvqjo0wByezzTItnJ9fM96
   x5v0kWcAN+CBL8a0Tb6Mivx5yDYB4u0wh/4lwJ+f+MBt77t5I61j6Q+iD
   AsSENs2d8BmsWp89mtoB/G5Y7AVdxMi1NU0fAH2eRuJ4CAuvUZ/TfEK7M
   aAONCoFfiOoMB8/JGvygF1/FtsPOdSzSbN43FTnpTwYZQ8kJ3iPhhAdFl
   DUcxsq+fbd5cLiEPsw9s8MBZz/gGH3JoWrqYVFvBXb+VJBhQRDhxZ0jyM
   wgbH1hYXzSwm3WNV681peffztJ6yd1NrK+M9YageENaP3opz9LjYiw9Kc
   A==;
X-CSE-ConnectionGUID: +iav1qHOT5eBp0xxZZuIpw==
X-CSE-MsgGUID: usEmmJnJRFWovnhj61s4UA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="6989280"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="6989280"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:56:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="22250093"
Received: from mthansen-mobl.amr.corp.intel.com (HELO [10.212.113.134]) ([10.212.113.134])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:56:25 -0700
Message-ID: <06314147-49d2-419b-842e-fb34f6901c39@intel.com>
Date: Mon, 1 Apr 2024 10:56:24 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/26] cxl/mem: Trace Dynamic capacity Event Record
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
 <20240324-dcd-type2-upstream-v1-23-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-23-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> CXL rev 3.1 section 8.2.9.2.1 adds the Dynamic Capacity Event Records.
> Notify the host of extents being added or removed.  User space has
> little use for these events other than for debugging.
> 
> Add DC trace points to the trace log for debugging purposes.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Changes for v1
> [iweiny: Adjust to new trace code]
> ---
>  drivers/cxl/core/mbox.c  |  4 +++
>  drivers/cxl/core/trace.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7babac2d1c95..cb4576890187 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -978,6 +978,10 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		ev_type = CXL_CPER_EVENT_DRAM;
>  	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
>  		ev_type = CXL_CPER_EVENT_MEM_MODULE;
> +	else if (uuid_equal(uuid, &CXL_EVENT_DC_EVENT_UUID)) {
> +		trace_cxl_dynamic_capacity(cxlmd, type, &record->event.dcd);
> +		return;
> +	}
>  
>  	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
>  }
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index bdf117a33744..7646fdd9aee3 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -707,6 +707,71 @@ TRACE_EVENT(cxl_poison,
>  	)
>  );
>  
> +/*
> + * DYNAMIC CAPACITY Event Record - DER
> + *
> + * CXL rev 3.0 section 8.2.9.2.1.5 Table 8-47
> + */
> +
> +#define CXL_DC_ADD_CAPACITY			0x00
> +#define CXL_DC_REL_CAPACITY			0x01
> +#define CXL_DC_FORCED_REL_CAPACITY		0x02
> +#define CXL_DC_REG_CONF_UPDATED			0x03
> +#define show_dc_evt_type(type)	__print_symbolic(type,		\
> +	{ CXL_DC_ADD_CAPACITY,	"Add capacity"},		\
> +	{ CXL_DC_REL_CAPACITY,	"Release capacity"},		\
> +	{ CXL_DC_FORCED_REL_CAPACITY,	"Forced capacity release"},	\
> +	{ CXL_DC_REG_CONF_UPDATED,	"Region Configuration Updated"	} \
> +)
> +
> +TRACE_EVENT(cxl_dynamic_capacity,
> +
> +	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> +		 struct cxl_event_dcd *rec),
> +
> +	TP_ARGS(cxlmd, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +
> +		/* Dynamic capacity Event */
> +		__field(u8, event_type)
> +		__field(u16, hostid)
> +		__field(u8, region_id)
> +		__field(u64, dpa_start)
> +		__field(u64, length)
> +		__array(u8, tag, CXL_DC_EXTENT_TAG_LEN)
> +		__field(u16, sh_extent_seq)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> +
> +		/* Dynamic_capacity Event */
> +		__entry->event_type = rec->event_type;
> +
> +		/* DCD event record data */
> +		__entry->hostid = le16_to_cpu(rec->host_id);
> +		__entry->region_id = rec->region_index;
> +		__entry->dpa_start = le64_to_cpu(rec->extent.start_dpa);
> +		__entry->length = le64_to_cpu(rec->extent.length);
> +		memcpy(__entry->tag, &rec->extent.tag, CXL_DC_EXTENT_TAG_LEN);
> +		__entry->sh_extent_seq = le16_to_cpu(rec->extent.shared_extn_seq);
> +	),
> +
> +	CXL_EVT_TP_printk("event_type='%s' host_id='%d' region_id='%d' " \
> +		"starting_dpa=%llx length=%llx tag=%s " \
> +		"shared_extent_sequence=%d",
> +		show_dc_evt_type(__entry->event_type),
> +		__entry->hostid,
> +		__entry->region_id,
> +		__entry->dpa_start,
> +		__entry->length,
> +		__print_hex(__entry->tag, CXL_DC_EXTENT_TAG_LEN),
> +		__entry->sh_extent_seq
> +	)
> +);
> +
>  #endif /* _CXL_EVENTS_H */
>  
>  #define TRACE_INCLUDE_FILE trace
> 

