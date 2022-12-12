Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76D664A57E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 18:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiLLRF2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 12:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiLLRFJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 12:05:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053D46427
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 09:05:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B41D7B80AEF
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 17:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF01C433D2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670864705;
        bh=N8j8NHUdw5yYvSZbG34wHllDmxtT09J4wclFmbhCPAE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G/rK8iLIPMrqY/p0NFN2hTNLie/mxy5b8q7Yef7ylBZQrnxxoKK2yuhUUellQuYFN
         1icYyXwNGVnXxFcMejQ/w0jDMO94C38hSz6FazIj/PJuW8pF/fBIvfY/N/2bZKViwo
         nNzpwziG1TsX8bXXkP7Qe96lBqs7QGs8OgAregZFAjGZjaejZ+zLp4j6NRAfnmwqH5
         DEG9YJiZDhH53Ut4BItNgrFuW+Y88M98ym4KpYse73juDk7W4i+CNr1O0ZADCDvDb9
         3DAT/2JTC47uUCig9SUCJ72upSKN2o/BAL/xCnzer0yZN2pBJVUu5CLPDrszOuQXr0
         EF2pIc3CSfBog==
Received: by mail-oi1-f181.google.com with SMTP id s187so11780272oie.10
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 09:05:05 -0800 (PST)
X-Gm-Message-State: ANoB5pn8p5AVXZcRBm2H0h/xTYxeApEgy5h9wDVPKaMUJbYzjxt3Z9uo
        VIs0B/aXjG9zlqxnAQC76CJXdi2JtmL4Oa58lAU=
X-Google-Smtp-Source: AA0mqf7qesgQLCLAiUJnl5jourCDiXtX6OLl+llIe/RKoJZwisnbhtS+/bUC9w6/qU1C6bLD0uCKZByFldhEy5FwEwE=
X-Received: by 2002:a05:6808:1287:b0:359:dc32:4f9e with SMTP id
 a7-20020a056808128700b00359dc324f9emr37441901oiw.92.1670864704435; Mon, 12
 Dec 2022 09:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20221205095122.17011-1-robbieko@synology.com> <CAL3q7H5V9zC_a7cUGuUuWyAh8POqbBMtmTP608mrE8vy_jqvqw@mail.gmail.com>
 <eb6563b8-10b3-9418-4777-812ddda45b23@synology.com> <bb8c0658-a1b1-b8fd-cdd2-f797692832ec@synology.com>
In-Reply-To: <bb8c0658-a1b1-b8fd-cdd2-f797692832ec@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 12 Dec 2022 17:04:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Vf9FX-ZiUh+NPpO1XK1718OHf-q9AeFXAmr38OZXkxg@mail.gmail.com>
Message-ID: <CAL3q7H6Vf9FX-ZiUh+NPpO1XK1718OHf-q9AeFXAmr38OZXkxg@mail.gmail.com>
Subject: Re: [PATCH 0/3] btrfs: fix unexpected -ENOMEM with
 percpu_counter_init when create snapshot
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 8, 2022 at 6:24 AM robbieko <robbieko@synology.com> wrote:
>
>
> robbieko =E6=96=BC 2022/12/6 =E4=B8=8B=E5=8D=884:58 =E5=AF=AB=E9=81=93:
> >
> > Filipe Manana =E6=96=BC 2022/12/5 =E4=B8=8B=E5=8D=887:15 =E5=AF=AB=E9=
=81=93:
> >> On Mon, Dec 5, 2022 at 10:55 AM robbieko <robbieko@synology.com> wrote=
:
> >>> From: Robbie Ko <robbieko@synology.com>
> >>>
> >>> [Issue]
> >>> When creating subvolume/snapshot, the transaction may be abort due
> >>> to -ENOMEM
> >>>
> >>>    WARNING: CPU: 1 PID: 411 at fs/btrfs/transaction.c:1937
> >>> create_pending_snapshot+0xe30/0xe70 [btrfs]()
> >>>    CPU: 1 PID: 411 Comm: btrfs Tainted: P O 4.4.180+ #42661
> >> 4.4.180...
> >>
> >> How often does that happen on a supported kernel? The oldest supported
> >> kernel is 4.9 at the moment.
> >
> > The occurrence of this issue is extremely low, and it cannot be
> > reproduced stably.
> > We have millions of machines out there, and this issue happened 3
> > times in the last two years.
> >
> >
> >>
> >>>    Call Trace:
> >>>      create_pending_snapshot+0xe30/0xe70 [btrfs]
> >>>      create_pending_snapshots+0x89/0xb0 [btrfs]
> >>>      btrfs_commit_transaction+0x469/0xc60 [btrfs]
> >>>      btrfs_mksubvol+0x5bd/0x690 [btrfs]
> >>>      btrfs_mksnapshot+0x102/0x170 [btrfs]
> >>>      btrfs_ioctl_snap_create_transid+0x1ad/0x1c0 [btrfs]
> >>>      btrfs_ioctl_snap_create_v2+0x102/0x160 [btrfs]
> >>>      btrfs_ioctl+0x2111/0x3130 [btrfs]
> >>>      do_vfs_ioctl+0x7ea/0xa80
> >>>      SyS_ioctl+0xa1/0xb0
> >>>      entry_SYSCALL_64_fastpath+0x1e/0x8e
> >>>    ---[ end trace 910c8f86780ca385 ]---
> >>>    BTRFS: error (device dm-2) in create_pending_snapshot:1937:
> >>> errno=3D-12 Out of memory
> >>>
> >>> [Cause]
> >>> During creating a subvolume/snapshot, it is necessary to allocate
> >>> memory for Initializing fs root.
> >>> Therefore, it can only use GFP_NOFS to allocate memory to avoid
> >>> deadlock issues.
> >>> However, atomic allocation is required when processing
> >>> percpu_counter_init
> >>> without GFP_KERNEL due to the unique structure of percpu_counter.
> >>> In this situation, allocating memory for initializing fs root may cau=
se
> >>> unexpected -ENOMEM when free memory is low and causes btrfs
> >>> transaction to abort.
> >> This sounds familiar, and we had a regression in mm that made
> >> percepu_counter_init fail very often with -ENOMEM.
> >> See:
> >>
> >> https://lore.kernel.org/linux-mm/CAL3q7H5RNBjCi708GH7jnczAOe0BLnacT9C+=
OBgA-Dx9jhB6SQ@mail.gmail.com/
> >>
> >>
> >> The kernel fix was this:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D0760fa3d8f7fceeea508b98899f1c826e10ffe78
> >>
> >>
> >> I'm assuming that you are probably running a Synology kernel based on
> >> 4.4 with a lot of backported patches, is that correct?
> >> Maybe you have the patchset that introduced the regression in that
> >> kernel, but that later fix is not in there.
> >>
> >> Thanks.
> >
> > Yes, We do backport many patches, but we don't backport "mm:
> > memcg/percpu: account percpu memory to memory cgroups",
> > So we think the issue has nothing to do with "percpu: make
> > pcpu_nr_empty_pop_pages per chunk type".
> >
> > This issue is just a corner case, when percpu_counter_init is executed
> > with GFP_NOFS, there is a chance to fail.
> > So we feel that the snapshot_lock should be preallocated.
> >
> > Thanks.
> >
> >
>
> Anyone have any suggestions ?

Sorry, some holidays and other priorities came in.

The idea seems fine to me. I was just wondering if you weren't hitting
that regression in mm.
Patches 1 and 2 don't apply with current misc-next, btw, they require
manual conflict resolution.

I'll leave review comments on each patch, small things, nothing major.

Thanks.

>
>
> >>
> >>> [Fix]
> >>> We allocate memory at the beginning of creating a subvolume/snapshot.
> >>> This way, we can ensure the memory is enough when initializing fs roo=
t.
> >>> Even -ENOMEM happens at the beginning of creating a subvolume/snapsho=
t,
> >>> the transaction won=E2=80=99t abort since it hasn=E2=80=99t started y=
et.
> >>>
> >>> Robbie Ko (3):
> >>>    btrfs: refactor anon_dev with new_fs_root_args for create
> >>>      subvolume/snapshot
> >>>    btrfs: change snapshot_lock to dynamic pointer
> >>>    btrfs: add snapshot_lock to new_fs_root_args
> >>>
> >>>   fs/btrfs/ctree.h       |   2 +-
> >>>   fs/btrfs/disk-io.c     | 107
> >>> ++++++++++++++++++++++++++++++-----------
> >>>   fs/btrfs/disk-io.h     |  12 ++++-
> >>>   fs/btrfs/file.c        |   8 +--
> >>>   fs/btrfs/inode.c       |  12 ++---
> >>>   fs/btrfs/ioctl.c       |  38 +++++++--------
> >>>   fs/btrfs/transaction.c |   2 +-
> >>>   fs/btrfs/transaction.h |   5 +-
> >>>   8 files changed, 123 insertions(+), 63 deletions(-)
> >>>
> >>> --
> >>> 2.17.1
> >>>
