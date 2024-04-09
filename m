Return-Path: <linux-btrfs+bounces-4039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A6F89CF86
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 02:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161AE284F6E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D0F5660;
	Tue,  9 Apr 2024 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRsLvak+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162A15C3;
	Tue,  9 Apr 2024 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712623405; cv=none; b=YZO4bn29OwEAMjmgiPrwusjLu5QjXOtPO7aGnSoOZFxyKgFWdrOpjvrDfAWSFu7UhymVGLxH5aGnj8w4rV0xz7NpIUqLPi/9EpFhwNA7qy6hpwBr5i1jPo+Bt5sO2hTNLXFKo8TLKbELGdYX8bAuAOGZ3MnKIVjS8kq9gSiEl7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712623405; c=relaxed/simple;
	bh=1aI4ho1DPT61jrjNxaxtPRo7yIfF3GJHyqhXxYEgWW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLw5A6GE3Mo7gLj3jj0HYPTomPfFIVNzxeNb0apAVW+22FXB9xO13YPNF3GhosE86L3uy0d3QM6UrwOYsp6DEA5r/dhoCrzYQ59qdhhX8XSF8LD8N807GykbdCo7VbZF3EzubdBR8ZaylaxEKkiBIOWr7YAG/aHxNZaxFmD87zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRsLvak+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712623403; x=1744159403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1aI4ho1DPT61jrjNxaxtPRo7yIfF3GJHyqhXxYEgWW4=;
  b=lRsLvak+taU5UISTP2XaKB+2PhqarYSPLOK5Ky2gliAh9Y66ii6FD0Cx
   pv7ALibJecD+oo9XM+Gg6g0IZFQQIq4g8uFb/axnVt4PQY7XWIBu5xj6w
   /QDKv5NF3/1kTdwsv3V3NhsuX7BzSaIuepu01C1TYIp0r+AWiRlQCmJDj
   mwdmYCqkBpkmcXsDJiXqczdAqMdsLcoxlshHpt/pcOp/BQP3JA31laNwn
   j7uJKLpJgmGkvibz7oJj7cvRRjbDYldxdBEJZa87a8BZZCkTT8NmvqTg3
   1fZ1lwDqNoHRSECPV23+yY32plLO8Am9dAYUFqn4dlxetUuKLJkc1lVin
   A==;
X-CSE-ConnectionGUID: 7o0jA+HNTC6ou6hKSBK6RQ==
X-CSE-MsgGUID: jg2FauJBRweVxKAUwGGFKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19075140"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="19075140"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 17:43:17 -0700
X-CSE-ConnectionGUID: ASMfITtESEWg+r1BXJk1PQ==
X-CSE-MsgGUID: LTqIP4DKSSqjEp1GmnW6AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24763419"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.37.24])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 17:43:11 -0700
Date: Mon, 8 Apr 2024 17:43:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Message-ID: <ZhSPHvoTHl28GXt1@aschofie-mobl2>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:08PM -0700, Ira Weiny wrote:
> cxl_dpa_set_mode() checks the mode for validity two times, once outside
> of the DPA RW semaphore and again within.

Not true. It only checks mode once before the lock. It checks for
capacity after the lock. If it didn't check mode before the lock,
then unsupported modes would fall through.

> The function is not in a critical path.

Implying what here?  OK to check twice (even though it wasn't)
or OK to expand scope of locking.

> Prior to Dynamic Capacity the extra check was not much
> of an issue.  The addition of DC modes increases the complexity of
> the check.
> 
> Simplify the mode check before adding the more complex DC modes.
> 

The addition of the DC mode check doesn't seem complex.

Pardon my picking at the words, but if you'd like to refactor the
function, just say so. The final result is a bit more readable, but
also adding the DC mode checks without refactoring would read fine
also.

and...a bit spacing nit below -

> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
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

delete extra line

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
insert blank line
> +	return 0;
>  }
>  
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> 
> -- 
> 2.44.0
> 

