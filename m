Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374FF3F8290
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 08:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbhHZGla (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 02:41:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54342 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbhHZGl2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 02:41:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43B5020167
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 06:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629960041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zloGiB0NXfsBMkWQlhPGSU7SHfKOd6SaprrL+cTItd8=;
        b=LG2gYuIJmVF9NzsMZhU/lohKrOpcjyAsXbLQgyNmZSpvXZkZTRRADC+9YaBjFWqdVjUz4q
        axfBxW12Ub6kFtV3QsSqX4mdS1n5hsXn3YeLWtACtR0HWDRYEXYfbdlRLbD89qMZtcpoeR
        JgCXBSRa/SeV9fm/fxvoSJGjCs0iIsM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6EC0113895
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 06:40:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id +L5MC2g3J2E+cgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 06:40:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: move btrfs_format_csum() to common/utils.[ch]
Date:   Thu, 26 Aug 2021 14:40:34 +0800
Message-Id: <20210826064036.21660-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210826064036.21660-1-wqu@suse.com>
References: <20210826064036.21660-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function btrfs_format_csum() is a special helper only used in
btrfs-progs.

Move it to common/utils.[ch] other than leaving it in
kernel-shared/disk-io.c.

Since we're moving the code, also introduce a macro,
BTRFS_CSUM_STRING_LEN, to replace open-coded string length calculation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/utils.c          | 14 ++++++++++++++
 common/utils.h          |  4 ++++
 kernel-shared/disk-io.c | 19 ++-----------------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/common/utils.c b/common/utils.c
index cf3331808df4..e944c43ac40e 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -385,6 +385,20 @@ enum btrfs_csum_type parse_csum_type(const char *s)
 	return 0;
 }
 
+int btrfs_format_csum(u16 csum_type, const u8 *data, char *output)
+{
+	int i;
+	const int csum_size = btrfs_csum_type_size(csum_type);
+
+	sprintf(output, "0x");
+	for (i = 0; i < csum_size; i++) {
+		output += 2;
+		sprintf(output, "%02x", data[i]);
+	}
+
+	return csum_size;
+}
+
 int get_device_info(int fd, u64 devid,
 		struct btrfs_ioctl_dev_info_args *di_args)
 {
diff --git a/common/utils.h b/common/utils.h
index 277026aeb016..8d5e78071f16 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -43,6 +43,10 @@ enum exclusive_operation {
 };
 
 enum btrfs_csum_type parse_csum_type(const char *s);
+
+/* 2 for "0x", 2 for each byte, plus nul */
+#define BTRFS_CSUM_STRING_LEN	(2 + 2 * BTRFS_CSUM_SIZE + 1)
+int btrfs_format_csum(u16 csum_type, const u8 *data, char *output);
 u64 parse_size_from_string(const char *s);
 u64 parse_qgroupid(const char *p);
 u64 arg_strtou64(const char *str);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 84990a521178..8b6f5ef75804 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -162,20 +162,6 @@ int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type, const u8 *data
 	return -1;
 }
 
-int btrfs_format_csum(u16 csum_type, const u8 *data, char *output)
-{
-	int i;
-	const int csum_size = btrfs_csum_type_size(csum_type);
-
-	sprintf(output, "0x");
-	for (i = 0; i < csum_size; i++) {
-		output += 2;
-		sprintf(output, "%02x", data[i]);
-	}
-
-	return csum_size;
-}
-
 static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 				  int verify, int silent, u16 csum_type)
 {
@@ -189,9 +175,8 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 	if (verify) {
 		if (memcmp_extent_buffer(buf, result, 0, csum_size)) {
 			if (!silent) {
-				/* "0x" plus 2 hex chars for each byte plus nul */
-				char found[2 + BTRFS_CSUM_SIZE * 2 + 1];
-				char wanted[2 + BTRFS_CSUM_SIZE * 2 + 1];
+				char found[BTRFS_CSUM_STRING_LEN];
+				char wanted[BTRFS_CSUM_STRING_LEN];
 
 				btrfs_format_csum(csum_type, result, found);
 				btrfs_format_csum(csum_type, (u8 *)buf->data, wanted);
-- 
2.32.0

