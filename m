Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78556B0E0D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 17:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjCHQCU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 11:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjCHQBr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 11:01:47 -0500
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC299BE32
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 08:00:10 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id C6DCA80204;
        Wed,  8 Mar 2023 11:00:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1678291210; bh=N6NT81voNqYw33iHgVwrFl4prjG8yE4MAzq++Yi4RGI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=QgW+ZaEz2dy8m9YX2gYeApa+9e6BfFiBF4sah5Ih9TI6WSx87U2wwnaZwiEeG4iiZ
         FUo+qN/w6ipUe9qCDZYJ7gmdXwOzU82eH4J3vaK4hkzRzQb6dC1p3KgTcuo6OmwA+P
         jySF6JLFyWXalMMZz6gKf/F9hJ56Dy4NV9ZCk4NLFH1zNPa+rSC/4Cgje94d34gjbD
         vmThCI2s+Izu6ah5U41+XwxQ2YCtVb0O0lz86QZ586dj3PLhF4e8aoMmThifHky+El
         gx/04qhbcGkFGyai0hgcQvhBCdEqkeaAyhXvbaDuCiWrQDVNvHrFif8oK4JoYGayLn
         DkcK2beutnpdw==
Message-ID: <252e452a-a9a4-ce5e-0dd8-1b0d1bd11466@dorminy.me>
Date:   Wed, 8 Mar 2023 11:00:08 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v3] btrfs: fix dio continue after short write due to
 buffer page fault
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <6733f2fac24b674d9f60dc1093de30513c099629.1678212067.git.boris@bur.io>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <6733f2fac24b674d9f60dc1093de30513c099629.1678212067.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/7/23 15:49, Boris Burkov wrote:
> If an application is doing direct io to a btrfs file and experiences a
> page fault reading from the write buffer, iomap will issue a partial
> bio, and allow the fs to keep going. However, there was a subtle bug in
> this code path in the btrfs dio iomap implementation that led to the
> partial write ending up as a gap in the file's extents and to be read
> back as zeros.
> 
> The sequence of events in a partial write, lightly summarized and
> trimmed down for brevity is as follows:
> 
>    ====WRITING TASK====
>    btrfs_direct_write
>    __iomap_dio_write
>    iomap_iter
>      btrfs_dio_iomap_begin # create full ordered extent
>    iomap_dio_bio_iter
>      bio_iov_iter_get_pages # page fault; partial read
>      submit_bio # partial bio
>    iomap_iter
>      btrfs_dio_iomap_end
>        btrfs_mark_ordered_io_finished # sets BTRFS_ORDERED_IOERR;
> 				     # submit to finish_ordered_fn wq
>    fault_in_iov_iter_readable # btrfs_direct_write detects partial write
>    __iomap_dio_write
>    iomap_iter
>      btrfs_dio_iomap_begin # create second partial ordered extent
>    iomap_dio_bio_iter
>      bio_iov_iter_get_pages # read all of remainder
>      submit_bio # partial bio with all of remainder
>    iomap_iter
>      btrfs_dio_iomap_end # nothing exciting to do with ordered io
> 
>    ====DIO ENDIO====
>    ==FIRST PARTIAL BIO==
>    btrfs_dio_end_io
>      btrfs_mark_ordered_io_finished # bytes_left > 0
> 				   # don't submit to finish_ordered_fn wq
>    ==SECOND PARTIAL BIO==
>    btrfs_dio_end_io
>      btrfs_mark_ordered_io_finished # bytes_left == 0
> 				   # submit to finish_ordered_fn wq
> 
>    ====BTRFS FINISH ORDERED WQ====
>    ==FIRST PARTIAL BIO==
>    btrfs_finish_ordered_io # called by dio_iomap_end_io, sees
> 			  # BTRFS_ORDERED_IOERR, just drops the
> 			  # ordered_extent
>    ==SECOND PARTIAL BIO==
>    btrfs_finish_ordered_io # called by btrfs_dio_end_io, writes out file
> 			  # extents, csums, etc...
> 
> The essence of the problem is that while btrfs_direct_write and iomap
> properly interact to submit all the correct bios, there is insufficient
> logic in the btrfs dio functions (btrfs_dio_iomap_begin,
> btrfs_dio_submit_io, btrfs_dio_end_io, and btrfs_dio_iomap_end) to
> ensure that every bio is at least a part of a completed ordered_extent.
> And it is completing an ordered_extent that results in crucial
> functionality like inserting a file extent item for the range in the
> subvolume/fs tree.
> 
> More specifically, btrfs_dio_end_io treats the ordered extent as
> unfinished but btrfs_dio_iomap_end sets BTRFS_ORDERED_IOERR on it.
> Thus, the finish io work doesn't result in file extents, csums, etc...
> In the aftermath, such a file behaves as though it has a hole in it,
> instead of the purportedly written data.
> 
> We considered a few options for fixing the bug:
> 
> 1. treat the partial bio as if we had truncated the file, which would
>     result in properly finishing it.
> 2. split the ordered extent when submitting a partial bio.
> 3. cache the ordered extent across calls to __iomap_dio_rw in
>     iter->private, so that we could reuse it and correctly apply several
>     bios to it.
> 
> I had trouble with 1, and it felt the most like a hack, so I tried 2
> and 3. Since 3 has the benefit of also not creating an extra file
> extent, and avoids an ordered extent lookup during bio submission, it
> felt like the best option.
> 
> A quick summary of the changes necessary to implement this cached
> ordered_extent behavior:
> 
> - btrfs_direct_write keeps track of an ordered_extent for the duration
>    of a call, possible across several __iomap_dio_rws.
> - zero the btrfs_dio_data before using it, since its fields constitute
>    state now.
> - btrfs_dio_write uses dio_data to pass this ordered extent into and out
>    of __iomap_dio_rw.
> - when the write is done, put the ordered_extent.
> - if the short write happens to be length 0, then we _don't_ get an
>    extra bio, so we do need to cancel the ordered_extent like we used
>    to (and ditch the cached ordered extent)
> - if the short write ordered_extent has an error on it, drop the cached
>    ordered extent, as before.
> - in btrfs_dio_iomap_begin, if the cached ordered extent is present,
>    skip all the work of creating it, just look up the extent mapping and
>    jump to setting up the iomap. (This part could likely be more
>    elegant..)
> 
> Thanks to Josef, Christoph, and Filipe with their help figuring out the
> bug and the fix.
> 
> Fixes: 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> Link: https://lore.kernel.org/linux-btrfs/aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com/
> Link: https://pastebin.com/3SDaH8C6
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Boris Burkov <boris@bur.io>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> Changelog:
> v3:
> - handle BTRFS_IOERR set on the ordered_extent in btrfs_dio_iomap_end.
>    If the bio fails before we loop in the submission loop and exit from
>    the loop early, we never submit a second bio covering the rest of the
>    extent range, resulting in leaking the ordered_extent, which hangs umount.
>    We can distinguish this from a short write in btrfs_dio_iomap_end by
>    checking the ordered_extent.
> v2:
> - rename new ordered extent function
> - pull the new function into a prep patch
> - reorganize how the ordered_extent is stored/passed around to avoid so
> many annoying memsets and exposing it to fs/btrfs/file.c
> - lots of small code style improvements
> - remove unintentional whitespace changes
> - commit message improvements
> - various ASSERTs for clarity/debugging
> 
>   fs/btrfs/btrfs_inode.h |  1 +
>   fs/btrfs/file.c        | 11 +++++-
>   fs/btrfs/inode.c       | 76 +++++++++++++++++++++++++++++++-----------
>   3 files changed, 68 insertions(+), 20 deletions(-)
> 

Ran generic/250 and generic/276 each 7500 times on this patchset, with 
no failures; previously I'd hit the race condition in each after 10-50 
times.
