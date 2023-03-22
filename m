Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEC06C549A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 20:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCVTMZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 15:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCVTMX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 15:12:23 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE45660D4B
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 12:12:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2D6B93200915;
        Wed, 22 Mar 2023 15:12:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 Mar 2023 15:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1679512328; x=
        1679598728; bh=d9SVfXYafcF4aRcE4BwSL1787RSm5xRoEsi9qXqAw/M=; b=q
        vXxx0z4FYFjlEsfeyUzHKAVlv2T6npr6n8oU2r88249SDDAEl8KFzbAW4R1oLB2o
        HLZU5HLT2cBy4sJf3enQQo5GGKgD+GAV8xgpPNNNofUDcQGaTMtjkxl7S1TFTi1M
        Y5e0VmiyTk5jOGEdozIPUFDu4i2XlFftNThaDdoXCX8FyOd3s0QK3F7NlkIJzojg
        uJ0fjIscIULnXUrYVI8ofVk03eSZWvTt6VK2UpID7adzGBgEVNgbSZlWpTLW/kzb
        ZKMXGwDL4+Vm+kqWBBhyYlrKlDGTqij7HUSxxy0THrIixeB1bLil4imxwAfVGOdy
        Ia8fUytatftqF+hZLOLCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679512328; x=1679598728; bh=d
        9SVfXYafcF4aRcE4BwSL1787RSm5xRoEsi9qXqAw/M=; b=fWe+PSh/bxa5kyXAB
        EMj8wvYeJ6Q3SdeqcyzolAnLEe/p87+G0NoRidtaOx1t/AiqKgOYf2I53w5NlU+b
        XQoRKo/tnm42z6S8JGXGO4vKx7N5QccrehmiPNSirsoTe4cyAATl3pmi8jWgCpIW
        MQIfpVVeKJCwL40j0AaBPKzc3jb7GdROoWy0Zvfwdj4WPIko2b0dh+knbHPBE4yY
        pG3CkKIIZKfFyTUJ4YrDCbJwfRUloAPCgEydflK5j19w9ReG9NVWtVlFEOlDMxWQ
        Bm6CoKN96f5zFpibWQ/j9CNj43lJXc38ZA4rM7JqucIBL+Ow60wf3bWHCZgQJyKa
        /9PHQ==
X-ME-Sender: <xms:CFMbZB92Zvkw1seHgb8oimKEMHRJazXE-n4y0VYFgDK1HKP8GF5FBA>
    <xme:CFMbZFtBSk1SwJ2ALZbaZQQMnIvznOMlcar6pUixehlFdkNICokJLKmjaPgeEX2wQ
    mwKXpbj2Mh9i2DEbpk>
X-ME-Received: <xmr:CFMbZPDtmcD3HdcJD_gJYCYEiZAySh8urp_j2K453uzHpGarT2rvcXUf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegvddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepvddtteffleeggeduudfggfdttdfgheegteffge
    euuedtleegueehteefteevleeunecuffhomhgrihhnpehrvgguhhgrthdrtghomhdpkhgv
    rhhnvghlrdhorhhgpdhprghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:CFMbZFdbcwtO2fwBW7HrfDIU9a6tOYxSwEQW5N8IqFOSbkF9sD1pDQ>
    <xmx:CFMbZGPSpWY0GgGnWTgou-s8h0IpvvHdDqGbutAxcY_w7ffUywTTbg>
    <xmx:CFMbZHkiyv1yiZ5Ztpn_0DOGX1kQgWXE2wkl4_u39QVjw90JlNqixg>
    <xmx:CFMbZAXZnAoZ91reRLguRZMKuooiX95TL5eFD8_fsm71vZfScIUPKg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Mar 2023 15:12:08 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 5/5] btrfs: split partial dio bios before submit
Date:   Wed, 22 Mar 2023 12:11:52 -0700
Message-Id: <b7c72ffeb725c2a359965655df9827bdbeebfb4e.1679512207.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679512207.git.boris@bur.io>
References: <cover.1679512207.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
---
 fs/btrfs/inode.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e30390051f15..08d132071bd3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7782,6 +7782,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	struct btrfs_dio_private *dip =
 		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_dio_data *dio_data = iter->private;
+	int err = 0;
 
 	btrfs_bio_init(bbio, BTRFS_I(iter->inode), btrfs_dio_end_io, bio->bi_private);
 	bbio->file_offset = file_offset;
@@ -7790,7 +7791,25 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	dip->bytes = bio->bi_iter.bi_size;
 
 	dio_data->submitted += bio->bi_iter.bi_size;
-	btrfs_submit_bio(bbio, 0);
+	/*
+	 * Check if we are doing a partial write. If we are, we need to split
+	 * the ordered extent to match the submitted bio. Hang on to the
+	 * remaining unfinishable ordered_extent in dio_data so that it can be
+	 * cancelled in iomap_end to avoid a deadlock wherein faulting the
+	 * remaining pages is blocked on the outstanding ordered extent.
+	 */
+	if (iter->flags & IOMAP_WRITE) {
+		struct btrfs_ordered_extent *ordered = dio_data->ordered;
+
+		ASSERT(ordered);
+		if (bio->bi_iter.bi_size < ordered->num_bytes)
+			err = btrfs_extract_ordered_extent_bio(bbio, ordered, NULL,
+							       &dio_data->ordered);
+	}
+	if (err)
+		btrfs_bio_end_io(bbio, err);
+	else
+		btrfs_submit_bio(bbio, 0);
 }
 
 static const struct iomap_ops btrfs_dio_iomap_ops = {
-- 
2.38.1

