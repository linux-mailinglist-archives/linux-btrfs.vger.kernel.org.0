Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31C65B3BB6
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 17:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiIIPSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiIIPSr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 11:18:47 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF12414672E
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 08:18:45 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1278624b7c4so4710922fac.5
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=z6Jy7WTQMImA6LM/9bYUO4MpARv1mTbkBlW6SCcQ3CE=;
        b=iCWzNl8NrfVUSCkve1iw2v1iKRViSa+oxBvdNqXme+GjxNRt8/s5IzcMAv3VdOOgaQ
         BYWh/HumHowXU/xO+T2Eu9yAKvYS9buUqufPQWOoq+RCSqPsPTmZJwWnKMmaq1qWJGKT
         C+3pKkZ41/fQX+pE+jpFyMLHpscD4mTIy+lLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=z6Jy7WTQMImA6LM/9bYUO4MpARv1mTbkBlW6SCcQ3CE=;
        b=Vvqu8lAeMabQCTIiwJEY7jQlF5k02arxHvuQkzIpZt+iCQqgRzvzc2tsJxkGHgtynh
         tTkdY7mPPYu+pnZkqDoCsJMx1wA0I1p9ESdyL8cCaSmXA+djqEZzr0GD3ZTKoIwdktUJ
         TU08XDxHMW1JwOf4u1TxFu619YA+YyUpOIcUIZhm6OLR/yIUYEgI76SJ7G6UBsZwV8Fl
         R1vPdlQdEu2x1+knU00ibGyCMILev1ihm2Zm5hOxb3ezHiEnmubf6CiAdG0vO9NaO9xb
         ylYyPsDpIhJ23CPsB6IG9XUNPdPFnTsKzpoxmiMONq8jeJzJcIq7xkjBtdzDPsLWO5gu
         TiNw==
X-Gm-Message-State: ACgBeo0GK0VDSyJj1CSOrTQVwj3IfS9trTYp1fDZPpw6A/zuZwTWaSx+
        SIDDu57kjHnkN+zhMnacT18hKg==
X-Google-Smtp-Source: AA6agR72I94eWZfQD/AmcKdpZ7Z03aH4B70v5T4r1MMcqh8gx0/CxQYUs/5c92P/mg372scUruuH3A==
X-Received: by 2002:a05:6870:88a6:b0:126:b40a:1f2d with SMTP id m38-20020a05687088a600b00126b40a1f2dmr5078073oam.119.1662736724994;
        Fri, 09 Sep 2022 08:18:44 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-67-190-102-125.hsd1.co.comcast.net. [67.190.102.125])
        by smtp.gmail.com with ESMTPSA id eq22-20020a056870a91600b0012779ba00fesm591977oab.2.2022.09.09.08.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:18:44 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     U-Boot Mailing List <u-boot@lists.denx.de>
Cc:     Simon Glass <sjg@chromium.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Philippe Reynes <philippe.reynes@softathome.com>,
        Qu Wenruo <wqu@suse.com>, Stefan Roese <sr@denx.de>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 06/14] fs: Quieten down the filesystems more
Date:   Fri,  9 Sep 2022 09:17:53 -0600
Message-Id: <20220909151801.336551-7-sjg@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220909151801.336551-1-sjg@chromium.org>
References: <20220909151801.336551-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When looking for a filesystem on a partition we should do so quietly. At
present if the filesystem is very small (e.g. 512 bytes) we get a host of
messages.

Update these to only show when debugging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 disk/part_efi.c       | 15 +++++++--------
 fs/btrfs/disk-io.c    |  7 ++++---
 fs/ext4/ext4_common.c |  2 +-
 fs/fs_internal.c      |  3 +--
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 5090efd1192..911089f76dd 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -266,20 +266,19 @@ int part_get_info_efi(struct blk_desc *dev_desc, int part,
 
 	/* "part" argument must be at least 1 */
 	if (part < 1) {
-		printf("%s: Invalid Argument(s)\n", __func__);
-		return -1;
+		log_debug("Invalid Argument(s)\n");
+		return -EINVAL;
 	}
 
 	/* This function validates AND fills in the GPT header and PTE */
 	if (find_valid_gpt(dev_desc, gpt_head, &gpt_pte) != 1)
-		return -1;
+		return -EINVAL;
 
 	if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
 	    !is_pte_valid(&gpt_pte[part - 1])) {
-		debug("%s: *** ERROR: Invalid partition number %d ***\n",
-			__func__, part);
+		log_debug("*** ERROR: Invalid partition number %d ***\n", part);
 		free(gpt_pte);
-		return -1;
+		return -EPERM;
 	}
 
 	/* The 'lbaint_t' casting may limit the maximum disk size to 2 TB */
@@ -302,8 +301,8 @@ int part_get_info_efi(struct blk_desc *dev_desc, int part,
 			info->type_guid, UUID_STR_FORMAT_GUID);
 #endif
 
-	debug("%s: start 0x" LBAF ", size 0x" LBAF ", name %s\n", __func__,
-	      info->start, info->size, info->name);
+	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
+		  info->size, info->name);
 
 	/* Remember to free pte */
 	free(gpt_pte);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8043abc1bd6..e2562877e0a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <common.h>
 #include <fs_internal.h>
+#include <log.h>
 #include <uuid.h>
 #include <memalign.h>
 #include "kernel-shared/btrfs_tree.h"
@@ -912,9 +913,9 @@ static int btrfs_scan_fs_devices(struct blk_desc *desc,
 
 	if (round_up(BTRFS_SUPER_INFO_SIZE + BTRFS_SUPER_INFO_OFFSET,
 		     desc->blksz) > (part->size << desc->log2blksz)) {
-		error("superblock end %u is larger than device size " LBAFU,
-				BTRFS_SUPER_INFO_SIZE + BTRFS_SUPER_INFO_OFFSET,
-				part->size << desc->log2blksz);
+		log_debug("superblock end %u is larger than device size " LBAFU,
+			  BTRFS_SUPER_INFO_SIZE + BTRFS_SUPER_INFO_OFFSET,
+			  part->size << desc->log2blksz);
 		return -EINVAL;
 	}
 
diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index d49ba4a9954..1185cb2c046 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -2415,7 +2415,7 @@ int ext4fs_mount(unsigned part_length)
 
 	return 1;
 fail:
-	printf("Failed to mount ext2 filesystem...\n");
+	log_debug("Failed to mount ext2 filesystem...\n");
 fail_noerr:
 	free(data);
 	ext4fs_root = NULL;
diff --git a/fs/fs_internal.c b/fs/fs_internal.c
index ae1cb8584c7..111f91b355d 100644
--- a/fs/fs_internal.c
+++ b/fs/fs_internal.c
@@ -29,8 +29,7 @@ int fs_devread(struct blk_desc *blk, struct disk_partition *partition,
 	/* Check partition boundaries */
 	if ((sector + ((byte_offset + byte_len - 1) >> log2blksz))
 	    >= partition->size) {
-		log_err("%s read outside partition " LBAFU "\n", __func__,
-			sector);
+		log_debug("read outside partition " LBAFU "\n", sector);
 		return 0;
 	}
 
-- 
2.37.2.789.g6183377224-goog

