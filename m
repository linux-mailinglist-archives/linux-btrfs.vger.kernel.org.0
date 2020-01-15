Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDDB13CAAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 18:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgAOROG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 12:14:06 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37787 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgAOROF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 12:14:05 -0500
Received: by mail-ua1-f66.google.com with SMTP id h32so6544793uah.4
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=SVMEKKS/rLCdhWvOUTeXhABG8+65OKTNIT6/v8KCgsg=;
        b=bRLzbWf9YRy8XnfwPqDj3aFD8fe0WCf5tN/GCDIBMrW6LZkJBBUg91pe1a/csWIbve
         LwAnasQZZjAC3QQHZtMCGnKWEjihLh7Zpv3/X1YaBY5bGN4FY8LpNq9h3ewJjgHMfeOM
         2WkIiTkVO3Jo8VzFRFM1RkUedcTJSbjN/r58mMYSVb8xem/VKxaf7qgfwhD3RJwjCUWX
         Fua3Fc5lqInq2svBZI/FkQuEIau+kv440m5G4dSeR6CT+QWTFVnxfTbhNJZDVj3kAI9d
         ndSFB9qn7bO5zHjj0sUQS1Jewvf3zlvv/Ea/B7u5nKFnKwEgsj2oBfXx9XCPcOxNadld
         yYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=SVMEKKS/rLCdhWvOUTeXhABG8+65OKTNIT6/v8KCgsg=;
        b=AAM40AD8AQ2PxHjmUFvr2h/14IhAvo6bWQlY03WLG/jK5bUlASCVnPri0NQI1byif/
         osPCczU9QnNBjEG5qXjYEEnXZ0DzgLuZ0cmrK0V2vVmXcJ/bypnPH6hjgU7z1sGXAEXp
         qf8B7iIkvGpZnUaC5CHV9lhZUj6d/HxFTdOfEWgx8tB5eNz2kdixQrP+fWCcYj0nqtlK
         cdFSS89RBS4g++sN7zZFe21C/GvCEVkDtWD0qg1pd7o/t8jSDexJg1jmn//9qzva8Spl
         O6EEeRErS+DkGxvmgJ+RtMRQ0E+l+nFsvOwNb/QGkMDum1/N9dldJ/WOMQ27v6ix8mR1
         8IDQ==
X-Gm-Message-State: APjAAAU21R4fg8JFg9/W9RNB8rEWD62UQq5ahEzn8vWcA+wMr2GXHflb
        6Xyu5jzZfmRmW5jWnskCNUGoGpdhwJcBIS9exFU=
X-Google-Smtp-Source: APXvYqzaPCmP1IHuHKLZojZ0LRjLuCZ0yLr8e+p1ArX16m09bCtDTTYitjoF1E2RJCD4zeaOXubwD5nl2wjex/z3mdU=
X-Received: by 2002:ab0:2a93:: with SMTP id h19mr14885281uar.27.1579108443990;
 Wed, 15 Jan 2020 09:14:03 -0800 (PST)
MIME-Version: 1.0
References: <20200107194237.145694-1-josef@toxicpanda.com> <20200107194237.145694-6-josef@toxicpanda.com>
In-Reply-To: <20200107194237.145694-6-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 Jan 2020 17:13:53 +0000
Message-ID: <CAL3q7H4B94tcog2t_QsU0j6v4cRjnWn8zwbGqrcXL9Po2_hLEw@mail.gmail.com>
Subject: Re: [PATCH 5/5] btrfs: delete the ordered isize update code
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 7, 2020 at 7:43 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Now that we have a safe way to update the isize, remove all of this code
> as it's no longer needed.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ordered-data.c      | 128 -----------------------------------
>  fs/btrfs/ordered-data.h      |   7 --
>  include/trace/events/btrfs.h |   1 -
>  3 files changed, 136 deletions(-)
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 3a3c648bb9d3..b8de2aea36b3 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -791,134 +791,6 @@ btrfs_lookup_first_ordered_extent(struct inode *ino=
de, u64 file_offset)
>         return entry;
>  }
>
> -/*
> - * After an extent is done, call this to conditionally update the on dis=
k
> - * i_size.  i_size is updated to cover any fully written part of the fil=
e.
> - */
> -int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
> -                               struct btrfs_ordered_extent *ordered)
> -{
> -       struct btrfs_ordered_inode_tree *tree =3D &BTRFS_I(inode)->ordere=
d_tree;
> -       u64 disk_i_size;
> -       u64 new_i_size;
> -       u64 i_size =3D i_size_read(inode);
> -       struct rb_node *node;
> -       struct rb_node *prev =3D NULL;
> -       struct btrfs_ordered_extent *test;
> -       int ret =3D 1;
> -       u64 orig_offset =3D offset;
> -
> -       spin_lock_irq(&tree->lock);
> -       if (ordered) {
> -               offset =3D entry_end(ordered);
> -               if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags))
> -                       offset =3D min(offset,
> -                                    ordered->file_offset +
> -                                    ordered->truncated_len);
> -       } else {
> -               offset =3D ALIGN(offset, btrfs_inode_sectorsize(inode));
> -       }
> -       disk_i_size =3D BTRFS_I(inode)->disk_i_size;
> -
> -       /*
> -        * truncate file.
> -        * If ordered is not NULL, then this is called from endio and
> -        * disk_i_size will be updated by either truncate itself or any
> -        * in-flight IOs which are inside the disk_i_size.
> -        *
> -        * Because btrfs_setsize() may set i_size with disk_i_size if tru=
ncate
> -        * fails somehow, we need to make sure we have a precise disk_i_s=
ize by
> -        * updating it as usual.
> -        *
> -        */
> -       if (!ordered && disk_i_size > i_size) {
> -               BTRFS_I(inode)->disk_i_size =3D orig_offset;
> -               ret =3D 0;
> -               goto out;
> -       }
> -
> -       /*
> -        * if the disk i_size is already at the inode->i_size, or
> -        * this ordered extent is inside the disk i_size, we're done
> -        */
> -       if (disk_i_size =3D=3D i_size)
> -               goto out;
> -
> -       /*
> -        * We still need to update disk_i_size if outstanding_isize is gr=
eater
> -        * than disk_i_size.
> -        */
> -       if (offset <=3D disk_i_size &&
> -           (!ordered || ordered->outstanding_isize <=3D disk_i_size))
> -               goto out;
> -
> -       /*
> -        * walk backward from this ordered extent to disk_i_size.
> -        * if we find an ordered extent then we can't update disk i_size
> -        * yet
> -        */
> -       if (ordered) {
> -               node =3D rb_prev(&ordered->rb_node);
> -       } else {
> -               prev =3D tree_search(tree, offset);
> -               /*
> -                * we insert file extents without involving ordered struc=
t,
> -                * so there should be no ordered struct cover this offset
> -                */
> -               if (prev) {
> -                       test =3D rb_entry(prev, struct btrfs_ordered_exte=
nt,
> -                                       rb_node);
> -                       BUG_ON(offset_in_entry(test, offset));
> -               }
> -               node =3D prev;
> -       }
> -       for (; node; node =3D rb_prev(node)) {
> -               test =3D rb_entry(node, struct btrfs_ordered_extent, rb_n=
ode);
> -
> -               /* We treat this entry as if it doesn't exist */
> -               if (test_bit(BTRFS_ORDERED_UPDATED_ISIZE, &test->flags))
> -                       continue;
> -
> -               if (entry_end(test) <=3D disk_i_size)
> -                       break;
> -               if (test->file_offset >=3D i_size)
> -                       break;
> -
> -               /*
> -                * We don't update disk_i_size now, so record this undeal=
t
> -                * i_size. Or we will not know the real i_size.
> -                */
> -               if (test->outstanding_isize < offset)
> -                       test->outstanding_isize =3D offset;
> -               if (ordered &&
> -                   ordered->outstanding_isize > test->outstanding_isize)
> -                       test->outstanding_isize =3D ordered->outstanding_=
isize;
> -               goto out;
> -       }
> -       new_i_size =3D min_t(u64, offset, i_size);
> -
> -       /*
> -        * Some ordered extents may completed before the current one, and
> -        * we hold the real i_size in ->outstanding_isize.
> -        */
> -       if (ordered && ordered->outstanding_isize > new_i_size)
> -               new_i_size =3D min_t(u64, ordered->outstanding_isize, i_s=
ize);
> -       BTRFS_I(inode)->disk_i_size =3D new_i_size;
> -       ret =3D 0;
> -out:
> -       /*
> -        * We need to do this because we can't remove ordered extents unt=
il
> -        * after the i_disk_size has been updated and then the inode has =
been
> -        * updated to reflect the change, so we need to tell anybody who =
finds
> -        * this ordered extent that we've already done all the real work,=
 we
> -        * just haven't completed all the other work.
> -        */
> -       if (ordered)
> -               set_bit(BTRFS_ORDERED_UPDATED_ISIZE, &ordered->flags);
> -       spin_unlock_irq(&tree->lock);
> -       return ret;
> -}
> -
>  /*
>   * search the ordered extents for one corresponding to 'offset' and
>   * try to find a checksum.  This is used because we allow pages to
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 5204171ea962..7f7f9ad091a6 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -52,11 +52,6 @@ enum {
>         BTRFS_ORDERED_DIRECT,
>         /* We had an io error when writing this out */
>         BTRFS_ORDERED_IOERR,
> -       /*
> -        * indicates whether this ordered extent has done its due diligen=
ce in
> -        * updating the isize
> -        */
> -       BTRFS_ORDERED_UPDATED_ISIZE,
>         /* Set when we have to truncate an extent */
>         BTRFS_ORDERED_TRUNCATED,
>         /* Regular IO for COW */
> @@ -180,8 +175,6 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_ran=
ge(
>                 struct btrfs_inode *inode,
>                 u64 file_offset,
>                 u64 len);
> -int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
> -                               struct btrfs_ordered_extent *ordered);
>  int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_byt=
enr,
>                            u8 *sum, int len);
>  u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 620bf1b38fba..02ac28f0e99e 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -468,7 +468,6 @@ DEFINE_EVENT(
>                 { (1 << BTRFS_ORDERED_PREALLOC),        "PREALLOC"      }=
, \
>                 { (1 << BTRFS_ORDERED_DIRECT),          "DIRECT"        }=
, \
>                 { (1 << BTRFS_ORDERED_IOERR),           "IOERR"         }=
, \
> -               { (1 << BTRFS_ORDERED_UPDATED_ISIZE),   "UPDATED_ISIZE" }=
, \
>                 { (1 << BTRFS_ORDERED_TRUNCATED),       "TRUNCATED"     }=
)
>
>
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
