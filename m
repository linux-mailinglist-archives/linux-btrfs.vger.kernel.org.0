Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764FC836BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbfHFQ2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:28:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33064 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387876AbfHFQ2w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:28:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id r6so80902708qtt.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=D7NQSyw8B44ESDBw7P9NDrNkQHokzgnH1WZP5GVdujI=;
        b=xt3HR8h3+uos9LR0BQIJYjQ+O5w/Q8ANmDCDlBSEBjnjJRLa8jvxSH5eY807zksLp5
         scnXc6q3il8cMxMzqlHwuY/3Wa3hnlyVyo12AYICEUsbrhB2OEACpYoO8o41Drm8CFX7
         va9Kf4wHF3oxXRUAI47XRiEEzEWVmFWGlDq3g/USRYZYrp92mL6Fd193bIUAqfmYZ0Jj
         2dwEMt+fK5qfQ1TwkAaU70FVrCtL2skV1FeSJ/py6YGZKhGWzgnKMzpJYBeBvaMpbDB+
         MnJNDs4qqf1C5coIOAFQD7JJCN1hKxYwrmXd8i6qH3jljXfqrjNNbJlgrtEry589qXao
         dEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D7NQSyw8B44ESDBw7P9NDrNkQHokzgnH1WZP5GVdujI=;
        b=pl3AqUSGWIx/EbyKoQcPxQDT+IFsGrLIloQdx0vnC1mniAIroMyLsCfKVA2sfzb/sw
         vAGOsr6JUkIXYEXilTj3E0OH7yMuFzwsnNl7MW7z7GuhDBAsEoYF7JQRGclvLFSDH/Eq
         WzkXrMIz/ZWXUlPcIKabkk9eVaPMvMzgEBr+oYwgcybwCFIjOfNvSj3zJ5k7LRPUT9zf
         u/NmRXCXFJVkCIP/Vs19MttpH551OuBI1P3XCKSlwK8qqjxlD+SDoQ+bZYu1CcmZEg/+
         KgZHuUuS16pBFFx7wAD+BKI6ls4PsDhlH6W43HGUUzoKf9wgUxkph/7JliYrj2rLSppB
         Glog==
X-Gm-Message-State: APjAAAWTK6u1hx4+oMPxbnDkL2eAfBsBg1l7ZOTDSEaJQubH9O1QS5s0
        XxsRrZCt+mTzsiuzkmzoubjJ27fdT+X2AA==
X-Google-Smtp-Source: APXvYqwXf0FcDqxX5VMoLrOUEnSltHskTCcu9IM0LTU4r1QFwc7F44fSxzlN6kpQhjO2cXMd0f9K5A==
X-Received: by 2002:ac8:4808:: with SMTP id g8mr3836055qtq.3.1565108931129;
        Tue, 06 Aug 2019 09:28:51 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z21sm34682117qto.48.2019.08.06.09.28.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:28:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 06/15] btrfs: temporarily export btrfs_get_restripe_target
Date:   Tue,  6 Aug 2019 12:28:28 -0400
Message-Id: <20190806162837.15840-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This gets used by a few different logical chunks of the block group
code, export it while we move things around.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h | 2 ++
 fs/btrfs/extent-tree.c | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 2745b99e5ae2..30bb722fce02 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -199,4 +199,6 @@ static inline int btrfs_block_group_cache_done(
 
 int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
 			       int force);
+u64 btrfs_get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags);
+
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 37556ce36d68..412c93abe6a4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3069,7 +3069,7 @@ int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  *
  * should be called with balance_lock held
  */
-static u64 get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
+u64 btrfs_get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
 {
 	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
 	u64 target = 0;
@@ -3110,7 +3110,7 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	 * try to reduce to the target profile
 	 */
 	spin_lock(&fs_info->balance_lock);
-	target = get_restripe_target(fs_info, flags);
+	target = btrfs_get_restripe_target(fs_info, flags);
 	if (target) {
 		/* pick target profile only if it's already available */
 		if ((flags & target) & BTRFS_EXTENDED_PROFILE_MASK) {
@@ -6672,7 +6672,7 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 	 * if restripe for this chunk_type is on pick target profile and
 	 * return, otherwise do the usual balance
 	 */
-	stripped = get_restripe_target(fs_info, flags);
+	stripped = btrfs_get_restripe_target(fs_info, flags);
 	if (stripped)
 		return extended_to_chunk(stripped);
 
-- 
2.21.0

