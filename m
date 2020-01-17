Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A237D140BBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgAQNwy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:52:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35451 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgAQNwx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:52:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id z76so22716564qka.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tGD+B7DKKLfpE/UYo+COOnBUoXKzRc7JvPrrBfJd7es=;
        b=VKT6+hKd9foZmG74pD+5xuVwLFsPNvGIxvbVO1iRhYJSYAWoZMtHItlE5acjQfoBNO
         BHcpOFnTCOnTsBmEgEwWXKiIewLekwgh9wuMtfyuwnIdR9Z+Zojxh77Zq7friVQ0rJYc
         bcft4XJQt5kCkKXFubq/J64Pre+Gva2jb8DVjiFWbQWDsVf+d4z0I17Gattkk1AX4dOi
         3rOs7/jQLfkakeeqH3VwNq0JdKayD0M7n5ch6iV+jy4FTOk2/54xZ28/9OlPvm0XEaaP
         rDMQikkJembb2HzbF3qsnFlT12In2j5SKkVENQe38UmqoTdv/yiXhsm3rHkXPyp19oIh
         x/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tGD+B7DKKLfpE/UYo+COOnBUoXKzRc7JvPrrBfJd7es=;
        b=MwamQRP5ZEiEFeyTwIsNli36qntbZOqjRusxx+RJYkMeK2kouAbgLqE+a9Cm8jo7Zg
         bJhgXVc+Oy4xYly3t17TmPcihvjPT1aF+T6JbbDnQ2xz/ZVPXvcPK4D3gxvlyJcx6HhQ
         TPReXfjnyOAQ8utOduMFcJfe4OaToYQdu0l9oxiDDnd/5xElIUq5hcmOpgLv/SnsRQeK
         ZMQeRJmuNU8O85iXjHCdrLF+S4Rs5kDxJmfTUj5xCN/FDODS1LsxHTaP8oN2POAUR4VH
         kzTfYD25H3OXVrsBZOljsvdtRkbJJqe0jaCNcX46+SslbB4qfAP/RTeL2LjPJ9k++VZz
         4zhQ==
X-Gm-Message-State: APjAAAXhir4kjcqa0j6IllscQHzyQCMNeMP0UsnyfruznMXlR6cvVAcS
        g1USkjtT/qSbVAaS3CF/Q/jvTeM/n74luw==
X-Google-Smtp-Source: APXvYqyqvYztso0lNWWH3rYCx96wkKZrtjf80bAG4nt99eTILorgoEb35xsrIgvUHFnH2m277ZjksQ==
X-Received: by 2002:ae9:f003:: with SMTP id l3mr33671287qkg.457.1579269172301;
        Fri, 17 Jan 2020 05:52:52 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w60sm12855067qte.39.2020.01.17.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:52:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs: make btrfs_cleanup_fs_roots use the fs_roots_radix_lock
Date:   Fri, 17 Jan 2020 08:52:37 -0500
Message-Id: <20200117135238.41601-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117135238.41601-1-josef@toxicpanda.com>
References: <20200117135238.41601-1-josef@toxicpanda.com>
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
index 42f352dfca45..73479b4bbf34 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3925,15 +3925,14 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
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
@@ -3947,7 +3946,7 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 			/* grab all the search result for later use */
 			gang[i] = btrfs_grab_root(gang[i]);
 		}
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
+		spin_unlock(&fs_info->fs_roots_radix_lock);
 
 		for (i = 0; i < ret; i++) {
 			if (!gang[i])
-- 
2.24.1

