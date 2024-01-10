Return-Path: <linux-btrfs+bounces-1347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152A782927C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 03:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA361289432
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 02:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC3F53A6;
	Wed, 10 Jan 2024 02:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaUBz3w+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="49iOJqPx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaUBz3w+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="49iOJqPx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3C4A11
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22D0E221AC;
	Wed, 10 Jan 2024 02:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704854591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlOLXaLHsvBHWrXcO9mQTBfes0KgQuEY5TMFdGN05uE=;
	b=eaUBz3w++O+GAjx7bmqiAFB4iYpgPTmG2ozstOmZk+M1VTSZ5fGCUcXIEge5elUEeBtAop
	O2J27HQD7eYqBy6u5lL32V3rhC52l3sOxnVgvquEs4QyqAXm0grj0rwEY+musviHaQpWNj
	fcXdn30z53LoS7rXq7ULGpXjBjznUKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704854591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlOLXaLHsvBHWrXcO9mQTBfes0KgQuEY5TMFdGN05uE=;
	b=49iOJqPx0OLO2o8J58p5N7Fvftm70JjTiDNE6IwxrHUGdx6eH9FRyplYYeK1/SDEN6yrlR
	37vrorziHQZ/1ZCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704854591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlOLXaLHsvBHWrXcO9mQTBfes0KgQuEY5TMFdGN05uE=;
	b=eaUBz3w++O+GAjx7bmqiAFB4iYpgPTmG2ozstOmZk+M1VTSZ5fGCUcXIEge5elUEeBtAop
	O2J27HQD7eYqBy6u5lL32V3rhC52l3sOxnVgvquEs4QyqAXm0grj0rwEY+musviHaQpWNj
	fcXdn30z53LoS7rXq7ULGpXjBjznUKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704854591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlOLXaLHsvBHWrXcO9mQTBfes0KgQuEY5TMFdGN05uE=;
	b=49iOJqPx0OLO2o8J58p5N7Fvftm70JjTiDNE6IwxrHUGdx6eH9FRyplYYeK1/SDEN6yrlR
	37vrorziHQZ/1ZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F376A13786;
	Wed, 10 Jan 2024 02:43:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fcs+Oz4EnmUeJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 02:43:10 +0000
Date: Wed, 10 Jan 2024 03:42:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, kernel test robot <lkp@intel.com>,
	linux-btrfs@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/3] btrfs: zlib: fix and simplify the inline extent
 decompression
Message-ID: <20240110024256.GR28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu@suse.com>
 <202401091012.pLm6PcKG-lkp@intel.com>
 <20240110015800.GP28693@twin.jikos.cz>
 <e3c5ace5-4266-4a6a-9836-f58f5fff66fe@suse.com>
 <20240110022643.GQ28693@twin.jikos.cz>
 <3fdafc03-91e6-4c36-9d10-417c07222d0b@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fdafc03-91e6-4c36-9d10-417c07222d0b@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: **
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 22D0E221AC
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eaUBz3w+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=49iOJqPx
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.977];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Jan 10, 2024 at 01:04:06PM +1030, Qu Wenruo wrote:
> >>>>
> >>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >>>> the same patch/commit), kindly add following tags
> >>>> | Reported-by: kernel test robot <lkp@intel.com>
> >>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202401091012.pLm6PcKG-lkp@intel.com/
> >>>>
> >>>> All warnings (new ones prefixed by >>):
> >>>>
> >>>>>> fs/btrfs/zlib.c:402:15: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
> >>>>        401 |                 pr_warn_ratelimited("BTRFS: infalte failed, decompressed=%lu expected=%lu\n",
> >>>>            |                                                                                       ~~~
> >>>>            |                                                                                       %zu
> >>>>        402 |                                         to_copy, destlen);
> >>>>            |                                                  ^~~~~~~
> >>>
> >>> Valid report but I can't reproduce it. Built with clang 17 and
> >>> explicitly enabled -Wformat. We have additional warnings enabled per
> >>> directory fs/btrfs/ so we can add -Wformat, I'd like to know what I'm
> >>> missing, we've had fixups for the size_t printk format so it would make
> >>> sense to catch it early.
> >>
> >> I guess it's due to the platform? (The report is from 32bit system).
> > 
> > Ah I see, I build on 64bit platform but should the Wformat warning also
> > point out mismatch there? The size_t type is an alias of unsigned long
> > so it is not an error but when size_t and %zu don't match could be a
> > platform-independent error, no? This would save us reports and followup
> > fixups roundtrips.
> 
> size_t is defined differently, in include/uapi/asm-generic/posix_types.h:
> 
> /*
>   * Most 32 bit architectures use "unsigned int" size_t,
>   * and all 64 bit architectures use "unsigned long" size_t.
>   */
> #ifndef __kernel_size_t
> #if __BITS_PER_LONG != 64
> typedef unsigned int    __kernel_size_t;
> typedef int             __kernel_ssize_t;
> typedef int             __kernel_ptrdiff_t;
> #else
> typedef __kernel_ulong_t __kernel_size_t;
> typedef __kernel_long_t __kernel_ssize_t;
> typedef __kernel_long_t __kernel_ptrdiff_t;
> #endif
> #endif
> 
> Thus this is the reason why we need @zu for size_t to handle the 
> difference, and since for 64bit it's just unsigned long, thus compiler 
> won't give any warning.

So it's the int/long difference and kernel does it in a special way due
to absence of the standard libc headers.

> (That's also why I tend to not use size_t at all, and why I like rust's 
> explicit sized type, and we may want to go that path to prefer 
> u8/u16/u32/u64 when possible)

Yeah, from what I've seen so far is that size_t brings us only problems,
I would not mind conversions to explicit types like u32 or u64. We do
that in many places, I think it's namely on the interface boundaries
where we provide a callback with a size_t type, but from that down it
could be u64.

Quick grep for size_t returns 300+ lines and 100+ of that is ssize_t,
that's still a lot so the conversions should be targeted.

