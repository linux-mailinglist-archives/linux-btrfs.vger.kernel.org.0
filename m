Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1AA415E96
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 14:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbhIWMnV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 08:43:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60656 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241028AbhIWMnB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 08:43:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BADEB21E64;
        Thu, 23 Sep 2021 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632400888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Q4+0i6jDHrwreLKfCKcg9FGd2XAcAzEcPYYDj34hiwU=;
        b=HaaZ3bFvGSInKqDQGw8xW8jY4PLdBi3avYV4zcQbHYjejZIcKYUPP6B62BPEmfJy3nk1x8
        /KuOsSnTj1HcIovpmRz3sKrD3yWOQ7SY8HPPINQlGGxTQaZwnTw66fruAxoNG+dZzUENuV
        cpvy2aH63C3ckt4ix5FpNGCh00VqnQ0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86D0413CC2;
        Thu, 23 Sep 2021 12:41:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ICm3Hfh1TGHFLgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 23 Sep 2021 12:41:28 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: Remove support for BTRFS_SUBVOL_CREATE_ASYNC
Date:   Thu, 23 Sep 2021 15:41:27 +0300
Message-Id: <20210923124127.119119-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Kernel has removed support for this feature in 5.7 so let's remove
support from progs as well.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

This has been languishing on my local branch, let's merge it and be done with
it once for all.

 ioctl.h                                     |  4 +--
 libbtrfsutil/README.md                      | 14 ++------
 libbtrfsutil/btrfs.h                        |  4 +--
 libbtrfsutil/btrfsutil.h                    | 23 +++++--------
 libbtrfsutil/python/module.c                |  6 ++--
 libbtrfsutil/python/tests/test_subvolume.py | 12 ++-----
 libbtrfsutil/subvolume.c                    | 38 ++++++---------------
 7 files changed, 29 insertions(+), 72 deletions(-)

diff --git a/ioctl.h b/ioctl.h
index 5ce47c838b0e..aad3e9772908 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -49,15 +49,13 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);

 #define BTRFS_DEVICE_PATH_NAME_MAX 1024

-#define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)
 #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
 #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
 #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
 #define BTRFS_SUBVOL_SPEC_BY_ID		(1ULL << 4)

 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
-			(BTRFS_SUBVOL_CREATE_ASYNC |	\
-			BTRFS_SUBVOL_RDONLY |		\
+			(BTRFS_SUBVOL_RDONLY |		\
 			BTRFS_SUBVOL_QGROUP_INHERIT |	\
 			BTRFS_DEVICE_SPEC_BY_ID |	\
 			BTRFS_SUBVOL_SPEC_BY_ID)
diff --git a/libbtrfsutil/README.md b/libbtrfsutil/README.md
index d9194f5fd842..d20f33980500 100644
--- a/libbtrfsutil/README.md
+++ b/libbtrfsutil/README.md
@@ -245,8 +245,7 @@ The equivalent `btrfs-progs` command is `btrfs subvolume list`.
 #### Creation

 `btrfs_util_create_subvolume()` creates a new subvolume at the given path. The
-subvolume can be created asynchronously and inherit from quota groups
-(qgroups).
+subvolume can inherit from quota groups (qgroups).

 Qgroups to inherit are specified with a `struct btrfs_util_qgroup_inherit`,
 which is created by `btrfs_util_create_qgroup_inherit()` and freed by
@@ -262,10 +261,6 @@ method and a `groups` member, which is a list of ints.
 ```c
 btrfs_util_create_subvolume("/subvol2", 0, NULL, NULL);

-uint64_t async_transid;
-btrfs_util_create_subvolume("/subvol2", 0, &async_transid, NULL);
-btrfs_util_wait_sync("/", async_transid);
-
 struct btrfs_util_qgroup_inherit *qgroups;
 btrfs_util_create_qgroup_inherit(0, &qgroups);
 btrfs_util_qgroup_inherit_add_group(&qgroups, 256);
@@ -276,9 +271,6 @@ btrfs_util_destroy_qgroup_inherit(qgroups);
 ```python
 btrfsutil.create_subvolume('/subvol2')

-async_transid = btrfsutil.create_subvolume('/subvol2', async_=True)
-btrfsutil.wait_sync('/', async_transid)
-
 qgroups = btrfsutil.QgroupInherit()
 qgroups.add_group(256)
 btrfsutil.create_subvolume('/subvol2', qgroup_inherit=qgroups)
@@ -292,8 +284,8 @@ The equivalent `btrfs-progs` command is `btrfs subvolume create`.
 #### Snapshotting

 Snapshots are created with `btrfs_util_create_snapshot()`, which takes a source
-path, a destination path, and flags. It can also be asynchronous and inherit
-from quota groups; see [subvolume creation](#Creation).
+path, a destination path, and flags. It can also inherit from quota groups;
+see [subvolume creation](#Creation).

 Snapshot creation can be recursive, in which case subvolumes underneath the
 subvolume being snapshotted will also be snapshotted onto the same location in
diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index a31173623249..3388381f36a3 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -39,8 +39,7 @@ struct btrfs_ioctl_vol_args {
 #define BTRFS_SUBVOL_SPEC_BY_ID		(1ULL << 4)

 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
-			(BTRFS_SUBVOL_CREATE_ASYNC |	\
-			BTRFS_SUBVOL_RDONLY |		\
+			(BTRFS_SUBVOL_RDONLY |		\
 			BTRFS_SUBVOL_QGROUP_INHERIT |	\
 			BTRFS_DEVICE_SPEC_BY_ID |	\
 			BTRFS_SUBVOL_SPEC_BY_ID)
@@ -103,7 +102,6 @@ struct btrfs_ioctl_qgroup_limit_args {
  * - BTRFS_IOC_SUBVOL_GETFLAGS
  * - BTRFS_IOC_SUBVOL_SETFLAGS
  */
-#define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)
 #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
 #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)

diff --git a/libbtrfsutil/btrfsutil.h b/libbtrfsutil/btrfsutil.h
index ddd2a7b2ae73..fedd9832113f 100644
--- a/libbtrfsutil/btrfsutil.h
+++ b/libbtrfsutil/btrfsutil.h
@@ -366,16 +366,13 @@ struct btrfs_util_qgroup_inherit;
  * btrfs_util_create_subvolume() - Create a new subvolume.
  * @path: Where to create the subvolume.
  * @flags: Must be zero.
- * @async_transid: If not NULL, create the subvolume asynchronously (i.e.,
- * without waiting for it to commit it to disk) and return the transaction ID
- * that it was created in. This transaction ID can be waited on with
- * btrfs_util_wait_sync().
+ * @unused: No longer used
  * @qgroup_inherit: Qgroups to inherit from, or NULL.
  *
  * Return: %BTRFS_UTIL_OK on success, non-zero error code on failure.
  */
 enum btrfs_util_error btrfs_util_create_subvolume(const char *path, int flags,
-						  uint64_t *async_transid,
+						  uint64_t *unused,
 						  struct btrfs_util_qgroup_inherit *qgroup_inherit);

 /**
@@ -385,7 +382,7 @@ enum btrfs_util_error btrfs_util_create_subvolume(const char *path, int flags,
  * should be created.
  * @name: Name of the subvolume to create.
  * @flags: See btrfs_util_create_subvolume().
- * @async_transid: See btrfs_util_create_subvolume().
+ * @unused: See btrfs_util_create_subvolume().
  * @qgroup_inherit: See btrfs_util_create_subvolume().
  *
  * Return: %BTRFS_UTIL_OK on success, non-zero error code on failure.
@@ -393,7 +390,7 @@ enum btrfs_util_error btrfs_util_create_subvolume(const char *path, int flags,
 enum btrfs_util_error btrfs_util_create_subvolume_fd(int parent_fd,
 						     const char *name,
 						     int flags,
-						     uint64_t *async_transid,
+						     uint64_t *unused,
 						     struct btrfs_util_qgroup_inherit *qgroup_inherit);

 /**
@@ -418,16 +415,14 @@ enum btrfs_util_error btrfs_util_create_subvolume_fd(int parent_fd,
  * @source: Path of the existing subvolume to snapshot.
  * @path: Where to create the snapshot.
  * @flags: Bitmask of BTRFS_UTIL_CREATE_SNAPSHOT_* flags.
- * @async_transid: See btrfs_util_create_subvolume(). If
- * %BTRFS_UTIL_CREATE_SNAPSHOT_RECURSIVE was in @flags, then this will contain
- * the largest transaction ID of all created subvolumes.
+ * @unused: See btrfs_util_create_subvolume().
  * @qgroup_inherit: See btrfs_util_create_subvolume().
  *
  * Return: %BTRFS_UTIL_OK on success, non-zero error code on failure.
  */
 enum btrfs_util_error btrfs_util_create_snapshot(const char *source,
 						 const char *path, int flags,
-						 uint64_t *async_transid,
+						 uint64_t *unused,
 						 struct btrfs_util_qgroup_inherit *qgroup_inherit);

 /**
@@ -435,7 +430,7 @@ enum btrfs_util_error btrfs_util_create_snapshot(const char *source,
  */
 enum btrfs_util_error btrfs_util_create_snapshot_fd(int fd, const char *path,
 						    int flags,
-						    uint64_t *async_transid,
+						    uint64_t *unused,
 						    struct btrfs_util_qgroup_inherit *qgroup_inherit);

 /**
@@ -446,13 +441,13 @@ enum btrfs_util_error btrfs_util_create_snapshot_fd(int fd, const char *path,
  * be created.
  * @name: Name of the snapshot to create.
  * @flags: See btrfs_util_create_snapshot().
- * @async_transid: See btrfs_util_create_snapshot().
+ * @unused: See btrfs_util_create_snapshot().
  * @qgroup_inherit: See btrfs_util_create_snapshot().
  */
 enum btrfs_util_error btrfs_util_create_snapshot_fd2(int fd, int parent_fd,
 						     const char *name,
 						     int flags,
-						     uint64_t *async_transid,
+						     uint64_t *unused,
 						     struct btrfs_util_qgroup_inherit *qgroup_inherit);

 /**
diff --git a/libbtrfsutil/python/module.c b/libbtrfsutil/python/module.c
index 729f76db23f1..2657ee289f6f 100644
--- a/libbtrfsutil/python/module.c
+++ b/libbtrfsutil/python/module.c
@@ -237,8 +237,7 @@ static PyMethodDef btrfsutil_methods[] = {
 	 "Create a new subvolume.\n\n"
 	 "Arguments:\n"
 	 "path -- string, bytes, or path-like object\n"
-	 "async_ -- create the subvolume without waiting for it to commit to\n"
-	 "disk and return the transaction ID\n"
+	 "async_ -- no longer used\n"
 	 "qgroup_inherit -- optional QgroupInherit object of qgroups to\n"
 	 "inherit from"},
 	{"create_snapshot", (PyCFunction)create_snapshot,
@@ -251,8 +250,7 @@ static PyMethodDef btrfsutil_methods[] = {
 	 "path -- string, bytes, or path-like object\n"
 	 "recursive -- also snapshot child subvolumes\n"
 	 "read_only -- create a read-only snapshot\n"
-	 "async_ -- create the subvolume without waiting for it to commit to\n"
-	 "disk and return the transaction ID\n"
+	 "async_ -- no longer used\n"
 	 "qgroup_inherit -- optional QgroupInherit object of qgroups to\n"
 	 "inherit from"},
 	{"delete_subvolume", (PyCFunction)delete_subvolume,
diff --git a/libbtrfsutil/python/tests/test_subvolume.py b/libbtrfsutil/python/tests/test_subvolume.py
index 2620b5c5cfde..690ff107680d 100644
--- a/libbtrfsutil/python/tests/test_subvolume.py
+++ b/libbtrfsutil/python/tests/test_subvolume.py
@@ -245,10 +245,6 @@ from tests import (
         btrfsutil.create_subvolume(subvol + '6//')
         self.assertTrue(btrfsutil.is_subvolume(subvol + '6'))

-        transid = btrfsutil.create_subvolume(subvol + '7', async_=True)
-        self.assertTrue(btrfsutil.is_subvolume(subvol + '7'))
-        self.assertGreater(transid, 0)
-
         # Test creating subvolumes under '/' in a chroot.
         pid = os.fork()
         if pid == 0:
@@ -308,12 +304,8 @@ from tests import (
         btrfsutil.create_snapshot(subvol, snapshot + '2', recursive=True)
         self.assertTrue(os.path.exists(os.path.join(snapshot + '2', 'nested/more_nested/nested_dir')))

-        transid = btrfsutil.create_snapshot(subvol, snapshot + '3', recursive=True, async_=True)
-        self.assertTrue(os.path.exists(os.path.join(snapshot + '3', 'nested/more_nested/nested_dir')))
-        self.assertGreater(transid, 0)
-
-        btrfsutil.create_snapshot(subvol, snapshot + '4', read_only=True)
-        self.assertTrue(btrfsutil.get_subvolume_read_only(snapshot + '4'))
+        btrfsutil.create_snapshot(subvol, snapshot + '3', read_only=True)
+        self.assertTrue(btrfsutil.get_subvolume_read_only(snapshot + '3'))

     def test_delete_subvolume(self):
         subvol = os.path.join(self.mountpoint, 'subvol')
diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
index 32086b7fcc7a..deff6de7c84e 100644
--- a/libbtrfsutil/subvolume.c
+++ b/libbtrfsutil/subvolume.c
@@ -683,7 +683,7 @@ static enum btrfs_util_error openat_parent_and_name(int dirfd, const char *path,

 PUBLIC enum btrfs_util_error btrfs_util_create_subvolume(const char *path,
 							 int flags,
-							 uint64_t *async_transid,
+							 uint64_t *unused,
 							 struct btrfs_util_qgroup_inherit *qgroup_inherit)
 {
 	char name[BTRFS_SUBVOL_NAME_MAX + 1];
@@ -696,7 +696,7 @@ PUBLIC enum btrfs_util_error btrfs_util_create_subvolume(const char *path,
 		return err;

 	err = btrfs_util_create_subvolume_fd(parent_fd, name, flags,
-					    async_transid, qgroup_inherit);
+					    unused, qgroup_inherit);
 	SAVE_ERRNO_AND_CLOSE(parent_fd);
 	return err;
 }
@@ -704,7 +704,7 @@ PUBLIC enum btrfs_util_error btrfs_util_create_subvolume(const char *path,
 PUBLIC enum btrfs_util_error btrfs_util_create_subvolume_fd(int parent_fd,
 							    const char *name,
 							    int flags,
-							    uint64_t *async_transid,
+							    uint64_t *unused,
 							    struct btrfs_util_qgroup_inherit *qgroup_inherit)
 {
 	struct btrfs_ioctl_vol_args_v2 args = {};
@@ -716,8 +716,6 @@ PUBLIC enum btrfs_util_error btrfs_util_create_subvolume_fd(int parent_fd,
 		return BTRFS_UTIL_ERROR_INVALID_ARGUMENT;
 	}

-	if (async_transid)
-		args.flags |= BTRFS_SUBVOL_CREATE_ASYNC;
 	if (qgroup_inherit) {
 		args.flags |= BTRFS_SUBVOL_QGROUP_INHERIT;
 		args.qgroup_inherit = (struct btrfs_qgroup_inherit *)qgroup_inherit;
@@ -738,9 +736,6 @@ PUBLIC enum btrfs_util_error btrfs_util_create_subvolume_fd(int parent_fd,
 	if (ret == -1)
 		return BTRFS_UTIL_ERROR_SUBVOL_CREATE_FAILED;

-	if (async_transid)
-		*async_transid = args.transid;
-
 	return BTRFS_UTIL_OK;
 }

@@ -1022,8 +1017,7 @@ PUBLIC enum btrfs_util_error btrfs_util_create_subvolume_iterator_fd(int fd,
 }

 static enum btrfs_util_error snapshot_subvolume_children(int fd, int parent_fd,
-							 const char *name,
-							 uint64_t *async_transid)
+							 const char *name)
 {
 	struct btrfs_util_subvolume_iterator *iter;
 	enum btrfs_util_error err;
@@ -1041,7 +1035,6 @@ static enum btrfs_util_error snapshot_subvolume_children(int fd, int parent_fd,
 		char child_name[BTRFS_SUBVOL_NAME_MAX + 1];
 		char *child_path;
 		int child_fd, new_parent_fd;
-		uint64_t tmp_transid;

 		err = btrfs_util_subvolume_iterator_next(iter, &child_path,
 							 NULL);
@@ -1076,14 +1069,11 @@ static enum btrfs_util_error snapshot_subvolume_children(int fd, int parent_fd,

 		err = btrfs_util_create_snapshot_fd2(child_fd, new_parent_fd,
 						     child_name, 0,
-						     async_transid ? &tmp_transid : NULL,
-						     NULL);
+						     NULL, NULL);
 		SAVE_ERRNO_AND_CLOSE(child_fd);
 		SAVE_ERRNO_AND_CLOSE(new_parent_fd);
 		if (err)
 			break;
-		if (async_transid && tmp_transid > *async_transid)
-			*async_transid = tmp_transid;
 	}

 	btrfs_util_destroy_subvolume_iterator(iter);
@@ -1095,7 +1085,7 @@ static enum btrfs_util_error snapshot_subvolume_children(int fd, int parent_fd,
 PUBLIC enum btrfs_util_error btrfs_util_create_snapshot(const char *source,
 							const char *path,
 							int flags,
-							uint64_t *async_transid,
+							uint64_t *unused,
 							struct btrfs_util_qgroup_inherit *qgroup_inherit)
 {
 	enum btrfs_util_error err;
@@ -1105,7 +1095,7 @@ PUBLIC enum btrfs_util_error btrfs_util_create_snapshot(const char *source,
 	if (fd == -1)
 		return BTRFS_UTIL_ERROR_OPEN_FAILED;

-	err = btrfs_util_create_snapshot_fd(fd, path, flags, async_transid,
+	err = btrfs_util_create_snapshot_fd(fd, path, flags, unused,
 					    qgroup_inherit);
 	SAVE_ERRNO_AND_CLOSE(fd);
 	return err;
@@ -1114,7 +1104,7 @@ PUBLIC enum btrfs_util_error btrfs_util_create_snapshot(const char *source,
 PUBLIC enum btrfs_util_error btrfs_util_create_snapshot_fd(int fd,
 							   const char *path,
 							   int flags,
-							   uint64_t *async_transid,
+							   uint64_t *unused,
 							   struct btrfs_util_qgroup_inherit *qgroup_inherit)
 {
 	char name[BTRFS_SUBVOL_NAME_MAX + 1];
@@ -1127,7 +1117,7 @@ PUBLIC enum btrfs_util_error btrfs_util_create_snapshot_fd(int fd,
 		return err;

 	err = btrfs_util_create_snapshot_fd2(fd, parent_fd, name, flags,
-					     async_transid, qgroup_inherit);
+					     unused, qgroup_inherit);
 	SAVE_ERRNO_AND_CLOSE(parent_fd);
 	return err;
 }
@@ -1136,7 +1126,7 @@ PUBLIC enum btrfs_util_error btrfs_util_create_snapshot_fd2(int fd,
 							    int parent_fd,
 							    const char *name,
 							    int flags,
-							    uint64_t *async_transid,
+							    uint64_t *unused,
 							    struct btrfs_util_qgroup_inherit *qgroup_inherit)
 {
 	struct btrfs_ioctl_vol_args_v2 args = {.fd = fd};
@@ -1153,8 +1143,6 @@ PUBLIC enum btrfs_util_error btrfs_util_create_snapshot_fd2(int fd,

 	if (flags & BTRFS_UTIL_CREATE_SNAPSHOT_READ_ONLY)
 		args.flags |= BTRFS_SUBVOL_RDONLY;
-	if (async_transid)
-		args.flags |= BTRFS_SUBVOL_CREATE_ASYNC;
 	if (qgroup_inherit) {
 		args.flags |= BTRFS_SUBVOL_QGROUP_INHERIT;
 		args.qgroup_inherit = (struct btrfs_qgroup_inherit *)qgroup_inherit;
@@ -1175,12 +1163,8 @@ PUBLIC enum btrfs_util_error btrfs_util_create_snapshot_fd2(int fd,
 	if (ret == -1)
 		return BTRFS_UTIL_ERROR_SUBVOL_CREATE_FAILED;

-	if (async_transid)
-		*async_transid = args.transid;
-
 	if (flags & BTRFS_UTIL_CREATE_SNAPSHOT_RECURSIVE) {
-		err = snapshot_subvolume_children(fd, parent_fd, name,
-						  async_transid);
+		err = snapshot_subvolume_children(fd, parent_fd, name);
 		if (err)
 			return err;
 	}
--
2.25.1

