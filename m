Return-Path: <linux-btrfs+bounces-3810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D428943A7
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 19:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE8DB220EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B24AEFD;
	Mon,  1 Apr 2024 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clcOuVE/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC938DE5;
	Mon,  1 Apr 2024 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991185; cv=none; b=GU1RjIrWFVidnJ3qkTG1j/oUwLnTeXH2oKFGLtXCWcHbDtmNNb2TNrXk+o1rMsLqA8hVoE+D/kyAQoC3Wz5H0ND3VCjz0F3nuen21/imOBznes16++CqxapKFihzYzNkTIbhBZQVnHN8QZxYe9Us+BbeqBOK+7DQtwldwUndh3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991185; c=relaxed/simple;
	bh=h2ZbhaU11eEghZqE4zHAMIx15+WcYQ2BJyK0q6cIcwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILTpTPWAgLsCvZXTUzODE8KO+3ByrHBF5EUl1Sg+osS7mCBAR+qDd6sXpIHoRf/2Nb/92o/0AFbJWM6wHvybFWgLCKRrVZQNY7w1EIIryHhKk3jm4LrUlNByXXIB/4GG4Ae91zqz5AAewx8aVVKtZ6E8GIy7MXNHtf2YkWnoQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clcOuVE/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711991183; x=1743527183;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h2ZbhaU11eEghZqE4zHAMIx15+WcYQ2BJyK0q6cIcwk=;
  b=clcOuVE/RBtawWH7sfEkqBDARTulWI7HzCpZQXA4iIYZhO7rrT6FxmTa
   +VXXOUG2S4Ec0eYq6ub7HC5QxiOYNXmCA1niv33d7UciQuKTNjQK2A6Dh
   VqHIpe3AvgX61fnrW2FmqXCxAslyK6zQP8B+vE+DHjQZG8aweay9WtwDS
   Wdw75xWP5/MHU29X9B1ijh2sn40EhcSRIQpxuJ89mOQ//LXoGqp7KPMpJ
   qipY9z4efH4Cw5ZOXVsXc+0JI+xdGFiuENrhOjcyE+msO3lPuInmzh8Ul
   kwaxrlxrizoaEFo6QjlNTYInBipumNqF7xJANQ66/ek1CxMgPbR+pP9r5
   w==;
X-CSE-ConnectionGUID: 5Utz2o90Qsui2vFFT0MkVg==
X-CSE-MsgGUID: xWAlSUpgTUGituzhbit2rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7317554"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="7317554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:06:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="22256672"
Received: from mthansen-mobl.amr.corp.intel.com (HELO [10.212.113.134]) ([10.212.113.134])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:06:16 -0700
Message-ID: <64a43062-b78b-472f-92be-82ff60eeb70c@intel.com>
Date: Mon, 1 Apr 2024 10:06:15 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/26] dax: Document dax dev range tuple
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
 <20240324-dcd-type2-upstream-v1-20-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-20-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, Ira Weiny wrote:
> The device DAX structure is being enhanced to track additional DCD
> information.
> 
> The current range tuple was not fully documented.  Document it prior to
> adding information for DC.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Changes for v1
> [iweiny: new patch]
> ---
>  drivers/dax/dax-private.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index c6319c6567fb..ac1ccf158650 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -70,7 +70,10 @@ struct dax_mapping {
>   * @dev - device core
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
>   * @nr_range: size of @ranges
> - * @ranges: resource-span + pgoff tuples for the instance
> + * @ranges: range tuples of memory used
> + * @pgoff: page offset
> + * @range: resource-span
> + * @mapping: device to assist in interrogating the range layout
>   */
>  struct dev_dax {
>  	struct dax_region *region;
> 

