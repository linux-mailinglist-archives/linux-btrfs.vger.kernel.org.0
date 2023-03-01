Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52346A7601
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 22:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCAVO6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 16:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCAVOu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 16:14:50 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2944615E
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 13:14:49 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id jo29so10345201qvb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Mar 2023 13:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1677705288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkJuyulNevmd7yk0hGOBaX8JL/71/bfAdog6KkOrzLM=;
        b=zm5clUB5IPy4/3EWIUCiwSUbQ0r/UdJwtfsV4lTAtRKLU8zzBzRwr4I+Nqlsa1cq/w
         zUVrONS19XvCz9AUYOSJGFJ1W0K25ojvlAhq2cTnyFXeccTGe1Fx77MppnwvRLYPkdp3
         akSHLjqkneiNRKvUrJLX7zm0/o7QB1jDi8ez3qDE8VPgmxSUMXGaLZi/BTQbIRZucxUX
         ZwrgT78NpcfC4Dh9cni26s3c3nmc3li8AORmg1gfPbBznq/1h0eP5+6tnJbL9ace5gv5
         WIgKo+bIje3axYTtjhzgWc4phaU6aAExJg6GagUD2Hxq33ZLAVF1as/d6HEcGVAYQOG0
         SKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677705288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkJuyulNevmd7yk0hGOBaX8JL/71/bfAdog6KkOrzLM=;
        b=ua4PMg9IvcEGtdNaZiYjIFtLLppQYNF6gn0Uln5CnLLRkqlNkB1lYnsr89KaX5ZD8U
         ytQy475z28xVYielRHchoh2kcwhpnOU24kZXY39JpHcZ2Z92wx5wnW8b/cXg7rWigEWM
         z3UQB2rIqGuR/kNg7B7NkvnMcU9w/xWHCmOa+4AFfhjIT1g+dTVlasxw2V/4DmE47n4d
         RYdyN3ng7Xm60fvv3YNOnLIctO704xch7XD9CEecVM9UQlRB67MN4w+R1WV6f70aq8MK
         DFEMpDPLmSkZ5vRS7ifSwjJsPAigjWN4Kz6ghU15KPpxSEqakiHH1/0fFHfiduDyMrIX
         cbdg==
X-Gm-Message-State: AO0yUKUNmXgMZ2BGc23RrQ69WSQo1OqvnyfyoooBX+5e4ZwcTBKv2f4S
        TB81Bu0Z+Ppzd0w/f7iFAeuCQqLnEthRytfIivQ=
X-Google-Smtp-Source: AK7set8J0PjGiAxF4jmVuanh1/D6QF8qbMY6vZ5m8XpOKjukD6uKuF0E80B9nR0snXpqDJcfhiuyYw==
X-Received: by 2002:a05:6214:dc5:b0:56f:8a99:1a67 with SMTP id 5-20020a0562140dc500b0056f8a991a67mr17268499qvt.3.1677705287772;
        Wed, 01 Mar 2023 13:14:47 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id t9-20020a05620a0b0900b0073b399700adsm9570420qkg.3.2023.03.01.13.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 13:14:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: rename BTRFS_FS_NO_OVERCOMMIT -> BTRFS_FS_ACTIVE_ZONE_TRACKING
Date:   Wed,  1 Mar 2023 16:14:42 -0500
Message-Id: <5cb6fa87af8959b0ee9b33591968812fc6b4ab87.1677705092.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1677705092.git.josef@toxicpanda.com>
References: <cover.1677705092.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This flag only gets set when we're doing active zone tracking, and I'm
going to need to use this flag for things related to this behavior.
Rename the flag to represent what it actually means for the file system
so it can be used in other ways and still make sense.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/fs.h         | 7 ++-----
 fs/btrfs/space-info.c | 2 +-
 fs/btrfs/zoned.c      | 3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 4c477eae6891..24cd49229408 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -120,11 +120,8 @@ enum {
 	/* Indicate that we want to commit the transaction. */
 	BTRFS_FS_NEED_TRANS_COMMIT,
 
-	/*
-	 * Indicate metadata over-commit is disabled. This is set when active
-	 * zone tracking is needed.
-	 */
-	BTRFS_FS_NO_OVERCOMMIT,
+	/* This is set when active zone tracking is needed. */
+	BTRFS_FS_ACTIVE_ZONE_TRACKING,
 
 	/*
 	 * Indicate if we have some features changed, this is mostly for
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 69c09508afb5..2237685d1ed0 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -407,7 +407,7 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
-	if (test_bit(BTRFS_FS_NO_OVERCOMMIT, &fs_info->flags) &&
+	if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags) &&
 	    (space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
 		avail = 0;
 	else
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f95b2c94d619..808cfa3091c5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -524,8 +524,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		}
 		atomic_set(&zone_info->active_zones_left,
 			   max_active_zones - nactive);
-		/* Overcommit does not work well with active zone tacking. */
-		set_bit(BTRFS_FS_NO_OVERCOMMIT, &fs_info->flags);
+		set_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags);
 	}
 
 	/* Validate superblock log */
-- 
2.26.3

