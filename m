Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601A214D939
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 11:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgA3KqZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 05:46:25 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44099 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KqY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 05:46:24 -0500
Received: by mail-ua1-f65.google.com with SMTP id x16so969054uao.11
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 02:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=x9Nw8sCDAT61gESIgEWNfBqu1lf6ZjRFYj/LZnOdQvQ=;
        b=cfRsLpnKRe+J7mTZmeD0yhIq2E7S1zL4seQeVpxvG8Sdp/0sieegr4WEc4JBQqsK08
         3WnTvVndSqmpWcW0kFGSFNkpEMklwsb6xwNMVMNJgVAipyvx03I5XkfHJkF5t9MfhlCb
         S+4Fk45H+/BIu3z7a8nnpB/GTzR/oMPNNJvhxPAyYhZ6u7aukWHISsJEDbhgwMt7oZ2d
         xKCy811Ft/WxD9KjUgc6pvCevwPjQcrXXUsrDJ1o4ADwZGvh/rhX6bywgm2GEO07EHd7
         YwgsIm606d49QwAUxONrXwFtw5UKCSWo7UP2ndjH2rWf9PIh2i3hxQorDsnmSmbQ91Ek
         apcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=x9Nw8sCDAT61gESIgEWNfBqu1lf6ZjRFYj/LZnOdQvQ=;
        b=nHFQYK7l0eBVPkym9FzRGp78CzM4PKOeL65IB4WyliaWE0jBOPzLyaMsyU7JMMbayK
         BXs3pbkSzzIfuv46xvPQtz3EHpGv8oGwQzanQLEiUSlHSu42m8FcW7ZlAOUSSutlKFmY
         gH+JRxz9GL2Pv5OtmvAJRdqOil+G0kjtAhnOvWJs5oG3ZeP0grKbpgxiQV4MwI3xWmFV
         dIgdxKpr28pHJ8LquCvK3EWiepJ/sgMX8kVjKpyNM8ce5SWsY7u9SUXvRq4Q7cdS6EKd
         SmFALG4jlUyIfmzsL0SRfjjjNaVPYKEK5JQOtXFuGeJ9a5nDp69PXffv7NC/WNAPQl1H
         r9cA==
X-Gm-Message-State: APjAAAXFOF3PSltgOCVZLDVVkn/hM+K68Bx5xMREXd/GTcdE5YMX7WGj
        FWg1uxceTURNeTyzKgxUUe/L/DiIHkRM4jcR93e+sw==
X-Google-Smtp-Source: APXvYqzI/0OUB1N5pWR72Nu2d/oNWGJhc8afmuKypxiMcMueTfH1QejHYIdRqFpXJ0+izYl/mXFa0RvfI2vYDQJ/FLM=
X-Received: by 2002:ab0:18a1:: with SMTP id t33mr2239059uag.123.1580381182923;
 Thu, 30 Jan 2020 02:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20200130052822.11765-1-wqu@suse.com> <CAL3q7H4ODcwn7LVm=P3BBL7zd3wGRB_Vtr_KNk_2MysNNwgqcQ@mail.gmail.com>
 <8341b76f-bcbe-f2b9-d8b0-cfcd0006a47c@gmx.com>
In-Reply-To: <8341b76f-bcbe-f2b9-d8b0-cfcd0006a47c@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 30 Jan 2020 10:46:12 +0000
Message-ID: <CAL3q7H6Ueu0v8tzozci-dj4s3rTGx78jAGUrcYomZPAZ+6_MsA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Allow btrfs_truncate_block() to fallback to nocow
 for data space reservation
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Martin Doucha <martin.doucha@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 10:36 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/1/30 =E4=B8=8B=E5=8D=886:02, Filipe Manana wrote:
> > On Thu, Jan 30, 2020 at 5:30 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG]
> >> When the data space is exhausted, even the inode has NOCOW attribute,
> >> btrfs will still refuse to truncate unaligned range due to ENOSPC.
> >>
> >> The following script can reproduce it pretty easily:
> >>   #!/bin/bash
> >>
> >>   dev=3D/dev/test/test
> >>   mnt=3D/mnt/btrfs
> >>
> >>   umount $dev &> /dev/null
> >>   umount $mnt&> /dev/null
> >>
> >>   mkfs.btrfs -f $dev -b 1G
> >>   mount -o nospace_cache $dev $mnt
> >>   touch $mnt/foobar
> >>   chattr +C $mnt/foobar
> >>
> >>   xfs_io -f -c "pwrite -b 4k 0 4k" $mnt/foobar > /dev/null
> >>   xfs_io -f -c "pwrite -b 4k 0 1G" $mnt/padding &> /dev/null
> >>   sync
> >>
> >>   xfs_io -c "fpunch 0 2k" $mnt/foobar
> >>   umount $mnt
> >>
> >> Current btrfs will fail at the fpunch part.
> >>
> >> [CAUSE]
> >> Because btrfs_truncate_block() always reserve space without checking t=
he
> >> NOCOW attribute.
> >>
> >> Since the writeback path follows NOCOW bit, we only need to bother the
> >> space reservation code in btrfs_truncate_block().
> >>
> >> [FIX]
> >> Make btrfs_truncate_block() to follow btrfs_buffered_write() to try to
> >> reserve data space first, and falls back to NOCOW check only when we
> >> don't have enough space.
> >>
> >> Such always-try-reserve is an optimization introduced in
> >> btrfs_buffered_write(), to avoid expensive btrfs_check_can_nocow() cal=
l.
> >>
> >> Since now check_can_nocow() is needed outside of inode.c, also export =
it
> >> and rename it to btrfs_check_can_nocow().
> >>
> >> Reported-by: Martin Doucha <martin.doucha@suse.com>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Test case will be submitted to fstests by the reporter.
> >
> > Well, this is a sudden change of mind, isn't it? :)
> >
> > We had btrfs/172, which you removed very recently, that precisely teste=
d this:
> >
> > https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3D538=
d8a4bcc782258f8f95fae815d5e859dee9126
>
> I didn't notice the nodatacow mount option. Super duper big facepalm.
>
> All my bad, especially feel sorry for Anand.
>
> With nodatacow mount option there, that test case in fact makes a lot of
> sense.
> Sorry again for that.
>
> Anand, mind to resubmit it to generic group?

Why the generic group?
The nodatacow mount option is btrfs specific, and most filesystems
don't support chattr +C (ext4 for example).

>
> Thanks,
> Qu
>
> >
> > Even though there are several reasons why this can still fail (at
> > writeback time), like regular buffered writes through the family of
> > write() syscalls can, I think it's perfectly fine to have this
> > behaviour.
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > So I think we can just resurrect btrfs/172 now...
> >
> >> ---
> >>  fs/btrfs/ctree.h |  2 ++
> >>  fs/btrfs/file.c  | 10 +++++-----
> >>  fs/btrfs/inode.c | 41 ++++++++++++++++++++++++++++++++++-------
> >>  3 files changed, 41 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> >> index 54efb21c2727..b5639f3461e4 100644
> >> --- a/fs/btrfs/ctree.h
> >> +++ b/fs/btrfs/ctree.h
> >> @@ -2954,6 +2954,8 @@ int btrfs_fdatawrite_range(struct inode *inode, =
loff_t start, loff_t end);
> >>  loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
> >>                               struct file *file_out, loff_t pos_out,
> >>                               loff_t len, unsigned int remap_flags);
> >> +int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
> >> +                         size_t *write_bytes);
> >>
> >>  /* tree-defrag.c */
> >>  int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
> >> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> >> index 8d47c76b7bd1..8dc084600f4e 100644
> >> --- a/fs/btrfs/file.c
> >> +++ b/fs/btrfs/file.c
> >> @@ -1544,8 +1544,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_ino=
de *inode, struct page **pages,
> >>         return ret;
> >>  }
> >>
> >> -static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t=
 pos,
> >> -                                   size_t *write_bytes)
> >> +int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
> >> +                         size_t *write_bytes)
> >>  {
> >>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >>         struct btrfs_root *root =3D inode->root;
> >> @@ -1645,8 +1645,8 @@ static noinline ssize_t btrfs_buffered_write(str=
uct kiocb *iocb,
> >>                 if (ret < 0) {
> >>                         if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODA=
TACOW |
> >>                                                       BTRFS_INODE_PREA=
LLOC)) &&
> >> -                           check_can_nocow(BTRFS_I(inode), pos,
> >> -                                       &write_bytes) > 0) {
> >> +                           btrfs_check_can_nocow(BTRFS_I(inode), pos,
> >> +                                                 &write_bytes) > 0) {
> >>                                 /*
> >>                                  * For nodata cow case, no need to res=
erve
> >>                                  * data space.
> >> @@ -1923,7 +1923,7 @@ static ssize_t btrfs_file_write_iter(struct kioc=
b *iocb,
> >>                  */
> >>                 if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
> >>                                               BTRFS_INODE_PREALLOC)) |=
|
> >> -                   check_can_nocow(BTRFS_I(inode), pos, &count) <=3D =
0) {
> >> +                   btrfs_check_can_nocow(BTRFS_I(inode), pos, &count)=
 <=3D 0) {
> >>                         inode_unlock(inode);
> >>                         return -EAGAIN;
> >>                 }
> >> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >> index 5509c41a4f43..b5ae4bbf1ad4 100644
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -4974,11 +4974,13 @@ int btrfs_truncate_block(struct inode *inode, =
loff_t from, loff_t len,
> >>         struct extent_state *cached_state =3D NULL;
> >>         struct extent_changeset *data_reserved =3D NULL;
> >>         char *kaddr;
> >> +       bool only_release_metadata =3D false;
> >>         u32 blocksize =3D fs_info->sectorsize;
> >>         pgoff_t index =3D from >> PAGE_SHIFT;
> >>         unsigned offset =3D from & (blocksize - 1);
> >>         struct page *page;
> >>         gfp_t mask =3D btrfs_alloc_write_mask(mapping);
> >> +       size_t write_bytes =3D blocksize;
> >>         int ret =3D 0;
> >>         u64 block_start;
> >>         u64 block_end;
> >> @@ -4990,11 +4992,26 @@ int btrfs_truncate_block(struct inode *inode, =
loff_t from, loff_t len,
> >>         block_start =3D round_down(from, blocksize);
> >>         block_end =3D block_start + blocksize - 1;
> >>
> >> -       ret =3D btrfs_delalloc_reserve_space(inode, &data_reserved,
> >> -                                          block_start, blocksize);
> >> -       if (ret)
> >> +       ret =3D btrfs_check_data_free_space(inode, &data_reserved, blo=
ck_start,
> >> +                                         blocksize);
> >> +       if (ret < 0) {
> >> +               if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
> >> +                                             BTRFS_INODE_PREALLOC)) &=
&
> >> +                   btrfs_check_can_nocow(BTRFS_I(inode), block_start,
> >> +                                         &write_bytes) > 0) {
> >> +                       /* For nocow case, no need to reserve data spa=
ce. */
> >> +                       only_release_metadata =3D true;
> >> +               } else {
> >> +                       goto out;
> >> +               }
> >> +       }
> >> +       ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode), blocks=
ize);
> >> +       if (ret < 0) {
> >> +               if (!only_release_metadata)
> >> +                       btrfs_free_reserved_data_space(inode, data_res=
erved,
> >> +                                       block_start, blocksize);
> >>                 goto out;
> >> -
> >> +       }
> >>  again:
> >>         page =3D find_or_create_page(mapping, index, mask);
> >>         if (!page) {
> >> @@ -5063,10 +5080,20 @@ int btrfs_truncate_block(struct inode *inode, =
loff_t from, loff_t len,
> >>         set_page_dirty(page);
> >>         unlock_extent_cached(io_tree, block_start, block_end, &cached_=
state);
> >>
> >> +       if (only_release_metadata)
> >> +               set_extent_bit(&BTRFS_I(inode)->io_tree, block_start,
> >> +                               block_end, EXTENT_NORESERVE, NULL, NUL=
L,
> >> +                               GFP_NOFS);
> >> +
> >>  out_unlock:
> >> -       if (ret)
> >> -               btrfs_delalloc_release_space(inode, data_reserved, blo=
ck_start,
> >> -                                            blocksize, true);
> >> +       if (ret) {
> >> +               if (!only_release_metadata)
> >> +                       btrfs_delalloc_release_space(inode, data_reser=
ved,
> >> +                                       block_start, blocksize, true);
> >> +               else
> >> +                       btrfs_delalloc_release_metadata(BTRFS_I(inode)=
,
> >> +                                       blocksize, true);
> >
> > I usually find it more intuitive to have it the other way around:
> >
> > if (only_release_metadata)
> >   ...
> > else
> >   ...
> >
> > E.g., positive case first, negative in the else branch. But that's
> > likely too much of a personal preference.
> >
> > Thanks.
> >
> >> +       }
> >>         btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);
> >>         unlock_page(page);
> >>         put_page(page);
> >> --
> >> 2.25.0
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
