Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B0F7C413A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjJJU2k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343780AbjJJU2j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:28:39 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549E791
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:37 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d89ba259964so6696985276.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969716; x=1697574516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u46hLMNS4RzQTNNSS2Qms4cPdJOoCgyXOu0Gun9Lx4=;
        b=ytV3W6JNz6ZKUO5mufZTotLHBOy1MPxbH4PJJB1AvlwMFlO4EKdKn+5B3ZonPFYdno
         1hROhl13lgjPfjzTvpXjGLXEmwP74fPXZBnFPEhlVs9GYlW0JQ0kwWjcPyKT+OdKC6TH
         f6+vP6F64RmYGHpZh/SsXa9GB7RsW4Ga/XtrzCzTeY6qxVpsfsmBK0vkkK7Fquosblrk
         NlastNUuOzfXdNdYIavYwdG8OZDpwgTUfz2Qs28WBxsR4EoSi/UFj1D3UVTQNNi5SdcW
         VPfgzhHjeylZotYzF3Af+O6CXza7VWvYPe8GdKqWkQf3geOOR1vNrNkS5gaXejLDYOTW
         LDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969716; x=1697574516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u46hLMNS4RzQTNNSS2Qms4cPdJOoCgyXOu0Gun9Lx4=;
        b=NL8jKq57wULMXLqbw42nL3drV+MZGo7Ij+aatMoNr1N5EZDV1DZhsJEMowq5WLOEb8
         q0ZKgH1tnA9qmUg7g9bF929RK0L/fL6ZuXz4ZuTFoyKHQvtv3AEtrVSfEB7XRmJ7iCEJ
         yXjpx30gO4DX2FFOQn/5mR8iprPmMSYaaKQN7hjFIbZIqq12+thLzOSfY6tLOJ/c/syv
         a9WgPr7HZW1kF9oyO/Zmpb9k3GQAaE6tLDyoSG0fVTT3636zeHKBkbKwT+qn1Un6Hall
         waYnxeg/KI4zS2pZajpyac2xwT+E6TVQ8SebNVR6vYVU9W6Lei8tG6W8ybP02lmzbdEW
         E5YA==
X-Gm-Message-State: AOJu0YxJbFg8jWLF2JqxAuvPyQ27xYRxniOVSI/HVISDUbRp8xzPdRZi
        C4oKi2F7IZk6hl1fME89L87oFG02yLovLkRZOOxgYQ==
X-Google-Smtp-Source: AGHT+IGSYOgg6mvEEvY8ZdqygBr3mK7VC5uiP4byirqBZKXCI1XlLmgQnOwqcDcTWMQokVrDtte7Mw==
X-Received: by 2002:a25:abef:0:b0:cfd:58aa:b36e with SMTP id v102-20020a25abef000000b00cfd58aab36emr19728700ybi.9.1696969716358;
        Tue, 10 Oct 2023 13:28:36 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 127-20020a250885000000b00d7465a90f0csm3995271ybi.22.2023.10.10.13.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:28:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 6/8] btrfs-progs: handle fscrypt context items
Date:   Tue, 10 Oct 2023 16:28:23 -0400
Message-ID: <6c0ce0af24a2e19de2ce0e451dc949971779a3d9.1696969632.git.josef@toxicpanda.com>
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

Encrypted inodes have a new associated item, the fscrypt context, which
can be printed as a pure hex string in dump-tree.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/print-tree.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 859eb015..38086275 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -99,6 +99,20 @@ static void print_dir_item(struct extent_buffer *eb, u32 size,
 	}
 }
 
+static void print_fscrypt_context(struct extent_buffer *eb, int slot)
+{
+	int i;
+	unsigned long ptr = btrfs_item_ptr_offset(eb, slot);
+	u32 item_size = btrfs_item_size(eb, slot);
+	u8 ctx_buf[item_size];
+
+	read_extent_buffer(eb, ctx_buf, ptr, item_size);
+	printf("\t\tvalue: ");
+	for(i = 0; i < item_size; i++)
+		printf("%02x", ctx_buf[i]);
+	printf("\n");
+}
+
 static void print_inode_extref_item(struct extent_buffer *eb, u32 size,
 		struct btrfs_inode_extref *extref)
 {
@@ -673,6 +687,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_DIR_LOG_ITEM_KEY]	= "DIR_LOG_ITEM",
 		[BTRFS_DIR_LOG_INDEX_KEY]	= "DIR_LOG_INDEX",
 		[BTRFS_XATTR_ITEM_KEY]		= "XATTR_ITEM",
+		[BTRFS_FSCRYPT_CTXT_ITEM_KEY]   = "FSCRYPT_CTXT_ITEM",
 		[BTRFS_VERITY_DESC_ITEM_KEY]	= "VERITY_DESC_ITEM",
 		[BTRFS_VERITY_MERKLE_ITEM_KEY]	= "VERITY_MERKLE_ITEM",
 		[BTRFS_ORPHAN_ITEM_KEY]		= "ORPHAN_ITEM",
@@ -1393,6 +1408,9 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 		case BTRFS_XATTR_ITEM_KEY:
 			print_dir_item(eb, item_size, ptr);
 			break;
+		case BTRFS_FSCRYPT_CTXT_ITEM_KEY:
+			print_fscrypt_context(eb, i);
+			break;
 		case BTRFS_DIR_LOG_INDEX_KEY:
 		case BTRFS_DIR_LOG_ITEM_KEY: {
 			struct btrfs_dir_log_item *dlog;
-- 
2.41.0

