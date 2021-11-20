Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D789B457C95
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Nov 2021 09:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhKTIhg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Nov 2021 03:37:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55070 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbhKTIhg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Nov 2021 03:37:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD37A1FD34;
        Sat, 20 Nov 2021 08:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637397270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qMVgMFqK+ZS0CJKaUTrpx5gxLAyQi28DBAIT/KVkk8c=;
        b=R9clJ1kGIOqH4b2aFfVlvPUvrTmjDVbs0ILUEQQvJLmfhKotD541QbiqJDfxhT9e5/YOvF
        yHsj4HnqK5wa1ogQo8wm6S6aQh3jn66Hxkaui69dbnMnKbAn5ydCMS04+bQze9u+7QtYIc
        ILcVpEYD6s9aKG4HwaLo1XOhO27CMhk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2CD913B16;
        Sat, 20 Nov 2021 08:34:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KApnHhWzmGHKVAAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 20 Nov 2021 08:34:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] btrfs: fix the memory leak caused in lzo_compress_pages()
Date:   Sat, 20 Nov 2021 16:34:11 +0800
Message-Id: <20211120083411.120338-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Fstests generic/027 is pretty easy to trigger a slow but steady memory
leak if run with "-o compress=lzo" mount option.

Normally one single run of generic/027 is enough to eat up at least 4G ram.

[CAUSE]
In commit d4088803f511 ("btrfs: subpage: make lzo_compress_pages()
compatible") we changed how @page_in is released.

But that refactor makes @page_in only released after all pages being
compressed.

This leaves error path not releasing @page_in. And by "error path"
things like incompressible data will also be treated as an error
(-E2BIG).

Thus it can leave btrfs to leak memory even there is nothing wrong
happened.

[FIX]
Add check under @out label to release @page_in when needed, so when we
hit any error, the input page is properly released.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: d4088803f511 ("btrfs: subpage: make lzo_compress_pages() compatible")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/lzo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 2fdfd0904313..12a459073ea1 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -290,6 +290,8 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_out = cur_out;
 	*total_in = cur_in - start;
 out:
+	if (page_in)
+		put_page(page_in);
 	*out_pages = DIV_ROUND_UP(cur_out, PAGE_SIZE);
 	return ret;
 }
-- 
2.34.0

