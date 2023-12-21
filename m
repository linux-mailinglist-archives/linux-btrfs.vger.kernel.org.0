Return-Path: <linux-btrfs+bounces-1111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB6981BFC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 21:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11C21F255E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 20:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69BC768E8;
	Thu, 21 Dec 2023 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdEgArsV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2C55E6C;
	Thu, 21 Dec 2023 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703192127; x=1734728127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0w8QXE+4um/f5qVFcFax66VvCFBNWrGXVxaOHPrwoC8=;
  b=PdEgArsV64sNjfL79uEHaPxoMfe5PY/SRnXkLboQLqCohwPsnf0aqNpc
   bNNyHfrYC4pZIgQDoSGk3Xq2gvI9U7OhFykYiLPgDDUshg6d8lRuLnaNF
   By3z49z7ooxoWNfyIpUcjaBxLzGIc8lx2RSHpKJuBszLogQPq7o4vSlMf
   yRiomA4gqcecBQKSlTK7eBadkr/JdnKJLP+NB6fhcOM4r++Ky9cl/TH3U
   LSUiYk5d08aV9mY9+fhO2dZdsnoTRs4J1pMuvbWEsRcWWsE/7cSfRzPTt
   6wNquGdpfopGmeRkVdX1Q0ql9StGY5gufISyEG8gAnBEzz6jXs+vWQp43
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="460370082"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="460370082"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 12:55:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="920436865"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="920436865"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 12:55:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGQ4f-00000007yda-13KS;
	Thu, 21 Dec 2023 22:55:21 +0200
Date: Thu, 21 Dec 2023 22:55:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-btrfs@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Message-ID: <ZYSmOCcqbBbbFx-s@smile.fi.intel.com>
References: <ZYL5CI4aEyVnabhe@smile.fi.intel.com>
 <15cf089f-be9a-4762-ae6b-4791efca6b44@gmx.com>
 <ZYQo6DB4nQj58iUg@smile.fi.intel.com>
 <cf3808eb-0c8f-4a51-b2b4-14eb33b88992@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3808eb-0c8f-4a51-b2b4-14eb33b88992@gmx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 07:07:31AM +1030, Qu Wenruo wrote:
> On 2023/12/21 22:30, Andy Shevchenko wrote:

...

> Then what about going the following path for the whole memparse() rabbit
> hole?
> 
> - Mark the old memparse() deprecated
> - Add a new function memparse_safe() (or rename the older one to
>   __memparse, and let the new one to be named memparse()?)
> - Add unit test for the new memparse_safe() or whatever the name is
> - Try my best to migrate as many call sites as possible
>   Only the two btrfs ones I'm 100% confident for now
> 
> Would that be a sounding plan?

As long as it does not break any ABI (like kernel command line parsing),
sounds good to me.

-- 
With Best Regards,
Andy Shevchenko



