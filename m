Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03483B5584
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 20:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfIQSnu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 14:43:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41453 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfIQSnt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 14:43:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id x4so5686575qtq.8
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2019 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gO+w/U8hMDaFUu707WWbHk/4OoJIRUYRlEDKwVJjTag=;
        b=QLUZ7PIm+frGdb1GvNxtaDkNyhxh82tNZLrLJvNk+AV2wqO+LCfao30oUlwBjumDk2
         zmObSLAG3n695kyOgwUFNDLgXpAOzLbH4JmmdjsEuMVw1rfgiJATAc5p7KAKp1OMnvTb
         NltaMXe9430uZPxl4jhXApk6cmc/Fsoh4okJ57jtkolFmPLx6WRma0fN5NXH0G5uzK1Z
         BGMLo37KTEXjZL1I0FXDlf3RJNUsoTqfREcw+/DtnhoYx4GytfpZmhO1LWDJlT1vUFiE
         uQovvZeRUhMyN+8OYZEAQ6VDtxJxX6rKv7d2zuYWBYOyOY1Dm2BMEcwAfSiFjj+94lbc
         Bvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gO+w/U8hMDaFUu707WWbHk/4OoJIRUYRlEDKwVJjTag=;
        b=IdkTzW4NrgZn2YSKr+8Y1GD9rwjG6O0Ys3PWGRlCcrCQLJTU0xBz0lMo+o6VsHKVQl
         /xodwvu6fqt6TPYnhfzv8yAd65zaiLr5qI3I00k6fllODscKtTUKlY85XI6B6rdPEohp
         /x7C1uPSNMSZbnQPDjOs4FvheCQIl8y1PXvGRnyWi7NyQy3BABs1kAOqnZcD45bajN23
         hslskafbCh3ITFXbxm9snXUrD1mA7UGVi5cqJxR3KgLTFLHrlhHodngChDFaCcKr9wMc
         zNIjOUCdZmrvwL8K4VHgcPXN6u+PeybrzC0Lnd0XtLWV3NcisRHSY1siwKONgw7OyqSc
         rt+A==
X-Gm-Message-State: APjAAAX3k/hEc7IfuGjBpl784EaJoBqyl8YprGNxBr4h4wBq/gwncYZq
        KqPjqCXHbCXl0LsE4RgXlWuryFAN0Qdopw==
X-Google-Smtp-Source: APXvYqx9nVGDLB6af1sXAMhqBp2faRs4vQqYqj7/mNlQjehReCvVWXeVkEkoUeM83ZF2dDHJZfedNw==
X-Received: by 2002:a0c:f787:: with SMTP id s7mr4317787qvn.221.1568745828563;
        Tue, 17 Sep 2019 11:43:48 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r7sm1716174qkb.82.2019.09.17.11.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:43:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/9] btrfs: separate out the extent leak code
Date:   Tue, 17 Sep 2019 14:43:35 -0400
Message-Id: <20190917184344.13155-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917184344.13155-1-josef@toxicpanda.com>
References: <20190917184344.13155-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We check both extent buffer and extent state leaks in the same function,
separate these two functions out so we can move them around.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4dc5e6939856..b4b786a9d870 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -60,7 +60,19 @@ void btrfs_leak_debug_del(struct list_head *entry)
 }
 
 static inline
-void btrfs_leak_debug_check(void)
+void btrfs_extent_buffer_leak_debug_check()
+{
+	while (!list_empty(&buffers)) {
+		eb = list_entry(buffers.next, struct extent_buffer, leak_list);
+		pr_err("BTRFS: buffer leak start %llu len %lu refs %d bflags %lu\n",
+		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags);
+		list_del(&eb->leak_list);
+		kmem_cache_free(extent_buffer_cache, eb);
+	}
+}
+
+static inline
+void btrfs_extent_state_leak_debug_check(void)
 {
 	struct extent_state *state;
 	struct extent_buffer *eb;
@@ -74,14 +86,6 @@ void btrfs_leak_debug_check(void)
 		list_del(&state->leak_list);
 		kmem_cache_free(extent_state_cache, state);
 	}
-
-	while (!list_empty(&buffers)) {
-		eb = list_entry(buffers.next, struct extent_buffer, leak_list);
-		pr_err("BTRFS: buffer leak start %llu len %lu refs %d bflags %lu\n",
-		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags);
-		list_del(&eb->leak_list);
-		kmem_cache_free(extent_buffer_cache, eb);
-	}
 }
 
 #define btrfs_debug_check_extent_io_range(tree, start, end)		\
@@ -105,7 +109,8 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 #else
 #define btrfs_leak_debug_add(new, head)	do {} while (0)
 #define btrfs_leak_debug_del(entry)	do {} while (0)
-#define btrfs_leak_debug_check()	do {} while (0)
+#define btrfs_extent_buffer_leak_debug_check()	do {} while (0)
+#define btrfs_extent_state_leak_debug_check()	do {} while (0)
 #define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
@@ -235,7 +240,8 @@ int __init extent_io_init(void)
 
 void __cold extent_io_exit(void)
 {
-	btrfs_leak_debug_check();
+	btrfs_extent_buffer_leak_debug_check();
+	btrfs_extent_state_leak_debug_check();
 
 	/*
 	 * Make sure all delayed rcu free are flushed before we
-- 
2.21.0

