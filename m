Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B829F2A0FE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgJ3VDa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VD3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:29 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B46C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:28 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t20so3412343qvv.8
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kC1BvpNjGdLAI7Rfy9a66TcHawg1xO4t+0xXAe1Gyyg=;
        b=K8ZuRdHJXAJOo3oNKipwRYzLsAF0XXLv/Zg6v71kfr35uTMV5VWqpjtbXbNeg2BS3C
         UDBYYkf4n2ZE/Ick56pkPAJpkkRGNW1vr9i9QQPZjhRRuy7y6JPRTKvLqs4QJ1N8wknp
         5wsfmh3EZ+p3OBIvrNvPIdIy/kWxEF1ZKjR2rJCZmfOHAU4ZK4+z1PM5I19edvaFfXK/
         BHtePxgsVa3T4vjRnZaBIVqYZoR3edBvqlLEhJY4UdZ1zAcuf+13ox8/S7AFgg6M/AKG
         sR+JOjUgM5JOYpZO+Z4MuDRs3RcSzQfAQWHx9a8Nhq1QoXt6RXLGei7hQN/kIIVs8gz1
         bR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kC1BvpNjGdLAI7Rfy9a66TcHawg1xO4t+0xXAe1Gyyg=;
        b=kPGUle1XmI7eZfARSI58DC3xpIyHXLtFMQqI+mhUiahfXBZBeksWRkGMkQoC5XwBqf
         GL42ZJ9sh2WBk3hnK7MRua5YGQTDWwtzTWcPsiZ+MLjXb4qHoMKyXBKkHlNqCp53/uXl
         a1sDn2Otbp++K4LkJqAZCOwBceahZH4ouJ4jwS6ii8lKaO4GQKsyTHYJAZOepT3cnJft
         vnZ2hV6zWqaH8L+GXXuHHM0ob/Jywn5wdbXZ53nmRoO1PupPKcGr4uOMO7VyW3lpZiwg
         AkfMcF61ouCm2j2IqvQEMNSceE6t3oz/cxda8tEIChriUp3Fokmf8kasRg4+B859rRne
         yQRA==
X-Gm-Message-State: AOAM533F4YHSOCp11eqipSp7+IMSSF/Psz+WHzWQqjFoYPGpn18VcOFy
        36czYhBx/rfd1JM3fg352HOdTfEw7FoCiHeK
X-Google-Smtp-Source: ABdhPJyr7udmF2ikf2L80m0aU1Hqz1r7GpKK0MX2d0QIgD8TCRQtC5v9KRar0NQd1UHcHiuVNGjYsw==
X-Received: by 2002:a05:6214:1588:: with SMTP id m8mr11408953qvw.18.1604091807272;
        Fri, 30 Oct 2020 14:03:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a3sm3396615qtp.63.2020.10.30.14.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/14] btrfs: use btrfs_read_node_slot in btrfs_qgroup_trace_subtree
Date:   Fri, 30 Oct 2020 17:03:02 -0400
Message-Id: <7a0adeab1bc81dbcd0199aa3108899890015f244.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604091530.git.josef@toxicpanda.com>
References: <cover.1604091530.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're open-coding btrfs_read_node_slot() here, replace with the helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ddd1cd6db6c4..0052b1c7d4c3 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2186,30 +2186,21 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	level = root_level;
 	while (level >= 0) {
 		if (path->nodes[level] == NULL) {
-			struct btrfs_key first_key;
 			int parent_slot;
-			u64 child_gen;
 			u64 child_bytenr;
 
 			/*
-			 * We need to get child blockptr/gen from parent before
-			 * we can read it.
+			 * We need to get child blockptr from parent before we
+			 * can read it.
 			  */
 			eb = path->nodes[level + 1];
 			parent_slot = path->slots[level + 1];
 			child_bytenr = btrfs_node_blockptr(eb, parent_slot);
-			child_gen = btrfs_node_ptr_generation(eb, parent_slot);
-			btrfs_node_key_to_cpu(eb, &first_key, parent_slot);
 
-			eb = read_tree_block(fs_info, child_bytenr, child_gen,
-					     level, &first_key);
+			eb = btrfs_read_node_slot(eb, parent_slot);
 			if (IS_ERR(eb)) {
 				ret = PTR_ERR(eb);
 				goto out;
-			} else if (!extent_buffer_uptodate(eb)) {
-				free_extent_buffer(eb);
-				ret = -EIO;
-				goto out;
 			}
 
 			path->nodes[level] = eb;
-- 
2.26.2

