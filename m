Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1AEBB62E
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 16:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405198AbfIWOFc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 10:05:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34757 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404990AbfIWOFc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 10:05:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so15543554qke.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d04XhOeMin68cWmb4r0Y7nFjc6+HeVha7ZFug8DppP8=;
        b=1Mwa03SjnmmJTrfBl2cEFfYJc4gm4NfEirzK/gy7rWe4IlAR/KLeKXyrIFlbzpgkTG
         DydPG2+3hpPLBUCNkKKpdZX8MdvPjQmiAreED6mxCoOqV4smlgZ+5sVCA4y2jmR/riqK
         cCoHWWa0saUPyktUFb0ulJtRjuPJfNLg2IvAc6r2zO1ams7yOQ5N2Gx0WugpbyejAaS2
         Ioh2YG8MBwZP5JDgIVh2kGeQ5nJ88upXeADcHhWXpZMatJO7RxjbOljJ37u8ce+3Xdpq
         QDhc+AGBhWVvuJcewBf/uv9XCQ2DD+2wTs3f0ZNuyEV+NPQC2bODWdoGwI1K/yExjW02
         IpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d04XhOeMin68cWmb4r0Y7nFjc6+HeVha7ZFug8DppP8=;
        b=XH0wjenkAtLBP7vVUqVKt0efsDpUHf1QZrtTOy2aceK1VpJcLGPa1JU2jXYSQQxmnm
         6RWk0GQRlkIVAOTL6GwcvSa1YBaGyD3VBlQ69VB/enS6RzEl8i4/UFVp/USlvXVR8Ky0
         aYpHKTO/DmWoJ+loxOTTcP+O3kjFeNalZ3beeqfo6uDt54R021MXOabAAwYCJxqtoWs8
         Rr7oq4ZfB/0Zgf4KCavL4Y7mKI1fHDqlclxJvujt57UO/G/15kWPAR1539ITi5U/4KJL
         eQehEhleT7pbX2Euv6M9teaflYTwaRfeRVvaQFOTQfU5OgyqIGjZaRwmFh+ZTXDxBRTj
         /LZw==
X-Gm-Message-State: APjAAAU3FGwTb36GF7WltVcobJtPKMgvoMt3Nl5OGYsgp3UbZcTqc5dh
        zHllt5r89i2+g8z8ADkN9LJPMGl3RQ/SQg==
X-Google-Smtp-Source: APXvYqzWNas/64yTYqESOmmkHQ91rhRQvuIYkietkQzwFCKD0MZM7RqDRq/j+MSuuDxCQkNTEDaGTg==
X-Received: by 2002:a05:620a:159b:: with SMTP id d27mr17666666qkk.298.1569247530122;
        Mon, 23 Sep 2019 07:05:30 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 22sm4778355qkj.0.2019.09.23.07.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 07:05:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/9] btrfs: separate out the extent leak code
Date:   Mon, 23 Sep 2019 10:05:17 -0400
Message-Id: <20190923140525.14246-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923140525.14246-1-josef@toxicpanda.com>
References: <20190923140525.14246-1-josef@toxicpanda.com>
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
 fs/btrfs/extent_io.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4dc5e6939856..8db378fa14da 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -60,11 +60,24 @@ void btrfs_leak_debug_del(struct list_head *entry)
 }
 
 static inline
-void btrfs_leak_debug_check(void)
+void btrfs_extent_buffer_leak_debug_check(void)
 {
-	struct extent_state *state;
 	struct extent_buffer *eb;
 
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
+{
+	struct extent_state *state;
+
 	while (!list_empty(&states)) {
 		state = list_entry(states.next, struct extent_state, leak_list);
 		pr_err("BTRFS: state leak: start %llu end %llu state %u in tree %d refs %d\n",
@@ -74,14 +87,6 @@ void btrfs_leak_debug_check(void)
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
@@ -105,7 +110,8 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 #else
 #define btrfs_leak_debug_add(new, head)	do {} while (0)
 #define btrfs_leak_debug_del(entry)	do {} while (0)
-#define btrfs_leak_debug_check()	do {} while (0)
+#define btrfs_extent_buffer_leak_debug_check()	do {} while (0)
+#define btrfs_extent_state_leak_debug_check()	do {} while (0)
 #define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
@@ -235,7 +241,8 @@ int __init extent_io_init(void)
 
 void __cold extent_io_exit(void)
 {
-	btrfs_leak_debug_check();
+	btrfs_extent_buffer_leak_debug_check();
+	btrfs_extent_state_leak_debug_check();
 
 	/*
 	 * Make sure all delayed rcu free are flushed before we
-- 
2.21.0

