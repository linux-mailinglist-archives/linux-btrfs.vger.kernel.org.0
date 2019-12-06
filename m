Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7EA115372
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLFOqB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34684 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOqB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id d202so6687584qkb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X+dDBN36nIO9Ue8qnQBxsC4EQZnEqI2HnSGzAQBPEHQ=;
        b=InXdKraIl56luJ9+96L1tLtlqhhchby4OMrTHCDjpkyPnf6M8PH3liXax/fdn58Vz7
         MHNt9gT0SNnGaqbfEs7BFTlbowQpv5l4+CtO79NpuhQ4RRKfVMQ8y9zgQJaqQZWJnnsG
         YiF20Xuswk5rZjxXtxbFjALyKJCFXQmMmfMueoyF6el+ZN5MM/DxhQAiFih/ftmR8zpS
         vrloxnVwoUM40cxNSM/vMVCpQh1Wb6Dnmd6+u5iZUwsRZQG/nWo8P3bVQf5aHxYZlTu0
         T3cR4fGiBsfFtuKduaz75z6z1hA3ojbOdsqib6rRE3nt1fJrF9aFjM3ejopk3c8BuccJ
         wVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+dDBN36nIO9Ue8qnQBxsC4EQZnEqI2HnSGzAQBPEHQ=;
        b=FEwcSOEoVSa53OQp1peAiTS+bfvIC5OHsymZlx/f22tLCEfQm0FEDiZx2pzg3CXr0h
         MSHGXtL9UHcP5uerIYjCjl9TzjITITlcBzuFI+cA7Yk3BCozecze3lvqG4rWJluhOc1F
         7cqPEvrWK51Cz+ptvsDpLos0U1wfkGAmDmclsjR1+9cNUn3gFngUI+HAQrqgLTr2Rm5z
         pW+4xBgbsMECuuG5i5yF0ZUh6OGsHx6F5fAXIXP+GO3MueZ8zNzF+ZGrNA+MrV9C12nd
         mSkZMCIy2YXoZ/Df7pJ0VUBQ09rUQMenxyVL4aOyYYzl63fD0z6IESm4OB+VDw58GzaJ
         6Ksg==
X-Gm-Message-State: APjAAAVei2bGgPV/UPpwplbUOCFgHvzqwHOC5T6qqSkSyCKixfWOQJCh
        YxgoCJgayzEsVpQ3AA0jMl7XVCikxvjhkg==
X-Google-Smtp-Source: APXvYqzJ/R59qpdGUOiqG71zN258nPPA86FwETj4c/3G1HiiV/63OTcc+6/EH737McubvG1u1QFx6A==
X-Received: by 2002:a37:b044:: with SMTP id z65mr13829725qke.424.1575643559838;
        Fri, 06 Dec 2019 06:45:59 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h34sm6651540qtc.62.2019.12.06.06.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:45:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/44] btrfs: hold a ref on fs roots while they're in the radix tree
Date:   Fri,  6 Dec 2019 09:45:04 -0500
Message-Id: <20191206144538.168112-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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
index 4c55db4b3147..dfeeabfc341b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1515,8 +1515,10 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
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
 
@@ -3816,6 +3818,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	radix_tree_delete(&fs_info->fs_roots_radix,
 			  (unsigned long)root->root_key.objectid);
+	if (test_and_clear_bit(BTRFS_ROOT_IN_RADIX, &root->state))
+		btrfs_put_fs_root(root);
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 
 	if (btrfs_root_refs(&root->root_item) == 0)
-- 
2.23.0

