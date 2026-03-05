Return-Path: <linux-btrfs+bounces-22240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OtjFeLzqGmfzgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22240-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 04:09:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8F20A6E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 04:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06513301DBBC
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 03:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDED274B2A;
	Thu,  5 Mar 2026 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y0Tsg5Xk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E8ab/EOp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y0Tsg5Xk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E8ab/EOp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF7273D8F
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680156; cv=none; b=PQGSY93beiECd0OPSzbO5y1Qac1FwJ39PqGxGDJ/0gZwyYrsN0kPq7i0qvALL1LL42X+evlE+eqPPgYjjrDGezu3EW9eSIdq0MRPf6abdy18sOTN6H6my1yQ0Bj/abA6FAWhtp7Ylcz5qc8lj7Sz+3PYmHhECZyQ5Pb5N4dIndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680156; c=relaxed/simple;
	bh=LNN/gW4EKvwQAuvwLnLh8SyA8R2zxcdw80wIrNrU4uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeUiL/U0TU/6vz19oJxI6kUFZWFdrEVQNQkx8iPxaI0Mju5kReVCLOoIf0PINzIrryv2FPK657U1aaPZs8F1W9oHIjXKs40yOdLVP18n+HNJ3DwmDNyyl492nurmcXa/Qt5d76DJn1nfnMSY067WSxsqvfUEHqsk9oMmx2A5hpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y0Tsg5Xk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E8ab/EOp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y0Tsg5Xk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E8ab/EOp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2ED673F279;
	Thu,  5 Mar 2026 03:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772680153;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J64YWwtaeH4gSwC3R/WuS/86p5y6F9uT7gdRPSwJCyg=;
	b=Y0Tsg5Xk5/4XunL8ASSOk7Z3OoNaeyj+hGDd1wqW+CWDkdfcU/xkKv1nG17BENJrIzvJXO
	3832jXHoV/tYo+spVCAm6opHFpcwaSrsSuYIzrQErvS2kray4BkoWtuM4x3S0RjVvLBnv2
	kLip6ik7GGlekUw5nLxVf+2G4if7vHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772680153;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J64YWwtaeH4gSwC3R/WuS/86p5y6F9uT7gdRPSwJCyg=;
	b=E8ab/EOpSlr5b4weBZtx3qGdm535ekuq/DkarmSQtu5oNM6Xzv1bIL2h3Ui+T8Ai3OWrtm
	CxBYY3qzoV8y/5Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772680153;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J64YWwtaeH4gSwC3R/WuS/86p5y6F9uT7gdRPSwJCyg=;
	b=Y0Tsg5Xk5/4XunL8ASSOk7Z3OoNaeyj+hGDd1wqW+CWDkdfcU/xkKv1nG17BENJrIzvJXO
	3832jXHoV/tYo+spVCAm6opHFpcwaSrsSuYIzrQErvS2kray4BkoWtuM4x3S0RjVvLBnv2
	kLip6ik7GGlekUw5nLxVf+2G4if7vHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772680153;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J64YWwtaeH4gSwC3R/WuS/86p5y6F9uT7gdRPSwJCyg=;
	b=E8ab/EOpSlr5b4weBZtx3qGdm535ekuq/DkarmSQtu5oNM6Xzv1bIL2h3Ui+T8Ai3OWrtm
	CxBYY3qzoV8y/5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07B0E3EA68;
	Thu,  5 Mar 2026 03:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +eazAdnzqGkFJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 05 Mar 2026 03:09:13 +0000
Date: Thu, 5 Mar 2026 04:09:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: get rid of btrfs_(alloc|free)_compr_folio()
Message-ID: <20260305030911.GD5735@suse.cz>
Reply-To: dsterba@suse.cz
References: <ddcbb67a60d1bc87bc2f45cbd6f830880a5076ae.1772438228.git.wqu@suse.com>
 <20260305025611.GC5735@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305025611.GC5735@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: E8B8F20A6E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-22240-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:replyto]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 03:56:11AM +0100, David Sterba wrote:
> On Mon, Mar 02, 2026 at 06:30:30PM +1030, Qu Wenruo wrote:
> > And hopefully this will address David's recent crash (as usual I'm not
> > able to reproduce locally).
> 
> I'll run the test with this patch.

Still crashes so the lru is a false hunch.

[  110.693070] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888100000000 pfn:0x111262
[  110.694052] flags: 0x4000000000000000(node=0|zone=2)
[  110.694596] raw: 4000000000000000 ffffea00040f2008 ffffea00042088c8 0000000000000000
[  110.695383] raw: ffff888100000000 0000000000000000 00000000ffffffff 0000000000000000
[  110.696164] page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
[  110.696925] ------------[ cut here ]------------
[  110.697414] kernel BUG at ./include/linux/mm.h:1493!
[  110.697955] Oops: invalid opcode: 0000 [#1] SMP KASAN
[  110.698482] CPU: 8 UID: 0 PID: 12 Comm: kworker/u64:0 Not tainted 7.0.0-rc1-default+ #626 PREEMPT(full) 
[  110.699385] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
[  110.700464] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
[  110.701110] RIP: 0010:btrfs_compress_bio+0x5c2/0x6a0 [btrfs]
[  110.702716] RSP: 0018:ffff8881003b79a0 EFLAGS: 00010286
[  110.703082] RAX: 000000000000003e RBX: ffff88810a83d5f8 RCX: 0000000000000000
[  110.703550] RDX: 000000000000003e RSI: 0000000000000004 RDI: ffffed1020076f27
[  110.704019] RBP: 1ffff11020076f37 R08: ffffffff8a444651 R09: fffffbfff195c438
[  110.704484] R10: 0000000000000003 R11: 0000000000000001 R12: ffffea00044498c0
[  110.704956] R13: ffffea00044498b4 R14: 0000000000000000 R15: ffffea0004449880
[  110.705555] FS:  0000000000000000(0000) GS:ffff88818baa0000(0000) knlGS:0000000000000000
[  110.706197] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  110.706664] CR2: 00007f4aa3c715a0 CR3: 0000000097a59000 CR4: 00000000000006b0
[  110.707131] Call Trace:
[  110.707335]  <TASK>
[  110.707522]  ? btrfs_compress_filemap_get_folio+0x130/0x130 [btrfs]
[  110.707999]  ? _raw_spin_unlock+0x1a/0x30
[  110.708307]  ? btrfs_compress_heuristic+0x48c/0x700 [btrfs]
[  110.708766]  compress_file_range+0x7b7/0x1640 [btrfs]
[  110.709169]  ? cow_file_range_inline.constprop.0+0x1b0/0x1b0 [btrfs]
[  110.709629]  ? __lock_acquire+0x568/0xbd0
[  110.709934]  ? lock_acquire.part.0+0xad/0x230
[  110.710240]  ? process_one_work+0x7ec/0x1590
[  110.710550]  ? submit_one_async_extent+0xb00/0xb00 [btrfs]
[  110.710970]  btrfs_work_helper+0x1c1/0x760 [btrfs]
[  110.711354]  ? lock_acquire+0x128/0x150
[  110.711635]  process_one_work+0x86b/0x1590
[  110.711934]  ? pwq_dec_nr_in_flight+0x720/0x720
[  110.712255]  ? lock_is_held_type+0x83/0xe0
[  110.712584]  worker_thread+0x5e9/0xfc0
[  110.712869]  ? process_one_work+0x1590/0x1590
[  110.713179]  kthread+0x323/0x410
[  110.713430]  ? _raw_spin_unlock_irq+0x1f/0x40
[  110.713741]  ? kthread_affine_node+0x1c0/0x1c0
[  110.714058]  ret_from_fork+0x476/0x5f0
[  110.714339]  ? arch_exit_to_user_mode_prepare.isra.0+0x60/0x60
[  110.714730]  ? __switch_to+0x22/0xe00
[  110.715011]  ? kthread_affine_node+0x1c0/0x1c0
[  110.715327]  ret_from_fork_asm+0x11/0x20
[  110.715616]  </TASK>
[  110.715806] Modules linked in: btrfs xor raid6_pq loop
[  110.716186] ---[ end trace 0000000000000000 ]---
[  110.716538] RIP: 0010:btrfs_compress_bio+0x5c2/0x6a0 [btrfs]
[  110.718125] RSP: 0018:ffff8881003b79a0 EFLAGS: 00010286
[  110.718488] RAX: 000000000000003e RBX: ffff88810a83d5f8 RCX: 0000000000000000
[  110.718958] RDX: 000000000000003e RSI: 0000000000000004 RDI: ffffed1020076f27
[  110.719448] RBP: 1ffff11020076f37 R08: ffffffff8a444651 R09: fffffbfff195c438
[  110.719912] R10: 0000000000000003 R11: 0000000000000001 R12: ffffea00044498c0
[  110.720373] R13: ffffea00044498b4 R14: 0000000000000000 R15: ffffea0004449880
[  110.720871] FS:  0000000000000000(0000) GS:ffff88818baa0000(0000) knlGS:0000000000000000
[  110.721409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  110.721800] CR2: 00007f4aa3c715a0 CR3: 0000000097a59000 CR4: 00000000000006b0

Looks like folio references are wrong, the assert in zlib related to the page
pool was just a symptom and I think actually correct.

The line numbers do not tell anything interesting:

(gdb) l *(btrfs_compress_bio+0x5c2)
0x1f38e2 is in btrfs_compress_bio (./include/linux/mm.h:1493).
1488    /*
1489     * Drop a ref, return true if the refcount fell to zero (the page has no users)
1490     */
1491    static inline int put_page_testzero(struct page *page)
1492    {
1493            VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
1494            return page_ref_dec_and_test(page);
1495    }
1496
1497    static inline int folio_put_testzero(struct folio *folio)

(gdb) l *(compress_file_range+0x7b7)
0xde947 is in compress_file_range (fs/btrfs/inode.c:1014).
1009            } else if (inode->prop_compress) {
1010                    compress_type = inode->prop_compress;
1011            }
1012
1013            /* Compression level is applied here. */
1014            cb = btrfs_compress_bio(inode, start, cur_len, compress_type,
1015                                     compress_level, async_chunk->write_flags);
1016            if (IS_ERR(cb)) {
1017                    cb = NULL;
1018                    goto mark_incompressible;

(gdb) l *(btrfs_compress_filemap_get_folio+0x130)
0x1f3320 is in btrfs_compress_bio (fs/btrfs/compression.c:902).
897      * to do the round up before submission.
898      */
899     struct compressed_bio *btrfs_compress_bio(struct btrfs_inode *inode,
900                                               u64 start, u32 len, unsigned int type,
901                                               int level, blk_opf_t write_flags)
902     {
903             struct btrfs_fs_info *fs_info = inode->root->fs_info;
904             struct list_head *workspace;
905             struct compressed_bio *cb;
906             int ret;

