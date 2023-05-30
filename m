Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE62715A43
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 11:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjE3JfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 05:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjE3Jev (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 05:34:51 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FC010A;
        Tue, 30 May 2023 02:34:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vjt9QYb_1685439286;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vjt9QYb_1685439286)
          by smtp.aliyun-inc.com;
          Tue, 30 May 2023 17:34:47 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] btrfs: remove unused definition
Date:   Tue, 30 May 2023 17:34:45 +0800
Message-Id: <20230530093445.61526-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The code using variable pages_processed has been removed,
and function folio_nr_pages has not changed the memory of pointer folio,
so both should be removed.

silence the warning:
fs/btrfs/extent_io.c:230:16: warning: variable 'pages_processed' set but not used

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5340
Fixes: 8294b1869688 ("btrfs: split page locking out of __process_pages_contig")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/btrfs/extent_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 89e093ae1c33..6919409c1183 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -227,7 +227,6 @@ static void __process_pages_contig(struct address_space *mapping,
 	pgoff_t start_index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
 	pgoff_t index = start_index;
-	unsigned long pages_processed = 0;
 	struct folio_batch fbatch;
 	int i;
 
@@ -242,7 +241,6 @@ static void __process_pages_contig(struct address_space *mapping,
 
 			process_one_page(fs_info, &folio->page, locked_page,
 					 page_ops, start, end);
-			pages_processed += folio_nr_pages(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.20.1.7.g153144c

