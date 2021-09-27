Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A9C418FE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhI0HYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45008 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhI0HY3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98ABD220C0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kb7ZA542OY8vLWoBXvmDhYoSTuHFAusMXvNpJYDYXdc=;
        b=c52uBVnEHaYJ8cOrp1HUJK/4rSbaGGVC/aAdEj5QHubcY10K8bZI/p8EJtTR+pUSll1lUg
        brq8h5fSzPvnYQw1McJbFn+87/uWGUjrA8D5fqNoxEOJpoOYJPJIGWqyZ1eot5HIoPF2xE
        wqEDScc54PGN+w14wsbbuWKJM6u2HhU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDBE213A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +BLqLUpxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 24/26] btrfs: allow page to be unlocked by btrfs_page_end_writer_lock() even if it's locked by plain page_lock()
Date:   Mon, 27 Sep 2021 15:22:06 +0800
Message-Id: <20210927072208.21634-25-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several call sites of extent_clear_unlock_delalloc() which
gets @locked_page = NULL.
So that extent_clear_unlock_delalloc() will try to call
process_one_page() to unlock every page even the first page is not
locked by btrfs_page_start_writer_lock().

This will trigger an ASSERT() in btrfs_subpage_end_and_test_writer() as
previously we require every page passed to
btrfs_subpage_end_and_test_writer() to be locked by
btrfs_page_start_writer_lock().

But compression path doesn't go that way.

Thankfully it's not hard to distinguish page locked by lock_page() and
btrfs_page_start_writer_lock().

So do the check in btrfs_subpage_end_and_test_writer() so now it can
handle both cases well.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 50b3d96289ca..39d63a21dcb9 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -292,6 +292,17 @@ bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
 
 	btrfs_subpage_assert(fs_info, page, start, len);
 
+	/*
+	 * We have call sites passing @lock_page into
+	 * extent_clear_unlock_delalloc() for compression path.
+	 *
+	 * Those @locked_page is locked by plain lock_page(), thus its
+	 * subpage::writers is 0.
+	 * Handle them specially.
+	 */
+	if (atomic_read(&subpage->writers) == 0)
+		return true;
+
 	ASSERT(atomic_read(&subpage->writers) >= nbits);
 	return atomic_sub_and_test(nbits, &subpage->writers);
 }
-- 
2.33.0

