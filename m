Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A75B8B58
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiINPHM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiINPG7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:59 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB2F74DF6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:57 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id h28so11108543qka.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=3P/AekNJYsZWxa6S5TDggSXC0raPMXg5TWjb1YBQtds=;
        b=IJoN/Y3JeHArxWOT/HEnHiiReEvLEVrPIv4b48gd8B3LAiKldYsOyW+tuToZFIb6U5
         T39lfxrpaTB1EqgS4b+7cppOcnddRxkrlcuKLi/CH3Fwv2weklCdXeyulE6Io7h+aFmm
         OBbLj8Sv3pLxJRsGlHXhBguHbNtlgRA5R5lKBIZX4tABQ1a0RHmU183qi4BoTrUZagAH
         MVdzkpy9cSTMhtXY9p5RfWgvkLzAsgyLXpoYxuiL3RHOJmmQhBshrXfE1iXOQiDcDaKU
         OFrtPy99k0wLFQq4B2VVLvOM3MtD53lydzuMYKDsYmFlMfzJ1BXu2WnLQofSelM+sA9E
         zyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3P/AekNJYsZWxa6S5TDggSXC0raPMXg5TWjb1YBQtds=;
        b=mcHMKbHDe8Pj29OJa18bOfw14cLR86ilntSgQnobDcBEwptIbo3hXXBrWrTcb7grXo
         JjUOh69Scgkf+8QIDteiVbq2LiadgnKfWRtkwwsRnpU7egLve5z8/85F2Ejqz637qny2
         8mcxFbYCGFXN1EHslXe4hRkMrOKiAfxx9gEgWbJMskIlpRNpIUlZhT09S4wMHqLDTcgY
         1VhIonUCZ2NKiOB5raRTt5XWsYpxCSAuREzvoH6oSlJ5l2CRwjmLYe4/m3QGcXcO8RSS
         TINzBK1tPZoR+QLuY2BPJki9B8FnbUqZoTnUTlINQBihHJdHLpr+8x/Ui+2aFYicKNRA
         SnSA==
X-Gm-Message-State: ACgBeo16lD8s/DfjQLuLTCRI1APvQDbrDT+GeaNHdDw/FaE+MGhmTso0
        MvFQA5jsV39LIbAYtFG/+x8i4B7hM/LEnA==
X-Google-Smtp-Source: AA6agR5cDCemf4IEd33LV+IBvCnWLUr0QP+ayLlP/ksb81oJ99wIbx6t/E+c4kQ2ACkE4SPcsoLAHA==
X-Received: by 2002:a05:620a:29c9:b0:6ce:7681:19e9 with SMTP id s9-20020a05620a29c900b006ce768119e9mr5221039qkp.297.1663168016344;
        Wed, 14 Sep 2022 08:06:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bk34-20020a05620a1a2200b006baef6daa45sm2005708qkb.119.2022.09.14.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/17] btrfs: move btrfs_chunk_item_size out of ctree.h
Date:   Wed, 14 Sep 2022 11:06:33 -0400
Message-Id: <3744e0ae6f8087daa9608174aeee00c53732f8bb.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

This is more of a volumes related helper, additionally it has a BUG_ON()
which isn't defined in the related header.  Move the code to volumes.c,
change the BUG_ON() to an ASSERT(), and move the prototype to volumes.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   | 7 -------
 fs/btrfs/volumes.c | 7 +++++++
 fs/btrfs/volumes.h | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2e6a947a48de..60f8817f5b7c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -58,13 +58,6 @@ struct btrfs_ioctl_encoded_io_args;
 
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
-static inline unsigned long btrfs_chunk_item_size(int num_stripes)
-{
-	BUG_ON(num_stripes == 0);
-	return sizeof(struct btrfs_chunk) +
-		sizeof(struct btrfs_stripe) * (num_stripes - 1);
-}
-
 /*
  * Runtime (in-memory) states of filesystem
  */
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 94ba46d57920..b4de4d5ed69f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -160,6 +160,13 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	},
 };
 
+unsigned long btrfs_chunk_item_size(int num_stripes)
+{
+	ASSERT(num_stripes);
+	return sizeof(struct btrfs_chunk) +
+		sizeof(struct btrfs_stripe) * (num_stripes - 1);
+}
+
 /*
  * Convert block group flags (BTRFS_BLOCK_GROUP_*) to btrfs_raid_types, which
  * can be used as index to access btrfs_raid_array[].
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f19a1cd1bfcf..96a7b437ff20 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -730,5 +730,5 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
-
+unsigned long btrfs_chunk_item_size(int num_stripes);
 #endif
-- 
2.26.3

