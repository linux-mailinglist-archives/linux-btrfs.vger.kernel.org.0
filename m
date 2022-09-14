Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19D55B90D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiINXIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiINXH7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:07:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C77087081
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:55 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s18so9392008qtx.6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=MFDwn1dwx6PkSD57bKJCt2SMDtuYBMpaUpYFyW+I6Us=;
        b=X/slaij+DoAvmJjYsEa9vlDL/IQgKGKv73aoeduqBTxQ//DNWq1JkJ9nkPWahDMgbY
         GCRzfVaYm7EJWxSo5VoPaxVrK2QqRrRfWH6smmYrKmxgJaE+ujj3x97mUiChnHbSQtg1
         71RZVmi+GSC7iPq6fFxT5fDfrvOeFsYNg9ve4l8WvTz33RNZ2M6pIIVGjFue+IhzRx4D
         15bHZSfCFmIg6NPOIfxrbhDq9MErHFLb5KRYJuGr7fDtMFgKjdOUIGqpvqYSQXLkCY3f
         UYXtvsh/DbgRIq0aw1VtwWpc/ZeePG5+DA2lLgWnGHt3sQ3K5ROi9jePjsjdFP+ykgXt
         iiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MFDwn1dwx6PkSD57bKJCt2SMDtuYBMpaUpYFyW+I6Us=;
        b=4enrnCCDEEjxssmLdC+D7+zxlNUfaBGYZ0E8mZLLk1d89uS3cvJRlWXxHHcO4mvAFk
         9HfwBq+91jnGxjJWgxPE0cSCeFv5g7RHLisHERx0iEM6ZWQ3TzAmFhWT0XotS/jr2EpE
         FuZkHIGFlcL5JfY4jxbDWGx5PH6niGQLeiSK2CjQC9mw4vjhUoHpei3vEQznVgX1XxKe
         +RaYEt3V3BbpwGRIPIZPlqMAR/kfU4HNJSzAhKvKMrSvjmAhSzaDE99CJgkaJTpLUngm
         vp65zqGQTmJgZRbGN1G/7uxk7dr+czOOVo59B1C6mkVtjE3AzMeQU184R4P9cowjNocH
         0/Dg==
X-Gm-Message-State: ACgBeo1PWp8TdxVSzct3pmzoX8TTAKx7QEwxQrBcNmLwJB7OrKH3VhqF
        NcmOl7pN9WUQ2+ajzeP3mY3yNziXrWoNiw==
X-Google-Smtp-Source: AA6agR50mzpZWgfxc9Zcx8M45Ux1Eg7bylsFevWiBhJe7tUPcyxGwGYoY2NF8GWpvvUepgM4La42nA==
X-Received: by 2002:a05:622a:290:b0:35b:bc26:d98c with SMTP id z16-20020a05622a029000b0035bbc26d98cmr10492687qtw.489.1663196874323;
        Wed, 14 Sep 2022 16:07:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id az6-20020a05620a170600b006b919c6749esm2824976qkb.91.2022.09.14.16.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:07:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/10] btrfs: move btrfs_check_device_zone_type into volumes.c
Date:   Wed, 14 Sep 2022 19:07:42 -0400
Message-Id: <a156cf2430eeaf93a748882f49ca9dd1cf7d51d4.1663196746.git.josef@toxicpanda.com>
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

Now that this is only used in volumes.c move it out of zoned.h locally
to volumes.c.  This is in order to avoid having a helper that uses
functions not defined in zoned.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 19 +++++++++++++++++++
 fs/btrfs/zoned.h   | 19 -------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ea76458d7c70..29652323ef9b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2583,6 +2583,25 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+static inline bool btrfs_check_device_zone_type(const struct btrfs_fs_info *fs_info,
+						struct block_device *bdev)
+{
+	if (btrfs_is_zoned(fs_info)) {
+		/*
+		 * We can allow a regular device on a zoned filesystem, because
+		 * we will emulate the zoned capabilities.
+		 */
+		if (!bdev_is_zoned(bdev))
+			return true;
+
+		return fs_info->zone_size ==
+			(bdev_zone_sectors(bdev) << SECTOR_SHIFT);
+	}
+
+	/* Do not allow Host Manged zoned device */
+	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
+}
+
 struct block_device *btrfs_open_device_for_adding(struct btrfs_fs_info *fs_info,
 						  const char *device_path)
 {
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 094f3e44c53c..20d7f35406d4 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -311,25 +311,6 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device, u64 p
 	btrfs_dev_set_empty_zone_bit(device, pos, false);
 }
 
-static inline bool btrfs_check_device_zone_type(const struct btrfs_fs_info *fs_info,
-						struct block_device *bdev)
-{
-	if (btrfs_is_zoned(fs_info)) {
-		/*
-		 * We can allow a regular device on a zoned filesystem, because
-		 * we will emulate the zoned capabilities.
-		 */
-		if (!bdev_is_zoned(bdev))
-			return true;
-
-		return fs_info->zone_size ==
-			(bdev_zone_sectors(bdev) << SECTOR_SHIFT);
-	}
-
-	/* Do not allow Host Manged zoned device */
-	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
-}
-
 static inline bool btrfs_check_super_location(struct btrfs_device *device, u64 pos)
 {
 	/*
-- 
2.26.3

