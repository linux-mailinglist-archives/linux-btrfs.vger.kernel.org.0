Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DB8FFE85
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 07:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfKRGbB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 01:31:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:38342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbfKRGbB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 01:31:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89B5EB256;
        Mon, 18 Nov 2019 06:30:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com
Subject: [PATCH 1/4] btrfs-progs: check/lowmem: Fix a false alert on uninitialized value
Date:   Mon, 18 Nov 2019 14:30:49 +0800
Message-Id: <20191118063052.56970-2-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191118063052.56970-1-wqu@suse.com>
References: <20191118063052.56970-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When compiling the devel branch with commit fb8f05e40b458
("btrfs-progs: check: Make repair_imode_common() handle inodes in
subvolume trees"), the following warning will be reported:

  check/mode-common.c: In function ‘detect_imode’:
  check/mode-common.c|1071 col 23| warning: ‘imode’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  1071 |   *imode_ret = (imode | 0700);
       |                ~~~~~~~^~~~~~~

This only occurs for regular build. If compiled with D=1, the warning
just disappears.

[CAUSE]
Looks like a bug in gcc optimization.
The code will only set @imode_ret when @found is true.
And for every "found = true" assignment we have assigned @imode.
So this is just a false alert.

[FIX]
I hope I can fix the problem of GCC, but obviously I can't (at least for
now).

So let's assign an initial value 0 to @imode to suppress the false
alert.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index 10ad6d228a03..9e81082b10aa 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -972,7 +972,7 @@ int detect_imode(struct btrfs_root *root, struct btrfs_path *path,
 	struct btrfs_inode_item iitem;
 	bool found = false;
 	u64 ino;
-	u32 imode;
+	u32 imode = 0;
 	int ret = 0;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-- 
2.24.0

