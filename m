Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C50170987
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 21:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbfGVTPR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 15:15:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38063 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbfGVTPO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 15:15:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so19567097plb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2019 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a4Txfmc382Oe0BuFQ2Rm+49WdvUvKYubBgVi0iwP8kU=;
        b=YlqMhaOEgi8OJi2BDY29VARqpEJ8RPPlE0X0a8D/pVTeHHdn8zVNJihOv5DeqJZO3R
         +pSDBa/+d5ULMehyYJLoVBG6qtlih2mwgHcduDxq/nlCvgNb7JBDPUIFLPhmzyQQWSMX
         iWNDq4gfOkkaPMjTESu+Z6Mz3xlnFVwdjb0rLLHtNQGI7e/mwCTBPtBnW6PqYDBiluRx
         HLIfge2UkHkkyEM6LrfQtmJ+cTjSGmW2o+LfbZBfC1Xolo3QYIXjyRIxTSqkzG2NP0eJ
         aSDTwf2TmR9mZXRaXgV11xVMEd0H0LKEoe1XHkK2+AWvtIgCISQw6m6B7EnA1d4aPZzE
         a7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4Txfmc382Oe0BuFQ2Rm+49WdvUvKYubBgVi0iwP8kU=;
        b=lt/Pa2mIA0EepgroYWPLK82/CPaz4YDeBLtXQL1MZFeB/GwNNrZbdCovipTi++PAiQ
         mYB5LLm/xT69nodMlAUbVjzVgUNq+HS4Y7samRAUy/S53qnWYGB+6aInTwhWnPuxdunl
         v7KXHf/u0mDjrCVEZtaOzUg754luoacdzBI+K4Zgr0Agia6ewhbbMko28JyHSLMteoOg
         ONDOCj35BfIJ9EsZ60hNz2scZUif7Hv2HRbNSw68XCiBzu6OfLKj+HqIMONeyMdbevDn
         FzyyKWQ/HXEGqsP2PytVsDpIeW1WgLF45N03cYIORZqH/MaflUplIEX7G5lVf0NBGKet
         sgFA==
X-Gm-Message-State: APjAAAUYzFqgt61C98ql4Lzae4OC8Ctk+7nTbja603G4uOHaR8Z9tCY1
        VtRgn7dk+OGKU/6cme3SxF5WYdA0ss0=
X-Google-Smtp-Source: APXvYqx4Vf7s/mg+eUN+I/ACpcgFbqB4m+V1sTlm7fW4MzBnGGusOqXEG0J3y94OMHB4myqAawqSzw==
X-Received: by 2002:a17:902:2aea:: with SMTP id j97mr64700480plb.153.1563822913523;
        Mon, 22 Jul 2019 12:15:13 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::2:a31b])
        by smtp.gmail.com with ESMTPSA id t11sm47262048pgb.33.2019.07.22.12.15.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:15:12 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 2/4] btrfs-progs: receive: get rid of unnecessary strdup()
Date:   Mon, 22 Jul 2019 12:15:03 -0700
Message-Id: <601d1314703351acf3b5569beea4670bc8754f9c.1563822638.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563822638.git.osandov@fb.com>
References: <cover.1563822638.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In process_clone(), we're not checking the return value of strdup().
But, there's no reason to strdup() in the first place: we just pass the
path into path_cat_out(). Get rid of the strdup().

Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 cmds/receive.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index 830ed082..dba05982 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -730,7 +730,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
 	struct btrfs_ioctl_clone_range_args clone_args;
 	struct subvol_info *si = NULL;
 	char full_path[PATH_MAX];
-	char *subvol_path = NULL;
+	const char *subvol_path;
 	char full_clone_path[PATH_MAX];
 	int clone_fd = -1;
 
@@ -751,7 +751,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
 		if (memcmp(clone_uuid, rctx->cur_subvol.received_uuid,
 				BTRFS_UUID_SIZE) == 0) {
 			/* TODO check generation of extent */
-			subvol_path = strdup(rctx->cur_subvol_path);
+			subvol_path = rctx->cur_subvol_path;
 		} else {
 			if (!si)
 				ret = -ENOENT;
@@ -769,14 +769,14 @@ static int process_clone(const char *path, u64 offset, u64 len,
 			if (sub_len > root_len &&
 			    strstr(si->path, rctx->full_root_path) == si->path &&
 			    si->path[root_len] == '/') {
-				subvol_path = strdup(si->path + root_len + 1);
+				subvol_path = si->path + root_len + 1;
 			} else {
 				error("clone: source subvol path %s unreachable from %s",
 					si->path, rctx->full_root_path);
 				goto out;
 			}
 		} else {
-			subvol_path = strdup(si->path);
+			subvol_path = si->path;
 		}
 	}
 
@@ -814,7 +814,6 @@ out:
 		free(si->path);
 		free(si);
 	}
-	free(subvol_path);
 	if (clone_fd != -1)
 		close(clone_fd);
 	return ret;
-- 
2.22.0

