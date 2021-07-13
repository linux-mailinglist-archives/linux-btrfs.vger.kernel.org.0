Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57103C6A55
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhGMGSb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59726 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbhGMGSb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:31 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0866820057
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=prjg/QXz2fqTXm2xdowE94Rq5QV3KVIg+OxEHvlX4gI=;
        b=g5mwdT9iSxVFrWELB4M1go28MN+o5OBl1Hx0moEkSX/Q5mhiRgYjH1Vjz90GZiXgkF+fbp
        IPritJxESKmld8qXfZfx2piOPEUomT5ovCfGWCQDLzUjb6AQ6Bd9gILvpeHFLRP0cJIRft
        1CQs6sdhjIxpOyY0pXpnCX16DnDtWM0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 46060139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id cCCuAowv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 17/27] btrfs: make compress_file_range() to be subpage compatible
Date:   Tue, 13 Jul 2021 14:15:06 +0800
Message-Id: <20210713061516.163318-18-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
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
index 94449a6da16b..3e6ff2b2dded 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -757,7 +757,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		 * win, compare the page count read with the blocks on disk,
 		 * compression must free at least one sector size
 		 */
-		total_in = ALIGN(total_in, PAGE_SIZE);
+		total_in = round_up(total_in, fs_info->sectorsize);
 		if (total_compressed + blocksize <= total_in) {
 			compressed_extents++;
 
-- 
2.32.0

