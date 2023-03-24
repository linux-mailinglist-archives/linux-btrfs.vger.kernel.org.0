Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127216C75ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCXCc4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXCcz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:32:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1067DAD
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 19:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J9V44wGXXmfUQHPkG4O4dnTG+VuidAUcoUI24gU3X4Q=; b=bg16pD9ODqfKmH1ZIxolpEPKiT
        mOoOUKvV+tRu+cFtBwhHw37K+xyp2dLVoYDa8jifG1ojNzjnn8v3UI0b+RlF/lHNKB/ol0fVsJmsJ
        X6bMiJb9DXGESSnNBR7j+FLgyTmyVPSEF249xbez4YRq2Mpb11bHgzQr5zw0i2PhoUdTnBCIMKfsT
        9Rri423ibEzaohQ32kZ6pgO67TsazqLJk7uZNA4x/pcIScTWim0qpyNWNJgaiJzGd2Vro9j/blYQz
        5w8D5eOHCewKgQOtk7WzT4ZbthC/hxug87OrWlpIKfJ0gZ8/NzspLdxqIB0/6r1pesLwY7ko5Notx
        3nXbOGnQ==;
Received: from [122.147.159.90] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfXEY-003PL3-1e;
        Fri, 24 Mar 2023 02:32:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 11/11] btrfs: split partial dio bios before submit
Date:   Fri, 24 Mar 2023 10:32:07 +0800
Message-Id: <20230324023207.544800-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324023207.544800-1-hch@lst.de>
References: <20230324023207.544800-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

If an application is doing direct io to a btrfs file and experiences a
page fault reading from the write buffer, iomap will issue a partial
bio, and allow the fs to keep going. However, there was a subtle bug in
this codepath in the btrfs dio iomap implementation that led to the
partial write ending up as a gap in the file's extents and to be read
back as zeros.

The sequence of events in a partial write, lightly summarized and
trimmed down for brevity is as follows:

====WRITING TASK====
btrfs_direct_write
__iomap_dio_write
iomap_iter
btrfs_dio_iomap_begin # create full ordered extent
iomap_dio_bio_iter
bio_iov_iter_get_pages # page fault; partial read
submit_bio # partial bio
iomap_iter
btrfs_dio_iomap_end
btrfs_mark_ordered_io_finished # sets BTRFS_ORDERED_IOERR;
			       # submit to finish_ordered_fn wq
fault_in_iov_iter_readable # btrfs_direct_write detects partial write
__iomap_dio_write
iomap_iter
btrfs_dio_iomap_begin # create second partial ordered extent
iomap_dio_bio_iter
bio_iov_iter_get_pages # read all of remainder
submit_bio # partial bio with all of remainder
iomap_iter
btrfs_dio_iomap_end # nothing exciting to do with ordered io

====DIO ENDIO====
==FIRST PARTIAL BIO==
btrfs_dio_end_io
btrfs_mark_ordered_io_finished # bytes_left > 0
			     # don't submit to finish_ordered_fn wq
==SECOND PARTIAL BIO==
btrfs_dio_end_io
btrfs_mark_ordered_io_finished # bytes_left == 0
			     # submit to finish_ordered_fn wq

====BTRFS FINISH ORDERED WQ====
==FIRST PARTIAL BIO==
btrfs_finish_ordered_io # called by dio_iomap_end_io, sees
		    # BTRFS_ORDERED_IOERR, just drops the
		    # ordered_extent
==SECOND PARTIAL BIO==
btrfs_finish_ordered_io # called by btrfs_dio_end_io, writes out file
		    # extents, csums, etc...

The essence of the problem is that while btrfs_direct_write and iomap
properly interact to submit all the correct bios, there is insufficient
logic in the btrfs dio functions (btrfs_dio_iomap_begin,
btrfs_dio_submit_io, btrfs_dio_end_io, and btrfs_dio_iomap_end) to
ensure that every bio is at least a part of a completed ordered_extent.
And it is completing an ordered_extent that results in crucial
functionality like writing out a file extent for the range.

More specifically, btrfs_dio_end_io treats the ordered extent as
unfinished but btrfs_dio_iomap_end sets BTRFS_ORDERED_IOERR on it.
Thus, the finish io work doesn't result in file extents, csums, etc...
In the aftermath, such a file behaves as though it has a hole in it,
instead of the purportedly written data.

We considered a few options for fixing the bug (apologies for any
incorrect summary of a proposal which I didn't implement and fully
understand):
1. treat the partial bio as if we had truncated the file, which would
result in properly finishing it.
2. split the ordered extent when submitting a partial bio.
3. cache the ordered extent across calls to __iomap_dio_rw in
iter->private, so that we could reuse it and correctly apply several
bios to it.

I had trouble with 1, and it felt the most like a hack, so I tried 2
and 3. Since 3 has the benefit of also not creating an extra file
extent, and avoids an ordered extent lookup during bio submission, it
felt like the best option. However, that turned out to re-introduce a
deadlock which this code discarding the ordered_extent between faults
was meant to fix in the first place. (Link to an explanation of the
deadlock below)

Therefore, go with fix #2, which requires a bit more setup work but
fixes the corruption without introducing the deadlock, which is
fundamentally caused by the ordered extent existing when we attempt to
fault in a range that overlaps with it.

Put succinctly, what this patch does is: when we submit a dio bio, check
if it is partial against the ordered extent stored in dio_data, and if it
is, extract the ordered_extent that matches the bio exactly out of the
larger ordered_extent. Keep the remaining ordered_extent around in dio_data
for cancellation in iomap_end.

Thanks to Josef, Christoph, and Filipe with their help figuring out the
bug and the fix.

Fixes: 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2169947
Link: https://lore.kernel.org/linux-btrfs/aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com/
Link: https://pastebin.com/3SDaH8C6
Link: https://lore.kernel.org/linux-btrfs/20230315195231.GW10580@twin.jikos.cz/T/#t
Signed-off-by: Boris Burkov <boris@bur.io>
[hch: refactored the ordered_extent extraction]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f72ba14dcda55e..017696ebe3fb65 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7716,6 +7716,24 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	dip->bytes = bio->bi_iter.bi_size;
 
 	dio_data->submitted += bio->bi_iter.bi_size;
+
+	/*
+	 * Check if we are doing a partial write.  If we are, we need to split
+	 * the ordered extent to match the submitted bio.  Hang on to the
+	 * remaining unfinishable ordered_extent in dio_data so that it can be
+	 * cancelled in iomap_end to avoid a deadlock wherein faulting the
+	 * remaining pages is blocked on the outstanding ordered extent.
+	 */
+	if (iter->flags & IOMAP_WRITE) {
+		int err;
+
+		err = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
+		if (err) {
+			btrfs_bio_end_io(bbio, errno_to_blk_status(err));
+			return;
+		}
+	}
+
 	btrfs_submit_bio(bbio, 0);
 }
 
-- 
2.39.2

