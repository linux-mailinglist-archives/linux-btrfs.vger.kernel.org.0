Return-Path: <linux-btrfs+bounces-5006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0D8C69A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 17:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9AB282C05
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 15:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA63155A52;
	Wed, 15 May 2024 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KH3fKfAn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iasrH6Zg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ommtw1sL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4OBcsZ8q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C067155752;
	Wed, 15 May 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786880; cv=none; b=UW2KwscL0dG6rl2DNLzb5V+m1zoWxFdmJOjcWnvVMtw+AMRrOlcdfQP4T7nUimwVMfyme7wF6lcvK1Q7EH6/WJqVN5wk+vkYPz47XnFPKW9Xd3t14J8SYQDpVHlZVM60c0kRVOf5VPQnVy/v8H/KB5x7rlz41GfN67f+cfK0wSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786880; c=relaxed/simple;
	bh=g1lVgGrmRqhqbAzR7xXGynSAR7VP0f5zUHajn+I4RV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KupwPDNhLf20osNAV1QZi9E8nhZAVwlVxI+atz9q1WhSW+PxfWMSSPFDVJOc6/d2a/rnw2btQasn+llxfgLo3Anr2pQYPj9/olmy/+QHVQMtlo30Z0QiAtugBev7ekdjCvK4+3tD63q1gbkPUsdN3NEK3sV43QxbxfM1uH24+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KH3fKfAn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iasrH6Zg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ommtw1sL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4OBcsZ8q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 778552084F;
	Wed, 15 May 2024 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715786870;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t134jEfnBj2jr8XB1K6GdCjxt6Dl3/mJ1ThDTNYqYBA=;
	b=KH3fKfAnXVyJoPnin9E/o6QmbEItEcNCtKtaezQ5hnwhjVSnWlUwoM+KeS72MPUgqkf9OM
	+CNTOY+ASyXP6cpbNc96QLaQavSX8TD+qLcjR2JCC7I1z5KY31/HnuuZB4HWVlmuw1GqS1
	EIwgF+cN9ZbUJFl1iMG+OUq+Hma3vYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715786870;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t134jEfnBj2jr8XB1K6GdCjxt6Dl3/mJ1ThDTNYqYBA=;
	b=iasrH6Zgyi4ZolvQOwIaRAiHF42kARzVvsB/UfuNE+5ycs+lcbkAlR/GGX33yYu5TVVhVg
	SPwZH+Nmfp/fOXDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715786869;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t134jEfnBj2jr8XB1K6GdCjxt6Dl3/mJ1ThDTNYqYBA=;
	b=Ommtw1sLkW83hf03hNwsIDnKfwdFjjBbhxcr15mpZ0wi3/Xr5FsHJe/E3ZN8Xp0NSrJdz4
	7V2COIVVie3coYMM/LDI2cFk9TbbWM6DOlaO5ba+IXaZ0wqitRBmHnKdXyZB1QFJUCqc9V
	zgRcUmd34YwcveEOt9+0Ys/21bstvbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715786869;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t134jEfnBj2jr8XB1K6GdCjxt6Dl3/mJ1ThDTNYqYBA=;
	b=4OBcsZ8qOK+TuPtbKPczVjbx3NFXxGyvOP16yqldCMo8qmvCb6Jh8FsSRaQBOo3LGFxMIx
	kckznFfvESJETRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 585C2136A8;
	Wed, 15 May 2024 15:27:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xX7gFHXURGYcDwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 15:27:49 +0000
Date: Wed, 15 May 2024 17:27:47 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+f7a41568dd5872d6ad52@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] possible deadlock in join_transaction
Message-ID: <20240515152747.GM4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0000000000001ac5ea061835f021@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001ac5ea061835f021@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: 1.23
X-Spam-Level: *
X-Spamd-Result: default: False [1.23 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a450595960709c8];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	BAYES_HAM(-0.27)[73.86%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[f7a41568dd5872d6ad52];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	SUBJECT_HAS_QUESTION(0.00)[]

On Sat, May 11, 2024 at 04:23:20PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ad432f180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a450595960709c8
> dashboard link: https://syzkaller.appspot.com/bug?extid=f7a41568dd5872d6ad52
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-dccb07f2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/987455e5cf13/vmlinux-dccb07f2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/327c390f753b/bzImage-dccb07f2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f7a41568dd5872d6ad52@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0 Not tainted
> ------------------------------------------------------
> kswapd0/110 is trying to acquire lock:
> ffff888000c76380 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x430/0xf40 fs/btrfs/transaction.c:290
> 
> but task is already holding lock:
> ffff88805a236610 (sb_internal#2){.+.+}-{0:0}, at: btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275
> 
> which lock already depends on the new lock.

Looks valid, though I haven't went through all the traces, there are
some usual suspects like shrinkers, evict, iput, and in two threads (#4 and #0).

Also this is on 6.9, so the recent addition of shrinker for extent_map
is not relevant here.

