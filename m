Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631FA74FF7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 08:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGLGjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 02:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGLGjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 02:39:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893519BA
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 23:38:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5947B1FEEC
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689143887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/QhHdZJrWsTHTw8L+aHFlXheI78vAXaxd4gU/Hn3a4=;
        b=ddu2nXerWOUYQ+Ox5Pm0CE5KNQcUJCGQfb/SvisKHtyPdbq5GIX3V2cNHHinkUVPC+2Ahc
        umyvOVbLfA37cXm125ycqqyNrU+RKLxUVisF8IJzkcQllR1x2lT5zYORUuB52Kj5ESPLBk
        TUIGD94NCrmClPoc9Ssi6OLnc+XVqy0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8F30133DD
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IDiLIU5KrmRhDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/6] btrfs: use write_extent_buffer() to implement write_extent_buffer_*id()
Date:   Wed, 12 Jul 2023 14:37:43 +0800
Message-ID: <debbd2f6b89a01969083ab17069154daf6e336ae.1689143654.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689143654.git.wqu@suse.com>
References: <cover.1689143654.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For helpers write_extent_buffer_chunk_tree_uuid() and
write_extent_buffer_fsid(), they can be implemented by
write_extent_buffer().

And those two helpers are not that hot, they only get called during
initialization of a new tree block.

There is not much need for those slightly optimized versions.
And since they can be easily converted to one write_extent_buffer() call,
define them as inline helpers.

This would make later page/folio switch much easier, as all change only
need to happen in write_extent_buffer().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 22 ----------------------
 fs/btrfs/extent_io.h | 19 ++++++++++++++++---
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6a7abcbe6bec..4e252fd7b78a 100644
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
index c5fae3a7d911..dd46811cf2f5 100644
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
+		const void *fsid)
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

