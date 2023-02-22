Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39C569F3C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 12:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBVLzt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 06:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjBVLzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 06:55:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE933A0B2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 03:55:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D880A61126
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 11:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD82C4339C
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677066934;
        bh=Bmk62EmWiM5uh1KxQgzt78QmdH6+aeLeux0yDUoXNhg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XUxg4kQt2t94+qYUzjGaZWecnkAShrTA20BYuRQ5t91HbfPI00TXKRcATQnkeZQdj
         AWP+skBQXu96cLtdsqDagyfbOemy3TD3sAPnS2lNd68or+irBbzt4yyWTPtPqkjLRD
         EnKXwagwPNBCs3/Ns3smI/JGp/PfqhCbnXCcevq+jcHmzJBs5qzatx3/1QyTnDAA+O
         b0n5QUJXLlFIRndQ3tlvjkToO9yyYQqBnsCEViIOrO8jbOC+gWERwwpOVabaE5Svbt
         LCt/qmvSdW0MnR3RcCABsV/4dRqyMp3OW3e1BOi5P8wZ0euwLuTTAMisqAVsfHuqXF
         AMnFA8g+od48g==
Received: by mail-oi1-f173.google.com with SMTP id e21so7684629oie.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 03:55:34 -0800 (PST)
X-Gm-Message-State: AO0yUKWJlZMwdltnnQGON7LPAibsjoYkt8/vxvAtbLjRKxkZUKGwfO3t
        rQ3M+q7jOajCdqk2T9H5srMzg8Q8qShkGMJ0JTk=
X-Google-Smtp-Source: AK7set8ggeFF/Ma49kbasgHZLZjY0x1IaVoCC+lFfb7A6HW+vEM08B2KCNi1NJRAo5nEeJa3D+SnoHO9oteXh31l6M0=
X-Received: by 2002:a05:6808:171b:b0:37d:5e52:6844 with SMTP id
 bc27-20020a056808171b00b0037d5e526844mr421457oib.98.1677066933296; Wed, 22
 Feb 2023 03:55:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677026757.git.boris@bur.io> <b064d09d94fb2a15ad72427962df400e37788d0c.1677026757.git.boris@bur.io>
 <CAL3q7H5rq9c2yXR6YqUCxoi1LQq-vTYAz0Eoxe1MxULsKKZ_bw@mail.gmail.com>
In-Reply-To: <CAL3q7H5rq9c2yXR6YqUCxoi1LQq-vTYAz0Eoxe1MxULsKKZ_bw@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 22 Feb 2023 11:54:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7a9M=FFPyg0g4OW6o+t8_JbE+77uV_UyF1wUsqyAt7wg@mail.gmail.com>
Message-ID: <CAL3q7H7a9M=FFPyg0g4OW6o+t8_JbE+77uV_UyF1wUsqyAt7wg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs: fix dio continue after short write due to
 buffer page fault
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 22, 2023 at 11:51 AM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Wed, Feb 22, 2023 at 1:04 AM Boris Burkov <boris@bur.io> wrote:
> >
> > If an application is doing direct io to a btrfs file and experiences a
> > page fault reading from the write buffer, iomap will issue a partial
> > bio, and allow the fs to keep going. However, there was a subtle bug in
> > this codepath in the btrfs dio iomap implementation that led to the
> > partial write ending up as a gap in the file's extents and to be read
> > back as zeros.
> >
> > The sequence of events in a partial write, lightly summarized and
> > trimmed down for brevity is as follows:
> >
> > ====WRITING TASK====
> > btrfs_direct_write
> > __iomap_dio_write
> > iomap_iter
> >   btrfs_dio_iomap_begin # create full ordered extent
> > iomap_dio_bio_iter
> >   bio_iov_iter_get_pages # page fault; partial read
> >   submit_bio # partial bio
> > iomap_iter
> >   btrfs_dio_iomap_end
> >     btrfs_mark_ordered_io_finished # sets BTRFS_ORDERED_IOERR;
> >                                    # submit to finish_ordered_fn wq
> > fault_in_iov_iter_readable # btrfs_direct_write detects partial write
> > __iomap_dio_write
> > iomap_iter
> >   btrfs_dio_iomap_begin # create second partial ordered extent
> > iomap_dio_bio_iter
> >   bio_iov_iter_get_pages # read all of remainder
> >   submit_bio # partial bio with all of remainder
> > iomap_iter
> >   btrfs_dio_iomap_end # nothing exciting to do with ordered io
> >
> > ====DIO ENDIO====
> > ==FIRST PARTIAL BIO==
> > btrfs_dio_end_io
> >   btrfs_mark_ordered_io_finished # bytes_left > 0
> >                                  # don't submit to finish_ordered_fn wq
> > ==SECOND PARTIAL BIO==
> > btrfs_dio_end_io
> >   btrfs_mark_ordered_io_finished # bytes_left == 0
> >                                  # submit to finish_ordered_fn wq
> >
> > ====BTRFS FINISH ORDERED WQ====
> > ==FIRST PARTIAL BIO==
> > btrfs_finish_ordered_io # called by dio_iomap_end_io, sees
> >                         # BTRFS_ORDERED_IOERR, just drops the
> >                         # ordered_extent
> > ==SECOND PARTIAL BIO==
> > btrfs_finish_ordered_io # called by btrfs_dio_end_io, writes out file
> >                         # extents, csums, etc...
>
> Thanks, this makes it a lot more clear for anyone trying to understand
> the problem.
>
> >
> > The essence of the problem is that while btrfs_direct_write and iomap
> > properly interact to submit all the correct bios, there is insufficient
> > logic in the btrfs dio functions (btrfs_dio_iomap_begin,
> > btrfs_dio_submit_io, btrfs_dio_end_io, and btrfs_dio_iomap_end) to
> > ensure that every bio is at least a part of a completed ordered_extent.
> > And it is completing an ordered_extent that results in crucial
> > functionality like writing out a file extent for the range.
>
> " writing out a file extent for the range", is kind of ambiguous, more
> like inserting a file extent item
> for the range in the subvolume/fs tree.
>
> >
> > More specifically, btrfs_dio_end_io treats the ordered extent as
> > unfinished but btrfs_dio_iomap_end sets BTRFS_ORDERED_IOERR on it.
> > Thus, the finish io work doesn't result in file extents, csums, etc...
> > In the aftermath, such a file behaves as though it has a hole in it,
> > instead of the purportedly written data.
> >
> > We considered a few options for fixing the bug (apologies for any
> > incorrect summary of a proposal which I didn't implement and fully
> > understand):
> > 1. treat the partial bio as if we had truncated the file, which would
> > result in properly finishing it.
> > 2. split the ordered extent when submitting a partial bio.
> > 3. cache the ordered extent across calls to __iomap_dio_rw in
> > iter->private, so that we could reuse it and correctly apply several
> > bios to it.
> >
> > I had trouble with 1, and it felt the most like a hack, so I tried 2
> > and 3. Since 3 has the benefit of also not creating an extra file
> > extent, and avoids an ordered extent lookup during bio submission, it
> > felt like the best option.
> >
> > A quick summary of the changes necessary to implement this cached
> > ordered_extent behavior:
> > - btrfs_direct_write keeps track of an ordered_extent for the duration
> > of a call, possible across several __iomap_dio_rws.
> > - zero the btrfs_dio_data before using it, since its fields constitute
> > state now.
> > - btrfs_dio_write uses dio_data to pass this ordered extent into and out
> > of __iomap_dio_rw.
> > - when the write is done, put the ordered_extent.
> > - if the short write happens to be length 0, then we _don't_ get an
> > extra bio, so we do need to cancel the ordered_extent like we used
> > to (and ditch the cached ordered extent)
> > - in btrfs_dio_iomap_begin, if the cached ordered extent is present,
> > skip all the work of creating it, just look up the extent mapping and
> > jump to setting up the iomap. (This part could likely be more
> > elegant..)
> >
> > Thanks to Josef, Christoph, and Filipe with their help figuring out the
> > bug and the fix.
> >
> > Fixes: 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> > Link: https://lore.kernel.org/linux-btrfs/aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com/
> > Link: https://pastebin.com/3SDaH8C6
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/btrfs_inode.h |  1 +
> >  fs/btrfs/file.c        | 11 ++++++-
> >  fs/btrfs/inode.c       | 75 +++++++++++++++++++++++++++++++-----------
> >  3 files changed, 67 insertions(+), 20 deletions(-)
> >
> > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > index 49a92aa65de1..87020aa58121 100644
> > --- a/fs/btrfs/btrfs_inode.h
> > +++ b/fs/btrfs/btrfs_inode.h
> > @@ -516,6 +516,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
> >  ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
> >                        size_t done_before);
> >  struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
> > +                                 struct btrfs_ordered_extent **ordered_extent,
> >                                   size_t done_before);
> >
> >  extern const struct dentry_operations btrfs_dentry_operations;
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 5cc5a1faaef5..ec5c5355906b 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1465,6 +1465,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >         ssize_t err;
> >         unsigned int ilock_flags = 0;
> >         struct iomap_dio *dio;
> > +       struct btrfs_ordered_extent *ordered_extent = NULL;
> >
> >         if (iocb->ki_flags & IOCB_NOWAIT)
> >                 ilock_flags |= BTRFS_ILOCK_TRY;
> > @@ -1526,7 +1527,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >          * got -EFAULT, faulting in the pages before the retry.
> >          */
> >         from->nofault = true;
> > -       dio = btrfs_dio_write(iocb, from, written);
> > +       dio = btrfs_dio_write(iocb, from, &ordered_extent, written);
> >         from->nofault = false;
> >
> >         /*
> > @@ -1569,6 +1570,14 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >                         goto relock;
> >                 }
> >         }
> > +       /*
> > +        * We can't loop back to btrfs_dio_write, so we can drop the cached
> > +        * ordered extent. Typically btrfs_dio_iomap_end will run and put the
> > +        * ordered_extent, but this is needed to clean up in case of an error
> > +        * path breaking out of iomap_iter before the final iomap_end call.
> > +        */
> > +       if (ordered_extent)
> > +               btrfs_put_ordered_extent(ordered_extent);
> >
> >         /*
> >          * If 'err' is -ENOTBLK or we have not written all data, then it means
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 44e9acc77a74..f1a59c5f3140 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -81,6 +81,7 @@ struct btrfs_dio_data {
> >         struct extent_changeset *data_reserved;
> >         bool data_space_reserved;
> >         bool nocow_done;
> > +       struct btrfs_ordered_extent *ordered;
> >  };
> >
> >  struct btrfs_dio_private {
> > @@ -6976,6 +6977,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
> >  }
> >
> >  static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> > +                                                 struct btrfs_dio_data *dio_data,
> >                                                   const u64 start,
> >                                                   const u64 len,
> >                                                   const u64 orig_start,
> > @@ -6986,7 +6988,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> >                                                   const int type)
> >  {
> >         struct extent_map *em = NULL;
> > -       int ret;
> > +       struct btrfs_ordered_extent *ordered;
> >
> >         if (type != BTRFS_ORDERED_NOCOW) {
> >                 em = create_io_em(inode, start, len, orig_start, block_start,
> > @@ -6996,18 +6998,21 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> >                 if (IS_ERR(em))
> >                         goto out;
> >         }
> > -       ret = btrfs_add_ordered_extent(inode, start, len, len, block_start,
> > -                                      block_len, 0,
> > -                                      (1 << type) |
> > -                                      (1 << BTRFS_ORDERED_DIRECT),
> > -                                      BTRFS_COMPRESS_NONE);
> > -       if (ret) {
> > +       ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
> > +                                            block_start, block_len, 0,
> > +                                            (1 << type) |
> > +                                            (1 << BTRFS_ORDERED_DIRECT),
> > +                                            BTRFS_COMPRESS_NONE);
> > +       if (IS_ERR(ordered)) {
> >                 if (em) {
> >                         free_extent_map(em);
> >                         btrfs_drop_extent_map_range(inode, start,
> >                                                     start + len - 1, false);
> >                 }
> > -               em = ERR_PTR(ret);
> > +               em = ERR_PTR(PTR_ERR(ordered));
> > +       } else {
> > +               ASSERT(!dio_data->ordered);
> > +               dio_data->ordered = ordered;
> >         }
> >   out:
> >
> > @@ -7015,6 +7020,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> >  }
> >
> >  static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
> > +                                                 struct btrfs_dio_data *dio_data,
> >                                                   u64 start, u64 len)
> >  {
> >         struct btrfs_root *root = inode->root;
> > @@ -7030,7 +7036,8 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
> >         if (ret)
> >                 return ERR_PTR(ret);
> >
> > -       em = btrfs_create_dio_extent(inode, start, ins.offset, start,
> > +       em = btrfs_create_dio_extent(inode, dio_data,
> > +                                    start, ins.offset, start,
> >                                      ins.objectid, ins.offset, ins.offset,
> >                                      ins.offset, BTRFS_ORDERED_REGULAR);
> >         btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> > @@ -7375,7 +7382,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
> >                 }
> >                 space_reserved = true;
> >
> > -               em2 = btrfs_create_dio_extent(BTRFS_I(inode), start, len,
> > +               em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data,
> > +                                             start, len,
> >                                               orig_start, block_start,
> >                                               len, orig_block_len,
> >                                               ram_bytes, type);
> > @@ -7417,7 +7425,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
> >                         goto out;
> >                 space_reserved = true;
> >
> > -               em = btrfs_new_extent_direct(BTRFS_I(inode), start, len);
> > +               em = btrfs_new_extent_direct(BTRFS_I(inode), dio_data, start, len);
> >                 if (IS_ERR(em)) {
> >                         ret = PTR_ERR(em);
> >                         goto out;
> > @@ -7521,6 +7529,17 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> >                 }
> >         }
> >
> > +       if (dio_data->ordered) {
> > +               ASSERT(write);
> > +               em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
> > +                                     dio_data->ordered->file_offset,
> > +                                     dio_data->ordered->bytes_left);
> > +               if (IS_ERR(em)) {
> > +                       ret = PTR_ERR(em);
> > +                       goto err;
> > +               }
> > +               goto map_iomap;
> > +       }
> >         memset(dio_data, 0, sizeof(*dio_data));
> >
> >         /*
> > @@ -7662,6 +7681,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> >         else
> >                 free_extent_state(cached_state);
> >
> > +map_iomap:
> >         /*
> >          * Translate extent map information to iomap.
> >          * We trim the extents (and move the addr) even though iomap code does
> > @@ -7715,13 +7735,25 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
> >         if (submitted < length) {
> >                 pos += submitted;
> >                 length -= submitted;
> > -               if (write)
> > -                       btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
> > -                                                      pos, length, false);
> > -               else
> > +               if (write) {
> > +                       if (submitted == 0) {
> > +                               btrfs_mark_ordered_io_finished(BTRFS_I(inode),
> > +                                                              NULL, pos,
> > +                                                              length, false);
> > +                               btrfs_put_ordered_extent(dio_data->ordered);
> > +                               dio_data->ordered = NULL;
> > +                       }
> > +               } else {
> >                         unlock_extent(&BTRFS_I(inode)->io_tree, pos,
> >                                       pos + length - 1, NULL);
> > +               }
> >                 ret = -ENOTBLK;
> > +       } else {
> > +               /* On the last bio, release our cached ordered_extent */
> > +               if (write) {
> > +                       btrfs_put_ordered_extent(dio_data->ordered);
> > +                       dio_data->ordered = NULL;
> > +               }
> >         }
> >
> >         if (write)
> > @@ -7784,19 +7816,24 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
> >
> >  ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
> >  {
> > -       struct btrfs_dio_data data;
> > +       struct btrfs_dio_data data = { };
>
> Btw, everywhere else we use the { 0 } style, so we should, ideally, be
> consistent and use it here too.
>
> Those are just minor things, David can fix them up when he picks the
> patch if he wants to, so:
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

And btw, as Christoph had asked before, can we get a test case for
fstests with this scenario?
Create a file (2M, close to the user's reproducer), mmap it to a
buffer, then do a direct write into another file using that mmap'ed
buffer - sounds like it should trigger the bug.

Thanks.

>
> >
> >         return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> >                             IOMAP_DIO_PARTIAL, &data, done_before);
> >  }
> >
> >  struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
> > +                                 struct btrfs_ordered_extent **ordered_extent,
> >                                   size_t done_before)
> >  {
> > -       struct btrfs_dio_data data;
> > +       struct btrfs_dio_data dio_data = { .ordered = *ordered_extent };
> > +       struct iomap_dio *dio;
> >
> > -       return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> > -                           IOMAP_DIO_PARTIAL, &data, done_before);
> > +       dio =  __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> > +                             IOMAP_DIO_PARTIAL, &dio_data, done_before);
> > +       if (!IS_ERR_OR_NULL(dio))
> > +               *ordered_extent = dio_data.ordered;
> > +       return dio;
> >  }
> >
> >  static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> > --
> > 2.38.1
> >
