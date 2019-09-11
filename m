Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B22AB0254
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 19:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfIKRDM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 13:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbfIKRDM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 13:03:12 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8455C21A4C
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568221390;
        bh=6AqgiW1zvp+G7Qlmurkq9lmohw0yz2HL48vJtRdSvDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hXqfldhWubYyqlqqf+rLxptXQlpNMwdMPlS1s2VPyEuhKHgS+SpjsNMi3C1OOHdOX
         tlUwrVeRL82LnZjruKU0KY7Yssh+AafUY9Kk1MnkS8IxJUje0cXppWmE62S966SPtW
         LfK+tmT2UVesoU5DEgYpilWDu5amIjH2pVp7weFE=
Received: by mail-vk1-f170.google.com with SMTP id 70so3606212vkz.8
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 10:03:10 -0700 (PDT)
X-Gm-Message-State: APjAAAUAxgyBTYSqGf9jr8rTQ/pjr5sCtuEu0b4H+6DaeecPpi+mBMR3
        3JDYKTL85J6OcbFNL2RrQHbxoXKE0M9nwyvPRDU=
X-Google-Smtp-Source: APXvYqxLuzV5+OyMJjgMw1adbb0fxswClq8NpZ5b8mySZZRpNAqgVUKr+CuyT5NtLrtAd0qJdzSPC9MyX0Xh3aXlJwE=
X-Received: by 2002:a1f:5e4f:: with SMTP id s76mr6972446vkb.4.1568221389366;
 Wed, 11 Sep 2019 10:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190911145542.1125-1-fdmanana@kernel.org> <18E989C2-3E39-4C87-907D-EA671099C4AE@fb.com>
 <CAL3q7H6kg+S+UwiLvsEKvCtsCuALMw7NfDnkWQEqk=AUn65SMg@mail.gmail.com> <20190911165422.GA17854@dennisz-mbp>
In-Reply-To: <20190911165422.GA17854@dennisz-mbp>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 11 Sep 2019 18:02:58 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7ucW=MNRV=FphAHujHQ6NFNaDJ2xkeYM5RRMU+kaeBmA@mail.gmail.com>
Message-ID: <CAL3q7H7ucW=MNRV=FphAHujHQ6NFNaDJ2xkeYM5RRMU+kaeBmA@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix unwritten extent buffers and hangs on future
 writeback attempts
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Chris Mason <clm@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Dennis Zhou <dennisz@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 5:54 PM Dennis Zhou <dennis@kernel.org> wrote:
>
> On Wed, Sep 11, 2019 at 05:13:15PM +0100, Filipe Manana wrote:
> > On Wed, Sep 11, 2019 at 5:04 PM Chris Mason <clm@fb.com> wrote:
> > >
> > > On 11 Sep 2019, at 15:55, fdmanana@kernel.org wrote:
> > >
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > So fix this by not overwriting the return value (ret) with the result
> > > > from flush_write_bio(). We also need to clear the
> > > > EXTENT_BUFFER_WRITEBACK
> > > > bit in case flush_write_bio() returns an error, otherwise it will hang
> > > > any future attempts to writeback the extent buffer.
> > > >
> > > > This is a regression introduced in the 5.2 kernel.
> > > >
> > > > Fixes: 2e3c25136adfb ("btrfs: extent_io: add proper error handling to
> > > > lock_extent_buffer_for_io()")
> > > > Fixes: f4340622e0226 ("btrfs: extent_io: Move the BUG_ON() in
> > > > flush_write_bio() one level up")
> > > > Reported-by: Zdenek Sojka <zsojka@seznam.cz>
> > > > Link:
> > > > https://lore.kernel.org/linux-btrfs/GpO.2yos.3WGDOLpx6t%7D.1TUDYM@seznam.cz/T/#u
> > > > Reported-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
> > > > Link:
> > > > https://lore.kernel.org/linux-btrfs/5c4688ac-10a7-fb07-70e8-c5d31a3fbb38@profihost.ag/T/#t
> > > > Reported-by: Drazen Kacar <drazen.kacar@oradian.com>
> > > > Link:
> > > > https://lore.kernel.org/linux-btrfs/DB8PR03MB562876ECE2319B3E579590F799C80@DB8PR03MB5628.eurprd03.prod.outlook.com/
> > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204377
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >  fs/btrfs/extent_io.c | 23 ++++++++++++++---------
> > > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > > index 1ff438fd5bc2..1311ba0fc031 100644
> > > > --- a/fs/btrfs/extent_io.c
> > > > +++ b/fs/btrfs/extent_io.c
> > > > @@ -3628,6 +3628,13 @@ void wait_on_extent_buffer_writeback(struct
> > > > extent_buffer *eb)
> > > >                      TASK_UNINTERRUPTIBLE);
> > > >  }
> > > >
> > > > +static void end_extent_buffer_writeback(struct extent_buffer *eb)
> > > > +{
> > > > +     clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> > > > +     smp_mb__after_atomic();
> > > > +     wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Lock eb pages and flush the bio if we can't the locks
> > > >   *
> > > > @@ -3699,8 +3706,11 @@ static noinline_for_stack int
> > > > lock_extent_buffer_for_io(struct extent_buffer *eb
> > > >
> > > >               if (!trylock_page(p)) {
> > > >                       if (!flush) {
> > > > -                             ret = flush_write_bio(epd);
> > > > -                             if (ret < 0) {
> > > > +                             int err;
> > > > +
> > > > +                             err = flush_write_bio(epd);
> > > > +                             if (err < 0) {
> > > > +                                     ret = err;
> > > >                                       failed_page_nr = i;
> > > >                                       goto err_unlock;
> > > >                               }
> > >
> > >
> > > Dennis (cc'd) has been trying a similar fix against this in production,
> > > but sending it was interrupted by plumbing conferences.  I think he
> > > found that it needs to undo this as well:
> > >
> > >                  percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> > >                                           -eb->len,
> > >                                           fs_info->dirty_metadata_batch);
> > >
> > > With the IO errors, we should end up aborting the FS.  This function
> > > also flips the the extent buffer written and dirty flags, and his patch
> > > resets them as well.  Given that we're aborting anyway, it's not
> > > critical, but it's probably a good idea to fix things up in the goto
> > > err_unlock just to make future bugs less likely.
> >
> > Yes, I considered that at some point (undo everything done so far,
> > under the locks, etc) and thought it was pointless as well because we
> > abort.
> >
> > But we may not abort - if we never start the writeback for an eb
> > because we returned error from flush_write_bio(), we can leave
> > btree_write_cache_pages() without noticing the error.
> > Since writeback never started, and btree_write_cache_pages() didn't
> > return the error, the transaction commit path may never get an error
> > from filemap_fdatawrite_range,
> > and we can commit the transaction despite failure to start writeback
> > for some extent buffer.
> >
> > A problem that existed before that regression in 5.2 anyway. Sending
> > it as separate.
> >
> > I'll include the undo of all operations in patch however, it doesn't
> > hurt for sure.
> >
> > Thanks.
> >
> > >
> > > -chris
>
> Hello,
>
> I should have pushed this upstream sooner, I was hoping to have one of
> my test hosts hit my WARN_ON() in a separate patch, but it hasn't.
>
> The following is what I have to unblock 5.2 testing.
>
> I think your patch is missing resetting the header bits + the percpu
> metadata counter.

Yes, even though it's not a problem since we will end up aborting the
transaction later.
The v2 I sent some minutes ago does it:
https://patchwork.kernel.org/patch/11141559/

> I think on error we should break out of
> btree_write_cache_pages() and return it too.

Yes, but that's a separate change.
It makes the code clear but it doesn't fix any problem, the errors
will be marked in the end io callback and transaction and log commits
will see them and abort.
Sent a patch for that as well some minutes ago:
https://patchwork.kernel.org/patch/11141561/

>
> Thanks,
> Dennis
>
> -----
> From 1a57b5ee6e52c63bf7c8e3ae969c0df406e3cf69 Mon Sep 17 00:00:00 2001
> From: Dennis Zhou <dennis@kernel.org>
> Date: Wed, 4 Sep 2019 10:49:53 -0700
> Subject: [PATCH] btrfs: fix stall on writeback bit extent buffer
>
> In lock_extent_buffer_for_io(), if we encounter a blocking action, we
> try and flush the currently held onto bio. The failure mode here used to
> be a BUG_ON(). f4340622e022 changed this to move BUG_ON() up and
> incorrectly reset the current ret code. However,
> lock_extent_buffer_for_io() returns 1 on we should write out the pages.
> This caused the buffer to be skipped while keeping the writeback bit
> set.
>
> Now that we can fail here, we also need to fix up dirty_metadata_bytes,
> clear BTRFS_HEADER_FLAG_WRITTEN and EXTENT_BUFFER_WRITEBACK, and set
> EXTENT_BUFFER_DIRTY again.
>
> Fixes: f4340622e022 ("btrfs: extent_io: Move the BUG_ON() in flush_write_bio() one level up")
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/extent_io.c | 52 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 43 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 43af8245c06e..4ba3cd972a2a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3636,6 +3636,13 @@ void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
>                        TASK_UNINTERRUPTIBLE);
>  }
>
> +static void end_extent_buffer_writeback(struct extent_buffer *eb)
> +{
> +       clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> +       smp_mb__after_atomic();
> +       wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
> +}
> +
>  /*
>   * Lock eb pages and flush the bio if we can't the locks
>   *
> @@ -3707,9 +3714,11 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
>
>                 if (!trylock_page(p)) {
>                         if (!flush) {
> -                               ret = flush_write_bio(epd);
> -                               if (ret < 0) {
> +                               int flush_ret = flush_write_bio(epd);
> +
> +                               if (flush_ret < 0) {
>                                         failed_page_nr = i;
> +                                       ret = flush_ret;
>                                         goto err_unlock;
>                                 }
>                                 flush = 1;
> @@ -3723,24 +3732,45 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
>         /* Unlock already locked pages */
>         for (i = 0; i < failed_page_nr; i++)
>                 unlock_page(eb->pages[i]);
> -       return ret;
> -}
>
> -static void end_extent_buffer_writeback(struct extent_buffer *eb)
> -{
> -       clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> -       smp_mb__after_atomic();
> -       wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
> +       /* undo the above above because we failed */
> +       btrfs_tree_lock(eb);
> +
> +       percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> +                                        eb->len,
> +                                        fs_info->dirty_metadata_batch);
> +
> +       btrfs_clear_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
> +
> +       spin_lock(&eb->refs_lock);
> +       set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
> +       spin_unlock(&eb->refs_lock);

Clearing the writeback bit should also be done while holding eb->refs_lock.
Everything else is equivalent to what I sent in v2.

> +
> +       btrfs_tree_unlock(eb);
> +
> +       end_extent_buffer_writeback(eb);
> +
> +       return ret;
>  }
>
>  static void set_btree_ioerr(struct page *page)
>  {
>         struct extent_buffer *eb = (struct extent_buffer *)page->private;
> +       struct btrfs_fs_info *fs_info;
>
>         SetPageError(page);
>         if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
>                 return;
>
> +       /*
> +        * We just marked the extent as bad, that means we need retry
> +        * in the future, so fix up the dirty_metadata_bytes accounting.
> +        */
> +       fs_info = eb->fs_info;
> +       percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> +                                eb->len,
> +                                fs_info->dirty_metadata_batch);
> +

This is a separate change from the 5.2 regression. Should be separate
patch with a specific changelog IMHO.
Can you please submit that?

>         /*
>          * If writeback for a btree extent that doesn't belong to a log tree
>          * failed, increment the counter transaction->eb_write_errors.
> @@ -3977,6 +4007,10 @@ int btree_write_cache_pages(struct address_space *mapping,
>                         if (!ret) {
>                                 free_extent_buffer(eb);
>                                 continue;
> +                       } else if (ret < 0) {
> +                               done = 1;
> +                               free_extent_buffer(eb);
> +                               break;
>                         }

Separate change as well, not cause by the 5.2 regression. So separate
patch with a specific changelog as well IMHO.
Anyway, this hunk is exactly like the separate patch I sent some minutes ago.

Thanks!

>
>                         ret = write_one_eb(eb, wbc, &epd);
> --
> 2.17.1
>
