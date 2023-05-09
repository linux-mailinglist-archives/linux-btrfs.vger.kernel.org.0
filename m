Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5600B6FC55A
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjEILtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 07:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjEILtD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 07:49:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9672F40F8
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 04:49:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 482B9211C3
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683632940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBcFExtPeuao6NgWBsfNFluqAE2BoVY1/exNHwTtjSM=;
        b=ba7ZsZJfkqAE43ebchVmsvf3kUR2CrkykYlXdqDPhRtypF+p+PUZk6U9IKV7hAQ/p9yJyT
        tQFxfwR+/HjS04vIFbakehQ1eiUFEEkoxOK2OJwGxywGivGMLMgPw9QXGpnTEzmOJKCSQO
        XcBwZQH6EDO4T4WAs9fKRHs0BC3LZjs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B9AE139B3
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 11:48:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OBMjFCszWmQSMwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 May 2023 11:48:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: split btrfs_direct_pio() functions into two
Date:   Tue,  9 May 2023 19:48:38 +0800
Message-Id: <86c88bc4e7d0500ae22317546420704e57a0ee88.1683632614.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683632614.git.wqu@suse.com>
References: <cover.1683632614.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's not a common practice to use the same io function for both read and
write (we have pread() and pwrite(), not pio()).

Furthermore the original function has the following problems:

- Not returning proper error number
  If we had ioctl/stat errors we just return 0 with errno set.
  Thus caller would treat it as a short read, not a proper error.

- Unnecessary @ret_rw
  This is not that obvious if we have different handling for read and
  write, but if we split them it's super obvious we can reuse @ret.

- No proper copy back for short read

- Unable to constify the @buf pointer for write operation

All those problems would be addressed in this patch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/device-utils.c | 82 +++++++++++++++++++++++++++++--------------
 common/device-utils.h |  7 ++--
 2 files changed, 60 insertions(+), 29 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 30b66ca8646f..c911a014dbb3 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -529,7 +529,7 @@ int device_get_rotational(const char *file)
 	return (rotational == '0');
 }
 
-ssize_t btrfs_direct_pio(int rw, int fd, void *buf, size_t count, off_t offset)
+ssize_t btrfs_direct_pread(int fd, void *buf, size_t count, off_t offset)
 {
 	int alignment;
 	size_t iosize;
@@ -537,13 +537,10 @@ ssize_t btrfs_direct_pio(int rw, int fd, void *buf, size_t count, off_t offset)
 	struct stat stat_buf;
 	unsigned long req;
 	int ret;
-	ssize_t ret_rw;
-
-	UASSERT(rw == READ || rw == WRITE);
 
 	if (fstat(fd, &stat_buf) == -1) {
 		error("fstat failed: %m");
-		return 0;
+		return -errno;
 	}
 
 	if ((stat_buf.st_mode & S_IFMT) == S_IFBLK)
@@ -553,20 +550,61 @@ ssize_t btrfs_direct_pio(int rw, int fd, void *buf, size_t count, off_t offset)
 
 	if (ioctl(fd, req, &alignment)) {
 		error("failed to get block size: %m");
-		return 0;
+		return -errno;
 	}
 
-	if (IS_ALIGNED((size_t)buf, alignment) && IS_ALIGNED(count, alignment)) {
-		if (rw == WRITE)
-			return pwrite(fd, buf, count, offset);
-		else
-			return pread(fd, buf, count, offset);
+	if (IS_ALIGNED((size_t)buf, alignment) && IS_ALIGNED(count, alignment))
+		return pread(fd, buf, count, offset);
+
+	iosize = round_up(count, alignment);
+
+	ret = posix_memalign(&bounce_buf, alignment, iosize);
+	if (ret) {
+		error_msg(ERROR_MSG_MEMORY, "bounce buffer");
+		errno = ret;
+		return -ret;
 	}
 
+	ret = pread(fd, bounce_buf, iosize, offset);
+	if (ret >= count)
+		ret = count;
+	memcpy(buf, bounce_buf, count);
+
+	free(bounce_buf);
+	return ret;
+}
+
+ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t count, off_t offset)
+{
+	int alignment;
+	size_t iosize;
+	void *bounce_buf = NULL;
+	struct stat stat_buf;
+	unsigned long req;
+	int ret;
+
+	if (fstat(fd, &stat_buf) == -1) {
+		error("fstat failed: %m");
+		return -errno;
+	}
+
+	if ((stat_buf.st_mode & S_IFMT) == S_IFBLK)
+		req = BLKSSZGET;
+	else
+		req = FIGETBSZ;
+
+	if (ioctl(fd, req, &alignment)) {
+		error("failed to get block size: %m");
+		return -errno;
+	}
+
+	if (IS_ALIGNED((size_t)buf, alignment) && IS_ALIGNED(count, alignment))
+		return pwrite(fd, buf, count, offset);
+
 	/* Cannot do anything if the write size is not aligned */
-	if (rw == WRITE && !IS_ALIGNED(count, alignment)) {
+	if (!IS_ALIGNED(count, alignment)) {
 		error("%zu is not aligned to %d", count, alignment);
-		return 0;
+		return -EINVAL;
 	}
 
 	iosize = round_up(count, alignment);
@@ -575,21 +613,13 @@ ssize_t btrfs_direct_pio(int rw, int fd, void *buf, size_t count, off_t offset)
 	if (ret) {
 		error_msg(ERROR_MSG_MEMORY, "bounce buffer");
 		errno = ret;
-		return 0;
+		return -ret;
 	}
 
-	if (rw == WRITE) {
-		UASSERT(iosize == count);
-		memcpy(bounce_buf, buf, count);
-		ret_rw = pwrite(fd, bounce_buf, iosize, offset);
-	} else {
-		ret_rw = pread(fd, bounce_buf, iosize, offset);
-		if (ret_rw >= count) {
-			ret_rw = count;
-			memcpy(buf, bounce_buf, count);
-		}
-	}
+	UASSERT(iosize == count);
+	memcpy(bounce_buf, buf, count);
+	ret = pwrite(fd, bounce_buf, iosize, offset);
 
 	free(bounce_buf);
-	return ret_rw;
+	return ret;
 }
diff --git a/common/device-utils.h b/common/device-utils.h
index 064d7cd09927..6390a72951eb 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -50,7 +50,8 @@ int device_get_rotational(const char *file);
  */
 int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		u64 max_block_count, unsigned opflags);
-ssize_t btrfs_direct_pio(int rw, int fd, void *buf, size_t count, off_t offset);
+ssize_t btrfs_direct_pread(int fd, void *buf, size_t count, off_t offset);
+ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t count, off_t offset);
 
 #ifdef BTRFS_ZONED
 static inline ssize_t btrfs_pwrite(int fd, void *buf, size_t count,
@@ -59,7 +60,7 @@ static inline ssize_t btrfs_pwrite(int fd, void *buf, size_t count,
 	if (!direct)
 		return pwrite(fd, buf, count, offset);
 
-	return btrfs_direct_pio(WRITE, fd, buf, count, offset);
+	return btrfs_direct_pwrite(fd, buf, count, offset);
 }
 static inline ssize_t btrfs_pread(int fd, void *buf, size_t count, off_t offset,
 				  bool direct)
@@ -67,7 +68,7 @@ static inline ssize_t btrfs_pread(int fd, void *buf, size_t count, off_t offset,
 	if (!direct)
 		return pread(fd, buf, count, offset);
 
-	return btrfs_direct_pio(READ, fd, buf, count, offset);
+	return btrfs_direct_pread(fd, buf, count, offset);
 }
 #else
 #define btrfs_pwrite(fd, buf, count, offset, direct) \
-- 
2.40.1

