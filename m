Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FC3418FDF
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhI0HY1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhI0HYW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A6E6220C0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SfKXq2rwGDlLsS7p5Cts37V7MN39UzvBER2CHTZJZuQ=;
        b=jgkHPQZLEZ5Z5fIbE4rrR1bkBVdBhsTRz5ASuhRbKKtFxOvccMW7oigIUuERMOjqWI5UKH
        z6aoU4cYybSJwmUL4lBex/G4ljnhhvLMb5aEwSpXBcFuUHm3sSnDUsbEJa8yWN+nGIYVad
        hPSPJN7N5Yih7oCqnpyyxfzH2S0uG+g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C073313A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WI/rIkNxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 17/26] btrfs: make compress_file_range() to be subpage compatible
Date:   Mon, 27 Sep 2021 15:21:59 +0800
Message-Id: <20210927072208.21634-18-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
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
index 8675a35189a9..6a13169adf44 100644
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
2.33.0

