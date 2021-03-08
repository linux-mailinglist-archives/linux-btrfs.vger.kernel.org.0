Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D569330A32
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 10:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCHJUr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 04:20:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:48840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhCHJUW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Mar 2021 04:20:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615195221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YW/ExaDrcHqyJc8ltluaQEjHl6Fo8H6rhL9pFpxLMec=;
        b=HAgLeOq6K7/PEeLL0DRZ2CeUfY8L0PVWHat55uZCPmaWGRI301dxhFUetYXHk3cD7SisaE
        +ELo8EJfZkJebM8f/TslgwQbS9wAYHezlkqPZKojmiY6qMEJgQd1PrBpRrgz85De1dEsTL
        gD0FscWzwhNaFi6l8YMCM8/Z5z+v8AE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87D66AC54;
        Mon,  8 Mar 2021 09:20:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] btrfs: fix wrong offset to zero out range beyond isize
Date:   Mon,  8 Mar 2021 17:20:17 +0800
Message-Id: <20210308092017.81059-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Btrfs fails at generic/091 test case, with the following output:

  fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -W
  mapped writes DISABLED
  Seed set to 1
  main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, disabling!
  main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, disabling!
  skipping zero size read
  truncating to largest ever: 0xe400
  copying to largest ever: 0x1f400
  cloning to largest ever: 0x70000
  cloning to largest ever: 0x77000
  fallocating to largest ever: 0x7a120
  Mapped Read: non-zero data past EOF (0x3a7ff) page offset 0x800 is 0xf2e1 <<<
  ...

[CAUSE]
In commit c28ea613fafa ("btrfs: subpage: fix the false data csum mismatch error")
end_bio_extent_readpage() changes to only zero the range inside the bvec
for incoming subpage support.

But that commit is using incorrect offset to calculate the start.

For subpage, we can have a case that the whole bvec is beyond isize,
thus we need to calculate the correct offset.

But the offending commit is using @end (bvec end), other than @start
(bvec start) to calculate the start offset.

This means, we only zero the last byte of the bvec, not from the isize.
This stupid bug makes the range beyond isize is not properly zeroed, and
failed above test.

[FIX]
Use correct @start to calculate the range start.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Sorry, I didn't do the full test for the offending patch, thinking such
small change, which only affects read after isize, shoudn't cause much
problem.

All my fault.
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4671c99d468d..f3d7be975c3a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3020,7 +3020,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 */
 			if (page->index == end_index && i_size <= end) {
 				u32 zero_start = max(offset_in_page(i_size),
-						     offset_in_page(end));
+						     offset_in_page(start));
 
 				zero_user_segment(page, zero_start,
 						  offset_in_page(end) + 1);
-- 
2.30.1

