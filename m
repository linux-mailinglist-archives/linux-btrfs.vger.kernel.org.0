Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D93D532E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 08:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhGZFyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 01:54:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57298 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhGZFyu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 01:54:50 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7598121F1B
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627281315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqp8LYRdhesEJoj/G9uGoI9CQUC0nerQmMLYwRq6jCc=;
        b=pq5TdlzMxQkiF4fqGG8iRSGZlegEAwBdRwzB6zYTsT6LZo3yxFQke/lwRzBKOAqELcY7U/
        Uc61bETFy1dvZSyDXqJY6KM+m5CJXuM1g5rhun/Rc6QyP4AAyr93Hux2bKMaaVB4ug8Lhd
        /Qtb98H3Q6C8YvEIehFgRr7IqkovAPw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AD5681365C
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ADxOG6JX/mCXBQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v8 03/18] btrfs: disable compressed readahead for subpage
Date:   Mon, 26 Jul 2021 14:34:52 +0800
Message-Id: <20210726063507.160396-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726063507.160396-1-wqu@suse.com>
References: <20210726063507.160396-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For current subpage support, we only support 64K page size with 4K
sector size.

This makes compressed readahead less effective, as maximum compressed
extent size is only 128K, 2x the page size.

On the other hand, the function add_ra_bio_pages() is still assuming
sectorsize == PAGE_SIZE, and code change may affect 4K page size
systems.

So for now, let's disable subpage compressed readahead for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index aeda426b6121..af3f8ceb8531 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -564,6 +564,16 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	if (isize == 0)
 		return 0;
 
+	/*
+	 * For current subpage support, we only support 64K page size,
+	 * which means maximum compressed extent size (128K) is just 2x page
+	 * size.
+	 * This makes readahead less effective, so here disable readahead for
+	 * subpage support for now, until full compressed write is supported.
+	 */
+	if (btrfs_sb(inode->i_sb)->sectorsize < PAGE_SIZE)
+		return 0;
+
 	end_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 
 	while (last_offset < compressed_end) {
-- 
2.32.0

