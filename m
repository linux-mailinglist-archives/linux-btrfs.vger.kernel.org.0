Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB956FC55D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 13:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbjEILtF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 07:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbjEILtE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 07:49:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F394D40E9
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 04:49:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7349F21907
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 11:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683632941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKahlhyMyeHq92SQH9VXS87C+RYF8Xti1KK9MdntUeA=;
        b=YjIra+g1lkICx1GYEwlCP1iT8akvNxB9zKAu45XpM0Kvhop76kQ/1ahKfxwAebMTAQanRR
        YSYCekvKvcLtPw48visl6OLFdGC450zbnTMrBMkCCx3vuzTlKVlX22yQMLsxCPaDNg6Vyb
        LjTv7xxZyKmjwN0HbcsqDMizYW1KVoM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B67C6139B3
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 11:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8D6yHiwzWmQSMwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 May 2023 11:49:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: constify the buffer pointer for write functions
Date:   Tue,  9 May 2023 19:48:39 +0800
Message-Id: <f05b0b3a04ae5f2a5e7ffc86d9fb7b5baf85e419.1683632614.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683632614.git.wqu@suse.com>
References: <cover.1683632614.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following functions accept a buffer for write, which can be marked
as const:

- btrfs_pwrite()
- write_data_to_disk()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/device-utils.h     | 6 +++---
 kernel-shared/extent_io.c | 2 +-
 kernel-shared/extent_io.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/device-utils.h b/common/device-utils.h
index 6390a72951eb..21955c2835f2 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -54,7 +54,7 @@ ssize_t btrfs_direct_pread(int fd, void *buf, size_t count, off_t offset);
 ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t count, off_t offset);
 
 #ifdef BTRFS_ZONED
-static inline ssize_t btrfs_pwrite(int fd, void *buf, size_t count,
+static inline ssize_t btrfs_pwrite(int fd, const void *buf, size_t count,
 				   off_t offset, bool direct)
 {
 	if (!direct)
@@ -62,8 +62,8 @@ static inline ssize_t btrfs_pwrite(int fd, void *buf, size_t count,
 
 	return btrfs_direct_pwrite(fd, buf, count, offset);
 }
-static inline ssize_t btrfs_pread(int fd, void *buf, size_t count, off_t offset,
-				  bool direct)
+static inline ssize_t btrfs_pread(int fd, void *buf, size_t count,
+				  off_t offset, bool direct)
 {
 	if (!direct)
 		return pread(fd, buf, count, offset);
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 172ba66a1cfa..7f6d592ab641 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -477,7 +477,7 @@ int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 logical,
  * Such data will be written to all mirrors and RAID56 P/Q will also be
  * properly handled.
  */
-int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
+int write_data_to_disk(struct btrfs_fs_info *info, const void *buf, u64 offset,
 		       u64 bytes)
 {
 	struct btrfs_multi_bio *multi = NULL;
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index a1cda3a53351..b6c30eef67c2 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -128,7 +128,7 @@ int set_extent_buffer_dirty(struct extent_buffer *eb);
 int btrfs_clear_buffer_dirty(struct extent_buffer *eb);
 int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 logical,
 			u64 *len, int mirror);
-int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
+int write_data_to_disk(struct btrfs_fs_info *info, const void *buf, u64 offset,
 		       u64 bytes);
 void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
                                 unsigned long pos, unsigned long len);
-- 
2.40.1

