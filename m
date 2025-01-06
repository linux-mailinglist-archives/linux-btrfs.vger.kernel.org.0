Return-Path: <linux-btrfs+bounces-10750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3210DA02A65
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 16:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8C97A294C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B3155389;
	Mon,  6 Jan 2025 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R/qRodYo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MctA8St/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R/qRodYo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MctA8St/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2033146D40;
	Mon,  6 Jan 2025 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177524; cv=none; b=Opt7VODiwyXm8joD1Cuj4qd7oYDR05A9RQQVt3wZ/O9mXc33W4naHaw1CrRwRcKBa0d1QtW8nX1/KMnF8xf/iTrH4QS0+pGOVXQoqccLmoTMbdnnp2TiSvVrrqesxi++a3a8ff4/SV1xWuKrF4/cnwngUKevV0cVukWNxhdu4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177524; c=relaxed/simple;
	bh=/G9+Yb8kn7wg4YdU8kvnGne8UfvUBTpY7bX3MS8QRtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYjZKjkFbmRtBDL5yDWcDs8tUIa0rhDJX49gElABr4i3PiNE7HU7kY9GWE2M4XWjTDmPTphTJh6WVUf5w63TZ6fN12l8LTZQoO28fjJ/gc6JiCN/ET2MMSkIt1dtA/E9823EvzowfFgpoZlXqmGOUQAhT6qEApdylzL+fUSRUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R/qRodYo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MctA8St/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R/qRodYo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MctA8St/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7697D21162;
	Mon,  6 Jan 2025 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736177513;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnxI4yj2ILtDGW6qI0p/lc3xOpDr/yT84ekSCr2K/NE=;
	b=R/qRodYoJb9QAxhMNc7rcZ6Qo27eN4KhlsD8MetqlD8B313WYlXyuGxR0/NKgVOzF5Ikco
	a2WkFN8XrxkDCKluYg1Y6/nBxXgbtwZzY+cuckbS/MNzcW4WkhzIDLhTCarQS8FSvAeycZ
	EAGvvG2h4F2EjYK0/cnDsj6Qx9L4AP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736177513;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnxI4yj2ILtDGW6qI0p/lc3xOpDr/yT84ekSCr2K/NE=;
	b=MctA8St/CKaVLAjir/UI4Y6hpGnXxBrmpGQXruz4v/VKIlY33yraj1Hd3Ab8dXWFdDl9gO
	+0SxgUNDvJbDOcBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="R/qRodYo";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="MctA8St/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736177513;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnxI4yj2ILtDGW6qI0p/lc3xOpDr/yT84ekSCr2K/NE=;
	b=R/qRodYoJb9QAxhMNc7rcZ6Qo27eN4KhlsD8MetqlD8B313WYlXyuGxR0/NKgVOzF5Ikco
	a2WkFN8XrxkDCKluYg1Y6/nBxXgbtwZzY+cuckbS/MNzcW4WkhzIDLhTCarQS8FSvAeycZ
	EAGvvG2h4F2EjYK0/cnDsj6Qx9L4AP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736177513;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnxI4yj2ILtDGW6qI0p/lc3xOpDr/yT84ekSCr2K/NE=;
	b=MctA8St/CKaVLAjir/UI4Y6hpGnXxBrmpGQXruz4v/VKIlY33yraj1Hd3Ab8dXWFdDl9gO
	+0SxgUNDvJbDOcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 464E3139AB;
	Mon,  6 Jan 2025 15:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qfzyEGn3e2f9SgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Jan 2025 15:31:53 +0000
Date: Mon, 6 Jan 2025 16:31:48 +0100
From: David Sterba <dsterba@suse.cz>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Fix avail_in bytes for s390 zlib HW
 compression path
Message-ID: <20250106153148.GB31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241218103251.3753503-1-zaslonko@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218103251.3753503-1-zaslonko@linux.ibm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 7697D21162
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Dec 18, 2024 at 11:32:51AM +0100, Mikhail Zaslonko wrote:
> Since the input data length passed to zlib_compress_folios() can be
> arbitrary, always setting strm.avail_in to a multiple of PAGE_SIZE may
> cause read-in bytes to exceed the input range. Currently this triggers
> an assert in btrfs_compress_folios() on the debug kernel (see below).
> Fix strm.avail_in calculation for S390 hardware acceleration path.
> 
>  assertion failed: *total_in <= orig_len, in fs/btrfs/compression.c:1041
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/compression.c:1041!
>  monitor event: 0040 ilc:2 [#1] PREEMPT SMP
>  CPU: 16 UID: 0 PID: 325 Comm: kworker/u273:3 Not tainted 6.13.0-20241204.rc1.git6.fae3b21430ca.300.fc41.s390x+debug #1
>  Hardware name: IBM 3931 A01 703 (z/VM 7.4.0)
>  Workqueue: btrfs-delalloc btrfs_work_helper
>  Krnl PSW : 0704d00180000000 0000021761df6538 (btrfs_compress_folios+0x198/0x1a0)
>             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
>  Krnl GPRS: 0000000080000000 0000000000000001 0000000000000047 0000000000000000
>             0000000000000006 ffffff01757bb000 000001976232fcc0 000000000000130c
>             000001976232fcd0 000001976232fcc8 00000118ff4a0e30 0000000000000001
>             00000111821ab400 0000011100000000 0000021761df6534 000001976232fb58
>  Krnl Code: 0000021761df6528: c020006f5ef4        larl    %r2,0000021762be2310
>             0000021761df652e: c0e5ffbd09d5        brasl   %r14,00000217615978d8
>            #0000021761df6534: af000000            mc      0,0
>            >0000021761df6538: 0707                bcr     0,%r7
>             0000021761df653a: 0707                bcr     0,%r7
>             0000021761df653c: 0707                bcr     0,%r7
>             0000021761df653e: 0707                bcr     0,%r7
>             0000021761df6540: c004004bb7ec        brcl    0,000002176276d518
>  Call Trace:
>   [<0000021761df6538>] btrfs_compress_folios+0x198/0x1a0
>  ([<0000021761df6534>] btrfs_compress_folios+0x194/0x1a0)
>   [<0000021761d97788>] compress_file_range+0x3b8/0x6d0
>   [<0000021761dcee7c>] btrfs_work_helper+0x10c/0x160
>   [<0000021761645760>] process_one_work+0x2b0/0x5d0
>   [<000002176164637e>] worker_thread+0x20e/0x3e0
>   [<000002176165221a>] kthread+0x15a/0x170
>   [<00000217615b859c>] __ret_from_fork+0x3c/0x60
>   [<00000217626e72d2>] ret_from_fork+0xa/0x38
>  INFO: lockdep is turned off.
>  Last Breaking-Event-Address:
>   [<0000021761597924>] _printk+0x4c/0x58
>  Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> Fixes: fd1e75d0105d ("btrfs: make compression path to be subpage compatible")
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Added to for-next, thanks.

