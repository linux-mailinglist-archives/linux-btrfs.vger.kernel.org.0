Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E3B47BC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 09:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfFQH7v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 03:59:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727020AbfFQH7v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 03:59:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4D172AE89
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2019 07:59:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: Fix Wformat-overflow warning in cmds-receive.c
Date:   Mon, 17 Jun 2019 15:59:36 +0800
Message-Id: <20190617075936.12113-5-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617075936.12113-1-wqu@suse.com>
References: <20190617075936.12113-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When compiling btrfs-progs with GCC 9 (9.1.0), we got the following
warnings:
  In file included from utils.h:30,
                   from cmds-receive.c:45:
  cmds-receive.c: In function 'process_subvol':
  messages.h:42:3: warning: '%s' directive argument is null [-Wformat-overflow=]
     42 |   __btrfs_error((fmt), ##__VA_ARGS__);   \
        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cmds-receive.c:178:3: note: in expansion of macro 'error'
    178 |   error("subvol: another one already started, path buf: %s",
        |   ^~~~~
      [CC]     cmds-inspect-tree-stats.o
  cmds-receive.c: In function 'process_snapshot':
  messages.h:42:3: warning: '%s' directive argument is null [-Wformat-overflow=]
     42 |   __btrfs_error((fmt), ##__VA_ARGS__);   \
        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cmds-receive.c:248:3: note: in expansion of macro 'error'
    248 |   error("snapshot: another one already started, path buf: %s",
        |   ^~~~~

[FIX]
We're using wrong member for the error output.
Fix the member to output.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds-receive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmds-receive.c b/cmds-receive.c
index fe5c3a5b05c5..07f05101f921 100644
--- a/cmds-receive.c
+++ b/cmds-receive.c
@@ -176,7 +176,7 @@ static int process_subvol(const char *path, const u8 *uuid, u64 ctransid,
 	}
 	if (rctx->cur_subvol_path[0]) {
 		error("subvol: another one already started, path buf: %s",
-				rctx->cur_subvol.path);
+				rctx->cur_subvol_path);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -246,7 +246,7 @@ static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid,
 	}
 	if (rctx->cur_subvol_path[0]) {
 		error("snapshot: another one already started, path buf: %s",
-				rctx->cur_subvol.path);
+				rctx->cur_subvol_path);
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.22.0

