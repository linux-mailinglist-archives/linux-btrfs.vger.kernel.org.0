Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68E46551F
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352235AbhLASU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352138AbhLASUt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:20:49 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C85C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:28 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t11so24974555qtw.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KNkMciKNt/whslgMekzPaIvfMEwa+U3L0W4rFrYFXc4=;
        b=ozQEK13C4UGocityLoPRYdX/KS0Bi2XuvgniD4UHMzTLThE+dL5hbz9uvOByrPVwUA
         mgfM/V+p1dTU42//N+W1ZI4dJ8li8ounWQUAu/+/L+SacvblUt7q/w+tfeWAs7PbhXAd
         oa5MBWAn63Bp9fSqbbhDw6lYEiXjmS6eu76Rk1OtDipI1JwNmpGRmw5EiKT6zuRFG979
         q5bjuhqokZXwIczWGg5QcGBhcc1zPBUp01yTFhOVYQBGrIPBLG4uyNQEHIb+h4Kj42LG
         vVxxp8px3FauNN3MUo0wA6sr/r5rTI+Sm06LxZv7JPiNp9xGRuZDNXidqDil7uB/TfyO
         WzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNkMciKNt/whslgMekzPaIvfMEwa+U3L0W4rFrYFXc4=;
        b=QGkV+shDlpndkP5bgSGqAZIV671UPFTTcQYPVMdf0meyU7twl6Q0/qVfOK4egVWi0Q
         zAdVR/SWdGc8jLWnAfEsM5hZmKCzlMIX0zWOgXKGDQNkwOzFp4Tjbai/lMKQAbwm6m2x
         8vXZLl3qnLcXjHeaoLN/46su2NINzwH3VNk3xLq7DuVFdl48eMN1sy+4KYkpPaF+ACiF
         PnU6Rm9+8DnbzsSKYMOe1co3L1H6mqmdeh0el7IcfdFZwhoMJ95fdeUZiHUbEVKrA8Kb
         j+6ogxhEyeWtGj+raR93/KvIbunDp9SVmjEXVcF6dgEpLVrewgm1T+kMSXTp3bXCsurY
         HskQ==
X-Gm-Message-State: AOAM530c1IG6kIxVkJWb18baE32rXrzzF799NjfIzY6j1uVy6Qlpavnz
        Gc1Yzqo0NhNQDzDI09fulfzaJRzqX9j8/g==
X-Google-Smtp-Source: ABdhPJxS+5uFpIm7DyThHTE43bsQ6Q+JBu9YrOSVzd+jwREstvx1t23bVdw4DwLB+2OEQoYoZ/jbGg==
X-Received: by 2002:a05:622a:38d:: with SMTP id j13mr8721573qtx.159.1638382647457;
        Wed, 01 Dec 2021 10:17:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f7sm260852qkp.107.2021.12.01.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/22] btrfs-progs: check-lowmem: use the btrfs_block_group_root helper
Date:   Wed,  1 Dec 2021 13:17:01 -0500
Message-Id: <695ed52c2aa658a89ecfc1ebe656c5b41e7f8126.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we're messing with block group items use the
btrfs_block_group_root() helper to get the correct root to search, and
this will do the right thing based on the file system flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index cc6773cd..263b56d1 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -266,7 +266,7 @@ static int modify_block_group_cache(struct btrfs_block_group *block_group, int c
  */
 static int modify_block_groups_cache(u64 flags, int cache)
 {
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_key key;
 	struct btrfs_path path;
 	struct btrfs_block_group *bg_cache;
@@ -331,7 +331,7 @@ static int clear_block_groups_full(u64 flags)
 static int create_chunk_and_block_group(u64 flags, u64 *start, u64 *nbytes)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	int ret;
 
 	if ((flags & BTRFS_BLOCK_GROUP_TYPE_MASK) == 0)
@@ -419,7 +419,7 @@ static int is_chunk_almost_full(u64 start)
 {
 	struct btrfs_path path;
 	struct btrfs_key key;
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_block_group_item *bi;
 	struct btrfs_block_group_item bg_item;
 	struct extent_buffer *eb;
@@ -4591,7 +4591,7 @@ next:
 static int find_block_group_item(struct btrfs_path *path, u64 bytenr, u64 len,
 				 u64 type)
 {
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 	int ret;
-- 
2.26.3

