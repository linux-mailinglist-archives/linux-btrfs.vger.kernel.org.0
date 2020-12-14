Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5125C2D9573
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 10:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbgLNJo4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 04:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731700AbgLNJoz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 04:44:55 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A4BC0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 01:44:15 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b64so11000771qkc.12
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 01:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Wi7OzFhymVKrmTGniVXIfDQJwy9WUW3VIR8mPwuomfI=;
        b=tnZNZh3T44uFqXGygS0/XYJo8p1ewl8cd27hkHkoYdHTglKJZT+bKvpPMxLuSNsbPg
         OHRI6D98eEGpcrd4KLRNilYoBijXt7RohBBKMBB8urnWYkfRrl0LW922lwZw28rIxcYn
         MSspouyTS4VaukPD1jYgT/ZMBrML/1BxxpgqBmsd1Z2ZsAl9LJKvRxPE6NMTNMy3Xi94
         He5KE+LdefEK2C3jrvohHVc7d/s0ujDtcpMa5X1jpB7opa8s5aDIgDpqwpXIhQZBaRsD
         OHN0JAwKrDi4vFIrb2D8kTNT03urEwHuJu4ykzDpRjVNgC4Ly0ZkDJgXP1LYJ8N3GN7v
         dXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Wi7OzFhymVKrmTGniVXIfDQJwy9WUW3VIR8mPwuomfI=;
        b=CqIx+ikjhRE5ZzC5G+c3ZZ0fKijzOGIotD64TtwqniYHtVYbm9Sw07buPRj9PurYGR
         bezcyd/+xSq+wx1Wp83qKtV/T+uBPONu3TivCzQaun+b7VNsf7B6PA4M5qnNBrBsOysW
         EG5CGH7K1clonpkk44ETPkCocGDa7HbtBg2ZBnii9TwGpJ0AeGJxr0UZhs705nj1oaET
         icsmzd2Z/RrNmq1r+fNenSKXYb9IMD1lEswRqPHuYQ6rCuuGs8vEYdYWdUv+4u1VGZnF
         u6E9kz5jxt5koF37yemwmH6kCcrCPLnuq6pW2D2l8K3yDRnI4JbzY+aHfxPOGcjXitRY
         u9SA==
X-Gm-Message-State: AOAM533k9/ycAnUd5XIv99PA3CH5xiBIg6uHjP0b5O7WttxtODutztlD
        wseZXtxmcdkL9JJrRIakIeHRtB8Q2DfcZV9Nbys=
X-Google-Smtp-Source: ABdhPJza9qLoBsrN9tzN2XziycpS1mrAE+zvxbgUp7i0UznOoFwTyoLxgOsXcwdZ815sLQtr2ccHh2xmsBLZ5hY4E0w=
X-Received: by 2002:ae9:df47:: with SMTP id t68mr30507455qkf.438.1607939054524;
 Mon, 14 Dec 2020 01:44:14 -0800 (PST)
MIME-Version: 1.0
References: <afdc2109f83fff1a925d7a66a6a047d4400721d4.1607724668.git.josef@toxicpanda.com>
In-Reply-To: <afdc2109f83fff1a925d7a66a6a047d4400721d4.1607724668.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 14 Dec 2020 09:44:03 +0000
Message-ID: <CAL3q7H5P5aGHwBRpo8PwvZrmasWgR0eJiZOrMXUaJpvx3POB=Q@mail.gmail.com>
Subject: Re: [PATCH][RFC] btrfs: fix race between dedupe and mmap
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 13, 2020 at 4:29 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Darrick asked how btrfs currently protects against mmap modifying a page
> during dedupe, and when I checked I realized it doesn't.  Previously we
> did the following dance
>
> lock page ranges in both files
>   lock extent
>     flush ordered
>       validate pages are the same
>         dedupe
>
> However Filipe moved us to use the generic checks, which instead does
> this dance
>
> lock inode
>   flush everything, check for ordered extents
>   lock page in both corresponding inodes
>     validate pages are the same
>   unlock pages
>   lock extent
>   dedupe
>
> The problem here is we're not doing our normal page lock -> extent lock
> -> validate check.  The generic checks assume we've blocked everybody
> from modifying the file, which we have with the exception of mmap.

One detail that is worth mentioning explicitly is that the problem
only happens when:

1) we unlock the pages
2) before we lock the range a mmap write happens
3) still before we lock the range, the delallloc for the mmap write is flus=
hed
4) still before we lock the range, the ordered extent, for the
delalloc created by the mmap write, completes
5) we lock the extent

It's quite a big stretch for steps 3 and 4 to happen too before we
lock the range, but certainly possible and needs to be fixed.
If 3 and 4 don't happen before we lock range, we are fine since we
reflink extents that had the data we compared before.

Though there's another problem caused by the race with mmap writes, it
affects both dedupe and clone.
If we end up with a dirty page after locking the range, we can later
deadlock when starting a transaction if we're too low on available
metadata space.
Basically we can deadlock if the transaction reservation needs to wait
for the async reclaim to flush delalloc, the same problem I fixed
recently with [1], just due to a different reason.

[1] https://patchwork.kernel.org/project/linux-btrfs/patch/39c2a60aa682f69f=
9823f51aa119d37ef4b9f834.1606909923.git.fdmanana@suse.com/

fallocate suffers from the same issue, and I've actually started to
address clone/dedupe and fallocate last week.
This patch ends up fixing that deadlock problem too for the dedupe
case as well. Two birds with one stone.

>
> There are two ways we can fix this, and I've chosen the simplest.
>
> The more complicated way is to add a flag to the generic checks to tell
> it that we'll do the page verification ourselves.  Then we add back the
> checks to btrfs_extent_same() to do the proper lock ordering in order to
> validate the pages.
>
> The simpler way to do this is to simply add a mechanism to block mmap
> from happening while we're doing dedupe.  I've opted for this strategy,
> because it's more straightforward and allows us to continue using the
> generic infrastructure.
>
> Ext4 and xfs do not have this problem because they have an inode lock
> that they use to block mmap from happening, the i_mmap_sem in ext4's
> case and the ilock for xfs.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> This is an RFC because there's two clear ways to fix this, and I'm not re=
ally
> married to either solution.  This is the solution I coded because it invo=
lves
> only touching Btrfs, which may be better for pushing out first to backpor=
t to
> stable.  The other solution is obviously to make the generic code skip th=
e
> verification and do it ourselves in btrfs_extent_same().  If we want to d=
o that
> instead I'll rework this patch to do it that way.

I like the fix. It allows us to reuse the generic code that compares the pa=
ges.

>
>  fs/btrfs/btrfs_inode.h | 33 +++++++++++++++++++++++++++++++++
>  fs/btrfs/inode.c       | 15 +++++++++++++++
>  fs/btrfs/reflink.c     | 31 +++++++++++++++++++++++++++----
>  3 files changed, 75 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index d9bf53d9ff90..2cadefb3736e 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -51,6 +51,17 @@ enum {
>          * the file range, inode's io_tree).
>          */
>         BTRFS_INODE_NO_DELALLOC_FLUSH,
> +       /*
> +        * Set when we are dedupe'ing a file in order to block any mmap w=
rites
> +        * from occurring.  This is because we use the generic checking t=
o
> +        * validate that the pages are the same, but we do not have the e=
xtent
> +        * locked at this point to block mmaps.  The trade-off of using t=
he
> +        * generic code is we need a separate mechanism to block mmaps in=
 this
> +        * case, otherwise we could race and modify pages in between chec=
king if
> +        * the pages are the same and locking the extents to do the
> +        * deduplication.
> +        */
> +       BTRFS_INODE_DEDUPE,
>  };
>
>  /* in memory btrfs inode */
> @@ -299,6 +310,28 @@ static inline void btrfs_mod_outstanding_extents(str=
uct btrfs_inode *inode,
>                                                   mod);
>  }
>
> +static inline void btrfs_inode_dedupe(struct btrfs_inode *inode)
> +{
> +       set_bit(BTRFS_INODE_DEDUPE, &inode->runtime_flags);
> +}
> +
> +static inline int btrfs_inode_dedupe_wait(struct btrfs_inode *inode)
> +{
> +       return wait_on_bit(&inode->runtime_flags, BTRFS_INODE_DEDUPE,
> +                          TASK_INTERRUPTIBLE);
> +}
> +
> +static inline void btrfs_inode_dedupe_done(struct btrfs_inode *inode)
> +{
> +       clear_bit(BTRFS_INODE_DEDUPE, &inode->runtime_flags);
> +       /*
> +        * This is necessary because clear_bit doesn't imply a memory bar=
rier,
> +        * and we need the memory barrier for wake_up_bit().
> +        */
> +       smp_mb__after_atomic();
> +       wake_up_bit(&inode->runtime_flags, BTRFS_INODE_DEDUPE);
> +}

Can't this be replaced with clear_and_wake_up_bit()? It's meant for
this use case.
With that in place we can also get rid of all these trivial helpers
and use directly set_bit, wait_on_bit and clear_and_wake_up_bit().

Anyway, just minor things, it looks good to me.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


> +
>  static inline int btrfs_inode_in_log(struct btrfs_inode *inode, u64 gene=
ration)
>  {
>         int ret =3D 0;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7a8d89e1b73f..85f85649c011 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8348,7 +8348,22 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf=
)
>
>         ret =3D VM_FAULT_NOPAGE; /* make the VM retry the fault */
>  again:
> +       /* We must wait on dedupes to complete. */
> +       if (btrfs_inode_dedupe_wait(BTRFS_I(inode)))
> +               goto out;
>         lock_page(page);
> +
> +       /*
> +        * If we raced and dedupe got set before we locked then we need t=
o retry.
> +        * If dedup comes in after this point we're OK because the verifi=
cation
> +        * step must lock this page for the filemap_flush(), so we will b=
lock
> +        * that step of the dedup until we exit mkwrite, at which point w=
e will
> +        * be written out and marked clean again.
> +        */
> +       if (test_bit(BTRFS_INODE_DEDUPE, &BTRFS_I(inode)->runtime_flags))=
 {
> +               unlock_page(page);
> +               goto again;
> +       }
>         size =3D i_size_read(inode);
>
>         if ((page->mapping !=3D inode->i_mapping) ||
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index b03e7891394e..5f4a806c445c 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -815,10 +815,26 @@ loff_t btrfs_remap_file_range(struct file *src_file=
, loff_t off,
>         if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
>                 return -EINVAL;
>
> -       if (same_inode)
> +       /*
> +        * We use btrfs_inode_dedup here to block concurrent mmaps during=
 dedup.
> +        * We do this because we use the generic helpers to validate that=
 the
> +        * ranges are indeed the same, however the appropriate locking is=
 not
> +        * done which makes it racy for us.  The alternative is to stop u=
sing
> +        * the generic checks and do the pages are the same checks intern=
ally
> +        * inside btrfs, but since mmap is the only issue here simply blo=
ck
> +        * concurrent mmaps.
> +        */
> +       if (same_inode) {
>                 inode_lock(src_inode);
> -       else
> +               if (remap_flags & REMAP_FILE_DEDUP)
> +                       btrfs_inode_dedupe(BTRFS_I(src_inode));
> +       } else {
>                 lock_two_nondirectories(src_inode, dst_inode);
> +               if (remap_flags & REMAP_FILE_DEDUP) {
> +                       btrfs_inode_dedupe(BTRFS_I(src_inode));
> +                       btrfs_inode_dedupe(BTRFS_I(dst_inode));
> +               }
> +       }
>
>         ret =3D btrfs_remap_file_range_prep(src_file, off, dst_file, dest=
off,
>                                           &len, remap_flags);
> @@ -831,10 +847,17 @@ loff_t btrfs_remap_file_range(struct file *src_file=
, loff_t off,
>                 ret =3D btrfs_clone_files(dst_file, src_file, off, len, d=
estoff);
>
>  out_unlock:
> -       if (same_inode)
> +       if (same_inode) {
>                 inode_unlock(src_inode);
> -       else
> +               if (remap_flags & REMAP_FILE_DEDUP)
> +                       btrfs_inode_dedupe_done(BTRFS_I(src_inode));
> +       } else {
>                 unlock_two_nondirectories(src_inode, dst_inode);
> +               if (remap_flags & REMAP_FILE_DEDUP) {
> +                       btrfs_inode_dedupe_done(BTRFS_I(src_inode));
> +                       btrfs_inode_dedupe_done(BTRFS_I(dst_inode));
> +               }
> +       }
>
>         return ret < 0 ? ret : len;
>  }
> --
> 2.26.2
>


--
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
