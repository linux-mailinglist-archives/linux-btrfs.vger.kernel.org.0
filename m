Return-Path: <linux-btrfs+bounces-15866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7336CB1BB24
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 21:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911E317EF94
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 19:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C4023A58B;
	Tue,  5 Aug 2025 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWZbTCCC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657D1DFF0
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423303; cv=none; b=PcMlB/ef08mVYndF32r2HiCA4AWlgBS6B9VnzTNY7YZAyww1z7CdGmI4DDnf1KECQRufeFigzfx8SCRepNyM+wPsLXi5dO70T5a5KKG1n1YClfYNb120zQOjlMZkWgtbb7ZAmiOiSQokqSS3VFdxowVa070yo3qEeaFyr+EM3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423303; c=relaxed/simple;
	bh=SDrBzXZsHXhCpI8+qAmvzbxrK4kGshT6dHfg6X0EGLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fhhc1BNcQcXERyZRQtho61F0dEBylaMMxtC7Vim5atFa2WL0U888DSZu7ThX2t0HeoWaVew9kmZKz6JZEk1Lqvcpv7IXGvOiZs/sfEaYJQCd7+lxi7ymsnZXy40GafXXv4M2PMJ6rcDJDJBJ3+k4O8gmH4rBc6zfNhO7bG4ZlXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWZbTCCC; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e8fe55d4facso3409197276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Aug 2025 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754423300; x=1755028100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWmFo5hbseEwdp3MHeRajdD4moxBdf1KYMn9yMa6W7k=;
        b=UWZbTCCCv7IL7RwuospnyrjjDOdwyE7pJcM+G9AJ7Or+ljgL7pe/tcDW76oKInebr3
         /x7JK2EDlwdDc054sRiwOBMJ3XWzLn0gjyn9/mE1pQ+uKRECdwURuxlRcCXeFZDnaUyA
         Mq1IIiEDNDdlCS//d2hPyS0zlUCXP536nK5aQcR6Cd3Ez4MbJLcLc8sjavqprKlmb9p6
         rgxM1FYh9gjsECTA88Z/bobCKs1rebTkNU/PqzBgBcO9lIL4C+VPeTuguU5r1+R6/hio
         /boC9/utYZVZugurLdLtc92XxVOpkPfoIeropkNDslXTs8ZayNb/UdVOrTPgsPBndNd+
         WmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754423300; x=1755028100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWmFo5hbseEwdp3MHeRajdD4moxBdf1KYMn9yMa6W7k=;
        b=kRbfvchM4O5K/YBvIeE/32bH8mkjlN8sOw39LjBTh9ARiZkA4+Dzf4UoCjiJtv068v
         Cu6eDcFMSg6xo0/aEWqf+F69yxCQ7qwtcXhxBmeOCsS3VCuF9lo9MG5v7g0qjzGxaick
         op34sT/x40i7tZctHGItAUf9X9oYwpl77Oj+BzFFqopB6fBjjjinB9eOXJ8EFJBsU+88
         wueIPSTtZz6jAYkNfGeuu6+2Xfk4Z9B7RVsfjnhnlxiTY1dLpTxjoEuoX+udP9k09TiZ
         taKvcQExnf7ErFFdzPzhSExNHXyasl3wqvhegM+M8RQ3D/eSZkGyNfneBCjyQQchSOtN
         YgNw==
X-Gm-Message-State: AOJu0YydeBZiP4OsXrWFdDVv8K+NY2+T0M8TgbEphC24zTybJWoafknt
	82KcuQFHkDMCV1bI1nkM20X7Hu44VE6wF4IclEn43pD2sBQ0kMU/W3ao
X-Gm-Gg: ASbGnctY2SFxSCikdYvNGd1Ss0cB2OLbqlQU5vBkgadUUU8Iw15i2jiNxRQ9AuDfpAp
	+b8tRML24tuo7zKgCLC52uTBUplr8L6JkyPuxmYDAhXhnmI0/ChN0kT6PwJf3H2ASbcYyN1QiqU
	6Gsii7V1lEf1GeJmReEGKAvtT9jojkQz0/ZQkoa4DNM9EixaLlPgi64Zf9/p7JTiFAYqqaqWC2W
	RzfXp8OhZCwJcOyZW06VNViTtqkmkiIZ5pzMOdxJpxXyflRyfax9au/lxHP4T77Yx2+ceisi/Ih
	jDf3XpdMTdU4rBcTTc5Dt58QsOwI1PUf03gYFQevcU59JaHB59I7rLHoH3+kjc+rjhpHQStsDZv
	ydjdQbvMfdzcFxXXhRB4fYc/+y20=
X-Google-Smtp-Source: AGHT+IFPbNwDZhOiA0PkU28YimsLACTCYvOCmh+vO6XuRDswapHopqU9vDHwrIWAlURBgUo1lSX/hg==
X-Received: by 2002:a05:690c:a0a8:10b0:71a:421e:e4fe with SMTP id 00721157ae682-71bc9815f49mr5065257b3.24.1754423300191;
        Tue, 05 Aug 2025 12:48:20 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5985e2sm34651647b3.57.2025.08.05.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:48:19 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: implement ref_tracker for delayed_nodes
Date: Tue,  5 Aug 2025 12:48:06 -0700
Message-ID: <20250805194817.3509450-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250805151447.GM6704@twin.jikos.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 5 Aug 2025 17:14:47 +0200 David Sterba <dsterba@suse.cz> wrote:

> On Mon, Aug 04, 2025 at 12:00:12PM -0700, Leo Martins wrote:
> > On Mon, 4 Aug 2025 15:57:50 +0200 David Sterba <dsterba@suse.cz> wrote:
> > 
> > > On Tue, Jul 29, 2025 at 12:08:04AM -0700, Leo Martins wrote:
> > > > This patch adds ref_tracker infrastructure for btrfs_delayed_node.
> > > > 
> > > > A ref_tracker object is allocated every time the reference count is
> > > > increased and freed when the reference count is decreased. The
> > > > ref_tracker object contains stack_trace information about where the
> > > > ref count is increased and decreased. The ref_tracker_dir embedded in
> > > > btrfs_delayed_node keeps track of all current references, and some
> > > > previous references. This information allows for detection of reference
> > > > leaks or double frees.
> > > > 
> > > > Here is a common example of taking a reference to a delayed_node and
> > > > freeing it with ref_tracker.
> > > > 
> > > > ```C
> > > > struct ref_tracker *tracker;
> > > > struct btrfs_delayed_node *node;
> > > > 
> > > > node = btrfs_get_delayed_node(inode, tracker);
> > > > // use delayed_node...
> > > > btrfs_release_delayed_node(node, tracker);
> > > > ```
> > > > 
> > > > There are two special cases where the delayed_node reference is long
> > > > term, meaning that the thread that takes the reference and the thread
> > > > that frees the reference are different. The inode_cache which is the
> > > > btrfs_delayed_node reference stored in the associated btrfs_inode, and
> > > > the node_list which is the btrfs_delayed_node reference stored in the
> > > > btrfs_delayed_root node_list/prepare_list. In these cases the
> > > > ref_tracker is stored in the delayed_node itself.
> > > > 
> > > > This patch introduces some new wrappers (btrfs_delayed_node_ref_tracker_*)
> > > > to ensure that when BTRFS_DEBUG is disabled everything gets compiled out.
> > > > 
> > > > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > > 
> > > I'm still missing why we need to add this whole infrastructure, there
> > > weren't any recent bugs in delayed inode tracking. I understand what the
> > > ref tracker does but it's still increasing structure size and adds a
> > > perf hit that is acceptable for debugging kernels but still.
> > 
> > Our leading btrfs crash is a soft lockup related to delayed_nodes.
> 
> Adding infrastructure for real problems makes sense, this is a good
> justification and should be mentioned in the patch. On which version do
> you observe it?

We have significant number of hosts running 6.9, 6.11, and 6.13. This soft
lockup happens on 6.11 and 6.13, but not 6.9. Also, it appears to be more
common on 6.11 happening at twice the rate of 6.13.

> 
> > [21017.354271] [     C96] Call Trace:
> > [21017.354273] [     C96]  <IRQ>
> > [21017.354278] [     C96]  ? rcu_dump_cpu_stacks+0xa1/0xe0
> > [21017.354282] [     C96]  ? print_cpu_stall+0x113/0x200
> > [21017.354284] [     C96]  ? rcu_sched_clock_irq+0x633/0x730
> > [21017.354287] [     C96]  ? update_process_times+0x66/0xa0
> > [21017.354288] [     C96]  ? dma_map_page_attrs+0x250/0x250
> > [21017.354289] [     C96]  ? tick_nohz_handler+0x84/0x1d0
> > [21017.354291] [     C96]  ? hrtimer_interrupt+0x1a1/0x5b0
> > [21017.354293] [     C96]  ? __sysvec_apic_timer_interrupt+0x44/0xe0
> > [21017.354295] [     C96]  ? sysvec_apic_timer_interrupt+0x6b/0x80
> > [21017.354296] [     C96]  </IRQ>
> > [21017.354297] [     C96]  <TASK>
> > [21017.354297] [     C96]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [21017.354302] [     C96]  ? xa_find+0xa/0xb0
> > [21017.354305] [     C96]  btrfs_kill_all_delayed_nodes+0x6b/0x150
> > [21017.354307] [     C96]  ? __switch_to+0x133/0x530
> > [21017.354308] [     C96]  ? schedule+0xff4/0x1380
> > [21017.354310] [     C96]  btrfs_clean_one_deleted_snapshot+0x70/0xe0
> > [21017.354313] [     C96]  cleaner_kthread+0x83/0x120
> > [21017.354315] [     C96]  ? exportfs_encode_inode_fh+0x60/0x60
> > [21017.354317] [     C96]  kthread+0xae/0xe0
> > [21017.354319] [     C96]  ? __efi_queue_work+0x130/0x130
> > [21017.354320] [     C96]  ret_from_fork+0x2f/0x40
> > [21017.354322] [     C96]  ? __efi_queue_work+0x130/0x130
> > [21017.354323] [     C96]  ret_from_fork_asm+0x11/0x20
> > [21017.354326] [     C96]  </TASK>
> > [21042.628340] [     C96] watchdog: BUG: soft lockup - CPU#96 stuck for 45s! [btrfs-cleaner:1438]
> > 
> > btrfs_kill_all_delayed_nodes is getting stuck in an infinite loop because
> > the root->delayed_nodes xarray has a delayed_node that never gets erased.
> > Inspecting the crash dump reveals that the delayed_node has a reference count
> > of one, indicating there is a reference leak.
> > 
> > I believe this bug was introduced or at least magnified somewhere between
> > 6.9 and 6.11.
> 
> That's likely to be related to the xarray conversion in 6.8.

I took a look at this, but couldn't find any obvious bugs.

> 
> > Let me know if you want anymore details about the crash.
> > 
> > > 
> > > We have the ref-verify code and mount option, from what I've heard it
> > > was used sporadically when touching related code. We can let the ref
> > > tracking work like that too, not turned on by default ie. requiring a
> > > mount option.
> > 
> > The only issue with a mount option is that we would not be able to conditionally
> > compile ref_tracker_dir and ref_tracker pointers in struct btrfs_delayed_node,
> > permanently increasing the size of the struct from 304 bytes to 400 bytes.
> 
> That's not a small difference though for delayed inodes it may be still
> within the acceptable range. Turnin on debugging features for other
> subsystems also bloats structures, lockdep makes from 4B spinlock
> something like 70B, also indirectly hidden in other embedded structures.
> 
> > Alternatively, there could be a delayed_node ref_tracker helper struct that we
> > could store a pointer to.
> 
> This might make more sense for the first implementation.

Got it, will give this a shot for v3.

> 
> > > In case you'd want to enhance more structures with ref tracker the mount
> > > option can enable them selectively.
> > > 
> > > > @@ -106,6 +113,13 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
> > > >  		 */
> > > >  		if (refcount_inc_not_zero(&node->refs)) {
> > > >  			refcount_inc(&node->refs);
> > > > +#ifdef CONFIG_BTRFS_DEBUG
> > > > +			inode_cache_tracker = &node->inode_cache_tracker;
> > > > +#endif
> > > 
> > > We try to avoid #ifdefs if it's a repeating pattern, this should be
> > > abstracted away in a helper.
> > 
> > Sounds good.
> > 
> > For the record, there would be no need for it if we used the typedef
> > approach :-). There is a good example of how the original
> > author of ref_tracker implemented it in include/net/net_trackers.h.
> 
> We also try to stick to consistent coding style and patterns even if
> there's something possibly better. Dealing with various preferences in
> a big code base becomes quite distracting over time.

Makes sense.

> 
> Could the typedef be replaced by a struct that's abstracting the
> conditional type? Something like
> 
> struct delayed_inode_tracker {
> #ifdef ...
> 	struct ref_tracker tracker;
> #else
> 	struct {} tracker;
> #endif
> };
> 
> Visually it's basically the same what I see in the net_tracker.h and we
> won't have to argue about the typedefs.

Yeah, this is great!

> 
> > > > +			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
> > > > +							     GFP_ATOMIC);
> > > > +			btrfs_delayed_node_ref_tracker_alloc(
> > > > +				node, inode_cache_tracker, GFP_ATOMIC);
> > > >  			btrfs_inode->delayed_node = node;
> > > >  		} else {
> > > >  			node = NULL;
> > > > @@ -125,17 +139,19 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
> > > >   *
> > > >   * Return the delayed node, or error pointer on failure.
> > > >   */
> > > > -static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> > > > -		struct btrfs_inode *btrfs_inode)
> > > > +static struct btrfs_delayed_node *
> > > > +btrfs_get_or_create_delayed_node(struct btrfs_inode *btrfs_inode,
> > > > +				 struct ref_tracker **tracker)
> > > 
> > > And another pattern, please don't change the style of the function
> > > definition line, the return value is on the same line as name, if
> > > parameters don't fit under reasonable column limit like 90 chars then
> > > it's on the next line. Most of the code has been fixed so you can just
> > > extend it.
> > 
> > Got it, I was just using the default kernel .clang-format.
> > Is there a btrfs specific .clang-format I could use?
> 
> Though there's "default kernel" .clang-format, many subsystems have
> their own style.  I think Boris mentioned an adjusted .clang-format for
> btrfs, but we have hand tuned code I'm not sure can be expressed in the
> config. The best we can do is to let if format things that have
> basically no exceptions and not touch the rest.

Understood.

Sent using hkml (https://github.com/sjp38/hackermail)

