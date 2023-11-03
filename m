Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F337E0848
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 19:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjKCShK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjKCShJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 14:37:09 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A218D52
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 11:37:03 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E2005C00CD;
        Fri,  3 Nov 2023 14:37:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 03 Nov 2023 14:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1699036620; x=1699123020; bh=39R9wdV6gy
        q1gw7RGjRkki4R6KWJ0FTEo95ZYXft5+k=; b=DByQtIQkH8fJjMyXbob9d44onq
        BtnLEGU3Pys7LanoX4PfuXEq42ivR/gy25WpHcXyYrz6INd//4f9ieVU6CeMh3Bf
        41U5Q+IDb8EtriVwkFjRI8ok6YITEh39x4ma9DEyg8VrgqamcEhWenSxW1QACjuC
        3a43aGVZqIuLNXF+ljbLtMeupO5OxqcOkMo75iIZnvGW+ad7uBcvcuzBdVqMGVjT
        ppI3/nS7QGAdHwSjRvbJgqn/F3lMm/Nk88IN1L9xIvnlqx9fSEpqaR6APlYjKVqV
        vzZXpGCe7+2QIPYkpI76EzoaxCLFcy+/AmidMo6GELwNE3H1mODvu0pd+3Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1699036620; x=1699123020; bh=39R9wdV6gyq1gw7RGjRkki4R6KWJ
        0FTEo95ZYXft5+k=; b=cH5+61CO73sdTJrF9t1tuC2yFcbh51CeDQmz3BWGPHsd
        M3EC/YD1nZLjeRNbfsEua3/7st3yyQcPIOtPhpzgN9Ju+CkmoKAmM7HUNWfQzK+k
        7Kuhi61VrkgT6UhjqlihfTsLhrV1vkSJuzzOmAtUAyM33hh7xK0Nq4HXwnlPDn9g
        v8pLrBVEE7Oa6wWV7MsVKAFdVbeERktOXpjXAO1wPk2UmIAN5ZhyT6ddenLg/Nre
        Lh7Puo0Bp47mReXmnna0Syy6n9HnX/JSYjlBWdRQ/10Q2YQ0bxGDVdZ2W+gKTkXj
        5Qb5kyPOXEtNJArwXUZ+sswBh6T0B4d5/6dDBKVzvw==
X-ME-Sender: <xms:zD1FZSpJdpUNxAxMvynpZUCom957cWUKQjSdq-q2QD-PVeU28fS_dw>
    <xme:zD1FZQr_xg-T6FJm5SNfcbOxprVAYWBfc87RBhnQ2aJZWk-mjtvNWiSyYbn9MwIZl
    aVAxdLyv7rDghW_qMc>
X-ME-Received: <xmr:zD1FZXPrdUHK714TRAQ2BRxeRVFrtVfYIg1TDJeXMORUNtdgu64U-f1_L-EJjj6-ASjzlCx0JbDyUowB_dMQeBTSxBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:zD1FZR7-pd22LeGoimwjFYXEKhjtAm4F4i--J_Xk9WpX66YPEX5qnQ>
    <xmx:zD1FZR7r5wWssbDw9ol832NbB7mGKTV8yP6nD6y_Tf1iHKzZ8NkKkw>
    <xmx:zD1FZRisiiWhlAASPoUCv3FZaD8BzodezTBBA5ckg4WXCYbEaaLJiw>
    <xmx:zD1FZejjW0rtshnemMZtok5RkO-6xVQxHr1V6kwuOWA2Mb-RPFfNxQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Nov 2023 14:36:59 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: make OWNER_REF_KEY type value smallest among inline refs
Date:   Fri,  3 Nov 2023 11:38:04 -0700
Message-ID: <9336edeaca6f158da080da16b9c2ee0270d671a9.1699036594.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTRFS_EXTENT_OWNER_REF_KEY is the type of simple quotas extent owner
refs. This special inline ref goes in front of all other inline refs.

In general, inline refs have a required sorted order s.t. type never
decreases (among other requirements). This was recently reified into a
tree-checker and fsck rule, which broke simple quotas. To be fair,
though, in a sense, the new owner ref item had also violated that not
yet fully enforced requirement.

This fix brings the owner ref item into compliance with the requirement
that inline ref type never decrease.

btrfs/301 exercises this behavior and should pass again with this fix.

Fixes: 1d014d89f9ef (btrfs: tree-checker: add type and sequence check for inline backrefs)
Signed-off-by: Boris Burkov <boris@bur.io>
---
 include/uapi/linux/btrfs_tree.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index c25fc9614594..d24e8e121507 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -219,6 +219,22 @@
  */
 #define BTRFS_METADATA_ITEM_KEY	169
 
+/*
+ * Special inline ref key which stores the id of the subvolume which originally
+ * created the extent. This subvolume owns the extent permanently from the
+ * perspective of simple quotas. Needed to know which subvolume to free quota
+ * usage from when the extent is deleted.
+ *
+ * Stored as an inline ref rather to avoid wasting space on a separate item on
+ * top of the existing extent item. However, unlike the other inline refs,
+ * there is one one owner ref per extent rather than one per extent.
+ *
+ * Because of this, it goes at the front of the list of inline refs, and thus
+ * must have a lower type value than any other inline ref type (to satisfy the
+ * disk format rule that inline refs have non-decreasing type).
+ */
+#define BTRFS_EXTENT_OWNER_REF_KEY	172
+
 #define BTRFS_TREE_BLOCK_REF_KEY	176
 
 #define BTRFS_EXTENT_DATA_REF_KEY	178
@@ -233,14 +249,6 @@
 
 #define BTRFS_SHARED_DATA_REF_KEY	184
 
-/*
- * Special inline ref key which stores the id of the subvolume which originally
- * created the extent. This subvolume owns the extent permanently from the
- * perspective of simple quotas. Needed to know which subvolume to free quota
- * usage from when the extent is deleted.
- */
-#define BTRFS_EXTENT_OWNER_REF_KEY	188
-
 /*
  * block groups give us hints into the extent allocation trees.  Which
  * blocks are free etc etc
-- 
2.42.0

