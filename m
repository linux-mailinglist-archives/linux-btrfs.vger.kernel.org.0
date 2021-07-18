Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2100C3CC934
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jul 2021 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhGRM5w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Jul 2021 08:57:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48302 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhGRM5v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Jul 2021 08:57:51 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F301A2014D
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jul 2021 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626612893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=O9KBaBzdQWO+XvgpCK/0Di9IyVpgrmn8NvaVJBrW4Go=;
        b=nRAMM5zWsLFpO2kb3lBVUzjOFDGp7XJ8Vq8on0mBCYbPM7aS6bujVwUqkYmiE3Sbaw1crt
        RF6sBrqLb+MqdDqfpHDhx4yc7aew6s9nKZum/Dw3AadZABDAz3XkQhVnjp/JVtwBtYYsaG
        Qwz61zxp3NnaJvomWVVFIp3CdvKmzHg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3482D1332A
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jul 2021 12:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 5sYxOZsk9GA2QAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jul 2021 12:54:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: check/original: detect directory inode with nlinks >= 2
Date:   Sun, 18 Jul 2021 20:54:48 +0800
Message-Id: <20210718125449.311815-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Linux VFS doesn't allow directory to have hard links, thus for btrfs
on-disk directory inode items, their nlinks should never go beyond 1.

Lowmem mode already has the check and will report it without problem.
Only original mode needs this update.

Reported-by: Pepperpoint <pepperpoint@mb.ardentcoding.com>
Link: https://lore.kernel.org/linux-btrfs/162648632340.7.1932907459648384384.10178178@mb.ardentcoding.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          | 7 +++++++
 check/mode-original.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/check/main.c b/check/main.c
index ee6cf793251c..df2303939ffe 100644
--- a/check/main.c
+++ b/check/main.c
@@ -623,6 +623,9 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 			rec->imode & ~07777);
 	if (errors & I_ERR_INVALID_GEN)
 		fprintf(stderr, ", invalid inode generation or transid");
+	if (errors & I_ERR_INVALID_NLINK)
+		fprintf(stderr, ", directory has invalid nlink %d",
+			rec->nlink);
 	fprintf(stderr, "\n");
 
 	/* Print the holes if needed */
@@ -909,6 +912,10 @@ static int process_inode_item(struct extent_buffer *eb,
 	if (S_ISLNK(rec->imode) &&
 	    flags & (BTRFS_INODE_IMMUTABLE | BTRFS_INODE_APPEND))
 		rec->errors |= I_ERR_ODD_INODE_FLAGS;
+
+	/* Directory should never have hard link */
+	if (S_ISDIR(rec->imode) && rec->nlink >= 2)
+		rec->errors |= I_ERR_INVALID_NLINK;
 	/*
 	 * We don't have accurate root info to determine the correct
 	 * inode generation uplimit, use super_generation + 1 anyway
diff --git a/check/mode-original.h b/check/mode-original.h
index b075a95c9757..eed16d92d0db 100644
--- a/check/mode-original.h
+++ b/check/mode-original.h
@@ -186,6 +186,7 @@ struct unaligned_extent_rec_t {
 #define I_ERR_MISMATCH_DIR_HASH		(1 << 18)
 #define I_ERR_INVALID_IMODE		(1 << 19)
 #define I_ERR_INVALID_GEN		(1 << 20)
+#define I_ERR_INVALID_NLINK		(1 << 21)
 
 struct inode_record {
 	struct list_head backrefs;
-- 
2.32.0

