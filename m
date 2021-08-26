Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E563F8291
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 08:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbhHZGlb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 02:41:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54348 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbhHZGla (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 02:41:30 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 909C220163
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 06:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629960042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ySMP1o7B+ELbO5WEihCi5xUL/e02ygpGBDfqavHYpk=;
        b=M2VnG4sWZ0JZ87U/e3ufvhRV1kFxYK2NJTP8sevS4ncbUfInAVIWZpWQDvY/OOGVHJJBXA
        GALTBmpOEv6aL8CH97FO3GsWiRl1uyGJtzYWzrA5za0+dW/Saw0SD+yzR5FmjdTkUMzWRE
        nWgXLil9FuglPwDdj7kImH70mejJAso=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BDA9E13895
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 06:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id iPPxHmk3J2E+cgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 06:40:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: slightly enhance btrfs_format_csum()
Date:   Thu, 26 Aug 2021 14:40:35 +0800
Message-Id: <20210826064036.21660-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210826064036.21660-1-wqu@suse.com>
References: <20210826064036.21660-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

- Change it void
  The old one always return csum_size.

- Use snprintf()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/utils.c | 14 ++++++++------
 common/utils.h |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/common/utils.c b/common/utils.c
index e944c43ac40e..7e213146520a 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -385,18 +385,20 @@ enum btrfs_csum_type parse_csum_type(const char *s)
 	return 0;
 }
 
-int btrfs_format_csum(u16 csum_type, const u8 *data, char *output)
+void btrfs_format_csum(u16 csum_type, const u8 *data, char *output)
 {
 	int i;
+	int cur = 0;
 	const int csum_size = btrfs_csum_type_size(csum_type);
 
-	sprintf(output, "0x");
+	output[0] = '\0';
+	snprintf(output, BTRFS_CSUM_STRING_LEN, "0x");
+	cur += strlen("0x");
 	for (i = 0; i < csum_size; i++) {
-		output += 2;
-		sprintf(output, "%02x", data[i]);
+		snprintf(output + cur, BTRFS_CSUM_STRING_LEN - cur, "%02x",
+			 data[i]);
+		cur += 2;
 	}
-
-	return csum_size;
 }
 
 int get_device_info(int fd, u64 devid,
diff --git a/common/utils.h b/common/utils.h
index 8d5e78071f16..a96bbce9d234 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -46,7 +46,7 @@ enum btrfs_csum_type parse_csum_type(const char *s);
 
 /* 2 for "0x", 2 for each byte, plus nul */
 #define BTRFS_CSUM_STRING_LEN	(2 + 2 * BTRFS_CSUM_SIZE + 1)
-int btrfs_format_csum(u16 csum_type, const u8 *data, char *output);
+void btrfs_format_csum(u16 csum_type, const u8 *data, char *output);
 u64 parse_size_from_string(const char *s);
 u64 parse_qgroupid(const char *p);
 u64 arg_strtou64(const char *str);
-- 
2.32.0

