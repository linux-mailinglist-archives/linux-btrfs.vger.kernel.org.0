Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098BF73376A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jun 2023 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjFPRY7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jun 2023 13:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344678AbjFPRYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jun 2023 13:24:52 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845F41FF7;
        Fri, 16 Jun 2023 10:24:49 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qADBk-009a0A-9U; Fri, 16 Jun 2023 18:24:45 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qADBk-000MoQ-2y;
        Fri, 16 Jun 2023 18:24:44 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, clm@fb.com
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] btrfs: make btrfs_compressed_bioset static
Date:   Fri, 16 Jun 2023 18:24:43 +0100
Message-Id: <20230616172443.87681-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The 'btrfs_compressed_bioset' struct isn't exported outside of the
fs/btrfs/compression.c file, so make it static to fix the following
sparse warning:

fs/btrfs/compression.c:40:16: warning: symbol 'btrfs_compressed_bioset' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 fs/btrfs/compression.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2d0493f0a184..10d8b76313dc 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -37,7 +37,7 @@
 #include "file-item.h"
 #include "super.h"
 
-struct bio_set btrfs_compressed_bioset;
+static struct bio_set btrfs_compressed_bioset;
 
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
-- 
2.39.2

