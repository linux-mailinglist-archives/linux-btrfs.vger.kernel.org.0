Return-Path: <linux-btrfs+bounces-8741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BE999727D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 19:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33D5B2149E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C41A0B12;
	Wed,  9 Oct 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TNFSPIoW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MGzYiI6H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TNFSPIoW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MGzYiI6H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D601126C17
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493201; cv=none; b=IA/FKGiNmDgWXkRM1MoIbDST177zrG2BK2VUDfqw8RSwyaXzKYHR37qfRhTtLrVK6FCWLWn+pnJ74d3bRMUbX5oZ6/SG8rnhxHQn07LS0phWa6Jxk/qy46OGzJcBr5ouuvQUKGm6jkUHV4t9uaYKeDnzKeQ8a1lNekWbX3kMieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493201; c=relaxed/simple;
	bh=TLGzFezhJHMmp67V7c6N3iRVub0Kk2WAKTNubKxE5tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZDTqma7PAzEoZ+C+QcGC8bdlseJktnb4wupTCHDi6Foc6RDEN3jg61hUIeXwdLhWjA1Lit3wnPzo+jqBgGWm8yAXTplr/TVP0+jqyQ09ZkKwyd2YnIt1A0xU2vDtoia1Tsq05kEIeBFvapBHq0bu0hrlIjTv5322FSmo8nrje4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TNFSPIoW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MGzYiI6H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TNFSPIoW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MGzYiI6H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 56FB11FD5E;
	Wed,  9 Oct 2024 16:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728493197;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UayxpgUsT3+wa54mi3WRBfIKpNjbmw6nXzmvCfKdbl8=;
	b=TNFSPIoWivTkDZx8wizSV6RAZwVC1X6cSKyXqf3NewW/hagHEgmoR0X8GQ1kgOi7JNe0fo
	oWRxR6x/5GUL/kGRH/UDjkipGq3x1WoxHeLfPqHUDUAuIcnzlDfbYfqKs8eD6N8EeFbwSv
	GlF5FuWizGsPq1G9xx9FAf156fV9+jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728493197;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UayxpgUsT3+wa54mi3WRBfIKpNjbmw6nXzmvCfKdbl8=;
	b=MGzYiI6H4u7tuZ0XgBhgYT7E3yywlKvIZCrqs1Daz7bPFgBLD7ON8U29K8faOgCcQF3L8u
	p3BhnW37bwbOLgDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728493197;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UayxpgUsT3+wa54mi3WRBfIKpNjbmw6nXzmvCfKdbl8=;
	b=TNFSPIoWivTkDZx8wizSV6RAZwVC1X6cSKyXqf3NewW/hagHEgmoR0X8GQ1kgOi7JNe0fo
	oWRxR6x/5GUL/kGRH/UDjkipGq3x1WoxHeLfPqHUDUAuIcnzlDfbYfqKs8eD6N8EeFbwSv
	GlF5FuWizGsPq1G9xx9FAf156fV9+jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728493197;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UayxpgUsT3+wa54mi3WRBfIKpNjbmw6nXzmvCfKdbl8=;
	b=MGzYiI6H4u7tuZ0XgBhgYT7E3yywlKvIZCrqs1Daz7bPFgBLD7ON8U29K8faOgCcQF3L8u
	p3BhnW37bwbOLgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F3F2136BA;
	Wed,  9 Oct 2024 16:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tNsuAo22BmeXcwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 09 Oct 2024 16:59:57 +0000
Date: Wed, 9 Oct 2024 18:59:55 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com, hch@lst.de
Subject: Re: [PATCH] btrfs: fix error propagation of split bios
Message-ID: <20241009165955.GM1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Oct 10, 2024 at 12:57:50AM +0900, Naohiro Aota wrote:
> The purpose of btrfs_bbio_propagate_error() shall be propagating an error
> of split bio to its original btrfs_bio, and tell the error to the upper
> layer. However, it's not working well on some cases.
> 
> * Case 1. Immediate (or quick) end_bio with an error
> 
> When btrfs sends btrfs_bio to mirrored devices, btrfs calls
> btrfs_bio_end_io() when all the mirroring bios are completed. If that
> btrfs_bio was split, it is from btrfs_clone_bioset and its end_io function
> is btrfs_orig_write_end_io. For this case, btrfs_bbio_propagate_error()
> accesses the orig_bbio's bio context to increase the error count.
> 
> That works well in most cases. However, if the end_io is called enough
> fast, orig_bbio's bio context may not be properly set at that time. Since
> the bio context is set when the orig_bbio (the last btrfs_bio) is sent to
> devices, that might be too late for earlier split btrfs_bio's completion.
> That will result in NULL pointer dereference.
> 
> That bug is easily reproducible by running btrfs/146 on zoned devices and
> it shows the following trace.
> 
>     [   20.923980][   T13] BUG: kernel NULL pointer dereference, address: 0000000000000020
>     [   20.925234][   T13] #PF: supervisor read access in kernel mode
>     [   20.926122][   T13] #PF: error_code(0x0000) - not-present page
>     [   20.927118][   T13] PGD 0 P4D 0
>     [   20.927607][   T13] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>     [   20.928424][   T13] CPU: 1 UID: 0 PID: 13 Comm: kworker/u32:1 Not tainted 6.11.0-rc7-BTRFS-ZNS+ #474
>     [   20.929740][   T13] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>     [   20.930697][   T13] Workqueue: writeback wb_workfn (flush-btrfs-5)
>     [   20.931643][   T13] RIP: 0010:btrfs_bio_end_io+0xae/0xc0 [btrfs]
>     [   20.932573][ T1415] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
>     [   20.932871][   T13] Code: ba e1 48 8b 7b 10 e8 f1 f5 f6 ff eb da 48 81 bf 10 01 00 00 40 0c 33 a0 74 09 40 88 b5 f1 00 00 00 eb b8 48 8b 85 18 01 00 00 <48> 8b 40 20 0f b7 50 24 f0 01 50 20 eb a3 0f 1f 40 00 90 90 90 90
>     [   20.936623][   T13] RSP: 0018:ffffc9000006f248 EFLAGS: 00010246
>     [   20.937543][   T13] RAX: 0000000000000000 RBX: ffff888005a7f080 RCX: ffffc9000006f1dc
>     [   20.938788][   T13] RDX: 0000000000000000 RSI: 000000000000000a RDI: ffff888005a7f080
>     [   20.940016][   T13] RBP: ffff888011dfc540 R08: 0000000000000000 R09: 0000000000000001
>     [   20.941227][   T13] R10: ffffffff82e508e0 R11: 0000000000000005 R12: ffff88800ddfbe58
>     [   20.942375][   T13] R13: ffff888005a7f080 R14: ffff888005a7f158 R15: ffff888005a7f158
>     [   20.943531][   T13] FS:  0000000000000000(0000) GS:ffff88803ea80000(0000) knlGS:0000000000000000
>     [   20.944838][   T13] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [   20.945811][   T13] CR2: 0000000000000020 CR3: 0000000002e22006 CR4: 0000000000370ef0
>     [   20.946984][   T13] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     [   20.948150][   T13] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     [   20.949327][   T13] Call Trace:
>     [   20.949949][   T13]  <TASK>
>     [   20.950374][   T13]  ? __die_body.cold+0x19/0x26
>     [   20.951066][   T13]  ? page_fault_oops+0x13e/0x2b0
>     [   20.951766][   T13]  ? _printk+0x58/0x73
>     [   20.952358][   T13]  ? do_user_addr_fault+0x5f/0x750
>     [   20.953120][   T13]  ? exc_page_fault+0x76/0x240
>     [   20.953827][   T13]  ? asm_exc_page_fault+0x22/0x30
>     [   20.954606][   T13]  ? btrfs_bio_end_io+0xae/0xc0 [btrfs]
>     [   20.955616][   T13]  ? btrfs_log_dev_io_error+0x7f/0x90 [btrfs]
>     [   20.956682][   T13]  btrfs_orig_write_end_io+0x51/0x90 [btrfs]
>     [   20.957769][   T13]  dm_submit_bio+0x5c2/0xa50 [dm_mod]
>     [   20.958623][   T13]  ? find_held_lock+0x2b/0x80
>     [   20.959339][   T13]  ? blk_try_enter_queue+0x90/0x1e0
>     [   20.960228][   T13]  __submit_bio+0xe0/0x130
>     [   20.960879][   T13]  ? ktime_get+0x10a/0x160
>     [   20.961546][   T13]  ? lockdep_hardirqs_on+0x74/0x100
>     [   20.962310][   T13]  submit_bio_noacct_nocheck+0x199/0x410
>     [   20.963140][   T13]  btrfs_submit_bio+0x7d/0x150 [btrfs]
>     [   20.964089][   T13]  btrfs_submit_chunk+0x1a1/0x6d0 [btrfs]
>     [   20.965066][   T13]  ? lockdep_hardirqs_on+0x74/0x100
>     [   20.965824][   T13]  ? __folio_start_writeback+0x10/0x2c0
>     [   20.966659][   T13]  btrfs_submit_bbio+0x1c/0x40 [btrfs]
>     [   20.967617][   T13]  submit_one_bio+0x44/0x60 [btrfs]
>     [   20.968536][   T13]  submit_extent_folio+0x13f/0x330 [btrfs]
>     [   20.969552][   T13]  ? btrfs_set_range_writeback+0xa3/0xd0 [btrfs]
>     [   20.970625][   T13]  extent_writepage_io+0x18b/0x360 [btrfs]
>     [   20.971632][   T13]  extent_write_locked_range+0x17c/0x340 [btrfs]
>     [   20.972702][   T13]  ? __pfx_end_bbio_data_write+0x10/0x10 [btrfs]
>     [   20.973857][   T13]  run_delalloc_cow+0x71/0xd0 [btrfs]
>     [   20.974841][   T13]  btrfs_run_delalloc_range+0x176/0x500 [btrfs]
>     [   20.975870][   T13]  ? find_lock_delalloc_range+0x119/0x260 [btrfs]
>     [   20.976911][   T13]  writepage_delalloc+0x2ab/0x480 [btrfs]
>     [   20.977792][   T13]  extent_write_cache_pages+0x236/0x7d0 [btrfs]
>     [   20.978728][   T13]  btrfs_writepages+0x72/0x130 [btrfs]
>     [   20.979531][   T13]  do_writepages+0xd4/0x240
>     [   20.980111][   T13]  ? find_held_lock+0x2b/0x80
>     [   20.980695][   T13]  ? wbc_attach_and_unlock_inode+0x12c/0x290
>     [   20.981461][   T13]  ? wbc_attach_and_unlock_inode+0x12c/0x290
>     [   20.982213][   T13]  __writeback_single_inode+0x5c/0x4c0
>     [   20.982859][   T13]  ? do_raw_spin_unlock+0x49/0xb0
>     [   20.983439][   T13]  writeback_sb_inodes+0x22c/0x560
>     [   20.984079][   T13]  __writeback_inodes_wb+0x4c/0xe0
>     [   20.984886][   T13]  wb_writeback+0x1d6/0x3f0
>     [   20.985536][   T13]  wb_workfn+0x334/0x520
>     [   20.986044][   T13]  process_one_work+0x1ee/0x570
>     [   20.986580][   T13]  ? lock_is_held_type+0xc6/0x130
>     [   20.987142][   T13]  worker_thread+0x1d1/0x3b0
>     [   20.987918][   T13]  ? __pfx_worker_thread+0x10/0x10
>     [   20.988690][   T13]  kthread+0xee/0x120
>     [   20.989180][   T13]  ? __pfx_kthread+0x10/0x10
>     [   20.989915][   T13]  ret_from_fork+0x30/0x50
>     [   20.990615][   T13]  ? __pfx_kthread+0x10/0x10
>     [   20.991336][   T13]  ret_from_fork_asm+0x1a/0x30
>     [   20.992106][   T13]  </TASK>
>     [   20.992482][   T13] Modules linked in: dm_mod btrfs blake2b_generic xor raid6_pq rapl
>     [   20.993406][   T13] CR2: 0000000000000020
>     [   20.993884][   T13] ---[ end trace 0000000000000000 ]---
>     [   20.993954][ T1415] BUG: kernel NULL pointer dereference, address: 0000000000000020
> 
> * Case 2. Earlier completion of orig_bbio for mirrored btrfs_bios
> 
> btrfs_bbio_propagate_error() assumes the end_io function for orig_bbio is
> called last among split bios. In that case, btrfs_orig_write_end_io() sets
> the bio->bi_status to BLK_STS_IOERR by seeing the bioc->error [1].
> Otherwise, the increased orig_bio's bioc->error is not checked by anyone
> and return BLK_STS_OK to the upper layer.
> 
> [1] Actually, this is not true. Because we only increases orig_bioc->errors
> by max_errors, the condition "atomic_read(&bioc->error) > bioc->max_errors"
> is still not met if only one split btrfs_bio fails.
> 
> * Case 3. Later completion of orig_bbio for un-mirrored btrfs_bios
> 
> In contrast to the above case, btrfs_bbio_propagate_error() is not working
> well if un-mirrored orig_bbio is completed last. It sets
> orig_bbio->bio.bi_status to the btrfs_bio's error. But, that is easily
> over-written by orig_bbio's completion status. If the status is BLK_STS_OK,
> the upper layer would not know the failure.
> 
> * Solution
> 
> Considering the above cases, we can only save the error status in the
> orig_bbio itself as it is always available. Also, the saved error status
> should be propagated when all the split btrfs_bios are finished (i.e,
> bbio->pending_ios == 0).
> 
> This commit introduces "status" to btrfs_bbio and uses the last saved error
> status for bbio->bio.bi_status.
> 
> With this commit, btrfs/146 on zoned devices does not hit the NULL pointer
> dereference.
> 
> Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
> CC: stable@vger.kernel.org # 6.6+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/bio.c | 33 +++++++++------------------------
>  fs/btrfs/bio.h |  3 +++
>  2 files changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 056f8a171bba..a43d88bdcae7 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -49,6 +49,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
>  	bbio->end_io = end_io;
>  	bbio->private = private;
>  	atomic_set(&bbio->pending_ios, 1);
> +	atomic_set(&bbio->status, BLK_STS_OK);
>  }
>  
>  /*
> @@ -120,41 +121,25 @@ static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
>  	}
>  }
>  
> -static void btrfs_orig_write_end_io(struct bio *bio);
> -
> -static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
> -				       struct btrfs_bio *orig_bbio)
> -{
> -	/*
> -	 * For writes we tolerate nr_mirrors - 1 write failures, so we can't
> -	 * just blindly propagate a write failure here.  Instead increment the
> -	 * error count in the original I/O context so that it is guaranteed to
> -	 * be larger than the error tolerance.
> -	 */
> -	if (bbio->bio.bi_end_io == &btrfs_orig_write_end_io) {
> -		struct btrfs_io_stripe *orig_stripe = orig_bbio->bio.bi_private;
> -		struct btrfs_io_context *orig_bioc = orig_stripe->bioc;
> -
> -		atomic_add(orig_bioc->max_errors, &orig_bioc->error);
> -	} else {
> -		orig_bbio->bio.bi_status = bbio->bio.bi_status;
> -	}
> -}
> -
>  void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>  {
>  	bbio->bio.bi_status = status;
>  	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
>  		struct btrfs_bio *orig_bbio = bbio->private;
>  
> -		if (bbio->bio.bi_status)
> -			btrfs_bbio_propagate_error(bbio, orig_bbio);
> +		/* Save the last error. */
> +		if (bbio->bio.bi_status != BLK_STS_OK)
> +			atomic_set(&orig_bbio->status, bbio->bio.bi_status);
>  		btrfs_cleanup_bio(bbio);
>  		bbio = orig_bbio;
>  	}
>  
> -	if (atomic_dec_and_test(&bbio->pending_ios))
> +	if (atomic_dec_and_test(&bbio->pending_ios)) {
> +		/* Load split bio's error which might be set above. */
> +		if (status == BLK_STS_OK)
> +			bbio->bio.bi_status = atomic_read(&bbio->status);
>  		__btrfs_bio_end_io(bbio);
> +	}
>  }
>  
>  static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index e48612340745..b8f7f6071bc2 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -79,6 +79,9 @@ struct btrfs_bio {
>  	/* File system that this I/O operates on. */
>  	struct btrfs_fs_info *fs_info;
>  
> +	/* Set the error status of split bio. */
> +	atomic_t status;

To repeat my comments from slack here. This should not be atomic when
it's using only set and read, a plain int or blk_sts_t.

The logic of storing the last error in btrfs_bio makes sense, I don't
see other ways to do it. If there are multiple errors we can store the
first one or the last one, we'd always lose some information. When it's
the first one it could be set by cmpxchg.

