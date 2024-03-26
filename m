Return-Path: <linux-btrfs+bounces-3618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBE488CB45
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 18:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1997308BF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E544C63A;
	Tue, 26 Mar 2024 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJ70/IdX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782C1F947;
	Tue, 26 Mar 2024 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475223; cv=none; b=UqAChL9HgxmDkupsDyUhZLUD2tftqNmN8wAX/jVxINUT9umZ6919oRi15ljNWtt4tv6TSekSjpXjZobLOx/xH1N6T1ncMM3af/WoBDnf0NT7VVGe6+Jrlu7vzd8DRRB/OFwnPwYFYWUfsEgwdK/kTpTUwxfeFKKh7E7M4CschN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475223; c=relaxed/simple;
	bh=OH8Qcawkekbg6pcnA21z3HohYq8UPhZ0okXs6Jts+Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/USPs+qUnPfUmwDRlIwQ7VaPon0nID6LiMl11l4O+a80Q5cCW6caKT3EL6UiiAWD2KAZYajrFbZt8gwpkfIU/N1/luv9ObKmoxLFsQgp1mxPV6ktX4zxjNUtswTLUL/tnvqb241or/fpZdEPbfmHzUFWB4Y0735o1WHxyBZZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJ70/IdX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711475222; x=1743011222;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OH8Qcawkekbg6pcnA21z3HohYq8UPhZ0okXs6Jts+Sk=;
  b=JJ70/IdXU2fVE77FJthM3hbqid94GDSP+Vkd0qBvuLcBXsqvRGXLBIeQ
   sMshJp1NCDRXnh9KARjyDVedbOnHc+T1UMpNUpc+E6nlUn/8M5Meb9Bid
   WIPSaTQG5OpbEPT63Zb+RWQLO8Lak6qhVR/Q7KashyavCF7elWb54N00O
   p8UVFFMKR5qcwq5ZLvlrM6I0EFn3mVLTl7NiSxe79Ty1qcd0tDwLvy3A4
   PDTGV/uV6/+q0T+j0GDvo4lkn8qQeYq+1wveYU9OaUBLhR3jzyjl7u5er
   WKE1gCMh1X+piP4/BAaUKixvKP/+m57F72FVmlCDkRwNQaCNjKkXf/+vq
   Q==;
X-CSE-ConnectionGUID: ZWFZG+RWS1uuVwYhLU0hag==
X-CSE-MsgGUID: f2tDbwEWRs+eG1nIqLlAWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6408545"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6408545"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:47:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20735657"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.112.247]) ([10.212.112.247])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:47:00 -0700
Message-ID: <922007a0-3f85-4a40-80e4-5c906e6dd2c8@intel.com>
Date: Tue, 26 Mar 2024 10:46:58 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
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
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, Ira Weiny wrote:
> cxl_dpa_set_mode() checks the mode for validity two times, once outside
> of the DPA RW semaphore and again within.  The function is not in a
> critical path.  Prior to Dynamic Capacity the extra check was not much
> of an issue.  The addition of DC modes increases the complexity of
> the check.
> 
> Simplify the mode check before adding the more complex DC modes.

I would augment this by saying simplify "by using scope-based resource menagement".
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Changes for v1:
> [iweiny: new patch]
> [Jonathan: based on getting rid of the loop in cxl_dpa_set_mode]
> [Jonathan: standardize on resource_size() == 0]
> ---
>  drivers/cxl/core/hdm.c | 45 ++++++++++++++++++---------------------------
>  1 file changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..66b8419fd0c3 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -411,44 +411,35 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
> -	int rc;
>  
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> +		return -EBUSY;
> +
> +	/*
> +	 * Check that the mode is supported by the current partition
> +	 * configuration
> +	 */
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
> +		if (!resource_size(&cxlds->ram_res)) {
> +			dev_dbg(dev, "no available ram capacity\n");
> +			return -ENXIO;
> +		}
> +		break;
>  	case CXL_DECODER_PMEM:
> +		if (!resource_size(&cxlds->pmem_res)) {
> +			dev_dbg(dev, "no available pmem capacity\n");
> +			return -ENXIO;
> +		}
>  		break;
>  	default:
>  		dev_dbg(dev, "unsupported mode: %d\n", mode);
>  		return -EINVAL;
>  	}
>  
> -	down_write(&cxl_dpa_rwsem);
> -	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Only allow modes that are supported by the current partition
> -	 * configuration
> -	 */
> -	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
> -		dev_dbg(dev, "no available pmem capacity\n");
> -		rc = -ENXIO;
> -		goto out;
> -	}
> -	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
> -		dev_dbg(dev, "no available ram capacity\n");
> -		rc = -ENXIO;
> -		goto out;
> -	}
> -
>  	cxled->mode = mode;
> -	rc = 0;
> -out:
> -	up_write(&cxl_dpa_rwsem);
> -
> -	return rc;
> +	return 0;
>  }
>  
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> 

