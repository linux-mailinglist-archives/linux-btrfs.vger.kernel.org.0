Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684CC75B891
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 22:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGTUMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGTUM1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 16:12:27 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48EBED
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 13:12:26 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76754b9eac0so119376585a.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 13:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689883946; x=1690488746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZR+LiEcuS9PmOI+xgU2ABdulN5k7XvyvVG58kN/6DE=;
        b=yibZxlISgBKUpJ/hnUePef62/XfjZxAg3IlUAUHVs9EAYfPMoyj6ObP1vJQ7neMyjb
         /+L3Vb+6XiZJAv+Y++g9Qm+qsgfREimDZ7XY3+hmiJQKiCxFpaSrI0Wo7nMfR/Cyg+Zl
         lHcbQXSsIgnSxbyCMM1luaA3n6uM0IB57nH5GtI1XL2qzOP4ZTPRNEdKbuvsaM4mAGlv
         3hju66CWNSkI8merknetduuZuOQxk3iQUe/9tHYF+eyu9ye/7c87vMWF5IVbCuATdGVE
         rdIB790lh51HsrvG6pAoMwCLP2ZzdYmC5g41S67Z48MSr0IIcLTP6GqXr8li8eAKOTiI
         zYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883946; x=1690488746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZR+LiEcuS9PmOI+xgU2ABdulN5k7XvyvVG58kN/6DE=;
        b=O6RScKIdYtEdVdjXeJItlYPR7VHaI2RsuQia7299UeZAVGiUQNqrSuKgUi7kgFXE8C
         zNrjSsBBxS5enug8a0hxiUh2axJ8IvRVSrXcT3ovEa9F57I+bukqyGaRUtj/2ab4aG0x
         ucKNenjtrVJ39n9RbOIIhZ5ESaDVD3zA3smHvOkwLtINfgWbyPKkqM1zzAmV91XTw1SR
         clrytsoYdgYBiU2ym9FI8azAeFTNUz/2jCRQfA23Vz3+4yKDxl7z7eoV3rNay3D7QUt4
         FlWnebAMeDfaMgnh+DfgHT4lFQyrdLQibsEb9n+SHBHrBnxmEmz06uwo01y06rzCkGPU
         3jjQ==
X-Gm-Message-State: ABy/qLbVRfGZhWLfi9uaQ3DeMgcSYQZ2bryQHnN/boPxCs7Ao86zIz50
        nW+gHW0OqwA+/6BO7ngqLb6qFf9X6rTuysOViHEo6w==
X-Google-Smtp-Source: APBJJlElWFlM0Ev87P/V9HE2UthxmkyJ0v0dT2dZAKbWW8VIS4AZFbfEW7N9ez2EQU4+pZO3GgSWug==
X-Received: by 2002:a05:620a:424f:b0:768:129b:b1c8 with SMTP id w15-20020a05620a424f00b00768129bb1c8mr8035731qko.38.1689883945646;
        Thu, 20 Jul 2023 13:12:25 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g30-20020a0caade000000b006365b23b5dfsm701887qvb.23.2023.07.20.13.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:12:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: cycle through the RAID profiles as a last resort
Date:   Thu, 20 Jul 2023 16:12:16 -0400
Message-ID: <4beedde9b4f6adf4a7054707617f8784e5ee8b35.1689883754.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689883754.git.josef@toxicpanda.com>
References: <cover.1689883754.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of looping through the RAID indices before advancing the FFE
loop lets move this until after we've exhausted the entire FFE loop in
order to give us the highest chance of success in satisfying the
allocation based on its flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8db2673948c9..ca4277ec1b19 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3953,10 +3953,6 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 		return 0;
 	}
 
-	ffe_ctl->index++;
-	if (ffe_ctl->index < BTRFS_NR_RAID_TYPES)
-		return 1;
-
 	/*
 	 * See the comment for btrfs_loop_type for an explanation of the phases.
 	 */
@@ -4026,6 +4022,11 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 		}
 		return 1;
 	}
+
+	ffe_ctl->index++;
+	if (ffe_ctl->index < BTRFS_NR_RAID_TYPES)
+		return 1;
+
 	return -ENOSPC;
 }
 
-- 
2.41.0

