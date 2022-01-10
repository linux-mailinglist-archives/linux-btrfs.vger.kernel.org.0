Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848EE4894AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 10:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbiAJJDr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 04:03:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60208 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiAJJB7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 04:01:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9EEF721100;
        Mon, 10 Jan 2022 09:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641805316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ihKlF/vwRGy+ckc+Uaj4KhKsRkjcZOgurKHwyDYREWc=;
        b=LE4+B3ENEUjGmw5lCtvQ37M4gJikWeXrM7CZCwTUHAG2dTBZ9zYcClcobcCWAcC7t3dGXO
        VQ6XS5iLl/OlZiw4R+TqPcZRKKZB9+mD9PBAIzGRL8FP9U6hsF3Dplyc5iKDxCFz0n7rk7
        5jjVJF/a84aoDjwMtgC5LvVNNfLnxz8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C3F013A98;
        Mon, 10 Jan 2022 09:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rltcEwT222EwIAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 10 Jan 2022 09:01:56 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs-progs: Remove redundant fs uuid validation from make_btrf
Date:   Mon, 10 Jan 2022 11:01:55 +0200
Message-Id: <20220110090155.1813901-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

cfg->fs_uuid is either 0 or set to the value of the -U parameter
passed to mkfs.btrfs. However the value of the latter is already being
validated in the main mkfs function. Just remove the duplicated checks
in make_btrfs as they effectively can never be executed.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

v2:
 * Properly "copy" the cfg->fs_uuid into the superblock's fsid field. This fixes
 a failure in 002-uuid-rewrite.

 mkfs/common.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index fec23e64b2b2..9608d27f73e7 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -260,20 +260,11 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	memset(&super, 0, sizeof(super));

 	num_bytes = (cfg->num_bytes / cfg->sectorsize) * cfg->sectorsize;
-	if (*cfg->fs_uuid) {
-		if (uuid_parse(cfg->fs_uuid, super.fsid) != 0) {
-			error("cannot not parse UUID: %s", cfg->fs_uuid);
-			ret = -EINVAL;
-			goto out;
-		}
-		if (!test_uuid_unique(cfg->fs_uuid)) {
-			error("non-unique UUID: %s", cfg->fs_uuid);
-			ret = -EBUSY;
-			goto out;
-		}
-	} else {
+	if (!*cfg->fs_uuid) {
 		uuid_generate(super.fsid);
 		uuid_unparse(super.fsid, cfg->fs_uuid);
+	} else {
+		uuid_parse(cfg->fs_uuid, super.fsid);
 	}
 	uuid_generate(super.dev_item.uuid);
 	uuid_generate(chunk_tree_uuid);
--
2.17.1

