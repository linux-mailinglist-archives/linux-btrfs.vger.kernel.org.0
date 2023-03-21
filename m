Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0298E6C3752
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCUQqZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 12:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjCUQqW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 12:46:22 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6188711656
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 09:45:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1BEB85C00E0;
        Tue, 21 Mar 2023 12:45:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Mar 2023 12:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1679417144; x=
        1679503544; bh=xxveT1NlhD1MHsMmSBTdjJEHd7Q8vXuSckDasrhE94A=; b=e
        vNTOuVt0YsNi7ubkExamLmIFzQimYsS/bxyfEfCLeD2qp0cFW1tSsnwntHNCNzgK
        hk0/4Xsx7S34Yp8lZQAdb8KE96Vr9pbC3cKgG8GKiDzkNoFHqCvmkm6+P0CMGzz7
        Z/vJx8dN5cpwW91NVj6x7QDZm8sDxswX16vHQbtVVvltWP76nt6jGu9cG+d6O+x1
        I07pSQiklAtKjslLy8neABcdw1OptMkG7s0BMp7jcF/vzhr3FnOgmKMoOam7S5DF
        gaDGXCyDpcI7ZrlSEKckWHUPnJsUE2lF+tVdn7IBZUgTY7Rpyt/2M0YwI1c/vkrq
        iPPlzhAi4clM9aDQSvQlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679417144; x=1679503544; bh=x
        xveT1NlhD1MHsMmSBTdjJEHd7Q8vXuSckDasrhE94A=; b=rP4AIgLpFtyXSCucm
        0zN2BbxValW3tolNshXODi4jOZxgSdMFEWX5M87VbLbHy80ZChh45eqMJZEaLFvW
        SiLomBA0Zkyk437IvRYZ9+xbYX4tkkQtcJWbGsUPW1q9j5Yj4FCi2y0eiKEBDVnH
        Ob/dxfFevkWqBT+l5QGQl40GzY/taI0fzx8tOLTg0OiLIAYQvQDtXL7/Yaj8k3nY
        VWNNdrjQmk04hdxv0l3QLq/C7bCI5xJFGGVP0oDrFpHGHFB1zbrOCJw5Tn8/5mUG
        XK62lr5oWBTUNfomBqLTCUK0Z6wOu9PiNEXMP3FZxJPB+GPmh0zGoHyMkm+5WeBv
        PY39w==
X-ME-Sender: <xms:N98ZZI0AuZ5udYbNCjraL3StuH3illAi-3cTa0g38gr-nAMDOSMOKw>
    <xme:N98ZZDEGNttHtBnOx9lwJfA5J3Y-2XJ2VVY8iZwZWzQ0CVrXZqbCUUHQdKoGrU2MP
    1kBr4RdcvUe8phjkKc>
X-ME-Received: <xmr:N98ZZA4BHQpusbcAJDLVtRxUY-c8AzMCDgXUDArkf-zLOt_4LWtzpZAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:N98ZZB1zF7_ucLIMNFS04QBz-K3kajZFDXEhFrLCeAKB-j8o6TvzfA>
    <xmx:N98ZZLHVZ--z5I6CiQSkO-iM-ithpnqwxoVrHYM_gy33Z-AqqT9YFg>
    <xmx:N98ZZK-eRTeMcnGVQP9sKY_Kqdv4AfO_6rf6gDQAnNv663TT2Jf6aQ>
    <xmx:ON8ZZOPxt1LekzwJ8fctgmjFkS-28o-zQcrOX6tyBzloGFejevqQ_g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 12:45:43 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 5/6] btrfs: fix crash with non-zero pre in btrfs_split_ordered_extent
Date:   Tue, 21 Mar 2023 09:45:32 -0700
Message-Id: <4154ce05313d40d1ba18e0648536426240119f41.1679416511.git.boris@bur.io>
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

