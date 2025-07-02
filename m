Return-Path: <linux-btrfs+bounces-15208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E8AF60A4
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 19:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4F81C4681A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA630AAD2;
	Wed,  2 Jul 2025 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="CaOZf/x/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NK4sOBRr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E63653A7
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479163; cv=none; b=YGIDBpDqfXq9ygbmfDGkSmk+tau7cYdCl6HJgWmaiW/UbhmRCDqU0uFiqM6eb5TuRd+J028ktryMxNWZCtVKGqCPjJTLAlneR7MtVAQTxgSlj1qIzqbdhgG7RY2Bg/ezPuQjuxSz24/eywya4CmI/bb2jaQ9wLXgW1/HsJAf3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479163; c=relaxed/simple;
	bh=VBVnqmwPZpBBeh6ByOO6aqUJ3gahaVIGOXHsEcINRHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heuXV1n7y+nL7Bjp/lA4OSl3UU5ylYBRkBbBHNFqNsSkPmicInryF22ZKi3RtBU72j3x142W40B51XPdKxhMGqFoOyqDEzZ+vALON/NZS8hvCxhLJRwimFl6aZ/lgdPC7AcMef9/WZuUcJEBuqR5KWpGw3vFqbdg5U0ko6bsL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=CaOZf/x/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NK4sOBRr; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 862937A0048;
	Wed,  2 Jul 2025 13:59:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 02 Jul 2025 13:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1751479160; x=1751565560; bh=hmPtHoRanj
	u+xoZmVCFGGnowVitQvcusdJ1ub3Wy1Ig=; b=CaOZf/x/airvTV93hfl80GZ2FG
	RbeedUWx054p99XPz4jPMtkuje0dZzbyRhogrvu1kvACLZ3BwtziWrOk3tbQUbGZ
	f9pyRpf75uQ9OeXCNO78r3YcmKHEnwnHa0Kim3B4MY8Eex4gPVf+gq+j+iFQTFhu
	K8hnFD88Ydnqh/s8Zmki5tpmn6g004cwT9k+YFGp3kAGHxFbNhXauoM+JV6VKYC8
	wVGrzD0nr1q8+iDwz6YYk4Q5kRkvzqcGfuRFZcYY1njc5F4nglgZbPTKvDjSLKQf
	/sZkbT8VXCqffoCG6clJArAam1WPQtg9ISdpr0y+RVPd+C9i5cYvtXnvaMhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751479160; x=1751565560; bh=hmPtHoRanju+xoZmVCFGGnowVitQvcusdJ1
	ub3Wy1Ig=; b=NK4sOBRrQAuCk9SktLDZ/H4AAr51mQeuqfyx7WXwKkb2M47I8Ju
	b0R3kCDZWd5TJXcaRByo6Od/dQ48+0YkikfoYulhIE+nsLvlAnCpDXmzMHZxqgdR
	JzgFigmkphNo8iyUTGgXLNAdnTUrFZWjjhU7lkkQr7BYnTtmeTCc7naRhK0TOwQi
	OexMmBWaC/VqcN+naHYn0Gp4R67layo3bKX5eFmUnC/0z+sXLqeAVp4gB+yDJX2f
	Nm5VbqExsyFyB8I5n7JPzjI/QkqgjE3IVktJMFYsdLgoYGe2eks1Ay/58DwKttpz
	nm8KL9iIo6bO9J8HFirksUdyAW7p7eAr8EQ==
X-ME-Sender: <xms:eHNlaN3gtVsBOrvJ2KHT-NujHdrAaw7aMZtzBfYd5EqfUKNk1pVEFg>
    <xme:eHNlaEFoKa5VOm7EPTC1KA-X1WngcJbMMxhyMn71lzxs0F9hlzoNlKQuhCcGFSsTE
    J5CLhW78ZhQH5Pyh5o>
X-ME-Received: <xmr:eHNlaN4hmMyG1YZqdss9yQdcbnNs9v-Gk2ksHc3NzjvpNpllyT-GnVgZ3vrOZTZvpuZxLTqIVH6oGe8HhNv-czwd0aY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eHNlaK1Lv8zV9qzfUPSL9DDzKFsv5aCcNjuyhiUn7aJRnKbWWYKXIA>
    <xmx:eHNlaAFrMBEUux23rlvRojbkI7JUuoZZ71erh_5Pb2ZU1xjxWe7gMw>
    <xmx:eHNlaL8Rk9WqWOsIuWZPQDfWRTnDbsuRgZaC_ornGOBezyD_ReGMuA>
    <xmx:eHNlaNm5QYLhne1O3KwDA30hpwnYjmQwtyOZIR1t5Uwnna9I1aQBPA>
    <xmx:eHNlaOU-6WGvkkXj2CvMENEb4YLdALcJ0JhCOi8RCGcrcXwAGIOaA2KP>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 13:59:19 -0400 (EDT)
Date: Wed, 2 Jul 2025 11:00:55 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/7] btrfs: accessors: inline eb bounds check and factor
 out the error report
Message-ID: <20250702180055.GB2308047@zen.localdomain>
References: <cover.1751390044.git.dsterba@suse.com>
 <a4b1c3cd286c9217d277e67af4c11a321af6863a.1751390044.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4b1c3cd286c9217d277e67af4c11a321af6863a.1751390044.git.dsterba@suse.com>

On Tue, Jul 01, 2025 at 07:23:50PM +0200, David Sterba wrote:
> There's a check in each set/get helper if the requested range is within
> extent buffer bounds, and if it's not then report it. This was in an
> ASSERT statement so with CONFIG_BTRFS_ASSERT this crashes right away, on
> other configs this is only reported but reading out of the bounds is
> done anyway. There are currently no known reports of this particular
> condition failing.
> 
> There are some drawbacks though. The behaviour dependence on the
> assertions being compiled in or not and a less visible effect of
> inlining report_setget_bounds() into each helper.
> 
> As the bounds check is expected to succeed almost always it's ok to
> inline it but make the report a function and move it out of the helper
> completely (__cold puts it to a different section). This also skips
> reading/writing the requested range in case it fails.
> 
> This improves stack usage significantly:
> 
>   btrfs_get_16                                         -48 (80 -> 32)
>   btrfs_get_32                                         -48 (80 -> 32)
>   btrfs_get_64                                         -48 (80 -> 32)
>   btrfs_get_8                                          -48 (72 -> 24)
>   btrfs_set_16                                         -56 (88 -> 32)
>   btrfs_set_32                                         -56 (88 -> 32)
>   btrfs_set_64                                         -56 (88 -> 32)
>   btrfs_set_8                                          -48 (80 -> 32)
> 
>   NEW (48):
> 	  report_setget_bounds                                     48
>   LOST/NEW DELTA:      +48
>   PRE/POST DELTA:     -360
> 
> Same as .ko size:
> 
>      text    data     bss     dec     hex filename
>   1456079  115665   16088 1587832  183a78 pre/btrfs.ko
>   1454951  115665   16088 1586704  183610 post/btrfs.ko
> 
>   DELTA: -1128
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/accessors.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
> index 2e90b9b14e73f4..a7b6b2d7bde224 100644
> --- a/fs/btrfs/accessors.c
> +++ b/fs/btrfs/accessors.c
> @@ -9,20 +9,15 @@
>  #include "fs.h"
>  #include "accessors.h"
>  
> -static bool check_setget_bounds(const struct extent_buffer *eb,
> -				const void *ptr, unsigned off, int size)
> +static void __cold report_setget_bounds(const struct extent_buffer *eb,
> +					const void *ptr, unsigned off, int size)
>  {
> -	const unsigned long member_offset = (unsigned long)ptr + off;
> +	unsigned long member_offset = (unsigned long)ptr + off;
>  
> -	if (unlikely(member_offset + size > eb->len)) {
> -		btrfs_warn(eb->fs_info,
> -		"bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
> -			(member_offset > eb->len ? "start" : "end"),
> -			(unsigned long)ptr, eb->start, member_offset, size);
> -		return false;
> -	}
> -
> -	return true;
> +	btrfs_warn(eb->fs_info,
> +		   "bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
> +		   (member_offset > eb->len ? "start" : "end"),
> +		   (unsigned long)ptr, eb->start, member_offset, size);
>  }
>  
>  /*
> @@ -56,7 +51,10 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
>  	const int part = eb->folio_size - oil;				\
>  	u8 lebytes[sizeof(u##bits)];					\
>  									\
> -	ASSERT(check_setget_bounds(eb, ptr, off, sizeof(u##bits)));	\
> +	if (unlikely(member_offset + sizeof(u##bits) > eb->len)) {	\
> +		report_setget_bounds(eb, ptr, off, sizeof(u##bits));	\

For full no-change compatibility would it make sense to also ASSERT
here? (or stuff it in report, these are the only two users)

> +		return 0;						\
> +	}								\
>  	if (INLINE_EXTENT_BUFFER_PAGES == 1 || likely(sizeof(u##bits) <= part))	\
>  		return get_unaligned_le##bits(kaddr + oil);		\
>  									\
> @@ -76,7 +74,10 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
>  	const int part = eb->folio_size - oil;				\
>  	u8 lebytes[sizeof(u##bits)];					\
>  									\
> -	ASSERT(check_setget_bounds(eb, ptr, off, sizeof(u##bits)));	\
> +	if (unlikely(member_offset + sizeof(u##bits) > eb->len)) {	\
> +		report_setget_bounds(eb, ptr, off, sizeof(u##bits));	\
> +		return;							\
> +	}								\

Would a helper macro to reduce this duplication be useful? Seems
borderline but worth mentioning. Next time you improve it you won't
have to hit two spots.

>  	if (INLINE_EXTENT_BUFFER_PAGES == 1 ||				\
>  	    likely(sizeof(u##bits) <= part)) {				\
>  		put_unaligned_le##bits(val, kaddr + oil);		\
> -- 
> 2.49.0
> 

