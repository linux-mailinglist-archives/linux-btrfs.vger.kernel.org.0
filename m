Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D592C64D7E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Dec 2022 09:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLOIky (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Dec 2022 03:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLOIkx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Dec 2022 03:40:53 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD7616C
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Dec 2022 00:40:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so2006842pjs.4
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Dec 2022 00:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWdnz4lyPWYGO39R7KFqlGE0UCK4LM2ZG5o56NolNMM=;
        b=LJTg3lAVuY+7HG1xaMftQIk9+8R0GLcZ3aeWZxN1lboQ5B8IiOukRQxW7TR7Jm18qJ
         V+fwLULmi1XDM4LvqT92YxM0ZcnKW4WBZpa6/hF2gqoWlsWRqd45DeMIaEwC2uVgBGO8
         ftxalsp763RGwFichj87jAyHMaT7PIxv/70nJWUp6odW0f9yBFIj/uWXuFFkmJxkX4tV
         L+TEihFABjCEztwrF3U+aAhbC+v3AF3u8XGDMR1t67SCsW5srf7i305P7zeWLFf81j0E
         falG7WLzhdaRGQ8lW8eIgclgTjKSZcMSh9Tf1IXlve87K69Rfle4O9NuBKBiE44aBRz8
         qRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWdnz4lyPWYGO39R7KFqlGE0UCK4LM2ZG5o56NolNMM=;
        b=ZXaOwIMS65bzvXn0l342Z6GvKJ0Lq8VvajKHK6WxpK+3y7EF35X360IXjdUtRe55ta
         5Yo2B4xKrsK+X0ueQOBzSiKD2yvAqZoU1FFNIDF+3GPU32Vc7qSDYqywe3K3XbLntvNN
         BUGlCWdz5z2kbqenfhmcCHQKXgQcAF99y/Ymhz9v+kY/iooraE7FvPdudpAwAxIMwXiL
         Go0QJZ398sIww4mUG/CxnypYolU1EPOnX95xwyR1PBT6jEs53BBLVFjLVkN8jv+WGxGJ
         MXI5n2UdnkN0KwFWcHKR6oaiYcYHSzh0xtQUowC6jtkAljtIc3WC4LwpMVzg2fbJFG/O
         XVgA==
X-Gm-Message-State: ANoB5pkoQ146gv28Dt2NA4Q4r0hn9fpE/Mpi+4988i3ekRxrxLVAOPOI
        pd7DhJvqnRdwj8Gqq8rTjPItMmu8rQY=
X-Google-Smtp-Source: AA0mqf7bIMl2ABIKtDP80WMCw5iMQ5AFS8NYOe46ydDxokKCY5Sywd1hJxeyy7t2GtQl6qCv5PziGw==
X-Received: by 2002:a05:6a20:a011:b0:a7:9022:5d5e with SMTP id p17-20020a056a20a01100b000a790225d5emr40341321pzj.2.1671093649090;
        Thu, 15 Dec 2022 00:40:49 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id p124-20020a634282000000b004786c63c21esm1081898pga.42.2022.12.15.00.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:40:48 -0800 (PST)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] Use pread/pwrite/ftruncate/stat instead of 64bit equivalents
Date:   Thu, 15 Dec 2022 00:40:45 -0800
Message-Id: <20221215084046.122836-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

64bit functions are aliases to original functions when largefile feature
is enabled via autoconf or right macro is passed on compiler cmdline

-D_FILE_OFFSET_BITS=64

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 cmds/rescue-chunk-recover.c |   4 +-
 image/main.c                |  14 +--
 kernel-shared/zoned.c       |   6 +-
 kernel-shared/zoned.h       |   4 +-
 mkfs/main.c                 |   4 +-
 mkfs/rootdir.c              |  10 +-
 tests/fsstress.c            | 192 ++++++++++++++++++------------------
 tests/fssum.c               |   8 +-
 8 files changed, 121 insertions(+), 121 deletions(-)

diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index e8d4b28f..d597e8bd 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -755,7 +755,7 @@ static int scan_one_device(void *dev_scan_struct)
 		if (is_super_block_address(bytenr))
 			bytenr += rc->sectorsize;
 
-		if (pread64(fd, buf->data, rc->nodesize, bytenr) <
+		if (pread(fd, buf->data, rc->nodesize, bytenr) <
 		    rc->nodesize)
 			break;
 
@@ -1875,7 +1875,7 @@ static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum,
 	data = malloc(len);
 	if (!data)
 		return -1;
-	ret = pread64(fd, data, len, start);
+	ret = pread(fd, data, len, start);
 	if (ret < 0 || ret != len) {
 		ret = -1;
 		goto out;
diff --git a/image/main.c b/image/main.c
index b1a0714a..e8acb4be 100644
--- a/image/main.c
+++ b/image/main.c
@@ -691,7 +691,7 @@ static int flush_pending(struct metadump_struct *md, int done)
 		if (start == BTRFS_SUPER_INFO_OFFSET) {
 			int fd = get_dev_fd(md->root);
 
-			ret = pread64(fd, async->buffer, size, start);
+			ret = pread(fd, async->buffer, size, start);
 			if (ret < size) {
 				free(async->buffer);
 				free(async);
@@ -1366,7 +1366,7 @@ static void write_backup_supers(int fd, u8 *buf)
 			break;
 		btrfs_set_super_bytenr(super, bytenr);
 		csum_block(buf, BTRFS_SUPER_INFO_SIZE);
-		ret = pwrite64(fd, buf, BTRFS_SUPER_INFO_SIZE, bytenr);
+		ret = pwrite(fd, buf, BTRFS_SUPER_INFO_SIZE, bytenr);
 		if (ret < BTRFS_SUPER_INFO_SIZE) {
 			if (ret < 0)
 				error(
@@ -1487,12 +1487,12 @@ static int restore_one_work(struct mdrestore_struct *mdres,
 				else
 					bytenr = logical;
 
-				ret = pwrite64(outfd, buffer + offset, chunk_size, bytenr);
+				ret = pwrite(outfd, buffer + offset, chunk_size, bytenr);
 				if (ret != chunk_size)
 					goto write_error;
 
 				if (physical_dup)
-					ret = pwrite64(outfd, buffer + offset,
+					ret = pwrite(outfd, buffer + offset,
 						       chunk_size, physical_dup);
 				if (ret != chunk_size)
 					goto write_error;
@@ -2454,7 +2454,7 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 	}
 	if (S_ISREG(buf.st_mode)) {
 		/* Don't forget to enlarge the real file */
-		ret = ftruncate64(out_fd, dev_size);
+		ret = ftruncate(out_fd, dev_size);
 		if (ret < 0) {
 			error("failed to enlarge result image: %m");
 			return -errno;
@@ -2913,7 +2913,7 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 			goto out;
 		}
 		if (S_ISREG(st.st_mode) && st.st_size < dev_size) {
-			ret = ftruncate64(fileno(out), dev_size);
+			ret = ftruncate(fileno(out), dev_size);
 			if (ret < 0) {
 				error(
 		"failed to enlarge result image file from %llu to %llu: %m",
@@ -3010,7 +3010,7 @@ static int update_disk_super_on_device(struct btrfs_fs_info *info,
 	memcpy(dev_item->fsid, fs_uuid, BTRFS_UUID_SIZE);
 	csum_block((u8 *)&disk_super, BTRFS_SUPER_INFO_SIZE);
 
-	ret = pwrite64(fp, &disk_super, BTRFS_SUPER_INFO_SIZE, BTRFS_SUPER_INFO_OFFSET);
+	ret = pwrite(fp, &disk_super, BTRFS_SUPER_INFO_SIZE, BTRFS_SUPER_INFO_OFFSET);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
 		if (ret < 0) {
 			errno = ret;
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index a79fc6a5..88d53e37 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -194,7 +194,7 @@ static int sb_write_pointer(int fd, struct blk_zone *zones, u64 *wp_ret)
 			bytenr = ((zones[i].start + zones[i].len)
 				   << SECTOR_SHIFT) - BTRFS_SUPER_INFO_SIZE;
 
-			ret = pread64(fd, buf[i], BTRFS_SUPER_INFO_SIZE, bytenr);
+			ret = pread(fd, buf[i], BTRFS_SUPER_INFO_SIZE, bytenr);
 			if (ret != BTRFS_SUPER_INFO_SIZE)
 				return -EIO;
 			super[i] = (struct btrfs_super_block *)&buf[i];
@@ -515,8 +515,8 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
 	/* We can call pread/pwrite if 'fd' is non-zoned device/file */
 	if (zone_size_sector == 0) {
 		if (rw == READ)
-			return pread64(fd, buf, count, offset);
-		return pwrite64(fd, buf, count, offset);
+			return pread(fd, buf, count, offset);
+		return pwrite(fd, buf, count, offset);
 	}
 
 	ASSERT(IS_ALIGNED(zone_size_sector, sb_size_sector));
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index cc0d6b6f..770f5889 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -150,9 +150,9 @@ int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices);
 #else
 
 #define sbread(fd, buf, offset) \
-	pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
+	pread(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
 #define sbwrite(fd, buf, offset) \
-	pwrite64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
+	pwrite(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
 
 static inline int btrfs_reset_dev_zone(int fd, struct blk_zone *zone)
 {
diff --git a/mkfs/main.c b/mkfs/main.c
index df091b16..08faf730 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -453,14 +453,14 @@ static int zero_output_file(int out_fd, u64 size)
 	/* Only zero out the first 1M */
 	loop_num = SZ_1M / SZ_4K;
 	for (i = 0; i < loop_num; i++) {
-		written = pwrite64(out_fd, buf, SZ_4K, location);
+		written = pwrite(out_fd, buf, SZ_4K, location);
 		if (written != SZ_4K)
 			ret = -EIO;
 		location += SZ_4K;
 	}
 
 	/* Then enlarge the file to size */
-	written = pwrite64(out_fd, buf, 1, size - 1);
+	written = pwrite(out_fd, buf, 1, size - 1);
 	if (written < 1)
 		ret = -EIO;
 	return ret;
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 2cf6eef9..1ddc1138 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -340,7 +340,7 @@ static int add_file_items(struct btrfs_trans_handle *trans,
 			goto end;
 		}
 
-		ret_read = pread64(fd, buffer, st->st_size, bytes_read);
+		ret_read = pread(fd, buffer, st->st_size, bytes_read);
 		if (ret_read == -1) {
 			error("cannot read %s at offset %llu length %llu: %m",
 				path_name, bytes_read, (unsigned long long)st->st_size);
@@ -386,7 +386,7 @@ again:
 
 		memset(eb->data, 0, sectorsize);
 
-		ret_read = pread64(fd, eb->data, sectorsize, file_pos +
+		ret_read = pread(fd, eb->data, sectorsize, file_pos +
 				   bytes_read);
 		if (ret_read == -1) {
 			error("cannot read %s at offset %llu length %u: %m",
@@ -929,7 +929,7 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
 	u64 new_size;
 	struct btrfs_device *device;
 	struct list_head *cur;
-	struct stat64 file_stat;
+	struct stat file_stat;
 	int nr_devs = 0;
 	int ret;
 
@@ -963,14 +963,14 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
 		*new_size_ret = new_size;
 
 	if (shrink_file_size) {
-		ret = fstat64(device->fd, &file_stat);
+		ret = fstat(device->fd, &file_stat);
 		if (ret < 0) {
 			error("failed to stat devid %llu: %m", device->devid);
 			return ret;
 		}
 		if (!S_ISREG(file_stat.st_mode))
 			return ret;
-		ret = ftruncate64(device->fd, new_size);
+		ret = ftruncate(device->fd, new_size);
 		if (ret < 0) {
 			error("failed to truncate device file of devid %llu: %m",
 				device->devid);
diff --git a/tests/fsstress.c b/tests/fsstress.c
index deea0d01..2411ea23 100644
--- a/tests/fsstress.c
+++ b/tests/fsstress.c
@@ -458,7 +458,7 @@ int	get_fname(int, long, pathname_t *, flist_t **, fent_t **, int *);
 void	init_pathname(pathname_t *);
 int	lchown_path(pathname_t *, uid_t, gid_t);
 int	link_path(pathname_t *, pathname_t *);
-int	lstat64_path(pathname_t *, struct stat64 *);
+int	lstat_path(pathname_t *, struct stat *);
 void	make_freq_table(void);
 int	mkdir_path(pathname_t *, mode_t);
 int	mknod_path(pathname_t *, mode_t, dev_t);
@@ -472,9 +472,9 @@ int	rename_path(pathname_t *, pathname_t *, int);
 int	rmdir_path(pathname_t *);
 void	separate_pathname(pathname_t *, char *, pathname_t *);
 void	show_ops(int, char *);
-int	stat64_path(pathname_t *, struct stat64 *);
+int	stat_path(pathname_t *, struct stat *);
 int	symlink_path(const char *, pathname_t *);
-int	truncate64_path(pathname_t *, off64_t);
+int	truncate_path(pathname_t *, off64_t);
 int	unlink_path(pathname_t *);
 void	usage(void);
 void	write_freq(void);
@@ -998,12 +998,12 @@ void
 check_cwd(void)
 {
 #ifdef DEBUG
-	struct stat64	statbuf;
+	struct stat	statbuf;
 	int ret;
 
-	ret = stat64(".", &statbuf);
+	ret = stat(".", &statbuf);
 	if (ret != 0) {
-		fprintf(stderr, "fsstress: check_cwd stat64() returned %d with errno: %d (%m)\n",
+		fprintf(stderr, "fsstress: check_cwd stat() returned %d with errno: %d (%m)\n",
 			ret, errno);
 		goto out;
 	}
@@ -1171,7 +1171,7 @@ again:
 void
 doproc(void)
 {
-	struct stat64	statbuf;
+	struct stat	statbuf;
 	char		buf[10];
 	char		cmd[64];
 	opnum_t		opno;
@@ -1182,7 +1182,7 @@ doproc(void)
 	dividend = (operations + execute_freq) / (execute_freq + 1);
 	sprintf(buf, "p%x", procid);
 	(void)mkdir(buf, 0777);
-	if (chdir(buf) < 0 || stat64(".", &statbuf) < 0) {
+	if (chdir(buf) < 0 || stat(".", &statbuf) < 0) {
 		perror(buf);
 		_exit(1);
 	}
@@ -1214,7 +1214,7 @@ doproc(void)
 		 * the forced shutdown happened.
 		 */
 		if (errtag != 0 && opno % 100 == 0)  {
-			rval = stat64(".", &statbuf);
+			rval = stat(".", &statbuf);
 			if (rval == EIO)  {
 				fprintf(stderr, "Detected EIO\n");
 				goto errout;
@@ -1537,18 +1537,18 @@ link_path(pathname_t *name1, pathname_t *name2)
 }
 
 int
-lstat64_path(pathname_t *name, struct stat64 *sbuf)
+lstat_path(pathname_t *name, struct stat *sbuf)
 {
 	char		buf[NAME_MAX + 1];
 	pathname_t	newname;
 	int		rval;
 
-	rval = lstat64(name->path, sbuf);
+	rval = lstat(name->path, sbuf);
 	if (rval >= 0 || errno != ENAMETOOLONG)
 		return rval;
 	separate_pathname(name, buf, &newname);
 	if (chdir(buf) == 0) {
-		rval = lstat64_path(&newname, sbuf);
+		rval = lstat_path(&newname, sbuf);
 		assert(chdir("..") == 0);
 	}
 	free_pathname(&newname);
@@ -1870,18 +1870,18 @@ show_ops(int flag, char *lead_str)
 }
 
 int
-stat64_path(pathname_t *name, struct stat64 *sbuf)
+stat_path(pathname_t *name, struct stat *sbuf)
 {
 	char		buf[NAME_MAX + 1];
 	pathname_t	newname;
 	int		rval;
 
-	rval = stat64(name->path, sbuf);
+	rval = stat(name->path, sbuf);
 	if (rval >= 0 || errno != ENAMETOOLONG)
 		return rval;
 	separate_pathname(name, buf, &newname);
 	if (chdir(buf) == 0) {
-		rval = stat64_path(&newname, sbuf);
+		rval = stat_path(&newname, sbuf);
 		assert(chdir("..") == 0);
 	}
 	free_pathname(&newname);
@@ -1913,18 +1913,18 @@ symlink_path(const char *name1, pathname_t *name)
 }
 
 int
-truncate64_path(pathname_t *name, off64_t length)
+truncate_path(pathname_t *name, off64_t length)
 {
 	char		buf[NAME_MAX + 1];
 	pathname_t	newname;
 	int		rval;
 
-	rval = truncate64(name->path, length);
+	rval = truncate(name->path, length);
 	if (rval >= 0 || errno != ENAMETOOLONG)
 		return rval;
 	separate_pathname(name, buf, &newname);
 	if (chdir(buf) == 0) {
-		rval = truncate64_path(&newname, length);
+		rval = truncate_path(&newname, length);
 		assert(chdir("..") == 0);
 	}
 	free_pathname(&newname);
@@ -2026,7 +2026,7 @@ non_btrfs_freq(const char *path)
 		ops[btrfs_ops[i]].freq = 0;
 }
 
-void inode_info(char *str, size_t sz, struct stat64 *s, int verbose)
+void inode_info(char *str, size_t sz, struct stat *s, int verbose)
 {
 	if (verbose)
 		snprintf(str, sz, "[%ld %ld %d %d %lld %lld]",
@@ -2101,7 +2101,7 @@ allocsp_f(opnum_t opno, long r)
 	struct xfs_flock64	fl;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 
@@ -2122,9 +2122,9 @@ allocsp_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: allocsp - fstat64 %s failed %d\n",
+			printf("%d/%lld: allocsp - fstat %s failed %d\n",
 				procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -2160,7 +2160,7 @@ do_aio_rw(opnum_t opno, long r, int flags)
 	size_t		len;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 	char		*dio_env;
@@ -2184,9 +2184,9 @@ do_aio_rw(opnum_t opno, long r, int flags)
 			       procid, opno, f.path, e);
 		goto aio_out;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: do_aio_rw - fstat64 %s failed %d\n",
+			printf("%d/%lld: do_aio_rw - fstat %s failed %d\n",
 			       procid, opno, f.path, errno);
 		goto aio_out;
 	}
@@ -2278,7 +2278,7 @@ do_uring_rw(opnum_t opno, long r, int flags)
 	size_t		len;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 	struct io_uring_sqe	*sqe;
@@ -2304,9 +2304,9 @@ do_uring_rw(opnum_t opno, long r, int flags)
 			       procid, opno, f.path, e);
 		goto uring_out;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: do_uring_rw - fstat64 %s failed %d\n",
+			printf("%d/%lld: do_uring_rw - fstat %s failed %d\n",
 			       procid, opno, f.path, errno);
 		goto uring_out;
 	}
@@ -2522,7 +2522,7 @@ bulkstat1_f(opnum_t opno, long r)
 	int		fd;
 	int		good;
 	__u64		ino;
-	struct stat64	s;
+	struct stat	s;
 	struct xfs_bstat	t;
 	int		v;
 	struct xfs_fsop_bulkreq bsr;
@@ -2534,7 +2534,7 @@ bulkstat1_f(opnum_t opno, long r)
 		init_pathname(&f);
 		if (!get_fname(FT_ANYm, r, &f, NULL, NULL, &v))
 			append_pathname(&f, ".");
-		ino = stat64_path(&f, &s) < 0 ? (ino64_t)r : s.st_ino;
+		ino = stat_path(&f, &s) < 0 ? (ino64_t)r : s.st_ino;
 		check_cwd();
 		free_pathname(&f);
 	} else {
@@ -2605,8 +2605,8 @@ clonerange_f(
 	struct file_clone_range	fcr;
 	struct pathname		fpath1;
 	struct pathname		fpath2;
-	struct stat64		stat1;
-	struct stat64		stat2;
+	struct stat		stat1;
+	struct stat		stat2;
 	char			inoinfo1[1024];
 	char			inoinfo2[1024];
 	off64_t			lr;
@@ -2660,17 +2660,17 @@ clonerange_f(
 	}
 
 	/* Get file stats */
-	if (fstat64(fd1, &stat1) < 0) {
+	if (fstat(fd1, &stat1) < 0) {
 		if (v1)
-			printf("%d/%lld: clonerange read - fstat64 %s failed %d\n",
+			printf("%d/%lld: clonerange read - fstat %s failed %d\n",
 				procid, opno, fpath1.path, errno);
 		goto out_fd2;
 	}
 	inode_info(inoinfo1, sizeof(inoinfo1), &stat1, v1);
 
-	if (fstat64(fd2, &stat2) < 0) {
+	if (fstat(fd2, &stat2) < 0) {
 		if (v2)
-			printf("%d/%lld: clonerange write - fstat64 %s failed %d\n",
+			printf("%d/%lld: clonerange write - fstat %s failed %d\n",
 				procid, opno, fpath2.path, errno);
 		goto out_fd2;
 	}
@@ -2743,8 +2743,8 @@ copyrange_f(
 #ifdef HAVE_COPY_FILE_RANGE
 	struct pathname		fpath1;
 	struct pathname		fpath2;
-	struct stat64		stat1;
-	struct stat64		stat2;
+	struct stat		stat1;
+	struct stat		stat2;
 	char			inoinfo1[1024];
 	char			inoinfo2[1024];
 	loff_t			lr;
@@ -2802,17 +2802,17 @@ copyrange_f(
 	}
 
 	/* Get file stats */
-	if (fstat64(fd1, &stat1) < 0) {
+	if (fstat(fd1, &stat1) < 0) {
 		if (v1)
-			printf("%d/%lld: copyrange read - fstat64 %s failed %d\n",
+			printf("%d/%lld: copyrange read - fstat %s failed %d\n",
 				procid, opno, fpath1.path, errno);
 		goto out_fd2;
 	}
 	inode_info(inoinfo1, sizeof(inoinfo1), &stat1, v1);
 
-	if (fstat64(fd2, &stat2) < 0) {
+	if (fstat(fd2, &stat2) < 0) {
 		if (v2)
-			printf("%d/%lld: copyrange write - fstat64 %s failed %d\n",
+			printf("%d/%lld: copyrange write - fstat %s failed %d\n",
 				procid, opno, fpath2.path, errno);
 		goto out_fd2;
 	}
@@ -2900,7 +2900,7 @@ deduperange_f(
 #define INFO_SZ			1024
 	struct file_dedupe_range *fdr;
 	struct pathname		*fpath;
-	struct stat64		*stat;
+	struct stat		*stat;
 	char			*info;
 	off64_t			*off;
 	int			*v;
@@ -2938,7 +2938,7 @@ deduperange_f(
 		goto out_fdr;
 	}
 
-	stat = calloc(nr, sizeof(struct stat64));
+	stat = calloc(nr, sizeof(struct stat));
 	if (!stat) {
 		printf("%d/%lld: line %d error %d\n",
 			procid, opno, __LINE__, errno);
@@ -3017,9 +3017,9 @@ deduperange_f(
 	}
 
 	/* Get file stats */
-	if (fstat64(fd[0], &stat[0]) < 0) {
+	if (fstat(fd[0], &stat[0]) < 0) {
 		if (v[0])
-			printf("%d/%lld: deduperange read - fstat64 %s failed %d\n",
+			printf("%d/%lld: deduperange read - fstat %s failed %d\n",
 				procid, opno, fpath[0].path, errno);
 		goto out_fds;
 	}
@@ -3027,9 +3027,9 @@ deduperange_f(
 	inode_info(&info[0], INFO_SZ, &stat[0], v[0]);
 
 	for (i = 1; i < nr; i++) {
-		if (fstat64(fd[i], &stat[i]) < 0) {
+		if (fstat(fd[i], &stat[i]) < 0) {
 			if (v[i])
-				printf("%d/%lld: deduperange write - fstat64 %s failed %d\n",
+				printf("%d/%lld: deduperange write - fstat %s failed %d\n",
 					procid, opno, fpath[i].path, errno);
 			goto out_fds;
 		}
@@ -3179,8 +3179,8 @@ splice_f(opnum_t opno, long r)
 {
 	struct pathname		fpath1;
 	struct pathname		fpath2;
-	struct stat64		stat1;
-	struct stat64		stat2;
+	struct stat		stat1;
+	struct stat		stat2;
 	char			inoinfo1[1024];
 	char			inoinfo2[1024];
 	loff_t			lr;
@@ -3237,17 +3237,17 @@ splice_f(opnum_t opno, long r)
 	}
 
 	/* Get file stats */
-	if (fstat64(fd1, &stat1) < 0) {
+	if (fstat(fd1, &stat1) < 0) {
 		if (v1)
-			printf("%d/%lld: splice read - fstat64 %s failed %d\n",
+			printf("%d/%lld: splice read - fstat %s failed %d\n",
 				procid, opno, fpath1.path, errno);
 		goto out_fd2;
 	}
 	inode_info(inoinfo1, sizeof(inoinfo1), &stat1, v1);
 
-	if (fstat64(fd2, &stat2) < 0) {
+	if (fstat(fd2, &stat2) < 0) {
 		if (v2)
-			printf("%d/%lld: splice write - fstat64 %s failed %d\n",
+			printf("%d/%lld: splice write - fstat %s failed %d\n",
 				procid, opno, fpath2.path, errno);
 		goto out_fd2;
 	}
@@ -3432,7 +3432,7 @@ dread_f(opnum_t opno, long r)
 	size_t		len;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 	char		*dio_env;
@@ -3454,9 +3454,9 @@ dread_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: dread - fstat64 %s failed %d\n",
+			printf("%d/%lld: dread - fstat %s failed %d\n",
 			       procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -3522,7 +3522,7 @@ dwrite_f(opnum_t opno, long r)
 	size_t		len;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 	char		*dio_env;
@@ -3544,9 +3544,9 @@ dwrite_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: dwrite - fstat64 %s failed %d\n",
+			printf("%d/%lld: dwrite - fstat %s failed %d\n",
 				procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -3620,7 +3620,7 @@ do_fallocate(opnum_t opno, long r, int mode)
 	int64_t		lr;
 	off64_t		off;
 	off64_t		len;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 
@@ -3640,9 +3640,9 @@ do_fallocate(opnum_t opno, long r, int mode)
 		return;
 	}
 	check_cwd();
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: do_fallocate - fstat64 %s failed %d\n",
+			printf("%d/%lld: do_fallocate - fstat %s failed %d\n",
 				procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -3734,7 +3734,7 @@ fiemap_f(opnum_t opno, long r)
 	int		fd;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 	int blocks_to_map;
@@ -3757,9 +3757,9 @@ fiemap_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: fiemap - fstat64 %s failed %d\n",
+			printf("%d/%lld: fiemap - fstat %s failed %d\n",
 				procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -3807,7 +3807,7 @@ freesp_f(opnum_t opno, long r)
 	struct xfs_flock64	fl;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 
@@ -3828,9 +3828,9 @@ freesp_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: freesp - fstat64 %s failed %d\n",
+			printf("%d/%lld: freesp - fstat %s failed %d\n",
 				procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -4226,7 +4226,7 @@ do_mmap(opnum_t opno, long r, int prot)
 	int64_t		lr;
 	off64_t		off;
 	int		flags;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 	sigjmp_buf	sigbus_jmpbuf;
@@ -4248,9 +4248,9 @@ do_mmap(opnum_t opno, long r, int prot)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: do_mmap - fstat64 %s failed %d\n",
+			printf("%d/%lld: do_mmap - fstat %s failed %d\n",
 			       procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -4370,7 +4370,7 @@ read_f(opnum_t opno, long r)
 	size_t		len;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 
@@ -4391,9 +4391,9 @@ read_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: read - fstat64 %s failed %d\n",
+			printf("%d/%lld: read - fstat %s failed %d\n",
 				procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -4454,7 +4454,7 @@ readv_f(opnum_t opno, long r)
 	size_t		len;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 	struct iovec	*iov = NULL;
@@ -4480,9 +4480,9 @@ readv_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: readv - fstat64 %s failed %d\n",
+			printf("%d/%lld: readv - fstat %s failed %d\n",
 				procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -4739,7 +4739,7 @@ resvsp_f(opnum_t opno, long r)
 	struct xfs_flock64	fl;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 
@@ -4760,9 +4760,9 @@ resvsp_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: resvsp - fstat64 %s failed %d\n",
+			printf("%d/%lld: resvsp - fstat %s failed %d\n",
 				procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -4971,7 +4971,7 @@ stat_f(opnum_t opno, long r)
 {
 	int		e;
 	pathname_t	f;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 
 	init_pathname(&f);
@@ -4981,7 +4981,7 @@ stat_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	e = lstat64_path(&f, &stb) < 0 ? errno : 0;
+	e = lstat_path(&f, &stb) < 0 ? errno : 0;
 	check_cwd();
 	if (v)
 		printf("%d/%lld: stat %s %d\n", procid, opno, f.path, e);
@@ -5133,7 +5133,7 @@ truncate_f(opnum_t opno, long r)
 	pathname_t	f;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 
@@ -5144,11 +5144,11 @@ truncate_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	e = stat64_path(&f, &stb) < 0 ? errno : 0;
+	e = stat_path(&f, &stb) < 0 ? errno : 0;
 	check_cwd();
 	if (e > 0) {
 		if (v)
-			printf("%d/%lld: truncate - stat64 %s failed %d\n",
+			printf("%d/%lld: truncate - stat %s failed %d\n",
 				procid, opno, f.path, e);
 		free_pathname(&f);
 		return;
@@ -5157,7 +5157,7 @@ truncate_f(opnum_t opno, long r)
 	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 	off %= maxfsize;
-	e = truncate64_path(&f, off) < 0 ? errno : 0;
+	e = truncate_path(&f, off) < 0 ? errno : 0;
 	check_cwd();
 	if (v)
 		printf("%d/%lld: truncate %s%s %lld %d\n", procid, opno, f.path,
@@ -5209,7 +5209,7 @@ unresvsp_f(opnum_t opno, long r)
 	struct xfs_flock64	fl;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 
@@ -5230,9 +5230,9 @@ unresvsp_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: unresvsp - fstat64 %s failed %d\n",
+			printf("%d/%lld: unresvsp - fstat %s failed %d\n",
 				procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -5281,7 +5281,7 @@ write_f(opnum_t opno, long r)
 	size_t		len;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 
@@ -5302,9 +5302,9 @@ write_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: write - fstat64 %s failed %d\n",
+			printf("%d/%lld: write - fstat %s failed %d\n",
 				procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
@@ -5337,7 +5337,7 @@ writev_f(opnum_t opno, long r)
 	size_t		len;
 	int64_t		lr;
 	off64_t		off;
-	struct stat64	stb;
+	struct stat	stb;
 	int		v;
 	char		st[1024];
 	struct iovec	*iov = NULL;
@@ -5363,9 +5363,9 @@ writev_f(opnum_t opno, long r)
 		free_pathname(&f);
 		return;
 	}
-	if (fstat64(fd, &stb) < 0) {
+	if (fstat(fd, &stb) < 0) {
 		if (v)
-			printf("%d/%lld: writev - fstat64 %s failed %d\n",
+			printf("%d/%lld: writev - fstat %s failed %d\n",
 				procid, opno, f.path, errno);
 		free_pathname(&f);
 		close(fd);
diff --git a/tests/fssum.c b/tests/fssum.c
index 2cba1891..e35c0274 100644
--- a/tests/fssum.c
+++ b/tests/fssum.c
@@ -519,9 +519,9 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 	int excl;
 	sum_file_data_t sum_file_data = flags[FLAG_STRUCTURE] ?
 			sum_file_data_strict : sum_file_data_permissive;
-	struct stat64 dir_st;
+	struct stat dir_st;
 
-	if (fstat64(dirfd, &dir_st)) {
+	if (fstat(dirfd, &dir_st)) {
 		perror("fstat");
 		exit(-1);
 	}
@@ -552,7 +552,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 	}
 	qsort(namelist, entries, sizeof(*namelist), namecmp);
 	for (i = 0; i < entries; ++i) {
-		struct stat64 st;
+		struct stat st;
 		sum_t cs;
 		sum_t meta;
 		char *path;
@@ -572,7 +572,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 			perror("fchdir");
 			exit(-1);
 		}
-		ret = lstat64(namelist[i], &st);
+		ret = lstat(namelist[i], &st);
 		if (ret) {
 			fprintf(stderr, "stat failed for %s/%s: %m\n",
 				path_prefix, path);
-- 
2.39.0

