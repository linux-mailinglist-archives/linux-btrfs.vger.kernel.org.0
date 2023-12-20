Return-Path: <linux-btrfs+bounces-1081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9258581A110
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 15:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF2C1F228A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63C38F9E;
	Wed, 20 Dec 2023 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHnqEiLb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66238DF5;
	Wed, 20 Dec 2023 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703082254; x=1734618254;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ij+eZ1wb0paDDLjZRVqjdrr8YSgCgTMHNcU/T9GNHlA=;
  b=LHnqEiLbk8Br2rgIBSquHpIBL8YNBeks4zVAa9AZ503FWEj0u7me16rY
   67UEFYowsEB3WVZLPAUB5BQJvT/FXiykwzTxTM81DpA+sNiWo8uREFaHB
   mIwSWjeamk2bOMD1wPkecWq+IgBQAX+fd/yQ7LB/2lAjJfH5EXfPd1Kre
   +RVPFZ83P6wH9vi4DUy9v67phbbRQVvqaI/9pXTyd9oHwx5MgGdm2RAWt
   dq43j0RZf5FsGU0S66ZvUW8ej7+9IsM1t+wLx3+nH445xhmsYkDZ/uYsk
   zkvdZ8sP5ssgWmzLaFK/1GJVmg4j+YoNxAq6B8LbybbLPqoTbxhWN8fcw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="392991585"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="392991585"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:24:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1107742833"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="1107742833"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:24:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFxUW-00000007YcA-3mex;
	Wed, 20 Dec 2023 16:24:08 +0200
Date: Wed, 20 Dec 2023 16:24:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-btrfs@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Message-ID: <ZYL5CI4aEyVnabhe@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo


On Wed, Dec 20, 2023 at 08:31:09PM +1030, Qu Wenruo wrote:
> On 2023/12/20 20:24, Alexey Dobriyan wrote:
> > > Just as mentioned in the comment of memparse(), the simple_stroull()
> > > usage can lead to overflow all by itself.
> > 
> > which is the root cause...
> > 
> > I don't like one char suffixes. They are easy to integrate but then the
> > _real_ suffixes are "MiB", "GiB", etc.
> > 
> > If you care only about memparse(), then using _parse_integer() can be
> > arranged. I don't see why not.
> 
> Well, personally speaking I don't think we should even support the suffix at
> all, at least for the only two usage inside btrfs.
> 
> But unfortunately I'm not the one to do the final call, and the final call
> is to keep the suffix behavior...
> 
> And indeed using _parse_integer() with _parse_interger_fixup_radix() would
> be better, as we don't need to extend the _kstrtoull() code base.

My comment on the first patch got vanished due to my MTA issues, but I'll try
to summarize my point here.

First of all, I do not like the naming, it's too vague. What kind of suffix?
Do we suppose to have suffix in the input? What will be the behaviour w/o
suffix?  And so on...

Second, if it's a problem in memparse(), just fix it and that's all.

Third, as Alexey said, we have metric and byte suffixes and they are different.
Supporting one without the other is just adding to the existing confusion.

Last, but not least, we do NOT accept new code in the lib/ without test cases.

So, that said here is my formal NAK for this series (at least in this form).

P.S> The Subject should start with either kstrtox: or lib/kstrtox.c.

-- 
With Best Regards,
Andy Shevchenko


