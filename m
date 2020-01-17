Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A411412C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgAQV0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:10 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38496 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id c24so12108395qtp.5
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6tD3SkNSKEEDG/aoBeQMkgM5wsm9ZuZ73HSUNDHrHH4=;
        b=Px8QSRhZ6NLCWKWT5EPiciJecLSoNQ6oku2AULFta5jAPgZoM+xv17fyh4DOfszRWF
         mFLBOPxlziW3t7pYWL85jKu8ffsn4VB+c4OEGRw8kkEK/AuAFh1PAWPJ3yBmS0xsll8b
         H2XAkc4zsymhh+o/fYcezlZaUfmvnMSLE7OHFl59q7UrGknOaWAQMh+ZSJOnQWRB4dSC
         vir+LqBGq+qRb5BgNiQRjui/m36v6omKo9xGTtlrtWlhNIBwd4+aG8X/FZ5NXbS6jGin
         Dpa2MVxvEZRyPpwXdJwcd6Dny2kEHtm1CqCtSgh0vUKMXu4yfPjjDUdVRwNdKKY1vQms
         Y/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tD3SkNSKEEDG/aoBeQMkgM5wsm9ZuZ73HSUNDHrHH4=;
        b=o7YhrYO6aPe2dzqO36QR9XyaGhan25jFFxbkSTUkQhfTYAzzcDWui2zvXyqe0JcHVZ
         zTm6r/Bpgku3W2pTywn/PrBiVjXah0pp5To4qIWpdJPt3IndlENHcIyy8PxDw6RZtdBh
         rZT344HY8uj8ISmQTZyr/lwy4g5nH4vTjOZ3BwZTlyPhS5HjVuU18Cw3bS0T7ZOgIj9e
         PNBGpr+ybvvsTceLhGJQsZ5Hpz1N6p+eQYVcSxYHa4m4H0xxeOd9O+GYbLjFF8Bwbojo
         glFSTmq7aYE9oXo5KuGKaYeXK/eLGx7iLPfH/5pZMcu7EknuyJJ/lI9W0YClVSmZY8Y8
         ubQw==
X-Gm-Message-State: APjAAAVHW9u4wlLfHudP/oH8B0bm86C3KD8qXzUuS4vhyKyn0nMYHVDq
        zQ1lUrSMv2wgaT33PXyI2MewXAQyZghaTA==
X-Google-Smtp-Source: APXvYqxJd9qFjeSRK6bDs5Q6hxiAobwHbCNvPzfOeXf0TnqaH6JhuXlmNXZeAddDAdHcsT3+xOEHGQ==
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr9670719qte.327.1579296369064;
        Fri, 17 Jan 2020 13:26:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g18sm12358642qki.13.2020.01.17.13.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/43] btrfs: move fs root init stuff into btrfs_init_fs_root
Date:   Fri, 17 Jan 2020 16:25:21 -0500
Message-Id: <20200117212602.6737-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a helper for reading fs roots that just reads the fs root off
the disk and then sets REF_COWS and init's the inheritable flags.  Move
this into btrfs_init_fs_root so we can later get rid of this helper and
consolidate all of the fs root reading into one helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1dc33e95052b..2d378aafb70b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1445,12 +1445,6 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
 	root = btrfs_read_tree_root(tree_root, location);
 	if (IS_ERR(root))
 		return root;
-
-	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
-		set_bit(BTRFS_ROOT_REF_COWS, &root->state);
-		btrfs_check_and_init_root_item(&root->root_item);
-	}
-
 	return root;
 }
 
@@ -1474,6 +1468,11 @@ int btrfs_init_fs_root(struct btrfs_root *root)
 	}
 	root->subv_writers = writers;
 
+	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
+		set_bit(BTRFS_ROOT_REF_COWS, &root->state);
+		btrfs_check_and_init_root_item(&root->root_item);
+	}
+
 	btrfs_init_free_ino_ctl(root);
 	spin_lock_init(&root->ino_cache_lock);
 	init_waitqueue_head(&root->ino_cache_wait);
-- 
2.24.1

