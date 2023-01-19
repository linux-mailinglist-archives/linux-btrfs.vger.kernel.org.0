Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24B674BC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 06:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjATFIK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 00:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjATFHZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 00:07:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A74C45A1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 20:54:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 612C5B8270E
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174CDC433F0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674156444;
        bh=JX7g8r0/rj6qX4qK3vccG7ypdABodTpV2WUgnh6cgF0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AGdvySW5R0NG5ag9DFq1CqOtVNDSVIJSHi1rda+2QYmH+mSkIiOypShFa+pcDTjnV
         F8Oo3Qy2vZG2M8IH5jp1yFznbuM1gQlqv02F4joCZjF4uE8tvpYRMjySpU8g2XWJB1
         SOv5awnEjSX75iiPKKdezyLBeOrPcUy732IGP9B7lSkUH0Vyf3xLTNEViKGfCDTt5b
         qsTsmseyYN0TX0bjTJMNZuIZBF/x9yuvHGygiHnRxSr6quKY3MLYsbdisnSYfy1oJ7
         CTOOz77kh+HU4VwlPMpFk1M2XJdS6nJhdPJjvSTmc9mrK0B8ZeCwyDcHyYAjXt4Pzb
         lt4Ic04plpCEw==
Received: by mail-ot1-f52.google.com with SMTP id n24-20020a0568301e9800b006865671a9d5so1790959otr.6
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 11:27:24 -0800 (PST)
X-Gm-Message-State: AFqh2kprV+dGpSOEN9xJA6VK2e3tmkJi1BrBvJtW7Cworu/mLeOHwjNM
        Qz1pX2Bgo6yl7e5t/8WYa/voGY/SuAMgbdusN3w=
X-Google-Smtp-Source: AMrXdXup7n3r+0mswt1HmXV6bObHwVwt8bzwcy7EXZNNn0Ok+ClxyKVI2i8BqwRn8cLOf1/iTocAQ1wlVHU+or58sUA=
X-Received: by 2002:a05:6830:308f:b0:686:5fff:a6e6 with SMTP id
 g15-20020a056830308f00b006865fffa6e6mr271545ots.345.1674156443116; Thu, 19
 Jan 2023 11:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20230119151929.GA29005@lst.de> <20230119161530.GA767320@falcondesktop>
 <20230119185124.znt5j3zamcopntzz@revolver>
In-Reply-To: <20230119185124.znt5j3zamcopntzz@revolver>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 19 Jan 2023 19:26:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4sDqL+zD66CJ2Ehh4CtcdUbaidN2RcSi7u+yjHKyrY=A@mail.gmail.com>
Message-ID: <CAL3q7H4sDqL+zD66CJ2Ehh4CtcdUbaidN2RcSi7u+yjHKyrY=A@mail.gmail.com>
Subject: Re: new lockdep warning about registering a non-static key
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 19, 2023 at 6:51 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> * Filipe Manana <fdmanana@kernel.org> [230119 11:15]:
> > On Thu, Jan 19, 2023 at 04:19:29PM +0100, Christoph Hellwig wrote:
> > > xfstests btrfs/168 on current misc-next:
> > >
> > > btrfs/168 1s ... [   32.860171] run fstests btrfs/168 at 2023-01-19 15:18:17
> > > [   33.224255] BTRFS info (device vdb): using crc32c (crc32c-intel) checksum
> > > alm
> > > [   33.224835] BTRFS info (device vdb): using free space tree
> > > [   33.229739] BTRFS info (device vdb): auto enabling async discard
> > > [   33.442266] BTRFS: device fsid 62b088c0-2f9a-490e-a6d8-e661c167c616 devid 1
> > > )
> > > )[   33.489483] BTRFS info (device vdc): using crc32c (crc32c-intel) checksum
> > > )alm
> > > )[   33.490135] BTRFS info (device vdc): using free space tree
> > > )[   33.494829] BTRFS info (device vdc): auto enabling async discard
> > > )[   33.495469] BTRFS info (device vdc): checking UUID tree
> > > )[   33.566003] INFO: trying to register non-static key.
> > > )[   33.566400] The code is fine but needs lockdep annotation, or maybe
> > > )[   33.566813] you didn't initialize this object before use?
> > > )[   33.567172] turning off the locking correctness validator.
> > > )[   33.567527] CPU: 0 PID: 7480 Comm: btrfs Not tainted 6.2.0-rc4+ #331
> > > )[   33.567930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > )rel-4
> > > )[   33.568665] Call Trace:
> > > )[   33.568830]  <TASK>
> > > )[   33.568996]  dump_stack_lvl+0x5b/0x73
> > > )[   33.569256]  register_lock_class+0x48d/0x4a0
> > > )[   33.569541]  ? __kmem_cache_alloc_node+0x28c/0x340
> > > )[   33.569854]  ? kmalloc_trace+0x21/0x50
> > > )[   33.569871]  ? btrfs_lru_cache_store+0x3e/0x1c0
> > > )[   33.569871]  ? cache_dir_utimes+0xac/0xe0
> > > )[   33.569871]  ? finish_inode_if_needed+0x14d1/0x17c0
> > > )[   33.569871]  ? changed_cb+0x1c1/0xbd0
> > > )[   33.569871]  ? btrfs_ioctl_send+0x1d6e/0x2080
> > > )[   33.569871]  ? _btrfs_ioctl_send+0xd9/0x120
> > > )[   33.569871]  __lock_acquire+0x6d/0x1ef0
> > > )[   33.569871]  lock_acquire+0xd2/0x2e0
> > > )[   33.569871]  ? mtree_insert_range+0x86/0x170
> > > )[   33.569871]  ? btrfs_lru_cache_store+0x3e/0x1c0
> > > )[   33.569871]  _raw_spin_lock+0x2a/0x40
> > > )[   33.569871]  ? mtree_insert_range+0x86/0x170
> > > )[   33.569871]  mtree_insert_range+0x86/0x170
> > > )[   33.569871]  btrfs_lru_cache_store+0x5f/0x1c0
> > > )[   33.569871]  cache_dir_utimes+0xac/0xe0
> > > )[   33.569871]  finish_inode_if_needed+0x14d1/0x17c0
> > > )[   33.569871]  ? lock_is_held_type+0xe3/0x140
> > > )[   33.569871]  ? find_held_lock+0x2b/0x80
> > > )[   33.569871]  changed_cb+0x1c1/0xbd0
> > > )[   33.569871]  ? lock_is_held_type+0xe3/0x140
> > > )[   33.569871]  ? find_held_lock+0x2b/0x80
> > > )[   33.569871]  ? lock_release+0x145/0x2f0
> > > )[   33.569871]  ? read_extent_buffer+0x92/0xb0
> > > )[   33.569871]  btrfs_ioctl_send+0x1d6e/0x2080
> > > )[   33.569871]  ? _btrfs_ioctl_send+0xf3/0x120
> > > )[   33.569871]  ? rcu_read_lock_sched_held+0x36/0x70
> > > )[   33.569871]  _btrfs_ioctl_send+0xd9/0x120
> > > )[   33.569871]  ? __lock_acquire+0x397/0x1ef0
> > > )[   33.569871]  btrfs_ioctl+0x11c1/0x3230
> > > )[   33.569871]  ? lock_is_held_type+0xe3/0x140
> > > )[   33.569871]  ? find_held_lock+0x2b/0x80
> > > )[   33.569871]  ? lock_release+0x145/0x2f0
> > > )[   33.569871]  __x64_sys_ioctl+0x80/0xb0
> > > )[   33.569871]  do_syscall_64+0x34/0x80
> >
> > Oddly I don't get anything reported here (and lockdep is enabled), but it's
> > easy to see why it happens.
> >
> > We're passing MT_FLAGS_LOCK_EXTERN to mt_init_flags(), as we don't care
> > about locking in btrfs' send, and because of that mt_init_flags() does not
> > initialize the spinlock:
> >
> >    (maple_tree.h)
> >
> >    static inline void mt_init_flags(struct maple_tree *mt, unsigned int flags)
> >    {
> >        mt->ma_flags = flags;
> >        if (!mt_external_lock(mt))
> >            spin_lock_init(&mt->ma_lock);
> >        rcu_assign_pointer(mt->ma_root, NULL);
> >    }
> >
> > However at mtree_insert_range(), and other mtree_* functions, mtree_lock()
> > is called unconditionally, which always tries to lock the spin lock, as it's
> > defined as:
> >
> >     #define mtree_lock(mt)            spin_lock((&(mt)->ma_lock))
> >
> > But the spinlock was not initialized, as the whole point of MT_FLAGS_LOCK_EXTERN
> > is to skip locking (unless I misunderstood its purpose).
>
> It appears that there is a misunderstanding here.  The
> MT_FLAGS_LOCK_EXTERN flag is to specify an external flag, not that you
> don't care about or won't be locking.
>
>
> > It seems mtree_lock() should be something like:
> >
> >    static inline void mtree_lock(struct maple_tree *mt)
> >    {
> >        if (!mt_external_lock(mt))
> >            spin_lock((&mt->ma_lock));
> >    }
> >
> > And the equivalent for mtree_unlock() as well.
>
> The mtree_ family of function is part of the simple interface which
> handles the locking for you.  If you are going to use an external lock,
> then you should use the advanced interface.. but you have to use a lock.
>
> Perhaps the mtree_lock/unlock() pair should be expanded to WARN_ON()
> MT_FLAGS_LOCK_EXTERN to catch this issue?
>
> Where did you get this idea about how the locking works?  Perhaps a
> documentation change is also in order.

Well, I don't remember exactly where I got the idea, but I suppose it
was from reading maple_tree.h:

1) the definition of mt_init_flags() doesn't initialize the spin lock
if MT_FLAGS_LOCK_EXTERN is set;
2) the comment for MT_FLAGS_LOCK_EXTERN says "mt_lock is not used"

So I guess I inferred that the use of that flag implied the maple tree
code would not use the spin lock at all.

Ok, I'll drop the incorrect use of the flag in btrfs then. Thanks.

>
> Thanks,
> Liam
