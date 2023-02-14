Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A14697074
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 23:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBNWNC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 17:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBNWNB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 17:13:01 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FE846B7
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 14:12:59 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 03FA25C00FD;
        Tue, 14 Feb 2023 17:12:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 14 Feb 2023 17:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1676412775; x=
        1676499175; bh=MbeUTHL284qxUFPzytL1OJ82/W7+17npsA/0uFNQxRc=; b=c
        bGXrm/bkT5yzyW9+TmjM/E7bn9wL4aZZHv9uDKhCSZdC9Wi6HtdTmaIM9JtgpTIe
        Hp+4X3nedSpE/Zj2dINeAXX5N1nJrfTrJcAyBDKZRUAGai7BHUlwtMZD+D0HGBub
        pcypWvpqaLGqMlrGx/Y3gowP3FRM43/ek9/LZc50DqSrRtOxLQFvKBWMKBsbvz16
        8IXojPk+RKC11Gfovp4JzHeXLVPjdRSeXM5IZ3XVphCj6uV8BH0EiLiT9V14gTPQ
        4flZcX4BbjprdnqNW7hSrjt1CA35sh+n2RpaM+GDYIgeXTDEvc3M5mleqbCLA9Hh
        nqMl2Kw85WwVL/qpf9gaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676412775; x=
        1676499175; bh=MbeUTHL284qxUFPzytL1OJ82/W7+17npsA/0uFNQxRc=; b=l
        Wox4BgN79bUejMnw0ruHHbiWXaAlrqNnxsqnXcHVq+RTlYAIicTyF1bVke/Cc4GF
        oq4TMi0XkxYZOXSFFV6Wu7iW9IVYUoYLvn+ikRh+0D5sLum4oshAiueuB8rMuStf
        Vt6wCMAe9tm83S5gJQBnSwcltXVFOpR4/iRD35xJMQKffCVtJW5LEYZP+lvnouMc
        JiACifz7EbEgyevrChA3CMSYq6XvcVFR0qK/9l3pIxc2B7E3TkHfSraHHPwJMnwN
        bP/o4WdCWqNe2FdDrfLJCS26OAEx2Oa29ienpIOEAM6xbmZkAtJXSMTgrvBok2jt
        3uNjHx/5dM3XGTl0RJqgQ==
X-ME-Sender: <xms:ZwfsYyZ2wnTwpeioOPxLeEdL_EayPltIEz0aeWEeO06uebf6fF2CtA>
    <xme:ZwfsY1aO8JPFwg_FaEd_TSuPhEa7xgN0cdPY6KvIBHg77B6lq-P-mhvCXqUGMI-cm
    WCJax_mlUtCYTw1Bco>
X-ME-Received: <xmr:ZwfsY8829t9b5Gim8ThEgeYTG2YWmYGRlDt5krCDpHPRb2Dq49xw4y9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeifedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    rhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrh
    hnpedulefhtdfhteduvdethfeftdeitdethedvtdekvdeltddvveegtdeuuddtiedtieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrih
    hssegsuhhrrdhioh
X-ME-Proxy: <xmx:ZwfsY0q8yt56JGBBHWMPH6qyF4UQ5a_dsfF-QAAgO50pzoBiSk9sdA>
    <xmx:ZwfsY9pr-P1gKsRSGmh9xHWTlO-R91ggl_5z3jqBgQy12_vyJs_5wg>
    <xmx:ZwfsYyRkik3pDKspfW9LjnFs_aMOgHCtB_ZcBHSg9CIrr34EMCmDOQ>
    <xmx:ZwfsY-BGHescNO3I9EdxVlyHKqI0XhZKN7hLWGo_yY8rHU86Yuaj0A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Feb 2023 17:12:55 -0500 (EST)
Date:   Tue, 14 Feb 2023 14:12:54 -0800
From:   Boris Burkov <boris@bur.io>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: fix size class loading logic
Message-ID: <Y+wHZje21c9p6//D@zen>
References: <cover.1674679476.git.boris@bur.io>
 <a88ac5fba9dadaba4c04edd0782d0f2e8cf5b8e6.1674679476.git.boris@bur.io>
 <CAL3q7H7eKMD44Z1+=Kb-1RFMMeZpAm2fwyO59yeBwCcSOU80Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7eKMD44Z1+=Kb-1RFMMeZpAm2fwyO59yeBwCcSOU80Pg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 14, 2023 at 09:47:54PM +0000, Filipe Manana wrote:
> On Wed, Jan 25, 2023 at 9:33 PM Boris Burkov <boris@bur.io> wrote:
> >
> > The original implementation was completely incorrect. It used
> > btrfs_search_slot to make an inexact match, which simply returned >0 to
> > indicate not finding the key.
> >
> > Change it to using search_forward with no transid to actually walk the
> > leaves looking for extent items. Some small tweaks to the key space
> > condition checking in the iteration were also necessary.
> >
> > Finally, since the sampling lookups are of fixed complexity, move them
> > into the main, blocking part of caching a block group, not as a
> > best-effort thing after. This has no effect on total block group caching
> > throughput as there is only one thread anyway, but makes it simpler and
> > reduces weird races where we change the size class simultaneously from
> > an allocation and loading.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/block-group.c | 56 ++++++++++++++++++++++++++++--------------
> >  1 file changed, 37 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 73e1270b3904..45ccb25c5b1f 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -555,7 +555,8 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
> >   * Returns: 0 on success, 1 if the search didn't yield a useful item, negative
> >   * error code on error.
> >   */
> > -static int sample_block_group_extent_item(struct btrfs_block_group *block_group,
> > +static int sample_block_group_extent_item(struct btrfs_caching_control *caching_ctl,
> > +                                         struct btrfs_block_group *block_group,
> >                                           int index, int max_index,
> >                                           struct btrfs_key *key)
> >  {
> > @@ -563,17 +564,19 @@ static int sample_block_group_extent_item(struct btrfs_block_group *block_group,
> >         struct btrfs_root *extent_root;
> >         int ret = 0;
> >         u64 search_offset;
> > +       u64 search_end = block_group->start + block_group->length;
> >         struct btrfs_path *path;
> >
> >         ASSERT(index >= 0);
> >         ASSERT(index <= max_index);
> >         ASSERT(max_index > 0);
> > +       lockdep_assert_held(&caching_ctl->mutex);
> > +       lockdep_assert_held_read(&fs_info->commit_root_sem);
> >
> >         path = btrfs_alloc_path();
> >         if (!path)
> >                 return -ENOMEM;
> >
> > -       down_read(&fs_info->commit_root_sem);
> >         extent_root = btrfs_extent_root(fs_info, max_t(u64, block_group->start,
> >                                                        BTRFS_SUPER_INFO_OFFSET));
> >
> > @@ -586,21 +589,36 @@ static int sample_block_group_extent_item(struct btrfs_block_group *block_group,
> >         key->type = BTRFS_EXTENT_ITEM_KEY;
> >         key->offset = 0;
> >
> > -       ret = btrfs_search_slot(NULL, extent_root, key, path, 0, 0);
> > -       if (ret != 0)
> > -               goto out;
> > -       if (key->objectid < block_group->start ||
> > -           key->objectid > block_group->start + block_group->length) {
> > -               ret = 1;
> > -               goto out;
> > -       }
> > -       if (key->type != BTRFS_EXTENT_ITEM_KEY) {
> > -               ret = 1;
> > -               goto out;
> > +       while (1) {
> > +               ret = btrfs_search_forward(extent_root, key, path, 0);
> 
> Boris, this is broken and can result in a deadlock.
> 
> btrfs_search_forward() will always lock the root node, despite the
> path having ->skip_locking and ->search_commit_root set to true (1).
> It's not meant to be used for commit roots, so it always needs to do locking.

Thanks for the catch and explanation. Working on a fix!

> 
> So if another task is COWing a child node of the same root node and
> then needs to wait for block group caching to complete when trying to
> allocate a metadata extent, it deadlocks.
> For example:
> 
> [539604.239315] sysrq: Show Blocked State
> [539604.240133] task:kworker/u16:6   state:D stack:0     pid:2119594
> ppid:2      flags:0x00004000
> [539604.241613] Workqueue: btrfs-cache btrfs_work_helper [btrfs]
> [539604.242673] Call Trace:
> [539604.243129]  <TASK>
> [539604.243925]  __schedule+0x41d/0xee0
> [539604.244797]  ? rcu_read_lock_sched_held+0x12/0x70
> [539604.245399]  ? rwsem_down_read_slowpath+0x185/0x490
> [539604.246111]  schedule+0x5d/0xf0
> [539604.246593]  rwsem_down_read_slowpath+0x2da/0x490
> [539604.247290]  ? rcu_barrier_tasks_trace+0x10/0x20
> [539604.248090]  __down_read_common+0x3d/0x150
> [539604.248702]  down_read_nested+0xc3/0x140
> [539604.249280]  __btrfs_tree_read_lock+0x24/0x100 [btrfs]
> [539604.250097]  btrfs_read_lock_root_node+0x48/0x60 [btrfs]
> [539604.250915]  btrfs_search_forward+0x59/0x460 [btrfs]
> [539604.251781]  ? btrfs_global_root+0x50/0x70 [btrfs]
> [539604.252476]  caching_thread+0x1be/0x920 [btrfs]
> [539604.253167]  btrfs_work_helper+0xf6/0x400 [btrfs]
> [539604.253848]  process_one_work+0x24f/0x5a0
> [539604.254476]  worker_thread+0x52/0x3b0
> [539604.255166]  ? __pfx_worker_thread+0x10/0x10
> [539604.256047]  kthread+0xf0/0x120
> [539604.256591]  ? __pfx_kthread+0x10/0x10
> [539604.257212]  ret_from_fork+0x29/0x50
> [539604.257822]  </TASK>
> [539604.258233] task:btrfs-transacti state:D stack:0     pid:2236474
> ppid:2      flags:0x00004000
> [539604.259802] Call Trace:
> [539604.260243]  <TASK>
> [539604.260615]  __schedule+0x41d/0xee0
> [539604.261205]  ? rcu_read_lock_sched_held+0x12/0x70
> [539604.262000]  ? rwsem_down_read_slowpath+0x185/0x490
> [539604.262822]  schedule+0x5d/0xf0
> [539604.263374]  rwsem_down_read_slowpath+0x2da/0x490
> [539604.266228]  ? lock_acquire+0x160/0x310
> [539604.266917]  ? rcu_read_lock_sched_held+0x12/0x70
> [539604.267996]  ? lock_contended+0x19e/0x500
> [539604.268720]  __down_read_common+0x3d/0x150
> [539604.269400]  down_read_nested+0xc3/0x140
> [539604.270057]  __btrfs_tree_read_lock+0x24/0x100 [btrfs]
> [539604.271129]  btrfs_read_lock_root_node+0x48/0x60 [btrfs]
> [539604.272372]  btrfs_search_slot+0x143/0xf70 [btrfs]
> [539604.273295]  update_block_group_item+0x9e/0x190 [btrfs]
> [539604.274282]  btrfs_start_dirty_block_groups+0x1c4/0x4f0 [btrfs]
> [539604.275381]  ? __mutex_unlock_slowpath+0x45/0x280
> [539604.276390]  btrfs_commit_transaction+0xee/0xed0 [btrfs]
> [539604.277391]  ? lock_acquire+0x1a4/0x310
> [539604.278080]  ? start_transaction+0xcb/0x6c0 [btrfs]
> [539604.279099]  transaction_kthread+0x142/0x1c0 [btrfs]
> [539604.279996]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> [539604.280673]  kthread+0xf0/0x120
> [539604.281050]  ? __pfx_kthread+0x10/0x10
> [539604.281496]  ret_from_fork+0x29/0x50
> [539604.281966]  </TASK>
> [539604.282255] task:fsstress        state:D stack:0     pid:2236483
> ppid:1      flags:0x00004006
> [539604.283897] Call Trace:
> [539604.284700]  <TASK>
> [539604.285088]  __schedule+0x41d/0xee0
> [539604.285660]  schedule+0x5d/0xf0
> [539604.286175]  btrfs_wait_block_group_cache_progress+0xf2/0x170 [btrfs]
> [539604.287342]  ? __pfx_autoremove_wake_function+0x10/0x10
> [539604.288450]  find_free_extent+0xd93/0x1750 [btrfs]
> [539604.289256]  ? _raw_spin_unlock+0x29/0x50
> [539604.289911]  ? btrfs_get_alloc_profile+0x127/0x2a0 [btrfs]
> [539604.290843]  btrfs_reserve_extent+0x147/0x290 [btrfs]
> [539604.291943]  btrfs_alloc_tree_block+0xcb/0x3e0 [btrfs]
> [539604.292903]  __btrfs_cow_block+0x138/0x580 [btrfs]
> [539604.293773]  btrfs_cow_block+0x10e/0x240 [btrfs]
> [539604.294595]  btrfs_search_slot+0x7f3/0xf70 [btrfs]
> [539604.295585]  btrfs_update_device+0x71/0x1b0 [btrfs]
> [539604.296459]  btrfs_chunk_alloc_add_chunk_item+0xe0/0x340 [btrfs]
> [539604.297489]  btrfs_chunk_alloc+0x1bf/0x490 [btrfs]
> [539604.298335]  find_free_extent+0x6fa/0x1750 [btrfs]
> [539604.299174]  ? _raw_spin_unlock+0x29/0x50
> [539604.299950]  ? btrfs_get_alloc_profile+0x127/0x2a0 [btrfs]
> [539604.300918]  btrfs_reserve_extent+0x147/0x290 [btrfs]
> [539604.301797]  btrfs_alloc_tree_block+0xcb/0x3e0 [btrfs]
> [539604.303017]  ? lock_release+0x224/0x4a0
> [539604.303855]  __btrfs_cow_block+0x138/0x580 [btrfs]
> [539604.304789]  btrfs_cow_block+0x10e/0x240 [btrfs]
> [539604.305611]  btrfs_search_slot+0x7f3/0xf70 [btrfs]
> [539604.306682]  ? btrfs_global_root+0x50/0x70 [btrfs]
> [539604.308198]  lookup_inline_extent_backref+0x17b/0x7a0 [btrfs]
> [539604.309254]  lookup_extent_backref+0x43/0xd0 [btrfs]
> [539604.310122]  __btrfs_free_extent+0xf8/0x810 [btrfs]
> [539604.310874]  ? lock_release+0x224/0x4a0
> [539604.311724]  ? btrfs_merge_delayed_refs+0x17b/0x1d0 [btrfs]
> [539604.313023]  __btrfs_run_delayed_refs+0x2ba/0x1260 [btrfs]
> [539604.314271]  btrfs_run_delayed_refs+0x8f/0x1c0 [btrfs]
> [539604.315445]  ? rcu_read_lock_sched_held+0x12/0x70
> [539604.316706]  btrfs_commit_transaction+0xa2/0xed0 [btrfs]
> [539604.317855]  ? do_raw_spin_unlock+0x4b/0xa0
> [539604.318544]  ? _raw_spin_unlock+0x29/0x50
> [539604.319240]  create_subvol+0x53d/0x6e0 [btrfs]
> [539604.320283]  btrfs_mksubvol+0x4f5/0x590 [btrfs]
> [539604.321220]  __btrfs_ioctl_snap_create+0x11b/0x180 [btrfs]
> [539604.322307]  btrfs_ioctl_snap_create_v2+0xc6/0x150 [btrfs]
> [539604.323295]  btrfs_ioctl+0x9f7/0x33e0 [btrfs]
> [539604.324331]  ? rcu_read_lock_sched_held+0x12/0x70
> [539604.325137]  ? lock_release+0x224/0x4a0
> [539604.325808]  ? __x64_sys_ioctl+0x87/0xc0
> [539604.326467]  __x64_sys_ioctl+0x87/0xc0
> [539604.327109]  do_syscall_64+0x38/0x90
> [539604.327875]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [539604.328792] RIP: 0033:0x7f05a7babaeb
> [539604.329378] RSP: 002b:00007ffd0fecc480 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [539604.330561] RAX: ffffffffffffffda RBX: 00007ffd0fecd520 RCX:
> 00007f05a7babaeb
> [539604.335194] RDX: 00007ffd0fecc4e0 RSI: 0000000050009418 RDI:
> 0000000000000004
> [539604.336583] RBP: 0000000000000002 R08: 0000000000000000 R09:
> 000055a66e107480
> [539604.337685] R10: 00007f05a7ac5358 R11: 0000000000000246 R12:
> 0000000000000004
> [539604.339220] R13: 00007ffd0fecc4e0 R14: 0000000000000004 R15:
> 000055a66c4be590
> [539604.341137]  </TASK>
> 
> This needs to use regular btrfs_search_slot() with some skip and stop logic.
> 
> Thanks.
> 
> 
> > +               if (ret != 0)
> > +                       goto out;
> > +               /* Success; sampled an extent item in the block group */
> > +               if (key->type == BTRFS_EXTENT_ITEM_KEY &&
> > +                   key->objectid >= block_group->start &&
> > +                   key->objectid + key->offset <= search_end)
> > +                       goto out;
> > +
> > +               /* We can't possibly find a valid extent item anymore */
> > +               if (key->objectid >= search_end) {
> > +                       ret = 1;
> > +                       break;
> > +               }
> > +               if (key->type < BTRFS_EXTENT_ITEM_KEY)
> > +                       key->type = BTRFS_EXTENT_ITEM_KEY;
> > +               else
> > +                       key->objectid++;
> > +               btrfs_release_path(path);
> > +               up_read(&fs_info->commit_root_sem);
> > +               mutex_unlock(&caching_ctl->mutex);
> > +               cond_resched();
> > +               mutex_lock(&caching_ctl->mutex);
> > +               down_read(&fs_info->commit_root_sem);
> >         }
> >  out:
> > +       lockdep_assert_held(&caching_ctl->mutex);
> > +       lockdep_assert_held_read(&fs_info->commit_root_sem);
> >         btrfs_free_path(path);
> > -       up_read(&fs_info->commit_root_sem);
> >         return ret;
> >  }
> >
> > @@ -638,7 +656,8 @@ static int sample_block_group_extent_item(struct btrfs_block_group *block_group,
> >   *
> >   * Returns: 0 on success, negative error code on error.
> >   */
> > -static int load_block_group_size_class(struct btrfs_block_group *block_group)
> > +static int load_block_group_size_class(struct btrfs_caching_control *caching_ctl,
> > +                                      struct btrfs_block_group *block_group)
> >  {
> >         struct btrfs_key key;
> >         int i;
> > @@ -646,11 +665,11 @@ static int load_block_group_size_class(struct btrfs_block_group *block_group)
> >         enum btrfs_block_group_size_class size_class = BTRFS_BG_SZ_NONE;
> >         int ret;
> >
> > -       if (btrfs_block_group_should_use_size_class(block_group))
> > +       if (!btrfs_block_group_should_use_size_class(block_group))
> >                 return 0;
> >
> >         for (i = 0; i < 5; ++i) {
> > -               ret = sample_block_group_extent_item(block_group, i, 5, &key);
> > +               ret = sample_block_group_extent_item(caching_ctl, block_group, i, 5, &key);
> >                 if (ret < 0)
> >                         goto out;
> >                 if (ret > 0)
> > @@ -812,6 +831,7 @@ static noinline void caching_thread(struct btrfs_work *work)
> >         mutex_lock(&caching_ctl->mutex);
> >         down_read(&fs_info->commit_root_sem);
> >
> > +       load_block_group_size_class(caching_ctl, block_group);
> >         if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
> >                 ret = load_free_space_cache(block_group);
> >                 if (ret == 1) {
> > @@ -867,8 +887,6 @@ static noinline void caching_thread(struct btrfs_work *work)
> >
> >         wake_up(&caching_ctl->wait);
> >
> > -       load_block_group_size_class(block_group);
> > -
> >         btrfs_put_caching_control(caching_ctl);
> >         btrfs_put_block_group(block_group);
> >  }
> > --
> > 2.38.1
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
