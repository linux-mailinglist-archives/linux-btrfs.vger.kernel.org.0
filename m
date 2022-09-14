Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7070D5B8B57
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiINPHK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiINPG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:57 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8627677C
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:56 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z18so11374418qts.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=5TCbmG9uld2V08UpcqmfC7D6SWwgupMLOva/r65mgSY=;
        b=FmYSl14yMY/KqA0OOMVBd3V89i5mzH9S+Ti20zoVs3fI/UnqbPN3Ei5sHu4jA121eR
         zZ1x9HKVph+ghlxED77dVnhT9sTZOWIW17rlTHvS1Ys5od31DUJjNUiIw0MP6vTmLnfg
         quTEj4SLc8radLpsMIq5+mys80Uzc8Hb+hJCQabKGzbhf59OSnO/eKrQl6/j4ixt/UVD
         7lI+kIk7g3Et+QI7Jn3hEyDs3p0/wrGDZByqqiVsl9elN8U+8tJqxkqj6km2YBFaETdp
         3aJPq9mlVtEMaG61z/nmZ30Z4r0/s8tJaY9rf1+pGp1XPU3OfMw0dpFhSR0RTL1XqnVP
         +NTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5TCbmG9uld2V08UpcqmfC7D6SWwgupMLOva/r65mgSY=;
        b=Ef7RyWOa4+a5fBIOjdGf+TKF0LpsmNcnj8Q8FydDhd9GDlB5HwY6u/hu0MCpi/a5s5
         ngsXfbBvF4+qscZKMY3egfkjAlwFQ/Nrzvn5Znt5F9oxqtcdTMFycRfZK6k0kUOd3IT7
         WaVjeVHt5k/FOj/2enQfvA3nG1GKubuw6pLkP3URteSS13lWwe7RMqxqEgdbYq+9IjFx
         MKyt4rjQw7ZbjpYSIwvBxCve1d07LZcLfYPW3/SMxldEc4POfrBzkRB4kAY4m7vywA9P
         v+TfYX6oezkE55hHbSWwhRujxhWkGCf7XtKU2PKDrGoAbf1HJZlF3wmAUhgXjoOXkjUc
         aUOw==
X-Gm-Message-State: ACgBeo2sFcPBXlVCAzigk61UsVG5tqD2KrijC+weoHH4FSIN+EjT2L84
        Hr/4dA6pJYV3levsJxcOhyH5fLyTtLbDMg==
X-Google-Smtp-Source: AA6agR5QfvTwyo9ZSNJI1reE5UF7fjHPoy10asprc2hGvQhd2Ueqj/Xlh5nVpT+BIWhafas68SrckA==
X-Received: by 2002:a05:622a:4c6:b0:343:71e9:d661 with SMTP id q6-20020a05622a04c600b0034371e9d661mr33577368qtx.626.1663168014925;
        Wed, 14 Sep 2022 08:06:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a404a00b006b98315c6fbsm2122192qko.1.2022.09.14.08.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/17] btrfs: move discard stat defs to free-space-cache.h
Date:   Wed, 14 Sep 2022 11:06:32 -0400
Message-Id: <5e7f34e068513a3a82b3bc810bc92a0eb0254863.1663167823.git.josef@toxicpanda.com>
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

These definitions are used for discard statistics, move them out of
ctree.h and put them in free-space-cache.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h            | 9 ---------
 fs/btrfs/free-space-cache.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e1ec047deff6..2e6a947a48de 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -58,15 +58,6 @@ struct btrfs_ioctl_encoded_io_args;
 
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
-/*
- * Deltas are an effective way to populate global statistics.  Give macro names
- * to make it clear what we're doing.  An example is discard_extents in
- * btrfs_free_space_ctl.
- */
-#define BTRFS_STAT_NR_ENTRIES	2
-#define BTRFS_STAT_CURR		0
-#define BTRFS_STAT_PREV		1
-
 static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 {
 	BUG_ON(num_stripes == 0);
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 6d419ba53e95..eaf30f6444dd 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -43,6 +43,15 @@ static inline bool btrfs_free_space_trimming_bitmap(
 	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMING);
 }
 
+/*
+ * Deltas are an effective way to populate global statistics.  Give macro names
+ * to make it clear what we're doing.  An example is discard_extents in
+ * btrfs_free_space_ctl.
+ */
+#define BTRFS_STAT_NR_ENTRIES	2
+#define BTRFS_STAT_CURR		0
+#define BTRFS_STAT_PREV		1
+
 struct btrfs_free_space_ctl {
 	spinlock_t tree_lock;
 	struct rb_root free_space_offset;
-- 
2.26.3

