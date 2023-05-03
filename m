Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534C96F4FDD
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 08:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjECGEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 02:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjECGEG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 02:04:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148FF30CB
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 23:04:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 707B81FFD3
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683093843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lz9jzlhBGS2UN45B0KbNx0Ewxf053x0ClejOm6V5uzs=;
        b=fy4L5KyYjWPGAL2c6r64e9RFrD0hiQem/M2EHz5EAf3vgHSGDMMPOf6q52fhtQhjyBZe8E
        rXuf5htBSOzepAmj7PmxCOcwLUlwvLFjREC0jwNBjujU9N2Tq3DFqcURqSgH6oAtDkZ6ep
        BHTYGqaBrJxJR3UaR8EawKjkKvLUd38=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B502B13584
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UA55HlL5UWSTJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 06:04:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/7] btrfs-progs: remove function btrfs_check_allocatable_zones()
Date:   Wed,  3 May 2023 14:03:37 +0800
Message-Id: <8358b7a43c479769bf32c1ccac24284442ceb567.1683093416.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683093416.git.wqu@suse.com>
References: <cover.1683093416.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function is introduced by commit b031fe84fda8 ("btrfs-progs: zoned:
implement zoned chunk allocator") but it never got called since then.

Furthermore in the kernel zoned code, there is no such function from the
very beginning, and everything is handled by
btrfs_find_allocatable_zones().

Thus we can safely remove the function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/zoned.c | 58 -------------------------------------------
 1 file changed, 58 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 7d2e68d08bcc..16abb042f5b0 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -596,64 +596,6 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
 	return ret_sz;
 }
 
-/*
- * Check if spcecifeid region is suitable for allocation
- *
- * @device:	the device to allocate a region
- * @pos:	the position of the region
- * @num_bytes:	the size of the region
- *
- * In non-ZONED device, anywhere is suitable for allocation. In ZONED
- * device, check if:
- * 1) the region is not on non-empty sequential zones,
- * 2) all zones in the region have the same zone type,
- * 3) it does not contain super block location
- */
-bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
-				   u64 num_bytes)
-{
-	struct btrfs_zoned_device_info *zinfo = device->zone_info;
-	u64 nzones, begin, end;
-	u64 sb_pos;
-	bool is_sequential;
-	int shift;
-	int i;
-
-	if (!zinfo || zinfo->model == ZONED_NONE)
-		return true;
-
-	nzones = num_bytes / zinfo->zone_size;
-	begin = pos / zinfo->zone_size;
-	end = begin + nzones;
-
-	ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
-	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
-
-	if (end > zinfo->nr_zones)
-		return false;
-
-	shift = ilog2(zinfo->zone_size);
-	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
-		sb_pos = sb_zone_number(shift, i);
-		if (!(end < sb_pos || sb_pos + 1 < begin))
-			return false;
-	}
-
-	is_sequential = btrfs_dev_is_sequential(device, pos);
-
-	while (num_bytes) {
-		if (is_sequential && !btrfs_dev_is_empty_zone(device, pos))
-			return false;
-		if (is_sequential != btrfs_dev_is_sequential(device, pos))
-			return false;
-
-		pos += zinfo->zone_size;
-		num_bytes -= zinfo->zone_size;
-	}
-
-	return true;
-}
-
 /**
  * btrfs_find_allocatable_zones - find allocatable zones within a given region
  *
-- 
2.39.2

