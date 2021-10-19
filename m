Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030744334B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 13:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJSLb6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 07:31:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42976 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhJSLb6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 07:31:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F333F1FD2D
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 11:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634642985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4aJQ9TAIUG42otnDFUwmoWCv9rALfbdtua9Bi5u8GY=;
        b=tufwL8amcp9VB5GzEPyuPxz2JGME7C+KtMHAr9fMoG14mQ0fFrEi0GmEmjUGBzw+L4QRTd
        zOqlABO0y0gF0xfoQDOlDKEcBySO2T6T5DggudB2AvhTnPvQOovrk28Mjfbz2BbyPahb0E
        fQApfrOoEqlxHvNaQ2KdKBCyu/Tbg/E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52E8D13E5F
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 11:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4F3dByisbmGmcAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 11:29:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: make sizeof(struct btrfs_super_block) to match BTRFS_SUPER_INFO_SIZE
Date:   Tue, 19 Oct 2021 19:29:24 +0800
Message-Id: <20211019112925.71920-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019112925.71920-1-wqu@suse.com>
References: <20211019112925.71920-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's a common practice to avoid use sizeof(struct btrfs_super_block)
(3531), but to use BTRFS_SUPER_INFO_SIZE (4096).

The problem is that, sizeof(struct btrfs_super_block) doesn't match
BTRFS_SUPER_INFO_SIZE from the very beginning.

Furthermore, for all call sites except selftest, we always allocate
BTRFS_SUPER_INFO_SIZE space for btrfs super block, there isn't any real
reason to use the smaller value, and it doesn't really save any space.

So let's get rid of such confusing behavior, and unify those two values.

This patch will also add a BUILD_BUG_ON() to verify the value at build
time.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h | 3 +++
 fs/btrfs/super.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 140126898577..e05098ac0337 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -270,6 +270,9 @@ struct btrfs_super_block {
 	__le64 reserved[28];
 	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
+
+	/* Padded to 4096 bytes */
+	u8 padding[565];
 } __attribute__ ((__packed__));
 
 /*
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a1c54a2c787c..6fb5cdfceaf5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2552,6 +2552,8 @@ static int __init init_btrfs_fs(void)
 {
 	int err;
 
+	BUILD_BUG_ON(sizeof(struct btrfs_super_block) != BTRFS_SUPER_INFO_SIZE);
+
 	btrfs_props_init();
 
 	err = btrfs_init_sysfs();
-- 
2.33.0

