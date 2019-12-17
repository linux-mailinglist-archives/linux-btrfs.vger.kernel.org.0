Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CA41230B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfLQPoU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:44:20 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36689 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfLQPoT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:44:19 -0500
Received: by mail-qv1-f66.google.com with SMTP id m14so3790327qvl.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YQfdQae39uiQcjyzXpXnnUq9Egi/pCGKybhDTHN2FOw=;
        b=s+O/dQtTEKajFru4uprdLt9iErIZRYUPuF0S4evU2opsJ6CA5P/y4bOKHfk9Ob0tur
         8uKbOhioGYHqmWyyr0XAI4VxCII6l8cvqpYgQ4ME9NAK3WsBkHk+587IsgK4cCsckOa9
         J5j4gjkhtFQ3P+7FmxOCwxRQhr0U2RDiToq+NnqnxRfx1PNM/SLUicAz/5wGDL9R3me+
         m8N11tu2F9lAKUTSac31yREilP2QTTAM1y1GFp21tB5MGUATNMda8f0wmF99BDZdVK+i
         Xh02XRa2lh756cjgek4jV/6atrj6xFLDa6d7I9qJWcLvW1WzsL5wMpDLBzMBlE+1TajP
         TBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQfdQae39uiQcjyzXpXnnUq9Egi/pCGKybhDTHN2FOw=;
        b=cVSKzt4cTxLDisO85c05osO5kHI/ikgVLO+KAsb0ZwEUT834JfnGPlLUB+AdhhsrNr
         9osreh9d2j67ueue3d9dzgGQJ5yxVlrGEYTbosXBKXrG3yd5GpiodZ0Zdj1Zn3AexEF+
         OP+Wt8orGMFbRt+deX7s4vwskQFRyM3Wryzd8UIB2S3P1bMb/ns5LFQ7GsAury54Gydh
         mKa2EeqhSabYarjl/BQpmbNkaZYt49cjIgTjeEkyhMCVPPj4bMXYo3regZ9mCFz6zZuh
         W1YglirIglwKZpsDvB+V/t7W1KtEngA95v1BXuvvMzYKGd4AY1JwZa0RtRyl3LTeLj+F
         iXdQ==
X-Gm-Message-State: APjAAAUHDqDyqY9nC1R0gfarwmCm/ezDXeq1EpCyvKpDoOVgADwL0Eny
        8AuOYAgVwNpg/2XoOGKsrWWsUzNy4t1Ulw==
X-Google-Smtp-Source: APXvYqxLp6ueOMm8TrstJ2NR6+pdK+xVDVhY7iz3WUhwfHNq5EXYiHhmdQaybKV7+vUR+ks+X1YE/g==
X-Received: by 2002:ad4:56a7:: with SMTP id bd7mr5288924qvb.238.1576597457781;
        Tue, 17 Dec 2019 07:44:17 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b3sm8301901qtr.86.2019.12.17.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:44:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/7] btrfs: make btrfs_cleanup_fs_roots use the fs_roots_radix_lock
Date:   Tue, 17 Dec 2019 10:44:03 -0500
Message-Id: <20191217154404.44831-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217154404.44831-1-josef@toxicpanda.com>
References: <20191217154404.44831-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The radix root is primarily protected by the fs_roots_radix_lock, so use
that to lookup and get a ref on all of our fs roots in
btrfs_cleanup_fs_roots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b99eab5381bf..9a0b74b4e7f9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3922,15 +3922,14 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 	int i = 0;
 	int err = 0;
 	unsigned int ret = 0;
-	int index;
 
 	while (1) {
-		index = srcu_read_lock(&fs_info->subvol_srcu);
+		spin_lock(&fs_info->fs_roots_radix_lock);
 		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
 					     (void **)gang, root_objectid,
 					     ARRAY_SIZE(gang));
 		if (!ret) {
-			srcu_read_unlock(&fs_info->subvol_srcu, index);
+			spin_unlock(&fs_info->fs_roots_radix_lock);
 			break;
 		}
 		root_objectid = gang[ret - 1]->root_key.objectid + 1;
@@ -3944,7 +3943,7 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 			/* grab all the search result for later use */
 			gang[i] = btrfs_grab_root(gang[i]);
 		}
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
+		spin_unlock(&fs_info->fs_roots_radix_lock);
 
 		for (i = 0; i < ret; i++) {
 			if (!gang[i])
-- 
2.23.0

