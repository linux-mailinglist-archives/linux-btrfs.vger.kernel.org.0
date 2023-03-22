Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CC26C549B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 20:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjCVTMY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 15:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjCVTMV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 15:12:21 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9657560A9D
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 12:12:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 69CFB32006F2;
        Wed, 22 Mar 2023 15:12:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 22 Mar 2023 15:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1679512325; x=
        1679598725; bh=xxveT1NlhD1MHsMmSBTdjJEHd7Q8vXuSckDasrhE94A=; b=t
        3Fcu4K6JcpfC9qjRX/dh/d61YDhgGOvxZDhC+oczTD21ZlWeAAAW6mQkgsee6n3m
        +Fr6ArhXar/Q301v0ue5teAeVxXL56dEk7rxfP258DljpHg7KqDyTDm4mLkxxYgg
        4r91PWNlSvQmcalzKHxqKzppnZFu2BLy7w1pbxHZ//iG/wW5Ti9+g/75aPlt/xqO
        4VTlSUUfLGJANY6BSz493rvbwGME/JoAkd0mPQxzdngOSQSHpu1EI9eE23Pz1uPg
        rK1mZ6HxK7wRJeL8tTdbMJ38qRXcpFSp2BS+MhXPAdV9QGDjGOC9TK0AdgJvs1HO
        80UmjlFwR5Gw1tlNZt9wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679512325; x=1679598725; bh=x
        xveT1NlhD1MHsMmSBTdjJEHd7Q8vXuSckDasrhE94A=; b=O9EOLc2MEM1tNqUb0
        h5BP7Ppq1R36PHDH+ykampOxKVhF94pZd6G/Pr1bBnBCBRK5EBJ/B20YfoAkSGk+
        hTLVtvo9ODRA1R2fpD/otMAGjIvKCqWH9j63M1hZ+UYaechgkizeUB6a+GHxGJnm
        4tvL6cRmVnGSmJlAfkTA2FDvGydWfdadyPg55L2qtB2LO2SFJGC/9OK0k78sliCM
        /d4BHK5utHnGkdG+TeAl22RBejLFRD0qZdfT9csDcszvYVQd+pjIFuGXaYY5PYu4
        jTXlNrIBBQNbJPssWqYQY2WhIIj/IkhytGdMT3QcoPqq5YdfFYfNvCX7JZM6RIi7
        rIFkA==
X-ME-Sender: <xms:BVMbZASfrcw8103BI0vkMbdlknRDC0A2x12s3_HiBd_bdocaf1Easw>
    <xme:BVMbZNxocHobFKq6eF8pwRvQQ7HnZx42mgT51qIx2ZABTnsgmkQBi9-9gkxQuJOkI
    l2DfbB-wHm05TvOHdc>
X-ME-Received: <xmr:BVMbZN2lQorDNjGv-RLd2x4KWGYi0lXFEY20oqCW47gG9lV2XvN-I0oJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegvddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:BVMbZECZBJLZ7zuJy1R3URJH8CjCWERMRV9CR6IKEDz5y5HCgjZfaw>
    <xmx:BVMbZJiE6FASlBwH_I7TXZlg2rTV4kv3O_xGaAtM9OckvtUe4EpUXw>
    <xmx:BVMbZAqhJ-dWJLEXWvDJMPN2npdK9-wkstu8cPWPEBPuQe9aRFakjg>
    <xmx:BVMbZJLB2Zv_bqm-4wz-9_HaFXohLy8DVmbQ5jxlUWjb97xSvemB7g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Mar 2023 15:12:05 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 4/5] btrfs: fix crash with non-zero pre in btrfs_split_ordered_extent
Date:   Wed, 22 Mar 2023 12:11:51 -0700
Message-Id: <b8c66eeedfcea2c068befcd40de6a95cf5d64d7b.1679512207.git.boris@bur.io>
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

if pre != 0 in btrfs_split_ordered_extent, then we do the following:
1. remove ordered (at file_offset) from the rb tree
2. modify file_offset+=pre
3. re-insert ordered
4. clone an ordered extent at offset 0 length pre from ordered.
5. clone an ordered extent for the post range, if necessary.

step 4 is not correct, as at this point, the start of ordered is already
the end of the desired new pre extent. Further this causes a panic when
btrfs_alloc_ordered_extent sees that the node (from the modified and
re-inserted ordered) is already present at file_offset + 0 = file_offset.

We can fix this by either using a negative offset, or by moving the
clone of the pre extent to after we remove the original one, but before
we modify and re-insert it. The former feels quite kludgy, as we are
"cloning" from outside the range of the ordered extent, so opt for the
latter, which does have some locking annoyances.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ordered-data.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4bebebb9b434..d14a3fe1a113 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1161,6 +1161,17 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered,
 	if (tree->last == node)
 		tree->last = NULL;
 
+	if (pre) {
+		spin_unlock_irq(&tree->lock);
+		oe = clone_ordered_extent(ordered, 0, pre);
+		ret = IS_ERR(oe) ? PTR_ERR(oe) : 0;
+		if (!ret && ret_pre)
+			*ret_pre = oe;
+		if (ret)
+			goto out;
+		spin_lock_irq(&tree->lock);
+	}
+
 	ordered->file_offset += pre;
 	ordered->disk_bytenr += pre;
 	ordered->num_bytes -= (pre + post);
@@ -1176,18 +1187,13 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered,
 
 	spin_unlock_irq(&tree->lock);
 
-	if (pre) {
-		oe = clone_ordered_extent(ordered, 0, pre);
-		ret = IS_ERR(oe) ? PTR_ERR(oe) : 0;
-		if (!ret && ret_pre)
-			*ret_pre = oe;
-	}
-	if (!ret && post) {
+	if (post) {
 		oe = clone_ordered_extent(ordered, pre + ordered->disk_num_bytes, post);
 		ret = IS_ERR(oe) ? PTR_ERR(oe) : 0;
 		if (!ret && ret_post)
 			*ret_post = oe;
 	}
+out:
 	return ret;
 }
 
-- 
2.38.1

