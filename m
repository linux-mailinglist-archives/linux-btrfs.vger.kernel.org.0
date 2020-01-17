Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B88140BCD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgAQN4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:56:52 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42058 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQN4w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:56:52 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so10702781qvb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zbqzbzO2TssldvFpVPjN4IKuIgV2h4UkkNGdkQ1XuQw=;
        b=wJ9StgGl4GJpj2j/D+UD36kW7J0dUnUmAPO2o+bEWfknR+wvJzYz63HbX8NJmiPBMA
         15GlVGDjIBFTuTbueUQPbp3uGdM0zQ+zPcuwCh+R8gBnIN5eHqYKMXZC5gjyhfq1Cni6
         jVqXYEKJfDZAHBMIE1Wznc+lbc0U7zQH4ek8KK6LPfDVwb4bv3xPN1H5ssw2fH6bab+5
         gRBA0rWu74EgDSV+CX52tpZTBxiJF2bJbwgc3Vf0HmzO3xdRH44NiQ8nP3JTW6Snbkd1
         K9FXr/mT4u/g8rkfyZBQIhih8PT78PvNMjB6HC71kixrPlPDFBuv2P6EX5Z+kOpXWSMr
         IYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zbqzbzO2TssldvFpVPjN4IKuIgV2h4UkkNGdkQ1XuQw=;
        b=XVUO+eCwAQuOXIuAfseEHpK7NcmQyL3+5nfkeM6WXDd+iRtlzd49B5u39bh5RtV40d
         zRlSYQQrQQk/z0FfOcCZeO35J4go6/D3iKyqTMDuaIKvwgiAZeRPv3XATUZbfFBNGWM7
         dWebqQc9wIl29wFvASoBVaLT9kolmGYViXyitIVBnhqWes8Ji3XtSLBrrb/yADVUYcaR
         VhUI/vc75CmE1kn1epd6dcrYbiHuyUsk9PSIXGSrCSrRUPFH49Wp9Y8KUT4TgBGo1qjl
         dn9XRK+V7eeIKonUJdL7fZZIg3IjUNCa/aTZJjHF8h5HxPGf+wfkQ0Z2V9Q+EVVPYJOR
         Y5Ig==
X-Gm-Message-State: APjAAAU/mV82Ne4zGobreai66HY9EfYef2Vvf6B6biCFTUFZOsT3p2pA
        9xVgVrLAknJvTr08HhqAe7W6KXOCFVblOg==
X-Google-Smtp-Source: APXvYqxrSyopxnM8Vl2AnT5IuH4JF0kEDdwz0wKdRvmCtB6CpuANroaAuM9w6CEYIkD6JKkuv+r+xg==
X-Received: by 2002:a05:6214:118d:: with SMTP id t13mr7561339qvv.5.1579269411363;
        Fri, 17 Jan 2020 05:56:51 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c184sm11716012qke.118.2020.01.17.05.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:56:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][RESEND] btrfs: free block groups after free'ing fs trees
Date:   Fri, 17 Jan 2020 08:56:49 -0500
Message-Id: <20200117135649.41983-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sometimes when running generic/475 we would trip the
WARN_ON(cache->reserved) check when free'ing the block groups on umount.
This is because sometimes we don't commit the transaction because of IO
errors and thus do not cleanup the tree logs until at umount time.
These blocks are still reserved until they are cleaned up, but they
aren't cleaned up until _after_ we do the free block groups work.  Fix
this by moving the free after free'ing the fs roots, that way all of the
tree logs are cleaned up and we have a properly cleaned fs.  A bunch of
loops of generic/475 confirmed this fixes the problem.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- Nothing has changed in this since last submission, it was simply rebased.

 fs/btrfs/disk-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d453bdc74e91..55a03a21d752 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4056,12 +4056,12 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 	btrfs_stop_all_workers(fs_info);
 
-	btrfs_free_block_groups(fs_info);
-
 	clear_bit(BTRFS_FS_OPEN, &fs_info->flags);
 	free_root_pointers(fs_info, true);
 	btrfs_free_fs_roots(fs_info);
 
+	btrfs_free_block_groups(fs_info);
+
 	iput(fs_info->btree_inode);
 
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-- 
2.24.1

