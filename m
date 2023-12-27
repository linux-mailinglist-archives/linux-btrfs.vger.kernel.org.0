Return-Path: <linux-btrfs+bounces-1140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C781EC5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 06:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6789C1C22242
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 05:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56D4522C;
	Wed, 27 Dec 2023 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="JM3GTG/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374903FFE;
	Wed, 27 Dec 2023 05:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=+XsM5hFWkLW09YUNHSAectqYCug7xGgUZWGLicrUKlY=; b=JM3GTG/0eQBIzPfhgWTwaXHfbN
	2sx42F0Jm+PSFApMU+9Jozj+j3zGynmtiJCBqwpEDjBwb4f7tFN2+4OyFX83AJzuqPGbi5jPhLE7J
	VousxCHLbVYvaRACIAjnRSdaq7k90vm5tUgZNRjH3LexUmGs+NTg7Fk3BS0Tq1+N3YRr++Rqh6s2u
	a6diP7Eir7v+j97jXbgep5NGNa49e7BgQW+IZbH78eohdxeCVGJhSKUa3iOCxYbNwG9X29Gr0tEBO
	DwRdd2kEOIypASTamwwBYK8u/8PIGLPCSTJFndxs69V81RBjAtirUqT5sDQ78gIx8Wja/rgCwY2zJ
	VfcuFnHzSuyR3Bk+IFxRfVrylMzUNmh7dM/tk4YjPZK1O2qvEgYNzGkEDv1aeetzCO2k422QljucD
	2LiPDFgF2lYvFO85gW3FP8uM6tqbBxKX7bJH1uZyDmYLRQL6UyFmCOUl3ZKuRDeuW+6aBH/5R1XtU
	6uNN6lWx75MUiI69JzbPGhGG;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rIMcv-005MKc-2k;
	Wed, 27 Dec 2023 05:38:46 +0000
Date: Wed, 27 Dec 2023 16:38:32 +1100
From: David Disseldorp <ddiss@samba.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Laight
 <David.Laight@ACULAB.COM>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Message-ID: <20231227163832.51e305f7@echidna>
In-Reply-To: <97b85612-16ab-4099-9a8e-426df510d7db@gmx.com>
References: <cover.1703030510.git.wqu@suse.com>
	<e042f40ea5cf7fa8251713d5bb7a485f42c5615b.1703030510.git.wqu@suse.com>
	<20231220163856.274f84a3@echidna>
	<97b85612-16ab-4099-9a8e-426df510d7db@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Dec 2023 20:27:30 +1030, Qu Wenruo wrote:

> On 2023/12/20 16:08, David Disseldorp wrote:
...
> >> +#define KSTRTOULL_SUFFIX_DEFAULT (SUFFIX_K | SUFFIX_M | SUFFIX_G | SUFFIX_T | SUFFIX_P)  
> >
> > I think it'd be clearer if you dropped this default and had callers
> > explicitly provide the desired suffix mask.  
> 
> Well, that would be long, and would be even longer as the newer naming
> would be MEMPARSE_SUFFIX_*, to be more explicit on what the suffix is for...
> 
> And I really want callers to choose a saner default suffix, thus here
> comes the default one.
> 
> In fact, in my next version, I also found that there are some memparse()
> call sites benefits from the newer suffixes (although won't for the "E"
> one).
> The example is the call site setup_elfcorehdr(). Where the comment only
> mentions KMG, but since memparse() silently added "PE" suffixes, maybe
> on some mainframes we saved some time for one or two lucky admins.

I think it's a sane default, my concern is that _DEFAULT says nothing
about supported units from the caller's perspective. Perhaps
MEMPARSE_SUFFIX_KMGTP or MEMPARSE_UNITS_KMGTP would be clearer.

...
> > With the above changes made, feel free to add
> > Reviewed-by: David Disseldorp <ddiss@suse.de>  
> 
> Thanks for the review, but I'm afraid the newer version would be another
> beast.
> 
> All the ommitted comments would be addressed a in new series.
> >
> > I'll leave the review of patch 2/2 up to others, as I'm still a little
> > worried about sysfs trailing whitespace regressions.  
> 
> That won't be a problem anymore, the new series would keep the old
> @retptr behavior, thus for btrfs part it won't be changed at all.

Sounds good. Will follow up there.

Cheers, David

