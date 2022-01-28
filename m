Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8741049F44A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 08:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346754AbiA1HVp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 02:21:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39668 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiA1HVo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 02:21:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 574331F385;
        Fri, 28 Jan 2022 07:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643354503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uZMFVBOtXnmLjxHnmz/WMlHY8Dk05C+pIdr3qwhAtNM=;
        b=OpvVXoJUuUj0/PwyY0CZTONaTl6GDSp25dMTsdGe8rZ5BhD5I50UQkW0LH1wgVbuYEn39Q
        BdtQU6hHAvTBkP6SptXkZg90eRhrZ182eJQlGeA24dtkrs0nbBOWMqrotwxOcej0vgsKv9
        6YSHRVIs6cEwzWI61Zgcky9kaauaKAQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93D82139C4;
        Fri, 28 Jan 2022 07:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CDVUGYaZ82HHQQAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 28 Jan 2022 07:21:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4 3/3] btrfs: defrag: remove an ambiguous condition for rejection
Date:   Fri, 28 Jan 2022 15:21:22 +0800
Message-Id: <83892067b499630da23737147e62ec3b5741e215.1643354254.git.wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643354254.git.wqu@suse.com>
References: <cover.1643354254.git.wqu@suse.com>
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
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 74237f31d166..3d3331dd0902 100644
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

