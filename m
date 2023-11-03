Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88CC7E084E
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 19:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjKCShp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjKCSho (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 14:37:44 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0B6D47
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 11:37:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8832A5C0100;
        Fri,  3 Nov 2023 14:37:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 03 Nov 2023 14:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1699036657; x=1699123057; bh=X5GHwnNCuZ
        mOSDtt7+tvXysu/XAD28WLwLD+pyUhark=; b=C26VT7S1rYMLaTkvctRjrxrVoK
        9LjrNHa3FTBttoe1neldMWmBgHQtuhfhEGDi2qk/MwFvsvemlgAldDcWXwEZMFrs
        qUjy5nil9xqihyO4QbCnxahVWNiS07g+sH8irNNy1AliFWx81jfAqZ6+/oCTspXi
        JA0x6IpBHxrBPl/xbskn2poo+IMRKnDRTVadkr4Th5DlbLgNNscEpdrVDi4mfL+4
        Fox89fhzjIByfzMuziU4KRPd2PZsxUx5hzBHK3X2VpkTei8su7cCn4kTsaT2ZysB
        nZ7YDU8QM78OGahVw6Wmy50a8BKEqyWUQiQ/9aPUAwuxRl/tGpHwxo6egdpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1699036657; x=1699123057; bh=X5GHwnNCuZmOSDtt7+tvXysu/XAD
        28WLwLD+pyUhark=; b=s4HYZUMlNCNwNkNNrkdc16ANqsefwXIKepZPVhNuOVVJ
        N/7MGut3DGcvmCJ1pDWZYBJDCFsogcM++7WBj2TMCfBLxGLvDZuWOrHY3rawqWVe
        VXkc0gar1Sz0zLlVC53T/sGDfgpVyW+XdfKkxG6k2Dz6Yo9dxD9ye5jT32RgfU5+
        Hvsyp4WVy8IyL1Mt0dXCcjt1Ezz8gFJki5L+q6hyAEi7ezDNJ+0x+2RJQ4ysEmx2
        HoYCwHtxAaf596irJowE8xOt513JfYNH2bvPhARlISsIRZBvz3zsMVUmkAh7ZOSb
        uAPXgiDUmJSX0z3jH3hHjRIVBeFS5UyuGjoRcSQN/A==
X-ME-Sender: <xms:8T1FZTcfCT5jkKe-ULSshyHmlh8krU7P9YjdRfNI4HWb8HO1sLMXdw>
    <xme:8T1FZZPQl1zm9ONSXryU4qrWt69zjGdJL6MgVTJmshJ8QXFIWuC57qd8DQZ1Zxtri
    0KTOmbzUqsqJjKZpKg>
X-ME-Received: <xmr:8T1FZcg47IrRK2iTZ9PcObJT0dLDVh6YtPj_NgLjAe1IqO5igV5yahBfkEL-wOtmQBRYktBzi_UBnqnhc-lX2KtDHhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeltdffhffhvddtfeegvdeiteelieejjeeitdfhfe
    egkeehveehkeejleekgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:8T1FZU9J225M9aLFXO0oNgYLlaBk28-DOsDzrFFKyAIfrYKao-FqHA>
    <xmx:8T1FZfv0UopqenSyKmE9mY8STAm9qapclssj5QtZAkRo3yfPyHqkKg>
    <xmx:8T1FZTFttm8tXfMK_6SVvIhaG2o2bLGiEGNucVjEN-eeWgJmP4HuYg>
    <xmx:8T1FZd2m7DTgvTh-y0Opp52tGkmen6Tefh2ynuvjlcTA5DOx0Lk9Sg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Nov 2023 14:37:36 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: make OWNER_REF_KEY type value smallest among inline refs
Date:   Fri,  3 Nov 2023 11:38:57 -0700
Message-ID: <868ac4f8b351773d755e6518c6afa525371b1c56.1699036579.git.boris@bur.io>
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

Companion patch to progs for the same change in the kernel. Inline refs
are expected to have non-decreasing type value but owner ref violated
this and got away with it via special parsing. Fix the inconsistency
while it is still experimental.

Link: https://lore.kernel.org/linux-btrfs/20231103134547.GA3548732@perftesting/T/#mca2c0e21ecb7a0da616dd09980b9f008c3c00f63
Signed-off-by: Boris Burkov <boris@bur.io>
---
 kernel-shared/uapi/btrfs_tree.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index dd7593634..e2ac228bc 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -220,6 +220,9 @@
  */
 #define BTRFS_METADATA_ITEM_KEY	169
 
+/* Extent owner, used by squota. */
+#define BTRFS_EXTENT_OWNER_REF_KEY	172
+
 #define BTRFS_TREE_BLOCK_REF_KEY	176
 
 #define BTRFS_EXTENT_DATA_REF_KEY	178
@@ -230,9 +233,6 @@
 
 #define BTRFS_SHARED_DATA_REF_KEY	184
 
-/* Extent owner, used by squota. */
-#define BTRFS_EXTENT_OWNER_REF_KEY	188
-
 /*
  * block groups give us hints into the extent allocation trees.  Which
  * blocks are free etc etc
-- 
2.42.0

