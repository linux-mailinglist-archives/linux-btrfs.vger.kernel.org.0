Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712FB24C678
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 22:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgHTUAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 16:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgHTUAU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 16:00:20 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B849C061386
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 13:00:20 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so2111915qtn.9
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/so4vs3WZ52V3Mk1MRVapNqzid0jrfPhWyiH8FPV54c=;
        b=TAMat+IbrJkon+hSfqrp4zZoYXoNPOWPKvRBmHJINd8iqXj3/dZ4qnYVcD6ti7/IPQ
         LIzq9GX09o3eRGuya49T4ii+VsghXoy0mr4/4c1J9WUmP8+WRWd+yrOH45S3KO4245FP
         hKMSz+46HSRm1IePVJIU9V+uL1mOp0ym4KvBL+x3Z84pnJEYMgsA5I4a+W772ubdS+vp
         9QakJZgUckUJNy+E8hNIw5ikUFEiDyiTHvQ3SJbEhVgwWR687QMISW/YJV1j/c5aYdkU
         bx4thS7idfWu24HjgGYV56fcdTxWQkFt3AXzqf2L6SZXN/oncwjQf0iZg+S0hFdotneo
         UozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/so4vs3WZ52V3Mk1MRVapNqzid0jrfPhWyiH8FPV54c=;
        b=rdOvwVnPd7izKgxGaFbo1Kvs3oaIkaPUTYk7D7vwNSug335PS/hENrHB7LSD30TOcE
         9PbhnAqOiFOws37QpcBvG9chdFVvFJ8g4mN8FD5qxjWRpJyAWiHjZ1lPZo1WMBLyBWTv
         mWx0xjUmxsy77nSzuOyuRrKrEi9rCCSGnTPVnAiL2OaN0HU69YXT/6hyF7zWq/VRQN7F
         TnCGEciIXVGtGW9hC1p0rrEV2UQy2q0eBuEdd53uX32WW0QpSLlH76t1q2oOpDMhfRiR
         MNQnRFb40oo2lZUsa4/MI3kcsAf2p2/xPe3aFzJaQ7Q7xGVg/A+yZvpBEHFjNEU9YhOn
         ivRQ==
X-Gm-Message-State: AOAM530l4DwKcaqU5q3JmMzoZDn6A+h9oBKw6iMDlamw/D10SYEWaje/
        yKS78hM0g+M0oE3gt0+35SrgnzvfwOZHoVQk
X-Google-Smtp-Source: ABdhPJwD2KtbdMY4gxurVpYkHtIAhuPJNtOgIGejOubL3qdFcctIGW9fZLjm9s2cZ8Da6dEe6yEMzQ==
X-Received: by 2002:ac8:43c4:: with SMTP id w4mr170037qtn.319.1597953618892;
        Thu, 20 Aug 2020 13:00:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s56sm4229047qtk.72.2020.08.20.13.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 13:00:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: free fs roots on failed mount
Date:   Thu, 20 Aug 2020 16:00:14 -0400
Message-Id: <9c6e581e607954968d08179961bb20a62491a655.1597953516.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597953516.git.josef@toxicpanda.com>
References: <cover.1597953516.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing a weird problem with -o degraded, I noticed I was getting
leaked root errors

BTRFS warning (device loop0): writable mount is not allowed due to too many missing devices
BTRFS error (device loop0): open_ctree failed
BTRFS error (device loop0): leaked root -9-0 refcount 1

This is the DATA_RELOC root, which gets read before the other fs roots,
but is included in the fs roots radix tree.  Handle this by adding a
btrfs_drop_and_free_fs_root() on the data reloc root if it exists.  This
is ok to do here if we fail further up because we will only drop the ref
if we delete the root from the radix tree, and all other cleanup won't
be duplicated.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 814f8de395fe..ac6d6fddd5f4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3418,6 +3418,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	btrfs_put_block_group_cache(fs_info);
 
 fail_tree_roots:
+	if (fs_info->data_reloc_root)
+		btrfs_drop_and_free_fs_root(fs_info, fs_info->data_reloc_root);
 	free_root_pointers(fs_info, true);
 	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 
-- 
2.24.1

