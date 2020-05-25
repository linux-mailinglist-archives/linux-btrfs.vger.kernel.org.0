Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926C51E070F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbgEYGeB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 02:34:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:33360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388487AbgEYGeB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 02:34:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F39C9AB87;
        Mon, 25 May 2020 06:34:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT v2 18/30] fs: btrfs: inode: Allow next_length() to return value > BTRFS_NAME_LEN
Date:   Mon, 25 May 2020 14:32:45 +0800
Message-Id: <20200525063257.46757-19-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All existing next_length() caller handles return value > BTRFS_NAME_LEN,
so there is no need to do BTRFS_NAME_LEN check in next_length().

But still, we want to exit early if we're beyond BTRFS_NAME_LEN, so this
patch will make next_length() to exit as soon as we're beyond BTRFS_NAME_LEN.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 007cf32c1603..da2a5e90a1bf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -217,8 +217,12 @@ static u64 __get_parent_inode(struct __btrfs_root *root, u64 inr,
 static inline int next_length(const char *path)
 {
 	int res = 0;
-	while (*path != '\0' && *path != '/' && res <= BTRFS_NAME_LEN)
-		++res, ++path;
+	while (*path != '\0' && *path != '/') {
+		++res;
+		++path;
+		if (res > BTRFS_NAME_LEN)
+			break;
+	}
 	return res;
 }
 
-- 
2.26.2

