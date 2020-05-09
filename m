Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC61CBDB2
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 07:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgEIFU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 01:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgEIFU0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 May 2020 01:20:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E16C061A0C;
        Fri,  8 May 2020 22:20:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so5234882pjb.0;
        Fri, 08 May 2020 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+T9eW2owY9q4Gb8vjKMZplraEfe6AYxf3AR2Osn5jN0=;
        b=Kkjt9IiRnzbkfmp7+hnU9lHDQc2fbSpVCMCaiWueCBEGH667DO8TTOBTNYSdYwyV4G
         Sk4NHPzL71YlcuLs+5gezK6C6rV/XTXqWrDvMt9qLniW9SV7BfcPdPUNbcNWWogrDSC1
         0J8WV8KOc/Ny5XhtkLFqEU88eurZbNpUFVsO3VU4KmkuthBZrm5D2GlPZx77TXmbcWJB
         Mo7XkAAWIBnPqZNm6jP/37l6bbQP5QBBc+ItUGSB2dhbEELAoCN8ld9NTZdonbxQ6hXc
         y/+pTX1/mH4m2eCTBfwVlz/q59T+UwFCKB9RPJry0xVY5Zavt0tGf/PkbXRmt6mg4Mwe
         5HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+T9eW2owY9q4Gb8vjKMZplraEfe6AYxf3AR2Osn5jN0=;
        b=sVR25Og0zuL0469MjmRGljZQ5fQPLf5nJEBUJaUa+ewSIvCEsdZjmnlt1x5C82ptLg
         fhTsQuxghyVJLOHWoZqU2gaZIMvdc27x/RzipuO5g1nfT/uxsfOeA6CawKf1J470LMIG
         VTdIcsyVuAidAzHEy42AXmTC0g8hmBRZ6QaV+/5Ek+3Eu/8nWqgzkc7hCMyH99G3tayu
         UpTRh+ZTxTAL5qqnvQRqWyzSpKP/H6fyYbbZBP7BIBpi9yEuowV53lmz8ONxmVI0870G
         cfIOKATn3+FKSF1q35wVphNbSCzL97+wGYh0XoDfs9Ecxk6y06s9MfOxYe0bTAX4iX78
         /aag==
X-Gm-Message-State: AGi0PuYXXc3N1cL8LT1Zs24Wsm5b9i5SfICm38wpNdAZMFle0OhimskD
        ZEiK1LAR7cHbqAjh8nfPxfQ=
X-Google-Smtp-Source: APiQypIC5AosZruIS7Cr4bGisH5c/SrwVaDvEytMqYNScxNBSLTRxaLmEYTTW6tVr/fhKKXV3mN1Og==
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr8783323pja.80.1589001624980;
        Fri, 08 May 2020 22:20:24 -0700 (PDT)
Received: from localhost.localdomain ([223.72.62.216])
        by smtp.gmail.com with ESMTPSA id j32sm2638775pgb.55.2020.05.08.22.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:20:24 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/4] fs: btrfs: fix a data race in btrfs_block_group_done()
Date:   Sat,  9 May 2020 13:20:01 +0800
Message-Id: <20200509052001.2298-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The functions btrfs_block_group_done() and caching_thread() are 
concurrently executed at runtime in the following call contexts:

Thread 1:
  btrfs_sync_file()
    start_ordered_ops()
      btrfs_fdatawrite_range()
        btrfs_writepages() [via function pointer]
          extent_writepages()
            extent_write_cache_pages()
              __extent_writepage()
                writepage_delalloc()
                  btrfs_run_delalloc_range()
                    cow_file_range()
                      btrfs_reserve_extent()
                        find_free_extent()
                          btrfs_block_group_done()

Thread 2:
  caching_thread()

In btrfs_block_group_done():
  smp_mb();
  return cache->cached == BTRFS_CACHE_FINISHED ||
      cache->cached == BTRFS_CACHE_ERROR;

In caching_thread():
  spin_lock(&block_group->lock);
  block_group->caching_ctl = NULL;
  block_group->cached = ret ? BTRFS_CACHE_ERROR : BTRFS_CACHE_FINISHED;
  spin_unlock(&block_group->lock);

The values cache->cached and block_group->cached access the same memory, 
and thus a data race can occur.
This data race was found and actually reproduced by our concurrency 
fuzzer.

To fix this race, the spinlock cache->lock is used to protect the 
access to cache->cached in btrfs_block_group_done().

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/btrfs/block-group.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 107bb557ca8d..fb5f12acea40 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -278,9 +278,13 @@ static inline u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
 
 static inline int btrfs_block_group_done(struct btrfs_block_group *cache)
 {
+	int flag;
 	smp_mb();
-	return cache->cached == BTRFS_CACHE_FINISHED ||
-		cache->cached == BTRFS_CACHE_ERROR;
+	spin_lock(&cache->lock);
+	flag = (cache->cached == BTRFS_CACHE_FINISHED ||
+		cache->cached == BTRFS_CACHE_ERROR);
+	spin_unlock(&cache->lock);
+	return flag;
 }
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-- 
2.17.1

