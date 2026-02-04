Return-Path: <linux-btrfs+bounces-21360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHbJN7JSg2mJlQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21360-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 15:07:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40549E6DD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 15:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C98823006447
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD5040F8D2;
	Wed,  4 Feb 2026 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pEGXqOWQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8YY5IMff";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pEGXqOWQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8YY5IMff"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948EB32571B
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214060; cv=none; b=XM3N6jKh5UmcQimCJkim8yXpoV979XWFZw93fIyV33DyA/TbGTVq5n5tixAg1bPMo5UmMXIfn8y/JeWLZm6x+aZK+O+2/K7DcKMN9Qatii6eEJ9cIpMprqVVf4vwf53UOhzuhr31Nl1fmDkcmcM7HTctmgYyvZOzUwK7TrP8JQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214060; c=relaxed/simple;
	bh=Dn+vdpUrp4VcDYGSDk4yaBfy236Og1GvlbvWeCe5wks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8p6S0aA/Stb2+vY36TsMqG+AgNb8pIA3aPgi4119dAD/27wCCSCf9RnnLMKDfmMoYmkiugABNkdCxHQH3tDGz+o7LvvlRUBeimaQsWPcZ96PydRXjkAl/4HSwdYrpA+gjegXIXb+n4RsdLj0d13aqIwsAZmwVhZUsbP09UrePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pEGXqOWQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8YY5IMff; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pEGXqOWQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8YY5IMff; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0AB83E73D;
	Wed,  4 Feb 2026 14:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770214058;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmAMfN61NIaA3dnevr+J0Hoci7C+bDaaKWUbkLxtBAk=;
	b=pEGXqOWQtaKH4th1DJ4gXC52bnj/kJbiLxmoD7yNQpWj1q/ZhVrBacdKntfQTBQZmmiXEj
	f5dV5AGjDg31rTx/r9f4QbKijV40nbPIWf3NBrmPvJrwG7nUXY69EWezq40cSPTrPNl4lN
	X+EfmpuiwMtYhQMk56NmDqmH5Sa4gyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770214058;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmAMfN61NIaA3dnevr+J0Hoci7C+bDaaKWUbkLxtBAk=;
	b=8YY5IMff6SLmm3kfasTEqJJ8qyubozHgB5NaQtwoQfNHCuQh+WEaJnhQ17e/I1yIRYoBny
	xYoO/ALpp08LdSDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pEGXqOWQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8YY5IMff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770214058;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmAMfN61NIaA3dnevr+J0Hoci7C+bDaaKWUbkLxtBAk=;
	b=pEGXqOWQtaKH4th1DJ4gXC52bnj/kJbiLxmoD7yNQpWj1q/ZhVrBacdKntfQTBQZmmiXEj
	f5dV5AGjDg31rTx/r9f4QbKijV40nbPIWf3NBrmPvJrwG7nUXY69EWezq40cSPTrPNl4lN
	X+EfmpuiwMtYhQMk56NmDqmH5Sa4gyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770214058;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmAMfN61NIaA3dnevr+J0Hoci7C+bDaaKWUbkLxtBAk=;
	b=8YY5IMff6SLmm3kfasTEqJJ8qyubozHgB5NaQtwoQfNHCuQh+WEaJnhQ17e/I1yIRYoBny
	xYoO/ALpp08LdSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C4953EA63;
	Wed,  4 Feb 2026 14:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IJU7GqpSg2mZZgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Feb 2026 14:07:38 +0000
Date: Wed, 4 Feb 2026 15:07:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] btrfs: do not ASSERT() when the fs flips RO inside
 btrfs_repair_io_failure()
Message-ID: <20260204140733.GR26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f21d342502c5ab027f38945fe06cda99af759784.1769491014.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f21d342502c5ab027f38945fe06cda99af759784.1769491014.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21360-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,twin.jikos.cz:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 40549E6DD0
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:46:55PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report that when btrfs hits ENOSPC error in a critical
> path, btrfs flips RO (this part is expected, although the ENOSPC bug
> still needs to be addressed).
> 
> The problem is after the RO flip, if we trigger a read repair, we can
> hit the ASSERT() inside btrfs_repair_io_failure() like the following:
> 
>  BTRFS info (device vdc): relocating block group 30408704 flags metadata|raid1
>  ------------[ cut here ]------------
>  BTRFS: Transaction aborted (error -28)
>  WARNING: fs/btrfs/extent-tree.c:3235 at __btrfs_free_extent.isra.0+0x453/0xfd0, CPU#1: btrfs/383844
>  Modules linked in: kvm_intel kvm irqbypass
>  [...]
>  ---[ end trace 0000000000000000 ]---
>  BTRFS info (device vdc state EA): 2 enospc errors during balance
>  BTRFS info (device vdc state EA): balance: ended with status: -30
>  BTRFS error (device vdc state EA): parent transid verify failed on logical 30556160 mirror 2 wanted 8 found 6
>  BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
>  [...]
>  assertion failed: !(fs_info->sb->s_flags & SB_RDONLY) :: 0, in fs/btrfs/bio.c:938
>  ------------[ cut here ]------------
>  assertion failed: !(fs_info->sb->s_flags & SB_RDONLY) :: 0, in fs/btrfs/bio.c:938
>  kernel BUG at fs/btrfs/bio.c:938!
>  Oops: invalid opcode: 0000 [#1] SMP NOPTI
>  CPU: 0 UID: 0 PID: 868 Comm: kworker/u8:13 Tainted: G        W        N  6.19.0-rc6+ #4788 PREEMPT(full)
>  Tainted: [W]=WARN, [N]=TEST
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>  Workqueue: btrfs-endio simple_end_io_work
>  RIP: 0010:btrfs_repair_io_failure.cold+0xb2/0x120
>  Code: 82 e8 18 52 fc ff 0f 0b 41 b8 aa 03 00 00 48 c7 c1 f7 2b 07 83 31 d2 48 c7 c6 88 68 fb 82 48 c7 c7 f0 54 fa 82 e8 f4 51 fc ff <0f> 0b 41 b8 b4 03 00 00 48 c7 c1 f7 2b 07 83 31 d2 48 c7 c6 3d 2c

Please delete the Code: line from changelogs.

>  RSP: 0000:ffffc90001d2bcf0 EFLAGS: 00010246
>  RAX: 0000000000000051 RBX: 0000000000001000 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffffffff8305cf42 RDI: 00000000ffffffff
>  RBP: 0000000000000002 R08: 00000000fffeffff R09: ffffffff837fa988
>  R10: ffffffff8327a9e0 R11: 6f69747265737361 R12: ffff88813018d310
>  R13: ffff888168b8a000 R14: ffffc90001d2bd90 R15: ffff88810a169000
>  FS:  0000000000000000(0000) GS:ffff8885e752c000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  ------------[ cut here ]------------
> 
> [CAUSE]
> The cause of -ENOSPC error during the test case btrfs/124 is still
> unknown, although it's known that we still have cases where metadata can
> be over-committed but can not be fulfilled correctly, thus if we hit
> such ENOSPC error inside a critical path, we have no choice but abort
> the current transaction.
> 
> This will mark the fs read-only.
> 
> The problem is inside the btrfs_repair_io_failure() path that we require
> the fs not to be mount read-only. This is normally fine, but if we are
> doing a read-repair meanwhile the fs flips RO due to a critical error,
> we can enter btrfs_repair_io_failure() with super block set to
> read-only, thus triggering the above crash.
> 
> [FIX]
> Just replace the ASSERT() with a proper return if the fs is already
> read-only.
> 
> Reported-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/linux-btrfs/20260126045555.GB31641@lst.de/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

