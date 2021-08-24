Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1BA3F593C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhHXHnT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 03:43:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48260 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbhHXHmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 03:42:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 247332208F
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629790878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhslULLOY/iae9Ou0arR6/PMSqwCEYpZtWXRM+tycAk=;
        b=eXdRSqO3Ths8shXxFgH6mo9y204r/EHUlAKiAn8KpY36BL51xQHW9rQqesOUS2fgB8wJ66
        xiJIPirxCg/ty3quQXDI9jZIjCkQYxUy1D7EZHuw5FxCRp/nq4GQ1YUxw5wL/ntxriB3dM
        h09tvuTU7ckzerjnyPeKZ9MEKNmhG+0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2126113942
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id MN0cMJyiJGF8bwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 3/4] btrfs-progs: image: reduce memory requirement for decompression
Date:   Tue, 24 Aug 2021 15:41:07 +0800
Message-Id: <20210824074108.44759-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210824074108.44759-1-wqu@suse.com>
References: <20210824074108.44759-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With recent change to enlarge max_pending_size to 256M for data dump,
the decompress code requires quite a lot of memory space. (256M * 4).

The main reason behind it is, we're using wrapped uncompress() function
call, which needs the buffer to be large enough to contain the
decompressed data.

This patch will re-work the decompress work to use inflate() which can
resume it decompression so that we can use a much smaller buffer size.

This patch choose to use 512K buffer size.

Now the memory consumption for restore is reduced to
 Cluster data size + 512K * nr_running_threads

Instead of the original one:
 Cluster data size + 1G * nr_running_threads

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 222 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 146 insertions(+), 76 deletions(-)

diff --git a/image/main.c b/image/main.c
index b57120875f72..c622c544b5d3 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1363,130 +1363,200 @@ static void write_backup_supers(int fd, u8 *buf)
 	}
 }
 
-static void *restore_worker(void *data)
+/*
+ * Restore one item.
+ *
+ * For uncompressed data, it's just reading from work->buf then write to output.
+ * For compressed data, since we can have very large decompressed data
+ * (up to 256M), we need to consider memory usage. So here we will fill buffer
+ * then write the decompressed buffer to output.
+ */
+static int restore_one_work(struct mdrestore_struct *mdres,
+			    struct async_work *async, u8 *buffer, int bufsize)
 {
-	struct mdrestore_struct *mdres = (struct mdrestore_struct *)data;
-	struct async_work *async;
-	size_t size;
-	u8 *buffer;
-	u8 *outbuf;
-	int outfd;
+	z_stream strm;
+	int buf_offset = 0;	/* offset inside work->buffer */
+	int out_offset = 0;	/* offset for output */
+	int out_len;
+	int outfd = fileno(mdres->out);
+	int compress_method = mdres->compress_method;
 	int ret;
-	int compress_size = current_version->max_pending_size * 4;
 
-	outfd = fileno(mdres->out);
-	buffer = malloc(compress_size);
-	if (!buffer) {
-		error("not enough memory for restore worker buffer");
-		pthread_mutex_lock(&mdres->mutex);
-		if (!mdres->error)
-			mdres->error = -ENOMEM;
-		pthread_mutex_unlock(&mdres->mutex);
-		pthread_exit(NULL);
+	ASSERT(is_power_of_2(bufsize));
+
+	if (compress_method == COMPRESS_ZLIB) {
+		strm.zalloc = Z_NULL;
+		strm.zfree = Z_NULL;
+		strm.opaque = Z_NULL;
+		strm.avail_in = async->bufsize;
+		strm.next_in = async->buffer;
+		strm.avail_out = 0;
+		strm.next_out = Z_NULL;
+		ret = inflateInit(&strm);
+		if (ret != Z_OK) {
+			error("failed to initialize decompress parameters: %d",
+				ret);
+			return ret;
+		}
 	}
+	while (buf_offset < async->bufsize) {
+		bool compress_end = false;
+		int read_size = min_t(u64, async->bufsize - buf_offset,
+				      bufsize);
 
-	while (1) {
-		u64 bytenr, physical_dup;
-		off_t offset = 0;
-		int err = 0;
-
-		pthread_mutex_lock(&mdres->mutex);
-		while (!mdres->nodesize || list_empty(&mdres->list)) {
-			if (mdres->done) {
-				pthread_mutex_unlock(&mdres->mutex);
-				goto out;
+		/* Read part */
+		if (compress_method == COMPRESS_ZLIB) {
+			if (strm.avail_out == 0) {
+				strm.avail_out = bufsize;
+				strm.next_out = buffer;
 			}
-			pthread_cond_wait(&mdres->cond, &mdres->mutex);
-		}
-		async = list_entry(mdres->list.next, struct async_work, list);
-		list_del_init(&async->list);
-
-		if (mdres->compress_method == COMPRESS_ZLIB) {
-			size = compress_size;
 			pthread_mutex_unlock(&mdres->mutex);
-			ret = uncompress(buffer, (unsigned long *)&size,
-					 async->buffer, async->bufsize);
+			ret = inflate(&strm, Z_NO_FLUSH);
 			pthread_mutex_lock(&mdres->mutex);
-			if (ret != Z_OK) {
-				error("decompression failed with %d", ret);
-				err = -EIO;
+			switch (ret) {
+			case Z_NEED_DICT:
+				ret = Z_DATA_ERROR;
+				__attribute__ ((fallthrough));
+			case Z_DATA_ERROR:
+			case Z_MEM_ERROR:
+				goto out;
+			}
+			if (ret == Z_STREAM_END) {
+				ret = 0;
+				compress_end = true;
 			}
-			outbuf = buffer;
+			out_len = bufsize - strm.avail_out;
 		} else {
-			outbuf = async->buffer;
-			size = async->bufsize;
+			/* No compress, read as many data as possible */
+			memcpy(buffer, async->buffer + buf_offset, read_size);
+
+			buf_offset += read_size;
+			out_len = read_size;
 		}
 
+		/* Fixup part */
 		if (!mdres->multi_devices) {
 			if (async->start == BTRFS_SUPER_INFO_OFFSET) {
-				memcpy(mdres->original_super, outbuf,
+				memcpy(mdres->original_super, buffer,
 				       BTRFS_SUPER_INFO_SIZE);
 				if (mdres->old_restore) {
-					update_super_old(outbuf);
+					update_super_old(buffer);
 				} else {
-					ret = update_super(mdres, outbuf);
-					if (ret)
-						err = ret;
+					ret = update_super(mdres, buffer);
+					if (ret < 0)
+						goto out;
 				}
 			} else if (!mdres->old_restore) {
-				ret = fixup_chunk_tree_block(mdres, async, outbuf, size);
+				ret = fixup_chunk_tree_block(mdres, async,
+							     buffer, out_len);
 				if (ret)
-					err = ret;
+					goto out;
 			}
 		}
 
+		/* Write part */
 		if (!mdres->fixup_offset) {
+			int size = out_len;
+			off_t offset = 0;
+
 			while (size) {
+				u64 logical = async->start + out_offset + offset;
 				u64 chunk_size = size;
-				physical_dup = 0;
+				u64 physical_dup = 0;
+				u64 bytenr;
+
 				if (!mdres->multi_devices && !mdres->old_restore)
 					bytenr = logical_to_physical(mdres,
-						     async->start + offset,
-						     &chunk_size,
-						     &physical_dup);
+							logical, &chunk_size,
+							&physical_dup);
 				else
-					bytenr = async->start + offset;
+					bytenr = logical;
 
-				ret = pwrite64(outfd, outbuf+offset, chunk_size,
-					       bytenr);
+				ret = pwrite64(outfd, buffer + offset, chunk_size, bytenr);
 				if (ret != chunk_size)
-					goto error;
+					goto write_error;
 
 				if (physical_dup)
-					ret = pwrite64(outfd, outbuf+offset,
-						       chunk_size,
-						       physical_dup);
+					ret = pwrite64(outfd, buffer + offset,
+						       chunk_size, physical_dup);
 				if (ret != chunk_size)
-					goto error;
+					goto write_error;
 
 				size -= chunk_size;
 				offset += chunk_size;
 				continue;
-
-error:
-				if (ret < 0) {
-					error("unable to write to device: %m");
-					err = errno;
-				} else {
-					error("short write");
-					err = -EIO;
-				}
 			}
 		} else if (async->start != BTRFS_SUPER_INFO_OFFSET) {
-			ret = write_data_to_disk(mdres->info, outbuf, async->start, size, 0);
+			ret = write_data_to_disk(mdres->info, buffer,
+						 async->start, out_len, 0);
 			if (ret) {
 				error("failed to write data");
 				exit(1);
 			}
 		}
 
-
 		/* backup super blocks are already there at fixup_offset stage */
-		if (!mdres->multi_devices && async->start == BTRFS_SUPER_INFO_OFFSET)
-			write_backup_supers(outfd, outbuf);
+		if (async->start == BTRFS_SUPER_INFO_OFFSET &&
+		    !mdres->multi_devices)
+			write_backup_supers(outfd, buffer);
+		out_offset += out_len;
+		if (compress_end) {
+			inflateEnd(&strm);
+			break;
+		}
+	}
+	return ret;
+
+write_error:
+	if (ret < 0) {
+		error("unable to write to device: %m");
+		ret = -errno;
+	} else {
+		error("short write");
+		ret = -EIO;
+	}
+out:
+	if (compress_method == COMPRESS_ZLIB)
+		inflateEnd(&strm);
+	return ret;
+}
+
+static void *restore_worker(void *data)
+{
+	struct mdrestore_struct *mdres = (struct mdrestore_struct *)data;
+	struct async_work *async;
+	u8 *buffer;
+	int ret;
+	int buffer_size = SZ_512K;
+
+	buffer = malloc(buffer_size);
+	if (!buffer) {
+		error("not enough memory for restore worker buffer");
+		pthread_mutex_lock(&mdres->mutex);
+		if (!mdres->error)
+			mdres->error = -ENOMEM;
+		pthread_mutex_unlock(&mdres->mutex);
+		pthread_exit(NULL);
+	}
+
+	while (1) {
+		pthread_mutex_lock(&mdres->mutex);
+		while (!mdres->nodesize || list_empty(&mdres->list)) {
+			if (mdres->done) {
+				pthread_mutex_unlock(&mdres->mutex);
+				goto out;
+			}
+			pthread_cond_wait(&mdres->cond, &mdres->mutex);
+		}
+		async = list_entry(mdres->list.next, struct async_work, list);
+		list_del_init(&async->list);
 
-		if (err && !mdres->error)
-			mdres->error = err;
+		ret = restore_one_work(mdres, async, buffer, buffer_size);
+		if (ret < 0) {
+			mdres->error = ret;
+			pthread_mutex_unlock(&mdres->mutex);
+			goto out;
+		}
 		mdres->num_items--;
 		pthread_mutex_unlock(&mdres->mutex);
 
-- 
2.32.0

