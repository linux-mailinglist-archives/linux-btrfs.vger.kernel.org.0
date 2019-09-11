Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A1BB022B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfIKQy3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 12:54:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38753 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbfIKQy3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:54:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so4415528wme.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 09:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Qz3Nw9hVWtukb+bJif0rZd+3ryOpu0owYx5A7I/HiE=;
        b=PKtQUCrYMKM3UcyVOsolvAYo8QYfi1DzLPOOHNuh2eTdIl+UAtS1wszH7FqDXc79Ou
         dxAWENR979Z8nd99E5AfpKxNGdmY1nyCj7M8a7L9c9UVLqBW0kQdA6ZlXo9DOPjjPLSZ
         sR/7OwxCMUX8RNTSTljZEUiednhA/eFxNiHpA+iYN6hCy9xOyVHNMJrNKjeC8wp/BR33
         04Rw7gbtwNW4xtGksr9SLYQwkaYqb+vUZqqOyMBDPgepIqvGKP/RknHZoDIfEHJqwzLn
         X/lAY7rIzVvDLglDFPnOcI5sKeEdNOiIJUPGYd7WI3ybHjpF5OQgGQodxwdWvkPJfQvm
         xFDw==
X-Gm-Message-State: APjAAAXUfuP1/oS9ZZsXPwOmvYLHweoZ5K3SbTIOoD7iwIm8lEQmkeHN
        MRVfRuxvML6iHLdNC4t7tBA=
X-Google-Smtp-Source: APXvYqwifWT5F0mI88L96D4jmD8aEdcVn9vjMJ7CH38d+qmoTagaLWZ9vasoDpYBYGcYMV7XVOP8nA==
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr5193841wmk.161.1568220866637;
        Wed, 11 Sep 2019 09:54:26 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c092:180::1:f90f])
        by smtp.gmail.com with ESMTPSA id y186sm5654017wmd.26.2019.09.11.09.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:54:25 -0700 (PDT)
Date:   Wed, 11 Sep 2019 17:54:22 +0100
From:   Dennis Zhou <dennis@kernel.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Chris Mason <clm@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Dennis Zhou <dennisz@fb.com>
Subject: Re: [PATCH] Btrfs: fix unwritten extent buffers and hangs on future
 writeback attempts
Message-ID: <20190911165422.GA17854@dennisz-mbp>
References: <20190911145542.1125-1-fdmanana@kernel.org>
 <18E989C2-3E39-4C87-907D-EA671099C4AE@fb.com>
 <CAL3q7H6kg+S+UwiLvsEKvCtsCuALMw7NfDnkWQEqk=AUn65SMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6kg+S+UwiLvsEKvCtsCuALMw7NfDnkWQEqk=AUn65SMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 05:13:15PM +0100, Filipe Manana wrote:
> On Wed, Sep 11, 2019 at 5:04 PM Chris Mason <clm@fb.com> wrote:
> >
> > On 11 Sep 2019, at 15:55, fdmanana@kernel.org wrote:
> >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > So fix this by not overwriting the return value (ret) with the result
> > > from flush_write_bio(). We also need to clear the
> > > EXTENT_BUFFER_WRITEBACK
> > > bit in case flush_write_bio() returns an error, otherwise it will hang
> > > any future attempts to writeback the extent buffer.
> > >
> > > This is a regression introduced in the 5.2 kernel.
> > >
> > > Fixes: 2e3c25136adfb ("btrfs: extent_io: add proper error handling to
> > > lock_extent_buffer_for_io()")
> > > Fixes: f4340622e0226 ("btrfs: extent_io: Move the BUG_ON() in
> > > flush_write_bio() one level up")
> > > Reported-by: Zdenek Sojka <zsojka@seznam.cz>
> > > Link:
> > > https://lore.kernel.org/linux-btrfs/GpO.2yos.3WGDOLpx6t%7D.1TUDYM@seznam.cz/T/#u
> > > Reported-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
> > > Link:
> > > https://lore.kernel.org/linux-btrfs/5c4688ac-10a7-fb07-70e8-c5d31a3fbb38@profihost.ag/T/#t
> > > Reported-by: Drazen Kacar <drazen.kacar@oradian.com>
> > > Link:
> > > https://lore.kernel.org/linux-btrfs/DB8PR03MB562876ECE2319B3E579590F799C80@DB8PR03MB5628.eurprd03.prod.outlook.com/
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204377
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/extent_io.c | 23 ++++++++++++++---------
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index 1ff438fd5bc2..1311ba0fc031 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -3628,6 +3628,13 @@ void wait_on_extent_buffer_writeback(struct
> > > extent_buffer *eb)
> > >                      TASK_UNINTERRUPTIBLE);
> > >  }
> > >
> > > +static void end_extent_buffer_writeback(struct extent_buffer *eb)
> > > +{
> > > +     clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> > > +     smp_mb__after_atomic();
> > > +     wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
> > > +}
> > > +
> > >  /*
> > >   * Lock eb pages and flush the bio if we can't the locks
> > >   *
> > > @@ -3699,8 +3706,11 @@ static noinline_for_stack int
> > > lock_extent_buffer_for_io(struct extent_buffer *eb
> > >
> > >               if (!trylock_page(p)) {
> > >                       if (!flush) {
> > > -                             ret = flush_write_bio(epd);
> > > -                             if (ret < 0) {
> > > +                             int err;
> > > +
> > > +                             err = flush_write_bio(epd);
> > > +                             if (err < 0) {
> > > +                                     ret = err;
> > >                                       failed_page_nr = i;
> > >                                       goto err_unlock;
> > >                               }
> >
> >
> > Dennis (cc'd) has been trying a similar fix against this in production,
> > but sending it was interrupted by plumbing conferences.  I think he
> > found that it needs to undo this as well:
> >
> >                  percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> >                                           -eb->len,
> >                                           fs_info->dirty_metadata_batch);
> >
> > With the IO errors, we should end up aborting the FS.  This function
> > also flips the the extent buffer written and dirty flags, and his patch
> > resets them as well.  Given that we're aborting anyway, it's not
> > critical, but it's probably a good idea to fix things up in the goto
> > err_unlock just to make future bugs less likely.
> 
> Yes, I considered that at some point (undo everything done so far,
> under the locks, etc) and thought it was pointless as well because we
> abort.
> 
> But we may not abort - if we never start the writeback for an eb
> because we returned error from flush_write_bio(), we can leave
> btree_write_cache_pages() without noticing the error.
> Since writeback never started, and btree_write_cache_pages() didn't
> return the error, the transaction commit path may never get an error
> from filemap_fdatawrite_range,
> and we can commit the transaction despite failure to start writeback
> for some extent buffer.
> 
> A problem that existed before that regression in 5.2 anyway. Sending
> it as separate.
> 
> I'll include the undo of all operations in patch however, it doesn't
> hurt for sure.
> 
> Thanks.
> 
> >
> > -chris

Hello,

I should have pushed this upstream sooner, I was hoping to have one of
my test hosts hit my WARN_ON() in a separate patch, but it hasn't.

The following is what I have to unblock 5.2 testing.

I think your patch is missing resetting the header bits + the percpu
metadata counter. I think on error we should break out of
btree_write_cache_pages() and return it too.

Thanks,
Dennis

-----
From 1a57b5ee6e52c63bf7c8e3ae969c0df406e3cf69 Mon Sep 17 00:00:00 2001
From: Dennis Zhou <dennis@kernel.org>
Date: Wed, 4 Sep 2019 10:49:53 -0700
Subject: [PATCH] btrfs: fix stall on writeback bit extent buffer

In lock_extent_buffer_for_io(), if we encounter a blocking action, we
try and flush the currently held onto bio. The failure mode here used to
be a BUG_ON(). f4340622e022 changed this to move BUG_ON() up and
incorrectly reset the current ret code. However,
lock_extent_buffer_for_io() returns 1 on we should write out the pages.
This caused the buffer to be skipped while keeping the writeback bit
set.

Now that we can fail here, we also need to fix up dirty_metadata_bytes,
clear BTRFS_HEADER_FLAG_WRITTEN and EXTENT_BUFFER_WRITEBACK, and set
EXTENT_BUFFER_DIRTY again.

Fixes: f4340622e022 ("btrfs: extent_io: Move the BUG_ON() in flush_write_bio() one level up")
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/extent_io.c | 52 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 43af8245c06e..4ba3cd972a2a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3636,6 +3636,13 @@ void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
 		       TASK_UNINTERRUPTIBLE);
 }
 
+static void end_extent_buffer_writeback(struct extent_buffer *eb)
+{
+	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
+	smp_mb__after_atomic();
+	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
+}
+
 /*
  * Lock eb pages and flush the bio if we can't the locks
  *
@@ -3707,9 +3714,11 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 
 		if (!trylock_page(p)) {
 			if (!flush) {
-				ret = flush_write_bio(epd);
-				if (ret < 0) {
+				int flush_ret = flush_write_bio(epd);
+
+				if (flush_ret < 0) {
 					failed_page_nr = i;
+					ret = flush_ret;
 					goto err_unlock;
 				}
 				flush = 1;
@@ -3723,24 +3732,45 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 	/* Unlock already locked pages */
 	for (i = 0; i < failed_page_nr; i++)
 		unlock_page(eb->pages[i]);
-	return ret;
-}
 
-static void end_extent_buffer_writeback(struct extent_buffer *eb)
-{
-	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
-	smp_mb__after_atomic();
-	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
+	/* undo the above above because we failed */
+	btrfs_tree_lock(eb);
+
+	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
+					 eb->len,
+					 fs_info->dirty_metadata_batch);
+
+	btrfs_clear_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
+
+	spin_lock(&eb->refs_lock);
+	set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
+	spin_unlock(&eb->refs_lock);
+
+	btrfs_tree_unlock(eb);
+
+	end_extent_buffer_writeback(eb);
+
+	return ret;
 }
 
 static void set_btree_ioerr(struct page *page)
 {
 	struct extent_buffer *eb = (struct extent_buffer *)page->private;
+	struct btrfs_fs_info *fs_info;
 
 	SetPageError(page);
 	if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
 		return;
 
+	/*
+	 * We just marked the extent as bad, that means we need retry
+	 * in the future, so fix up the dirty_metadata_bytes accounting.
+	 */
+	fs_info = eb->fs_info;
+	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
+				 eb->len,
+				 fs_info->dirty_metadata_batch);
+
 	/*
 	 * If writeback for a btree extent that doesn't belong to a log tree
 	 * failed, increment the counter transaction->eb_write_errors.
@@ -3977,6 +4007,10 @@ int btree_write_cache_pages(struct address_space *mapping,
 			if (!ret) {
 				free_extent_buffer(eb);
 				continue;
+			} else if (ret < 0) {
+				done = 1;
+				free_extent_buffer(eb);
+				break;
 			}
 
 			ret = write_one_eb(eb, wbc, &epd);
-- 
2.17.1

