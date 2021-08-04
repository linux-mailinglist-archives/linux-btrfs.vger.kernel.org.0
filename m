Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED803E0098
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhHDL5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 07:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhHDL5L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Aug 2021 07:57:11 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1735FC0613D5
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Aug 2021 04:56:59 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id az7so2420236qkb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Aug 2021 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=a1b16MZl722Z+rD1dIE3trpQ6PXRtg0zg2Etl35oOwA=;
        b=UHnY4JrCAg3tB59VFmLQJPy/vQyhVDMqYyy/pktyli5818TlE4OBaFApbduAJVPTXs
         tcb5VAtim5Ii1S3aAeKzEES9hKFvQVRgxmoEFS9Gd7t9y+iNErq46xJ8BHX2xGA9E7p2
         NGeGXMWAGpcufZRul5kcv+SlcvN6/TrGP+hAQPaIAi44EJrnjSHKAsZqkUNTwF5yHNar
         UpxoWVnk/9SL754h7+w3kFNVGeYbTH5vKxpZFuZ2jeIxmWOhoqW+7olAQmcQt7joO6PE
         qv2jK2NslZrScEd0wehTR929Uy7moknOjOTFaLzTcde0r1Hp3L60xrmjcZW53jJpQ+dl
         lGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=a1b16MZl722Z+rD1dIE3trpQ6PXRtg0zg2Etl35oOwA=;
        b=tW1e5IBRlTBdcKyPLA+RxPdSye4U7uozPDNNu/P6MvD27oHPPKplK0RWmRDhmWzGe+
         bXvLFmsao6rg5j4okvz1FsStiP2Gw1N/i8ZjVHS0UCdteYVGrgqE2e42LEFMa1KNq74n
         dZFInKGOY7Go8bgZUbQjNJ1ARl+vRIkJH3tYBoOyXUetQe9lntyAtQwyXUPi4E61fdRc
         1wTcUdXAY8JYtYkkDOncll86COYYS8igJpgoliBCIJ95eOOVdAXaSFi9CM5Z+jqwnczb
         yYVikEN41AoKNGGET1fw7fMHcB5vrZvjBAgBVa/t9xb7RuglAlTOcEpyJY/rkgLbBdFQ
         bUMg==
X-Gm-Message-State: AOAM533h/lm2q3pVHew2PUk8gNl0lCVQmMyOrBzFP5pZyzP7QTAPKmvn
        UCdXIVginvgCMYk3WMiAgE4MSdBnk0G+udMcVRg=
X-Google-Smtp-Source: ABdhPJy9tkGthvmpwa68Qbs2iyyhNCeaV7P8z+lp9Vu962gYXCdf9aaRqwYT1U15Wt3gbU3LQzmAW1BWLvesCl7UwfY=
X-Received: by 2002:ae9:ed8a:: with SMTP id c132mr25835035qkg.438.1628078218286;
 Wed, 04 Aug 2021 04:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210804024904.2598-1-robbieko@synology.com>
In-Reply-To: <20210804024904.2598-1-robbieko@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 4 Aug 2021 12:56:47 +0100
Message-ID: <CAL3q7H74kDr+_R=RixVyu05zBxXNqTgYh+Wibmp3vffxjwA6Yg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix root drop key inconsistent when drop
 subvolume/snapshot fails
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 4, 2021 at 4:45 AM robbieko <robbieko@synology.com> wrote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> When walk down/up tree fails, we did not aborting the transaction,
> nor did modify the root drop key, but the refs of some tree blocks
> may have been removed in the transaction.
>
> Therefore when we retry to delete the subvolume in the future,
> we will fail due to the fact that some references were deleted
> in the previous attempt.
>
> ------------[ cut here ]------------
> WARNING: at fs/btrfs/extent-tree.c:898 btrfs_lookup_extent_info+0x40a/0x4=
c0 [btrfs]()
> CPU: 2 PID: 11618 Comm: btrfs-cleaner Tainted: P
> Hardware name: Synology Inc. RS3617xs Series/Type2 - Board Product Name1,=
 BIOS M.017 2019/10/16
> ffffffff814c2246 ffffffff81036536 ffff88024a911d08 ffff880262de45b0
> ffff8802448b5f20 ffff88024a9c1ad8 0000000000000000 ffffffffa08eb05a
> 000008f84e72c000 0000000000000000 0000000000000001 0000000100000000
> Call Trace:
> [<ffffffff814c2246>] ? dump_stack+0xc/0x15
> [<ffffffff81036536>] ? warn_slowpath_common+0x56/0x70
> [<ffffffffa08eb05a>] ? btrfs_lookup_extent_info+0x40a/0x4c0 [btrfs]
> [<ffffffffa08ee558>] ? do_walk_down+0x128/0x750 [btrfs]
> [<ffffffffa08ebab4>] ? walk_down_proc+0x314/0x330 [btrfs]
> [<ffffffffa08eec42>] ? walk_down_tree+0xc2/0xf0 [btrfs]
> [<ffffffffa08f2bce>] ? btrfs_drop_snapshot+0x40e/0x9a0 [btrfs]
> [<ffffffffa09096db>] ? btrfs_clean_one_deleted_snapshot+0xab/0xe0 [btrfs]
> [<ffffffffa08fe970>] ? cleaner_kthread+0x280/0x320 [btrfs]
> [<ffffffff81052eaf>] ? kthread+0xaf/0xc0
> [<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
> [<ffffffff814c8c0d>] ? ret_from_fork+0x5d/0xb0
> [<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
> ------------[ end trace ]-----------
> BTRFS error (device dm-1): Missing references.
> BTRFS: error (device dm-1) in btrfs_drop_snapshot:9557: errno=3D-5 IO fai=
lure
>
> By not aborting the transaction, every future attempt to delete the
> subvolume fails and we end up never freeing all the extents used by
> the subvolume/snapshot.
>
> By aborting the transaction we have a least the possibility to
> succeeded after unmounting and mounting again the filesystem.
>
> So we fix this problem by aborting the transaction when the walk down/up
> tree fails, which is a safer approach.

Ok, this still misses the explanation on why we can't solve the
problem by simply updating the drop_progress and drop_level when we
get an error from walk_up_tree() or walk_down_tree().

>
> In addition, we also added the initialization of drop_progress and
> drop_level.

So, this about initializing drop_progress and drop_level seems like a
separate change.
How is this related to the original problem?

It completely lacks an explanation about why it's needed, how it
relates to the original problem.

If it's unrelated, then it should go into a separate patch with a
proper explanation in its changelog.

>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/btrfs/extent-tree.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 268ce58d4569..032a257fdb65 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5539,10 +5539,14 @@ int btrfs_drop_snapshot(struct btrfs_root *root, =
int update_ref, int for_reloc)
>                 path->locks[level] =3D BTRFS_WRITE_LOCK;
>                 memset(&wc->update_progress, 0,
>                        sizeof(wc->update_progress));
> +               memset(&wc->drop_progress, 0,
> +                      sizeof(wc->drop_progress));

I don't see why this is needed.
wc was allocated with kzalloc(), how can wc->drop_progress not be
already zeroed here?

Also, walk_up_tree() and walk_down_tree() never read from
wc->drop_progress. We use wc->drop_progress only for storing after
walk up/walk down and then copy it into the root item for persistence.

>         } else {
>                 btrfs_disk_key_to_cpu(&key, &root_item->drop_progress);
>                 memcpy(&wc->update_progress, &key,
>                        sizeof(wc->update_progress));
> +               memcpy(&wc->drop_progress, &key,
> +                      sizeof(wc->drop_progress));

Why is this needed?
Except when starting the subvolume/snapshot drop, before entering the
loop with the walk up and down logic, we never read wc->drop_progress.

wc->drop_progress is meant only for storing into the root_item after
each walk up/walk down iteration, we never read from it during the
walks.

>
>                 level =3D btrfs_root_drop_level(root_item);
>                 BUG_ON(level =3D=3D 0);
> @@ -5588,6 +5592,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, in=
t update_ref, int for_reloc)
>
>         wc->restarted =3D test_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
>         wc->level =3D level;
> +       wc->drop_level =3D level;

I don't understand why this is needed too.
We never read from wc->drop_level during the walk up and walk down,
it's only used to store a level during/after each walk up and walk
down iteration, and if the walks succeeded we
set wc->drop_level to wc->level and then copy it into the root item.

So please provide an explanation on why these initializations are
needed and how they relate to the original problem.
If they are not related to the original problem, then move them into a
separate patch, with all the proper explanations in the changelog.

Thanks.


>         wc->shared_level =3D -1;
>         wc->stage =3D DROP_REFERENCE;
>         wc->update_ref =3D update_ref;
> @@ -5659,8 +5664,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, i=
nt update_ref, int for_reloc)
>                 }
>         }
>         btrfs_release_path(path);
> -       if (err)
> +       if (err) {
> +               btrfs_abort_transaction(trans, err);
>                 goto out_end_trans;
> +       }
>
>         ret =3D btrfs_del_root(trans, &root->root_key);
>         if (ret) {
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
