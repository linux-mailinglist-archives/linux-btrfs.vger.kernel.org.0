Return-Path: <linux-btrfs+bounces-3673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B3188ECC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B020A1C311BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D014E2CB;
	Wed, 27 Mar 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtyJ5bs8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070C4E1C8;
	Wed, 27 Mar 2024 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561142; cv=none; b=T5nU66QD+CAzTyinzQsE40EwjdPDJOta5mIb4tnZ3MhODK97TnA0ar7ZzX+8ygoRVeYWUEBSt4VkORhUOdjCamVO/u1sb5qBpRkp7I8WVpIfcS5RW9UMEHIzrcXb+sbq1Yj0P1ONVRtr8iiBc5T0gErfSuV/O+m5b+JlVivQiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561142; c=relaxed/simple;
	bh=9xvaJ/dsTe/lDDX65qEa0ml4lL8d7eAMeKHcjtED0DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuFqlrU6sPhqKHaYiabSy1Ej7lu1kFws1IaEMzOEDnpXQeVJl6FcPAL8qmsPLJe6c7igZr7I/ibzQnAgiIpMt6Fbm2lONHjnqh/s9HNzF4Z52RMRqNHi1yoSvnh4ePqgPHf2ARp9l5vDxDocmCqqZ/B4oFo54wExwb+x6RQoHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtyJ5bs8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711561142; x=1743097142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9xvaJ/dsTe/lDDX65qEa0ml4lL8d7eAMeKHcjtED0DQ=;
  b=KtyJ5bs8qQWlzhLKOxUGH6CD38dDQS2sYJxyvjoihbOBD5FCi2vnkXpt
   NhwwPte2Z/KqteTPZRtjHG3G1lXXgcCBgry0vzQ4zQorK1ODfJrOT333u
   mgl1kpCOGGEP+Ljkl321qZXO3x1/dYSHFQ2JXie0Y13LLBlxV6bHK6rmJ
   TP+grG/yIjdf4atk2eHpVzIxfs2IBdNXgF2Ie+XMiUgscZagi3G1XPi6i
   mVeBi4ymAwcmxY9igmJHUlOn7QyQe9oUVu+TAbeQ5X4A9jTOgNAi7S7MR
   xmpkXQBIWpi6C7o7IDjVu60TL7M3QQC8DrMWpUBM4Y/X1IM/sjFOWpZ01
   g==;
X-CSE-ConnectionGUID: JK/qTTPmRG6hHADM0pVuJg==
X-CSE-MsgGUID: BzXqtVnnTPW9BrsG6bAzFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17824637"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="17824637"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 10:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16997987"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.56.222]) ([10.212.56.222])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 10:39:00 -0700
Message-ID: <3935e09b-5dfc-488f-84fb-69fb5707b1cc@intel.com>
Date: Wed, 27 Mar 2024 10:38:59 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/26] cxl/pci: Delay event buffer allocation
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-11-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-11-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, Ira Weiny wrote:
> The event buffer does not need to be allocated if something has failed
> in setting up event irq's.
> 
> In prep for adjusting event configuration for DCD events move the buffer
> allocation to the end of the event configuration.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index cedd9b05f129..ccaf4ad26a4f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -756,10 +756,6 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  		return 0;
>  	}
>  
> -	rc = cxl_mem_alloc_event_buf(mds);
> -	if (rc)
> -		return rc;
> -
>  	rc = cxl_event_get_int_policy(mds, &policy);
>  	if (rc)
>  		return rc;
> @@ -777,6 +773,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_mem_alloc_event_buf(mds);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_event_irqsetup(mds, &policy);
>  	if (rc)
>  		return rc;
> 

