Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372223B1389
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 07:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFWF54 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 01:57:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41964 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFWF54 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 01:57:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6759021941
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624427738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05yNKYcYwZl8z3rGIYEPomT+tjMv7Ae41fh4TBQ7mF4=;
        b=SGVuF1m6h1VQ9bvES0/r7i00O8/E8u4zVMf8A3AipCsSwfXDsRb44TAq0WGqm2SAl42TVg
        +9ooCD/8fGPE6d26tyW04LlkYiuXF9pnpV4lHhm1QdyA4869nLJK469uwXb+lyIXdKuVnd
        nk2sRGdjtwUSFGxVoFzQQkzzNJx50bc=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 6C13CA3B91
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/8] btrfs: make compress_file_range() to be subpage compatible
Date:   Wed, 23 Jun 2021 13:55:24 +0800
Message-Id: <20210623055529.166678-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623055529.166678-1-wqu@suse.com>
References: <20210623055529.166678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In function compress_file_range(), then the compression is finished, the
function just round up @total_in to PAGE_SIZE.

This is fine for regular sectorsize == PAGE_SIZE case, but not for
subpage.

Just change the ALIGN(, PAGE_SIZE) to round_up(, sectorsize) so that
both regular sectorsize and subpage sectorsize will be happy.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e102e3672475..30cb8b1fc067 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -759,7 +759,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		 * win, compare the page count read with the blocks on disk,
 		 * compression must free at least one sector size
 		 */
-		total_in = ALIGN(total_in, PAGE_SIZE);
+		total_in = round_up(total_in, fs_info->sectorsize);
 		if (total_compressed + blocksize <= total_in) {
 			compressed_extents++;
 
-- 
2.32.0

