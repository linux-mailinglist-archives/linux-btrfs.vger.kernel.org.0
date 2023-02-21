Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BE569E79E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 19:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjBUSf6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 13:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBUSfz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 13:35:55 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55F118A8D
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 10:35:09 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5C2453200392;
        Tue, 21 Feb 2023 13:34:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 21 Feb 2023 13:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1677004445; x=1677090845; bh=6JwWr1oKhs
        xsLAjnypv4l3yLuhyxgxcAq9BZvGwy/nY=; b=lD7mdWYlXrC2sZ6Z8YEGmcqAcw
        k9DdRex2GYgUrvE4jU0omlzDIPZ8Nf1uXkHgsJ4CM28gewylWN8OEbZgTmgHvBtr
        LweYs/nDCQAumNOAusMHInJaDY5LOHfunyCh0IZe6r+3qxLhX5G/SUORXuZp6wqq
        vKOmqAAoL1pLiJ6+Ca78ht54RWqGpdnqX+gh0IROy/aGGXANKHNIlbjVY9wQfr84
        R4GMqL4TxmUFw7/CCU19N8FJV4p/ZPKdpXzqGJrBoH7sjrNoig5LgJVs0+78nIXY
        bvUYsPIwaY8QevKqecU9q8/kt77xusQx7Czd0ooTumRUPqMXSyTPrn4QL3Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677004445; x=1677090845; bh=6JwWr1oKhsxsLAjnypv4l3yLuhyx
        gxcAq9BZvGwy/nY=; b=PIohsXhhu2nitcMPQCAfNJilqNKPQrO7kH095N/T/hyt
        M5zPXxrOsrKJJ4csWsDqnuWTbxldZln/7lKCy/U6eY7i2RcCK31H8r0ZjAFIWBID
        dq2TdYHDSf/jdLLz8FneY9zLmH88PLVfKuCo6du7ayY25MOq+t/04PipkCtnLLnc
        qYOV1X95+kDBvPHu3VffzvY5980+kjr2o3fdzG6AWSFhkf3L96297JHiIqLTxSRl
        mkgQy4mEckOlick8UsBTpYIqMWmRwPgqUG1CMyrconohprVsh5PpYTL2DkrMIJBR
        mKNtw71WvifVKEfe23TlcZMVjT7VsL8e6NIIE3vPoQ==
X-ME-Sender: <xms:nQ71Y6bnwkKR-hcXi4IfpPZP4TMdd41DPK9TlkJjpgnz_8WxHsqKyQ>
    <xme:nQ71Y9bhGVJ1cXHfJewWhrn-AN1KQalsOydw9jJJ-YLVy7ft47_StP4ldtoWjQlUE
    fwqWV_EDjLnagqpZr0>
X-ME-Received: <xmr:nQ71Y0_Ek_KKglAKzuoq44ePbDMGMl2nl7y1dNLyDd87aZwk475xu0BH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epueeivdfgieekkeelgfeiledvvdeffeehgeeggeeiteetkeekveffkeehheektedvnecu
    ffhomhgrihhnpehrvgguhhgrthdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdr
    ihho
X-ME-Proxy: <xmx:nQ71Y8r7AMtI4D2BR1JvxupWXbqLtCO05Sq2nM97IvHsuSvxHmfv5Q>
    <xmx:nQ71Y1p1HtiqwHQ6LOcuHVoSGcreVx_dO0yReSxA6jddvvKfRWFcCQ>
    <xmx:nQ71Y6RvRR4i6WBuTh90_6AlOTCxlBoJGBA5mk5acBPkA1c6yhkgbA>
    <xmx:nQ71Y2D2C71cfjBXsnJ2DN4TH0XmVAcOUVqRNgmtBcMOKw8WKQmMxw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 13:34:05 -0500 (EST)
Date:   Tue, 21 Feb 2023 10:34:04 -0800
From:   Boris Burkov <boris@bur.io>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix dio continue after short write due to source
 fault
Message-ID: <Y/UOnKe6Ap8+lGx0@zen>
References: <ae81e48b0e954bae1c3451c0da1a24ae7146606c.1676684984.git.boris@bur.io>
 <CAL3q7H7wVW_E70+qvb4S7w06RvjW_2dXxzTLLQO45_vC0SLTkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7wVW_E70+qvb4S7w06RvjW_2dXxzTLLQO45_vC0SLTkA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 20, 2023 at 02:01:39PM +0000, Filipe Manana wrote:
> On Sat, Feb 18, 2023 at 2:25 AM Boris Burkov <boris@bur.io> wrote:
> >
> > Downstream bug report:
> > https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> 
> You place this in a Link: tag at the bottom.
> Also the previous discussion is useful to be there too:
> 
> Link: https://lore.kernel.org/linux-btrfs/aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com/

Thank you for the tip, I'll include those in V2.

> 
> >
> > If an application is doing direct io to a btrfs file and experiences a
> > page fault reading from the source, iomap will issue a partial bio, and
> > allow the fs to keep going.
> 
> This is a bit confusing. It should mention that it's a direct IO write
> hitting a page fault when accessing the buffer to write.
> 
> You mention reading a source file without any context, so it's a bit
> confusing for anyone who hasn't followed the discussion or bugzilla in
> detail. In this case the write buffer happens to be a memory mapped
> region of another file.

I was really confused by your message at first, because I thought
"buffer to write" and "write buffer" referred to the destination of the
direct bytes. But thinking more, I assume you must mean that it is the
buffer which is the source of the data for the write.

Just so we don't talk past each other on this point, do we agree on:

"We are doing a direct write into file B from an mmaped region of file A
and hitting a page faulting reading the contents of A, resulting in a
partial write into B."

If so, That is what I meant by "page fault reading from the source",
but I am happy to change the wording to something better.

"accessing the write buffer" does strike me as more precise, for what
it's worth assuming, again, that we agree on the meaning. I think I
might be using the wrong terminology in my head for some of these
concepts.

> 
> > However, there was a subtle bug in this
> > codepath in the btrfs dio iomap implementation that led to the partial
> > write ending up as a gap in the file's extents and to be read back as
> > zeros.
> >
> > In this case, iomap_dio_iter will submit a partial bio, then iomap_iter
> > calls iomap_end (btrfs_dio_iomap_end) and then __iomap_dio_rw will
> > return back to btrfs_direct_write to try again, which it does.
> >
> > However, btrfs_dio_iomap_end detects this short write condition and
> > marks the whole ordered extent finished, but not uptodate, which results
> > in essentially discarding it as unfinished. Further, when the partial
> > bio completes, it does not trigger finishing the ordered extent, because
> > bytes_left > 0, and we need the rest of the (nonexistent) bios to finish.
> >
> > btrfs_direct_write picks it up there and writes out the rest of the file
> > just fine, but nothing goes back for that lost partial write, which
> 
> And how does btrfs_direct_write() picks it up?

I was referring to the codepath which runs:

fault_in_iov_iterable(from, left);
goto relock;

> btrfs_dio_iomap_end() calls btrfs_mark_ordered_io_finished(), which
> sets BTRFS_ORDERED_IOERR on the ordered extent.
> That results in btrfs_finished_ordered_io() to not insert a new file
> extent item (and etc).

That is what I meant when I wrote:
"However, btrfs_dio_iomap_end detects this short write condition and
marks the whole ordered extent finished, but not uptodate, which
results in essentially discarding it as unfinished."

> But the ->bytes_left of the ordered extent must have reached 0
> somewhere, otherwise the next call
> to btrfs_dio_iomap_begin(), would find the ordered extent when it
> calls lock_extent_direct() and then hang when waiting for it to
> complete.

It's difficult to prove this without dumps of messy personal printks
from git-stashed code, but I actually don't think this is the case. As
far as I can tell, for writes, btrfs_dio_iomap_begin unlocks the extent
range after creating the ordered extent. It sets unlock_extents = true
unconditionally after creating the new ordered extent in
btrfs_get_blocks_direct_write and then unlocks the range just before the
out label.

> 
> When you say "picks it up", it gives the idea that the second call to
> btrfs_dio_iomap_begin() will pick up the ordered extent created from
> the previous call (before the fault error happened).
> But how can that happen? lock_extent_direct() would hang if it had found it.

Sorry about that confusion, but in my mind "it" was the operation of
writing the file.

> 
> The second call to btrfs_dio_iomap_begin() must be creating a new
> ordered extent, which overlaps with the first one, as we have

I agree with that, before the fix, we "cancelled" (via
btrfs_dio_iomap_end calling mark_ordered_io_finished with
uptodate=false resulting in BTRFS_ORDERED_IOERR) the first ordered
extent and created a new one in the next call to btrfs_dio_iomap_begin.

> discussed before in the other thread, otherwise we wouldn't have a
> hole just for the range corresponding to the submitted bio, but from
> the offset where that bio ends until the file's EOF.
> 
> Either you forgot to mention all that, or the problem is not fully understood.

Currently, I think we agree on the important points of the behavior
(except maybe some subtleties of the extent locking) and the issue is
mostly in my explanation of the bug being unclear. Unless you reply to
the contrary, my plan is to try to improve my commit message in a V2
where I also make your other suggested improvements.

Thank you for the review.

> 
> > results in the observed, buggy behavior.
> >
> > We considered a few options for fixing the bug (apologies for any
> > incorrect summary of a proposal which I didn't implement and fully
> > understand):
> > 1. treat the partial bio as if we had truncated the file, which would
> >    result in properly finishing it.
> > 2. split the ordered extent when submitting a partial bio.
> > 3. cache the ordered extent across calls to __iomap_dio_rw in
> >    iter->private, so that we could reuse it and correctly apply several
> >    bios to it.
> >
> > I had trouble with 1, and it felt the most like a hack, so I tried 2
> > and 3. Since 3 has the benefit of also not creating an extra file
> > extent, and avoids an ordered extent lookup during bio submission, it
> > felt like the best option.
> >
> > A quick summary of the changes necessary to implement this cached
> > behavior:
> > - modify add_ordered_extent to create an __add_ordered_extent variant
> 
> Don't create new functions prefixed with __, it's against the current
> best practices.
> 
> >   which refcounts and returns the ordered extent, to save a lookup
> >   during caching.
> > - store the ordered_extent on btrfs_dio_data (which had to move to
> >   fs/btrfs/file.h where fs/btrfs/file.c could see it)
> > - zero the btrfs_dio_data before using it, since its fields constitute
> >   state now.
> > - on the re-loop case in btrfs_direct_write, pull out the
> >   ordered_extent, zero the rest of the fields, and put the ordered
> >   extent back in.
> > - when the write is done, put the ordered_extent.
> > - if the short write happens to be length 0, then we _don't_ get an
> >   extra bio, so we do need to cancel the ordered_extent like we used
> >   to (and ditch the cached ordered extent)
> > - in btrfs_dio_iomap_begin, if the cached ordered extent is present,
> >   skip all the work of creating it, just look up the extent mapping and
> >   jump to setting up the iomap. (This part could likely be more
> >   elegant..)
> >
> > Thanks to Josef, Christoph, and Filipe with their help figuring out the
> > bug and the fix.
> >
> > Fixes: 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/btrfs_inode.h  |  4 ++-
> >  fs/btrfs/file.c         | 19 ++++++++++-
> >  fs/btrfs/file.h         |  8 +++++
> >  fs/btrfs/inode.c        | 75 ++++++++++++++++++++++++++---------------
> >  fs/btrfs/ordered-data.c | 45 ++++++++++++++++++++-----
> >  fs/btrfs/ordered-data.h |  7 +++-
> >  fs/iomap/direct-io.c    |  1 -
> >  7 files changed, 119 insertions(+), 40 deletions(-)
> >
> > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > index 49a92aa65de1..977b7aaa3db3 100644
> > --- a/fs/btrfs/btrfs_inode.h
> > +++ b/fs/btrfs/btrfs_inode.h
> > @@ -515,8 +515,10 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
> >
> >  ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
> >                        size_t done_before);
> > +
> > +struct btrfs_dio_data;
> >  struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
> > -                                 size_t done_before);
> > +                                 struct btrfs_dio_data *data, size_t done_before);
> >
> >  extern const struct dentry_operations btrfs_dentry_operations;
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 5cc5a1faaef5..60a6711e25fa 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1464,7 +1464,11 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >         loff_t endbyte;
> >         ssize_t err;
> >         unsigned int ilock_flags = 0;
> > +       struct btrfs_dio_data dio_data;
> >         struct iomap_dio *dio;
> > +       struct btrfs_ordered_extent *tmp;
> 
> Why not call it just 'oe', it's more descriptive than 'tmp'.
> 
> > +
> > +       memset(&dio_data, 0, sizeof(dio_data));
> >
> >         if (iocb->ki_flags & IOCB_NOWAIT)
> >                 ilock_flags |= BTRFS_ILOCK_TRY;
> > @@ -1526,7 +1530,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >          * got -EFAULT, faulting in the pages before the retry.
> >          */
> >         from->nofault = true;
> > -       dio = btrfs_dio_write(iocb, from, written);
> > +       dio = btrfs_dio_write(iocb, from, &dio_data, written);
> >         from->nofault = false;
> >
> >         /*
> > @@ -1564,11 +1568,24 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >                 if (left == prev_left) {
> >                         err = -ENOTBLK;
> >                 } else {
> > +                       tmp = dio_data.ordered;
> 
> You can also declare the ordered extent pointer inside this block,
> since it's not used outside of it.
> 
> > +                       memset(&dio_data, 0, sizeof(dio_data));
> > +                       dio_data.ordered = tmp;
> >                         fault_in_iov_iter_readable(from, left);
> >                         prev_left = left;
> >                         goto relock;
> >                 }
> >         }
> > +       /*
> > +        * We can't loop back to btrfs_dio_write, so we can drop the cached
> > +        * ordered extent. Typically btrfs_dio_iomap_end will run and put the
> > +        * ordered_extent, but this is needed to clean up in case of an error
> > +        * path breaking out of iomap_iter before the final iomap_end call.
> > +        */
> > +       if (dio_data.ordered) {
> > +               btrfs_put_ordered_extent(dio_data.ordered);
> > +               dio_data.ordered = NULL;
> > +       }
> >
> >         /*
> >          * If 'err' is -ENOTBLK or we have not written all data, then it means
> > diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
> > index 82b34fbb295f..3d4427881eb6 100644
> > --- a/fs/btrfs/file.h
> > +++ b/fs/btrfs/file.h
> > @@ -5,6 +5,14 @@
> >
> >  extern const struct file_operations btrfs_file_operations;
> >
> > +struct btrfs_dio_data {
> > +       ssize_t submitted;
> > +       struct extent_changeset *data_reserved;
> > +       bool data_space_reserved;
> > +       bool nocow_done;
> > +       struct btrfs_ordered_extent *ordered;
> > +};
> > +
> >  int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
> >  int btrfs_drop_extents(struct btrfs_trans_handle *trans,
> >                        struct btrfs_root *root, struct btrfs_inode *inode,
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 44e9acc77a74..b95dbd611261 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -76,13 +76,6 @@ struct btrfs_iget_args {
> >         struct btrfs_root *root;
> >  };
> >
> > -struct btrfs_dio_data {
> > -       ssize_t submitted;
> > -       struct extent_changeset *data_reserved;
> > -       bool data_space_reserved;
> > -       bool nocow_done;
> > -};
> > -
> >  struct btrfs_dio_private {
> >         /* Range of I/O */
> >         u64 file_offset;
> > @@ -6976,6 +6969,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
> >  }
> >
> >  static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> > +                                                 struct btrfs_dio_data *dio_data,
> >                                                   const u64 start,
> >                                                   const u64 len,
> >                                                   const u64 orig_start,
> > @@ -6986,7 +6980,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> >                                                   const int type)
> >  {
> >         struct extent_map *em = NULL;
> > -       int ret;
> > +       struct btrfs_ordered_extent *ordered;
> >
> >         if (type != BTRFS_ORDERED_NOCOW) {
> >                 em = create_io_em(inode, start, len, orig_start, block_start,
> > @@ -6996,25 +6990,27 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> >                 if (IS_ERR(em))
> >                         goto out;
> >         }
> > -       ret = btrfs_add_ordered_extent(inode, start, len, len, block_start,
> > -                                      block_len, 0,
> > -                                      (1 << type) |
> > -                                      (1 << BTRFS_ORDERED_DIRECT),
> > -                                      BTRFS_COMPRESS_NONE);
> > -       if (ret) {
> > +       ordered = __btrfs_add_ordered_extent(inode, start, len, len, block_start,
> > +                                            block_len, 0,
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
> > +               dio_data->ordered = ordered;
> 
> Can we ASSERT that dio->ordered is currently NULL, to help catching
> any current or future bugs?
> 
> >         }
> >   out:
> > -
> 
> Unrelated change.
> 
> >         return em;
> >  }
> >
> >  static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
> > +                                                 struct btrfs_dio_data *dio_data,
> >                                                   u64 start, u64 len)
> >  {
> >         struct btrfs_root *root = inode->root;
> > @@ -7030,7 +7026,8 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
> >         if (ret)
> >                 return ERR_PTR(ret);
> >
> > -       em = btrfs_create_dio_extent(inode, start, ins.offset, start,
> > +       em = btrfs_create_dio_extent(inode, dio_data,
> > +                                    start, ins.offset, start,
> >                                      ins.objectid, ins.offset, ins.offset,
> >                                      ins.offset, BTRFS_ORDERED_REGULAR);
> >         btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> > @@ -7375,7 +7372,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
> >                 }
> >                 space_reserved = true;
> >
> > -               em2 = btrfs_create_dio_extent(BTRFS_I(inode), start, len,
> > +               em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data,
> > +                                             start, len,
> >                                               orig_start, block_start,
> >                                               len, orig_block_len,
> >                                               ram_bytes, type);
> > @@ -7417,7 +7415,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
> >                         goto out;
> >                 space_reserved = true;
> >
> > -               em = btrfs_new_extent_direct(BTRFS_I(inode), start, len);
> > +               em = btrfs_new_extent_direct(BTRFS_I(inode), dio_data, start, len);
> >                 if (IS_ERR(em)) {
> >                         ret = PTR_ERR(em);
> >                         goto out;
> > @@ -7521,6 +7519,16 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> >                 }
> >         }
> >
> > +       if (dio_data->ordered && write) {
> 
> I don't think you need the "&& write" condition.
> Just assert: ASSERT(write);  inside this block.
> 
> > +               em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
> > +                                     dio_data->ordered->file_offset,
> > +                                     dio_data->ordered->bytes_left);
> > +               if (IS_ERR(em)) {
> > +                       ret = PTR_ERR(em);
> > +                       goto err;
> > +               }
> > +               goto out;
> > +       }
> >         memset(dio_data, 0, sizeof(*dio_data));
> >
> >         /*
> > @@ -7543,6 +7551,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> >                         goto err;
> >         }
> >
> > +
> 
> Unrelated change.
> 
> >         /*
> >          * If this errors out it's because we couldn't invalidate pagecache for
> >          * this range and we need to fallback to buffered IO, or we are doing a
> > @@ -7662,6 +7671,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> >         else
> >                 free_extent_state(cached_state);
> >
> > +out:
> >         /*
> >          * Translate extent map information to iomap.
> >          * We trim the extents (and move the addr) even though iomap code does
> > @@ -7715,13 +7725,25 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
> >         if (submitted < length) {
> >                 pos += submitted;
> >                 length -= submitted;
> > -               if (write)
> > -                       btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
> > -                                                      pos, length, false);
> > -               else
> > +               if (!write)
> >                         unlock_extent(&BTRFS_I(inode)->io_tree, pos,
> >                                       pos + length - 1, NULL);
> > +               else {
> > +                       if (submitted == 0) {
> > +                               btrfs_mark_ordered_io_finished(BTRFS_I(inode),
> > +                                                              NULL, pos,
> > +                                                              length, false);
> > +                               btrfs_put_ordered_extent(dio_data->ordered);
> > +                               dio_data->ordered = NULL;
> > +                       }
> > +               }
> 
> Why change the order of the logic? Why not keep if (write) ... else ...
> Also both branches of the if statement should have { }
> 
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
> > @@ -7785,18 +7807,17 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
> >  ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
> >  {
> >         struct btrfs_dio_data data;
> > +       memset(&data, 0, sizeof(data));
> 
> Please leave a space between the variable declaration and memset().
> That's part of the coding style and, IIRC, even checkpatch should
> complain about that.
> 
> Thanks.
> 
> >
> >         return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> >                             IOMAP_DIO_PARTIAL, &data, done_before);
> >  }
> >
> >  struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
> > -                                 size_t done_before)
> > +                                 struct btrfs_dio_data *data, size_t done_before)
> >  {
> > -       struct btrfs_dio_data data;
> > -
> >         return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> > -                           IOMAP_DIO_PARTIAL, &data, done_before);
> > +                           IOMAP_DIO_PARTIAL, data, done_before);
> >  }
> >
> >  static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > index 6c24b69e2d0a..a4c7eed811eb 100644
> > --- a/fs/btrfs/ordered-data.c
> > +++ b/fs/btrfs/ordered-data.c
> > @@ -160,14 +160,16 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
> >   * @compress_type:   Compression algorithm used for data.
> >   *
> >   * Most of these parameters correspond to &struct btrfs_file_extent_item. The
> > - * tree is given a single reference on the ordered extent that was inserted.
> > + * tree is given a single reference on the ordered extent that was inserted, and
> > + * the returned pointer is given a second reference.
> >   *
> > - * Return: 0 or -ENOMEM.
> > + * Return: the new ordered_extent or ERR_PTR(-ENOMEM).
> >   */
> > -int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> > -                            u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> > -                            u64 disk_num_bytes, u64 offset, unsigned flags,
> > -                            int compress_type)
> > +struct btrfs_ordered_extent *__btrfs_add_ordered_extent(
> > +                       struct btrfs_inode *inode, u64 file_offset,
> > +                       u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> > +                       u64 disk_num_bytes, u64 offset, unsigned long flags,
> > +                       int compress_type)
> >  {
> >         struct btrfs_root *root = inode->root;
> >         struct btrfs_fs_info *fs_info = root->fs_info;
> > @@ -181,7 +183,7 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> >                 /* For nocow write, we can release the qgroup rsv right now */
> >                 ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
> >                 if (ret < 0)
> > -                       return ret;
> > +                       return ERR_PTR(ret);
> >                 ret = 0;
> >         } else {
> >                 /*
> > @@ -190,11 +192,11 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> >                  */
> >                 ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes);
> >                 if (ret < 0)
> > -                       return ret;
> > +                       return ERR_PTR(ret);
> >         }
> >         entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
> >         if (!entry)
> > -               return -ENOMEM;
> > +               return ERR_PTR(-ENOMEM);
> >
> >         entry->file_offset = file_offset;
> >         entry->num_bytes = num_bytes;
> > @@ -256,6 +258,31 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> >         btrfs_mod_outstanding_extents(inode, 1);
> >         spin_unlock(&inode->lock);
> >
> > +       /* one ref for the returned entry to match semantics of lookup */
> > +       refcount_inc(&entry->refs);
> > +       return entry;
> > +}
> > +
> > +
> > +/*
> > + * Add a new btrfs_ordered_extent for the range, but drop the reference
> > + * instead of returning it to the caller.
> > + */
> > +int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> > +                            u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> > +                            u64 disk_num_bytes, u64 offset, unsigned long flags,
> > +                            int compress_type)
> > +{
> > +       struct btrfs_ordered_extent *ordered;
> > +
> > +       ordered = __btrfs_add_ordered_extent(inode, file_offset, num_bytes,
> > +                                            ram_bytes, disk_bytenr,
> > +                                            disk_num_bytes, offset, flags,
> > +                                            compress_type);
> > +
> > +       if (IS_ERR(ordered))
> > +               return PTR_ERR(ordered);
> > +       btrfs_put_ordered_extent(ordered);
> >         return 0;
> >  }
> >
> > diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> > index eb40cb39f842..d09048655dfb 100644
> > --- a/fs/btrfs/ordered-data.h
> > +++ b/fs/btrfs/ordered-data.h
> > @@ -178,9 +178,14 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
> >  bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
> >                                     struct btrfs_ordered_extent **cached,
> >                                     u64 file_offset, u64 io_size);
> > +struct btrfs_ordered_extent *__btrfs_add_ordered_extent(
> > +                       struct btrfs_inode *inode, u64 file_offset,
> > +                       u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> > +                       u64 disk_num_bytes, u64 offset, unsigned long flags,
> > +                       int compress_type);
> >  int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> >                              u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> > -                            u64 disk_num_bytes, u64 offset, unsigned flags,
> > +                            u64 disk_num_bytes, u64 offset, unsigned long flags,
> >                              int compress_type);
> >  void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
> >                            struct btrfs_ordered_sum *sum);
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index f771001574d0..b1277e615478 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -131,7 +131,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
> >                 ret += dio->done_before;
> >
> >         kfree(dio);
> > -
> >         return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_dio_complete);
> > --
> > 2.38.1
> >
