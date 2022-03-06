Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F744CED20
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 19:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiCFSQs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 13:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiCFSQq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 13:16:46 -0500
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A5B865D19
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 10:15:54 -0800 (PST)
Received: from venice.bhome ([78.12.27.75])
        by michael.mail.tiscali.it with 
        id 36El2700C1dDdji016EnH3; Sun, 06 Mar 2022 18:14:47 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/5] btrfs: add flags to give an hint to the chunk allocator
Date:   Sun,  6 Mar 2022 19:14:39 +0100
Message-Id: <b15072e61eac46aa9f61317c59219713a01ff897.1646589622.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646589622.git.kreijack@inwind.it>
References: <cover.1646589622.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1646590488; bh=k4fStNXRZTOhSgYE1Jym6cSH926IWoozudV13F4pQj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=tl27NA84w7V+AUpaRa44HkFCUUSo444kkJg8T8bmK13wOUBaKpc1W/BEp55TJ+L/3
         YY+0qRPwfnjxUBzVnOiGwx2zJ3jZsinmBOCzjPW3mrWQszzKTtvetdtnpS5hJWBS0v
         eWXC1nu80gKQ+5XbYy/HL046TvvePLOlo9EUyRGg=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add the following flags to give an hint about which chunk should be
allocated in which disk:

- BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED
  preferred for data chunk, but metadata chunk allowed
- BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED
  preferred for metadata chunk, but data chunk allowed
- BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
  only metadata chunk allowed
- BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
  only data chunk allowed

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index b069752a8ecf..e0d842c2e616 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -389,6 +389,22 @@ struct btrfs_key {
 	__u64 offset;
 } __attribute__ ((__packed__));
 
+/* dev_item.type */
+
+/* btrfs chunk allocation hint */
+#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
+/* btrfs chunk allocation hint mask */
+#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
+	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
+/* preferred data chunk, but metadata chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED	(0ULL)
+/* preferred metadata chunk, but data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED	(1ULL)
+/* only metadata chunk are allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY		(2ULL)
+/* only data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY		(3ULL)
+
 struct btrfs_dev_item {
 	/* the internal btrfs device id */
 	__le64 devid;
-- 
2.35.1

