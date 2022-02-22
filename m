Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997514C0494
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiBVW04 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiBVW0z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:26:55 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1AB10B5
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:29 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d3so3590113qvb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=611LCI5vySsFWRZuSkZ9BinIxusuA0FwgYLFYstxWmQ=;
        b=Z2DvIM5FppOhX7/ySROoCuWYZ59vsRkt9JLUq6DelrLPjwMzOgIgNmkzeGg7vwXgTG
         F+a7ZqapbH9qF/4pe1nnmAbX9bIY0nG9aKTu12fookW1tiw5072GI2+WlBbvrOFVDkHp
         joniNNtwU0XrJHC10MNBLdECY4luAK5pW2tbmKm3jK5AB5gI65J4D9isHSkkuK6+NdSf
         NTHo0bdq6rCVVddIwkBoFhKi0UDcrB9ITDqYrCCla1ZoxkoRijK8XJxLAoHgqtm+oqKy
         98lst4/sa7sOY3HKVRYHReo8b07iSocNlR+ypcbrQjdVdI05MLOtJTvDi4aIydjhzi4d
         xQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=611LCI5vySsFWRZuSkZ9BinIxusuA0FwgYLFYstxWmQ=;
        b=ITimzYojhQLUY0SKBSqSlVEOIbNJZAfRRY5SxSCMnK0W6JXZ28bfl7sTpMVzCuCyFA
         bZfK5L4ea/5v3J3TY+8tiUppTqD1jPoKx8aoTtIcJU3X0b+0JfchfpylYRZMa8yPVeoB
         mM1hLUODmA9hZES1yxKHwnpJpzRE953HGwKzR6T+brBnsXhr+w36usUKTQS14jmIo4W7
         AyXbzoazySx0GUnefFZtKuYQ2pxVhijyuk5ApgATZvoIgTdy4wM15ArjKVfkfaby/it1
         yzVAM1rVxS3MVXlpYwF+GotqQeokN8xl7Hd/GnNpBLJ9UqXXjqybn3aCUS6GW5byudU6
         YTjw==
X-Gm-Message-State: AOAM530RYdNUGSvaT+VCKy7AE8mejdx5QtWBBqAys1BDpuJGXfTy01Sc
        UFJtQzlO2BJr37m49qF+KvH0REQi9Oy3rS15
X-Google-Smtp-Source: ABdhPJzJPDI3Fnpoec1jEPHWpxqf5nMgW8V5l+EPkGELw3GtRmZD6XyQBPKiIz5AnYQnE9n3GlXRgQ==
X-Received: by 2002:ac8:5a0a:0:b0:2de:b81:24ca with SMTP id n10-20020ac85a0a000000b002de0b8124camr11719704qta.271.1645568788602;
        Tue, 22 Feb 2022 14:26:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 18sm696283qtx.88.2022.02.22.14.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/13] btrfs-progs: store BTRFS_LEAF_DATA_SIZE in the fs_info
Date:   Tue, 22 Feb 2022 17:26:13 -0500
Message-Id: <94cb2a8f86edb5ecbe0874ccd7ca3d5514bdab6f.1645568701.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
References: <cover.1645568701.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is going to be a different value based on the incompat settings of
the file system, just store this in the fs_info instead of calculating
it every time.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h   | 4 ++--
 kernel-shared/disk-io.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index de5452f2..31169f33 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -363,8 +363,7 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	return nodesize - sizeof(struct btrfs_header);
 }
 
-#define BTRFS_LEAF_DATA_SIZE(fs_info) \
-				(__BTRFS_LEAF_DATA_SIZE(fs_info->nodesize))
+#define BTRFS_LEAF_DATA_SIZE(fs_info) (fs_info->leaf_data_size)
 
 /*
  * this is a very generous portion of the super block, giving us
@@ -1271,6 +1270,7 @@ struct btrfs_fs_info {
 	u32 nodesize;
 	u32 sectorsize;
 	u32 stripesize;
+	u32 leaf_data_size;
 	u16 csum_type;
 	u16 csum_size;
 
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index f83ba884..0434ed7d 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1552,6 +1552,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 	fs_info->stripesize = btrfs_super_stripesize(disk_super);
 	fs_info->csum_type = btrfs_super_csum_type(disk_super);
 	fs_info->csum_size = btrfs_super_csum_size(disk_super);
+	fs_info->leaf_data_size = __BTRFS_LEAF_DATA_SIZE(fs_info->nodesize);
 
 	ret = btrfs_check_fs_compatibility(fs_info->super_copy, flags);
 	if (ret)
-- 
2.26.3

