Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3266B2C3D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 18:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCIRq6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 12:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCIRq5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 12:46:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B82FAFBB
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 09:46:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D04F201F5;
        Thu,  9 Mar 2023 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678384014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w9z1VwUTZQJUhGgkq15faR0TMknY3Yudc8fKS0yADYs=;
        b=wTOZ8pHH0/0n+a8XPEHwJUDbQpQeQJg9sqtvCh46wgg+vNEg0ZFWHlwNMXJvCCmCnm4ay/
        uDfZIW1giulqiyNiqoLiL37xBgcqkgArWISJ6Id8RWFa0mevQYphfL+UQXJOqvLhZuYUTS
        Ev9RsL/AXJijvK0T6cTZ+vN/ilgfmhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678384014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w9z1VwUTZQJUhGgkq15faR0TMknY3Yudc8fKS0yADYs=;
        b=v5pS25dsHJb6ZF+InW+tO3hAv6w0Vx5VSfL7r9qwDIQn25s1qheS79gbSZCn0k5pwgVVei
        0KwNHE6QCh90DQCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 281A313A10;
        Thu,  9 Mar 2023 17:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MvFQCI4bCmS+JAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Mar 2023 17:46:54 +0000
Date:   Thu, 9 Mar 2023 18:40:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3] btrfs: fix dio continue after short write due to
 buffer page fault
Message-ID: <20230309174050.GI10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6733f2fac24b674d9f60dc1093de30513c099629.1678212067.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6733f2fac24b674d9f60dc1093de30513c099629.1678212067.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 07, 2023 at 12:49:30PM -0800, Boris Burkov wrote:
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
>   ====WRITING TASK====
>   btrfs_direct_write
>   __iomap_dio_write
>   iomap_iter
>     btrfs_dio_iomap_begin # create full ordered extent
>   iomap_dio_bio_iter
>     bio_iov_iter_get_pages # page fault; partial read
>     submit_bio # partial bio
>   iomap_iter
>     btrfs_dio_iomap_end
>       btrfs_mark_ordered_io_finished # sets BTRFS_ORDERED_IOERR;
> 				     # submit to finish_ordered_fn wq
>   fault_in_iov_iter_readable # btrfs_direct_write detects partial write
>   __iomap_dio_write
>   iomap_iter
>     btrfs_dio_iomap_begin # create second partial ordered extent
>   iomap_dio_bio_iter
>     bio_iov_iter_get_pages # read all of remainder
>     submit_bio # partial bio with all of remainder
>   iomap_iter
>     btrfs_dio_iomap_end # nothing exciting to do with ordered io
> 
>   ====DIO ENDIO====
>   ==FIRST PARTIAL BIO==
>   btrfs_dio_end_io
>     btrfs_mark_ordered_io_finished # bytes_left > 0
> 				   # don't submit to finish_ordered_fn wq
>   ==SECOND PARTIAL BIO==
>   btrfs_dio_end_io
>     btrfs_mark_ordered_io_finished # bytes_left == 0
> 				   # submit to finish_ordered_fn wq
> 
>   ====BTRFS FINISH ORDERED WQ====
>   ==FIRST PARTIAL BIO==
>   btrfs_finish_ordered_io # called by dio_iomap_end_io, sees
> 			  # BTRFS_ORDERED_IOERR, just drops the
> 			  # ordered_extent
>   ==SECOND PARTIAL BIO==
>   btrfs_finish_ordered_io # called by btrfs_dio_end_io, writes out file
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
>    result in properly finishing it.
> 2. split the ordered extent when submitting a partial bio.
> 3. cache the ordered extent across calls to __iomap_dio_rw in
>    iter->private, so that we could reuse it and correctly apply several
>    bios to it.
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
>   of a call, possible across several __iomap_dio_rws.
> - zero the btrfs_dio_data before using it, since its fields constitute
>   state now.
> - btrfs_dio_write uses dio_data to pass this ordered extent into and out
>   of __iomap_dio_rw.
> - when the write is done, put the ordered_extent.
> - if the short write happens to be length 0, then we _don't_ get an
>   extra bio, so we do need to cancel the ordered_extent like we used
>   to (and ditch the cached ordered extent)
> - if the short write ordered_extent has an error on it, drop the cached
>   ordered extent, as before.
> - in btrfs_dio_iomap_begin, if the cached ordered extent is present,
>   skip all the work of creating it, just look up the extent mapping and
>   jump to setting up the iomap. (This part could likely be more
>   elegant..)
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
>   If the bio fails before we loop in the submission loop and exit from
>   the loop early, we never submit a second bio covering the rest of the
>   extent range, resulting in leaking the ordered_extent, which hangs umount.
>   We can distinguish this from a short write in btrfs_dio_iomap_end by
>   checking the ordered_extent.

Replaced v2 in misc-next, thanks.
