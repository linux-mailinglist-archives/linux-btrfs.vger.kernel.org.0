Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3D754864
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 13:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGOLJC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jul 2023 07:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGOLJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jul 2023 07:09:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9727269D
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 04:08:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F4D31F38D;
        Sat, 15 Jul 2023 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689419338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P6R01ThtRCS3AIeTebMp//qoxUJzphloI3ob3DHF/LQ=;
        b=jtjqm94Vro4s73+xlmQUpPE6+bRt2gpF2K1bZLGDz4eWo5ibYlbQk3gvftirAXktpe6cf3
        9dpCLy0MlIKqF2mzqgz0ePUlBezTZJQvUjS/mx75SxD74VQJM6vqqOfBz51FXWV5k/5K91
        Ui5VIdfB1qnt1b8rJTCu0FORie9ZV2I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88DF0133F7;
        Sat, 15 Jul 2023 11:08:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EJ6DFEl+smRcZwAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 15 Jul 2023 11:08:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v3 4/8] btrfs: use write_extent_buffer() to implement write_extent_buffer_*id()
Date:   Sat, 15 Jul 2023 19:08:30 +0800
Message-ID: <4ced223cb82569a6cbe57dea6237024ededfed2a.1689418958.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689418958.git.wqu@suse.com>
References: <cover.1689418958.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Helpers write_extent_buffer_chunk_tree_uuid() and
write_extent_buffer_fsid(), they can be implemented by
write_extent_buffer().

These two helpers are not that frequently used, they only get called
during initialization of a new tree block.  There is not much need for
those slightly optimized versions.  And since they can be easily
converted to one write_extent_buffer() call, define them as inline
helpers.

This would make later page/folio switch much easier, as all change only
need to happen in write_extent_buffer().

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 22 ----------------------
 fs/btrfs/extent_io.h | 19 ++++++++++++++++---
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4acc6d05c467..aabb59cb3669 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4175,28 +4175,6 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
 	}
 }
 
-void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
-		const void *srcv)
-{
-	char *kaddr;
-
-	assert_eb_page_uptodate(eb, eb->pages[0]);
-	kaddr = page_address(eb->pages[0]) +
-		get_eb_offset_in_page(eb, offsetof(struct btrfs_header,
-						   chunk_tree_uuid));
-	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
-}
-
-void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
-{
-	char *kaddr;
-
-	assert_eb_page_uptodate(eb, eb->pages[0]);
-	kaddr = page_address(eb->pages[0]) +
-		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, fsid));
-	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
-}
-
 void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 			 unsigned long start, unsigned long len)
 {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c5fae3a7d911..5966d810af7b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -236,11 +236,24 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 				       void __user *dst, unsigned long start,
 				       unsigned long len);
-void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *src);
-void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
-		const void *src);
 void write_extent_buffer(const struct extent_buffer *eb, const void *src,
 			 unsigned long start, unsigned long len);
+
+static inline void write_extent_buffer_chunk_tree_uuid(
+		const struct extent_buffer *eb, const void *chunk_tree_uuid)
+{
+	write_extent_buffer(eb, chunk_tree_uuid,
+			    offsetof(struct btrfs_header, chunk_tree_uuid),
+			    BTRFS_FSID_SIZE);
+}
+
+static inline void write_extent_buffer_fsid(const struct extent_buffer *eb,
+					    const void *fsid)
+{
+	write_extent_buffer(eb, fsid, offsetof(struct btrfs_header, fsid),
+			    BTRFS_FSID_SIZE);
+}
+
 void copy_extent_buffer_full(const struct extent_buffer *dst,
 			     const struct extent_buffer *src);
 void copy_extent_buffer(const struct extent_buffer *dst,
-- 
2.41.0

