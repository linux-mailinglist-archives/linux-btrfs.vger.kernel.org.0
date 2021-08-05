Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4C63E10AA
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 10:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhHEI5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 04:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhHEI5j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Aug 2021 04:57:39 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3324C061765
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Aug 2021 01:57:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c5so3344287qtp.13
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Aug 2021 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=6nBqiEYxTfGyUuBsViasABMPa2dRQwtzrb8z+iPXk9c=;
        b=FHopV8UiVRfQjZVKunL0LM9uoOqNAzonISGXdPT0dSuEe25LtWxEpjcCgcSdbVdhuF
         hl+thZlWlqf3WIQ2CNRkjYQHANyd/7tdR5yAltoaGrcNJ547KbLJtK1+Rw9rdrCxN1mG
         wggpE93c9I0KhG+JnTxHjHuxLbVMOjWNnKQogsnwQFhhzUJUyVKs02kmze7U4fnhBmS9
         yx8iw7Id+6uNR6wCeFHKwgcot9mpba3tKG5uh/3wmrD5zBn5Us6+mQlA06thHNuY3C8H
         ToeHJTuGeHcgrpTw5RNIxZE0G12wx6SLgWsYkrHb3IWxOSqlW+px7EA3+f71sY8BS7tV
         IYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=6nBqiEYxTfGyUuBsViasABMPa2dRQwtzrb8z+iPXk9c=;
        b=oZqMBOkRxQv6qxfK8qYBzkzdbAkeqDMq8bxnmkuj6dkhK76ioXC0w8RQiILrQjkAR4
         SL7rrrvc75lzHa8RjaIrXQDQ9Dfl+h9/P7IF6BjbvkDXaqw0AJ60GcHr3i3cCMp9jiS7
         KGB9yvpPuKy6zNXuINxXFNMk1hmpJp+cJu/s7qzpFU3c2C83RJ1b/nSlhl51znwf1MAu
         oBU3jahCiEXVbArSl9e+CPQDOQj77OhEgHRUvoXQEDM1nXONtIdt7AiGTt+s4ljQal9w
         3aW3NpemJknY0f8APe9K9zO1n7XSs019TuN+AEjOf3iWeegujZYkVWyGhWeth6nL+9mQ
         zENQ==
X-Gm-Message-State: AOAM530x7bdnFGbxGt9qoZkqxfiNrsHN9rYJaa3oQwtJHZWXNTldB11W
        x/lL+o9x4MW5zIZ6R2UenBblE3ZlgLFmj+JY2tc=
X-Google-Smtp-Source: ABdhPJwNJVeibdWHlADasUM6niqzLaVyNLae32hVUajgv98FtC4P6Xeh30eoRvf27q63+R1Ep+XG0h2AaQhTBfZhdOU=
X-Received: by 2002:ac8:5e11:: with SMTP id h17mr3511773qtx.213.1628153844099;
 Thu, 05 Aug 2021 01:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210804024904.2598-1-robbieko@synology.com> <CAL3q7H74kDr+_R=RixVyu05zBxXNqTgYh+Wibmp3vffxjwA6Yg@mail.gmail.com>
 <58bbbb8f-06d6-2976-7cb7-afffe3c8436a@synology.com>
In-Reply-To: <58bbbb8f-06d6-2976-7cb7-afffe3c8436a@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 5 Aug 2021 09:57:13 +0100
Message-ID: <CAL3q7H5MrjJyvN-6zhD3Uv3qJ3XxKmPEGavUUjg4xqZyADzptA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix root drop key inconsistent when drop
 subvolume/snapshot fails
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 5, 2021 at 4:00 AM robbieko <robbieko@synology.com> wrote:
>
> Filipe Manana =E6=96=BC 2021/8/4 =E4=B8=8B=E5=8D=88 07:56 =E5=AF=AB=E9=81=
=93:
> > On Wed, Aug 4, 2021 at 4:45 AM robbieko <robbieko@synology.com> wrote:
> >> From: Robbie Ko <robbieko@synology.com>
> >>
> >> When walk down/up tree fails, we did not aborting the transaction,
> >> nor did modify the root drop key, but the refs of some tree blocks
> >> may have been removed in the transaction.
> >>
> >> Therefore when we retry to delete the subvolume in the future,
> >> we will fail due to the fact that some references were deleted
> >> in the previous attempt.
> >>
> >> ------------[ cut here ]------------
> >> WARNING: at fs/btrfs/extent-tree.c:898 btrfs_lookup_extent_info+0x40a/=
0x4c0 [btrfs]()
> >> CPU: 2 PID: 11618 Comm: btrfs-cleaner Tainted: P
> >> Hardware name: Synology Inc. RS3617xs Series/Type2 - Board Product Nam=
e1, BIOS M.017 2019/10/16
> >> ffffffff814c2246 ffffffff81036536 ffff88024a911d08 ffff880262de45b0
> >> ffff8802448b5f20 ffff88024a9c1ad8 0000000000000000 ffffffffa08eb05a
> >> 000008f84e72c000 0000000000000000 0000000000000001 0000000100000000
> >> Call Trace:
> >> [<ffffffff814c2246>] ? dump_stack+0xc/0x15
> >> [<ffffffff81036536>] ? warn_slowpath_common+0x56/0x70
> >> [<ffffffffa08eb05a>] ? btrfs_lookup_extent_info+0x40a/0x4c0 [btrfs]
> >> [<ffffffffa08ee558>] ? do_walk_down+0x128/0x750 [btrfs]
> >> [<ffffffffa08ebab4>] ? walk_down_proc+0x314/0x330 [btrfs]
> >> [<ffffffffa08eec42>] ? walk_down_tree+0xc2/0xf0 [btrfs]
> >> [<ffffffffa08f2bce>] ? btrfs_drop_snapshot+0x40e/0x9a0 [btrfs]
> >> [<ffffffffa09096db>] ? btrfs_clean_one_deleted_snapshot+0xab/0xe0 [btr=
fs]
> >> [<ffffffffa08fe970>] ? cleaner_kthread+0x280/0x320 [btrfs]
> >> [<ffffffff81052eaf>] ? kthread+0xaf/0xc0
> >> [<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
> >> [<ffffffff814c8c0d>] ? ret_from_fork+0x5d/0xb0
> >> [<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
> >> ------------[ end trace ]-----------
> >> BTRFS error (device dm-1): Missing references.
> >> BTRFS: error (device dm-1) in btrfs_drop_snapshot:9557: errno=3D-5 IO =
failure
> >>
> >> By not aborting the transaction, every future attempt to delete the
> >> subvolume fails and we end up never freeing all the extents used by
> >> the subvolume/snapshot.
> >>
> >> By aborting the transaction we have a least the possibility to
> >> succeeded after unmounting and mounting again the filesystem.
> >>
> >> So we fix this problem by aborting the transaction when the walk down/=
up
> >> tree fails, which is a safer approach.
> > Ok, this still misses the explanation on why we can't solve the
> > problem by simply updating the drop_progress and drop_level when we
> > get an error from walk_up_tree() or walk_down_tree().
>
> I don't fully understand the walk up/down tree part, so I am not sure if
> drop_progress and drop_level are correct. So it=E2=80=99s safer for me to=
 abort
> the transaction.

Then it seems a better understanding is needed.
I would like to know exactly why updating the drop_progress and
drop_level, and the root item, even when the walk up/down fails would
not work. And have it mentioned in the changelog.

When attempting to delete again a root, we have checks that first
verify if backrefs still exist for an extent.
They were added by:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D78c52d9eb6b7ac899bcd5a681aeff7c971c22934

The problem you describe sounds more like it's missing that type of
check somewhere.

>
>
> >> In addition, we also added the initialization of drop_progress and
> >> drop_level.
> > So, this about initializing drop_progress and drop_level seems like a
> > separate change.
> > How is this related to the original problem?
> >
> > It completely lacks an explanation about why it's needed, how it
> > relates to the original problem.
> >
> > If it's unrelated, then it should go into a separate patch with a
> > proper explanation in its changelog.
>
> This part is really not related to the original problem, but I think
> there is a potential risk, I will separate it into another patch.
>
>
> >> Signed-off-by: Robbie Ko <robbieko@synology.com>
> >> ---
> >>   fs/btrfs/extent-tree.c | 9 ++++++++-
> >>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> >> index 268ce58d4569..032a257fdb65 100644
> >> --- a/fs/btrfs/extent-tree.c
> >> +++ b/fs/btrfs/extent-tree.c
> >> @@ -5539,10 +5539,14 @@ int btrfs_drop_snapshot(struct btrfs_root *roo=
t, int update_ref, int for_reloc)
> >>                  path->locks[level] =3D BTRFS_WRITE_LOCK;
> >>                  memset(&wc->update_progress, 0,
> >>                         sizeof(wc->update_progress));
> >> +               memset(&wc->drop_progress, 0,
> >> +                      sizeof(wc->drop_progress));
> > I don't see why this is needed.
> > wc was allocated with kzalloc(), how can wc->drop_progress not be
> > already zeroed here?
>
> Yes, it's should all be zero.
> But I think the wording of update_progress should be consistent.

What do you mean by "wording of update_progress"?

>
> >
> > Also, walk_up_tree() and walk_down_tree() never read from
> > wc->drop_progress. We use wc->drop_progress only for storing after
> > walk up/walk down and then copy it into the root item for persistence.
> >
> >>          } else {
> >>                  btrfs_disk_key_to_cpu(&key, &root_item->drop_progress=
);
> >>                  memcpy(&wc->update_progress, &key,
> >>                         sizeof(wc->update_progress));
> >> +               memcpy(&wc->drop_progress, &key,
> >> +                      sizeof(wc->drop_progress));
> > Why is this needed?
> > Except when starting the subvolume/snapshot drop, before entering the
> > loop with the walk up and down logic, we never read wc->drop_progress.
> >
> > wc->drop_progress is meant only for storing into the root_item after
> > each walk up/walk down iteration, we never read from it during the
> > walks.
>
> Indeed, drop_progress is only used to storing into the root item after
> each walk up/down iteration. But this value is not updated every time,
> when the stage is UPDATE_BACKREF, we may update 0 into to the root item,
> resulting in inconsistent drop_progress.

I still don't see how that could happen.
We always start in the DROP_REFERENCE stage, and then we update
drop_progress based on wc->level, path->nodes[wc->level] and
path->slots[wc->level].
All these are properly initialized.

>
> So I think we must initialize drop_progress and drop_level.
>
> >>                  level =3D btrfs_root_drop_level(root_item);
> >>                  BUG_ON(level =3D=3D 0);
> >> @@ -5588,6 +5592,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root,=
 int update_ref, int for_reloc)
> >>
> >>          wc->restarted =3D test_bit(BTRFS_ROOT_DEAD_TREE, &root->state=
);
> >>          wc->level =3D level;
> >> +       wc->drop_level =3D level;
> > I don't understand why this is needed too.
> > We never read from wc->drop_level during the walk up and walk down,
> > it's only used to store a level during/after each walk up and walk
> > down iteration, and if the walks succeeded we
> > set wc->drop_level to wc->level and then copy it into the root item.
>
> This is not always true.
> If the stage is UPDATE_BACKREF, drop_level and drop_progress will not be =
updated,
> so the root item may write 0, resulting in inconsistent drop_progress.

Same as before, we always start with DROP_REFERENCE stage, which
guarantees drop_progress and drop_level end up properly
initialized/setup.
So I still don't see a problem.

I think you need to show an exact sequence of steps that lead to a problem.

Thanks.

>
>
> >
> > So please provide an explanation on why these initializations are
> > needed and how they relate to the original problem.
> > If they are not related to the original problem, then move them into a
> > separate patch, with all the proper explanations in the changelog.
> >
> > Thanks.
> >
> >
> >>          wc->shared_level =3D -1;
> >>          wc->stage =3D DROP_REFERENCE;
> >>          wc->update_ref =3D update_ref;
> >> @@ -5659,8 +5664,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root=
, int update_ref, int for_reloc)
> >>                  }
> >>          }
> >>          btrfs_release_path(path);
> >> -       if (err)
> >> +       if (err) {
> >> +               btrfs_abort_transaction(trans, err);
> >>                  goto out_end_trans;
> >> +       }
> >>
> >>          ret =3D btrfs_del_root(trans, &root->root_key);
> >>          if (ret) {
> >> --
> >> 2.17.1
> >>
> >
>
>
> --
> Avast =E9=98=B2=E6=AF=92=E8=BB=9F=E9=AB=94=E5=B7=B2=E6=AA=A2=E6=9F=A5=E6=
=AD=A4=E5=B0=81=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E7=9A=84=E7=97=85=E6=AF=
=92=E3=80=82
> https://www.avast.com/antivirus
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
