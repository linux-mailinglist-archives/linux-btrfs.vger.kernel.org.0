Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951ED3A9CC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 15:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhFPN6G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhFPN6F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 09:58:05 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD912C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Jun 2021 06:55:57 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id p21so1904807qtw.6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Jun 2021 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=g0sVMETT/F7NDf9jL4c12dlz9ZiNZuKpYh5M976/2eU=;
        b=rBTGlPKJ5ozderoyhdfb1YJOI9cZW/4kxQ+YUNkSEK6hYq5fZ0JhOrMNWBr0vvvSU4
         1fzgKiN9qKWF6yHnICOICz1gud+gs7CH7ZzKUouLDX6i7L3dkrQxYJ9mb/JuJCFgcB4s
         k931jJMUObwgQQ3PxNjm3KqlK8ipTveJMxxjTr0lCuZqhSMipq7o1pBsfPrFv8UY6u04
         z5ir+jyPFOmBy8Q4QoLDyXGH1ktVviMZqbWKsk2qL95cjFxuHiMzIiK5hHogzQDN2kEd
         deebApndg0X7SsQxnmKb+dZuwpjBmNoA//9v8U6dfeC5q6j09zoxbPTN3WPICTHAMN0Z
         qLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=g0sVMETT/F7NDf9jL4c12dlz9ZiNZuKpYh5M976/2eU=;
        b=qOHPM0DWIIHTPEgOa8TE7BV3n23nX97e7qp1zZId0IGi2PVSibn89MuddVuc5hjdqQ
         5fvdspz5V0NHtxDmp763tTopMThBUZwrXgxnXSvPgXMlo6YU6OQUxkAZaQhbnuUC9VOo
         Bilcz0NZBpNQqYbtjF7Jgq0Bktjpax5nXWR9MgBAHuMSr9vbBHKs6UG6DX19gdcEFCpQ
         5YpvX1PADD8XgaEG5e64zuxmu5Dn9wkdOHrwq6HPkMnk1TrVl1BJIik6dy7X1faKX+Or
         XbLGoEKMT4AXc1S+tRXY768JVIvSRhGasYnpmqx6h2OdO8z+bNK86hOcZHQ+YMOhlQ5U
         4WsA==
X-Gm-Message-State: AOAM5339jnfZBUXDpUYzSTohD+V9QCGy4vRglOJZrAA6to8MygEBKVwW
        qipnzSDCDPsG7RYxWBaDkjwt7ibg3AT7yP9QPSM=
X-Google-Smtp-Source: ABdhPJxvb85Et6ipcrImtqk8YUKC/aTgY9fI7VmYG2EwaPhnJxXEswFBnad00iGZFy6L3NcVoKQL/bLvS5/KjxrbW0Q=
X-Received: by 2002:ac8:7590:: with SMTP id s16mr5254060qtq.259.1623851757105;
 Wed, 16 Jun 2021 06:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621526221.git.dsterba@suse.com> <79a09502c532bc9939645d2711c72ebad5fce2e7.1621526221.git.dsterba@suse.com>
 <CAL3q7H6P-TqtM6BkRY5_15ThVJzD54HZCdjKtdkukUqrZzh5-Q@mail.gmail.com>
In-Reply-To: <CAL3q7H6P-TqtM6BkRY5_15ThVJzD54HZCdjKtdkukUqrZzh5-Q@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 16 Jun 2021 14:55:46 +0100
Message-ID: <CAL3q7H4xwZwZaBVXjJ8n9152D39eomfKOS1j0QQBFAWn7kYUxQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] btrfs: add cancelable chunk relocation support
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 16, 2021 at 2:54 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Fri, May 21, 2021 at 9:15 PM David Sterba <dsterba@suse.com> wrote:
> >
> > Add support code that will allow canceling relocation on the chunk
> > granularity. This is different and independent of balance, that also
> > uses relocation but is a higher level operation and manages it's own
> > state and pause/cancelation requests.
> >
> > Relocation is used for resize (shrink) and device deletion so this will
> > be a common point to implement cancelation for both. The context is
> > entirely in btrfs_relocate_block_group and btrfs_recover_relocation,
> > enclosing one chunk relocation. The status bit is set and unset between
> > the chunks. As relocation can take long, the effects may not be
> > immediate and the request and actual action can slightly race.
> >
> > The fs_info::reloc_cancel_req is only supposed to be increased and does
> > not pair with decrement like fs_info::balance_cancel_req.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/ctree.h      |  9 +++++++
> >  fs/btrfs/disk-io.c    |  1 +
> >  fs/btrfs/relocation.c | 60 ++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 69 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index a142e56b6b9a..3dfc32a3ebab 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -565,6 +565,12 @@ enum {
> >          */
> >         BTRFS_FS_BALANCE_RUNNING,
> >
> > +       /*
> > +        * Indicate that relocation of a chunk has started, it's set pe=
r chunk
> > +        * and is toggled between chunks.
> > +        */
> > +       BTRFS_FS_RELOC_RUNNING,
> > +
> >         /* Indicate that the cleaner thread is awake and doing somethin=
g. */
> >         BTRFS_FS_CLEANER_RUNNING,
> >
> > @@ -871,6 +877,9 @@ struct btrfs_fs_info {
> >         struct btrfs_balance_control *balance_ctl;
> >         wait_queue_head_t balance_wait_q;
> >
> > +       /* Cancelation requests for chunk relocation */
> > +       atomic_t reloc_cancel_req;
> > +
> >         u32 data_chunk_allocations;
> >         u32 metadata_ratio;
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 8c3db9076988..93c994b78d61 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -2251,6 +2251,7 @@ static void btrfs_init_balance(struct btrfs_fs_in=
fo *fs_info)
> >         atomic_set(&fs_info->balance_cancel_req, 0);
> >         fs_info->balance_ctl =3D NULL;
> >         init_waitqueue_head(&fs_info->balance_wait_q);
> > +       atomic_set(&fs_info->reloc_cancel_req, 0);
> >  }
> >
> >  static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index b70be2ac2e9e..9b84eb86e426 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -2876,11 +2876,12 @@ int setup_extent_mapping(struct inode *inode, u=
64 start, u64 end,
> >  }
> >
> >  /*
> > - * Allow error injection to test balance cancellation
> > + * Allow error injection to test balance/relocation cancellation
> >   */
> >  noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info=
)
> >  {
> >         return atomic_read(&fs_info->balance_cancel_req) ||
> > +               atomic_read(&fs_info->reloc_cancel_req) ||
> >                 fatal_signal_pending(current);
> >  }
> >  ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
> > @@ -3780,6 +3781,47 @@ struct inode *create_reloc_inode(struct btrfs_fs=
_info *fs_info,
> >         return inode;
> >  }
> >
> > +/*
> > + * Mark start of chunk relocation that is cancelable. Check if the can=
celation
> > + * has been requested meanwhile and don't start in that case.
> > + *
> > + * Return:
> > + *   0             success
> > + *   -EINPROGRESS  operation is already in progress, that's probably a=
 bug
> > + *   -ECANCELED    cancelation request was set before the operation st=
arted
> > + */
> > +static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
> > +{
> > +       if (test_and_set_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags)) =
{
> > +               /* This should not happen */
> > +               btrfs_err(fs_info, "reloc already running, cannot start=
");
> > +               return -EINPROGRESS;
> > +       }
> > +
> > +       if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
> > +               btrfs_info(fs_info, "chunk relocation canceled on start=
");
> > +               /*
> > +                * On cancel, clear all requests but let the caller mar=
k
> > +                * the end after cleanup operations.
> > +                */
> > +               atomic_set(&fs_info->reloc_cancel_req, 0);
> > +               return -ECANCELED;
> > +       }
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Mark end of chunk relocation that is cancelable and wake any waiter=
s.
> > + */
> > +static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
> > +{
> > +       /* Requested after start, clear bit first so any waiters can co=
ntinue */
> > +       if (atomic_read(&fs_info->reloc_cancel_req) > 0)
> > +               btrfs_info(fs_info, "chunk relocation canceled during o=
peration");
> > +       clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
> > +       atomic_set(&fs_info->reloc_cancel_req, 0);
> > +}
> > +
> >  static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info =
*fs_info)
> >  {
> >         struct reloc_control *rc;
> > @@ -3862,6 +3904,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_i=
nfo *fs_info, u64 group_start)
> >                 return -ENOMEM;
> >         }
> >
> > +       ret =3D reloc_chunk_start(fs_info);
> > +       if (ret < 0) {
> > +               err =3D ret;
> > +               goto out_end;
>
> There's a bug here. At out_end we do:
>
> btrfs_put_block_group(rc->block_group);
>
> But rc->block_group was not yet assigned.

On misc-next it's actually label "out_put_bg" and under there we do
the block group put, but not on the version posted here.

>
> Thanks.
>
> > +       }
> > +
> >         rc->extent_root =3D extent_root;
> >         rc->block_group =3D bg;
> >
> > @@ -3953,6 +4001,8 @@ int btrfs_relocate_block_group(struct btrfs_fs_in=
fo *fs_info, u64 group_start)
> >                 btrfs_dec_block_group_ro(rc->block_group);
> >         iput(rc->data_inode);
> >         btrfs_put_block_group(rc->block_group);
> > +out_end:
> > +       reloc_chunk_end(fs_info);
> >         free_reloc_control(rc);
> >         return err;
> >  }
> > @@ -4073,6 +4123,12 @@ int btrfs_recover_relocation(struct btrfs_root *=
root)
> >                 goto out;
> >         }
> >
> > +       ret =3D reloc_chunk_start(fs_info);
> > +       if (ret < 0) {
> > +               err =3D ret;
> > +               goto out_end;
> > +       }
> > +
> >         rc->extent_root =3D fs_info->extent_root;
> >
> >         set_reloc_control(rc);
> > @@ -4137,6 +4193,8 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
> >                 err =3D ret;
> >  out_unset:
> >         unset_reloc_control(rc);
> > +out_end:
> > +       reloc_chunk_end(fs_info);
> >         free_reloc_control(rc);
> >  out:
> >         free_reloc_roots(&reloc_roots);
> > --
> > 2.29.2
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
