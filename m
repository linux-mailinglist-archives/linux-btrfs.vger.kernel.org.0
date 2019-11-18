Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE58FFFE24
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 06:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfKRFxl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 00:53:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39084 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfKRFxl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 00:53:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so9122626plk.6
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Nov 2019 21:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wRy4gkCiDmjWgFgJgp6H2Spf2zxLT0v4LF/Q/YKKLTU=;
        b=ie4AieeQl4aCeBfs3zkYgqDWYB8USLmfr1F0YUpj3gprQ4w2K43/Xf2lQeYNAwQe3p
         AKGv5qjcis6UtH/Az+1mvwGtwWuSHR2jRxjDGBCEhEZPlhMXpMPREfk3TSMlNibLJc3u
         prtkl6mktTx1pmpWV6uWa1M7aqpZfT02vwTWq/PB/Spq1yntKS/CIUQqQvxVUu2H+wtp
         bP2JEtkX0pSvr4Eo0nPtlMzfFSATOSN+iWbkMrjHnz75RIKzxzuqJEUQUxJNqbmsJtRA
         xk+4+gElWeV/GQs959Yz8Sao6+arZKc7jK2QIP2nRhvM0pGNHehor3jdFH2ojA+BbSTr
         sEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wRy4gkCiDmjWgFgJgp6H2Spf2zxLT0v4LF/Q/YKKLTU=;
        b=nTh9s0ZkZ7q9qord3aSFcHPq+750Ses5DIGOVcf8QUEoSlJrf1U867EwJI2LWQzPUP
         zJqn6DtcyX/4DTwGIP2XYw3wc0UAJeCDAb7fGVY04Kf9trs2Ey7D6t69msY2+/oI45f0
         NSr0BEauvWc3PRiz7GKFC3qfd32Omv9TDUcZNpATmWg81pdROyxDdp137MBLfJ+l60CJ
         P8xBxQFXu6QTyLHc614l8adzKULFltzZ4ogouRtJUiKOVgY0oOVSyveixNHJEfc21med
         k6ERCvr1VH7gL9fxT2CiPfbDW+Ax7cNy9aiisnWLCNQVo+KR8q6yJ3mkoifmrZcOmHgl
         gG0A==
X-Gm-Message-State: APjAAAWziF70q344Ptyctfl45Wj1hoNlKJ3Kqs1vMSTIXtFmsdbEI0iS
        EWuTYloEGC9YD1raaMW5G4pvECd4GQg=
X-Google-Smtp-Source: APXvYqyKxrZZOzz6+IZ0y/z/qL7nM5qcdy6RrR5vDz39UJAnRXugiU4ewfHfHBrNW0hiU8Pa+E+liA==
X-Received: by 2002:a17:90a:340c:: with SMTP id o12mr37240641pjb.18.1574056420215;
        Sun, 17 Nov 2019 21:53:40 -0800 (PST)
Received: from cat-arch.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id n62sm19838775pjc.6.2019.11.17.21.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 21:53:39 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Damenly_Su@gmx.com
Subject: [PATCH 1/2] btrfs-progs: block group: do not exclude bytenr adjacent to block group
Date:   Mon, 18 Nov 2019 13:53:34 +0800
Message-Id: <20191118055335.9927-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

While checking the image provided by the reporter, the btrfsck aborts:
======================================================================
Opening filesystem to check...
extent_io.c:158: insert_state: BUG_ON `end < start` triggered, value 1
btrfs check(+0xa3fa8)[0x5614c14c7fa8]
btrfs check(+0xa4046)[0x5614c14c8046]
btrfs check(+0xa45f1)[0x5614c14c85f1]
btrfs check(set_extent_bits+0x83)[0x5614c14c8c63]
btrfs check(+0xbfb90)[0x5614c14e3b90]
btrfs check(exclude_super_stripes+0x1fc)[0x5614c14e3de9]
btrfs check(+0xbd85d)[0x5614c14e185d]
btrfs check(btrfs_read_block_groups+0xd3)[0x5614c14e19f5]
btrfs check(btrfs_setup_all_roots+0x454)[0x5614c14d7740]
btrfs check(+0xb4219)[0x5614c14d8219]
btrfs check(open_ctree_fs_info+0x177)[0x5614c14d8415]
btrfs check(+0x693dd)[0x5614c148d3dd]
btrfs check(+0x14dc7)[0x5614c1438dc7]
btrfs check(main+0x126)[0x5614c1439713]
/usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7fe3f1ecf153]
btrfs check(_start+0x2e)[0x5614c1438cce]
[1]    6196 abort (core dumped)
======================================================================

It's excluding super stripes from one block group, the bytenr equals
block group's start + len, so the @num_bytes is 0. Then
add_exclude_extent() calculates the @end is less than the @start
which trigers the abort.

Anyway, the logical bytenr should not be excluded if the block group's
start + len equals it, because it's not belong to the block group.

Link: https://github.com/kdave/btrfs-progs/issues/210
Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/extent-tree.c b/extent-tree.c
index f690ae999f37..848fb72f90a4 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -3630,7 +3630,7 @@ int exclude_super_stripes(struct btrfs_fs_info *fs_info,
 		while (nr--) {
 			u64 start, len;
 
-			if (logical[nr] > cache->key.objectid +
+			if (logical[nr] >= cache->key.objectid +
 			    cache->key.offset)
 				continue;
 
-- 
2.23.0

