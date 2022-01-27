Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1C349DA01
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 06:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiA0FZF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 00:25:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48374 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiA0FZE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 00:25:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E97C4218F3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 05:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643261103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5GuoGqxlCXfRwE+CAIppGfSYzrmW+C/UBFd4k34ul0=;
        b=s9ILFSUWBoFlyt4y2ZHk53Jqr+CqP95c9j1301TbMf5OZe/E/vEsgE88krYuj+qY2P3/0u
        +gZYFHv9MqhKHdq2Th0kTJJh0Bx7ndHUvDCkyn3DdjfOAl8G4A7U73xp8VHtOdd4B3syGi
        qZHT71SxozsNIGTdAsOr+yaz/RsLONU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C57913F58
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 05:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uBhqKa4s8mFOXgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 05:25:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: defrag: remove an ambiguous condition for rejection
Date:   Thu, 27 Jan 2022 13:24:43 +0800
Message-Id: <0a2fdf173e68967239e4162fe08c434502ba7ea1.1643260816.git.wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643260816.git.wqu@suse.com>
References: <cover.1643260816.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From the very beginning of btrfs defrag, there is a check to reject
extents which meet both conditions:

- Physically adjacent

  We may want to defrag physically adjacent extents to reduce the number
  of extents or the size of subvolume tree.

- Larger than 128K

  This may be there for compressed extents, but unfortunately 128K is
  exactly the max capacity for compressed extents.
  And the check is > 128K, thus it never rejects compressed extents.

  Furthermore, the compressed extent capacity bug is fixed by previous
  patch, there is no reason for that check anymore.

The original check has a very small ranges to reject (the target extent
size is > 128K, and default extent threshold is 256K), and for
compressed extent it doesn't work at all.

So it's better just to remove the rejection, and allow us to defrag
physically adjacent extents.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a03c31e1ff18..af95e3b7aa72 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1078,10 +1078,6 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 	 */
 	if (next->len >= get_extent_max_capacity(em))
 		goto out;
-	/* Physically adjacent and large enough */
-	if ((em->block_start + em->block_len == next->block_start) &&
-	    (em->block_len > SZ_128K && next->block_len > SZ_128K))
-		goto out;
 	ret = true;
 out:
 	free_extent_map(next);
-- 
2.34.1

