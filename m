Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7011F5EC985
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Sep 2022 18:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiI0Qb2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Sep 2022 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiI0QbD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Sep 2022 12:31:03 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00D5CC8C4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Sep 2022 09:30:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DE9C43200708;
        Tue, 27 Sep 2022 12:30:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 27 Sep 2022 12:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1664296242; x=1664382642; bh=Y+e4551dsCWT0WIidamjkq6HH
        tDBhLX/CxujeuIb9a4=; b=NgxPyDjRuAjtzI/IVBgP/2wbItwhGsXWWnUnxMVz4
        Rw0LbFvy/+FEqPHvvJNMkatJVjuq/T1cn983+34GxBPmHCJcpWUYmDFq5nNKgjot
        Y1KaonuF4reeDVn7IIdBdmNdVuoQi0NP+S+2+9XUN1UVytiw1Q+R+fXv426hnTfW
        qNS4td6bswa4E0DP0jbA1vAdTA9DPt05+FmK3/d5rgZ0KdGZU2sPlpvvJp97GXtY
        DphQdHq/MZR3uMx7wt4LTDp30LpwUPMek16ST0nuPsf8omu2FhMRsTTLHgINf8vw
        GYsPEw/n3bAVt7B9i80JwrvPikyNycqurzP/L9o2gmTzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1664296242; x=1664382642; bh=Y+e4551dsCWT0WIidamjkq6HHtDBhLX/Cxu
        jeuIb9a4=; b=GfQYFJ1MFzDfJLxwBLRww1xyX1xNkJcYY6176P+ErCE2n4v/i5x
        Hgy2ymlaYynYD/490te8mqJojQEsOTF9pfq8Tn4DL3LPG8jNKLsVQ0OL7oNiUeSP
        v6PXbewnV71g12NTeDhllO/lVWL3rQ/DY6g34gFWmebfTRlaQsnxacTd47FYk43H
        MoSOlJadijSdyaRlXZiErQ+NsE3en7GJsAW9PrLf5uufCJOpHtYA6ugCZJKZuuGX
        KxEAjZNCAoYwO5hfP1qapNoSNDd0xFXsoi5fuYJUYPdU1mr4cI3yRPS/sRMWUXoG
        Y+MCEg07CYzkxAQ8W/IBBfbGV+K/6QESSoQ==
X-ME-Sender: <xms:MiUzY_0y8MLGRvvc207k_Sh72TB2si3qPGlJxhchOtsS1i7FLXBw6g>
    <xme:MiUzY-EfR33ofHVthXA7_mFOzKRu2uyLETWUpEMrnE6dNxx9dtBrNISCws8d-z1IY
    rogjV813U9aUvgvMUQ>
X-ME-Received: <xmr:MiUzY_4QubbFNtK3z9FbhDK4erPaYWr2V6-9T7AxJs3JXK43PkDGctsYwqtDXO_sDEgOibXv7OdrFdVJVR9vdCrFWMqkQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegiedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:MiUzY03cG0U7IRD-o4hAYKETVQmU0jWLPizoDCWxmYIJ8XNeuSJ72A>
    <xmx:MiUzYyG_CY4el6cOmx217xG0I0OCpsZZkoMo9tG_bp6r_4J7S1H-xA>
    <xmx:MiUzY1-jMI0R7H16g7U4gOoyo8CdyqfcaBn13ulmgR7-G8-FqYmMEg>
    <xmx:MiUzY9MPbN7leo24ai9AkHVPG5qnz-urRbUOr_x-9_jwPT5dY7OHrg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Sep 2022 12:30:41 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2] btrfs: send: SEND_STREAM_VERSION=3 for CONFIG_BTRFS_DEBUG
Date:   Tue, 27 Sep 2022 09:30:39 -0700
Message-Id: <dbf2e27f804704cdcb4c3e8d53d600938bbe1d61.1664296068.git.boris@bur.io>
X-Mailer: git-send-email 2.37.2
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

We haven't finalized send stream v3 yet, so gate the send stream version
behind CONFIG_BTRFS_DEBUG.

The original verity send did not check the proto version, so add that
actual protection as well.

Signed-off-by: Boris Burkov <boris@bur.io>
---
v2:
- gate protocol version; not command/attr definitions
- actually prevent sending verity data when version < 3

 fs/btrfs/send.c | 2 +-
 fs/btrfs/send.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4ef4167072b8..178347666235 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6469,7 +6469,7 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 		if (ret < 0)
 			goto out;
 	}
-	if (sctx->cur_inode_needs_verity) {
+	if (sctx->proto >= 3 && sctx->cur_inode_needs_verity) {
 		ret = process_verity(sctx);
 		if (ret < 0)
 			goto out;
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 0a4537775e0c..d6c5b87d6705 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -10,7 +10,11 @@
 #include <linux/types.h>
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
+#ifdef CONFIG_BTRFS_DEBUG
+#define BTRFS_SEND_STREAM_VERSION 3
+#else
 #define BTRFS_SEND_STREAM_VERSION 2
+#endif
 
 /*
  * In send stream v1, no command is larger than 64K. In send stream v2, no limit
-- 
2.37.2

