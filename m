Return-Path: <linux-btrfs+bounces-1342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1780E829244
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 02:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717C0B218FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 01:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086EA17F5;
	Wed, 10 Jan 2024 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QEwwo7M3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ebU4slKe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qT90n4rs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GllvsqAA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C141376
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDCE32219D;
	Wed, 10 Jan 2024 01:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704851970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSwDIRV4DZMIzyvFLCeYPmg0euy+erTMyxRLYBH8TCQ=;
	b=QEwwo7M3J3ToASO/jzRmh4ktzgUBNhne74P823fd9a2tKaTyfnztsi5EeHeiNe8LEOEcll
	nmee9fRgHV7GdUlJc5zy0qHOj34hvaPcgxoD4G532TaWg+oeGPfD6XV8Bo3X9SL3L4Xpxe
	eJkuEgROHxtOnaMsUuHH0+Lha9kP6z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704851970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSwDIRV4DZMIzyvFLCeYPmg0euy+erTMyxRLYBH8TCQ=;
	b=ebU4slKel5Xb3+2CPuaeDWSe8ePOIs9guxXzKMVnU8j6pdaJkXO8M8inuLuGeVwShZFWs2
	eoVkD7ZTocBF4NDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704851969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSwDIRV4DZMIzyvFLCeYPmg0euy+erTMyxRLYBH8TCQ=;
	b=qT90n4rsVQFFN0sZezn6U6vVJVpKvhdshTsXLB9i2ID7ZFYsdB6oXVt2hQSAQKtsBFVc7q
	KrUccxPhPwtzFFK/wS3EkuPzDWrnNB6wXdtObTPsCT8e+3G5l/QfxQMjTSMUPdZlYxyl5E
	qHZLcwN/ImdI+K3eOv9W631v7VLQ1nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704851969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSwDIRV4DZMIzyvFLCeYPmg0euy+erTMyxRLYBH8TCQ=;
	b=GllvsqAAIGwNxW/5c2Bn2N6il5D6rDj9CCh/36j3H+yz753+Dip84OHYIUZwvaHH0SaLiL
	yCLfOnRFiZN2XRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A21C313C94;
	Wed, 10 Jan 2024 01:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0oFlJwH6nWWBDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 01:59:29 +0000
Date: Wed, 10 Jan 2024 02:59:11 +0100
From: David Sterba <dsterba@suse.cz>
To: kernel test robot <lkp@intel.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/3] btrfs: zlib: fix and simplify the inline extent
 decompression
Message-ID: <20240110015800.GP28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu@suse.com>
 <202401091012.pLm6PcKG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401091012.pLm6PcKG-lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qT90n4rs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GllvsqAA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.29 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,git-scm.com:url,intel.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[11.44%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 3.29
X-Rspamd-Queue-Id: BDCE32219D
X-Spam-Flag: NO

On Tue, Jan 09, 2024 at 11:02:54AM +0800, kernel test robot wrote:
> Hi Qu,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on kdave/for-next]
> [also build test WARNING on next-20240108]
> [cannot apply to linus/master v6.7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-zlib-fix-and-simplify-the-inline-extent-decompression/20240108-171206
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> patch link:    https://lore.kernel.org/r/29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu%40suse.com
> patch subject: [PATCH 1/3] btrfs: zlib: fix and simplify the inline extent decompression
> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240109/202401091012.pLm6PcKG-lkp@intel.com/config)
> compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401091012.pLm6PcKG-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401091012.pLm6PcKG-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/btrfs/zlib.c:402:15: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
>      401 |                 pr_warn_ratelimited("BTRFS: infalte failed, decompressed=%lu expected=%lu\n",
>          |                                                                                       ~~~
>          |                                                                                       %zu
>      402 |                                         to_copy, destlen);
>          |                                                  ^~~~~~~

Valid report but I can't reproduce it. Built with clang 17 and
explicitly enabled -Wformat. We have additional warnings enabled per
directory fs/btrfs/ so we can add -Wformat, I'd like to know what I'm
missing, we've had fixups for the size_t printk format so it would make
sense to catch it early.

