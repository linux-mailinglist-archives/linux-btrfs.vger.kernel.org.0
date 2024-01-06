Return-Path: <linux-btrfs+bounces-1283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DD6825FE4
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 15:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6661F227FF
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7228847A;
	Sat,  6 Jan 2024 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpDJb+l6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E179D7;
	Sat,  6 Jan 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704551718; x=1736087718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZNNysimiaIE8kJDewUd2Rel+W4OnxP7QCkFhwCl3gQA=;
  b=bpDJb+l6aKOzo8Xlk8sMDrwVdm0cQgPkrppklXV0/+S5RdOMgtwtTVPx
   U3bnF3xxg66iBrTVptNRNoPy6ue511zHffBjFbZYs0p5pBJpQULpBVTRx
   Urhv3u69vVY6zRb+88Evgjq6oKmN+2SCSBhqkDh6Q1mqVIRK3Z5TuDw8r
   QJL+s7H38tH5R9DxXBr8oYH9uTLsCZxsrm8BBZ3oB9aoiYg/k0jwR5oca
   iSHcibAcRcNE0t6hgALfUUBNaKpvy9eOeJK3uw8jHTUQ7m/ZtdmF3MOwm
   4DxlDTCJB/iHjz9NSLDNq5Sy2jxuifrDy9FT+NzishGSxaZWvebcIUm/m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="428843917"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="428843917"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="809803693"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="809803693"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:35:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM7lY-0000000Bvj0-0Zba;
	Sat, 06 Jan 2024 16:35:12 +0200
Date: Sat, 6 Jan 2024 16:35:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
	David.Laight@aculab.com, ddiss@suse.de, geert@linux-m68k.org,
	rdunlap@infradead.org
Subject: Re: [PATCH v4 0/4] kstrtox: introduce memparse_safe()
Message-ID: <ZZllH1Aw_XKw1EW5@smile.fi.intel.com>
References: <cover.1704422015.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1704422015.git.wqu@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jan 05, 2024 at 01:04:58PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v4:
> - Extra test cases for supported but not enabled suffixes
> 
> - Comments update for memparse_safe() function

Same comment is applied as per v3.

-- 
With Best Regards,
Andy Shevchenko



