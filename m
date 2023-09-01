Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13E178FAFE
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Sep 2023 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbjIAJhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 05:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjIAJhw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 05:37:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05CEC0
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 02:37:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E897212AE
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 09:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693561067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ebTOoxH2VQQrOhrH4N/0UQDcIF3Z1/VfkOIGoob8myw=;
        b=NgDGCCkmwMep1Yuu6R9F2YxqKHPnuamnWh7HWyD5ZYXjM+N1IN4oyr0u28BqPb/pSPffte
        9Cf2ZdXLtUiZ0+wrkceqnUpvbhPXd0295/qSdaW2AxgCyYFQcYQ/67XNXvbOACKsLAGlON
        Zg9GqOlS6184YK0kbC0akvqgyIIPTPk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F24E013582
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 09:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oFZ9Luqw8WSJRQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Sep 2023 09:37:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: libbtrfs: fix API compatibility change
Date:   Fri,  1 Sep 2023 17:37:44 +0800
Message-ID: <4d54ca8fb8605704260aad205acd6185fe73fb49.1693561063.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In commit 83ab92512e79 ("libbtrfs: remove the support for fs without
uuid tree"), the change to libbtrfs leads to an incompatible API change.

It's mostly in the subvol_info structure, that with the removed rb_node
structures, the subvol_info can no longer be compatible to older
versions due to the changed offset of the new members.

Fix it by adding back the old rb_node members mostly as a place holder.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 libbtrfs/send-utils.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/libbtrfs/send-utils.h b/libbtrfs/send-utils.h
index be6f91b1d7bb..02f519c84804 100644
--- a/libbtrfs/send-utils.h
+++ b/libbtrfs/send-utils.h
@@ -43,6 +43,14 @@ enum subvol_search_type {
 };
 
 struct subvol_info {
+	/*
+	 * Those members are not longre utilized, but still need to be there
+	 * for API compatibility.
+	 */
+	struct rb_node rb_root_id_node;
+	struct rb_node rb_local_node;
+	struct rb_node rb_received_node;
+	struct rb_node rb_path_node;
 
 	u64 root_id;
 	u8 uuid[BTRFS_UUID_SIZE];
@@ -58,6 +66,14 @@ struct subvol_info {
 
 struct subvol_uuid_search {
 	int mnt_fd;
+
+	/* The following members are deprecated. */
+	int __uuid_tree_existed;
+
+	struct rb_root __root_id_subvols;
+	struct rb_root __local_subvols;
+	struct rb_root __received_subvols;
+	struct rb_root __path_subvols;
 };
 
 int subvol_uuid_search_init(int mnt_fd, struct subvol_uuid_search *s);
-- 
2.41.0

