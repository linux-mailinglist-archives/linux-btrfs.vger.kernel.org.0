Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCC1507D8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 02:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358546AbiDTAXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 20:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358550AbiDTAXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 20:23:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2282C656
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 17:20:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F9E1210F1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650414027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdFMSr8JOAZMwhL7/26Rrs0hLzGnuoH22R3i2eSL4bo=;
        b=rJlsY+/ZEiO5vODzp9YEumulW+RqSdkoSDhqzLKRd05Y9xt896k8u6lMEen5waStRYULUu
        ceMVLdMY8i/CQuKRZyV5H6ItVnlPZcy8qb66ZR0oT8MqWgpRgDPDiFk0/mFORZD1d0dgpR
        ZJBoyLSAU54rTRNfBbjfu/yr6ege9as=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5ACC139BE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sBxcIspRX2KvZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 08/10] btrfs-progs: mkfs/sprout: introduce a helper to relocate system chunks
Date:   Wed, 20 Apr 2022 08:19:57 +0800
Message-Id: <840cf2c6421abd49b2fee4bbacfe3478baf159d9.1650413308.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650413308.git.wqu@suse.com>
References: <cover.1650413308.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In kernel, for seed sprout we always relocate all system chunks.

The reason is a little complex, at mount time, especially for
sys_chunk_array processing, we don't have any idea which device is seed
device.

And all we can access is just all deviecs with the same fsid, not even
knowing if that fsid has any seed device.

Thus kernel choose to relocate all system chunks, and remove the empty
seed system chunks to allow a proper mount.

Here we do the same thing, but since in progs we don't have chunk
relocation ability, here we just CoW every leaf, then all nodes will
also be CoWed, thus the whole chunk tree will be relocated.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/sprout.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/mkfs/sprout.c b/mkfs/sprout.c
index 66119bbe975f..38d80d789084 100644
--- a/mkfs/sprout.c
+++ b/mkfs/sprout.c
@@ -187,3 +187,57 @@ error:
 	btrfs_abort_transaction(trans, ret);
 	return ret;
 }
+
+/*
+ * Relocate all chunk tree blocks by CoWing every leaf.
+ *
+ * Kernel and btrfs-progs requires sys_chunk_array to only contain devices from
+ * current fsid.
+ *
+ * As btrfs_stripe only contains devid and dev uuid, no fsid to determine if
+ * the current device is a seed.
+ *
+ * And at sys_chunk_array read time, btrfs doesn't have seed devices setup,
+ * thus if we have a chunk with seed device in it, kernel and progs will
+ * treat it as missing directly.
+ *
+ * So we need this function to relocate all system chunks from seed device,
+ * so later we can cleanup those system chunks.
+ */
+static int sprout_relocate_chunk_tree(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *chunk_root = fs_info->chunk_root;
+	struct btrfs_key key = { 0 };
+	struct btrfs_path path;
+	int ret;
+
+	while (true) {
+		btrfs_init_path(&path);
+		ret = btrfs_search_slot(trans, chunk_root, &key, &path, 0, 1);
+		if (ret < 0)
+			break;
+		/*
+		 * This is for the first search, we should be at the first item
+		 * of chunk tree. That's expected.
+		 */
+		if (ret > 0) {
+			ASSERT(key.offset == 0 && key.type == 0 &&
+			       key.objectid == 0);
+			ret = 0;
+		}
+
+		ret = btrfs_next_leaf(chunk_root, &path);
+		if (ret < 0)
+			break;
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
+		/* Save the key for next search */
+		btrfs_item_key_to_cpu(path.nodes[0], &key, 0);
+		btrfs_release_path(&path);
+	}
+	btrfs_release_path(&path);
+	return ret;
+}
-- 
2.35.1

