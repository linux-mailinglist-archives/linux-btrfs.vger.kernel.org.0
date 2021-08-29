Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C53FA94F
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhH2F0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:26:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59392 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhH2F0O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:26:14 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8BF0E21DAB
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZcuZEUnXtJ4oXuw+raoc3NAiYzDAdxYokCQsFtbGhA=;
        b=imCR6EcbwkoCFUP5SgXhymSZdjB14ZnT2ejcStDb7sYGSf7tLOmNhRTTWNvIcPKCjie+GP
        NpqnUA1D75NcQXFO0a5IufaBn16iuETMeI4pSIopY7OYyHUHN69HxFP7Iql8qzKj4Ocxb3
        8tOW0wOQ6LbOefir/KMd0XZiHsVMfjQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BE77C13964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id oAz8H0EaK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 17/26] btrfs: make compress_file_range() to be subpage compatible
Date:   Sun, 29 Aug 2021 13:24:49 +0800
Message-Id: <20210829052458.15454-18-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In function compress_file_range(), when the compression is finished, the
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
index 18d99f5dd380..09639887b65f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -758,7 +758,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		 * win, compare the page count read with the blocks on disk,
 		 * compression must free at least one sector size
 		 */
-		total_in = ALIGN(total_in, PAGE_SIZE);
+		total_in = round_up(total_in, fs_info->sectorsize);
 		if (total_compressed + blocksize <= total_in) {
 			compressed_extents++;
 
-- 
2.32.0

