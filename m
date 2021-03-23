Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AED345E71
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 13:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhCWMqa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 08:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhCWMq3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 08:46:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F7C8619B7;
        Tue, 23 Mar 2021 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616503588;
        bh=dKb4XHoIDXNLVg+qyrrG69FkzuESgHyQtMG/175Jr0E=;
        h=From:To:Cc:Subject:Date:From;
        b=mn4G5F2Q76qMPWsgaqnasyU9DR6HnK3afRUyNqF7giwnuVWMbolkSDWbtRnnrd1qF
         QeI51YC8ZBRuhVC0tN8XYfuoaBeKYDmGv+JLipyZhc4Z5QDmBUv1mRLFgemHqjeU87
         7431ZkI0gkbWNYlH9BYAqt54rhsPXKGvo7Gu8Mxl2Y7BvlEL3MEgIaS2Cw5YxtVSuJ
         4H3CAHXR592NKYKLc9H09iV0HG6znQxNNruqmX03met0sVD/W8c4tIWpqh/r1JU41S
         WR1YYWa6nCWZHLx2e0LwFfJh7ranM6SKDKAHCNbCEZoIQctCvCuXYtPVDThf/mTI/e
         Lk0CuVME+Wn8g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: zoned: fix uninitialized max_chunk_size
Date:   Tue, 23 Mar 2021 13:46:19 +0100
Message-Id: <20210323124624.1494552-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The ctl->max_chunk_size member might be used uninitialized
when none of the three conditions for initializing it in
init_alloc_chunk_ctl_policy_zoned() are true:

In function ‘init_alloc_chunk_ctl_policy_zoned’,
    inlined from ‘init_alloc_chunk_ctl’ at fs/btrfs/volumes.c:5023:3,
    inlined from ‘btrfs_alloc_chunk’ at fs/btrfs/volumes.c:5340:2:
include/linux/compiler-gcc.h:48:45: error: ‘ctl.max_chunk_size’ may be used uninitialized [-Werror=maybe-uninitialized]
 4998 |         ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
      |                               ^~~
fs/btrfs/volumes.c: In function ‘btrfs_alloc_chunk’:
fs/btrfs/volumes.c:5316:32: note: ‘ctl’ declared here
 5316 |         struct alloc_chunk_ctl ctl;
      |                                ^~~

Initialize it to UINT_MAX and rely on the min() expression to limit
it.

Fixes: 1cd6121f2a38 ("btrfs: zoned: implement zoned chunk allocator")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Note that the -Wmaybe-unintialized warning is globally disabled
by default. For some reason I got this warning anyway when building
this specific file with gcc-11.
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bc3b33efddc5..b42b423b6a10 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4980,6 +4980,7 @@ static void init_alloc_chunk_ctl_policy_zoned(
 	u64 type = ctl->type;
 
 	ctl->max_stripe_size = zone_size;
+	ctl->max_chunk_size = UINT_MAX;
 	if (type & BTRFS_BLOCK_GROUP_DATA) {
 		ctl->max_chunk_size = round_down(BTRFS_MAX_DATA_CHUNK_SIZE,
 						 zone_size);
-- 
2.29.2

