Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF1647FA76
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Dec 2021 07:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbhL0GMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Dec 2021 01:12:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60046 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbhL0GMa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Dec 2021 01:12:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01E2521116;
        Mon, 27 Dec 2021 06:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640585549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4DEIv18K1oCYX/XnmR6nLSwjz8erldQglFwlCLTnP8=;
        b=NNB2vv2gu5H9+NAkoeJao+GXvTupFhogSvF8ynHbSna8Rrc76YculQE1sJbGXNwZ/lWeJy
        cpPmTSSyTmjfntuALimka4BBD2d2xuH4tQAJBFmvo+fAD8CMOBSLcA9/FUnK15rO0QsmPx
        h0lrHfn9oBKevOm/aTqSK1XfVKr/IEA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B2AE13491;
        Mon, 27 Dec 2021 06:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KPNeMEtZyWGfHgAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 27 Dec 2021 06:12:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] fs/btrfs: add dependency on BLAKE2 hash
Date:   Mon, 27 Dec 2021 14:12:08 +0800
Message-Id: <20211227061208.54497-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227061208.54497-1-wqu@suse.com>
References: <20211227061208.54497-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now btrfs can utilize the newly intorudced BLAKE2 hash.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Kconfig       |  1 +
 fs/btrfs/crypto/hash.c | 14 ++++++++++++++
 fs/btrfs/crypto/hash.h |  1 +
 fs/btrfs/disk-io.c     |  2 ++
 4 files changed, 18 insertions(+)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index a0b48c23b31a..e31afe595f31 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -6,6 +6,7 @@ config FS_BTRFS
 	select ZSTD
 	select RBTREE
 	select SHA256
+	select BLAKE2
 	help
 	  This provides a single-device read-only BTRFS support. BTRFS is a
 	  next-generation Linux file system based on the copy-on-write
diff --git a/fs/btrfs/crypto/hash.c b/fs/btrfs/crypto/hash.c
index fb51f6386cb1..891a2974be05 100644
--- a/fs/btrfs/crypto/hash.c
+++ b/fs/btrfs/crypto/hash.c
@@ -4,6 +4,7 @@
 #include <linux/unaligned/access_ok.h>
 #include <linux/types.h>
 #include <u-boot/sha256.h>
+#include <u-boot/blake2.h>
 #include <u-boot/crc.h>
 
 static u32 btrfs_crc32c_table[256];
@@ -39,6 +40,19 @@ int hash_xxhash(const u8 *buf, size_t length, u8 *out)
 	return 0;
 }
 
+/* We use the full CSUM_SIZE(32) for BLAKE2B */
+#define BTRFS_BLAKE2_HASH_SIZE	32
+int hash_blake2(const u8 *buf, size_t length, u8 *out)
+{
+	blake2b_state S;
+
+	blake2b_init(&S, BTRFS_BLAKE2_HASH_SIZE);
+	blake2b_update(&S, buf, length);
+	blake2b_final(&S, out, BTRFS_BLAKE2_HASH_SIZE);
+
+	return 0;
+}
+
 int hash_crc32c(const u8 *buf, size_t length, u8 *out)
 {
 	u32 crc;
diff --git a/fs/btrfs/crypto/hash.h b/fs/btrfs/crypto/hash.h
index d1ba1fa374e3..f9846038bfa3 100644
--- a/fs/btrfs/crypto/hash.h
+++ b/fs/btrfs/crypto/hash.h
@@ -9,6 +9,7 @@ void btrfs_hash_init(void);
 int hash_crc32c(const u8 *buf, size_t length, u8 *out);
 int hash_xxhash(const u8 *buf, size_t length, u8 *out);
 int hash_sha256(const u8 *buf, size_t length, u8 *out);
+int hash_blake2(const u8 *buf, size_t length, u8 *out);
 
 u32 crc32c(u32 seed, const void * data, size_t len);
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index eb7736d53e11..8043abc1bd60 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -126,6 +126,8 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
 		return hash_xxhash(data, len, out);
 	case BTRFS_CSUM_TYPE_SHA256:
 		return hash_sha256(data, len, out);
+	case BTRFS_CSUM_TYPE_BLAKE2:
+		return hash_blake2(data, len, out);
 	default:
 		printf("Unknown csum type %d\n", csum_type);
 		return -EINVAL;
-- 
2.34.1

