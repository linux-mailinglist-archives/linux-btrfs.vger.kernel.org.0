Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25F855E02F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbiF1H2z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 03:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbiF1H2t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 03:28:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0F62CDEA
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 00:28:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CFA81FB3C;
        Tue, 28 Jun 2022 07:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656401327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hloSUbimKPIEYh1/9v8Sy8+7YBlPPiZ44GRZGeoZWho=;
        b=ihZIXOHg+H6I4I3bZfP/iaE7yg6YDMLA15FZqgmRDDLt5XDncNzrEdoQ7kacrl1mnI4QiB
        xkq95VoSNvFQX7h7MQq7mmaaPEAwRA+iTF7vewnG4e6lgk83eOn9UQKf2Vk27Nfjy1mYql
        hKr1rEpquRQSqYwUJQXr78zIHLndzpI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DC47139E9;
        Tue, 28 Jun 2022 07:28:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wIevNautumJzFQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
        Simon Glass <sjg@chromium.org>
Subject: [PATCH RFC 6/8] fs: sandboxfs: add sandbox_fs_get_blocksize()
Date:   Tue, 28 Jun 2022 15:28:06 +0800
Message-Id: <9f4b43b84a688b0367a87da2d4e0eb303a36bf32.1656401086.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656401086.git.wqu@suse.com>
References: <cover.1656401086.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is to make sandboxfs to report blocksize it supports for
_fs_read() to handle unaligned read.

Unlike all other fses, sandboxfs can handle unaligned read/write without
any problem since it's calling read()/write(), which doesn't bother the
blocksize at all.

This change is mostly to make testing of _fs_read() much easier.

Cc: Simon Glass <sjg@chromium.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 arch/sandbox/cpu/os.c  | 11 +++++++++++
 fs/fs.c                |  2 +-
 fs/sandbox/sandboxfs.c | 14 ++++++++++++++
 include/os.h           |  8 ++++++++
 include/sandboxfs.h    |  1 +
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index 5ea54179176c..6c29f29bdd9b 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -46,6 +46,17 @@ ssize_t os_read(int fd, void *buf, size_t count)
 	return read(fd, buf, count);
 }
 
+ssize_t os_get_blocksize(int fd)
+{
+	struct stat stat = {0};
+	int ret;
+
+	ret = fstat(fd, &stat);
+	if (ret < 0)
+		return -errno;
+	return stat.st_blksize;
+}
+
 ssize_t os_write(int fd, const void *buf, size_t count)
 {
 	return write(fd, buf, count);
diff --git a/fs/fs.c b/fs/fs.c
index 7e4ead9b790b..337d5711c28c 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -261,7 +261,7 @@ static struct fstype_info fstypes[] = {
 		.exists = sandbox_fs_exists,
 		.size = sandbox_fs_size,
 		.read = fs_read_sandbox,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = sandbox_fs_get_blocksize,
 		.write = fs_write_sandbox,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
diff --git a/fs/sandbox/sandboxfs.c b/fs/sandbox/sandboxfs.c
index 4ae41d5b4db1..130fee088621 100644
--- a/fs/sandbox/sandboxfs.c
+++ b/fs/sandbox/sandboxfs.c
@@ -55,6 +55,20 @@ int sandbox_fs_read_at(const char *filename, loff_t pos, void *buffer,
 	return ret;
 }
 
+int sandbox_fs_get_blocksize(const char *filename)
+{
+	int fd;
+	int ret;
+
+	fd = os_open(filename, OS_O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	ret = os_get_blocksize(fd);
+	os_close(fd);
+	return ret;
+}
+
 int sandbox_fs_write_at(const char *filename, loff_t pos, void *buffer,
 			loff_t towrite, loff_t *actwrite)
 {
diff --git a/include/os.h b/include/os.h
index 10e198cf503e..a864d9ca39b2 100644
--- a/include/os.h
+++ b/include/os.h
@@ -26,6 +26,14 @@ struct sandbox_state;
  */
 ssize_t os_read(int fd, void *buf, size_t count);
 
+/**
+ * Get the optimial blocksize through stat() call.
+ *
+ * @fd:		File descriptor as returned by os_open()
+ * Return:	>=0 for the blocksize. <0 for error.
+ */
+ssize_t os_get_blocksize(int fd);
+
 /**
  * Access to the OS write() system call
  *
diff --git a/include/sandboxfs.h b/include/sandboxfs.h
index 783dd5c88a73..6937068f7b82 100644
--- a/include/sandboxfs.h
+++ b/include/sandboxfs.h
@@ -32,6 +32,7 @@ void sandbox_fs_close(void);
 int sandbox_fs_ls(const char *dirname);
 int sandbox_fs_exists(const char *filename);
 int sandbox_fs_size(const char *filename, loff_t *size);
+int sandbox_fs_get_blocksize(const char *filename);
 int fs_read_sandbox(const char *filename, void *buf, loff_t offset, loff_t len,
 		    loff_t *actread);
 int fs_write_sandbox(const char *filename, void *buf, loff_t offset,
-- 
2.36.1

