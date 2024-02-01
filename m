Return-Path: <linux-btrfs+bounces-2022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF0845B4D
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 16:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426501F217AB
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E059163AA5;
	Thu,  1 Feb 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSAH0TgN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088A161B77;
	Thu,  1 Feb 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800716; cv=none; b=IiDnK3YBaOICCkDtbd4etX0iKN9mmnlp9LX64rk58/jEjYN8GN1rLXVTtBDqZPyqM4mPp/q0Ms2u+EtdgjhR5xJtAnUmDmD48Aprp62XaBrAEgVCJnl4KpidDWjapWu85y5yJs6KI4wuFHOFDjZpRx75zxayuquAkDV9XGTIphU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800716; c=relaxed/simple;
	bh=3RevnAVAbHAEBydU8gSpDEND0TRcHLa+idBC6gA4zJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qHJ3+s2Me++N04jE0gNxxKR6P69wxAPoZfo44qD5DQfRflU6gJMjCPwQ70vxp4Wva4qzCC0vVL35uiHnhknAh18hVWX6DKyrRVYSXRB+LzcAMIxj+UVrVdN0pBa2Nn4t9af4sPZqs7EB3b4toYfME9FQdv+rs5gTS+Wl1/qo1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSAH0TgN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706800716; x=1738336716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3RevnAVAbHAEBydU8gSpDEND0TRcHLa+idBC6gA4zJQ=;
  b=XSAH0TgNPdypoxNchZJNydk1Ps7jv2o1jqOfjYoH1HteJFg3yXFrrJJP
   gtm91RTqZNnLtSBOwml8SDrXjdXOtMfydPpk6IEWFC87esdWZ9NaSKBKQ
   88bsEoHydT1kTkfEKaCYvVfTQA2OXAk0DwDs1fwhq2JRZIe/bPelFcaS7
   R1Gc4W7PgrPx8koVLAf9e3AFV0WNj9T5rdNtdRkNZVJHxeUz94UJJX+I1
   l5EB9F0LKANhWtjraD1AY6BMWDGalgv5jp+GJ+ue3Rf9CnRlWHtQyPUBr
   2r2LLwhbZfH/2y+dTYfJyrdzF0JQqEe0J6bGANZSWisihmR2liC9VeQCH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10545503"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10545503"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:18:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961943769"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="961943769"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:18:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVYpf-00000000rtt-0oZx;
	Thu, 01 Feb 2024 17:18:27 +0200
Date: Thu, 1 Feb 2024 17:18:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr, David.Laight@aculab.com,
	ddiss@suse.de, geert@linux-m68k.org
Subject: Re: [PATCH v3 0/4] kstrtox: introduce memparse_safe()
Message-ID: <Zbu2QqhC2LyK4ttb@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 15, 2024 at 06:31:05AM +1030, Qu Wenruo wrote:
> On 2024/1/15 00:12, Andy Shevchenko wrote:
> > On Sun, Jan 07, 2024 at 07:28:27AM +1030, Qu Wenruo wrote:
> > > On 2024/1/7 01:04, Andy Shevchenko wrote:
> > > > On Thu, Jan 04, 2024 at 09:57:47AM +1030, Qu Wenruo wrote:

...

> > > > Having test cases is quite good, thanks!
> > > > But as I understood what Alexey wanted, is not using the kstrtox files for this.
> > > > You can introduce it in the cmdline.c, correct? Just include local "kstrtox.h".
> > > 
> > > Not really possible, all the needed parsing helpers are internal inside
> > > kstrtox.c.
> > 
> > I'm not sure I follow. The functions are available to other library (built-in)
> > modules.
> 
> Did I miss something?
> 
> Firstly neither _parse_integer_fixup_radix() nor _parse_integer_limit() is
> exported to modules. (No EXPORT_SYMBOL() call on them).

Should they?

> Secondly _parse_integer_fixup_radix() and _parse_integer_limit have "_"
> prefix, and is only declared in "lib/kstrtox.h", which means they are
> designed only for internal usage.
> If putting memparse_safe() into cmdline.c, at least we would need to include
> local header "kstrtox.h", and I'm not sure if this is any better than
> putting memparse_safe() into kstrtox.[ch].

Yes, this is much better.

> Finally, I just tried putting memparse_safe() into cmdline.c, and it failed
> at linkage stage, even if that offending file has no call to
> memparse_safe():
> 
>   ld: arch/x86/boot/compressed/kaslr.o: in function `memparse_safe':
> kaslr.c:(.text+0xbb1): undefined reference to `_parse_integer_fixup_radix'
>   ld: kaslr.c:(.text+0xbc5): undefined reference to `_parse_integer'
>   ld: arch/x86/boot/compressed/vmlinux: hidden symbol `_parse_integer' isn't
> defined

I don't understand. Implement memparse_safe() in the C file
(i.e.  lib/cmdline.c) and if it's needed to be exported, export it.

> I can try again but I'm not sure if it's possible to move memparse_safe() to
> cmdline.[ch].

Please do. I do not see design issues with proposed approach.

...

> > > Furthermore, this also means memparse() can not be enhanced due to:
> > > 
> > > - Lack of ways to return errors
> > 
> > What does this mean?
> 
> If you want to keep the prototype of memparse() (aka, a drop-in
> enhancement), then there is no good way to indicate the errors like overflow
> at all.

No need to replace one by another in the implementation side, having two is
okay, while moving affected code to the better one one-by-one. Then we may
remove the old one. And then, if there is a wish, we may rename it back.

> > > - Unable to call the parsing helpers inside cmdline.c
> > 
> > ??? (see above)
> > 
> See above.

Got it, but please try again. I do believe it's possible to avoid touching
kstrotox.c.

-- 
With Best Regards,
Andy Shevchenko


