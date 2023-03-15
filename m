Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2D56BBDA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjCOTxe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 15:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCOTxc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 15:53:32 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD6C6A56
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 12:53:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 477BB5C04BE;
        Wed, 15 Mar 2023 15:53:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 Mar 2023 15:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678910006; x=1678996406; bh=+X
        sVYsawvmLTKKzmiA+4t0O8IQN7SJG/jW9YPXZMGfg=; b=OYXNPQLkeL6QNs2Cgs
        /mvdBXbwGxUHD0DSqXRA2vYfsFAyKS/hHgZH8vjYeq+Qy2evczlQAkktTQow2Yqj
        Z8bZwQQa7NCqiDMwGXyTWqmPjtzWbJa/taNKKjZrK5tIQDroAOYSf/NhNAp1NyYs
        DDQ50H491MfUM5zLHkgqq2IIKYluAOIPH4fnYSrCOuPnZ2cIpOWbV1ShxvZO9cwm
        eQBkh5NNlMZwUfhR3E8Bh7ba+k7A8sGA9zAoF5bGHuWGWHW8F1cXcHTU1zBVANBh
        wJ9usa3EmevbayMd77bBmEAMJhsTb1igszJgwP2/sMNwGhAkYIaYzpUN4k7cVudM
        w1YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678910006; x=1678996406; bh=+XsVYsawvmLTK
        KzmiA+4t0O8IQN7SJG/jW9YPXZMGfg=; b=LZbcY20KPhhm60+vLNnA+iiw5RrG7
        28+WnPNSAj4LT8tz4nDqVCZjqrubGu6stO1NL9x4SHHgE70ffMAjKo8HC8lsGBQj
        O0txtJx2NdRvUUwKy9tcBTN5UzPXG9hnODhU42QwTA3uwpT5WdaYNNnrLrtTh+MS
        m135jw64QDB0msAzrvtFTTrL7r0KlBSbqP5Vil38LTphx3klrYuTPjGhCJmZ7pfN
        trJ3UNTQSt6my9UH0ZepSz+wwLJ5SKEY0T1OLMfYRSRXVupGr4MRuVj1rZjWgh8E
        FaI+2h9YPSC4HQUaMfWQvXynRBM7BlY9hWzM1xpak8CCpYLFwm88iv9Jw==
X-ME-Sender: <xms:NSISZLx1Z_Tc3BPpWmCd21koesfHwKeGG3S5cNpXg0M9Gb35TPeaMQ>
    <xme:NSISZDQlGt19YI2gyPfiWl-QuwviBO01veLx2aGY57-jdHzD_lVDaH_nvYZ-4b7Zp
    ETGZ_CbR6pwGGNT0Ug>
X-ME-Received: <xmr:NSISZFXn3vz23Xd-eanQHyzLABT9j-1_B3BvO8W8hRYLbnY30wprz6vY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epleevtdehffdvfeelfeffhfevtedvudevveeludfgvdehhedtuddugeeiudffieefnecu
    ffhomhgrihhnpehrvgguhhgrthdrtghomhdpkhgvrhhnvghlrdhorhhgpdhprghsthgvsg
    hinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:NiISZFhJ_ivngd9O-2V2ATbTntNZwBBS2OVGdNg8_5_dJudit2dVLw>
    <xmx:NiISZNAOjlrJD2T8Ib162GHtCCW2YKg-hpqsY5p0XAVH-3qL6iLV1Q>
    <xmx:NiISZOLKcbhxUdLcz-WjOjZozBdY9Do_1qqrK53UyxzHGj3vw9doGw>
    <xmx:NiISZK4nZPgW0VRpO5s1prh4WjAcqKd0QB9-07d9v0i_VcuxhQQlUw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 15:53:25 -0400 (EDT)
Date:   Wed, 15 Mar 2023 12:53:24 -0700
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3] btrfs: fix dio continue after short write due to
 buffer page fault
Message-ID: <20230315195255.GA27662@zen>
References: <6733f2fac24b674d9f60dc1093de30513c099629.1678212067.git.boris@bur.io>
 <20230309174050.GI10580@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309174050.GI10580@twin.jikos.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 09, 2023 at 06:40:50PM +0100, David Sterba wrote:
> On Tue, Mar 07, 2023 at 12:49:30PM -0800, Boris Burkov wrote:
> > If an application is doing direct io to a btrfs file and experiences a
> > page fault reading from the write buffer, iomap will issue a partial
> > bio, and allow the fs to keep going. However, there was a subtle bug in
> > this code path in the btrfs dio iomap implementation that led to the
> > partial write ending up as a gap in the file's extents and to be read
> > back as zeros.
> > 
> > The sequence of events in a partial write, lightly summarized and
> > trimmed down for brevity is as follows:
> > 
> >   ====WRITING TASK====
> >   btrfs_direct_write
> >   __iomap_dio_write
> >   iomap_iter
> >     btrfs_dio_iomap_begin # create full ordered extent
> >   iomap_dio_bio_iter
> >     bio_iov_iter_get_pages # page fault; partial read
> >     submit_bio # partial bio
> >   iomap_iter
> >     btrfs_dio_iomap_end
> >       btrfs_mark_ordered_io_finished # sets BTRFS_ORDERED_IOERR;
> > 				     # submit to finish_ordered_fn wq
> >   fault_in_iov_iter_readable # btrfs_direct_write detects partial write
> >   __iomap_dio_write
> >   iomap_iter
> >     btrfs_dio_iomap_begin # create second partial ordered extent
> >   iomap_dio_bio_iter
> >     bio_iov_iter_get_pages # read all of remainder
> >     submit_bio # partial bio with all of remainder
> >   iomap_iter
> >     btrfs_dio_iomap_end # nothing exciting to do with ordered io
> > 
> >   ====DIO ENDIO====
> >   ==FIRST PARTIAL BIO==
> >   btrfs_dio_end_io
> >     btrfs_mark_ordered_io_finished # bytes_left > 0
> > 				   # don't submit to finish_ordered_fn wq
> >   ==SECOND PARTIAL BIO==
> >   btrfs_dio_end_io
> >     btrfs_mark_ordered_io_finished # bytes_left == 0
> > 				   # submit to finish_ordered_fn wq
> > 
> >   ====BTRFS FINISH ORDERED WQ====
> >   ==FIRST PARTIAL BIO==
> >   btrfs_finish_ordered_io # called by dio_iomap_end_io, sees
> > 			  # BTRFS_ORDERED_IOERR, just drops the
> > 			  # ordered_extent
> >   ==SECOND PARTIAL BIO==
> >   btrfs_finish_ordered_io # called by btrfs_dio_end_io, writes out file
> > 			  # extents, csums, etc...
> > 
> > The essence of the problem is that while btrfs_direct_write and iomap
> > properly interact to submit all the correct bios, there is insufficient
> > logic in the btrfs dio functions (btrfs_dio_iomap_begin,
> > btrfs_dio_submit_io, btrfs_dio_end_io, and btrfs_dio_iomap_end) to
> > ensure that every bio is at least a part of a completed ordered_extent.
> > And it is completing an ordered_extent that results in crucial
> > functionality like inserting a file extent item for the range in the
> > subvolume/fs tree.
> > 
> > More specifically, btrfs_dio_end_io treats the ordered extent as
> > unfinished but btrfs_dio_iomap_end sets BTRFS_ORDERED_IOERR on it.
> > Thus, the finish io work doesn't result in file extents, csums, etc...
> > In the aftermath, such a file behaves as though it has a hole in it,
> > instead of the purportedly written data.
> > 
> > We considered a few options for fixing the bug:
> > 
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
> > ordered_extent behavior:
> > 
> > - btrfs_direct_write keeps track of an ordered_extent for the duration
> >   of a call, possible across several __iomap_dio_rws.
> > - zero the btrfs_dio_data before using it, since its fields constitute
> >   state now.
> > - btrfs_dio_write uses dio_data to pass this ordered extent into and out
> >   of __iomap_dio_rw.
> > - when the write is done, put the ordered_extent.
> > - if the short write happens to be length 0, then we _don't_ get an
> >   extra bio, so we do need to cancel the ordered_extent like we used
> >   to (and ditch the cached ordered extent)
> > - if the short write ordered_extent has an error on it, drop the cached
> >   ordered extent, as before.
> > - in btrfs_dio_iomap_begin, if the cached ordered extent is present,
> >   skip all the work of creating it, just look up the extent mapping and
> >   jump to setting up the iomap. (This part could likely be more
> >   elegant..)
> > 
> > Thanks to Josef, Christoph, and Filipe with their help figuring out the
> > bug and the fix.
> > 
> > Fixes: 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> > Link: https://lore.kernel.org/linux-btrfs/aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com/
> > Link: https://pastebin.com/3SDaH8C6
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> > Changelog:
> > v3:
> > - handle BTRFS_IOERR set on the ordered_extent in btrfs_dio_iomap_end.
> >   If the bio fails before we loop in the submission loop and exit from
> >   the loop early, we never submit a second bio covering the rest of the
> >   extent range, resulting in leaking the ordered_extent, which hangs umount.
> >   We can distinguish this from a short write in btrfs_dio_iomap_end by
> >   checking the ordered_extent.
> 
> Replaced v2 in misc-next, thanks.

Embarassingly, I have now proven that this version is _still_ broken :(

TL;DR, this "fix" reintroduces the original bug Filipe was fixing in the
first place, just a more subtle version of it.

The original bug (some pseudocode liberties taken) was:
mmap(srcfile) = buf
open(srcfile, O_DIRECT|O_WRONLY|O_TRUNC) = fd
write(fd, buf, size=sz, off=0) = HANG!!!

and the issue was that iomap_begin created an OE, and then the page
fault handler did btrfs_readahead which blocked on the OE.

this led to the bug I was fixing, which was the case:
mmap(srcfile) = buf
open(dstfile, O_DIRECT|O_WRONLY|O_TRUNC) = fd
doStuff(buf); # partially in cache
write(fd, buf, size=sz, off=0) = CORRUPTION!!!

which we fixed by making the OE once again outlive the call into iomap,
and survive across multiple partial writes. HOWEVER, now we can trigger
the same original deadlock, we just have to work a bit harder.
mmap(srcfile) = buf
open(srcfile, O_DIRECT|O_WRONLY) = fd
doStuff(buf); # partially in cache
write(fd, buf, size=sz/2, off=sz/4) = HANG!!!

Crucially, we make two changes: we make the written region overlap with
the region backing the write buffer and we remove O_TRUNC. As a result,
we create an OE [sz/4, 3sz/4], do a partial write from the start of buf
(mapped to offset 0 in srcfile), then fault and attempt to fault in the
rest of srcfile while the OE exists, which is exactly the original
deadlock. Crucially, O_TRUNC and the exactly matching read/write regions
where covering this up by forcing the fault to always happen on the 0
byte, which got special handling, rather than a true partial fault.

With all that said, I think this strategy for fixing it, by keeping the
OE around is probably dead on arrival, and I need to scrap it and split
the ordered extent on a partial bio instead.

Sorry for the churn,
Boris
