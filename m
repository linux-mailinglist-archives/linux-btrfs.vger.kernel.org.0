Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36B415114B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgBCUuA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41791 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCUt7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:49:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id u19so8012894qku.8
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuWYAK+axRJuUajBuTmWQVCYEGKddeKdSecCx1HfXwc=;
        b=GNDtXi+OnZc9L6bpyHdcdtPfSzh4yz+dM7QYvDcrY/4jTkslOt/gHS1B1yl3acqacz
         c593tQtRWiqkflFqpwRzUUG+K5s6sUDDP7l/IdS3Gfyckg05Q78jOD5VA80o+RGopYIN
         3PQoh8rO78duGr1TfbTmHlK/H5CscWFPWGOjvGKOHyEvPOX0BldeXF3rx2aOfI0Dk/0T
         MIos/6w4Nm/GzntT8JGhYtlMooRl5yiqndaT12EfE2yxSaKdECmCuDhuIoLZuyG/AA81
         yhCwj7fxKZlGQ4ZIA15rN2Mj6r5nBJ3hGmTBfymJn3Vf9EmJvPllBe4Azoq9GgBMePeD
         9drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuWYAK+axRJuUajBuTmWQVCYEGKddeKdSecCx1HfXwc=;
        b=g0Aar+FDg1gLRjO1dB0ej/Tna7A/rUTrbJpLZIUN/d81BzHn7JOC6au3P1IWsFz+ng
         bx1xw7sIJeJX7YykzpKbYSG/5Ya37PYtQHwrAfXTI0C7HmdY+u7J5tRUxmCcPbv0aW2M
         PmbfiEL34totamIHbdK2ETEnzYuMd4bhteD/s9qlPNEOcSCAHcLPQY2x0dQ0hU7NbVNS
         Z5O6xVF80M3WKV3rUiHYtxFjZ4YVDNrXPnt7AlsIwoqzpYEdfuQh4dyGmTc5mDJLeRS9
         F7OJNKQWDwpjwvC2abqnk/K+U6QQ8OyIZCZXu60p0MAX5RFMEY2EeZpYQTVk67CVmSk/
         AhDg==
X-Gm-Message-State: APjAAAVZ9VWETEiblF3AvbP2VyxbiQXpgnUayJjlFyEWpXZl7UXR0Lx7
        lBX76PCplRUi0PU4RkCaKVnM7ozpTWUMBA==
X-Google-Smtp-Source: APXvYqwaTjxfVWkMQBcWqyp2YOqW6+by4NIcoWfQVYV3S5GzKEVbC8YFnb3L64qua1l1Xh6Dv6O3zg==
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr10966248qkm.455.1580762997391;
        Mon, 03 Feb 2020 12:49:57 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y26sm10150373qtv.28.2020.02.03.12.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:49:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/24] btrfs: remove orig from shrink_delalloc
Date:   Mon,  3 Feb 2020 15:49:29 -0500
Message-Id: <20200203204951.517751-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't use this anywhere inside of shrink_delalloc, remove it.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index edda1ee0455e..671c3a379224 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -350,7 +350,7 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
  * shrink metadata reservation for delalloc
  */
 static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
-			    u64 orig, bool wait_ordered)
+			    bool wait_ordered)
 {
 	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
@@ -569,7 +569,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes * 2, num_bytes,
+		shrink_delalloc(fs_info, num_bytes * 2,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

