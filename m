Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22B744B022
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbhKIPPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 10:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbhKIPPD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 10:15:03 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DC9C061766
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 07:12:17 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id v2so14388861qve.11
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 07:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vo7QoWGFUCkmUYCsXlJ4zDQOuXodeHYIL/Pm3SYpodc=;
        b=UtPgvT5JXN4PtskBM92DOqW38a5USvkOZ7kEHlVEwK40HWa1iJzSuuW+UK0c9vzWrs
         Bf83GX5B4cbxvaU73qU7R7habOkB3qvRnJBUP+Ktfc/gdaL5MhumMgLknli0e6eVMsh6
         SSZI34EnzBjRVzsPfiQ7/DqSSlIliGAIrDf6+V6RbJQtbHG5n9Y4C44TcKbrKpSzptap
         ljk9tlPjNqUDznoLKPgge/jTmIpDBreotQGqKR1pkYu1JpWFBBR5i0tBq3lE26fM5vik
         +n+TdIZ4dVNSuJRJryxcmhMRCwz9xgK5pg5WkQ4/PkwIQyfRFhkl4SyUFY/j45npg411
         iqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vo7QoWGFUCkmUYCsXlJ4zDQOuXodeHYIL/Pm3SYpodc=;
        b=F0lyb9+cj2kRqcq8FdopF7mAyLvO1HUtU4EsXlDXkw3KBarZH8IfOPO0NRQ+EMzbhx
         IV7lgKiXqYE65OcSvBn5SZXqBfI3aRCYRd8kaw78lic+InSiCm07GEgY/xnU/U6kMZVM
         3ltWRpnLYDcvFvZEDRXLrjh1kAfW8zQnA3xVHCO8EJYK3iRRvDpCFMgzTAaxDL37+6cX
         R8JypETfUJXy0MbGXaVLg1aqywj91+KXTvJfJOyBwqZcuugPWI3ujtga12Gr7fmahQ31
         vSazbqxhHV5iANxPTuMFyhRzWgvD611S7zaK+XUztGEJ5dBX2fWV7Pw62/0kKd22wpGZ
         2xig==
X-Gm-Message-State: AOAM532eKaTf36LhKiO51Ez5sX5bF9rhwFBdD4bJgFvPq3MzrkmAvuf/
        WyiozIvHi+LhyKnmlcOcYo5Z+vbrkCixHQ==
X-Google-Smtp-Source: ABdhPJyt0LdG2UAmY7P/rYGk+k94kW0yKEwvGCLtg5/MxHH65As3IbWNcP+d6k/q3ehjKYTQJBglIw==
X-Received: by 2002:a05:6214:19e3:: with SMTP id q3mr8113357qvc.35.1636470736222;
        Tue, 09 Nov 2021 07:12:16 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w16sm1520365qtc.30.2021.11.09.07.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:12:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 5/7] btrfs: remove global rsv stealing logic for orphan cleanup
Date:   Tue,  9 Nov 2021 10:12:05 -0500
Message-Id: <aaf3c230a541b9f0e238c5bd84452faa08c0ab04.1636470628.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636470628.git.josef@toxicpanda.com>
References: <cover.1636470628.git.josef@toxicpanda.com>
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
index f72d70051f5b..6b65baec33d4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1601,16 +1601,9 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
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

