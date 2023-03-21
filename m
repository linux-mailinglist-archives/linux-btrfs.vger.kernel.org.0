Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A7F6C3751
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 17:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCUQqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 12:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjCUQqS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 12:46:18 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2098152F73
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 09:45:58 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CB4865C0136;
        Tue, 21 Mar 2023 12:45:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 21 Mar 2023 12:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1679417145; x=
        1679503545; bh=SJXljvkua0QBQ/xrM+RYMut+xJvz2Y9iekPc3I/pppI=; b=f
        19mEuDCs8mb2BD1zZ7BbLlhEzmh0yUw9oEv5wGPB5UV083D7Nkxum7DH6nu05t1L
        7djyRkQ7sCdUZ3YuVUlMY+tv1kwzAGKdxilIJhr2s5O6bIGcL+S8NYQCox3E2Krn
        oM0it4PSKRy7OjVZZg6U0wmKitCiHStx/83XjdyR42/FUQacpsxgME9A9VkZg3e8
        EM4O1P6Z9EFyaD7fenCyayspeZqWDWpWLdbiPBeCZtSs0wvHbQRnE30AtfROqqor
        DUSfXJTIRlyrQaPu4X203EpOww0DpJUFW9uPb00lsriWCo5JLbVj+fABcU6K8TNC
        vMIcJDdbbGCykba+HT3NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679417145; x=1679503545; bh=S
        JXljvkua0QBQ/xrM+RYMut+xJvz2Y9iekPc3I/pppI=; b=F4G4GBueiFaUDGATS
        6vSrl5k3eIQDFsaPHl/piXZNFgEsf42L5Bd/eCSGMiat3/4zASb2cdDkHXEEaFZ7
        dobN0sxIBuGas818C0PDyD/ZL6tBOG48NwlTNdtLaGiPiTe6wobn8UQXbKc0KrBe
        8bWte5Ld61/moaTS4y4/rIMXqrDBrIH9GwQY/IyWCgAsFGkOeKTgYeha1AG/Y8yQ
        wmmbrU6Nqvps8b/v7d9B3Q2Lpn82Eu1iKKFhFX22kiDEAT8MpXQZ0NIzg/bRuw9f
        9ku96jujdj6VMSrvvIAaE7e/60RQbueAoeCaxh69LvbxCoWP5jKrHOXkzoheu8rE
        I9H0Q==
X-ME-Sender: <xms:Od8ZZC4YPj6MnmC2I2_7LkVJao9MKhYpp6NHZN0FrEmCM10j5dTJig>
    <xme:Od8ZZL67h8Cr3uR--bSazohHwrd03rFb5xEMQJffic619UiAkY4EngBj6BwLFBwzT
    7m0fP2OkT2CdgZS1Js>
X-ME-Received: <xmr:Od8ZZBf8_7rhLEavURYLrbTNCw629-6F4esLKj6UVzGnndJ43YRtgLQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpedvtdetffelgeeguddugffgtddtgfehgeetffegue
    eutdelgeeuheetfeetveelueenucffohhmrghinheprhgvughhrghtrdgtohhmpdhkvghr
    nhgvlhdrohhrghdpphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Od8ZZPJrkjc-4eUMm11czSPpwrJ8MthwSP02eepvO9QQ6U2HPfNgWg>
    <xmx:Od8ZZGImr9FWW8Q-5pShayBJQ70u2P6EDDu7wkaKszgvMfFVND0Sxw>
    <xmx:Od8ZZAwAToNvYvKm-ZiGwf70RepqnR0kPW_Xv22h9nnRRFHW9vRN1w>
    <xmx:Od8ZZAzlMfm4NcIO--iSh-A3uB2Xkf7g7epbn37WExnK9pwNKknGEQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 12:45:45 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 6/6] btrfs: split partial dio bios before submit
Date:   Tue, 21 Mar 2023 09:45:33 -0700
Message-Id: <1216b857841d01b0494199129068baf23546959e.1679416511.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679416511.git.boris@bur.io>
References: <cover.1679416511.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index dbea124c9fa3..69fdcbb89522 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7815,6 +7815,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	struct btrfs_dio_private *dip =
 		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_dio_data *dio_data = iter->private;
+	int err = 0;
 
 	btrfs_bio_init(bbio, BTRFS_I(iter->inode), btrfs_dio_end_io, bio->bi_private);
 	bbio->file_offset = file_offset;
@@ -7823,7 +7824,25 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
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

