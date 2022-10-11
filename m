Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB225FB7BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJKPv7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJKPvl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 11:51:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6934D1172
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 08:48:10 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r20so7355453ilt.11
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDmZu8dsnx5R+YVKV7Fd0nTlKmj3LngBBHmQCaeFvXk=;
        b=LK4fRajv3ZLADgDpK0WbaBToe+g2TmV00aBlAwYcSF47TABlqFpqkSaSWcvVMtPemC
         zocYhKUrYwsoiDhzE4KkNP/r3WH2fEJzrbwuvYKNiGxjq0wqSTUy2Ke9I2POZKI2ddRe
         WG9oOJ/yDmjfaGlQX73a8wHu3ZPKmQFTlOpuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDmZu8dsnx5R+YVKV7Fd0nTlKmj3LngBBHmQCaeFvXk=;
        b=wH97hpGSLHFnK/uOPsjifGYUpmza/ovB5fAVqH9HwHYGIBF1Tmfdqd+AOeptDco4QC
         XDG5Io9FG6NBNLdF36YbXlaP+ut//+K5jsO1KzcVEaDkwoNaVI6NRPE9OEsl7boPbe+I
         Nkx34d13Yo7uGe6XISftoklz71cIX9fwIvaLAcxKYJ28W+D8gce/6S6cAZg7OgP2Zlid
         0JqIoOf3P9rOVU0fM4b+1u/bdgxSPLMkaXRC9l6EDhMq6GxmQ+lAztjqPV9ot52yeWKt
         5oAxniwkehjcGYqIZT0V/4xd9x5vefvgVd8CQWUJu4+D9iAbUYuuAskucS0rcsWcdUl2
         36Kw==
X-Gm-Message-State: ACrzQf2Ksyd8EqOv0CCw6HKI3WkKBxiYnD2QvyN3VvRx4F3AL2WeYPNo
        C9lr2i4D6erMLDnPLIbPkYfJJQ==
X-Google-Smtp-Source: AMsMyM7RnYSbsk92Uua8JwXakVve0ylm2UFa63P7i1PVXII8067gfD7/aKYP4D1EN5/AQfYRYUZfNg==
X-Received: by 2002:a05:6e02:1a6f:b0:2fa:8b33:de50 with SMTP id w15-20020a056e021a6f00b002fa8b33de50mr13193996ilv.267.1665503289842;
        Tue, 11 Oct 2022 08:48:09 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-67-190-102-125.hsd1.co.comcast.net. [67.190.102.125])
        by smtp.gmail.com with ESMTPSA id r12-20020a922a0c000000b002f9b55e7e92sm4988680ile.0.2022.10.11.08.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:48:09 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     U-Boot Mailing List <u-boot@lists.denx.de>
Cc:     Simon Glass <sjg@chromium.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Philippe Reynes <philippe.reynes@softathome.com>,
        Qu Wenruo <wqu@suse.com>, Stefan Roese <sr@denx.de>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/14] fs: Quieten down the filesystems more
Date:   Tue, 11 Oct 2022 09:47:11 -0600
Message-Id: <20221011154720.550320-6-sjg@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011154720.550320-1-sjg@chromium.org>
References: <20221011154720.550320-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v1)

 disk/part_efi.c       | 15 +++++++--------
 fs/btrfs/disk-io.c    |  7 ++++---
 fs/ext4/ext4_common.c |  2 +-
 fs/fs_internal.c      |  3 +--
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index ad94504ed90..26738a57d5d 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -264,20 +264,19 @@ int part_get_info_efi(struct blk_desc *dev_desc, int part,
 
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
@@ -300,8 +299,8 @@ int part_get_info_efi(struct blk_desc *dev_desc, int part,
 			info->type_guid, UUID_STR_FORMAT_GUID);
 #endif
 
-	debug("%s: start 0x" LBAF ", size 0x" LBAF ", name %s\n", __func__,
-	      info->start, info->size, info->name);
+	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
+		  info->size, info->name);
 
 	/* Remember to free pte */
 	free(gpt_pte);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c80f8e80283..3f0d9f1c113 100644
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
@@ -910,9 +911,9 @@ static int btrfs_scan_fs_devices(struct blk_desc *desc,
 
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
2.38.0.rc1.362.ged0d419d3c-goog

