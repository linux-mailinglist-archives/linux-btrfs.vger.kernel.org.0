Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFCC140B69
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgAQNsT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:19 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38041 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgAQNsT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so22682386qki.5
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L+f5IzV9nT4YAxPklsAU5borgvxb1+yqLE5tB0c9SqY=;
        b=EYAr0KC0r5kEuBrfuCqr9baXy0vaYOtgcBtcP35fZ+KmkcSQLORmflTA+Z9WlmAZYf
         TqIwlvHdv/wZDCAumFhE1Nc/6CWX9YFyAhW/3tlgzm+lkMIaAMCx2uu36ChdUOjM4T6G
         utp5fv+cjXLW6Luh763/srQa+ajGjk9MFBYpr6yDdwQNCF7OiTDvD/KZ6CdgGbxOLEO2
         Se0exMOoG6cygK/4aKPkxGE/MHZjaKk7ObuySSYTJ9FDS1eOlHlbULss3BsgOH7M/exn
         UwbOSOyBzR9O0a+jJDx1KGNjrj+ZPWqtu7rbc6amtSJN2ZhznJxUHh5hRzJJXwLroKMW
         KKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+f5IzV9nT4YAxPklsAU5borgvxb1+yqLE5tB0c9SqY=;
        b=CT6/HtH7LVP6jfnP0SrtsLH6WvfuiTaxV3Z24jNQ8iSZ6kYsyzoXCJC+YqQfc5v/+5
         VaIOq6u8WTIAf4KqP40k/mOsOitYJ++iehIdYuEsi+d91RjkcaL6cGyTrp/duhLt/5uU
         C+2ZRM3Vdym7r8aFlXyZEbE7lWGAS/FUQpejGnZFC29amP85b0HP3ntb/6UdJ2ZwTLZr
         2PZ0Ywtuofm13mI/BWDb3otppyRDOLLNgLXusNHwHZ+fK0Xd77zqion8fd79ix/RrNgM
         k8LaDM+ZN306lDKgKpIjgHhPieRoyMAd9jTE90kd+xQqc0muDrClp/y1cz43EUvxiH7E
         h5kw==
X-Gm-Message-State: APjAAAUAHXTAjP27bnYPV9IZaT9ss0tdlt33xgFdqwGSe96ri5Vap+iR
        F5yYEbsIV+EYyYbzmhtyrhx1+aUvuIDitg==
X-Google-Smtp-Source: APXvYqxKhK1NoeKxWIDYW+5JbQL3pjs9p4YtqJ0IHdMs7mcw0hItzoXnWRRjSOUcYzEI7t2aFwZd1Q==
X-Received: by 2002:a37:5841:: with SMTP id m62mr37345926qkb.256.1579268897987;
        Fri, 17 Jan 2020 05:48:17 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r66sm11855184qkd.125.2020.01.17.05.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/43] btrfs: hold a ref on fs roots while they're in the radix tree
Date:   Fri, 17 Jan 2020 08:47:25 -0500
Message-Id: <20200117134758.41494-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're sitting in the radix tree, we should probably have a ref for
the radix tree.  Grab a ref on the root when we insert it, and drop it
when it gets deleted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f030ff87ed18..5f672f016ed8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1513,8 +1513,10 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 	ret = radix_tree_insert(&fs_info->fs_roots_radix,
 				(unsigned long)root->root_key.objectid,
 				root);
-	if (ret == 0)
+	if (ret == 0) {
+		btrfs_grab_fs_root(root);
 		set_bit(BTRFS_ROOT_IN_RADIX, &root->state);
+	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 	radix_tree_preload_end();
 
@@ -3814,6 +3816,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	radix_tree_delete(&fs_info->fs_roots_radix,
 			  (unsigned long)root->root_key.objectid);
+	if (test_and_clear_bit(BTRFS_ROOT_IN_RADIX, &root->state))
+		btrfs_put_fs_root(root);
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 
 	if (btrfs_root_refs(&root->root_item) == 0)
-- 
2.24.1

