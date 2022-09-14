Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3094C5B90DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiINXIJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiINXIF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:08:05 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F6895C3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:08:03 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f13so7823292qkk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=4uW150atEhF6nK23NrUBZERw9/ufdlInpqL5JXvQcbw=;
        b=PcmhX/f4qC3z7ywAsxyG4zM+Bne0ontBhzuF/G7vWSUuKZlcdJCXT0EMAqVAubQ0ar
         wpPqtk+8Mf1Wme8oPzNJFnZgxc6EHrsLFS7bwJE5krf7qOFjTb62ODfjuZO8dic1sSNo
         5Q3GC10wcX2vvaElE9V2w2V3xZaxdeyxI9xu8vKFWYqlrY9lbBYJdmMo0l7E9grNN9zx
         /XawWnwxbYG46Np9lBl1u7ta9p6ryvMyii/lReqEnULLn4xn+C/Z/W9QyLlJ6cmNNjuV
         k2rU0hyQxvfuTNofTJbgiAuNiz9oHbiBdg0HwM7cvZN3zyKcvcZXUPvGW2sB2+ylJc8z
         AXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4uW150atEhF6nK23NrUBZERw9/ufdlInpqL5JXvQcbw=;
        b=ZzN7CJwvhXoEyR0chG82/Q42IBhWLdV3J5SZhj9SaruyO3NMSvuoyPLVkf9piVRAG6
         OJLfI7ZJtWwkqD6Md2rB6PlAnp4cmXdBYnOEEVDHdZlXfQM1Ym0uFtx4M0vLzMo+tlzf
         xvPg5O1CXZ8ALW/pRvNAmmgPvD/dwF6zlyzZUH5Wgiq6ay68pdIMthegM/0NlWNXmInY
         Lk9wKUR6sM4bbGSCqUrrS7tSMawptUgTJiVUNF705ZVdrpKMuL9HBNrNLX10SrjtRO76
         w1YilCPb6/OVHjxn5zTe1YWzDdF9tXT7zMBaGzbpRmliBF6OOgQSN/JnklJiCMQhODoW
         ll9A==
X-Gm-Message-State: ACgBeo0WWbLR7MOe74Kh50l2pa7O0hNVbmgqmQkPUD2uViFwn2uaFe1L
        FN+LDO0wDjzcxXvSGsBLEs2XXiKMlO8KSw==
X-Google-Smtp-Source: AA6agR61ltNcy26TVYlHSLL/2i+S++9ZlUg9LbeV7PiCdfw/pwUplyL5yKZt8cp8gJZKovdkE+HZzA==
X-Received: by 2002:ae9:ed44:0:b0:6ce:19bb:7780 with SMTP id c65-20020ae9ed44000000b006ce19bb7780mr14382176qkg.25.1663196882531;
        Wed, 14 Sep 2022 16:08:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s14-20020ac85ece000000b00339b8a5639csm2366578qtx.95.2022.09.14.16.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:08:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/10] btrfs: move btrfs_zoned_bg_is_full into block-group.c
Date:   Wed, 14 Sep 2022 19:07:48 -0400
Message-Id: <04ad998f1c1c383fd68577abf613ffd8e4622cec.1663196746.git.josef@toxicpanda.com>
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

This function is completely related to block groups, as well as using
ASSERT() which isn't defined in either zoned.h or block-group.h.  Move
the code to block-group.c to make sure the headers are only using code
they define themselves.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 6 ++++++
 fs/btrfs/block-group.h | 1 +
 fs/btrfs/zoned.h       | 7 -------
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e21382a13fe4..3a5f29494d98 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4178,3 +4178,9 @@ void btrfs_dec_block_group_swap_extents(struct btrfs_block_group *bg, int amount
 	bg->swap_extents -= amount;
 	spin_unlock(&bg->lock);
 }
+
+bool btrfs_zoned_bg_is_full(const struct btrfs_block_group *bg)
+{
+	ASSERT(btrfs_is_zoned(bg->fs_info));
+	return (bg->alloc_offset == bg->zone_capacity);
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 6c970a486b68..4edf5486a592 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -322,6 +322,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info);
 int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		       struct block_device *bdev, u64 physical, u64 **logical,
 		       int *naddrs, int *stripe_len);
+bool btrfs_zoned_bg_is_full(const struct btrfs_block_group *bg);
 
 static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index de1337e462be..a94de42f9edb 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -312,11 +312,4 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device, u64 p
 {
 	btrfs_dev_set_empty_zone_bit(device, pos, false);
 }
-
-static inline bool btrfs_zoned_bg_is_full(const struct btrfs_block_group *bg)
-{
-	ASSERT(btrfs_is_zoned(bg->fs_info));
-	return (bg->alloc_offset == bg->zone_capacity);
-}
-
 #endif
-- 
2.26.3

