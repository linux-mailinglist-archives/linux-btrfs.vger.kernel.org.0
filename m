Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5483C6A5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhGMGSk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36788 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhGMGSj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:39 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87F3E21F05
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hozd7A6iP04JULX7QezSWOpCn/Bnqn5n0tSrnkl5sLA=;
        b=qQBxM+9wcHx4FE7t7WtnBkNEKfNCzqv/irnuRk9dNi7ihMuiEkVVrb5H1tJihuHw6cjJwm
        EBQAS/jWmT5o8E9aK3bFfTFryRYVPj9u6aS6iaSHD4I7o+VP1PaTtUaeI8PhKR+gFp5TCV
        CASSB4WjQELbOMPYd18a4bZPKmTcldA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C5A81139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id oD6+IZQv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 24/27] btrfs: allow page to be unlocked by btrfs_page_end_writer_lock() even if it's locked by plain page_lock()
Date:   Tue, 13 Jul 2021 14:15:13 +0800
Message-Id: <20210713061516.163318-25-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
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
index 3e0416e7e48b..7d0f4f1ce0bf 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -248,6 +248,17 @@ bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
 
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
2.32.0

