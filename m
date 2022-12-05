Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A641C642752
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Dec 2022 12:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiLELQP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Dec 2022 06:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLELQO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 06:16:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F7E0F8
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 03:16:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B21FBB80EC1
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 11:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDA1C433D7
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 11:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670238970;
        bh=97puNeDyGOMd7CfKPrRBmos4zYC84L3cCCchLE/GokA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VronYJFr5n2uzcBplxsc9qnYDa2ntKmwwpHMR9kXR3uiuwH2Uk8xPWANp8xxxauQv
         f6NHA2xmgxMhG5Xkcwwc9MsEfMoEW66KH6kHStnG8Wa5aN++QF7l4Bd3/mq7uU5hKw
         NRdyB4OgTzKqSHS1NpFMF4oEU3++I/umX40+bEITk1QYMm43rbTFCmzE28cy/HRuFs
         JzHIhRPFoEVRoc1CXXypeMQp+UswVpsOLuPJiAg9HLmaZzW2yn17e1YKrDRBRGkXK9
         Cj6V/Mz2inv4UYoxJ22ggnZK4I8zZxqNz9EJMw/sWcMH1rJsPNvSWMJ9ub4N0owhg8
         yO5js5oZyHHag==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1447c7aa004so4886447fac.11
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Dec 2022 03:16:10 -0800 (PST)
X-Gm-Message-State: ANoB5pka2iSdF9UayvvyiG4L/GcbhT6m3BTWxOowWsWLroREsEqyo/po
        MbCITg9m61PQ5k6ep5YCbmbOtcqWFBILw+GA6IU=
X-Google-Smtp-Source: AA0mqf4wrKI4hO+WUBLrqhsN2VAOtV9Z+jlpU//6VXHeuICRTA5yM3CsrUm/V3xa9UXOGCccMz4aOmdUT+YiJVelrtE=
X-Received: by 2002:a05:6870:9e9a:b0:144:307b:c8d1 with SMTP id
 pu26-20020a0568709e9a00b00144307bc8d1mr8442831oab.92.1670238969603; Mon, 05
 Dec 2022 03:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20221205095122.17011-1-robbieko@synology.com>
In-Reply-To: <20221205095122.17011-1-robbieko@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 5 Dec 2022 11:15:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5V9zC_a7cUGuUuWyAh8POqbBMtmTP608mrE8vy_jqvqw@mail.gmail.com>
Message-ID: <CAL3q7H5V9zC_a7cUGuUuWyAh8POqbBMtmTP608mrE8vy_jqvqw@mail.gmail.com>
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

On Mon, Dec 5, 2022 at 10:55 AM robbieko <robbieko@synology.com> wrote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> [Issue]
> When creating subvolume/snapshot, the transaction may be abort due to -EN=
OMEM
>
>   WARNING: CPU: 1 PID: 411 at fs/btrfs/transaction.c:1937 create_pending_=
snapshot+0xe30/0xe70 [btrfs]()
>   CPU: 1 PID: 411 Comm: btrfs Tainted: P O 4.4.180+ #42661

4.4.180...

How often does that happen on a supported kernel? The oldest supported
kernel is 4.9 at the moment.

>   Call Trace:
>     create_pending_snapshot+0xe30/0xe70 [btrfs]
>     create_pending_snapshots+0x89/0xb0 [btrfs]
>     btrfs_commit_transaction+0x469/0xc60 [btrfs]
>     btrfs_mksubvol+0x5bd/0x690 [btrfs]
>     btrfs_mksnapshot+0x102/0x170 [btrfs]
>     btrfs_ioctl_snap_create_transid+0x1ad/0x1c0 [btrfs]
>     btrfs_ioctl_snap_create_v2+0x102/0x160 [btrfs]
>     btrfs_ioctl+0x2111/0x3130 [btrfs]
>     do_vfs_ioctl+0x7ea/0xa80
>     SyS_ioctl+0xa1/0xb0
>     entry_SYSCALL_64_fastpath+0x1e/0x8e
>   ---[ end trace 910c8f86780ca385 ]---
>   BTRFS: error (device dm-2) in create_pending_snapshot:1937: errno=3D-12=
 Out of memory
>
> [Cause]
> During creating a subvolume/snapshot, it is necessary to allocate memory =
for Initializing fs root.
> Therefore, it can only use GFP_NOFS to allocate memory to avoid deadlock =
issues.
> However, atomic allocation is required when processing percpu_counter_ini=
t
> without GFP_KERNEL due to the unique structure of percpu_counter.
> In this situation, allocating memory for initializing fs root may cause
> unexpected -ENOMEM when free memory is low and causes btrfs transaction t=
o abort.

This sounds familiar, and we had a regression in mm that made
percepu_counter_init fail very often with -ENOMEM.
See:

https://lore.kernel.org/linux-mm/CAL3q7H5RNBjCi708GH7jnczAOe0BLnacT9C+OBgA-=
Dx9jhB6SQ@mail.gmail.com/

The kernel fix was this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D0760fa3d8f7fceeea508b98899f1c826e10ffe78

I'm assuming that you are probably running a Synology kernel based on
4.4 with a lot of backported patches, is that correct?
Maybe you have the patchset that introduced the regression in that
kernel, but that later fix is not in there.

Thanks.


>
> [Fix]
> We allocate memory at the beginning of creating a subvolume/snapshot.
> This way, we can ensure the memory is enough when initializing fs root.
> Even -ENOMEM happens at the beginning of creating a subvolume/snapshot,
> the transaction won=E2=80=99t abort since it hasn=E2=80=99t started yet.
>
> Robbie Ko (3):
>   btrfs: refactor anon_dev with new_fs_root_args for create
>     subvolume/snapshot
>   btrfs: change snapshot_lock to dynamic pointer
>   btrfs: add snapshot_lock to new_fs_root_args
>
>  fs/btrfs/ctree.h       |   2 +-
>  fs/btrfs/disk-io.c     | 107 ++++++++++++++++++++++++++++++-----------
>  fs/btrfs/disk-io.h     |  12 ++++-
>  fs/btrfs/file.c        |   8 +--
>  fs/btrfs/inode.c       |  12 ++---
>  fs/btrfs/ioctl.c       |  38 +++++++--------
>  fs/btrfs/transaction.c |   2 +-
>  fs/btrfs/transaction.h |   5 +-
>  8 files changed, 123 insertions(+), 63 deletions(-)
>
> --
> 2.17.1
>
