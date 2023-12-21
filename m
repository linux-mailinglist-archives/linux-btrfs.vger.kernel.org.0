Return-Path: <linux-btrfs+bounces-1103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8289C81B56B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 13:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1FD287ED0
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D847F6E587;
	Thu, 21 Dec 2023 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJeIRufo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D176DD18;
	Thu, 21 Dec 2023 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703160058; x=1734696058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HUgYg3Z9o2yXh3C+bSwBC9vytvmB1fqomhibW+F8MgE=;
  b=HJeIRufo0vZRNrE95XlecUcArUoo2hrCcDZ5R1BAiBdZZ7Xtuuz04Hut
   gp3KztthXpGfN1GgSxfTOij8k8uACeVGz5xUrfGnM+GSVKvPfkNdf+m2f
   JwEKpJ3rqVxlEF2mzRrGM+aHcNNLqj1w0T9x8ZAkhz/u5r/57QgZL0+2v
   gctyKo4arQIwJhBX9VOcg/cyqKMpEaMMoiFvekIjDMsxxm1q6znRZrQVo
   tVEWwVXq9UTU8ORjInU4IOu5hXwIyaYDG/SknmHvjwjsqNYp6aPIZ3OTr
   q3KTDf2BHXCdZKrNFVaVWAmRBuRSG0mQihpMxL7sFXcSVfNIm2tKBZf2c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="462406717"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="462406717"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:00:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="900082435"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="900082435"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:00:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGHjF-00000007qPi-1MKb;
	Thu, 21 Dec 2023 14:00:41 +0200
Date: Thu, 21 Dec 2023 14:00:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-btrfs@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Message-ID: <ZYQo6DB4nQj58iUg@smile.fi.intel.com>
References: <ZYL5CI4aEyVnabhe@smile.fi.intel.com>
 <15cf089f-be9a-4762-ae6b-4791efca6b44@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15cf089f-be9a-4762-ae6b-4791efca6b44@gmx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 07:08:08AM +1030, Qu Wenruo wrote:
> On 2023/12/21 00:54, Andy Shevchenko wrote:
> > On Wed, Dec 20, 2023 at 08:31:09PM +1030, Qu Wenruo wrote:
> > > On 2023/12/20 20:24, Alexey Dobriyan wrote:
> > > > > Just as mentioned in the comment of memparse(), the simple_stroull()
> > > > > usage can lead to overflow all by itself.
> > > > 
> > > > which is the root cause...
> > > > 
> > > > I don't like one char suffixes. They are easy to integrate but then the
> > > > _real_ suffixes are "MiB", "GiB", etc.
> > > > 
> > > > If you care only about memparse(), then using _parse_integer() can be
> > > > arranged. I don't see why not.
> > > 
> > > Well, personally speaking I don't think we should even support the suffix at
> > > all, at least for the only two usage inside btrfs.
> > > 
> > > But unfortunately I'm not the one to do the final call, and the final call
> > > is to keep the suffix behavior...
> > > 
> > > And indeed using _parse_integer() with _parse_interger_fixup_radix() would
> > > be better, as we don't need to extend the _kstrtoull() code base.
> > 
> > My comment on the first patch got vanished due to my MTA issues, but I'll try
> > to summarize my point here.
> > 
> > First of all, I do not like the naming, it's too vague. What kind of suffix?
> > Do we suppose to have suffix in the input? What will be the behaviour w/o
> > suffix?  And so on...
> 
> I really like David Sterb to hear this though.

Me too, I like to hear opinions. But I will fight for the best we can do here.

> To me, we should mark memparse() as deprecated as soon as possible, not
> spreading the damn pandemic to any newer code.

Send a patch!

> The "convenience" is not an excuse to use incorrect code.

I do not object this.

> > Second, if it's a problem in memparse(), just fix it and that's all.
> 
> Nope, the memparse() itself doesn't have any way to indicate errors.
> 
> It's not fixable in the first place, as long as you want a drop-in solution.
> 
> > Third, as Alexey said, we have metric and byte suffixes and they are different.
> > Supporting one without the other is just adding to the existing confusion.
> > 
> > Last, but not least, we do NOT accept new code in the lib/ without test cases.
> > 
> > So, that said here is my formal NAK for this series (at least in this form).
> 
> Then why there is the hell of memparse() in the first place?

You have all means to investigate.
It used to be setup_mem() till 9b0f5889b12b ("Linux 2.2.18pre9"),
which in turn was split from setup_arch() in 716454f016a9 ("Import
2.1.121pre1")... Looking deeper seems it comes as a parser at hand
for the mem= command line parameter very long time ago.

> It doesn't have test case (we have cmdline_kunit, but it doesn't test
> memparse() at all), nor the proper error detection.

Exactly! Someone's job to add this. And the best is the one who touches
the code. See how cmdline_kunit appears.

> I'm fine to get my patch rejected, but why the hell of memparse() is
> here in the first place?
> It doesn't fit any of the standard you mentioned.

So, what standard did we have in above mentioned (prehistorical) time?

> > P.S> The Subject should start with either kstrtox: or lib/kstrtox.c.

-- 
With Best Regards,
Andy Shevchenko



