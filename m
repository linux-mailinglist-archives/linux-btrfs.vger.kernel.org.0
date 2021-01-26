Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439C83057DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314405AbhAZXH0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbhAZVZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:21 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB220C061756
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:40 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id a7so10632077qkb.13
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RLr32Qcbn9HQE+KCtpFqOdOZw6r6Hdyeoi+tYaRwySE=;
        b=jXn7RgEMWyCNpg6fp6RFL25dAPXP7GBt/0IIN6R9D23NqQ8W22uCHLodCLxEHmhxGh
         ts5dvY3XrHpFoPdhdROIlbn4NE4SDaSLWY37VW0Rlf6HHCt05RF6eXmG3UlpfGTPn4jS
         RMvyQ3W3nktcrD42Rs7CaNXCVv391PSHN4vrbC6dE2ySmgmqchE73JR3NOVd6pHEG3aW
         4xgRAs54c9yXYrBmPM2E+8BN4Z0U3Dq2uc1T5HpN8KxAYV33UD7/f6C9e0MGNGYz2ZWJ
         U9dYM6MSPe/Sj3nSRoTDghIRq460btrTfWz0UgVbADoKMm90ku8ihlh881yTtVkulcgO
         KhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RLr32Qcbn9HQE+KCtpFqOdOZw6r6Hdyeoi+tYaRwySE=;
        b=IYivOkUvUYLiDoQK+ws1E5bjqWLaL+kWo1+uEARK45mDkhe8Q2H7+at/IJPEKPWowb
         PRwLwJeU+oU9uYh5daYtmpB+45fxVdaGKAWwhTYVpfv8izhsv5dt8NpgpgD1B9t0Y3Z5
         5kqTa17PiOz106azFntawweyghVcgUiBpTzUsZQ2hGcPwiuv5zy5W8RHSQO3PRXAXIAc
         IHjNsAoo0c7Jn35Au333SAdMz0DorKi/d/IfToHkXYMdYT8nsN47meJ3zWgkxHEBIo8s
         Lx42EVhNTsAMj3JnsYzOkIdFdRu2JydsaokVI+gC0ZRssbha16EgsAQde7YS7OBZzKFP
         qGCg==
X-Gm-Message-State: AOAM531ETKriMXqgl//JUko/jRk7mkQThcPtnYZ58hr5lfPljWmUBGRe
        +z/Ug1PclBItBaa7NjE/n3szKg4p80qgL1ZZ
X-Google-Smtp-Source: ABdhPJzc+kC0DwCLMqTGJFRiB7UFnk2k+eX9x4Y+fiI81V2MlDKJPa1AET3u9iXgZ78mva0AqZLd3w==
X-Received: by 2002:a37:9c14:: with SMTP id f20mr7998863qke.82.1611696279835;
        Tue, 26 Jan 2021 13:24:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 2sm14023924qtt.24.2021.01.26.13.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 01/12] btrfs: make flush_space take a enum btrfs_flush_state instead of int
Date:   Tue, 26 Jan 2021 16:24:25 -0500
Message-Id: <20d9a183d520ff93e2b52d213d975a1681537c57.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I got a automated message from somebody who runs clang against our
kernels and it's because I used the wrong enum type for what I passed
into flush_space.  Change the argument to be explicitly the enum we're
expecting to make everything consistent.  Maybe eventually gcc will
catch errors like this.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index fd8e79e3c10e..975bb109e8b9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -670,7 +670,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
  */
 static void flush_space(struct btrfs_fs_info *fs_info,
 		       struct btrfs_space_info *space_info, u64 num_bytes,
-		       int state)
+		       enum btrfs_flush_state state)
 {
 	struct btrfs_root *root = fs_info->extent_root;
 	struct btrfs_trans_handle *trans;
@@ -923,7 +923,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_space_info *space_info;
 	u64 to_reclaim;
-	int flush_state;
+	enum btrfs_flush_state flush_state;
 	int commit_cycles = 0;
 	u64 last_tickets_id;
 
-- 
2.26.2

