Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F953D66F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 20:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhGZSKj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 14:10:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57668 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhGZSKj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 14:10:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1DDEF2200D;
        Mon, 26 Jul 2021 18:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627325467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XSdouBCoTtFPonStuT+WoY5P9PNPDfPrRnB37V6O0Bk=;
        b=JNKdz4joKoRZX3qxN/cK3AV1pM+diacrITNQKpS/0GlPoFd4Y9a4TE/RASxXGsyQbDXUnx
        8je2uXmV5ILBrGevVfZ60qjdCQEQgWR5BWxo2w+YSe4+U4eYmE/FRB+LgFQOuKsqGPR/IB
        CYAMThf0kn4FZC142StHhkXsYpO0IPA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F9C213B57;
        Mon, 26 Jul 2021 18:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hZDYERkE/2C+HQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Mon, 26 Jul 2021 18:51:05 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: file-item: Remove unneeded variable
Date:   Mon, 26 Jul 2021 15:51:07 -0300
Message-Id: <20210726185107.6842-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can return from btrfs_search_slot directly.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/file-item.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index df6631eefc65..99ca5724ac6f 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -233,7 +233,6 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_path *path, u64 objectid,
 			     u64 offset, int mod)
 {
-	int ret;
 	struct btrfs_key file_key;
 	int ins_len = mod < 0 ? -1 : 0;
 	int cow = mod != 0;
@@ -241,8 +240,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 	file_key.objectid = objectid;
 	file_key.offset = offset;
 	file_key.type = BTRFS_EXTENT_DATA_KEY;
-	ret = btrfs_search_slot(trans, root, &file_key, path, ins_len, cow);
-	return ret;
+	return btrfs_search_slot(trans, root, &file_key, path, ins_len, cow);
 }
 
 /*
-- 
2.26.2

