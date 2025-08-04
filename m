Return-Path: <linux-btrfs+bounces-15840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C34BB1A957
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 21:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BAB18A196A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6715244EA0;
	Mon,  4 Aug 2025 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcB2mFRq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A37D28B41A
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754334050; cv=none; b=stI1H7gPmImuRZ+NIfluBsqRFTatnYjqSeFily30lXMEIC9MBWJJNUrv8I507JSO1doHNh30HeNXIrNd+3Y6gw1b2yBsWFL9hM/cxZkR5OxTKqd49h5ItU5d9nB4KDtqX2Q+AZ1Kk7CeOFd1rDeR0s3JwAwAKBZ2HsnPw042cwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754334050; c=relaxed/simple;
	bh=FvJz1k43uBE9W+TRw7PypiG4Lb1wye55bKdV0NTtJuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtKBMiiSLpvW1jrnli6OVgmaTDIsfYUFY/Y0MSdXjnYtdzFIRNu4GveZA8/ltKpLWewwvwM1aQpGqIfu4Cb4PUrNPw/oUOmRSIFL7HC+kqND2dm8FrxmxRnU0giUIzVKq2kbq0yy4Bam0ibwPcPRZwrPG0e6LCRfdnhBtPJ9OS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcB2mFRq; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-71b73225060so35574897b3.3
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Aug 2025 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754334031; x=1754938831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymIGrOz+CxbRX94J4e5iRZiOij4TUd/2pUQF0JqT8k0=;
        b=fcB2mFRqg1mpDiD/cpjwTLHXdHu2cjVVY/geF99xHSaZygu8N399d6pLrDq2PYRjM3
         3PjCVlnikmRehgylTtxCOFSUlsSc2lMjQn5aJkMR4SCMRv7olErnuF+RCenXF5vvpQ8a
         tOaOGBTdeO9Qgh1d6aDgY3wLJoy/50bV2jRyjMj7Qk6vxTkW5CcAoRCXQxW3WGYgBZAD
         pHuf0Lh8bJ+3kQ35ZHap/xxBR4ZggB3l/8smhI/EZaAJ7Qbwmhv0DZoLWMgVHRl4CoiF
         1UHYsHPHLAkzhmQYnUFLvWPm+RZa3n0b9jPQlA6+SP/mCW8ug+Mfzk3/ML23l1lk3RyO
         iGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754334031; x=1754938831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymIGrOz+CxbRX94J4e5iRZiOij4TUd/2pUQF0JqT8k0=;
        b=V6HMKEVvwIdCxAOMUwep7B4fUMvSXXDRtAkCYl9n71NI7zY/biBR0+wnR42deORQrZ
         L1Z1GIuvWOn40WkGwxq/glrHB3XozO7epfATLpWuGwIer1uv/OgEgF3Qey5hjrcB6adK
         QlCwut95d+MnuZNU9E5UCPUfBWNffSnu8zsSKiAIdYQXG7Q709sD1vlMu9iUrTn00FoV
         fea+M5boEY2Q0nmbUi8w+qceRbvXpU8VxLGxcAgYB75d0L60sUlWrzUytfVG4EpGNN0Q
         PyxwzAzPMEqRT+0pT4hDcpdI7yAhrJu1RRxKqX57JdHcasJ6n1ycUckS029CNhH8iOTQ
         qavA==
X-Gm-Message-State: AOJu0Yy88njv4hZ5Tbngd97R/HQ13knnapW3jQJ83GteoVz9znI9KCNI
	LuVtv6JbSd8InInGMTm2Dy7LGN//q2XJ0w4GwDNIeGpu2Cf5ND8803VnaQwnFocR
X-Gm-Gg: ASbGnculT4h+ccb9A6OB4KDbJUu/nFeNR9fYe/+hLJlLmlqL/cBmUPLHcyRqjOTZ5Me
	Dt6ueLEApCxvzKKfqsSt6QBahOf01+ryNO5X5+huhi/HHUC7R+eEvX34DbqbXgAUdvHwUBGidlT
	mwJX3wV7X2JbHy9x0h14wK+V78aPm2CnWnlQlpVwce7oCOIDwjPtBDcAKcpNyNP++J2Mhl6LUi+
	be5le51JVVMiesrrj6MC7vDWABu4Vtgso6I94+5x/35yiW5/u9ZRN7sHrGo7VNiflywmd4xQTvS
	v6tYcgYQfqysWLk1fTnCLm8p4copj7Mv5kP7dFIoBr6zQT3txVZ+gglRUtaSgXt9pBbzNyJS+Zq
	5aD1PLjex2Cm8+HcJ
X-Google-Smtp-Source: AGHT+IH+b7mJhEfpKVZH0TqBUCfiOXO30JSPtk2VukPMHKOY2p5ZQ2ySmS46KvUKfUCjDnsgSuFUhg==
X-Received: by 2002:a05:690c:660c:b0:71a:22aa:c558 with SMTP id 00721157ae682-71b7f5e1366mr118372567b3.4.1754334030728;
        Mon, 04 Aug 2025 12:00:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5c62efsm27179537b3.63.2025.08.04.12.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 12:00:30 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: implement ref_tracker for delayed_nodes
Date: Mon,  4 Aug 2025 12:00:12 -0700
Message-ID: <20250804190026.484954-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250804135750.GL6704@twin.jikos.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 4 Aug 2025 15:57:50 +0200 David Sterba <dsterba@suse.cz> wrote:

> On Tue, Jul 29, 2025 at 12:08:04AM -0700, Leo Martins wrote:
> > This patch adds ref_tracker infrastructure for btrfs_delayed_node.
> > 
> > A ref_tracker object is allocated every time the reference count is
> > increased and freed when the reference count is decreased. The
> > ref_tracker object contains stack_trace information about where the
> > ref count is increased and decreased. The ref_tracker_dir embedded in
> > btrfs_delayed_node keeps track of all current references, and some
> > previous references. This information allows for detection of reference
> > leaks or double frees.
> > 
> > Here is a common example of taking a reference to a delayed_node and
> > freeing it with ref_tracker.
> > 
> > ```C
> > struct ref_tracker *tracker;
> > struct btrfs_delayed_node *node;
> > 
> > node = btrfs_get_delayed_node(inode, tracker);
> > // use delayed_node...
> > btrfs_release_delayed_node(node, tracker);
> > ```
> > 
> > There are two special cases where the delayed_node reference is long
> > term, meaning that the thread that takes the reference and the thread
> > that frees the reference are different. The inode_cache which is the
> > btrfs_delayed_node reference stored in the associated btrfs_inode, and
> > the node_list which is the btrfs_delayed_node reference stored in the
> > btrfs_delayed_root node_list/prepare_list. In these cases the
> > ref_tracker is stored in the delayed_node itself.
> > 
> > This patch introduces some new wrappers (btrfs_delayed_node_ref_tracker_*)
> > to ensure that when BTRFS_DEBUG is disabled everything gets compiled out.
> > 
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> 
> I'm still missing why we need to add this whole infrastructure, there
> weren't any recent bugs in delayed inode tracking. I understand what the
> ref tracker does but it's still increasing structure size and adds a
> perf hit that is acceptable for debugging kernels but still.

Our leading btrfs crash is a soft lockup related to delayed_nodes.

[21017.354271] [     C96] Call Trace:
[21017.354273] [     C96]  <IRQ>
[21017.354278] [     C96]  ? rcu_dump_cpu_stacks+0xa1/0xe0
[21017.354282] [     C96]  ? print_cpu_stall+0x113/0x200
[21017.354284] [     C96]  ? rcu_sched_clock_irq+0x633/0x730
[21017.354287] [     C96]  ? update_process_times+0x66/0xa0
[21017.354288] [     C96]  ? dma_map_page_attrs+0x250/0x250
[21017.354289] [     C96]  ? tick_nohz_handler+0x84/0x1d0
[21017.354291] [     C96]  ? hrtimer_interrupt+0x1a1/0x5b0
[21017.354293] [     C96]  ? __sysvec_apic_timer_interrupt+0x44/0xe0
[21017.354295] [     C96]  ? sysvec_apic_timer_interrupt+0x6b/0x80
[21017.354296] [     C96]  </IRQ>
[21017.354297] [     C96]  <TASK>
[21017.354297] [     C96]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[21017.354302] [     C96]  ? xa_find+0xa/0xb0
[21017.354305] [     C96]  btrfs_kill_all_delayed_nodes+0x6b/0x150
[21017.354307] [     C96]  ? __switch_to+0x133/0x530
[21017.354308] [     C96]  ? schedule+0xff4/0x1380
[21017.354310] [     C96]  btrfs_clean_one_deleted_snapshot+0x70/0xe0
[21017.354313] [     C96]  cleaner_kthread+0x83/0x120
[21017.354315] [     C96]  ? exportfs_encode_inode_fh+0x60/0x60
[21017.354317] [     C96]  kthread+0xae/0xe0
[21017.354319] [     C96]  ? __efi_queue_work+0x130/0x130
[21017.354320] [     C96]  ret_from_fork+0x2f/0x40
[21017.354322] [     C96]  ? __efi_queue_work+0x130/0x130
[21017.354323] [     C96]  ret_from_fork_asm+0x11/0x20
[21017.354326] [     C96]  </TASK>
[21042.628340] [     C96] watchdog: BUG: soft lockup - CPU#96 stuck for 45s! [btrfs-cleaner:1438]

btrfs_kill_all_delayed_nodes is getting stuck in an infinite loop because
the root->delayed_nodes xarray has a delayed_node that never gets erased.
Inspecting the crash dump reveals that the delayed_node has a reference count
of one, indicating there is a reference leak.

I believe this bug was introduced or at least magnified somewhere between
6.9 and 6.11.

Let me know if you want anymore details about the crash.

> 
> We have the ref-verify code and mount option, from what I've heard it
> was used sporadically when touching related code. We can let the ref
> tracking work like that too, not turned on by default ie. requiring a
> mount option.

The only issue with a mount option is that we would not be able to conditionally
compile ref_tracker_dir and ref_tracker pointers in struct btrfs_delayed_node,
permanently increasing the size of the struct from 304 bytes to 400 bytes.

Alternatively, there could be a delayed_node ref_tracker helper struct that we
could store a pointer to.

> 
> In case you'd want to enhance more structures with ref tracker the mount
> option can enable them selectively.
> 
> > @@ -106,6 +113,13 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
> >  		 */
> >  		if (refcount_inc_not_zero(&node->refs)) {
> >  			refcount_inc(&node->refs);
> > +#ifdef CONFIG_BTRFS_DEBUG
> > +			inode_cache_tracker = &node->inode_cache_tracker;
> > +#endif
> 
> We try to avoid #ifdefs if it's a repeating pattern, this should be
> abstracted away in a helper.

Sounds good.

For the record, there would be no need for it if we used the typedef
approach :-). There is a good example of how the original
author of ref_tracker implemented it in include/net/net_trackers.h.

> 
> > +			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
> > +							     GFP_ATOMIC);
> > +			btrfs_delayed_node_ref_tracker_alloc(
> > +				node, inode_cache_tracker, GFP_ATOMIC);
> >  			btrfs_inode->delayed_node = node;
> >  		} else {
> >  			node = NULL;
> > @@ -125,17 +139,19 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
> >   *
> >   * Return the delayed node, or error pointer on failure.
> >   */
> > -static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> > -		struct btrfs_inode *btrfs_inode)
> > +static struct btrfs_delayed_node *
> > +btrfs_get_or_create_delayed_node(struct btrfs_inode *btrfs_inode,
> > +				 struct ref_tracker **tracker)
> 
> And another pattern, please don't change the style of the function
> definition line, the return value is on the same line as name, if
> parameters don't fit under reasonable column limit like 90 chars then
> it's on the next line. Most of the code has been fixed so you can just
> extend it.

Got it, I was just using the default kernel .clang-format.
Is there a btrfs specific .clang-format I could use?

> 
> >  {
> >  	struct btrfs_delayed_node *node;
> > +	struct ref_tracker **inode_cache_tracker = NULL;
> >  	struct btrfs_root *root = btrfs_inode->root;
> >  	u64 ino = btrfs_ino(btrfs_inode);
> >  	int ret;
> >  	void *ptr;
> >  
> 
> > --- a/fs/btrfs/delayed-inode.h
> > +++ b/fs/btrfs/delayed-inode.h
> > @@ -7,6 +7,7 @@
> >  #ifndef BTRFS_DELAYED_INODE_H
> >  #define BTRFS_DELAYED_INODE_H
> >  
> > +#include <linux/ref_tracker.h>
> >  #include <linux/types.h>
> >  #include <linux/rbtree.h>
> >  #include <linux/spinlock.h>
> > @@ -63,8 +64,19 @@ struct btrfs_delayed_node {
> >  	struct rb_root_cached del_root;
> >  	struct mutex mutex;
> >  	struct btrfs_inode_item inode_item;
> > -	refcount_t refs;
> > +
> >  	int count;
> > +	refcount_t refs;
> > +
> > +#ifdef CONFIG_BTRFS_DEBUG
> > +	/* Used to track all references to this delayed node. */
> > +	struct ref_tracker_dir ref_dir;
> > +	/* Used to track delayed node reference stored in node list. */
> > +	struct ref_tracker *node_list_tracker;
> > +	/* Used to track delayed node reference stored in inode cache. */
> > +	struct ref_tracker *inode_cache_tracker;
> > +#endif
> 
> Optional and debugging structure members are best placed near the end.
> In this case it's related to the refs so this could be mentioned in
> comments as 'refs' should not be moved.

Ok.

> 
> > +
> >  	u64 index_cnt;
> >  	unsigned long flags;
> >  	/*

Sent using hkml (https://github.com/sjp38/hackermail)

