Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E636261453C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 08:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKAHtU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 03:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKAHtS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 03:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD781271E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 00:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2B4A6151B
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 07:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472B3C433D6
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 07:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667288956;
        bh=ueo7e1iSLTx3SWAhp+u6tgSIys5mARI34frVZohSy4E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mqUmFALL5jYAH90PKWJI+nbpgza1xAWLXdLxU484XPFnd1s/ly1Uf+yfbuc921Aec
         cwwFbwZrqzoqZK4+Br4MfBADtlp4kUM6BHNeD0iWJsazWiG0q7MUOkAtoO9zcEsHCl
         q7SR197nQiRs7qbJIxq9GIE8nch0E1sLOnTzw1vJQ3xHwwcoXhQUSI2z6XmOtUXF/T
         DDHlZFVgrDGyWrsDlcZZ4/FgywZoQidiyeRG/c6KVCGHGM94wMAZUnR8Dpfao8DuEv
         Bf/3rR+1CLkyXUlqJD89yg+7IJzMGmjVTKY6/HiD6UcoqIL/eqB7toFOe7j7yD9knm
         +PzQ0acZCaYsA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13ae8117023so15988383fac.9
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 00:49:16 -0700 (PDT)
X-Gm-Message-State: ACrzQf0VOTmHKdLx5kLSqdmzKokOWwgCu4jWU6dlHC5d4AOuJxGSNrwG
        KmD6jKJ9+HKryusHTMmsfSLcn80GrSXcZ0VmiZI=
X-Google-Smtp-Source: AMsMyM5L2cq0FgiD7MnsSPMsIfqxlR+MNJwqSHM9uj2vx1HpqSTtkLerlkH1VgEsYetJQq1c8dJVyxP8YjkFqArLPsM=
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id
 l18-20020a056870205200b0013207b22fe6mr10419009oad.98.1667288955364; Tue, 01
 Nov 2022 00:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1667215075.git.fdmanana@suse.com> <84cb2eb28538c98cbde50e83a770de476528a4f1.1667215075.git.fdmanana@suse.com>
 <20221101084953.50DF.409509F4@e16-tech.com>
In-Reply-To: <20221101084953.50DF.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 1 Nov 2022 07:48:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H58E+FjjGdhB=wZ60iNr-VWC2rh7p+ipJYBpCzh+dKWLg@mail.gmail.com>
Message-ID: <CAL3q7H58E+FjjGdhB=wZ60iNr-VWC2rh7p+ipJYBpCzh+dKWLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix lost file sync on direct IO write with
 nowait and dsync iocb
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 1, 2022 at 1:05 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When doing a direct IO write using a iocb with nowait and dsync set, we
> > end up not syncing the file once the write completes.
> >
> > This is because we tell iomap to not call generic_write_sync(), which
> > would result in calling btrfs_sync_file(), in order to avoid a deadlock
> > since iomap can call it while we are holding the inode's lock and
> > btrfs_sync_file() needs to acquire the inode's lock. The deadlock happe=
ns
> > only if the write happens synchronously, when iomap_dio_rw() calls
> > iomap_dio_complete() before it returns. Instead we do the sync ourselve=
s
> > at btrfs_do_write_iter().
> >
> > For a nowait write however we can end up not doing the sync ourselves a=
t
> > at btrfs_do_write_iter() because the write could have been queued, and
> > therefore we get -EIOCBQUEUED returned from iomap in such case. That ma=
kes
> > us skip the sync call at btrfs_do_write_iter(), as we don't do it for
> > any error returned from btrfs_direct_write(). We can't simply do the ca=
ll
> > even if -EIOCBQUEUED is returned, since that would block the task waiti=
ng
> > for IO, both for the data since there are bios still in progress as wel=
l
> > as potentially blocking when joining a log transaction and when syncing
> > the log (writing log trees, super blocks, etc).
> >
> > So let iomap do the sync call itself and in order to avoid deadlocks fo=
r
> > the case of synchronous writes (without nowait), use __iomap_dio_rw() a=
nd
> > have ourselves call iomap_dio_complete() after unlocking the inode.
> >
> > A test case will later be sent for fstests, after this is fixed in Linu=
s'
> > tree.
> >
> > Fixes: 51bd9563b678 ("btrfs: fix deadlock due to page faults during dir=
ect IO reads and writes")
> > Reported-by: =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=
=B1=D0=B5=D1=80=D0=B3 <socketpair@gmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/CAEmTpZGRKbzc16fWPvxbr6AfFsQo=
Lmz-Lcg-7OgJOZDboJ+SGQ@mail.gmail.com/
> > CC: stable@vger.kernel.org # 6.0+
>
> The test script provided by =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=
=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 <socketpair@gmail.com>
> show a normal result on 6.1.0-rc3+ with this patch.
>
> but the test script provided by =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=
=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 show that
> there is a problem in 5.15.y too. we need a different fix for 5.15.y?

Yes, I forgot Anand actually backported it to 5.15.
It will need a different (but similar) fix due to some cleanups that
happened on 5.19 or 6.0.

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/11/01
>
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/btrfs_inode.h |  5 ++++-
> >  fs/btrfs/file.c        | 22 ++++++++++++++++------
> >  fs/btrfs/inode.c       | 14 +++++++++++---
> >  3 files changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > index 79a9f06c2434..d21c30bf7053 100644
> > --- a/fs/btrfs/btrfs_inode.h
> > +++ b/fs/btrfs/btrfs_inode.h
> > @@ -526,7 +526,10 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, str=
uct iov_iter *iter,
> >  ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *fr=
om,
> >                              const struct btrfs_ioctl_encoded_io_args *=
encoded);
> >
> > -ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t=
 done_before);
> > +ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
> > +                    size_t done_before);
> > +struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter =
*iter,
> > +                               size_t done_before);
> >
> >  extern const struct dentry_operations btrfs_dentry_operations;
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 838b3c0ea329..6e2889bc73d8 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1453,6 +1453,7 @@ static ssize_t btrfs_direct_write(struct kiocb *i=
ocb, struct iov_iter *from)
> >       loff_t endbyte;
> >       ssize_t err;
> >       unsigned int ilock_flags =3D 0;
> > +     struct iomap_dio *dio;
> >
> >       if (iocb->ki_flags & IOCB_NOWAIT)
> >               ilock_flags |=3D BTRFS_ILOCK_TRY;
> > @@ -1513,11 +1514,22 @@ static ssize_t btrfs_direct_write(struct kiocb =
*iocb, struct iov_iter *from)
> >        * So here we disable page faults in the iov_iter and then retry =
if we
> >        * got -EFAULT, faulting in the pages before the retry.
> >        */
> > -again:
> >       from->nofault =3D true;
> > -     err =3D btrfs_dio_rw(iocb, from, written);
> > +     dio =3D btrfs_dio_write(iocb, from, written);
> >       from->nofault =3D false;
> >
> > +     /*
> > +      * iomap_dio_complete() will call btrfs_sync_file() if we have a =
dsync
> > +      * iocb, and that needs to lock the inode. So unlock it before ca=
lling
> > +      * iomap_dio_complete() to avoid a deadlock.
> > +      */
> > +     btrfs_inode_unlock(inode, ilock_flags);
> > +
> > +     if (IS_ERR_OR_NULL(dio))
> > +             err =3D PTR_ERR_OR_ZERO(dio);
> > +     else
> > +             err =3D iomap_dio_complete(dio);
> > +
> >       /* No increment (+=3D) because iomap returns a cumulative value. =
*/
> >       if (err > 0)
> >               written =3D err;
> > @@ -1543,12 +1555,10 @@ static ssize_t btrfs_direct_write(struct kiocb =
*iocb, struct iov_iter *from)
> >               } else {
> >                       fault_in_iov_iter_readable(from, left);
> >                       prev_left =3D left;
> > -                     goto again;
> > +                     goto relock;
> >               }
> >       }
> >
> > -     btrfs_inode_unlock(inode, ilock_flags);
> > -
> >       /*
> >        * If 'err' is -ENOTBLK or we have not written all data, then it =
means
> >        * we must fallback to buffered IO.
> > @@ -3752,7 +3762,7 @@ static ssize_t btrfs_direct_read(struct kiocb *io=
cb, struct iov_iter *to)
> >        */
> >       pagefault_disable();
> >       to->nofault =3D true;
> > -     ret =3D btrfs_dio_rw(iocb, to, read);
> > +     ret =3D btrfs_dio_read(iocb, to, read);
> >       to->nofault =3D false;
> >       pagefault_enable();
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index fd26282edace..b1e7bfd5f525 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -8176,13 +8176,21 @@ static const struct iomap_dio_ops btrfs_dio_ops=
 =3D {
> >       .bio_set                =3D &btrfs_dio_bioset,
> >  };
> >
> > -ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t=
 done_before)
> > +ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size=
_t done_before)
> >  {
> >       struct btrfs_dio_data data;
> >
> >       return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_=
ops,
> > -                         IOMAP_DIO_PARTIAL | IOMAP_DIO_NOSYNC,
> > -                         &data, done_before);
> > +                         IOMAP_DIO_PARTIAL, &data, done_before);
> > +}
> > +
> > +struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter =
*iter,
> > +                               size_t done_before)
> > +{
> > +     struct btrfs_dio_data data;
> > +
> > +     return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_di=
o_ops,
> > +                         IOMAP_DIO_PARTIAL, &data, done_before);
> >  }
> >
> >  static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info=
 *fieinfo,
> > --
> > 2.35.1
>
>
