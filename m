Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1452326ED9
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Feb 2021 21:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhB0UFW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Feb 2021 15:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhB0UFT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Feb 2021 15:05:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFACC06174A
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Feb 2021 12:04:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n4so9265270wmq.3
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Feb 2021 12:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zT/MzT1WKOx33vxc0wD87nB1Pa0QFbqgjB9bXUcc8kI=;
        b=kM26UIXNPbX0FBD7YGf/FV06tThMU8MlTaZ+AsXuGDq5qzQLVJB7SfqQGqj3+JXvCn
         bwb219ULOaTxnBRK+ojnU6jeMU1OCE+qegv0RsHGJt1BnlE300d9yOkWbNsx8syGOhJ2
         7nZGNIfbUeT4waGqAAtVeLQca51XjB61imrqQ+04KvUQ0xXWUdmCxtwvwC6RMb9TPShL
         6l3VLilf2OSeyLeBFaKJw+w9retRLVs6qt/SBNZV6NvLneh/NJqnvfmDINwtp93s1P6i
         /8ZiwW2OmWw5MajXdS0/Q0AT466eDDC/nARged70DJ1z8NHYYhtAgC+DE1yNGfpJhmVD
         i2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zT/MzT1WKOx33vxc0wD87nB1Pa0QFbqgjB9bXUcc8kI=;
        b=PGhVqfzdth+oBiBBnhicbk5JKnfrTtPZgWyN2JrOlZuMBAw65FOQrq/JggW8dCedYN
         1SeSpwDTrDvy4VdmDcZtxKsbl1w++pYVAwwQTbeeLciSx7c9lF4xpYZyrAab8rnTfWK0
         IpOupYNRqxsquN73SDYNErhK77/bY0vxy9GkVT6ilM5x7FZNOakg26/JaPKMZVqOlvSy
         CZGLihC9V2UgBmzv0JtBnaItOVbqb4RSZOVSFwELXL/QhsLEQnUOoRWLD05UvoNGoUAB
         FnQUKIu8GpLmjIq4vMgMKwjKrjZH/ciU3L7vGJCR9CQbsaRJJB29HvqN9o+t5sWqNekE
         W37g==
X-Gm-Message-State: AOAM532d6kYeutAaLA9ATwdCRYEB+QpY7Wsmby0Vgc5j12z+b8lRx5S5
        TPToH1+eYiL2ZM8DkdVD6pjthrEBMorchw==
X-Google-Smtp-Source: ABdhPJzE/ljJi2iAOeXqygwhMYAYVETbM24kWyYpJUOQ0r0idqzg/pg8FLl+/O7tBRCnUatnsdH/WQ==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr8542228wmd.36.1614456276309;
        Sat, 27 Feb 2021 12:04:36 -0800 (PST)
Received: from localhost.localdomain ([46.109.188.78])
        by smtp.gmail.com with ESMTPSA id j12sm4566939wrt.27.2021.02.27.12.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 12:04:35 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH] btrfs-progs: Fix checksum output for "checksum verify failed"
Date:   Sat, 27 Feb 2021 22:07:02 +0200
Message-Id: <20210227200702.11977-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently only single checksum byte is outputted.
This fixes it so that full checksum is outputted.

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 kernel-shared/disk-io.c | 47 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 6f584986..8773eed7 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -160,10 +160,45 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
 	return -1;
 }
 
+int btrfs_format_csum(u16 csum_type, const char *data, char *output)
+{
+	int i;
+	int csum_len = 0;
+	int position = 0;
+	int direction = 1;
+	switch (csum_type) {
+		case BTRFS_CSUM_TYPE_CRC32:
+			csum_len = 4;
+			position = csum_len - 1;
+			direction = -1;
+			break;
+		case BTRFS_CSUM_TYPE_XXHASH:
+			csum_len = 8;
+			position = csum_len - 1;
+			direction = -1;
+			break;
+		case BTRFS_CSUM_TYPE_SHA256:
+		case BTRFS_CSUM_TYPE_BLAKE2:
+			csum_len = 32;
+			break;
+		default:
+			fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
+			ASSERT(0);
+	}
+
+	for (i = 0; i < csum_len; i++) {
+		sprintf(output + i*2, "%02X", data[position + i*direction] & 0xFF);
+	}
+
+	return csum_len;
+}
+
 static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 				  int verify, int silent, u16 csum_type)
 {
 	u8 result[BTRFS_CSUM_SIZE];
+	char found[BTRFS_CSUM_SIZE * 2 + 1]; // 2 hex chars for each byte + null
+	char expected[BTRFS_CSUM_SIZE * 2 + 1];
 	u32 len;
 
 	len = buf->len - BTRFS_CSUM_SIZE;
@@ -172,12 +207,14 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 
 	if (verify) {
 		if (memcmp_extent_buffer(buf, result, 0, csum_size)) {
-			/* FIXME: format */
-			if (!silent)
-				printk("checksum verify failed on %llu found %08X wanted %08X\n",
+			if (!silent) {
+				btrfs_format_csum(csum_type, (char *)result, found);
+				btrfs_format_csum(csum_type, buf->data, expected);
+				printk("checksum verify failed on %llu found %s wanted %s\n",
 				       (unsigned long long)buf->start,
-				       result[0],
-				       buf->data[0]);
+				       found,
+				       expected);
+			}
 			return 1;
 		}
 	} else {
-- 
2.30.1

