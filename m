Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5B5449811
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbhKHPYV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 10:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhKHPYV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 10:24:21 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BFEC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 07:21:36 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h14so13959213qtb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 07:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNmVz6R7OvbyzR9AWXaX/hM1ZWQMRcA1AV6DlldkOU4=;
        b=ZYmPS8JffiW82Ote+pJ6icw8ZNCO/pMspUc+TWJfdoQLYsqNRYoC2ARyzR9TPWOZ+0
         tWMxuzvDZB1Q+jiuwx3WqZjnwuzl/ytX54dOeImO7PULXsxq5mCzoGOs/PIVDw8u98M9
         DewZF3J+7jfCB3L3l9FaZw1Rx/bRQxNHI1R99C3N39tHAQYJtorc+wvxZYb6s6yrXcu/
         GwuxBk5jRFMGF5sCVoGgWAidTKexQpaHlXc2ES5JP2JuF7KovXPrqCvfYccDDNbnaSEa
         u1jcfe2engtEMnYgtLde8hjXvlhjiTIHBXLId532epBuRBFHXPsjJAPhlDk4JttUI4JM
         JnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNmVz6R7OvbyzR9AWXaX/hM1ZWQMRcA1AV6DlldkOU4=;
        b=J82Pnx8Uropm0vxQaSneeepwSw1XzlV3YfUVwEZYKK3mxGuEW6cGueIbvpgWypUNRS
         995m/D2gnFcX4dCWZiIW+xvFSDAIlodzTtrjo86hvZEq8t5eE64BNb9v/atFQmMVl1qx
         Pv3bnERseuxdVJL+3IZmdm2y2uWztx9xYVErnNpXKSvQOAFSdl6r5wDfgd71WjA2/eNe
         PpL9VZ2v0BHBWZ5RmfutWYBsCT5r/rdNKzOEGJd/zbqGR8/mgeYXJCElHMp59TmVTQwf
         nxbDAQ15gNPqqrrru3KRWvPHQwFZrJP5PVwZG0yrjbdSn+ous5Z++jxRG/KzL1On2F1w
         n2qA==
X-Gm-Message-State: AOAM530AeNT397rf4xWawEniu3hqEm76zUCa+rgI5dtnL3kVecaLtmnP
        VsB4NQY98A7l2WX9ySzTmIy5AtCR3CmL3Q==
X-Google-Smtp-Source: ABdhPJyypjHL2ebRzbdiS+GeWSx+yMDKKrREdlXQBaoIPggEAzQ8e400AiNiR9zu4ho69XrKbsnftg==
X-Received: by 2002:a05:622a:90:: with SMTP id o16mr309734qtw.84.1636384895595;
        Mon, 08 Nov 2021 07:21:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f34sm3011578qtb.7.2021.11.08.07.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:21:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/4] btrfs: remove global rsv stealing logic for orphan cleanup
Date:   Mon,  8 Nov 2021 10:21:28 -0500
Message-Id: <cf98170aba8a88b8f5a1e698b57c30f855c3b88f.1636384774.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636384774.git.josef@toxicpanda.com>
References: <cover.1636384774.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is very old code before we were stealing from the global reserve
during evict.  We have proper ways to steal from the global reserve
while we're evicting, so rip out this code as it's no longer necessary.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 00bbcf9bec40..7ca18b18b132 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1604,16 +1604,9 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 				 enum btrfs_reserve_flush_enum flush)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	int ret;
 
 	ret = __reserve_bytes(fs_info, block_rsv->space_info, orig_bytes, flush);
-	if (ret == -ENOSPC &&
-	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
-		if (block_rsv != global_rsv &&
-		    !btrfs_block_rsv_use_bytes(global_rsv, orig_bytes))
-			ret = 0;
-	}
 	if (ret == -ENOSPC) {
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      block_rsv->space_info->flags,
-- 
2.26.3

