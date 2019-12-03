Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970E410F490
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 02:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfLCBeo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 20:34:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37767 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLCBeo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 20:34:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so785382pga.4
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 17:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XwHbg1a+4pUxALqWYYd9+ycQ/lVXsQpFJwto07+kXV4=;
        b=XX/CEznvgUjK9MDMZ+kIkJ0dRRS2F3dShYMUbFUiJF2xhGKrt5WXoKo7dzQ0fEYw8L
         2xg66uWlzUDjR/kFNQLMmDBzEMPLM905mEYOl8VhR4Z9O1flhf2uhVb2HYSdruna2r00
         VUNY2sUh4d4AyPXqfsMOaLwb9pzxgNiEZFK6an0kyCwy0Al1QCz/qfeUtcvVEjQRcuCF
         v9QQ0c2l0xThvUKOfZr2NhPcXSQgr+956rnDmMWQlt1J8XkVH4gvefpyWL/OIytPAJKR
         ZQXGcmRGOXmjlid+Z7/Q6nTJsNRF1qdo8wNPHKRdZlqb0c6NqvKRLw7aDHEpXj9qRZ0u
         9gtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XwHbg1a+4pUxALqWYYd9+ycQ/lVXsQpFJwto07+kXV4=;
        b=HUxxezWhXF5RnY/8Sfkfyc5QDBb213ORBU21rxDZRQlmFnNCRR/ITQQS8hxr5/HZ7Z
         46fkqtmgRKDYkPKmrjvR1B0Qs0qmyU9dDFC3/6+1R48ILGJbnAykNKn+148EFnGJBfpO
         Z/FsB7Xum6y8UF3avFjBN8uMhTMe7diNWFjCdyG8sbrL9Pon5v14+oQHT9xoM8hV1pVx
         eECB8iLVtPqLMDjcN6EwPDL/yWXQNzGU3u4ElZNdB7YND+Xk7Nw5ei0kE6nXt0B1toTE
         P3digZ6yHaAi46g8vn7/pKoHrvUwrdzQOiTggvqj6gjd4V0LWFIxgMgw6iCDRd9AKANa
         a+VA==
X-Gm-Message-State: APjAAAXCrpaD/1zUgSmueAc1YCmormVlFXhk7a3Q+Cn1AhublDjyjkMZ
        GPGdy5Id2cEja0ORz976VA0wPzUfUFgbRw==
X-Google-Smtp-Source: APXvYqy0gOXpW3L6h4MKoicDAY1QGrUqfg5PHGqdNXW8AK4aMv9ioBu8CNVPc2Rh21F7OQngdMci2g==
X-Received: by 2002:a62:5485:: with SMTP id i127mr2064374pfb.186.1575336883057;
        Mon, 02 Dec 2019 17:34:43 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::6ddc])
        by smtp.gmail.com with ESMTPSA id u65sm800242pfb.35.2019.12.02.17.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:34:42 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 9/9] btrfs: remove struct find_free_extent.ram_bytes
Date:   Mon,  2 Dec 2019 17:34:25 -0800
Message-Id: <e86fb919694d8c57612c5690be77b27313325232.1575336816.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575336815.git.osandov@fb.com>
References: <cover.1575336815.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This hasn't been used since it was first introduced in commit
b4bd745d1230 ("btrfs: Introduce find_free_extent_ctl structure for later
rework").

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent-tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 18df434bfe52..40c000269232 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3437,7 +3437,6 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
  */
 struct find_free_extent_ctl {
 	/* Basic allocation info */
-	u64 ram_bytes;
 	u64 num_bytes;
 	u64 empty_size;
 	u64 flags;
@@ -3809,7 +3808,6 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 
 	WARN_ON(num_bytes < fs_info->sectorsize);
 
-	ffe_ctl.ram_bytes = ram_bytes;
 	ffe_ctl.num_bytes = num_bytes;
 	ffe_ctl.empty_size = empty_size;
 	ffe_ctl.flags = flags;
-- 
2.24.0

