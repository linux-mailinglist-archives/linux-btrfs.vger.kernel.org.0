Return-Path: <linux-btrfs+bounces-8816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643F1998E1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 19:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BD5283D85
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151119D06D;
	Thu, 10 Oct 2024 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M2JHHTmY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OTnWmUJI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M2JHHTmY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OTnWmUJI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE419CC07
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580323; cv=none; b=NUZICFQIuNObHQDUi7D7e+Es83a7su4J671EnKzWCwgx/8Dr3tB3m1TkWoY/e+G+yMaN8Awyy1WwojeInlf97tuWMLygu45m2OuCvb8iH6n2yoXVJCSTi7/EvLB84wG2QSV/QyBVvCfPFzpmwI4UHKJ1T3MDx8kH4N7qUxDMeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580323; c=relaxed/simple;
	bh=QdP5vvGYNJjWIA/ArABgjRmBlyo0qkJvimXBhM/wYRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRbb6ajY84i6uQQMNWVyVrx+wF8GYHYfbFrf5dJtc/QbtBh/yL12urnZqwU8sWPyaB4B2PZBrLScri5fq5ycX3c+BF5l9VFkOaTefbt9G8bGyh9isGwMci7PYulNBn6j2bz0IQqALd46NfEuw0Pe1nY4E2SoHZa8CQFDe2zYK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M2JHHTmY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OTnWmUJI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M2JHHTmY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OTnWmUJI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E6F21F7EE;
	Thu, 10 Oct 2024 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728580320;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnzooejaljZgEwYvRrTuBfnUFR7uKNtyxa4jpqkyWOo=;
	b=M2JHHTmYi4KymkK6VuhWbNnblwuU0Q3FZO3II1td/dUOJ7OcZfi2w63MqwgKmLzp5QzCJz
	YRSpHOFuuUaxoIRly8e4v8Fk3i1v15DQc7WbICExm2rwOknlIF6kiCDZIvxjQRSLC1kDTU
	z9O8oF0U6AVOH9lbq6L0/g3aRtyWkm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728580320;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnzooejaljZgEwYvRrTuBfnUFR7uKNtyxa4jpqkyWOo=;
	b=OTnWmUJIP3U2nHLWQCB19bLRGrzzikUe4iDB50GqImFE4RbLLXpoZc+j2va8YEVpmOrY6Q
	IBAfHuszeYPaT3Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728580320;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnzooejaljZgEwYvRrTuBfnUFR7uKNtyxa4jpqkyWOo=;
	b=M2JHHTmYi4KymkK6VuhWbNnblwuU0Q3FZO3II1td/dUOJ7OcZfi2w63MqwgKmLzp5QzCJz
	YRSpHOFuuUaxoIRly8e4v8Fk3i1v15DQc7WbICExm2rwOknlIF6kiCDZIvxjQRSLC1kDTU
	z9O8oF0U6AVOH9lbq6L0/g3aRtyWkm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728580320;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnzooejaljZgEwYvRrTuBfnUFR7uKNtyxa4jpqkyWOo=;
	b=OTnWmUJIP3U2nHLWQCB19bLRGrzzikUe4iDB50GqImFE4RbLLXpoZc+j2va8YEVpmOrY6Q
	IBAfHuszeYPaT3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3474E13A6E;
	Thu, 10 Oct 2024 17:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DquWDOAKCGfnGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 10 Oct 2024 17:12:00 +0000
Date: Thu, 10 Oct 2024 19:11:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: handle NULL as device path for
 btrfs_scan_one_device()
Message-ID: <20241010171159.GS1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <330f0214f1d8150e25dc609477e89534e3da961a.1728527388.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <330f0214f1d8150e25dc609477e89534e3da961a.1728527388.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -8.00
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[cee29f5a48caf10cd475];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Oct 10, 2024 at 01:00:57PM +1030, Qu Wenruo wrote:
> [BUG]
> Syzbot reports a crash when mounting a btrfs with NULL as @path for
> btrfs_scan_one_device():
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 UID: 0 PID: 5235 Comm: syz-executor338 Not tainted 6.12.0-rc2-next-20241008-syzkaller #0
> RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
> Call Trace:
>  <TASK>
>  getname_kernel+0x1d/0x2f0 fs/namei.c:232
>  kern_path+0x1d/0x50 fs/namei.c:2716
>  is_good_dev_path fs/btrfs/volumes.c:760 [inline]
>  btrfs_scan_one_device+0x19e/0xd90 fs/btrfs/volumes.c:1484
>  btrfs_get_tree_super fs/btrfs/super.c:1841 [inline]
>  btrfs_get_tree+0x30e/0x1920 fs/btrfs/super.c:2114
>  vfs_get_tree+0x90/0x2b0 fs/super.c:1800
>  fc_mount+0x1b/0xb0 fs/namespace.c:1231
>  btrfs_get_tree_subvol fs/btrfs/super.c:2077 [inline]
>  btrfs_get_tree+0x652/0x1920 fs/btrfs/super.c:2115
>  vfs_get_tree+0x90/0x2b0 fs/super.c:1800
>  vfs_cmd_create+0xa0/0x1f0 fs/fsopen.c:225
>  __do_sys_fsconfig fs/fsopen.c:472 [inline]
>  __se_sys_fsconfig+0xa1f/0xf70 fs/fsopen.c:344
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe8c78542a9
> ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> The reproducer passes NULL as the device path for
> btrfs_scan_one_device().
> 
> Normally such case will be rejected by bdev_file_open_by_path(), which
> will return -EINVAL and we reject the mount.
> 
> But since commit ("btrfs: avoid unnecessary device path update for the
> same device") and commit ("btrfs: canonicalize the device path before
> adding") will do extra kern_path() lookup before
> bdev_file_open_by_path().
> 
> Unlike bdev_file_open_by_path(), kern_path() doesn't do the NULL pointer
> check and triggers the above strlen() on NULL pointer.
> 
> [FIX]
> For function is_good_dev_path() and get_canonical_dev_path(), do the
> extra NULL pointer checks.
> 
> This will be folded into the two offending patches, and I hope this is
> really the last fix I need to fold...

After you fold it please manually close the syzbot reports as this won't
be done by the automatic detection of the reported-by links.

