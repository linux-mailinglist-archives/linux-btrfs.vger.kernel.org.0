Return-Path: <linux-btrfs+bounces-11769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50603A43F9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 13:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631FF189A245
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 12:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BD726657E;
	Tue, 25 Feb 2025 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hZdqz3ee";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4wnRHp7o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uBwlNQoq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ikEcUy6Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B963A1DB
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487309; cv=none; b=SWJBD1Z1a1ihVOr+v57BCtsn1gfZqUJOxt2qolO2LVEoNbnyB2Iy9rwSIPKyJGvTHQvtrb0pvP6IzvDs6qf9s+cC97fUdcuO9iDranE1c2MGUqrNiQjpA8fggnIa87q7q3oczKdg4IvTohAe3sI0k2BFakNFhokGgrC7ZzieJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487309; c=relaxed/simple;
	bh=POblSCurFVRXGiiG6iZjbrQdJC1N9GDwjufovCyjUIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul43RwZQWPbn9UkeVV3b4zT44p26CgwaEvwiWCma6Vzr1FoCfrc116cUUaUJmE7oGRvwv6LDcCzyCi+D+m6rVK1i6WqDXObEeXWb6lrHisBMqBIYLTEWJDcUZps2pRJqhYO2Uees1MrewafyLB3gvsDhAajRsI+hcpDt5Vustbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hZdqz3ee; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4wnRHp7o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uBwlNQoq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ikEcUy6Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E836421179;
	Tue, 25 Feb 2025 12:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740487305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=djZ5cPGk1imANDgyd4NIJjrulOgYkPjDOX2halcjkZY=;
	b=hZdqz3eecdeRyIA79HInl5naPWO+dGZGOYiFDuPuHPwbBINKGMI9WWA1ks1LKiYqYURtlS
	Ptn3LQi1zIssM22TQU2w7AfY9IBpjFmfoERWja4zq1vgzN759vEt0CjyeF2/41uiqK4a8u
	fvMExE8vG4OJhGnLEjYB5o+ITYFKz0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740487305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=djZ5cPGk1imANDgyd4NIJjrulOgYkPjDOX2halcjkZY=;
	b=4wnRHp7oWj0VLTMNNqxdBQDkycLisFyLJs9+VmmnoN070JNmUyptzxJuASM2GUq5LWBryJ
	YJM8cSJgyEnwwkBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740487304;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=djZ5cPGk1imANDgyd4NIJjrulOgYkPjDOX2halcjkZY=;
	b=uBwlNQoqNFsn3iX6nNHJkTcEUBrI/lY+KCZfD4lXkQxfXW7SghCHVGr5qon9a1PpTnDQVk
	sCCiGxfh9ZTz5CcvEUBgj5EMUlZSD+QRrbAxLRkhqu0KPsjWV7gijtYk0lcr2yt4cIt9K0
	3PaCz3cGvhZUjpa73opi+Yv/+Gr94Lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740487304;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=djZ5cPGk1imANDgyd4NIJjrulOgYkPjDOX2halcjkZY=;
	b=ikEcUy6YjEwdikWhZJZfJYMtvf8MKthRdL5hF6GQCTJZWPVeOQN1CPJFhGOrd+qwp7GbM8
	Fjs2HwR6W0b95YAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD03E13888;
	Tue, 25 Feb 2025 12:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nXunLYi6vWcqVAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Feb 2025 12:41:44 +0000
Date: Tue, 25 Feb 2025 13:41:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: fix extent unlock in cow_file_range()
Message-ID: <20250225124143.GN5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <baa48c5a32ae079b218613cbdae175f2387cd745.1739948529.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa48c5a32ae079b218613cbdae175f2387cd745.1739948529.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,twin.jikos.cz:mid];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 19, 2025 at 04:02:11PM +0900, Naohiro Aota wrote:
> Running generic/751 on the btrfs for-next often results in hung like
> below. They are both stack by locking an extent. This suggests someone
> forget to unlock an extent.
> 
>     INFO: task kworker/u128:1:12 blocked for more than 323 seconds.
>           Not tainted 6.13.0-BTRFS-ZNS+ #503
>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     task:kworker/u128:1  state:D stack:0     pid:12    tgid:12    ppid:2      flags:0x00004000
>     Workqueue: btrfs-fixup btrfs_work_helper [btrfs]
>     Call Trace:
>      <TASK>
>      __schedule+0x534/0xdd0
>      schedule+0x39/0x140
>      __lock_extent+0x31b/0x380 [btrfs]
>      ? __pfx_autoremove_wake_function+0x10/0x10
>      btrfs_writepage_fixup_worker+0xf1/0x3a0 [btrfs]
>      btrfs_work_helper+0xff/0x480 [btrfs]
>      ? lock_release+0x178/0x2c0
>      process_one_work+0x1ee/0x570
>      ? srso_return_thunk+0x5/0x5f
>      worker_thread+0x1d1/0x3b0
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0x10b/0x230
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x30/0x50
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
>     INFO: task kworker/u134:0:184 blocked for more than 323 seconds.
>           Not tainted 6.13.0-BTRFS-ZNS+ #503
>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     task:kworker/u134:0  state:D stack:0     pid:184   tgid:184   ppid:2      flags:0x00004000
>     Workqueue: writeback wb_workfn (flush-btrfs-4)
>     Call Trace:
>      <TASK>
>      __schedule+0x534/0xdd0
>      schedule+0x39/0x140
>      __lock_extent+0x31b/0x380 [btrfs]
>      ? __pfx_autoremove_wake_function+0x10/0x10
>      find_lock_delalloc_range+0xdb/0x260 [btrfs]
>      writepage_delalloc+0x12f/0x500 [btrfs]
>      ? srso_return_thunk+0x5/0x5f
>      extent_write_cache_pages+0x232/0x840 [btrfs]
>      btrfs_writepages+0x72/0x130 [btrfs]
>      do_writepages+0xe7/0x260
>      ? srso_return_thunk+0x5/0x5f
>      ? lock_acquire+0xd2/0x300
>      ? srso_return_thunk+0x5/0x5f
>      ? find_held_lock+0x2b/0x80
>      ? wbc_attach_and_unlock_inode.part.0+0x102/0x250
>      ? wbc_attach_and_unlock_inode.part.0+0x102/0x250
>      __writeback_single_inode+0x5c/0x4b0
>      writeback_sb_inodes+0x22d/0x550
>      __writeback_inodes_wb+0x4c/0xe0
>      wb_writeback+0x2f6/0x3f0
>      wb_workfn+0x32a/0x510
>      process_one_work+0x1ee/0x570
>      ? srso_return_thunk+0x5/0x5f
>      worker_thread+0x1d1/0x3b0
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0x10b/0x230
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x30/0x50
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
> 
> This happens because we have another success path for the zoned mode. When
> there is no active zone available, btrfs_reserve_extent() returns
> -EAGAIN. In this case, we have two reactions. (1) If the given range is
> never allocated, we can only wait for someone to finish a zone, so wait on
> BTRFS_FS_NEED_ZONE_FINISH bit and retry afterward. (2) Or, if some
> allocations are already done, we must bail out and let the caller to send
> IOs for the allocation. This is because these IOs may be necessary to
> finish a zone.
> 
> The commit 06f364284794 ("btrfs: do proper folio cleanup when
> cow_file_range() failed") moved the unlock code from the inside of the loop
> to the outside. So, previously, the allocated extents are unlocked just
> after the allocation and so before returning from the function. However,
> they are no longer unlocked on the case (2) above. That caused the hung
> issue.
> 
> Fix the issue by modifying the 'end' to the end of the allocated
> range. Then, we can exit the loop and the same unlock code can properly
> handle the case.
> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> CC: stable@vger.kernel.org
> Fixes: 06f364284794 ("btrfs: do proper folio cleanup when cow_file_range() failed")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to for-next, thanks.

