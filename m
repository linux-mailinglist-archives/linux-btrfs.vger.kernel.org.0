Return-Path: <linux-btrfs+bounces-2824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042598681E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 21:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7180A1F24A1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79598130E20;
	Mon, 26 Feb 2024 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qquDX3Rz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YmhkeoDt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qquDX3Rz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YmhkeoDt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E71E878
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979219; cv=none; b=oznAvanZVGQV/iNz+zcSK/IPZRQqvwbVx6QY2tC/rOm4PHJ5iGmT+nvLHM3rvVXZRIdzIWws1eByoY6/RxRo/dOcly056x3xyBRHwI9OAAuiQLAIMUt38fT4RXCz3PrluCgyzTHO+a7Gcjukovd+5S41zCM8tZjLjDO2P7jOQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979219; c=relaxed/simple;
	bh=bulEW0gAylrJr3RS5E6L1jhOsfPBaa/uj6ld3CPrGWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc34wMYkYAkUDgPaHK6aSpyhmtQG1QXdBBMY7BX/4Z7vSLwOCbacvUsm5HIucOwsKVWNnhkBAPVcxtibs8YL/lzeQLctyCPqO+clZkDrVr7d8IQ9+NI5NdcJjjkc7lm1PR3V2pylrBSyI95JATOCu24xq3DocOcpgNI5VNd/Gic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qquDX3Rz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YmhkeoDt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qquDX3Rz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YmhkeoDt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 55B281FB6B;
	Mon, 26 Feb 2024 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708979215;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NTwJp24/5gIGSiyuUeFIsSyJUCp2t13kUTi3765fkD0=;
	b=qquDX3Rz9qXQKUwPBCUcZKt7yh7LIp10O+SCbBUsxhMkMYxoxknh33ZEVVMlx6ceWEgYW3
	k6ZoAFWOX9k0S0AhfdCXxsoU41EX8LP8TZ2bGdGjYkVjQzPVtIWSkW2lwgwQLTaZOeY52V
	wiyrb54Jd5IKdJeegtb+GwIb3X6iTX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708979215;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NTwJp24/5gIGSiyuUeFIsSyJUCp2t13kUTi3765fkD0=;
	b=YmhkeoDt5gXy7lMKkTyUWLRB+h7s15l0+H4PUYroHwFpZZNEy17XMy2S/dSMRNr5Iy92Mf
	UgFfc6grWWY8loDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708979215;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NTwJp24/5gIGSiyuUeFIsSyJUCp2t13kUTi3765fkD0=;
	b=qquDX3Rz9qXQKUwPBCUcZKt7yh7LIp10O+SCbBUsxhMkMYxoxknh33ZEVVMlx6ceWEgYW3
	k6ZoAFWOX9k0S0AhfdCXxsoU41EX8LP8TZ2bGdGjYkVjQzPVtIWSkW2lwgwQLTaZOeY52V
	wiyrb54Jd5IKdJeegtb+GwIb3X6iTX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708979215;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NTwJp24/5gIGSiyuUeFIsSyJUCp2t13kUTi3765fkD0=;
	b=YmhkeoDt5gXy7lMKkTyUWLRB+h7s15l0+H4PUYroHwFpZZNEy17XMy2S/dSMRNr5Iy92Mf
	UgFfc6grWWY8loDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 38F8D1329E;
	Mon, 26 Feb 2024 20:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1gZ3DQ/03GVMLQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 26 Feb 2024 20:26:55 +0000
Date: Mon, 26 Feb 2024 21:26:10 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix double free of anonymous device after
 snapshot creation failure
Message-ID: <20240226202610.GH17966@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2b3c3fd6b5a6b9f9a7aa39cd343b233a11495bce.1708707655.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b3c3fd6b5a6b9f9a7aa39cd343b233a11495bce.1708707655.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Fri, Feb 23, 2024 at 05:03:19PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When creating a snapshot we may do a double free of an anonymous device
> in case there's an error comitting the transaction. The second free may
> result in freeing an anonymous device number that was allocated by some
> other subsystem in the kernel or another btrfs filesystem.
> 
> The steps that lead to this:
> 
> 1) At ioctl.c:create_snapshot() we allocate an anonymous device number
>    and assign it to pending_snapshot->anon_dev;
> 
> 2) Then we call btrfs_commit_transaction() and end up at
>    transaction.c:create_pending_snapshot();
> 
> 3) There we call btrfs_get_new_fs_root() and pass it the anonymous device
>    number stored in pending_snapshot->anon_dev;
> 
> 4) btrfs_get_new_fs_root() frees that anonymous device number because
>    btrfs_lookup_fs_root() returned a root - someone else did a lookup
>    of the new root already, which could some task doing backref walking;
> 
> 5) After that some error happens in the transaction commit path, and at
>    ioctl.c:create_snapshot() we jump to the 'fail' label, and after
>    that we free again the same anonymous device number, which in the
>    meanwhile may have been reallocated somewhere else, because
>    pending_snapshot->anon_dev still has the same value as in step 1.
> 
> Recently syzbot ran into this and reported the following trace:
> 
>   ------------[ cut here ]------------
>   ida_free called for id=51 which is not allocated.
>   WARNING: CPU: 1 PID: 31038 at lib/idr.c:525 ida_free+0x370/0x420 lib/idr.c:525
>   Modules linked in:
>   CPU: 1 PID: 31038 Comm: syz-executor.2 Not tainted 6.8.0-rc4-syzkaller-00410-gc02197fc9076 #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
>   RIP: 0010:ida_free+0x370/0x420 lib/idr.c:525
>   Code: 10 42 80 3c 28 (...)
>   RSP: 0018:ffffc90015a67300 EFLAGS: 00010246
>   RAX: be5130472f5dd000 RBX: 0000000000000033 RCX: 0000000000040000
>   RDX: ffffc90009a7a000 RSI: 000000000003ffff RDI: 0000000000040000
>   RBP: ffffc90015a673f0 R08: ffffffff81577992 R09: 1ffff92002b4cdb4
>   R10: dffffc0000000000 R11: fffff52002b4cdb5 R12: 0000000000000246
>   R13: dffffc0000000000 R14: ffffffff8e256b80 R15: 0000000000000246
>   FS:  00007fca3f4b46c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f167a17b978 CR3: 000000001ed26000 CR4: 0000000000350ef0
>   Call Trace:
>    <TASK>
>    btrfs_get_root_ref+0xa48/0xaf0 fs/btrfs/disk-io.c:1346
>    create_pending_snapshot+0xff2/0x2bc0 fs/btrfs/transaction.c:1837
>    create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1931
>    btrfs_commit_transaction+0xf1c/0x3740 fs/btrfs/transaction.c:2404
>    create_snapshot+0x507/0x880 fs/btrfs/ioctl.c:848
>    btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:998
>    btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1044
>    __btrfs_ioctl_snap_create+0x387/0x4b0 fs/btrfs/ioctl.c:1306
>    btrfs_ioctl_snap_create_v2+0x1ca/0x400 fs/btrfs/ioctl.c:1393
>    btrfs_ioctl+0xa74/0xd40
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:871 [inline]
>    __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:857
>    do_syscall_64+0xfb/0x240
>    entry_SYSCALL_64_after_hwframe+0x6f/0x77
>   RIP: 0033:0x7fca3e67dda9
>   Code: 28 00 00 00 (...)
>   RSP: 002b:00007fca3f4b40c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>   RAX: ffffffffffffffda RBX: 00007fca3e7abf80 RCX: 00007fca3e67dda9
>   RDX: 00000000200005c0 RSI: 0000000050009417 RDI: 0000000000000003
>   RBP: 00007fca3e6ca47a R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>   R13: 000000000000000b R14: 00007fca3e7abf80 R15: 00007fff6bf95658
>    </TASK>
> 
> Where we get an explicit message where we attempt to free an anonymous
> device number that is not currently allocated. It happens in a different
> code path from the example below, at btrfs_get_root_ref(), so this change
> may not fix the case triggered by syzbot.
> 
> To fix at least the code path from the example above, change
> btrfs_get_root_ref() and its callers to receive a dev_t pointer argument
> for the anonymous device number, so that in case it frees the number, it
> also resets it to 0, so that up in the call chain we don't attempt to do
> the double free.
> 
> Link: https://lore.kernel.org/linux-btrfs/000000000000f673a1061202f630@google.com/

The link is fine as one can go directly to the report, for the syzbot to
auto-close the report I think it's most reliable to add

Reported-by: syzbot+623a623cfed57f422be1@syzkaller.appspotmail.com

> Fixes: e03ee2fe873e ("btrfs: do not ASSERT() if the newly created subvolume already got read")

This has been backported up to 5.10 so we'll need

CC: stable@vger.kernel.org # 5.10+

> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

