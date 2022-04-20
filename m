Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20497507D92
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 02:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358563AbiDTAXP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 20:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346874AbiDTAXK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 20:23:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5822C64F
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 17:20:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30FC4210F1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650414025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBPl4uaLqtFsu+uLoGxT7RmZc7drK1E1A7PjptVhzbY=;
        b=ptKGrL2hVRSqqpmEPH0sf/Qg9nDL1/9HGwMJCaDSKllpF3bTnK0fzZO+D233x74OX4MitZ
        vzGwbq99edPvY7dUYNDmbFNwT5qulWLaDKQxwEyiq5GkKBCj+hpPJ9l3owDqQAihVA7Ri4
        DBNonK357W/rK4aV6jQGdi/UYmBc2zM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75A8B139BE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uNnXDshRX2KvZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 06/10] btrfs-progs: mkfs/sprout: add a helper to update generation for seed device
Date:   Wed, 20 Apr 2022 08:19:55 +0800
Message-Id: <c1df316ffa396a53bc34b9d921725dd00b32c06e.1650413308.git.wqu@suse.com>
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

For non-sprouted fs, generation of a device item is always 0.

But for sprouted fs, we use btrfs_dev_item::generation to store the
generation of expected seed device generation.

Here we introduce a helper to update the generation of seed device, for
the incoming seed sprout at mkfs time.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/sprout.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/mkfs/sprout.c b/mkfs/sprout.c
index eb423d082c7c..5977a73644f5 100644
--- a/mkfs/sprout.c
+++ b/mkfs/sprout.c
@@ -112,3 +112,40 @@ out:
 	close_ctree(fs_info->tree_root);
 	return ret;
 }
+
+static int update_seed_dev_geneartion(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_fs_devices *seed_devs = fs_info->fs_devices->seed;
+	struct btrfs_device *dev;
+	struct btrfs_path path;
+	int ret;
+
+	ASSERT(seed_devs);
+
+	btrfs_init_path(&path);
+	list_for_each_entry(dev, &seed_devs->devices, dev_list) {
+		struct btrfs_dev_item *di;
+		struct btrfs_key key;
+
+		key.objectid = BTRFS_DEV_ITEMS_OBJECTID;
+		key.type = BTRFS_DEV_ITEM_KEY;
+		key.offset = dev->devid;
+
+		ret = btrfs_search_slot(trans, fs_info->chunk_root, &key, &path,
+					0, 1);
+		if (ret > 0)
+			ret = -ENOENT;
+		if (ret < 0)
+			break;
+
+		di = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				    struct btrfs_dev_item);
+		btrfs_set_device_generation(path.nodes[0], di, dev->generation);
+		btrfs_mark_buffer_dirty(path.nodes[0]);
+		btrfs_release_path(&path);
+	}
+	btrfs_release_path(&path);
+	return ret;
+}
+
-- 
2.35.1

