Return-Path: <linux-btrfs+bounces-7286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0612955222
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 22:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042DB1C2165A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 20:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B541C5789;
	Fri, 16 Aug 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bakgKZfH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9C10E4;
	Fri, 16 Aug 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841928; cv=none; b=qdrSDthTRT0z6ck6WHBhysh9KxuW/IE7cQIOE1XEqDVigiTcyGolzM9rQQlpMjjOwfU7LkORpSz9dJbSZMZ5AB4gzaXaDiju8EO1a2mAioJqafO0K5IpNQGhpkERFYlKy/znLw3Bm0gv3euQpEyontC0KPy/QpBGUznlYYG/BQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841928; c=relaxed/simple;
	bh=prKEysYXyyWuDvDu9eJZ44qO6cHeJEujNjWHyFKJvT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFn7MNzNIQst6F7Tk+yZmgWPp2b/i07Kew+59CjplJe2UAiqyhLjQyBugTag1M4akc3Nw2q7rxlh1ikVo46x8cf0FBx3y5RJ4l3LM2PkSawOMz2qw4Tq17Xps5d67pRUiFuwl+Brwj713zl63nbFJmX1GFkCNhihU7Jtlfks7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bakgKZfH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723841927; x=1755377927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=prKEysYXyyWuDvDu9eJZ44qO6cHeJEujNjWHyFKJvT8=;
  b=bakgKZfH3QD2r+QafOjSJ1lubuMHElZrnpDlAyEHMgR96rpgd8c2K1YZ
   Q2i3QcG8plMHBCF7BFhOpnlf2i+rL5nG46hLpTOBGICaCCnhUpY3qN8jL
   MWCDc4ZYRCBZCrdX9WRpdjaz6/TwgHrEqy+hph/cIfMpPWQ4D9ibb4yXJ
   xU7dGhgyakXCqm0UScnKROKGc8yjLgFizRV9OuoX6zkz36WfVBqlZDxpY
   QMdqMhFGuFLpEPcLad1fgOsDDG1lQzsfEXdbUFuJKEvV+bDQu06ix5AXJ
   PdpsRx/4HoxVPZji0W4xi8RvynSl9g6kRDakKsYUH2ePi1Rw860U9yySz
   A==;
X-CSE-ConnectionGUID: zceVZwTFTG62FaHGnQzT3Q==
X-CSE-MsgGUID: /V2I8uDuQMWlRbYUbOcbYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="47552982"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="47552982"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 13:58:46 -0700
X-CSE-ConnectionGUID: KyEt2O1KTnaKwGbbUPz49Q==
X-CSE-MsgGUID: nU4SDx70T0qy2MZzNo7IIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64730816"
Received: from unknown (HELO [10.125.111.71]) ([10.125.111.71])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 13:58:45 -0700
Message-ID: <c39d5638-f72c-4001-85f8-0ba81661638a@intel.com>
Date: Fri, 16 Aug 2024 13:58:44 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/25] dax: Document dax dev range tuple
To: Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, nvdimm@lists.linux.dev
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-3-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-3-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/24 7:44 AM, Ira Weiny wrote:
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
> Changes:
> [iweiny: move to start of series]
> ---
>  drivers/dax/dax-private.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 446617b73aea..ccde98c3d4e2 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -58,7 +58,10 @@ struct dax_mapping {
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

