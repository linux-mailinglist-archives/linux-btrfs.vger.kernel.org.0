Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CAA6AF824
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 23:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCGWBP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 17:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCGWBL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 17:01:11 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CB2AA278
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 14:01:04 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C34E43200786;
        Tue,  7 Mar 2023 17:01:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 07 Mar 2023 17:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678226461; x=1678312861; bh=k1
        b+On2smOXCopl71bSBNGs+Npto/8MG6Zjy8DOLNyI=; b=AD61lCV4R0gXC9zkBb
        Jd+LBAdXOXfED5JdxE7XOCpPVgxZujgEoYw/CEB+QB8GcnBFpGcZjneGRzjFP7nL
        7iVSwZewDGvGjxzCshJb40xLB8K1XLRePSrzeww0vWxn5E5d9Kgjtxzw/aGPRE9m
        min3JHDZBFSbUlUunzC1/4h7yFS7DBxAEwTmBfcmTXI1Cgl7zRBz0lBjtsF2BstR
        seUhZc/mZTefepmlGC9RJB/GchOOw0tHS9uFGHbQaaTdMsu396BJOLKRvISWcYDZ
        FOcmjk+vXmo+UfzDujdvoWgu+RXLWzxe4Hs0NDa+O/deQeTWI5j/V61f+j18aQYN
        YlRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678226461; x=1678312861; bh=k1b+On2smOXCo
        pl71bSBNGs+Npto/8MG6Zjy8DOLNyI=; b=TvDxHv6C6Cde5RkNSlQat7ELVQMlr
        4VG9fcR7LBfkjeAHPzS7ySAe9Ot1zaBXsAIQM40sw5bf07AlZxERCWOXbIPZFHHe
        SKE/jL/RufMQ7BgYsukD/IYkynj2ImVntNHpAnyd2VRm/4ZbP683TQ7R7EHp/qj+
        am2x+vn1Upoop25dwFl9eSIwrvTlHIX0WiKodVyC0sODLIqEqL38d63R/jOeimCh
        0/60nClS9n4QMr6xDnK/Y7+VIb8CfyEZ9R/gE5oxcVhLZuqa4eThYUzAyO92V7+W
        sM19AHOdA/DkGOdzoNSzj/j3ZZmt+93AEzea0QGHeXSdo9ekGuN27CvpA==
X-ME-Sender: <xms:HLQHZFj03SKm2Bk-4dlqliCWyH4qmBpp6TMKXsiCu5nFBmO2oZVfcw>
    <xme:HLQHZKA1HhseD_Q5PixCkNJkd_fmSJfwYrywFl8sc1y6u4Lh6blJ4QfTEVDKuArXv
    CIfanm8tjhAXkPWvm8>
X-ME-Received: <xmr:HLQHZFHt6tYEnIaDp7V_Pr3-wPsARmZ76Y0jjD8FqsDm67P28WC1CLvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddutddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epleevtdehffdvfeelfeffhfevtedvudevveeludfgvdehhedtuddugeeiudffieefnecu
    ffhomhgrihhnpehrvgguhhgrthdrtghomhdpkhgvrhhnvghlrdhorhhgpdhprghsthgvsg
    hinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:HLQHZKQ9zdym9sfoyTB1sIjkIXZ5k1ceFgtj56gx3YrWKrgQzzHtaQ>
    <xmx:HLQHZCxbOLDLut2We8fYEoZ3UgLZlR3jUujeqRyswF-t1zVYeFmN7Q>
    <xmx:HLQHZA72Xl_TSckKulJpL_g7I_DWArdH2g-WCwyylzI9GgV7W4Zhpw>
    <xmx:HbQHZHrZyM_ztsyRQsnU1etCZ_FfS-3a8iuRq78hJNXNYykuJ62qPw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Mar 2023 17:01:00 -0500 (EST)
Date:   Tue, 7 Mar 2023 14:00:58 -0800
From:   Boris Burkov <boris@bur.io>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: fix dio continue after short write due to
 buffer page fault
Message-ID: <20230307220058.GA8678@zen>
References: <cover.1677026757.git.boris@bur.io>
 <b064d09d94fb2a15ad72427962df400e37788d0c.1677026757.git.boris@bur.io>
 <20230307070720.63BA.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307070720.63BA.409509F4@e16-tech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 07, 2023 at 07:07:21AM +0800, Wang Yugui wrote:
> Hi,
> 
> fstests generic/276 trigger a deadloop with the patch in misc-next.
> 
> sysrq(w) output:
> 
> [33812.455122] sysrq: Show Blocked State
> 
> [33812.458831] task:kworker/u20:31  state:D stack:0     pid:1457865 ppid:2      flags:0x00004000
> [33812.467371] Workqueue: btrfs-flush_delalloc btrfs_work_helper [btrfs]
> [33812.473916] Call Trace:
> [33812.476365]  <TASK>
> [33812.478469]  __schedule+0x2cb/0x880
> [33812.481965]  schedule+0x50/0xc0
> [33812.485123]  btrfs_start_ordered_extent+0xf7/0x140 [btrfs]
> [33812.490668]  ? add_wait_queue+0xa0/0xa0
> [33812.494508]  btrfs_run_ordered_extent_work+0x1a/0x30 [btrfs]
> [33812.500219]  btrfs_work_helper+0x27f/0x360 [btrfs]
> [33812.505073]  process_one_work+0x1b0/0x390
> [33812.509101]  worker_thread+0x3c/0x370
> [33812.512779]  ? process_one_work+0x390/0x390
> [33812.516979]  kthread+0xe3/0x110
> [33812.520138]  ? kthread_complete_and_exit+0x20/0x20
> [33812.524945]  ret_from_fork+0x1f/0x30
> [33812.528542]  </TASK>
> 
> [33812.530751] task:umount          state:D stack:0     pid:1465218 ppid:1464868 flags:0x00004002
> [33812.539372] Call Trace:
> [33812.541823]  <TASK>
> [33812.543938]  __schedule+0x2cb/0x880
> [33812.547441]  ? wait_for_completion+0x83/0x160
> [33812.551807]  schedule+0x50/0xc0
> [33812.554964]  schedule_timeout+0x269/0x310
> [33812.559005]  ? wait_for_completion+0x83/0x160
> [33812.563370]  wait_for_completion+0xb5/0x160
> [33812.567561]  btrfs_wait_ordered_extents+0x346/0x450 [btrfs]
> [33812.573197]  btrfs_wait_ordered_roots+0x163/0x250 [btrfs]
> [33812.578645]  btrfs_sync_fs+0x3e/0x1c0 [btrfs]
> [33812.583052]  sync_filesystem+0x74/0x90
> [33812.586830]  generic_shutdown_super+0x22/0x120
> [33812.591281]  kill_anon_super+0x14/0x30
> [33812.595049]  btrfs_kill_super+0x12/0x20 [btrfs]
> [33812.599629]  deactivate_locked_super+0x2c/0x70
> [33812.604079]  cleanup_mnt+0xb8/0x140
> [33812.607585]  task_work_run+0x6a/0xb0
> [33812.611168]  exit_to_user_mode_prepare+0x1b9/0x1c0
> [33812.615977]  syscall_exit_to_user_mode+0x12/0x30
> [33812.620617]  do_syscall_64+0x67/0x80
> [33812.624198]  ? syscall_exit_to_user_mode+0x12/0x30
> [33812.629007]  ? do_syscall_64+0x67/0x80
> [33812.632771]  ? syscall_exit_to_user_mode+0x12/0x30
> [33812.637579]  ? do_syscall_64+0x67/0x80
> [33812.641346]  ? syscall_exit_to_user_mode+0x12/0x30
> [33812.646144]  ? do_syscall_64+0x67/0x80
> [33812.649907]  ? exc_page_fault+0x64/0x140
> [33812.653847]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [33812.658932] RIP: 0033:0x7f2eb454e56b
> [33812.662510] RSP: 002b:00007ffdf683ac78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [33812.670088] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f2eb454e56b
> [33812.677242] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000563731e5b5a0
> [33812.684394] RBP: 0000563731e5b370 R08: 0000000000000000 R09: 00007ffdf6839a00
> [33812.691536] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [33812.698678] R13: 0000563731e5b5a0 R14: 0000563731e5b480 R15: 0000563731e5b370
> [33812.705819]  </TASK>
> 
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/03/07

I sent a V3 that fixed our issue on generic/250. Since I didn't have a
reproducer for this issue, I was not able to test it. But the tests are
somewhat similar (dmerror + dio) as are the symptoms (stuck on ordered
extents) so I suspect they were hitting the same bug. If you have a
chance, would you be able to apply the V3 and test it out again on your
system?

Thanks,
Boris

> 
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
> > 
> > The essence of the problem is that while btrfs_direct_write and iomap
> > properly interact to submit all the correct bios, there is insufficient
> > logic in the btrfs dio functions (btrfs_dio_iomap_begin,
> > btrfs_dio_submit_io, btrfs_dio_end_io, and btrfs_dio_iomap_end) to
> > ensure that every bio is at least a part of a completed ordered_extent.
> > And it is completing an ordered_extent that results in crucial
> > functionality like writing out a file extent for the range.
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
> >  		       size_t done_before);
> >  struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
> > +				  struct btrfs_ordered_extent **ordered_extent,
> >  				  size_t done_before);
> >  
> >  extern const struct dentry_operations btrfs_dentry_operations;
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 5cc5a1faaef5..ec5c5355906b 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1465,6 +1465,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >  	ssize_t err;
> >  	unsigned int ilock_flags = 0;
> >  	struct iomap_dio *dio;
> > +	struct btrfs_ordered_extent *ordered_extent = NULL;
> >  
> >  	if (iocb->ki_flags & IOCB_NOWAIT)
> >  		ilock_flags |= BTRFS_ILOCK_TRY;
> > @@ -1526,7 +1527,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >  	 * got -EFAULT, faulting in the pages before the retry.
> >  	 */
> >  	from->nofault = true;
> > -	dio = btrfs_dio_write(iocb, from, written);
> > +	dio = btrfs_dio_write(iocb, from, &ordered_extent, written);
> >  	from->nofault = false;
> >  
> >  	/*
> > @@ -1569,6 +1570,14 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >  			goto relock;
> >  		}
> >  	}
> > +	/*
> > +	 * We can't loop back to btrfs_dio_write, so we can drop the cached
> > +	 * ordered extent. Typically btrfs_dio_iomap_end will run and put the
> > +	 * ordered_extent, but this is needed to clean up in case of an error
> > +	 * path breaking out of iomap_iter before the final iomap_end call.
> > +	 */
> > +	if (ordered_extent)
> > +		btrfs_put_ordered_extent(ordered_extent);
> >  
> >  	/*
> >  	 * If 'err' is -ENOTBLK or we have not written all data, then it means
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 44e9acc77a74..f1a59c5f3140 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -81,6 +81,7 @@ struct btrfs_dio_data {
> >  	struct extent_changeset *data_reserved;
> >  	bool data_space_reserved;
> >  	bool nocow_done;
> > +	struct btrfs_ordered_extent *ordered;
> >  };
> >  
> >  struct btrfs_dio_private {
> > @@ -6976,6 +6977,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
> >  }
> >  
> >  static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> > +						  struct btrfs_dio_data *dio_data,
> >  						  const u64 start,
> >  						  const u64 len,
> >  						  const u64 orig_start,
> > @@ -6986,7 +6988,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> >  						  const int type)
> >  {
> >  	struct extent_map *em = NULL;
> > -	int ret;
> > +	struct btrfs_ordered_extent *ordered;
> >  
> >  	if (type != BTRFS_ORDERED_NOCOW) {
> >  		em = create_io_em(inode, start, len, orig_start, block_start,
> > @@ -6996,18 +6998,21 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> >  		if (IS_ERR(em))
> >  			goto out;
> >  	}
> > -	ret = btrfs_add_ordered_extent(inode, start, len, len, block_start,
> > -				       block_len, 0,
> > -				       (1 << type) |
> > -				       (1 << BTRFS_ORDERED_DIRECT),
> > -				       BTRFS_COMPRESS_NONE);
> > -	if (ret) {
> > +	ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
> > +					     block_start, block_len, 0,
> > +					     (1 << type) |
> > +					     (1 << BTRFS_ORDERED_DIRECT),
> > +					     BTRFS_COMPRESS_NONE);
> > +	if (IS_ERR(ordered)) {
> >  		if (em) {
> >  			free_extent_map(em);
> >  			btrfs_drop_extent_map_range(inode, start,
> >  						    start + len - 1, false);
> >  		}
> > -		em = ERR_PTR(ret);
> > +		em = ERR_PTR(PTR_ERR(ordered));
> > +	} else {
> > +		ASSERT(!dio_data->ordered);
> > +		dio_data->ordered = ordered;
> >  	}
> >   out:
> >  
> > @@ -7015,6 +7020,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> >  }
> >  
> >  static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
> > +						  struct btrfs_dio_data *dio_data,
> >  						  u64 start, u64 len)
> >  {
> >  	struct btrfs_root *root = inode->root;
> > @@ -7030,7 +7036,8 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
> >  	if (ret)
> >  		return ERR_PTR(ret);
> >  
> > -	em = btrfs_create_dio_extent(inode, start, ins.offset, start,
> > +	em = btrfs_create_dio_extent(inode, dio_data,
> > +				     start, ins.offset, start,
> >  				     ins.objectid, ins.offset, ins.offset,
> >  				     ins.offset, BTRFS_ORDERED_REGULAR);
> >  	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> > @@ -7375,7 +7382,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
> >  		}
> >  		space_reserved = true;
> >  
> > -		em2 = btrfs_create_dio_extent(BTRFS_I(inode), start, len,
> > +		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data,
> > +					      start, len,
> >  					      orig_start, block_start,
> >  					      len, orig_block_len,
> >  					      ram_bytes, type);
> > @@ -7417,7 +7425,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
> >  			goto out;
> >  		space_reserved = true;
> >  
> > -		em = btrfs_new_extent_direct(BTRFS_I(inode), start, len);
> > +		em = btrfs_new_extent_direct(BTRFS_I(inode), dio_data, start, len);
> >  		if (IS_ERR(em)) {
> >  			ret = PTR_ERR(em);
> >  			goto out;
> > @@ -7521,6 +7529,17 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> >  		}
> >  	}
> >  
> > +	if (dio_data->ordered) {
> > +		ASSERT(write);
> > +		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
> > +				      dio_data->ordered->file_offset,
> > +				      dio_data->ordered->bytes_left);
> > +		if (IS_ERR(em)) {
> > +			ret = PTR_ERR(em);
> > +			goto err;
> > +		}
> > +		goto map_iomap;
> > +	}
> >  	memset(dio_data, 0, sizeof(*dio_data));
> >  
> >  	/*
> > @@ -7662,6 +7681,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> >  	else
> >  		free_extent_state(cached_state);
> >  
> > +map_iomap:
> >  	/*
> >  	 * Translate extent map information to iomap.
> >  	 * We trim the extents (and move the addr) even though iomap code does
> > @@ -7715,13 +7735,25 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
> >  	if (submitted < length) {
> >  		pos += submitted;
> >  		length -= submitted;
> > -		if (write)
> > -			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
> > -						       pos, length, false);
> > -		else
> > +		if (write) {
> > +			if (submitted == 0) {
> > +				btrfs_mark_ordered_io_finished(BTRFS_I(inode),
> > +							       NULL, pos,
> > +							       length, false);
> > +				btrfs_put_ordered_extent(dio_data->ordered);
> > +				dio_data->ordered = NULL;
> > +			}
> > +		} else {
> >  			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
> >  				      pos + length - 1, NULL);
> > +		}
> >  		ret = -ENOTBLK;
> > +	} else {
> > +		/* On the last bio, release our cached ordered_extent */
> > +		if (write) {
> > +			btrfs_put_ordered_extent(dio_data->ordered);
> > +			dio_data->ordered = NULL;
> > +		}
> >  	}
> >  
> >  	if (write)
> > @@ -7784,19 +7816,24 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
> >  
> >  ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
> >  {
> > -	struct btrfs_dio_data data;
> > +	struct btrfs_dio_data data = { };
> >  
> >  	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> >  			    IOMAP_DIO_PARTIAL, &data, done_before);
> >  }
> >  
> >  struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
> > +				  struct btrfs_ordered_extent **ordered_extent,
> >  				  size_t done_before)
> >  {
> > -	struct btrfs_dio_data data;
> > +	struct btrfs_dio_data dio_data = { .ordered = *ordered_extent };
> > +	struct iomap_dio *dio;
> >  
> > -	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> > -			    IOMAP_DIO_PARTIAL, &data, done_before);
> > +	dio =  __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> > +			      IOMAP_DIO_PARTIAL, &dio_data, done_before);
> > +	if (!IS_ERR_OR_NULL(dio))
> > +		*ordered_extent = dio_data.ordered;
> > +	return dio;
> >  }
> >  
> >  static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> > -- 
> > 2.38.1
> 
> 
