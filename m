Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07D6140BB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAQNwu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:52:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36778 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgAQNwu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:52:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id i13so21808996qtr.3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=26r1ijGQJWQ4p03khoUS8onzFBaju/8sMGqnWWiZprk=;
        b=kqAHFwreHgQXJQidFzXdut1hvoA8nX2+QU+UDaiYebhbOC/04woD0HY8DDWy4gVr48
         t0aWReWrawIOmqEcWYDmZqPPRbnsLwawxySaBL10zvNr0fqgkoIC0tHUb4WW5AmvnRoB
         DPgiLz7Vlkrh2PlO8WiCq46F5UV66ktCiqKcmtWhiz2OiyKagw8OhIjgChy7nP28r2lj
         o8zl+oa4QESGNnPZTpgzAwZhYRL6/kSxSEUmtr/i3I4lilhS0ud2Yf7jZO6wb7d9/bCw
         PL2GIegzluLehL5fNKbmYGR033q48C51w6nJGVzYneA34UJ5grFd+VogeJ6I+HRyrEM7
         k/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26r1ijGQJWQ4p03khoUS8onzFBaju/8sMGqnWWiZprk=;
        b=BMKjCncHiO4N/FUYezyg3U0PkejmiBWMGUNsROUK2SycvTFnDxrSZkBYAYiVlOI+mZ
         Cl07P3M90nu3lGhHf79YB0V/I4jCxg/vf8CKr8nm9C0IlhZ1t+KrDOHgtUzj2owFR9YA
         3x8JmfhdsAQwJUv+valwWsNtmboTG6rwGVBv3lKDIC7snV6+IMvKSlnMRnlg51/4gI59
         vpiw8Nomy4t8HGol2kyHbM6qbc/X/JBkCkveDg3WiWpPbYofd6rL5vhdg6MTZxwLlvsL
         /amUrTsj/3F4Ii9mIz4BGkhUKFi6r2Xk8VceTsKkjEifV/LQoU324ib24foTe41ACWc7
         +kbw==
X-Gm-Message-State: APjAAAWz3vy5PRkko+qYxdTv1AuN/RD/4u66EIpfQR1NGLDUKqWAmQlM
        CLtnhRpJsuaC1/3VfUxBnYS+FQs1wxupdw==
X-Google-Smtp-Source: APXvYqzJ9jITZcxAWC4dd1bu7qrHTpRSjZvlNu0tuEiyL8ChiSkO8Hkz8j+HRoe1M4t0lhY2QrKT5w==
X-Received: by 2002:ac8:65ce:: with SMTP id t14mr7595462qto.72.1579269168865;
        Fri, 17 Jan 2020 05:52:48 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x34sm13090719qtd.20.2020.01.17.05.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:52:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] btrfs: hold a ref on the root on the dead roots list
Date:   Fri, 17 Jan 2020 08:52:35 -0500
Message-Id: <20200117135238.41601-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117135238.41601-1-josef@toxicpanda.com>
References: <20200117135238.41601-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At the point we add a root to the dead roots list we have no open inodes
for that root, so we need to hold a ref on that root to keep it from
disappearing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     | 3 +--
 fs/btrfs/transaction.c | 6 ++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ca474f87aba5..be9b1a1b1a33 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2081,8 +2081,7 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
 
 		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state))
 			btrfs_drop_and_free_fs_root(fs_info, gang[0]);
-		else
-			btrfs_put_root(gang[0]);
+		btrfs_put_root(gang[0]);
 	}
 
 	while (1) {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c1b34c8c9fd6..27a535d4bb4f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1260,8 +1260,10 @@ void btrfs_add_dead_root(struct btrfs_root *root)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	spin_lock(&fs_info->trans_lock);
-	if (list_empty(&root->root_list))
+	if (list_empty(&root->root_list)) {
+		btrfs_grab_root(root);
 		list_add_tail(&root->root_list, &fs_info->dead_roots);
+	}
 	spin_unlock(&fs_info->trans_lock);
 }
 
@@ -2434,7 +2436,7 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root)
 		ret = btrfs_drop_snapshot(root, NULL, 0, 0);
 	else
 		ret = btrfs_drop_snapshot(root, NULL, 1, 0);
-
+	btrfs_put_root(root);
 	return (ret < 0) ? 0 : 1;
 }
 
-- 
2.24.1

