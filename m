Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD14149ACC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 07:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381521AbiAYGyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 01:54:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51470 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376769AbiAYGvT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 01:51:19 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D22421F381
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 06:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643093476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=THX0iXoFeYPRzVapR1mpmX0HNRgo7eUwJXsZ1YIcxxM=;
        b=qkzv28v42K9bbV+WezhAyxaBwvmswLnXS5fDvCTNCIkVmMWymNbileGkegYTnrD0g97/AI
        lGbcJ+dpxfwAv0NaZZgrpa728oiZqhIOipp0nyXV0OapOJWxhFtoLRg/f3f6BEAa/Fvwzx
        +NVCFwl7v4984NJKlprxFYx84zurhjQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C70CE13BAA
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 06:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WJ2zJOOd72H5AQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 06:51:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [POC for v5.15 1/2] btrfs: defrag: don't defrag preallocated extents
Date:   Tue, 25 Jan 2022 14:50:56 +0800
Message-Id: <20220125065057.35863-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125065057.35863-1-wqu@suse.com>
References: <20220125065057.35863-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the same patch as "btrfs: defrag: don't try to merge regular
extents with preallocated extents" but for v5.15.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0ae5777bf056..8350864a4bd8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1152,19 +1152,23 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 				     bool locked)
 {
 	struct extent_map *next;
-	bool ret = true;
+	bool ret = false;
 
 	/* this is the last extent */
 	if (em->start + em->len >= i_size_read(inode))
-		return false;
+		return ret;
 
 	next = defrag_lookup_extent(inode, em->start + em->len, locked);
 	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
-		ret = false;
-	else if ((em->block_start + em->block_len == next->block_start) &&
-		 (em->block_len > SZ_128K && next->block_len > SZ_128K))
-		ret = false;
+		goto out;
+	if (test_bit(EXTENT_FLAG_COMPRESSED, &next->flags))
+		goto out;
+	if ((em->block_start + em->block_len == next->block_start) &&
+	 (em->block_len > SZ_128K && next->block_len > SZ_128K))
+		goto out;
 
+	ret = true;
+out:
 	free_extent_map(next);
 	return ret;
 }
-- 
2.34.1

