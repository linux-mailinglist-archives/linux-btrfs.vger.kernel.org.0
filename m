Return-Path: <linux-btrfs+bounces-776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A06480B328
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 09:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095C61F212A9
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 08:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846CC79C7;
	Sat,  9 Dec 2023 08:21:40 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67161171D
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Dec 2023 00:21:35 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vy5DIlH_1702110092;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0Vy5DIlH_1702110092)
          by smtp.aliyun-inc.com;
          Sat, 09 Dec 2023 16:21:33 +0800
From: 'Guanjun' <guanjun@linux.alibaba.com>
To: wqu@suse.com,
	dsterba@suse.com,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/1] btrfs: scrub: Fix use of uninitialized variable
Date: Sat,  9 Dec 2023 16:21:32 +0800
Message-Id: <20231209082132.2690130-1-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Guanjun <guanjun@linux.alibaba.com>

'ret' will be uninitialized in case that the logical_length
is 0. Even if the caller has already ensured that logical_length
is greater than 0, we still need to fix this issue. Due to the
compiler may complain like this:

fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.constprop’:
fs/btrfs/scrub.c:2123:9: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
 2123 |  return ret;
      |         ^~~

Fixes: 09022b14fafc (btrfs: scrub: introduce dedicated helper to scrub simple-mirror based range)
Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a01807cbd4d4..13024131f77d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2071,7 +2071,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	const u64 logical_end = logical_start + logical_length;
 	u64 cur_logical = logical_start;
-	int ret;
+	int ret = 0;
 
 	/* The range must be inside the bg */
 	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
-- 
2.39.3


