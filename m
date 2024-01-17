Return-Path: <linux-btrfs+bounces-1499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3C82FE2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 02:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E98EB24C99
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F91364;
	Wed, 17 Jan 2024 01:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQnSIM5t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MTabVzT1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQnSIM5t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MTabVzT1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E6EDE
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453708; cv=none; b=T01ReSOWyA8Rxd2nXs1rFJD75RS0Hjva0gF6B9WmDOQGW1NotmncDK5NP8FemwkDn259Vk9UPp9eM4CcQTVKd6hx+P02WQHMmEwZplQsI+i1j9PeRH54eVAPLyeQYfWf6wd4nabQ7AHfJmyPJG5r21Bcpp/+owlyGJAJxCVR8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453708; c=relaxed/simple;
	bh=3DpMf1+/b2fQvlGbt4kxjg7/tvEgNtElEd5TYaDI6VU=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spamd-Result:
	 X-Spam-Level:X-Spam-Flag:X-Spam-Score; b=iowYVcL7IIowOvpadvoya8nenkxfaBEEDIM3XqVZTLyC9yO//NueZt6EP72lQiFCUG3uxKtSoz00GveUftIvPAM27uhOcSizfgBz12Ovc9mjaKBxQKzUzvCQpNbh2oOn7wDhhNAPsS/ReSg/DR3aNUi2mTZ6xgah45ITGDZuyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQnSIM5t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MTabVzT1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQnSIM5t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MTabVzT1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E432D2217C;
	Wed, 17 Jan 2024 01:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705453704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nxaWGJtcqbCpH0421EVOPf96FpCc77dly2kaJDubpuE=;
	b=rQnSIM5tnr2uPkNM017hJgDlEGD4CZN7AxzWKXEv7hLmppPl6ps1/+5egjJ44M6S+vccfj
	OHQ9O3gqvcGlj+E1bBm3izfecEZEZuWo2IAtGG9L9NRym0oHQ1r6QPCoUCflgcADbukV8J
	yQeYQro0bni2+lfOUqC8eovXdWYuew0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705453704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nxaWGJtcqbCpH0421EVOPf96FpCc77dly2kaJDubpuE=;
	b=MTabVzT1FfPqsGBKkgM/8iU1Oz3rZhMY9qS/IScEhu5thy3Y84xVT5+QkbQygZ2/xrxeCm
	VfeQ6or3LZkJDLCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705453704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nxaWGJtcqbCpH0421EVOPf96FpCc77dly2kaJDubpuE=;
	b=rQnSIM5tnr2uPkNM017hJgDlEGD4CZN7AxzWKXEv7hLmppPl6ps1/+5egjJ44M6S+vccfj
	OHQ9O3gqvcGlj+E1bBm3izfecEZEZuWo2IAtGG9L9NRym0oHQ1r6QPCoUCflgcADbukV8J
	yQeYQro0bni2+lfOUqC8eovXdWYuew0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705453704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nxaWGJtcqbCpH0421EVOPf96FpCc77dly2kaJDubpuE=;
	b=MTabVzT1FfPqsGBKkgM/8iU1Oz3rZhMY9qS/IScEhu5thy3Y84xVT5+QkbQygZ2/xrxeCm
	VfeQ6or3LZkJDLCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CB55D133DC;
	Wed, 17 Jan 2024 01:08:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IKMoMYgop2W6ZgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 17 Jan 2024 01:08:24 +0000
Date: Wed, 17 Jan 2024 02:08:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: convert/ext2: new debug environment
 variable to finetune transaction size
Message-ID: <20240117010806.GI31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705135055.git.wqu@suse.com>
 <4c2f12dc417a192f4acfd804831401aadeeb9c42.1705135055.git.wqu@suse.com>
 <20240116183152.GC31555@twin.jikos.cz>
 <8d987075-18be-4866-80da-03415b6da7ff@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d987075-18be-4866-80da-03415b6da7ff@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Wed, Jan 17, 2024 at 06:50:11AM +1030, Qu Wenruo wrote:
> On 2024/1/17 05:01, David Sterba wrote:
> > On Sat, Jan 13, 2024 at 07:15:29PM +1030, Qu Wenruo wrote:
> >> Since we got a recent bug report about tree-checker triggered for large
> >> fs conversion, we need a properly way to trigger the problem for test
> >> case purpose.
> >>
> >> To trigger that bug, we need to meet several conditions:
> >>
> >> - We need to read some tree blocks which has half-backed inodes
> >> - We need a large enough enough fs to generate more tree blocks than
> >>    our cache.
> >>
> >>    For our existing test cases, firstly the fs is not that large, thus
> >>    we may even go just one transaction to generate all the inodes.
> >>
> >>    Secondly we have a global cache for tree blocks, which means a lot of
> >>    written tree blocks are still in the cache, thus won't trigger
> >>    tree-checker.
> >>
> >> To make the problem much easier for our existing test case to expose,
> >> this patch would introduce a debug environment variable:
> >> BTRFS_PROGS_DEBUG_BLOCKS_USED_THRESHOLD.
> >>
> >> This would affects the threshold for the transaction size, setting it to
> >> a much smaller value would make the bug much easier to trigger.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   common/utils.c        | 62 +++++++++++++++++++++++++++++++++++++++++++
> >>   common/utils.h        |  1 +
> >>   convert/source-ext2.c |  9 ++++++-
> >>   3 files changed, 71 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/common/utils.c b/common/utils.c
> >> index 62f0e3f48b39..e6070791f5cc 100644
> >> --- a/common/utils.c
> >> +++ b/common/utils.c
> >> @@ -956,6 +956,68 @@ u8 rand_u8(void)
> >>   	return (u8)(rand_u32());
> >>   }
> >>   
> >> +/*
> >> + * Parse a u64 value from an environment variable.
> >> + *
> >> + * Supports unit suffixes "KMGTP", the suffix is always 2 ** 10 based.
> >> + * With proper overflow detection.
> >> + *
> >> + * The string must end with '\0', anything unexpected non-suffix string,
> >> + * including space, would lead to -EINVAL and no value updated.
> >> + */
> >> +int get_env_u64(const char *env_name, u64 *value_ret)
> > 
> > There already is a function for parsing sizes parse_size_from_string()
> > in common/parse-utils.c.
> 
> Unfortunately that's not suitable.
> 
> We don't want a invalid string to fully blow up the program, as the 
> existing parser would call exit(1), especially we only need it for a 
> debug environmental variable.

I see.

> Should I change the existing one to provide better error handling?
> (Which means around 16 call sites update), or is there some better solution?

Yeah, the parsers used for command line arguments are fine to exit as
error handling but generic helper should not do that. There's
arg_strotu64, so I'd keep the arg_ prefix for helpers that will exit on
error.

Looking at parse_size_from_string, it should return int or bool and the
value will be in parameter. This is cleaner than using errno for that.

