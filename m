Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1054E7C4136
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbjJJU2i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343647AbjJJU2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:28:37 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B26E94
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:36 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-579de633419so74863367b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969715; x=1697574515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eg5fs+zEanWgTMZW9LpTtVG6BeK+nTh05mS+PcssrsM=;
        b=vfuDDgXvC+gKizX4WJQ6KQXdv6WUmycv8nkrefsrMT40AQDehiNLbaV3E+0QoFpjty
         CFzpkKKeA9f5NYhaRX1LgFDynEWzEN7yLR6pBQTsoPCNCHH8gHdNJJPrSoL/fnrgu4jD
         TxWT9yJZy7mX8nT8nsjbih13nJ2EQw1/ZRZPIpuH+RkkReZO9ov+/dpGO1QKfJ1LHJh3
         +IXZSuxoo3i/MyT9e65HQLfw9h7BIiRDg26F6Zq4LN926uWdo13fQWfEfEr/apydQ/XF
         R28iYq/lC+SrFMNsagEZoTJlmNWev1tqUohQeAKFq1ns3ZHi7o8BRUGz9ec4h9rMAMDP
         xumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969715; x=1697574515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eg5fs+zEanWgTMZW9LpTtVG6BeK+nTh05mS+PcssrsM=;
        b=nc/E1cNVafk5I0FwYpiuKYpNE8r8WsjFHnJkx2icmN6QmKkRPwrDYC3a6XSRBndUO1
         qMfcOGIHVNwVeJzJIjN2cfYOLLMNOBFJ5G+BcYOHPgkHqWKGpN/JrPjzqkRuJDZ4FMcO
         yqCxHU1SdpjP4X53jnli5L4bsQYUn6bcFb6Zc7jgosYjdCKAe/eCAVF88mZTN3AyMAIZ
         6o24HKXhPRibFmzkmfsXX6D7snQZdaWioJAMZxBhqN29NR91IAqrGNC2Nkbk3e0Wmwmd
         1XWb/+waO0wBgtoVNVX+hEzAHNCZGEAX9LDaq0oEtgkpDoC60mwhHLij18PW/tjzCplH
         SLGA==
X-Gm-Message-State: AOJu0Ywkct9iUsUPET5iG0s8TC2EaA3xWnI32RzXBIEbvZ+DyEUTdrds
        BEUsOXUCtSQAkTjwKCKHBNSwgYXoA5lc+Dp/bsEXmQ==
X-Google-Smtp-Source: AGHT+IET4WU6w8+xEwrCFyCAdGxVA+aqpquGGHoUJgobZLWgnRAYl6/y4ZtrdKKFMcJOPOamu1iAug==
X-Received: by 2002:a81:bb48:0:b0:59e:8f6d:92e with SMTP id a8-20020a81bb48000000b0059e8f6d092emr17913484ywl.49.1696969715257;
        Tue, 10 Oct 2023 13:28:35 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d184-20020a0ddbc1000000b00586108dd8f5sm4600868ywe.18.2023.10.10.13.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:28:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 5/8] btrfs-progs: interpret encrypted file extents.
Date:   Tue, 10 Oct 2023 16:28:22 -0400
Message-ID: <92d67445dd292368cf8b67a0efb8af8d9f46c7ad.1696969632.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696969632.git.josef@toxicpanda.com>
References: <cover.1696969632.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Encrypted file extents now have the 'encryption' field set to a
encryption type plus a context length, and have an extent context
appended to the item.  This necessitates adjusting the struct to have a
variable-length fscrypt_context member at the end, and printing contexts
if one is provided.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 check/main.c               | 12 +++++++++---
 kernel-shared/print-tree.c | 25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 0979a8c6..e841ae9c 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1698,7 +1698,6 @@ static int process_file_extent(struct btrfs_root *root,
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
 		if (extent_type == BTRFS_FILE_EXTENT_PREALLOC &&
 		    (btrfs_file_extent_compression(eb, fi) ||
-		     btrfs_file_extent_encryption(eb, fi) ||
 		     btrfs_file_extent_other_encoding(eb, fi)))
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
 		if (compression && rec->nodatasum)
@@ -6352,6 +6351,7 @@ static int run_next_block(struct btrfs_root *root,
 		for (i = 0; i < nritems; i++) {
 			struct btrfs_file_extent_item *fi;
 			unsigned long inline_offset;
+			size_t extra_size = 0;
 
 			inline_offset = offsetof(struct btrfs_file_extent_item,
 						 disk_bytenr);
@@ -6487,13 +6487,19 @@ static int run_next_block(struct btrfs_root *root,
 				continue;
 
 			/* Prealloc/regular extent must have fixed item size */
+			if (btrfs_file_extent_encryption(buf, fi))
+				extra_size = btrfs_file_extent_encryption_info_size(buf, fi) +
+					sizeof(struct btrfs_encryption_info);
+
 			if (btrfs_item_size(buf, i) !=
-			    sizeof(struct btrfs_file_extent_item)) {
+			    (sizeof(struct btrfs_file_extent_item) +
+			     extra_size)) {
 				ret = -EUCLEAN;
 				error(
 			"invalid file extent item size, have %u expect %zu",
 					btrfs_item_size(buf, i),
-					sizeof(struct btrfs_file_extent_item));
+					sizeof(struct btrfs_file_extent_item) +
+					extra_size);
 				continue;
 			}
 			/* key.offset (file offset) must be aligned */
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index d7ffeccd..859eb015 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -356,6 +356,26 @@ static void compress_type_to_str(u8 compress_type, char *ret)
 	}
 }
 
+static void generate_encryption_string(struct extent_buffer *leaf,
+				       struct btrfs_file_extent_item *fi,
+				       char *ret)
+{
+	u8 policy = btrfs_file_extent_encryption(leaf, fi);
+	u32 ctxsize = btrfs_file_extent_encryption_ctx_size(leaf, fi);
+	const __u8 *ctx = (__u8 *)(leaf->data +
+				   btrfs_file_extent_encryption_ctx_offset(fi));
+
+	ret += sprintf(ret, "(%hhu, %u", policy, ctxsize);
+
+	if (ctxsize) {
+		int i;
+		ret += sprintf(ret, ": context ");
+		for (i = 0; i < ctxsize; i++)
+			ret += sprintf(ret, "%02hhx", ctx[i]);
+	}
+	sprintf(ret, ")");
+}
+
 static const char* file_extent_type_to_str(u8 type)
 {
 	switch (type) {
@@ -372,9 +392,11 @@ static void print_file_extent_item(struct extent_buffer *eb,
 {
 	unsigned char extent_type = btrfs_file_extent_type(eb, fi);
 	char compress_str[16];
+	char encrypt_str[16];
 
 	compress_type_to_str(btrfs_file_extent_compression(eb, fi),
 			     compress_str);
+	generate_encryption_string(eb, fi, encrypt_str);
 
 	printf("\t\tgeneration %llu type %hhu (%s)\n",
 			btrfs_file_extent_generation(eb, fi),
@@ -407,6 +429,9 @@ static void print_file_extent_item(struct extent_buffer *eb,
 	printf("\t\textent compression %hhu (%s)\n",
 			btrfs_file_extent_compression(eb, fi),
 			compress_str);
+	printf("\t\textent encryption %hhu (%s)\n",
+			btrfs_file_extent_encryption(eb, fi),
+			encrypt_str);
 }
 
 /* Caller should ensure sizeof(*ret) >= 16("DATA|TREE_BLOCK") */
-- 
2.41.0

