Return-Path: <linux-btrfs+bounces-2786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99785867149
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 11:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532DE288D39
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061C02E64B;
	Mon, 26 Feb 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLM+liUb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1704817;
	Mon, 26 Feb 2024 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943252; cv=none; b=bzBsF8t0rCsydfR1bUNQwpEucRA/Zm9pXqDOyjTyZTkFq3Upk9dDdHeUfbQwMH1t2hCoGv7R+yuz23plQJziLx/TMoR9XJbCU3AsR97QuYglDlhExwpiFhZ/L6L9Q0l5oDUHur1ZpP/xcQdKkzGGTVM8kFOlCt2vbIm1zRjNeAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943252; c=relaxed/simple;
	bh=5L9QNoh0f+vRtiDXMwpI8NJgAp36BLuI/7gvCVOlhwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k5wRLfpm0zu6UOLLrFaczmPkCy2MmWgKpHTu+zXkfaAVj570FL69udg+FhW55alcyoX6z9wSM5YPPOwvDsWVuy/ZLknuIwbTpd5ntF8mMPWCxoNSbeMF8QNjR3M3RmZ8+8akIisQJwEiF4VlQTTkPYqSb0Pq8zWngwI82dK7Ops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLM+liUb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708943250; x=1740479250;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5L9QNoh0f+vRtiDXMwpI8NJgAp36BLuI/7gvCVOlhwg=;
  b=SLM+liUbOTfMOALNwe8Lba5XSWMgMzJPJIXsWWFwHNTC/2ZkT4MzmZKJ
   4hCzomsahoob/7WtRLTlbsk9nRh533Em6kH+OEDA/EBocCH5k41CKZLKP
   VgzwPPyaHui480IxgbKeVpe+T2F8+bGP/Qky5kMVRF07JXiI+SSWgnfl+
   uB4q2Z8QIwyZxQeNClV0h5jQ5JGsdTp6w1VaU6UbN9LbkMqIRQLfxtdKz
   VmCSYcz/rws2eioqUyNlORq1NPbO7bJtx1eMwCk2SDDwXjzjhgcbWvlIQ
   v+cILIeekRoR8D2aSV+j0DU1SB7HtvyNRpjw+Ja3LNI3KzNGKXBzqtBxC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3060928"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3060928"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 02:27:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="37629455"
Received: from hibeid-mobl.amr.corp.intel.com (HELO localhost) ([10.252.46.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 02:27:24 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: David Laight <David.Laight@ACULAB.COM>, "'linux-kernel@vger.kernel.org'"
 <linux-kernel@vger.kernel.org>, 'Linus
 Torvalds' <torvalds@linux-foundation.org>, 'Netdev'
 <netdev@vger.kernel.org>, "'dri-devel@lists.freedesktop.org'"
 <dri-devel@lists.freedesktop.org>
Cc: 'Jens Axboe' <axboe@kernel.dk>, "'Matthew Wilcox (Oracle)'"
 <willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>,
 "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>, 'Andrew
 Morton' <akpm@linux-foundation.org>, 'Andy Shevchenko'
 <andriy.shevchenko@linux.intel.com>, "'David S . Miller'"
 <davem@davemloft.net>, 'Dan Carpenter' <dan.carpenter@linaro.org>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>
Subject: RE: [PATCH next v2 02/11] minmax: Use _Static_assert() instead of
 static_assert()
In-Reply-To: <824b0f70413d4570bcc97b39aad81a93@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com>
 <8059bc04da1a45bc810ac339a1129a4c@AcuMS.aculab.com>
 <87v86bo9qi.fsf@intel.com>
 <824b0f70413d4570bcc97b39aad81a93@AcuMS.aculab.com>
Date: Mon, 26 Feb 2024 12:27:22 +0200
Message-ID: <87sf1fo705.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 26 Feb 2024, David Laight <David.Laight@ACULAB.COM> wrote:
> From: Jani Nikula
>> Sent: 26 February 2024 09:28
>> 
>> On Sun, 25 Feb 2024, David Laight <David.Laight@ACULAB.COM> wrote:
>> > The wrapper just adds two more lines of error output when the test fails.
>> 
>> There are only a handful of places in kernel code that use
>> _Static_assert() directly. Nearly 900 instances of static_assert().
>
> How many of those supply an error message?

At a glance, not many.

>> Are we now saying it's fine to use _Static_assert() directly all over
>> the place? People will copy-paste and cargo cult.
>
> Is that actually a problem?

I don't know. I'm asking.

Usually when we have compiler wrappers, they're meant to be used instead
of the thing being wrapped.

This series deviates from that, so it would seem to fair to mention it
slightly more verbosely than just stating what's being done.

> The wrapper allows the error message to be omitted and substitutes
> the text of the conditional.
> But it isn't 'free'.
> As well as slightly slowing down the compilation, the error messages
> from the compiler get more difficult to interpret.
>
> Most of the static_assert() will probably never generate an error.
> But the ones in min()/max() will so it is best to make them as
> readable as possible.
> (Don't even look as the mess clang makes....)

I'm not arguing any of this. :)


BR,
Jani.


-- 
Jani Nikula, Intel

