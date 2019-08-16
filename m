Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823EC9048C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfHPPU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 11:20:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39978 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfHPPU0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 11:20:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id e8so6454185qtp.7
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=q46PD7UxMjoqblNZxRfqQ5JkvwrT9L9w1KjqSx+ge9s=;
        b=zdHetuc2myY3vnnd4J1GufMfR4gs3ZzWhBUEH+of+w0BWJo3l4KAd/LKB113BsInAw
         kixJC9c9C4X5MOVK/hVDvpyQE6VP1jKsXCJSZzQLMx3FJhToyMlCiCS29D3ASCmn+oHj
         CvjKTfQX4hEuEjVkj0XSpEzf5j9iY02vRaqHOHwjh2xsNKMSCi6k+KmWXvj6lZ9a3ip5
         +aW8jcHy/BqlGGcQ9wkaD5u8/n6hpxUvuSyW0PR8miV/BqDOVlHN+lXf4y59JcMTpuPJ
         ukBKDUAbEVyIaOuQIgW+AACqG+ADlVHAzEQ/ttEhH88DuB2OVLWyLH/9iJh+X/AuLCtE
         wzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q46PD7UxMjoqblNZxRfqQ5JkvwrT9L9w1KjqSx+ge9s=;
        b=rRisV5bkFrjwq1++eu/x/7R7HSYVdN1NuDw64IMs7/MaW3svH8MRRCKXfrxp9gyGcN
         B+5xFKai3HHOZVL/x2dttvCwdFm1IsRikAiPnIJTBhJ3PMsxVTPwbt/S9kbqINoFGEKB
         dkDEAjn8duRex+ekuXd+nsGFduD9BhUktMfiaqFkpSrdRhl663fxNkYtZZgtXOwB1kjP
         YaoDXZ+nsgXCNHjPKIKxB9b3ZqIe+D/18qLIQgDtyHzAkcm9AzNtjKR/M2+KoM+Se/dd
         baF8qH2Hzihfgl4MPmg1mm6PQLZ29tjYNULjEwta6hM/LcA/1CYrnJztZ6TmuTaL+npO
         Ujyw==
X-Gm-Message-State: APjAAAXRIpu6jUyAha8z9grKXBpS0wKA0gYOt5rIogveL+RjrAmmfB4l
        mwDLcPzmCfGY9prlnrY4GVoJQlCLDnLUKw==
X-Google-Smtp-Source: APXvYqw3o3+QFeCgIYfpzKp7sT/d9ySUZjtCOWhkxdLZlIf0J6StgVDUWZ3h+/IqWAmMuW2K0IZy4A==
X-Received: by 2002:a0c:d003:: with SMTP id u3mr2243979qvg.112.1565968825603;
        Fri, 16 Aug 2019 08:20:25 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r15sm3005604qkm.27.2019.08.16.08.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:20:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: always reserve our entire size for the global reserve
Date:   Fri, 16 Aug 2019 11:20:16 -0400
Message-Id: <20190816152019.1962-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816152019.1962-1-josef@toxicpanda.com>
References: <20190816152019.1962-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While messing with the overcommit logic I noticed that sometimes we'd
ENOSPC out when really we should have run out of space much earlier.  It
turns out it's because we'll only reserve up to the free amount left in
the space info for the global reserve, but that doesn't make sense with
overcommit because we could be well above our actual size.  This results
in the global reserve not carving out it's entire reservation, and thus
not putting enough pressure on the rest of the infrastructure to do the
right thing and ENOSPC out at a convenient time.  Fix this by always
taking our full reservation amount for the global reserve.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 657675eef443..18a0af20ee5a 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -295,15 +295,10 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	block_rsv->size = min_t(u64, num_bytes, SZ_512M);
 
 	if (block_rsv->reserved < block_rsv->size) {
-		num_bytes = btrfs_space_info_used(sinfo, true);
-		if (sinfo->total_bytes > num_bytes) {
-			num_bytes = sinfo->total_bytes - num_bytes;
-			num_bytes = min(num_bytes,
-					block_rsv->size - block_rsv->reserved);
-			block_rsv->reserved += num_bytes;
-			btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
-							      num_bytes);
-		}
+		num_bytes = block_rsv->size - block_rsv->reserved;
+		block_rsv->reserved += num_bytes;
+		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
+						      num_bytes);
 	} else if (block_rsv->reserved > block_rsv->size) {
 		num_bytes = block_rsv->reserved - block_rsv->size;
 		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
-- 
2.21.0

