Return-Path: <linux-btrfs+bounces-12104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A9A573A6
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 22:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFECF7A6F79
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EA41B4132;
	Fri,  7 Mar 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="b3q3nCnA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yb6Nx36B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07AD52F88
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383073; cv=none; b=CSVgxUN7s6skch1SMw1hsD2qRdcuNhEoqnPzlcFlMJfdQW1GSUXK3FN7nW9luyYmFKEJwLph0fQ//RfwSs1UTDtJRBNtvmw/hy4KIPhNe6xpuRUVCWW06kPm8/38Kz4FrPf2imGQReU/teDP7LFabP8hppVHrxyDa56/nGzFmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383073; c=relaxed/simple;
	bh=iF9t9aoCoRgBDBc17elYLnz8NBdEMnu30bL+xW0L27s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvBCMNAAsqFXu5hzcuvjJPLu2WxfgDIEdFrC9XT4k6bEOcAr90OhEPKle9iumYxOwOb8aVeVCGpVZZREZ/ZsyC5eNuQtdUlggvUw5gHMBCk9qbn1Q28Q3X1wlv7kwA0XUJ/its1bv1m0pOxlmRk7T7qFDhxeicv4LjcKE0syMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=b3q3nCnA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yb6Nx36B; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id BFC71114009E;
	Fri,  7 Mar 2025 16:31:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 07 Mar 2025 16:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1741383069;
	 x=1741469469; bh=7BwQL+vxsXpuHz4sSVxyeHed1e3w6dLVcjlqXRE64n0=; b=
	b3q3nCnAhSJWjiu90yBfevZM89W+IxOVyLpAn/8p3gmtBcGNeZlBySm2v4lBh5rl
	euBwp5SA3WpOHE2uU2YZD3HKby/923le52NyjmQocN1gQHl7WDzGoFO8XaKl4LZW
	rQUrocW0Q2g67MPzZrEcFFJI0x80zGPwQAiQwQun3XoPu3BdlnHFx0cwkCtRQ4IF
	UzRAQE64TI0n1bbOpK+aelwhnyv+FdI7ZwP60hsB8+7ggC7zmPZik8WqT5WUUJXd
	z9A1u6zgcNzNmZB4Y35wx0xjUCmVC6RLpV5WkiCYuq5JgY5yHa5ZnAsYkRFErxDh
	R/L18MXdGjzdGGTPZ3tgCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741383069; x=
	1741469469; bh=7BwQL+vxsXpuHz4sSVxyeHed1e3w6dLVcjlqXRE64n0=; b=Y
	b6Nx36BWRFGakvMiCvdW/bP4M/31ADxHo+tJlxoQ5YVP5jbRDc+NUaG/kJ7QzYlY
	6BKQTt9c2YaiMd3B4ojaX9rS5RaJp+LgbC6ajaiTfjIgz90Zee3l9u+G4nDgtkWS
	0zXXhrkswbZjnQ5yizhgEDRU/4W7qM9sfoLTx/+QGHoDGXglCZE69YxJ9a442v1L
	7QUH9iNKAgtTKoez9bq8TKRfgHfmN9X3iwI1lbuHooQNGbj/WAbHKknnrOCSAt11
	lrS1N4F0slhM4LHWd83qa+xPlnNf3daUHBdArRS3sUfJpENaNXITHFwPNPzAkBo1
	TGNd3Hd55hLbSDbQrpLKg==
X-ME-Sender: <xms:nWXLZ4gp5SQrYD2CDt27mznMJ4-G3oJppN1aTp4TBhLx0K9Sx7y9Kg>
    <xme:nWXLZxD7OBrRnq-YBVFyx1Ffa1XA_9p37OnY9qhNgc3ZxWxf0DcSt4EvbL54iV8Fy
    9uVQjoYvZyTp1zgUyU>
X-ME-Received: <xmr:nWXLZwGe86WBGP33ocuqyyk9Sc93RfxRStJGsJMYs47Mxj_odqNjoxx8-OlrsomZkUw6Goi1a0TWgdkWEynSDQOejKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddujeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledt
    vdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:nWXLZ5SYflSJ5VAVE8oJYjZN-VGG7vCmCVRTN3uDSgZ856P78kcllA>
    <xmx:nWXLZ1yzr_MSjRkrOKQzcNPEclXS3q8niKQW7QFi0JyLn83QKDe04g>
    <xmx:nWXLZ36iqj7GMNdRjbxEN4Rg9xu1l3Dj1GgTv6b2Dw7sIXzYQWjCtA>
    <xmx:nWXLZyz1aX-QUov3A5jABIlguyxOlE7dOTZwBUGnwB13ok0CFW00gQ>
    <xmx:nWXLZ9-ZybIvdq4FUtI7gNRu5sKXwIljgKN99Gl0Ls5pOfOsK01n91S5>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 16:31:08 -0500 (EST)
Date: Fri, 7 Mar 2025 13:32:02 -0800
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/5] btrfs: fix bg refcount race in
 btrfs_create_pending_block_groups
Message-ID: <20250307213202.GA3554015@zen.localdomain>
References: <cover.1741306938.git.boris@bur.io>
 <f66e903dd583274967fcd45844e6444c4a49d98b.1741306938.git.boris@bur.io>
 <CAL3q7H4ErZWCa2qC1UgXVCfahA1Qx=WdeEGJ8E3COCLuH-n=5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4ErZWCa2qC1UgXVCfahA1Qx=WdeEGJ8E3COCLuH-n=5A@mail.gmail.com>

On Fri, Mar 07, 2025 at 02:13:15PM +0000, Filipe Manana wrote:
> On Fri, Mar 7, 2025 at 12:31 AM Boris Burkov <boris@bur.io> wrote:
> >
> > To avoid a race where mark_bg_unused spuriously "moved" the block_group
> > from one bg_list attachment to another without taking a ref, we mark a
> > new block group with the bit BLOCK_GROUP_FLAG_NEW.
> >
> > However, this fix is not quite complete. Since it does not use the
> > unused_bg_lock, it is possible for the following race to occur:
> >
> > create_pending_block_groups                     mark_bg_unused
> 
> mark_bg_unused -> btrfs_mark_bg_unused
> 
> >                                            if list_empty // false
> >         list_del_init
> >         clear_bit
> >                                            else if (test_bit) // true
> >                                                 list_move_tail
> 
> This should mention how that sequence is possible, i.e. on a higher level.
> 
> For example the task that created the block group ended up not
> allocating extents from it,
> and other tasks allocated extents from it and deallocated so that the
> block group became empty
> and was added to the unused list before the task that created it
> finished btrfs_create_pending_block_groups().
> 
> Or was it some other scenario?

To be honest, since the detection of the error is so non-local to the
time of the error with these refcounting issues, I don't have any
proof that exactly this is happening. I just have a bunch of hosts with
wrong refcounts detected after a relocation and started squinting at
places it could have gone wrong.

Your original patch and the very existence of the BLOCK_GROUP_FLAG_NEW
flag suggest to me that the two running concurrently is expected.

Would you like me to attempt to produce this condition on the current
kernel? Or I can duplicate/link to some of the reasoning from your first
fix here so that this commit message tells a better self-contained story?

Thanks,
Boris

> 
> Thanks.
> 
> >
> > And we get into the exact same broken ref count situation.
> > Those look something like:
> > [ 1272.943113] ------------[ cut here ]------------
> > [ 1272.943527] refcount_t: underflow; use-after-free.
> > [ 1272.943967] WARNING: CPU: 1 PID: 61 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
> > [ 1272.944731] Modules linked in: btrfs virtio_net xor zstd_compress raid6_pq null_blk [last unloaded: btrfs]
> > [ 1272.945550] CPU: 1 UID: 0 PID: 61 Comm: kworker/u32:1 Kdump: loaded Tainted: G        W          6.14.0-rc5+ #108
> > [ 1272.946368] Tainted: [W]=WARN
> > [ 1272.946585] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> > [ 1272.947273] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
> > [ 1272.947788] RIP: 0010:refcount_warn_saturate+0xba/0x110
> > [ 1272.948180] Code: 01 01 e8 e9 c7 a9 ff 0f 0b c3 cc cc cc cc 80 3d 3f 4a de 01 00 75 85 48 c7 c7 00 9b 9f 8f c6 05 2f 4a de 01 01 e8 c6 c7 a9 ff <0f> 0b c3 cc cc cc cc 80 3d 1d 4a de 01 00 0f 85 5e ff ff ff 48 c7
> > [ 1272.949532] RSP: 0018:ffffbf1200247df0 EFLAGS: 00010282
> > [ 1272.949901] RAX: 0000000000000000 RBX: ffffa14b00e3f800 RCX: 0000000000000000
> > [ 1272.950437] RDX: 0000000000000000 RSI: ffffbf1200247c78 RDI: 00000000ffffdfff
> > [ 1272.950986] RBP: ffffa14b00dc2860 R08: 00000000ffffdfff R09: ffffffff90526268
> > [ 1272.951512] R10: ffffffff904762c0 R11: 0000000063666572 R12: ffffa14b00dc28c0
> > [ 1272.952024] R13: 0000000000000000 R14: ffffa14b00dc2868 R15: 000001285dcd12c0
> > [ 1272.952850] FS:  0000000000000000(0000) GS:ffffa14d33c40000(0000) knlGS:0000000000000000
> > [ 1272.953458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1272.953931] CR2: 00007f838cbda000 CR3: 000000010104e000 CR4: 00000000000006f0
> > [ 1272.954474] Call Trace:
> > [ 1272.954655]  <TASK>
> > [ 1272.954812]  ? refcount_warn_saturate+0xba/0x110
> > [ 1272.955173]  ? __warn.cold+0x93/0xd7
> > [ 1272.955487]  ? refcount_warn_saturate+0xba/0x110
> > [ 1272.955816]  ? report_bug+0xe7/0x120
> > [ 1272.956103]  ? handle_bug+0x53/0x90
> > [ 1272.956424]  ? exc_invalid_op+0x13/0x60
> > [ 1272.956700]  ? asm_exc_invalid_op+0x16/0x20
> > [ 1272.957011]  ? refcount_warn_saturate+0xba/0x110
> > [ 1272.957399]  btrfs_discard_cancel_work.cold+0x26/0x2b [btrfs]
> > [ 1272.957853]  btrfs_put_block_group.cold+0x5d/0x8e [btrfs]
> > [ 1272.958289]  btrfs_discard_workfn+0x194/0x380 [btrfs]
> > [ 1272.958729]  process_one_work+0x130/0x290
> > [ 1272.959026]  worker_thread+0x2ea/0x420
> > [ 1272.959335]  ? __pfx_worker_thread+0x10/0x10
> > [ 1272.959644]  kthread+0xd7/0x1c0
> > [ 1272.959872]  ? __pfx_kthread+0x10/0x10
> > [ 1272.960172]  ret_from_fork+0x30/0x50
> > [ 1272.960474]  ? __pfx_kthread+0x10/0x10
> > [ 1272.960745]  ret_from_fork_asm+0x1a/0x30
> > [ 1272.961035]  </TASK>
> > [ 1272.961238] ---[ end trace 0000000000000000 ]---
> >
> > Though we have seen them in the async discard workfn as well. It is
> > most likely to happen after a relocation finishes which cancels discard,
> > tears down the block group, etc.
> >
> > Fix this fully by taking the lock around the list_del_init + clear_bit
> > so that the two are done atomically.
> >
> > Fixes: 0657b20c5a76 ("btrfs: fix use-after-free of new block group that became unused")
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/block-group.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 64f0268dcf02..2db1497b58d9 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -2797,8 +2797,11 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
> >                 /* Already aborted the transaction if it failed. */
> >  next:
> >                 btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
> > +
> > +               spin_lock(&fs_info->unused_bgs_lock);
> >                 list_del_init(&block_group->bg_list);
> >                 clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
> > +               spin_unlock(&fs_info->unused_bgs_lock);
> >
> >                 /*
> >                  * If the block group is still unused, add it to the list of
> > --
> > 2.48.1
> >
> >

