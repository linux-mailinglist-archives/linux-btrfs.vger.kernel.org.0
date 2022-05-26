Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713CB5350B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 16:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbiEZOgU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 10:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiEZOgS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 10:36:18 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AFC9ED2;
        Thu, 26 May 2022 07:36:17 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2c8c0d5bdso2411510fac.4;
        Thu, 26 May 2022 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGmXtFgbTPU1yCec3GU23xwZY5DzGMqhXlSw9q55n50=;
        b=qIVfm+NNZhtHs3fnFFry3R0/a44ajLeM/X7BY276Uxg+XJCNiaO9BXJ/462cbN3+5l
         b8tWQdu+ihCEXx4798lXt6WNDFrL022EAqDFHt5bDQvoERd1dbzhNqL9bAep4orWuX6+
         xvSkkqHt3ZxbGX8PuwUJOaCpDtdauIgvYVRFHw9bL7SCzNpDlmrFvtOq2vUc1s10yB0A
         Rkbw7t+Ma1QmkU1ohAK9pFF0GyEvULjstLBnMbpOap4RpKn/b2PYOlvmOFeiCYzda+vV
         R1EbtvItG4zHrk4CaemtFQk5Ba1SmaSuT28qQ5DSUaOAcyUP/L/IArGc/sPUWuFeo4Qz
         fLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGmXtFgbTPU1yCec3GU23xwZY5DzGMqhXlSw9q55n50=;
        b=oqYwIEyklCDdKwybFt7UL4QHSe6Slh3doja9rtET5fEzCjVoRSDVNBq35oK0rM65ei
         Ial8qzDrKJadEkO4cs55j3lQr//phK6281mVfdolUWabx2El41W5qvO38TWO4zXXkfpO
         37OhoUugJ5Mjc7Xp6seycEtBwoZHlsaq9qjrzYlLPTghWuILDfCrFTmsyZXg+ec1JgQ8
         zO0uj9cMC9NN0Lpsi10PbmkMOfji7vWmrQcWsHMassY9cW9QH6WPs/meny4KEiNrM69h
         P+iJmXsJlGpLm8LkHJ5LtTdo3eEUVq3tAct1TuH/ZiGHAWHWZXflSFwyb0NdnvrYciGX
         ++sw==
X-Gm-Message-State: AOAM530fXe7hgXHtu5RWQsmI/HL16BU1RpFQlopHDj1mjvHO58ptcW83
        BHOya2otQIZ6wrhk1LageFivQ//Pm5gX7UdFVnM=
X-Google-Smtp-Source: ABdhPJybuePShTJ6M0jxXdUEgg8rT4OeBlwenJy8NsdLACTZWZuUE3kvBHAlNS/9oEFFvfU8r8Ppzg==
X-Received: by 2002:a05:6870:ea8b:b0:f1:f46f:515e with SMTP id s11-20020a056870ea8b00b000f1f46f515emr1435650oap.192.1653575776753;
        Thu, 26 May 2022 07:36:16 -0700 (PDT)
Received: from localhost ([199.180.249.178])
        by smtp.gmail.com with ESMTPSA id s31-20020a056830439f00b0060613c844adsm684623otv.10.2022.05.26.07.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:36:16 -0700 (PDT)
From:   bh1scw@gmail.com
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Fanjun Kong <bh1scw@gmail.com>
Subject: [PATCH] btrfs: use PAGE_ALIGNED instead of IS_ALIGNED
Date:   Thu, 26 May 2022 22:35:40 +0800
Message-Id: <20220526143539.1594769-1-bh1scw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Fanjun Kong <bh1scw@gmail.com>

The <linux/mm.h> already provides the PAGE_ALIGNED macro. Let's
use this macro instead of IS_ALIGNED and passing PAGE_SIZE directly.

Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
---
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/inode.c     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8f6b544ae616..1f9f31004d60 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6201,7 +6201,7 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 		return -EINVAL;
 	}
 	if (fs_info->nodesize >= PAGE_SIZE &&
-	    !IS_ALIGNED(start, PAGE_SIZE)) {
+	    !PAGE_ALIGNED(start)) {
 		btrfs_err(fs_info,
 		"tree block is not page aligned, start %llu nodesize %u",
 			  start, fs_info->nodesize);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 81737eff92f3..0f6f62fa03c8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -560,8 +560,8 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 	 * will unlock the full page.
 	 */
 	if (fs_info->sectorsize < PAGE_SIZE) {
-		if (!IS_ALIGNED(start, PAGE_SIZE) ||
-		    !IS_ALIGNED(end + 1, PAGE_SIZE))
+		if (!PAGE_ALIGNED(start) ||
+		    !PAGE_ALIGNED(end + 1))
 			return 0;
 	}
 
@@ -678,8 +678,8 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	 * Thus we must also check against @actual_end, not just @end.
 	 */
 	if (blocksize < PAGE_SIZE) {
-		if (!IS_ALIGNED(start, PAGE_SIZE) ||
-		    !IS_ALIGNED(round_up(actual_end, blocksize), PAGE_SIZE))
+		if (!PAGE_ALIGNED(start) ||
+		    !PAGE_ALIGNED(round_up(actual_end, blocksize)))
 			goto cleanup_and_bail_uncompressed;
 	}
 
-- 
2.36.0

