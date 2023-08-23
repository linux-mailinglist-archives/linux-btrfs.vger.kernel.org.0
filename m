Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F94785AAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjHWOdj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjHWOdi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:38 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85CFE54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:36 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d7225259f52so5632780276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801216; x=1693406016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNGWm6NdL1drTn/oo0Y/OvcWe2LvUaNmbQUrs43rWaM=;
        b=mWYJo2ovvPTbNIETS99PBpSJRzYnw1cZ0ceVzhKHLjGkOi1F65TeEZftBzOQj5yBJL
         Vb40S9ikfgjxV/1zYgqYYkcb8n1c+F9GQB7/PKqf/Kd8YguqG10w5l5tScuLWyaiM+Ty
         3vKGMguskPZqHo2UNKVfpUKV7EC58/1i/R+auhgxub+dKigB7QOaC/zGROT118O6T1do
         vg2Tnev7bbZkWr47tXNwB7ZjFALZivvSTP5nfIsgnr824KNV9BU0Vopw6lku4NZTp8qt
         suNMfWB3VfvNfMuu3Rr/eV+r2a8CXKfGZVjUG/pKw/LpNi75Ua5GMMFF+0TxZEzp0f5b
         TsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801216; x=1693406016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNGWm6NdL1drTn/oo0Y/OvcWe2LvUaNmbQUrs43rWaM=;
        b=Npf5HeoouaQsxKKhOrYzasErU+aZZ7BYSHLOiwXqb+ZVp7qUndp4q126E2cDu5y7A8
         LddgyWgqdUvV6cHB3m2Sf0P51R0cpHayn51HYoTbCe5L/F2Z7IAwvvthzPJ3Ahwja+0C
         AKV1fQRn7WpuQHg92eXrvBGfXopELAfpT/P/jHt1v6oVI5F7P/EB2uzsufLr1P/5auSl
         gHeGfK76X5qBkSqwMAQzMNEi8Y20yHX/ZAAgE1hIyJNT+6BUS/6FsjoicfSVdii+sfUw
         FzZlfz91FoohUqyxM34ouRxA0JEZHXOCUGndHEz6re5WYuwr2PYIUVHV84KZM+GE4XT7
         n5jg==
X-Gm-Message-State: AOJu0YwOorWfkGA0kZpwQ+ShY3mlcwbEVad3wLeFG7/f/fd02U8WRhze
        VTjo3eFl8l0LfwT7FXvJ8uhaXAmt/vFZGGTsVFI=
X-Google-Smtp-Source: AGHT+IFHrUhABIjTWGW43a6tRWnX7J2PtzXcKPvFK0dGL4VrluUysISn/3aEaBFOayNUPo6Y4WIYsg==
X-Received: by 2002:a25:504:0:b0:d0b:bbc7:56bc with SMTP id 4-20020a250504000000b00d0bbbc756bcmr11402053ybf.45.1692801215917;
        Wed, 23 Aug 2023 07:33:35 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 10-20020a25030a000000b00c5ec980da48sm2860977ybd.9.2023.08.23.07.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/38] btrfs-progs: init new tree blocks in btrfs_alloc_tree_block
Date:   Wed, 23 Aug 2023 10:32:49 -0400
Message-ID: <01c064dd2704444211d0a4ee6cd13f89d4d3a55c.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is how the kernel initializes blocks, so anybody who uses
btrfs_alloc_tree_block in the kernel expects the blocks to be already
initialized.  Put this init code into btrfs-progs so as we sync code
from the kernel we get the correct behavior.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 10482652..4ddf5222 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2558,6 +2558,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					u64 hint, u64 empty_size,
 					enum btrfs_lock_nesting nest)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_key ins;
 	int ret;
 	struct extent_buffer *buf;
@@ -2578,6 +2579,14 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		return ERR_PTR(-ENOMEM);
 	}
 	btrfs_set_buffer_uptodate(buf);
+	memset_extent_buffer(buf, 0, 0, sizeof(struct btrfs_header));
+	btrfs_set_header_level(buf, level);
+	btrfs_set_header_bytenr(buf, buf->start);
+	btrfs_set_header_generation(buf, trans->transid);
+	btrfs_set_header_backref_rev(buf, BTRFS_MIXED_BACKREF_REV);
+	btrfs_set_header_owner(buf, root_objectid);
+	write_extent_buffer_fsid(buf, fs_info->fs_devices->metadata_uuid);
+	write_extent_buffer_chunk_tree_uuid(buf, fs_info->chunk_tree_uuid);
 	trans->blocks_used++;
 
 	return buf;
-- 
2.41.0

