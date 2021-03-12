Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C1339852
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhCLU0m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhCLU0S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:18 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7433C061761
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:17 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id g24so4839794qts.6
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gxYb00Bl/qQfwB//81/hEDg2Vk4vMISElHXXqKu7RI=;
        b=daAUduSQ1/hOc7L2Aze1Bs/lbeQvzC2fiqkz8DrjFB/2dJ4WirJrDqMfC5eONSaFXZ
         +NP7IQ5QHO75F3Z+JYGGAGbtAtVbymrqRCqe1lTujGhg6gdKSACZhWzzx95pR+hevyl1
         bOixG8PQ0GOqx1nO5puERFFpAJVkccPg1erWSaczqB3SNH9RoJj1k3UMaRztjFnBsMoF
         hp3XgrXK9gK3SAOIfMq1Wtm6T2+tm6OEcax4jaAVDoh59p3ztOvNkUFjSQTuTRiqVdbZ
         4e3wxKadLYALGlW/y/FFpZHO/4WkPx5ItxRnH/hA4Wpm0Vdw2z3w1uqqdbJixGl2y4PX
         oDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gxYb00Bl/qQfwB//81/hEDg2Vk4vMISElHXXqKu7RI=;
        b=J2wi9VOQZs/xxaCcws3efXx8vWIdyLwQIoObvbRAKgedWoVo0RN5HFq31vLDO4I2h3
         0O0CUeC+X9+P1K2KjaSoCAXhMCTTBeblbIEIsXdR2xzIZ2nhz4YnGk1deTyWB0IQUK33
         K2Zqh2u4D6LiDMoEqwBX40q4XBvzA9877zv+tU7N7TtsFntCaHJ9GdTi8Mb8tLEJjEMD
         1gvZfFCg4smQbWBL4u9mmf4dd4g9fnlKR/QoirANVv1o2JorHmM8PkiphKTIWrWc00hk
         VyrCJazZX03s3TG4QmRa59AC1FG/7NGzkbr/L5xw9K4MbcEURLvokrh6PO+3pusozEsf
         PTUw==
X-Gm-Message-State: AOAM531oJ2xdn+U9yn2e2yPA4XkbNk2IniB9Wsj/EuvFoTf28H9CkcNt
        TI3jQR5qZ6UZmpR012JrsyDhdQTmHW314C/R
X-Google-Smtp-Source: ABdhPJwF1/7QIttiNT0KmDe8IM+RpXo9HqM8KHK7l9d3Hx7IOYebv8kwBszavakhE7y142MmY6nvJA==
X-Received: by 2002:ac8:5747:: with SMTP id 7mr13805254qtx.274.1615580776836;
        Fri, 12 Mar 2021 12:26:16 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h18sm4645849qtn.49.2021.03.12.12.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 26/39] btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
Date:   Fri, 12 Mar 2021 15:25:21 -0500
Message-Id: <7306e790c23ea756348c2e955cbe0347ec8c01dd.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few BUG_ON()'s in replace_path are purely to keep us from making
logical mistakes, so replace them with ASSERT()'s.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7b242f527bd8..dfd58fa9f189 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1210,8 +1210,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	int ret;
 	int slot;
 
-	BUG_ON(src->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
-	BUG_ON(dest->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(src->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(dest->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
 
 	last_snapshot = btrfs_root_last_snapshot(&src->root_item);
 again:
@@ -1242,7 +1242,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	parent = eb;
 	while (1) {
 		level = btrfs_header_level(parent);
-		BUG_ON(level < lowest_level);
+		ASSERT(level >= lowest_level);
 
 		ret = btrfs_bin_search(parent, &key, &slot);
 		if (ret < 0)
-- 
2.26.2

