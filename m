Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FDE3C6A5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhGMGSl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhGMGSk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:40 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD189221D2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VR8XnNYlhdDP3tDYxsEuqMHh2Ggoxee8FcuSMgPQH88=;
        b=lRmtnsZV1i7awwsvrc2pAnrhbp8ll1pxAHfIVT1/Gvt2Xb/EI+RwJGrqPxSnHkp83LoBr0
        1wk1CNQ7/LJsZR2F4JNyE5t7uw5ML7xMsp0LcXkANx8r8hjHCjGgjsaNdWuvJTZe6qE1RZ
        Y/lvnhuL3nxFvfpnA4kneh0qgMf0ZAg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 06AD9139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id uBm0LpUv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 25/27] btrfs: allow subpage to compress a range which only covers one page
Date:   Tue, 13 Jul 2021 14:15:14 +0800
Message-Id: <20210713061516.163318-26-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With expertimental subpage compression write enabled, btrfs still refuse
to compress a completely valid range:

 mkfs.btrfs -f -s 4k $dev
 mount $dev -o compress $mnt

 xfs_io -f -c "pwrite 0 64K" $mnt/file
 umount $mnt

The result extent is uncompressed.

[CAUSE]
It turns out we have extra check on whether we should compress the range
in compress_file_range().

The check looks like:

	if (nr_pages > 1 && inode_need_compress(BTRFS_I(inode), start, end)) {

This means, we will only compress range which covers more than one page.

This check no longer makes sense for subpage, as one page can contain
several sectors.

[FIX]
Don't use @nr_pages, but directly compare @total_compressed against
@blocksize to determine whether we need to do compression.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1432e268c13e..1cab1e99e46e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -630,7 +630,8 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	 * inode has not been flagged as nocompress.  This flag can
 	 * change at any time if we discover bad compression ratios.
 	 */
-	if (nr_pages > 1 && inode_need_compress(BTRFS_I(inode), start, end)) {
+	if (total_compressed > blocksize &&
+	    inode_need_compress(BTRFS_I(inode), start, end)) {
 		WARN_ON(pages);
 		pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
 		if (!pages) {
-- 
2.32.0

