Return-Path: <linux-btrfs+bounces-4113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B6289FDB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69AB1F21AF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574661802B3;
	Wed, 10 Apr 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMBEOvam"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803F17F384;
	Wed, 10 Apr 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768610; cv=none; b=YCrF7tiKZWp8AAGvnkIz1CUQNHL4PBEXfjVnvudkyS3S/7p+zxzy7XRmw640ND9j6Yher2s/jAYvmywZPLl7f3T6n8HeKqAl4+M9Ljl6tX3vjRlPkvGA5kz1h3d8UkxVUzsOadTwUwwt8h+KkcSL4Sh4qValBzQfT5FbJlDOhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768610; c=relaxed/simple;
	bh=lq5Wl2+Nx/P1XJbW6AnAEtWNNXOhlT5G1jfm1WEuLfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icHVsB4dC+x2VHCW0O5AIHToA2BIXkmYRbB86jE3Jotm6S1IM2npSuObXmqaOvWhbdylXeFIxQLpjHCtxmLB9/h3+mvuvlnIhQyAdvmBeIBeX2YBWrthxNYVmed+zX22gc6JxfmoeINnN/ZqBcVqZvxrlPpkUr64RfBxREXMFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMBEOvam; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712768608; x=1744304608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lq5Wl2+Nx/P1XJbW6AnAEtWNNXOhlT5G1jfm1WEuLfU=;
  b=cMBEOvam8Esy8E8e1JEScBcYnr1dOfvIuqNnhQ7fXyuDiYWchoeK4ha4
   BJWdZ/I7MRVIQlLr2f57Do7nJT07mEKpgPwW2834PH2Ld4nEAp2nt6fpq
   zXYSQLNGaGb79b7FCBJNWNgd4GGUMKBFSo+FgxmaU9nSN+3YQpEC5PdVa
   oMwosMjNrxIGUiTZq9EkNoCJMwJkkJkMN1P5ScP4L1nuM/1fqL+NfD/ND
   uIyCRhHRfekPAmIvkoR7fX+F753W4eOwB2o6q1VJK0+ee36p7RXOAV4s1
   vLM5yz72HeTDTJY3/jjnCXAUToJGSyMnsqOqBCPndG3sDt2IWqB3xRT+I
   g==;
X-CSE-ConnectionGUID: utnWHNjwQVOBkmhXcIKUAA==
X-CSE-MsgGUID: iWPcOT2US1qbHxY9XSxKZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18858507"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18858507"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 10:03:27 -0700
X-CSE-ConnectionGUID: wlfn6evvSG6s0Um4MA+UeQ==
X-CSE-MsgGUID: tAWPm7jcSmSkDcpua7cm3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25111440"
Received: from rsterlin-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.230.146])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 10:03:26 -0700
Date: Wed, 10 Apr 2024 10:03:24 -0700
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
Subject: Re: [PATCH 23/26] cxl/mem: Trace Dynamic capacity Event Record
Message-ID: <ZhbGXMh4q3+7ymKS@aschofie-mobl2>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-23-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-23-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:26PM -0700, Ira Weiny wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> CXL rev 3.1 section 8.2.9.2.1 adds the Dynamic Capacity Event Records.
> Notify the host of extents being added or removed.  User space has
> little use for these events other than for debugging.

Is there really any 'Notify' going on here?

Can you state the usage in the positive, rather than saying it has
little use. Is this the only method for users to track this activity.

If it were just for your kernel debugging, I'd guess you'd just throw
in more dev_dbg() messages.

I see 'dpa_start'. Will we need to do any dpa->hpa translation work
here?

--Alison


> 
> Add DC trace points to the trace log for debugging purposes.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
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
> -- 
> 2.44.0
> 

