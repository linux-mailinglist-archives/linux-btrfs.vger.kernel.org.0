Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF5B418FCF
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhI0HYO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56806 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbhI0HYG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 06818200A0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ncKf17UxJzZVDOoZtGqFB6jwID1kTkvQ4r52vd0ids=;
        b=GUD4zBWVS04HCrfHqeD0hlnoLTWfHN1EGh6DziLIcpMr6f5HUKox453JGnFan7Y1gY9G0I
        LaKiLCwuuF4Dp6JuMRuoLK6UdKNmqP3fyFvVUfFWg8lKqlslFKO0lXYeUQX1HKp4jOltkQ
        cvqxFn+teHKznbkGwzt9aPum7PipqUk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60A5213A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sBZqCzNxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 01/26] btrfs: remove unused parameter @nr_pages in add_ra_bio_pages()
Date:   Mon, 27 Sep 2021 15:21:43 +0800
Message-Id: <20210927072208.21634-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Variable @nr_pages only get increased but never used.
Remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2a86a2a1494b..b50927740d27 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -551,7 +551,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	u64 isize = i_size_read(inode);
 	int ret;
 	struct page *page;
-	unsigned long nr_pages = 0;
 	struct extent_map *em;
 	struct address_space *mapping = inode->i_mapping;
 	struct extent_map_tree *em_tree;
@@ -647,7 +646,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 				   PAGE_SIZE, 0);
 
 		if (ret == PAGE_SIZE) {
-			nr_pages++;
 			put_page(page);
 		} else {
 			unlock_extent(tree, last_offset, end);
-- 
2.33.0

