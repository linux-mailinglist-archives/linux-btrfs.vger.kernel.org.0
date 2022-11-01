Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99393614543
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 08:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKAHyP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 03:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAHyN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 03:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0720FF0
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 00:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EA2A61551
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 07:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE2CC433C1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 07:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667289251;
        bh=dEl0lBfBNgIja9aUXm/JKNpmzRQFL7JM/SCTKpQRyQE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dhJWSO345YOyBGphLgIPMMQPCs+o15iet8v1nmkQ/SgnN81USDeuIDQJO4bizBUCs
         Oh41oA/bx1e1NnMt6yr1rSP+wdvW0xMriet1KV6M7njyPCE2RgItoEGPwhUvN7EZOo
         tlYoBPTEqYX2OQXvR4c2psYSioNFT292fWYIK2ixEmNnwj6Y17e194hD5418Gvf/ce
         NW0LZzg7BV0G2XIWhS0Xy4j3qrPAe5SnJ+CyYhkQzlBpKRSWsdieVcJ/+ipk/lDZUd
         6BCodZaum0VxTpBXvWEtOgvXqfrU8lte34vlzhq9TSH0dzbt8mtRfMBq82Uc0Pds0+
         xk5Czqei2YJdw==
Received: by mail-oi1-f172.google.com with SMTP id r76so8628162oie.13
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 00:54:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf0mxLm8XZfgBMTRHkre4P8VTygjn/qt9VTU/6wfUJ4mPIsZeTet
        Vw/3HzfB/pPhoCwvnoVNsOOmekDNdYJGvMR08Ug=
X-Google-Smtp-Source: AMsMyM4TbJFQYmgkiyqe2Tj6E2gDi3Qq4r51zuN3ZF6aHwrPmq1bkVOCwyMVO5iqVBTJDN3xiY4JUkZ/xrVuW9cwqes=
X-Received: by 2002:a05:6808:1691:b0:351:48da:62e0 with SMTP id
 bb17-20020a056808169100b0035148da62e0mr9320921oib.98.1667289250695; Tue, 01
 Nov 2022 00:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <84cb2eb28538c98cbde50e83a770de476528a4f1.1667215075.git.fdmanana@suse.com>
 <20221101084953.50DF.409509F4@e16-tech.com> <20221101090450.50E3.409509F4@e16-tech.com>
In-Reply-To: <20221101090450.50E3.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 1 Nov 2022 07:53:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7xZCB3B7kYgXtUTQa0mhFB7i=m_O6tJ425qxyYN_U7aQ@mail.gmail.com>
Message-ID: <CAL3q7H7xZCB3B7kYgXtUTQa0mhFB7i=m_O6tJ425qxyYN_U7aQ@mail.gmail.com>
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

On Tue, Nov 1, 2022 at 1:31 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> > Hi,
> >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > When doing a direct IO write using a iocb with nowait and dsync set, =
we
> > > end up not syncing the file once the write completes.
> > >
> > > This is because we tell iomap to not call generic_write_sync(), which
> > > would result in calling btrfs_sync_file(), in order to avoid a deadlo=
ck
> > > since iomap can call it while we are holding the inode's lock and
> > > btrfs_sync_file() needs to acquire the inode's lock. The deadlock hap=
pens
> > > only if the write happens synchronously, when iomap_dio_rw() calls
> > > iomap_dio_complete() before it returns. Instead we do the sync oursel=
ves
> > > at btrfs_do_write_iter().
> > >
> > > For a nowait write however we can end up not doing the sync ourselves=
 at
> > > at btrfs_do_write_iter() because the write could have been queued, an=
d
> > > therefore we get -EIOCBQUEUED returned from iomap in such case. That =
makes
> > > us skip the sync call at btrfs_do_write_iter(), as we don't do it for
> > > any error returned from btrfs_direct_write(). We can't simply do the =
call
> > > even if -EIOCBQUEUED is returned, since that would block the task wai=
ting
> > > for IO, both for the data since there are bios still in progress as w=
ell
> > > as potentially blocking when joining a log transaction and when synci=
ng
> > > the log (writing log trees, super blocks, etc).
> > >
> > > So let iomap do the sync call itself and in order to avoid deadlocks =
for
> > > the case of synchronous writes (without nowait), use __iomap_dio_rw()=
 and
> > > have ourselves call iomap_dio_complete() after unlocking the inode.
> > >
> > > A test case will later be sent for fstests, after this is fixed in Li=
nus'
> > > tree.
> > >
> > > Fixes: 51bd9563b678 ("btrfs: fix deadlock due to page faults during d=
irect IO reads and writes")
> > > Reported-by: =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=B5=D0=BD=
=D0=B1=D0=B5=D1=80=D0=B3 <socketpair@gmail.com>
> > > Link: https://lore.kernel.org/linux-btrfs/CAEmTpZGRKbzc16fWPvxbr6AfFs=
QoLmz-Lcg-7OgJOZDboJ+SGQ@mail.gmail.com/
> > > CC: stable@vger.kernel.org # 6.0+
> >
> > The test script provided by =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=
=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 <socketpair@gmail.com>
> > show a normal result on 6.1.0-rc3+ with this patch.
> >
> > but the test script provided by =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=
=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 show that
> > there is a problem in 5.15.y too. we need a different fix for 5.15.y?
>
> a dirty fix will let the test script provided by =D0=9C=D0=B0=D1=80=D0=BA=
 =D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5
> show a normal result on 5.15.y. but I don't know whether this dirty fix
> is right.
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index bd05a8f..42b2d20 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2109,7 +2109,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *=
iocb,
>
>         btrfs_set_inode_last_sub_trans(inode);
>
> -       if (num_written > 0)
> +       if (num_written > 0 || sync)
>                 num_written =3D generic_write_sync(iocb, num_written);

Nop. If it were that simple, I would have done similar for 6.0, 6.1
and misc-next.

If we are in a nowait context we shouldn't block, and
generic_write_sync() will trigger fsync which can
block for many reasons - one of them is blocking for IO to complete.

The call to generic_write_sync() must happen when the bios complete in
case of async IO.

What you did will work, since fsync will wait for the ordered extent
to complete, but it is wrong
because when we are in nowait context we shouldn't block.

Thanks.

>
>         if (sync)
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/11/01
>
> >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/btrfs_inode.h |  5 ++++-
> > >  fs/btrfs/file.c        | 22 ++++++++++++++++------
> > >  fs/btrfs/inode.c       | 14 +++++++++++---
> > >  3 files changed, 31 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > > index 79a9f06c2434..d21c30bf7053 100644
> > > --- a/fs/btrfs/btrfs_inode.h
> > > +++ b/fs/btrfs/btrfs_inode.h
> > > @@ -526,7 +526,10 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, s=
truct iov_iter *iter,
> > >  ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *=
from,
> > >                            const struct btrfs_ioctl_encoded_io_args *=
encoded);
> > >
> > > -ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size=
_t done_before);
> > > +ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
> > > +                  size_t done_before);
> > > +struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_ite=
r *iter,
> > > +                             size_t done_before);
> > >
> > >  extern const struct dentry_operations btrfs_dentry_operations;
> > >
> > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > index 838b3c0ea329..6e2889bc73d8 100644
> > > --- a/fs/btrfs/file.c
> > > +++ b/fs/btrfs/file.c
> > > @@ -1453,6 +1453,7 @@ static ssize_t btrfs_direct_write(struct kiocb =
*iocb, struct iov_iter *from)
> > >     loff_t endbyte;
> > >     ssize_t err;
> > >     unsigned int ilock_flags =3D 0;
> > > +   struct iomap_dio *dio;
> > >
> > >     if (iocb->ki_flags & IOCB_NOWAIT)
> > >             ilock_flags |=3D BTRFS_ILOCK_TRY;
> > > @@ -1513,11 +1514,22 @@ static ssize_t btrfs_direct_write(struct kioc=
b *iocb, struct iov_iter *from)
> > >      * So here we disable page faults in the iov_iter and then retry =
if we
> > >      * got -EFAULT, faulting in the pages before the retry.
> > >      */
> > > -again:
> > >     from->nofault =3D true;
> > > -   err =3D btrfs_dio_rw(iocb, from, written);
> > > +   dio =3D btrfs_dio_write(iocb, from, written);
> > >     from->nofault =3D false;
> > >
> > > +   /*
> > > +    * iomap_dio_complete() will call btrfs_sync_file() if we have a =
dsync
> > > +    * iocb, and that needs to lock the inode. So unlock it before ca=
lling
> > > +    * iomap_dio_complete() to avoid a deadlock.
> > > +    */
> > > +   btrfs_inode_unlock(inode, ilock_flags);
> > > +
> > > +   if (IS_ERR_OR_NULL(dio))
> > > +           err =3D PTR_ERR_OR_ZERO(dio);
> > > +   else
> > > +           err =3D iomap_dio_complete(dio);
> > > +
> > >     /* No increment (+=3D) because iomap returns a cumulative value. =
*/
> > >     if (err > 0)
> > >             written =3D err;
> > > @@ -1543,12 +1555,10 @@ static ssize_t btrfs_direct_write(struct kioc=
b *iocb, struct iov_iter *from)
> > >             } else {
> > >                     fault_in_iov_iter_readable(from, left);
> > >                     prev_left =3D left;
> > > -                   goto again;
> > > +                   goto relock;
> > >             }
> > >     }
> > >
> > > -   btrfs_inode_unlock(inode, ilock_flags);
> > > -
> > >     /*
> > >      * If 'err' is -ENOTBLK or we have not written all data, then it =
means
> > >      * we must fallback to buffered IO.
> > > @@ -3752,7 +3762,7 @@ static ssize_t btrfs_direct_read(struct kiocb *=
iocb, struct iov_iter *to)
> > >      */
> > >     pagefault_disable();
> > >     to->nofault =3D true;
> > > -   ret =3D btrfs_dio_rw(iocb, to, read);
> > > +   ret =3D btrfs_dio_read(iocb, to, read);
> > >     to->nofault =3D false;
> > >     pagefault_enable();
> > >
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index fd26282edace..b1e7bfd5f525 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -8176,13 +8176,21 @@ static const struct iomap_dio_ops btrfs_dio_o=
ps =3D {
> > >     .bio_set                =3D &btrfs_dio_bioset,
> > >  };
> > >
> > > -ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size=
_t done_before)
> > > +ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, si=
ze_t done_before)
> > >  {
> > >     struct btrfs_dio_data data;
> > >
> > >     return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_=
ops,
> > > -                       IOMAP_DIO_PARTIAL | IOMAP_DIO_NOSYNC,
> > > -                       &data, done_before);
> > > +                       IOMAP_DIO_PARTIAL, &data, done_before);
> > > +}
> > > +
> > > +struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_ite=
r *iter,
> > > +                             size_t done_before)
> > > +{
> > > +   struct btrfs_dio_data data;
> > > +
> > > +   return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_di=
o_ops,
> > > +                       IOMAP_DIO_PARTIAL, &data, done_before);
> > >  }
> > >
> > >  static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_in=
fo *fieinfo,
> > > --
> > > 2.35.1
> >
>
>
