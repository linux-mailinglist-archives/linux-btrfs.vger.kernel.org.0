Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121A87B0B4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjI0RrP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0RrO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:47:14 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8EAA1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:47:11 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77432add7caso439875585a.2
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695836830; x=1696441630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxznYvzA02PDJe2TFNGF+HSeHbWxqcrgvzF+MJ0KmRk=;
        b=mS0a8MCchNj3T8TPYRy4BYhaHsvyzGZVaR80upwrYuDrg+q4y3juTs1XoKu56IafMs
         ao3QhIEwm8Kjn8de/kKQpOJwN02sQ/7P9wMg8ii2irblzk1CB3QdUwP0t86LVonDVL9O
         rvNNABVltP6rLzZy/c+36tcr9NpD8yHh7DZVyKeURn8eivF4qqEFwXZ+WECLfTG1aruw
         RjqnKp7AIvTReepljMdshjUKOZKk6LBTzYhiajTTYeINUxWLmF6gLmUiphwnh0RF21nV
         1ewI3QUWZ11FITt1zQHCWjM1soGsV/MmOM52DnfnFS4/P0ASVGUOxO57Bc5rNkA8F90o
         x/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695836830; x=1696441630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxznYvzA02PDJe2TFNGF+HSeHbWxqcrgvzF+MJ0KmRk=;
        b=r2xsQ8KAZsn5+34teLn8fltbxph9qtnBTlOWBdxETLzDIs7x5slrtWFxmuIVMPAjeY
         /vpLUYt1Nk4WlJ3kTRRt6lf0NYzsyhg8PCjzY29/NheiOteWhuFpntdfeCjUIuwr6GSs
         5mUGfXkkeLdTM1h7AB7b0Ie20/86UEyhB09yJyvrCqyC3eNbzZmpgbeqDCjmMNdL5PiY
         TM+5quzEzXME2G/4KI52PheVKb2Yuy0EJBFyzewkVfWXHElxqDq0omYoRvq7EO+lCW6y
         r7xkSFF7RM2Z2LAcf+mVTTJ/ebs4TH5O8jFyN0OCCMiOx37QaW7Iv7Q3y81a63hqvQJA
         0fKg==
X-Gm-Message-State: AOJu0Yzlda7+tlCFeqd8ep5H9pS8kNkS2+u8/ec/QKO0okb1aEFSCteu
        P+SgB/vBgapOMbyL9OYlBGHD87L9pZfeFvkYUEK4lg==
X-Google-Smtp-Source: AGHT+IE8kJ3E1I6liSMwfBsZFq5HHqYjHeFmlh17n8LgocnT12oRQBUXQ1dZuEOw2fHQ+df/gjCvRQ==
X-Received: by 2002:a0c:f30a:0:b0:65b:259f:d6a9 with SMTP id j10-20020a0cf30a000000b0065b259fd6a9mr2924787qvl.7.1695836830574;
        Wed, 27 Sep 2023 10:47:10 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m17-20020a0cdb91000000b0065d04135014sm358443qvk.13.2023.09.27.10.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:47:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/3] btrfs: fix ->free_chunk_space math in btrfs_shrink_device
Date:   Wed, 27 Sep 2023 13:46:59 -0400
Message-ID: <1c153ebd18861caaac06d1b30b41483f33b360b7.1695836511.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695836511.git.josef@toxicpanda.com>
References: <cover.1695836511.git.josef@toxicpanda.com>
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

There's two bugs in how we adjust ->free_chunk_space in
btrfs_shrink_device.  First we're removing the entire diff between
new_size and old_size from ->free_chunk_space.  This only works if we're
reducing the free area, which we could potentially not be.  So adjust
the math to only subtract the diff in the free space from
->free_chunk_space.

Additionally in the error case we're unconditionally adding the diff
back into ->free_chunk_space, which we need to only do if this device is
writeable.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 733842136163..907ea775f4e4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4841,6 +4841,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	u64 old_size = btrfs_device_get_total_bytes(device);
 	u64 diff;
 	u64 start;
+	u64 free_diff = 0;
 
 	new_size = round_down(new_size, fs_info->sectorsize);
 	start = new_size;
@@ -4866,7 +4867,19 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	btrfs_device_set_total_bytes(device, new_size);
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 		device->fs_devices->total_rw_bytes -= diff;
-		atomic64_sub(diff, &fs_info->free_chunk_space);
+
+		/*
+		 * The new free_chunk_space is new_size - used, so we have to
+		 * subtract the delta of the old free_chunk_space which included
+		 * old_size - used.  If used > new_size then just subtract this
+		 * entire device's free space.
+		 */
+		if (device->bytes_used < new_size)
+			free_diff = (old_size - device->bytes_used) -
+				(new_size - device->bytes_used);
+		else
+			free_diff = old_size - device->bytes_used;
+		atomic64_sub(free_diff, &fs_info->free_chunk_space);
 	}
 
 	/*
@@ -5001,9 +5014,10 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	if (ret) {
 		mutex_lock(&fs_info->chunk_mutex);
 		btrfs_device_set_total_bytes(device, old_size);
-		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
+		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 			device->fs_devices->total_rw_bytes += diff;
-		atomic64_add(diff, &fs_info->free_chunk_space);
+			atomic64_add(free_diff, &fs_info->free_chunk_space);
+		}
 		mutex_unlock(&fs_info->chunk_mutex);
 	}
 	return ret;
-- 
2.41.0

