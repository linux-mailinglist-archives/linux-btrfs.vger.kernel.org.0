Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4E334E53F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhC3KRz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 06:17:55 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:49054 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231621AbhC3KRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 06:17:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UTrIdsW_1617099435;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UTrIdsW_1617099435)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Mar 2021 18:17:22 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] btrfs: Remove useless call "zlib_inflateEnd"
Date:   Tue, 30 Mar 2021 18:17:01 +0800
Message-Id: <1617099421-58511-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix the following whitescan warning:

Calling "zlib_inflateEnd(&workspace->strm)" is only useful for its
return value, which is ignored.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/zlib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index d524acf..93537cc 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -357,7 +357,6 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	else
 		ret = 0;
 done:
-	zlib_inflateEnd(&workspace->strm);
 	if (data_in)
 		kunmap(pages_in[page_in_index]);
 	if (!ret)
-- 
1.8.3.1

