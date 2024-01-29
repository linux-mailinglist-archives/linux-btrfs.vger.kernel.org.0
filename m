Return-Path: <linux-btrfs+bounces-1884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488198400ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 10:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F5A1F23F52
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D257A5576C;
	Mon, 29 Jan 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpC6GTJP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F0654F91;
	Mon, 29 Jan 2024 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519271; cv=none; b=b1HH4vkGubqbtSMVijOKtCT69cvKdEjqD3dHhhJIKdwAjw30sVIW32Sl5/Mo1XFek+Dye768xNbv2QAGQoif2xXClvb6/bBEgAnDmjOR/XKjQYnI6YESAvBmoR3MDZAphIL2uMsIm4nxwZiBH5W8bPpqlwxAPaNn1irnnFBFoeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519271; c=relaxed/simple;
	bh=msuiibqFBcGfMgzA/fC14fkBPBHd7u1JVKZzOwMA6L0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UoJ2TkQyTu8J3osRVa3L22V1YVgkgdwz6SPqxRCJar2vwlHdsLYrvaNbnV3r5OavuZIRWl/R4NdjSnsLOx4yR8aJT2gBuhxH6yUBgknTJwKDnT1iOVM37/bKx511hfbTfdRbKORN39UK6/IILlFQX7by/iJqunLJBarWD/NWV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpC6GTJP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706519269; x=1738055269;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=msuiibqFBcGfMgzA/fC14fkBPBHd7u1JVKZzOwMA6L0=;
  b=EpC6GTJPEFrBY3j4uMsQQSyMtlU0Lt8uqNm2BqWamkTPIdMI++13IG6R
   4QZgVcolVOGUQdzJxf26mbEmGV/7g07E7sWHuj1D0gBDUrMV0kRi/7GtJ
   aH0NVfRg+qS2nvpPLM6xmcqDY6ccPloIFQkXj9ogCSmW/E55p4TSIYwKT
   A095MQJriI45GCeJu3cYLtcqW9XN4W1utD9jgXUTE5Gc2r5epuFNGagM4
   rvAFQhLsA+gTn/Cu+pTTB9H1b+59BYG1pneGMC5y/Ecg2WBYQ8zB2O85D
   SyQ7yWBLrZYlt/wvfqWvpnlTeqwSGsNDX19SGvfiX1LTwiiKkSiAls4Ro
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2724897"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="2724897"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="3407220"
Received: from hbrandbe-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.53])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:07:42 -0800
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
 <davem@davemloft.net>, 'Dan
 Carpenter' <dan.carpenter@linaro.org>
Subject: Re: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
In-Reply-To: <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com>
 <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
Date: Mon, 29 Jan 2024 11:07:38 +0200
Message-ID: <87sf2gjyn9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Jan 2024, David Laight <David.Laight@ACULAB.COM> wrote:
> blk_stack_limits() contains:
> 	t->zoned =3D max(t->zoned, b->zoned);
> These are bool, so it is just a bitwise or.

Should be a logical or, really. And || in code.

BR,
Jani.


> However it generates:
> error: comparison of constant =C3=A2=E2=82=AC=CB=9C0=C3=A2=E2=82=AC=E2=84=
=A2 with boolean expression is always true [-Werror=3Dbool-compare]
> inside the signedness check that max() does unless a '+ 0' is added.
> It is a shame the compiler generates this warning for code that will
> be optimised away.
>
> Change so that the extra '+ 0' can be removed.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>  block/blk-settings.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 06ea91e51b8b..9ca21fea039d 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -688,7 +688,7 @@ int blk_stack_limits(struct queue_limits *t, struct q=
ueue_limits *b,
>  						   b->max_secure_erase_sectors);
>  	t->zone_write_granularity =3D max(t->zone_write_granularity,
>  					b->zone_write_granularity);
> -	t->zoned =3D max(t->zoned, b->zoned);
> +	t->zoned =3D t->zoned | b->zoned;
>  	return ret;
>  }
>  EXPORT_SYMBOL(blk_stack_limits);

--=20
Jani Nikula, Intel

