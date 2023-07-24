Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6E75F61F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 14:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjGXMUO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjGXMUI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 08:20:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909F8E77;
        Mon, 24 Jul 2023 05:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 953EB61127;
        Mon, 24 Jul 2023 12:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF8CC433D9;
        Mon, 24 Jul 2023 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690201181;
        bh=iwWAJYKBLb5j4fPL4Hu12qT1nZd5e76fZ0AMw+DpLq0=;
        h=From:To:Cc:Subject:Date:From;
        b=g70Q5KEwzUTcBwKA802MW7o/2isjEP+AZHYWLnF+HxqBWIAlMeMU8yXLIiGFJct7b
         14Fpa6fpdty9oELGGx3eSTyOieayser7Z/6RqtpYCh8d+BLpNR9vOnHdZ8CVbRByc2
         yneX4l8OQkrUOIFWyAo4WT6n+OytQxG5Wotd3Zkwblw8Fs38WZ/rMUHVk49Nt6/qfA
         USUbBUBA9XX8XXWgfiTVoAzAcr0M7LVszE99SWhZOylD7TOlRkn/34XI6UcpxvwVwb
         JU4aEnAxhW52HBUAG1qg0oulIzh54dIbzRJK8RWjZoC3Y+MTueR09DVYcWbQwdKoFq
         3y9b8ARMYdekQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: remove unused pages_processed variable
Date:   Mon, 24 Jul 2023 14:19:15 +0200
Message-Id: <20230724121934.1406807-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The only user of pages_processed was removed, so it's now a local write-only
variable that can be eliminated as well:

fs/btrfs/extent_io.c:214:16: error: variable 'pages_processed' set but not used [-Werror,-Wunused-but-set-variable]

Fixes: 9480af8687200 ("btrfs: split page locking out of __process_pages_contig")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307241541.8w52nEnt-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/extent_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c0440a0988c9a..121edea2cfe85 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -211,7 +211,6 @@ static void __process_pages_contig(struct address_space *mapping,
 	pgoff_t start_index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
 	pgoff_t index = start_index;
-	unsigned long pages_processed = 0;
 	struct folio_batch fbatch;
 	int i;
 
@@ -226,7 +225,6 @@ static void __process_pages_contig(struct address_space *mapping,
 
 			process_one_page(fs_info, &folio->page, locked_page,
 					 page_ops, start, end);
-			pages_processed += folio_nr_pages(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.39.2

