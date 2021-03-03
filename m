Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7180A32C54F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450703AbhCDAT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhCCTRr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Mar 2021 14:17:47 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E61C06175F
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Mar 2021 11:16:57 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id l4so10413157qkl.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Mar 2021 11:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6moVGHPaqMgpCCTMjKhvhGagci8g711nv7kAeckayM=;
        b=Bt8jR8olvYLCcr3V8MDyoThJRrxF0Nhdg58fDYyngBPA56WiatIwYCWmorn0WK9FDq
         c+dSWvauJo/dULfQWGQ454AmLcnd73Aidzm8eW/Ry83mr/DxEMiNJsvLFmU/jCBBRRqE
         rHkLg6Y867PNbsNNt5+6FX2BAmrtOtcVh9SifT64VGAlbHKKPIQvkhW3cHPgKxOQjIUh
         EciTl6mM8rPHv+atOa91njYEbaJ1O4YMgsHIab9SSddgd5Qgo6juXE+fsaNiTS9UleUI
         s1NZeiWK/kun1qgAebEEhI2banurd42NWql4Oyf8SqWLq6iUAjRkrIIASOOzNutT4Ovq
         Qi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6moVGHPaqMgpCCTMjKhvhGagci8g711nv7kAeckayM=;
        b=Vdqi0mmIPfz95yfNsLtJdkVF+SZgHFzi2VQvIZF8EQhUIM9pIuoBLghvJBMO7u2HkU
         SM7s5n3PHhmWhY08SpCi1uo2ifwGgDE3sZEnHdUETnt0vxZKdspJC0BRErfl+ibteaBV
         U9HK72BBU+JheO940PRe2T5aoxpixE3eCicVGkqNzai9BVVgkANZFpbOusHtMdZ4ff8/
         2mlNAj+ZhC8lRKAV0brMMZiKnrpaHH2XUUmFfQ3gXN1EHzmn8wLC8f2LOzIMavQ+ZJBJ
         fTNjOdQLkNw3N6QOfgN4UH418Aun1qlwMekse0RyZVRGxPijt6VRLsjO6EVyAPK38UgR
         sjug==
X-Gm-Message-State: AOAM530UFHQ9dsowGm/xwXtEzigvv6bzofBphDAVhEyluWIhmvtQflmJ
        rAP7OJpAlnY0o5TV20YHdOdrFcIFeWspmg==
X-Google-Smtp-Source: ABdhPJwULVCdkeCNMQwVgn3gzqO2BtfIrTSByNBPY00m9OJwpQRM6CjWkvbQgkfz1V7W7jjf4DCfTQ==
X-Received: by 2002:a37:d01:: with SMTP id 1mr491335qkn.247.1614799016370;
        Wed, 03 Mar 2021 11:16:56 -0800 (PST)
Received: from localhost.localdomain ([81.198.235.160])
        by smtp.gmail.com with ESMTPSA id q8sm18400316qkn.39.2021.03.03.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 11:16:55 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH v2] btrfs-progs: Fix checksum output for "checksum verify failed"
Date:   Wed,  3 Mar 2021 21:18:44 +0200
Message-Id: <20210303191843.6878-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210227200702.11977-1-davispuh@gmail.com>
References: <20210227200702.11977-1-davispuh@gmail.com>
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
 kernel-shared/disk-io.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 6f584986..10b2421e 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -160,10 +160,30 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
 	return -1;
 }
 
+int btrfs_format_csum(u16 csum_type, u16 csum_size, const char *data, char *output)
+{
+	int i;
+	int position = 0;
+	int direction = 1;
+	if (csum_type == BTRFS_CSUM_TYPE_CRC32 ||
+		csum_type == BTRFS_CSUM_TYPE_XXHASH) {
+		position = csum_size - 1;
+		direction = -1;
+	}
+
+	for (i = 0; i < csum_size; i++) {
+		sprintf(output + i*2, "%02X", data[position + i*direction] & 0xFF);
+	}
+
+	return csum_size;
+}
+
 static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 				  int verify, int silent, u16 csum_type)
 {
 	u8 result[BTRFS_CSUM_SIZE];
+	char found[BTRFS_CSUM_SIZE * 2 + 1]; // 2 hex chars for each byte + null
+	char wanted[BTRFS_CSUM_SIZE * 2 + 1];
 	u32 len;
 
 	len = buf->len - BTRFS_CSUM_SIZE;
@@ -172,12 +192,14 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 
 	if (verify) {
 		if (memcmp_extent_buffer(buf, result, 0, csum_size)) {
-			/* FIXME: format */
-			if (!silent)
-				printk("checksum verify failed on %llu found %08X wanted %08X\n",
+			if (!silent) {
+				btrfs_format_csum(csum_type, csum_size, (char *)result, found);
+				btrfs_format_csum(csum_type, csum_size, buf->data, wanted);
+				printk("checksum verify failed on %llu wanted %s found %s\n",
 				       (unsigned long long)buf->start,
-				       result[0],
-				       buf->data[0]);
+				       wanted,
+				       found);
+			}
 			return 1;
 		}
 	} else {
-- 
2.30.1

