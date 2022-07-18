Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFE578D5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 00:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiGRWNX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 18:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiGRWNW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 18:13:22 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F24D32444
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 15:13:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D3D15C00FB;
        Mon, 18 Jul 2022 18:13:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jul 2022 18:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1658182400; x=1658268800; bh=Fr
        prrIhu/QyDoqH7s/Cgy/A2X71xrYogcleBz0brMCE=; b=QKWFbPdnC8v6YwlE7Q
        58mtSeFj9a5UD2bF+fXecPJ8Te8xHxwbmxmA4kW2H6dIXKcROz62rNeaE/uM1ra2
        XldZAmfaqKADJPUJCvfYtKCKPsjppkHWS6XNRMLxym9Q2QqFC/6BID1bA5PEzq2+
        rZg869eOJ46sM3MFmwp3PBLtLC02/dHBMr2u4NLchuqwRUpbQEOTOXqmSXP6s02e
        BrXYc+D/dLKuqjR5aF5WmBp+dRbxChhcH99ttaZP9c9aU3fB0WNkg9Itb3rGc9Fh
        u0luIWPmuUPlaMuC3uRYR0eFqOdz1NLRxZ2weD+mfCveUACCLIRfgXse/qxk8z0v
        JRJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1658182400; x=1658268800; bh=FrprrIhu/QyDo
        qH7s/Cgy/A2X71xrYogcleBz0brMCE=; b=hQ2WSTd2KdFbQXuZu+fpKns1zLzeh
        DTEk8CRcvtw70jfgLB3wrBbKghcQzQG1zD9V8rysQ++3t0LrS+JgAt63nsDm0dV/
        8mTxgNgpJZHN7gEZ2bBxmugKtVenipIdGyvYTduXqTrulMIexPX7jJtIvq8Wdpdi
        8Ek6lShEm1hbHAtSGnlfTZbjeorQ6VmJdIlZ7Jl89P+3E7lbvy058E4Fr8tA9YhO
        GwiIZUe8E99O9QKYz7fFdorOn/FrSXNx9X0t348gsRkVR9NdfZGcHIIDDg1/awlT
        1V5AmwIvACnHzHvP4zTEnN6CEAj3K9zThHzadJEAy+BCk8YYKOt5u8C4g==
X-ME-Sender: <xms:ANvVYtYv_CD4lZCRpctakXiRbJOie4MY1Qv2GUIxruQuz0tAugFOng>
    <xme:ANvVYka-mJOWmhZk8pLM4JjGvzpnCa7mh4fT6J-HtkJxNlFSEPsIp3smYFiWYbzIe
    JRWuVbnXB-nx06pfoQ>
X-ME-Received: <xmr:ANvVYv8_5CbaqqyrgZNI9CHn7hCO8esC_UY7PZr0AatWbwCbHNDTiBSLaR1dM5TIqRkUMUpRLbgfFpdtL0upT3XPNCAEtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:ANvVYrrFpQZi9_JwwEtN_lAtKFH1h9quTBXSNIPtvHCbrnqJHVCJtw>
    <xmx:ANvVYooQ9pO7MhqnFBqGPkoiLqjl3rv602FtK1rrlWB-2oHyeFyjSQ>
    <xmx:ANvVYhSjv35TJnO5Q-b350jXcckqQxoiz-a8c-P6YcgRJFSuIVVc6g>
    <xmx:ANvVYvS9U5CaYvlKoUp-7hp2cIHysLy-7F8KGrnCbu8SrivpXckivw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Jul 2022 18:13:20 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 4/4] btrfs-progs: add VERITY ro compat flag
Date:   Mon, 18 Jul 2022 15:13:11 -0700
Message-Id: <c111cd8c8996902fda08e32171cfea86b16c581d.1658182042.git.boris@bur.io>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658182042.git.boris@bur.io>
References: <cover.1658182042.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This compat flag is missing, but is being checked by mount, and could
well be present legitimately.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 kernel-shared/ctree.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index fc8b61eda..2070a6e51 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -484,6 +484,7 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
  * tree.
  */
 #define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
+#define BTRFS_FEATURE_COMPAT_RO_VERITY			(1ULL << 2)
 
 #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
 #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
@@ -514,7 +515,8 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
  */
 #define BTRFS_FEATURE_COMPAT_RO_SUPP			\
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
-	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID)
+	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |\
+	 BTRFS_FEATURE_COMPAT_RO_VERITY)
 
 #if EXPERIMENTAL
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
-- 
2.37.1

