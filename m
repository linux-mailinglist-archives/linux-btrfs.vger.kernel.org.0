Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0498C5B90DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiINXII (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiINXIE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:08:04 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC88087081
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:08:02 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id s13so12911493qvq.10
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=D3yrp+m004UR0fVemLriMd19Z6YV9SNVzs/TI4VG3ss=;
        b=d1sIhTIu1mK1BJz4Bw/DXCwj9vZYrNjLMjZKe7P8lDPk1F3BHqdvqUvyGh8SCWaeIo
         KI6uHnSj66CWCFl/MWr0HVZKtIQYT7GOjl9l9lvYv+2s7e63vZkmnKHJRzzIOaTUKCjd
         diy/tTrCTnkazyM8iWRkZNCJOAGnXrj++LFjm0b/EqBS7VpdJPA0WTLeZLCdv1Se9sK5
         1ytIU9slTiGQ26mq4KACWoWph03iA/nboN/thvnNvBqT3H+aMxpkQwSaSJEfKjM8GdbP
         ey1EWDAwcZC3/nU8SGhm0Za8ZSsYPLUwai0yF4LtudiMJ8RSzNL7nO26AtoABAF0Za7H
         fsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=D3yrp+m004UR0fVemLriMd19Z6YV9SNVzs/TI4VG3ss=;
        b=TU9HvarCT755fY+WWybh2dhOR8tGDlBJzChe0HTKQukvH+CU5pEb/8JTBe5Gap6Nvs
         c9WYMeGyfRh3CkiCU29bQpeI6t3L0uuJ7rkb4Ij55zCBCOPTzJwcLNgRI5VulLDQ5ciA
         Pyxd78I/odClEjo4pDDzs2RhzCG5+FwSvnVjHoQDwYk6h1bfi4dERKQTZRw11HyAUmjO
         R0gb9SrvHdn5sRDo0d8dGK6VksK+2AW1H9B9/PU01cQvqTPG+6/fRVTgAczSA0fkEivX
         DKkhj/rcK5BbFbn4bl2Z3re/dOZIXrrc5d4VR7cMZ3CbOidrLD9wkxK17lr8JJinTEDS
         mlHQ==
X-Gm-Message-State: ACgBeo1jfjQL8IzFOY9gmy7tIICkweHGNLQusUF5Aa5DJO1d6N4iVZ7b
        57xaXBuOiwIXzBR9sGVV+/0sJCaGrDfL4Q==
X-Google-Smtp-Source: AA6agR5Ab1kFDYFqkIZhHv58U41rI8rwq/MwGAlLiyPTQzY+TM/2tJ9mqqCSByPH6eO6e8xdtMomfA==
X-Received: by 2002:ad4:4eec:0:b0:4a5:52eb:5cbe with SMTP id dv12-20020ad44eec000000b004a552eb5cbemr34105163qvb.34.1663196881244;
        Wed, 14 Sep 2022 16:08:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84cce000000b0034355a352d1sm2348702qtv.92.2022.09.14.16.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:08:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/10] btrfs: move btrfs_zoned_data_reloc_*lock to extent_io.c
Date:   Wed, 14 Sep 2022 19:07:47 -0400
Message-Id: <9ff2cb480bba029fb169a15919bf96a87b37a919.1663196746.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196746.git.josef@toxicpanda.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
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

These functions are only used to protect io in extent_io.c, move them
from zoned.h locally in extent_io.c.  These helpers use code not defined
in zoned.h, this cleans up the header file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 16 ++++++++++++++++
 fs/btrfs/zoned.h     | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 18b60304c97a..13c8ed8cbfc8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3301,6 +3301,22 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	return ret;
 }
 
+static inline void btrfs_zoned_data_reloc_lock(struct btrfs_inode *inode)
+{
+	struct btrfs_root *root = inode->root;
+
+	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
+		mutex_lock(&root->fs_info->zoned_data_reloc_io_lock);
+}
+
+static inline void btrfs_zoned_data_reloc_unlock(struct btrfs_inode *inode)
+{
+	struct btrfs_root *root = inode->root;
+
+	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
+		mutex_unlock(&root->fs_info->zoned_data_reloc_io_lock);
+}
+
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc)
 {
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index bd2b3fee4f2d..de1337e462be 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -313,22 +313,6 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device, u64 p
 	btrfs_dev_set_empty_zone_bit(device, pos, false);
 }
 
-static inline void btrfs_zoned_data_reloc_lock(struct btrfs_inode *inode)
-{
-	struct btrfs_root *root = inode->root;
-
-	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
-		mutex_lock(&root->fs_info->zoned_data_reloc_io_lock);
-}
-
-static inline void btrfs_zoned_data_reloc_unlock(struct btrfs_inode *inode)
-{
-	struct btrfs_root *root = inode->root;
-
-	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
-		mutex_unlock(&root->fs_info->zoned_data_reloc_io_lock);
-}
-
 static inline bool btrfs_zoned_bg_is_full(const struct btrfs_block_group *bg)
 {
 	ASSERT(btrfs_is_zoned(bg->fs_info));
-- 
2.26.3

