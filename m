Return-Path: <linux-btrfs+bounces-1344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C970C829271
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 03:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0281F26B1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 02:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292381C2D;
	Wed, 10 Jan 2024 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uKQQdLL6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pf+2r3/1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uKQQdLL6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pf+2r3/1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B915C0
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 947CC221A9;
	Wed, 10 Jan 2024 02:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704853618;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3xR/VXu5oTD4rNGb7vUwTQWM/qoPJYtwzuuqmj1eApU=;
	b=uKQQdLL64+y3RFmwL7UlpYqPC5/6LWWH+60wRtDsxOyrrKsDTQ0QN1zn0/x+K9ylkhFYPb
	5LOPiD2wZKwvIzJhK6VGUWfZHJ+1V0jxOFbb6shcFTRtMDpsn2NghP2TasGawaxOxJnNTn
	O+oJtmILU7RQeQYtp48wMD6azCoXXYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704853618;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3xR/VXu5oTD4rNGb7vUwTQWM/qoPJYtwzuuqmj1eApU=;
	b=Pf+2r3/13IBprvh0knkhebycIOEtPl42rHUdVpdAwo1aAINKlRHpdazkew4ea732S7kZpQ
	IKw+FORm9v2mrZCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704853618;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3xR/VXu5oTD4rNGb7vUwTQWM/qoPJYtwzuuqmj1eApU=;
	b=uKQQdLL64+y3RFmwL7UlpYqPC5/6LWWH+60wRtDsxOyrrKsDTQ0QN1zn0/x+K9ylkhFYPb
	5LOPiD2wZKwvIzJhK6VGUWfZHJ+1V0jxOFbb6shcFTRtMDpsn2NghP2TasGawaxOxJnNTn
	O+oJtmILU7RQeQYtp48wMD6azCoXXYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704853618;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3xR/VXu5oTD4rNGb7vUwTQWM/qoPJYtwzuuqmj1eApU=;
	b=Pf+2r3/13IBprvh0knkhebycIOEtPl42rHUdVpdAwo1aAINKlRHpdazkew4ea732S7kZpQ
	IKw+FORm9v2mrZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66D5313786;
	Wed, 10 Jan 2024 02:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lazkGHIAnmXDHAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 02:26:58 +0000
Date: Wed, 10 Jan 2024 03:26:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, kernel test robot <lkp@intel.com>,
	linux-btrfs@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/3] btrfs: zlib: fix and simplify the inline extent
 decompression
Message-ID: <20240110022643.GQ28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu@suse.com>
 <202401091012.pLm6PcKG-lkp@intel.com>
 <20240110015800.GP28693@twin.jikos.cz>
 <e3c5ace5-4266-4a6a-9836-f58f5fff66fe@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c5ace5-4266-4a6a-9836-f58f5fff66fe@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.93 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
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
	 NEURAL_HAM_SHORT(-0.13)[-0.674];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.93

On Wed, Jan 10, 2024 at 12:33:17PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/10 12:29, David Sterba wrote:
> > On Tue, Jan 09, 2024 at 11:02:54AM +0800, kernel test robot wrote:
> >> Hi Qu,
> >>
> >> kernel test robot noticed the following build warnings:
> >>
> >> [auto build test WARNING on kdave/for-next]
> >> [also build test WARNING on next-20240108]
> >> [cannot apply to linus/master v6.7]
> >> [If your patch is applied to the wrong git tree, kindly drop us a note.
> >> And when submitting patch, we suggest to use '--base' as documented in
> >> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >>
> >> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-zlib-fix-and-simplify-the-inline-extent-decompression/20240108-171206
> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> >> patch link:    https://lore.kernel.org/r/29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu%40suse.com
> >> patch subject: [PATCH 1/3] btrfs: zlib: fix and simplify the inline extent decompression
> >> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240109/202401091012.pLm6PcKG-lkp@intel.com/config)
> >> compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> >> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401091012.pLm6PcKG-lkp@intel.com/reproduce)
> >>
> >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >> the same patch/commit), kindly add following tags
> >> | Reported-by: kernel test robot <lkp@intel.com>
> >> | Closes: https://lore.kernel.org/oe-kbuild-all/202401091012.pLm6PcKG-lkp@intel.com/
> >>
> >> All warnings (new ones prefixed by >>):
> >>
> >>>> fs/btrfs/zlib.c:402:15: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
> >>       401 |                 pr_warn_ratelimited("BTRFS: infalte failed, decompressed=%lu expected=%lu\n",
> >>           |                                                                                       ~~~
> >>           |                                                                                       %zu
> >>       402 |                                         to_copy, destlen);
> >>           |                                                  ^~~~~~~
> > 
> > Valid report but I can't reproduce it. Built with clang 17 and
> > explicitly enabled -Wformat. We have additional warnings enabled per
> > directory fs/btrfs/ so we can add -Wformat, I'd like to know what I'm
> > missing, we've had fixups for the size_t printk format so it would make
> > sense to catch it early.
> 
> I guess it's due to the platform? (The report is from 32bit system).

Ah I see, I build on 64bit platform but should the Wformat warning also
point out mismatch there? The size_t type is an alias of unsigned long
so it is not an error but when size_t and %zu don't match could be a
platform-independent error, no? This would save us reports and followup
fixups roundtrips.

> Otherwise it's indeed my bad, for now I don't even have a 32bit VM to 
> verify, thus my LSP doesn't warn me about the format.

Yeah, it could/should though.

