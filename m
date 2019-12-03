Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 281F310F48F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 02:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfLCBeo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 20:34:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33292 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfLCBen (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 20:34:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id y206so902556pfb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 17:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dhMNxMRL59v0xeoDIjm8Lrm4C202koHkHPnIlytprVg=;
        b=Fuj0JG3u+i5I2huz/iy5pJSsWSzzyglTi4BLiPel06JKLDWkLtXVXSoTKTs4/HT7LD
         yWrt1Zb5UyYlaQSzOzNWofMKTeD8AgpH1ozfOedGMhwsYwUqhzLJwrqbw/hPiF7xc0f5
         GHyf6JXG1/TPCfR35iw04XPyRb3pkGg/Xk2hm+Ejnb7z7Mg/fxlzyha9+tvBtra0PaQe
         /0DsQC2JFYUIb7TSPE51VVWNsNyCQIreWpbltiKRvG+5c7wetNtTTb96uJ6DT7j1c+o7
         7jr5SRFvyKeVFlrBoPXxzDHJUgdu5Ol1ZWaVrt/cyzinA+Tpr6CJ6FO5KzQOU/uomuYj
         cipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhMNxMRL59v0xeoDIjm8Lrm4C202koHkHPnIlytprVg=;
        b=Yxrk0qLoxQ4uiG9xMd45dVRHCabG8OuP2D8nw4eF0rzyKDdB7mpqy0hrmHcqfIeR+8
         L3ht85DgMCF7+pa7De2RJtn9+BXaK13MTnKu0ehM4gGTobnseMGcmiGVeMjHB2ajfFxJ
         4A2c0Rp64g5ACmnVElsTsBUEs3M3Dvr4s/soCfag2resJM4sdM9NpKbcUxH+6WAme5fY
         1QAsI6GZSvNVsDoDrjwYLO/d8LxBiUJx4IcpMmHVAUWMFyJosSu9RBj+q6ODFI8nc2VV
         j49DvfgZ1O8bfNWQWVUYGweUx2xWOBxxMGqkZwENGX7N0he+WSdwpl0Fmy0EMYz2abnR
         kogQ==
X-Gm-Message-State: APjAAAWu63Sx983Ww9asaLX0He0Jl4S8737oyxrHuLSJNKng04+OK11w
        LQyyRTGu2L/qqgyMp6OY0run28fzCWYuSw==
X-Google-Smtp-Source: APXvYqwH/7sNmBYBHZB46o3H703wETQmRH62xddMpTEy03SR+nz2CiYX0IdTccm4FxdlJUt58IjZdQ==
X-Received: by 2002:aa7:828c:: with SMTP id s12mr2009465pfm.166.1575336882090;
        Mon, 02 Dec 2019 17:34:42 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::6ddc])
        by smtp.gmail.com with ESMTPSA id u65sm800242pfb.35.2019.12.02.17.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:34:41 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 8/9] btrfs: simplify compressed/inline check in __extent_writepage_io()
Date:   Mon,  2 Dec 2019 17:34:24 -0800
Message-Id: <8c99ef2ac5f56d6d08716fe8ddfd3a24084f3861.1575336816.git.osandov@fb.com>
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

Commit 7087a9d8db88 ("btrfs: Remove
extent_io_ops::writepage_end_io_hook") left this logic in a confusing
state. Simplify it.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 13c03c42ba5c..385edd31acf0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3492,22 +3492,13 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 		 */
 		if (compressed || block_start == EXTENT_MAP_HOLE ||
 		    block_start == EXTENT_MAP_INLINE) {
-			/*
-			 * end_io notification does not happen here for
-			 * compressed extents
-			 */
-			if (!compressed)
-				btrfs_writepage_endio_finish_ordered(page, cur,
-							    cur + iosize - 1,
-							    1);
-			else if (compressed) {
-				/* we don't want to end_page_writeback on
-				 * a compressed extent.  this happens
-				 * elsewhere
-				 */
+			if (compressed) {
 				nr++;
+			} else {
+				btrfs_writepage_endio_finish_ordered(page, cur,
+							     cur + iosize - 1,
+							     1);
 			}
-
 			cur += iosize;
 			pg_offset += iosize;
 			continue;
-- 
2.24.0

