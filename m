Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01402B0107
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfIKQN2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 12:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfIKQN2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:13:28 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B94C20863
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 16:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568218407;
        bh=/i/D7IWNKgFBFeRyXp88n15uUa7dgrKAdzJKMFVQkfU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j6NFIk94OMOLBEGPtFFLhEJBmGs/AnKxZBYoRSm5YdVUeJLhao1MXXoY4V58mYe9q
         EzzR9lq62vgELo7cQxYh7tqidIo5Ov3YAd7CLpCVvf7EVIqM9Vr04/VByTW7+pbGXZ
         i+8FxDTJP6I8DEQWvQeBb6c60EarQUnKNn+U2/YY=
Received: by mail-ua1-f42.google.com with SMTP id u18so6976780uap.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 09:13:27 -0700 (PDT)
X-Gm-Message-State: APjAAAX/dxFqjZfjg/38+8BR8BdjV/mOLpxF9TnS/SSXo3O3y92b1mGH
        I4Cbtc0OdAL5X6MLvBFswOp5IcUtOWvQmcPV8vo=
X-Google-Smtp-Source: APXvYqyP8wz4mWDNXvVtE6wjvlD3AcHv479nnTQpTjBuQl/f4tOt+XO2zjq9gbfW01qGcPZU9MhA7y/uoRKgIrffjI0=
X-Received: by 2002:ab0:2410:: with SMTP id f16mr17318666uan.83.1568218406277;
 Wed, 11 Sep 2019 09:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190911145542.1125-1-fdmanana@kernel.org> <18E989C2-3E39-4C87-907D-EA671099C4AE@fb.com>
In-Reply-To: <18E989C2-3E39-4C87-907D-EA671099C4AE@fb.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 11 Sep 2019 17:13:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6kg+S+UwiLvsEKvCtsCuALMw7NfDnkWQEqk=AUn65SMg@mail.gmail.com>
Message-ID: <CAL3q7H6kg+S+UwiLvsEKvCtsCuALMw7NfDnkWQEqk=AUn65SMg@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix unwritten extent buffers and hangs on future
 writeback attempts
To:     Chris Mason <clm@fb.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Dennis Zhou <dennisz@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 5:04 PM Chris Mason <clm@fb.com> wrote:
>
> On 11 Sep 2019, at 15:55, fdmanana@kernel.org wrote:
>
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > So fix this by not overwriting the return value (ret) with the result
> > from flush_write_bio(). We also need to clear the
> > EXTENT_BUFFER_WRITEBACK
> > bit in case flush_write_bio() returns an error, otherwise it will hang
> > any future attempts to writeback the extent buffer.
> >
> > This is a regression introduced in the 5.2 kernel.
> >
> > Fixes: 2e3c25136adfb ("btrfs: extent_io: add proper error handling to
> > lock_extent_buffer_for_io()")
> > Fixes: f4340622e0226 ("btrfs: extent_io: Move the BUG_ON() in
> > flush_write_bio() one level up")
> > Reported-by: Zdenek Sojka <zsojka@seznam.cz>
> > Link:
> > https://lore.kernel.org/linux-btrfs/GpO.2yos.3WGDOLpx6t%7D.1TUDYM@seznam.cz/T/#u
> > Reported-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
> > Link:
> > https://lore.kernel.org/linux-btrfs/5c4688ac-10a7-fb07-70e8-c5d31a3fbb38@profihost.ag/T/#t
> > Reported-by: Drazen Kacar <drazen.kacar@oradian.com>
> > Link:
> > https://lore.kernel.org/linux-btrfs/DB8PR03MB562876ECE2319B3E579590F799C80@DB8PR03MB5628.eurprd03.prod.outlook.com/
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204377
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/extent_io.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 1ff438fd5bc2..1311ba0fc031 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -3628,6 +3628,13 @@ void wait_on_extent_buffer_writeback(struct
> > extent_buffer *eb)
> >                      TASK_UNINTERRUPTIBLE);
> >  }
> >
> > +static void end_extent_buffer_writeback(struct extent_buffer *eb)
> > +{
> > +     clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> > +     smp_mb__after_atomic();
> > +     wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
> > +}
> > +
> >  /*
> >   * Lock eb pages and flush the bio if we can't the locks
> >   *
> > @@ -3699,8 +3706,11 @@ static noinline_for_stack int
> > lock_extent_buffer_for_io(struct extent_buffer *eb
> >
> >               if (!trylock_page(p)) {
> >                       if (!flush) {
> > -                             ret = flush_write_bio(epd);
> > -                             if (ret < 0) {
> > +                             int err;
> > +
> > +                             err = flush_write_bio(epd);
> > +                             if (err < 0) {
> > +                                     ret = err;
> >                                       failed_page_nr = i;
> >                                       goto err_unlock;
> >                               }
>
>
> Dennis (cc'd) has been trying a similar fix against this in production,
> but sending it was interrupted by plumbing conferences.  I think he
> found that it needs to undo this as well:
>
>                  percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
>                                           -eb->len,
>                                           fs_info->dirty_metadata_batch);
>
> With the IO errors, we should end up aborting the FS.  This function
> also flips the the extent buffer written and dirty flags, and his patch
> resets them as well.  Given that we're aborting anyway, it's not
> critical, but it's probably a good idea to fix things up in the goto
> err_unlock just to make future bugs less likely.

Yes, I considered that at some point (undo everything done so far,
under the locks, etc) and thought it was pointless as well because we
abort.

But we may not abort - if we never start the writeback for an eb
because we returned error from flush_write_bio(), we can leave
btree_write_cache_pages() without noticing the error.
Since writeback never started, and btree_write_cache_pages() didn't
return the error, the transaction commit path may never get an error
from filemap_fdatawrite_range,
and we can commit the transaction despite failure to start writeback
for some extent buffer.

A problem that existed before that regression in 5.2 anyway. Sending
it as separate.

I'll include the undo of all operations in patch however, it doesn't
hurt for sure.

Thanks.

>
> -chris
