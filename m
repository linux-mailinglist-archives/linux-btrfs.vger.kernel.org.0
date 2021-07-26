Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1D3D5790
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhGZJtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233301AbhGZJtM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:49:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1460D60F55;
        Mon, 26 Jul 2021 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295381;
        bh=ReToYCrsnCgSWTrMplKLrE2gqkmqzKErsjrW+xTUPR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDFg3ySg5L1JG7j6GPZxeQly/lExzj9hT+9xNGE77ifNn36VWfT9vgb+Gr0U2QJjs
         qEvQwwJI62Fut8Qrkj6fRHQ7R51bdOPARmSBcdm+1PxY2JsDPCAmY0jyawHnoR3Pva
         CpCxWm7J1PtEgRY9VBNx7CNdqzjSEJdI0MVayu3yTzOmVB3OWlXx1uFWd7rc10/T/B
         gHrLQW1BD3JvXfqOCenfOwo51Sxa5jyrblM9uJ1CGKGMP4LV+mKv37Dxq37K/QHAZl
         +a6Va1v3V/j6T21vzxXQhP3YXCFDqher1XRLUGjupfVKGB+UD+EUIVKprx4Br4zr4S
         I6pyOGDNMRnHw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
Subject: [PATCH v3 21/21] btrfs/242: introduce btrfs specific idmapped mounts tests
Date:   Mon, 26 Jul 2021 12:28:16 +0200
Message-Id: <20210726102816.612434-22-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=108495; h=from:subject; bh=gf9TN45jPrzDKsOVXJ+IRei/n8LwQ8qGtG038Z67Vn8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zP7vHLL9dhQp8CrrNoXS6PMuRc4ru9JfJx56+xS7xiT hRJxHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP50MPIsOfvnpB55emBYeU7qnh23b RMNnZY6t/KfMFbLMvp19TetQx/uGJL9bUXOK45XRhy+/ti3qM6Pm/itwf/1gjdrtsTZyDDCAA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

While core vfs functionality that btrfs implements is completely covered
by the generic test-suite the btrfs specific ioctls are not.
This patch expands the test-suite to cover btrfs specific ioctls that
are have required changes to work on idmapped mounts. We deliberately
don't use the libbtrfsutil library as we need to know exactly what
ioctl's are issued and we need to be in control of all privileges at all
times. This test-suite currently tests:
- BTRFS_IOC_{SNAP,SUBVOL}_CREATE_V2
  - subvolume creation on idmapped mounts where the fsids do have a
    mapping in the superblock
  - snapshot creation on idmapped mounts where the fsids do have a
    mapping in the superblock
  - subvolume creation on idmapped mounts where the fsids do not have a
    mapping in the superblock
  - snapshot creation on idmapped mounts where the fsids do not have
    a mapping in the superblock
  - subvolume creation on idmapped mounts where the caller is
    located in a user namespace and the fsids do have a mapping
    in the superblock
  - snapshot creation on idmapped mounts where the caller is located
    in a user namespace and the fsids do have a mapping in the
    superblock
  - subvolume creation on idmapped mounts where the caller is
    located in a user namespace and the fsids do not have a mapping
    in the superblock
  - snapshot creation on idmapped mounts where the caller is located
    in a user namespace and the fsids do not have a mapping in the
    superblock

- BTRFS_IOC_SNAP_DESTROY_V2
  - subvolume deletion on idmapped mounts where the fsids do have a
    mapping in the superblock
  - snapshot deletion on idmapped mounts where the fsids do have a
    mapping in the superblock
  - subvolume deletion on idmapped mounts where the fsids do not have a
    mapping in the superblock
  - snapshot deletion on idmapped mounts where the fsids do not have
    a mapping in the superblock
  - subvolume deletion on idmapped mounts where the caller is
    located in a user namespace and the fsids do have a mapping
    in the superblock
  - snapshot deletion on idmapped mounts where the caller is located
    in a user namespace and the fsids do have a mapping in the
    superblock
  - subvolume deletion on idmapped mounts where the caller is
    located in a user namespace and the fsids do not have a mapping
    in the superblock
  - snapshot deletion on idmapped mounts where the caller is located
    in a user namespace and the fsids do not have a mapping in the
    superblock
  - unprivileged subvolume deletion on idmapped mounts where the fsids
    do have a mapping in the superblock and the filesystem is mounted
    with "user_subvol_rm_allowed"
  - unprivileged snapshot deletion on idmapped mounts where the fsids do
    have a mapping in the superblock and the filesystem is mounted with
    "user_subvol_rm_allowed"
  - subvolume deletion on idmapped mounts where the caller is
    located in a user namespace and the fsids do have a mapping
    in the superblock and the filesystem is mounted with
    "user_subvol_rm_allowed"
  - snapshot deletion on idmapped mounts where the caller is located
    in a user namespace and the fsids do have a mapping in the
    superblock and the filesystem is mounted with
    "user_subvol_rm_allowed"

- BTRFS_IOC_SUBVOL_SETFLAGS
  - subvolume flags on idmapped mounts where the fsids do have a mapping
    in the superblock
  - snapshot flags on idmapped mounts where the fsids do have a mapping
    in the superblock
  - subvolume flags on idmapped mounts where the fsids do not have a
    mapping in the superblock
  - snapshot flags on idmapped mounts where the fsids do not have a
    mapping in the superblock
  - subvolume flags on idmapped mounts where the caller is located in a
    user namespace and the fsids do have a mapping in the superblock
  - snapshot flags on idmapped mounts where the caller is located in a
    user namespace and the fsids do have a mapping in the superblock
  - subvolume flags on idmapped mounts where the caller is located in a
    user namespace and the fsids do not have a mapping in the superblock
  - snapshot flags on idmapped mounts where the caller is located in a
    user namespace and the fsids do not have a mapping in the superblock

- BTRFS_IOC_INO_LOOKUP_USER
  - subvolume lookup on idmapped mounts where the fsids do have a mapping
    in the superblock
  - subvolume lookup on idmapped mounts where the fsids do not have a
    mapping in the superblock
  - subvolume lookup on idmapped mounts where the caller is located in a
    user namespace and the fsids do have a mapping in the superblock
  - subvolume lookup on idmapped mounts where the caller is located in a
    user namespace and the fsids do not have a mapping in the superblock

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - When trying to delete a subvolume or snapshot by its id on idmapped
    mounts the returned error code has changed from -EINVAL to
    -EOPNOTSUPP. Account for that in the tests.
---
 src/idmapped-mounts/idmapped-mounts.c | 3693 ++++++++++++++++++++++++-
 tests/btrfs/242                       |   34 +
 tests/btrfs/242.out                   |    2 +
 3 files changed, 3719 insertions(+), 10 deletions(-)
 create mode 100755 tests/btrfs/242
 create mode 100644 tests/btrfs/242.out

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index f155e0b4..c5a4aaa0 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -11,6 +11,8 @@
 #include <getopt.h>
 #include <grp.h>
 #include <limits.h>
+#include <linux/btrfs.h>
+#include <linux/btrfs_tree.h>
 #include <linux/limits.h>
 #include <linux/types.h>
 #include <pthread.h>
@@ -91,12 +93,21 @@ const char *t_fstype;
 /* path of the test device */
 const char *t_device;
 
+/* path of the test scratch device */
+const char *t_device_scratch;
+
 /* mountpoint of the test device */
 const char *t_mountpoint;
 
+/* mountpoint of the test device */
+const char *t_mountpoint_scratch;
+
 /* fd for @t_mountpoint */
 int t_mnt_fd;
 
+/* fd for @t_mountpoint_scratch */
+int t_mnt_scratch_fd;
+
 /* fd for @T_DIR1 */
 int t_dir1_fd;
 
@@ -9520,6 +9531,3622 @@ out:
 	return fret;
 }
 
+static int btrfs_delete_subvolume(int parent_fd, const char *name)
+{
+	struct btrfs_ioctl_vol_args args = {};
+	size_t len;
+	int ret;
+
+	len = strlen(name);
+	if (len >= sizeof(args.name))
+		return -ENAMETOOLONG;
+
+	memcpy(args.name, name, len);
+	args.name[len] = '\0';
+
+	ret = ioctl(parent_fd, BTRFS_IOC_SNAP_DESTROY, &args);
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
+static int btrfs_delete_subvolume_id(int parent_fd, uint64_t subvolid)
+{
+	struct btrfs_ioctl_vol_args_v2 args = {};
+	int ret;
+
+	args.flags = BTRFS_SUBVOL_SPEC_BY_ID;
+	args.subvolid = subvolid;
+
+	ret = ioctl(parent_fd, BTRFS_IOC_SNAP_DESTROY_V2, &args);
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
+static int btrfs_create_subvolume(int parent_fd, const char *name)
+{
+	struct btrfs_ioctl_vol_args_v2 args = {};
+	size_t len;
+	int ret;
+
+	len = strlen(name);
+	if (len >= sizeof(args.name))
+		return -ENAMETOOLONG;
+
+	memcpy(args.name, name, len);
+	args.name[len] = '\0';
+
+	ret = ioctl(parent_fd, BTRFS_IOC_SUBVOL_CREATE_V2, &args);
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
+static int btrfs_create_snapshot(int fd, int parent_fd, const char *name,
+				 int flags)
+{
+	struct btrfs_ioctl_vol_args_v2 args = {
+		.fd = fd,
+	};
+	size_t len;
+	int ret;
+
+	if (flags & ~BTRFS_SUBVOL_RDONLY)
+		return -EINVAL;
+
+	len = strlen(name);
+	if (len >= sizeof(args.name))
+		return -ENAMETOOLONG;
+	memcpy(args.name, name, len);
+	args.name[len] = '\0';
+
+	if (flags & BTRFS_SUBVOL_RDONLY)
+		args.flags |= BTRFS_SUBVOL_RDONLY;
+	ret = ioctl(parent_fd, BTRFS_IOC_SNAP_CREATE_V2, &args);
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
+static int btrfs_get_subvolume_ro(int fd, bool *read_only_ret)
+{
+	uint64_t flags;
+	int ret;
+
+	ret = ioctl(fd, BTRFS_IOC_SUBVOL_GETFLAGS, &flags);
+	if (ret < 0)
+		return -1;
+
+	*read_only_ret = flags & BTRFS_SUBVOL_RDONLY;
+	return 0;
+}
+
+static int btrfs_set_subvolume_ro(int fd, bool read_only)
+{
+	uint64_t flags;
+	int ret;
+
+	ret = ioctl(fd, BTRFS_IOC_SUBVOL_GETFLAGS, &flags);
+	if (ret < 0)
+		return -1;
+
+	if (read_only)
+		flags |= BTRFS_SUBVOL_RDONLY;
+	else
+		flags &= ~BTRFS_SUBVOL_RDONLY;
+
+	ret = ioctl(fd, BTRFS_IOC_SUBVOL_SETFLAGS, &flags);
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
+static int btrfs_get_subvolume_id(int fd, uint64_t *id_ret)
+{
+	struct btrfs_ioctl_ino_lookup_args args = {
+	    .treeid = 0,
+	    .objectid = BTRFS_FIRST_FREE_OBJECTID,
+	};
+	int ret;
+
+	ret = ioctl(fd, BTRFS_IOC_INO_LOOKUP, &args);
+	if (ret < 0)
+		return -1;
+
+	*id_ret = args.treeid;
+
+	return 0;
+}
+
+/*
+ * The following helpers are adapted from the btrfsutils library. We can't use
+ * the library directly since we need full control over how the subvolume
+ * iteration happens. We need to be able to check whether unprivileged
+ * subvolume iteration is possible, i.e. whether BTRFS_IOC_INO_LOOKUP_USER is
+ * available and also ensure that it is actually used when looking up paths.
+ */
+struct btrfs_stack {
+	uint64_t tree_id;
+	struct btrfs_ioctl_get_subvol_rootref_args rootref_args;
+	size_t items_pos;
+	size_t path_len;
+};
+
+struct btrfs_iter {
+	int fd;
+	int cur_fd;
+
+	struct btrfs_stack *search_stack;
+	size_t stack_len;
+	size_t stack_capacity;
+
+	char *cur_path;
+	size_t cur_path_capacity;
+};
+
+static struct btrfs_stack *top_stack_entry(struct btrfs_iter *iter)
+{
+	return &iter->search_stack[iter->stack_len - 1];
+}
+
+static int pop_stack(struct btrfs_iter *iter)
+{
+	struct btrfs_stack *top, *parent;
+	int fd, parent_fd;
+	size_t i;
+
+	if (iter->stack_len == 1) {
+		iter->stack_len--;
+		return 0;
+	}
+
+	top = top_stack_entry(iter);
+	iter->stack_len--;
+	parent = top_stack_entry(iter);
+
+	fd = iter->cur_fd;
+	for (i = parent->path_len; i < top->path_len; i++) {
+		if (i == 0 || iter->cur_path[i] == '/') {
+			parent_fd = openat(fd, "..", O_RDONLY);
+			if (fd != iter->cur_fd)
+				close(fd);
+			if (parent_fd == -1)
+				return -1;
+			fd = parent_fd;
+		}
+	}
+	if (iter->cur_fd != iter->fd)
+		close(iter->cur_fd);
+	iter->cur_fd = fd;
+
+	return 0;
+}
+
+static int append_stack(struct btrfs_iter *iter, uint64_t tree_id, size_t path_len)
+{
+	struct btrfs_stack *entry;
+
+	if (iter->stack_len >= iter->stack_capacity) {
+		size_t new_capacity = iter->stack_capacity * 2;
+		struct btrfs_stack *new_search_stack;
+
+		new_search_stack = reallocarray(iter->search_stack, new_capacity,
+						sizeof(*iter->search_stack));
+		if (!new_search_stack)
+			return -ENOMEM;
+
+		iter->stack_capacity = new_capacity;
+		iter->search_stack = new_search_stack;
+	}
+
+	entry = &iter->search_stack[iter->stack_len];
+
+	memset(entry, 0, sizeof(*entry));
+	entry->path_len = path_len;
+	entry->tree_id = tree_id;
+
+	if (iter->stack_len) {
+		struct btrfs_stack *top;
+		char *path;
+		int fd;
+
+		top = top_stack_entry(iter);
+		path = &iter->cur_path[top->path_len];
+		if (*path == '/')
+			path++;
+		fd = openat(iter->cur_fd, path, O_RDONLY);
+		if (fd == -1)
+			return -errno;
+
+		close(iter->cur_fd);
+		iter->cur_fd = fd;
+	}
+
+	iter->stack_len++;
+
+	return 0;
+}
+
+static int btrfs_iterator_start(int fd, uint64_t top, struct btrfs_iter **ret)
+{
+	struct btrfs_iter *iter;
+	int err;
+
+	iter = malloc(sizeof(*iter));
+	if (!iter)
+		return -ENOMEM;
+
+	iter->fd = fd;
+	iter->cur_fd = fd;
+
+	iter->stack_len = 0;
+	iter->stack_capacity = 4;
+	iter->search_stack = malloc(sizeof(*iter->search_stack) *
+				    iter->stack_capacity);
+	if (!iter->search_stack) {
+		err = -ENOMEM;
+		goto out_iter;
+	}
+
+	iter->cur_path_capacity = 256;
+	iter->cur_path = malloc(iter->cur_path_capacity);
+	if (!iter->cur_path) {
+		err = -ENOMEM;
+		goto out_search_stack;
+	}
+
+	err = append_stack(iter, top, 0);
+	if (err)
+		goto out_cur_path;
+
+	*ret = iter;
+
+	return 0;
+
+out_cur_path:
+	free(iter->cur_path);
+out_search_stack:
+	free(iter->search_stack);
+out_iter:
+	free(iter);
+	return err;
+}
+
+static void btrfs_iterator_end(struct btrfs_iter *iter)
+{
+	if (iter) {
+		free(iter->cur_path);
+		free(iter->search_stack);
+		if (iter->cur_fd != iter->fd)
+			close(iter->cur_fd);
+		close(iter->fd);
+		free(iter);
+	}
+}
+
+static int __append_path(struct btrfs_iter *iter, const char *name,
+			 size_t name_len, const char *dir, size_t dir_len,
+			 size_t *path_len_ret)
+{
+	struct btrfs_stack *top = top_stack_entry(iter);
+	size_t path_len;
+	char *p;
+
+	path_len = top->path_len;
+	/*
+	 * We need a joining slash if we have a current path and a subdirectory.
+	 */
+	if (top->path_len && dir_len)
+		path_len++;
+	path_len += dir_len;
+	/*
+	 * We need another joining slash if we have a current path and a name,
+	 * but not if we have a subdirectory, because the lookup ioctl includes
+	 * a trailing slash.
+	 */
+	if (top->path_len && !dir_len && name_len)
+		path_len++;
+	path_len += name_len;
+
+	/* We need one extra character for the NUL terminator. */
+	if (path_len + 1 > iter->cur_path_capacity) {
+		char *tmp = realloc(iter->cur_path, path_len + 1);
+
+		if (!tmp)
+			return -ENOMEM;
+		iter->cur_path = tmp;
+		iter->cur_path_capacity = path_len + 1;
+	}
+
+	p = iter->cur_path + top->path_len;
+	if (top->path_len && dir_len)
+		*p++ = '/';
+	memcpy(p, dir, dir_len);
+	p += dir_len;
+	if (top->path_len && !dir_len && name_len)
+		*p++ = '/';
+	memcpy(p, name, name_len);
+	p += name_len;
+	*p = '\0';
+
+	*path_len_ret = path_len;
+
+	return 0;
+}
+
+static int get_subvolume_path(struct btrfs_iter *iter, uint64_t treeid,
+			      uint64_t dirid, size_t *path_len_ret)
+{
+	struct btrfs_ioctl_ino_lookup_user_args args = {
+		.treeid = treeid,
+		.dirid = dirid,
+	};
+	int ret;
+
+	ret = ioctl(iter->cur_fd, BTRFS_IOC_INO_LOOKUP_USER, &args);
+	if (ret == -1)
+		return -1;
+
+	return __append_path(iter, args.name, strlen(args.name), args.path,
+			     strlen(args.path), path_len_ret);
+}
+
+static int btrfs_iterator_next(struct btrfs_iter *iter, char **path_ret,
+			       uint64_t *id_ret)
+{
+	struct btrfs_stack *top;
+	uint64_t treeid, dirid;
+	size_t path_len;
+	int ret, err;
+
+	for (;;) {
+		for (;;) {
+			if (iter->stack_len == 0)
+				return 1;
+
+			top = top_stack_entry(iter);
+			if (top->items_pos < top->rootref_args.num_items) {
+				break;
+			} else {
+				ret = ioctl(iter->cur_fd,
+					    BTRFS_IOC_GET_SUBVOL_ROOTREF,
+					    &top->rootref_args);
+				if (ret == -1 && errno != EOVERFLOW)
+					return -1;
+				top->items_pos = 0;
+
+				if (top->rootref_args.num_items == 0) {
+					err = pop_stack(iter);
+					if (err)
+						return err;
+				}
+			}
+		}
+
+		treeid = top->rootref_args.rootref[top->items_pos].treeid;
+		dirid = top->rootref_args.rootref[top->items_pos].dirid;
+		top->items_pos++;
+		err = get_subvolume_path(iter, treeid, dirid, &path_len);
+		if (err) {
+			/* Skip the subvolume if we can't access it. */
+			if (errno == EACCES)
+				continue;
+			return err;
+		}
+
+		err = append_stack(iter, treeid, path_len);
+		if (err) {
+			/*
+			 * Skip the subvolume if it does not exist (which can
+			 * happen if there is another filesystem mounted over a
+			 * parent directory) or we don't have permission to
+			 * access it.
+			 */
+			if (errno == ENOENT || errno == EACCES)
+				continue;
+			return err;
+		}
+
+		top = top_stack_entry(iter);
+		goto out;
+	}
+
+out:
+	if (path_ret) {
+		*path_ret = malloc(top->path_len + 1);
+		if (!*path_ret)
+			return -ENOMEM;
+		memcpy(*path_ret, iter->cur_path, top->path_len);
+		(*path_ret)[top->path_len] = '\0';
+	}
+	if (id_ret)
+		*id_ret = top->tree_id;
+	return 0;
+}
+
+#define BTRFS_SUBVOLUME1 "subvol1"
+#define BTRFS_SUBVOLUME1_SNAPSHOT1 "subvol1_snapshot1"
+#define BTRFS_SUBVOLUME1_SNAPSHOT1_RO "subvol1_snapshot1_ro"
+#define BTRFS_SUBVOLUME1_RENAME "subvol1_rename"
+#define BTRFS_SUBVOLUME2 "subvol2"
+
+static int btrfs_subvolumes_fsids_mapped(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_fsids(10000, 10000))
+			die("failure: switch fsids");
+
+		if (!caps_up())
+			die("failure: raise caps");
+
+		/*
+		 * The caller's fsids now have mappings in the idmapped mount so
+		 * any file creation must succeed.
+		 */
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		/* remove subvolume */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (!caps_down())
+			die("failure: lower caps");
+
+		/*
+		 * The filesystem is not mounted with user_subvol_rm_allowed so
+		 * subvolume deletion must fail.
+		 */
+		if (!btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000))
+		die("failure: check ownership");
+
+	/* remove subvolume */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_subvolumes_fsids_mapped_userns(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		/* The caller's fsids now have mappings in the idmapped mount so
+		 * any file creation must fail.
+		 */
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 0, 0))
+			die("failure: check ownership");
+
+		/* remove subvolume */
+		if (!btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove subvolume */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_subvolumes_fsids_unmapped(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create directory for rename test */
+	if (btrfs_create_subvolume(t_dir1_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	/* change ownership of all files to uid 0 */
+	if (fchownat(t_dir1_fd, BTRFS_SUBVOLUME1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	if (!switch_fsids(0, 0)) {
+		log_stderr("failure: switch_fsids");
+		goto out;
+	}
+
+	/*
+	 * The caller's fsids don't have a mappings in the idmapped mount so
+	 * any file creation must fail.
+	 */
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create subvolume */
+	if (!btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME2)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+	if (errno != EOVERFLOW) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	/* try to rename a subvolume */
+	if (!renameat2(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
+		       BTRFS_SUBVOLUME1_RENAME, 0)) {
+		log_stderr("failure: renameat2");
+		goto out;
+	}
+	if (errno != EOVERFLOW) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	/* The caller is privileged over the inode so file deletion must work. */
+
+	/* remove subvolume */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_subvolumes_fsids_unmapped_userns(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF, userns_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	/* create directory for rename test */
+	if (btrfs_create_subvolume(t_dir1_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	/* change ownership of all files to uid 0 */
+	if (fchownat(t_dir1_fd, BTRFS_SUBVOLUME1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	userns_fd = get_userns_fd(0, 30000, 10000);
+	if (userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!expected_uid_gid(t_dir1_fd, BTRFS_SUBVOLUME1, 0,
+				      t_overflowuid, t_overflowgid))
+			die("failure: expected_uid_gid");
+
+		if (!expected_uid_gid(open_tree_fd, BTRFS_SUBVOLUME1, 0,
+				      t_overflowuid, t_overflowgid))
+			die("failure: expected_uid_gid");
+
+		/*
+		 * The caller's fsids don't have a mappings in the idmapped mount so
+		 * any file creation must fail.
+		 */
+
+		/* create subvolume */
+		if (!btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME2))
+			die("failure: btrfs_create_subvolume");
+		if (errno != EOVERFLOW)
+			die("failure: errno");
+
+		/* try to rename a subvolume */
+		if (!renameat2(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
+					BTRFS_SUBVOLUME1_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EOVERFLOW)
+			die("failure: errno");
+
+		/*
+		 * The caller is not privileged over the inode so subvolume
+		 * deletion must fail.
+		 */
+
+		/* remove subvolume */
+		if (!btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove subvolume */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+	safe_close(userns_fd);
+
+	return fret;
+}
+
+static int btrfs_snapshots_fsids_mapped(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int subvolume_fd = -EBADF;
+
+		if (!switch_fsids(10000, 10000))
+			die("failure: switch fsids");
+
+		if (!caps_up())
+			die("failure: raise caps");
+
+		/* The caller's fsids now have mappings in the idmapped mount so
+		 * any file creation must fail.
+		 */
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		/* create read-write snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1, 0))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		/* create read-only snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1_RO,
+					  BTRFS_SUBVOL_RDONLY))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		safe_close(subvolume_fd);
+
+		/* remove subvolume */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+
+		/* remove read-write snapshot */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1))
+			die("failure: btrfs_delete_subvolume");
+
+		/* remove read-only snapshot */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO))
+			die("failure: btrfs_delete_subvolume");
+
+		/* create directory */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		/* create read-write snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1, 0))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		/* create read-only snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1_RO,
+					  BTRFS_SUBVOL_RDONLY))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		safe_close(subvolume_fd);
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	/* remove read-write snapshot */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	/* remove read-only snapshot */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_snapshots_fsids_mapped_userns(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int subvolume_fd = -EBADF;
+
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		/* create read-write snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1, 0))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		/* create read-only snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1_RO,
+					  BTRFS_SUBVOL_RDONLY))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		safe_close(subvolume_fd);
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000))
+		die("failure: expected_uid_gid");
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 10000, 10000))
+		die("failure: expected_uid_gid");
+
+	/* remove read-write snapshot */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO, 0, 10000, 10000))
+		die("failure: expected_uid_gid");
+
+	/* remove read-only snapshot */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_snapshots_fsids_unmapped(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create directory for rename test */
+	if (btrfs_create_subvolume(t_dir1_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	/* change ownership of all files to uid 0 */
+	if (fchownat(t_dir1_fd, BTRFS_SUBVOLUME1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr,
+			      sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int subvolume_fd = -EBADF;
+
+		if (!switch_fsids(0, 0)) {
+			log_stderr("failure: switch_fsids");
+			goto out;
+		}
+
+		/*
+		 * The caller's fsids don't have a mappings in the idmapped
+		 * mount so any file creation must fail.
+		 */
+
+		/*
+		 * The open_tree() syscall returns an O_PATH file descriptor
+		 * which we can't use with ioctl(). So let's reopen it as a
+		 * proper file descriptor.
+		 */
+		tree_fd = openat(open_tree_fd, ".",
+				 O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (tree_fd < 0)
+			die("failure: openat");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		/* create directory */
+		if (!btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME2))
+			die("failure: btrfs_create_subvolume");
+		if (errno != EOVERFLOW)
+			die("failure: errno");
+
+		/* create read-write snapshot */
+		if (!btrfs_create_snapshot(subvolume_fd, tree_fd,
+					   BTRFS_SUBVOLUME1_SNAPSHOT1, 0))
+			die("failure: btrfs_create_snapshot");
+		if (errno != EOVERFLOW)
+			die("failure: errno");
+
+		/* create read-only snapshot */
+		if (!btrfs_create_snapshot(subvolume_fd, tree_fd,
+					   BTRFS_SUBVOLUME1_SNAPSHOT1_RO,
+					   BTRFS_SUBVOL_RDONLY))
+			die("failure: btrfs_create_snapshot");
+		if (errno != EOVERFLOW)
+			die("failure: errno");
+
+		/* try to rename a directory */
+		if (!renameat2(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
+			       BTRFS_SUBVOLUME1_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EOVERFLOW)
+			die("failure: errno");
+
+		if (!caps_down())
+			die("failure: caps_down");
+
+		/* create read-write snapshot */
+		if (!btrfs_create_snapshot(subvolume_fd, tree_fd,
+					   BTRFS_SUBVOLUME1_SNAPSHOT1, 0))
+			die("failure: btrfs_create_snapshot");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/* create read-only snapshot */
+		if (!btrfs_create_snapshot(subvolume_fd, tree_fd,
+					   BTRFS_SUBVOLUME1_SNAPSHOT1_RO,
+					   BTRFS_SUBVOL_RDONLY))
+			die("failure: btrfs_create_snapshot");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/*
+		 * The caller is not privileged over the inode so subvolume
+		 * deletion must fail.
+		 */
+
+		/* remove directory */
+		if (!btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!caps_up())
+			die("failure: caps_down");
+
+		/*
+		 * The caller is privileged over the inode so subvolume
+		 * deletion must work.
+		 */
+
+		/* remove directory */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_snapshots_fsids_unmapped_userns(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, subvolume_fd = -EBADF, tree_fd = -EBADF,
+	    userns_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create directory for rename test */
+	if (btrfs_create_subvolume(t_dir1_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	/* change ownership of all files to uid 0 */
+	if (fchownat(t_dir1_fd, BTRFS_SUBVOLUME1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	userns_fd = get_userns_fd(0, 30000, 10000);
+	if (userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr,
+			      sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor
+	 * which we can't use with ioctl(). So let's reopen it as a
+	 * proper file descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".",
+			O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+			O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (subvolume_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!expected_uid_gid(t_dir1_fd, BTRFS_SUBVOLUME1, 0,
+				      t_overflowuid, t_overflowgid))
+			die("failure: expected_uid_gid");
+
+		if (!expected_uid_gid(open_tree_fd, BTRFS_SUBVOLUME1, 0,
+				      t_overflowuid, t_overflowgid))
+			die("failure: expected_uid_gid");
+
+		/*
+		 * The caller's fsids don't have a mappings in the idmapped
+		 * mount so any file creation must fail.
+		 */
+
+		/* create directory */
+		if (!btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME2))
+			die("failure: btrfs_create_subvolume");
+		if (errno != EOVERFLOW)
+			die("failure: errno");
+
+		/* create read-write snapshot */
+		if (!btrfs_create_snapshot(subvolume_fd, tree_fd,
+					   BTRFS_SUBVOLUME1_SNAPSHOT1, 0))
+			die("failure: btrfs_create_snapshot");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/* create read-only snapshot */
+		if (!btrfs_create_snapshot(subvolume_fd, tree_fd,
+					   BTRFS_SUBVOLUME1_SNAPSHOT1_RO,
+					   BTRFS_SUBVOL_RDONLY))
+			die("failure: btrfs_create_snapshot");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/* try to rename a directory */
+		if (!renameat2(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
+			       BTRFS_SUBVOLUME1_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EOVERFLOW)
+			die("failure: errno");
+
+		/*
+		 * The caller is not privileged over the inode so subvolume
+		 * deletion must fail.
+		 */
+
+		/* remove directory */
+		if (!btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+		die("failure: btrfs_delete_subvolume");
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(subvolume_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_mnt_scratch_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_fsids(10000, 10000))
+			die("failure: switch fsids");
+
+		if (!caps_down())
+			die("failure: raise caps");
+
+		/*
+		 * The caller's fsids now have mappings in the idmapped mount so
+		 * any file creation must succedd.
+		 */
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		/*
+		 * The scratch device is mounted with user_subvol_rm_allowed so
+		 * subvolume deletion must succeed.
+		 */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_subvolumes_fsids_mapped_userns_user_subvol_rm_allowed(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_mnt_scratch_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		/* The caller's fsids now have mappings in the idmapped mount so
+		 * any file creation must fail.
+		 */
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 0, 0))
+			die("failure: check ownership");
+
+		/*
+		 * The scratch device is mounted with user_subvol_rm_allowed so
+		 * subvolume deletion must succeed.
+		 */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_snapshots_fsids_mapped_user_subvol_rm_allowed(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_mnt_scratch_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int subvolume_fd = -EBADF;
+
+		if (!switch_fsids(10000, 10000))
+			die("failure: switch fsids");
+
+		if (!caps_down())
+			die("failure: raise caps");
+
+		/*
+		 * The caller's fsids now have mappings in the idmapped mount so
+		 * any file creation must succeed.
+		 */
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		/* create read-write snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1, 0))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		/* create read-only snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1_RO,
+					  BTRFS_SUBVOL_RDONLY))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		safe_close(subvolume_fd);
+
+		/* remove subvolume */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+
+		/* remove read-write snapshot */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1))
+			die("failure: btrfs_delete_subvolume");
+
+		/* remove read-only snapshot */
+		if (!btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO))
+			die("failure: btrfs_delete_subvolume");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		if (btrfs_set_subvolume_ro(subvolume_fd, false))
+			die("failure: btrfs_set_subvolume_ro");
+
+		safe_close(subvolume_fd);
+
+		/* remove read-only snapshot */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO))
+			die("failure: btrfs_delete_subvolume");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_snapshots_fsids_mapped_userns_user_subvol_rm_allowed(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_mnt_scratch_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int subvolume_fd = -EBADF;
+
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		/* create read-write snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1, 0))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		/* create read-only snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1_RO,
+					  BTRFS_SUBVOL_RDONLY))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		/* remove directory */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_delete_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		/* remove read-write snapshot */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1))
+			die("failure: btrfs_delete_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		/* remove read-only snapshot */
+		if (!btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO))
+			die("failure: btrfs_delete_subvolume");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		if (btrfs_set_subvolume_ro(subvolume_fd, false))
+			die("failure: btrfs_set_subvolume_ro");
+
+		safe_close(subvolume_fd);
+
+		/* remove read-only snapshot */
+		if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1_RO))
+			die("failure: btrfs_delete_subvolume");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_delete_by_spec_id(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, subvolume_fd = -EBADF, tree_fd = -EBADF;
+	uint64_t subvolume_id1 = -EINVAL, subvolume_id2 = -EINVAL;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	/* create subvolume */
+	if (btrfs_create_subvolume(t_mnt_scratch_fd, "A")) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	/* create subvolume */
+	if (btrfs_create_subvolume(t_mnt_scratch_fd, "B")) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	subvolume_fd = openat(t_mnt_scratch_fd, "B", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (subvolume_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create subvolume */
+	if (btrfs_create_subvolume(subvolume_fd, "C")) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	safe_close(subvolume_fd);
+
+	subvolume_fd = openat(t_mnt_scratch_fd, "A", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (subvolume_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (btrfs_get_subvolume_id(subvolume_fd, &subvolume_id1)) {
+		log_stderr("failure: btrfs_get_subvolume_id");
+		goto out;
+	}
+
+	subvolume_fd = openat(t_mnt_scratch_fd, "B/C", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (subvolume_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (btrfs_get_subvolume_id(subvolume_fd, &subvolume_id2)) {
+		log_stderr("failure: btrfs_get_subvolume_id");
+		goto out;
+	}
+
+	if (sys_mount(t_device_scratch, t_mountpoint, "btrfs", 0, "subvol=B/C")) {
+		log_stderr("failure: mount");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(-EBADF, t_mountpoint,
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/*
+		 * The subvolume isn't exposed in the idmapped mount so
+		 * delation via spec id must fail.
+		 */
+		if (!btrfs_delete_subvolume_id(tree_fd, subvolume_id1))
+			die("failure: btrfs_delete_subvolume_id");
+		if (errno != EOPNOTSUPP)
+			die("failure: errno");
+
+		if (btrfs_delete_subvolume_id(t_mnt_scratch_fd, subvolume_id1))
+			die("failure: btrfs_delete_subvolume_id");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+	sys_umount2(t_mountpoint, MNT_DETACH);
+	btrfs_delete_subvolume_id(t_mnt_scratch_fd, subvolume_id2);
+	btrfs_delete_subvolume(t_mnt_scratch_fd, "B");
+
+	return fret;
+}
+
+static int btrfs_subvolumes_setflags_fsids_mapped(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int subvolume_fd = -EBADF;
+		bool read_only = false;
+
+		if (!switch_fsids(10000, 10000))
+			die("failure: switch fsids");
+
+		if (!caps_down())
+			die("failure: raise caps");
+
+		/* The caller's fsids now have mappings in the idmapped mount so
+		 * any file creation must fail.
+		 */
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		if (btrfs_get_subvolume_ro(subvolume_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		if (btrfs_set_subvolume_ro(subvolume_fd, true))
+			die("failure: btrfs_set_subvolume_ro");
+
+		if (btrfs_get_subvolume_ro(subvolume_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (!read_only)
+			die("failure: not read_only");
+
+		if (btrfs_set_subvolume_ro(subvolume_fd, false))
+			die("failure: btrfs_set_subvolume_ro");
+
+		if (btrfs_get_subvolume_ro(subvolume_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		safe_close(subvolume_fd);
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_subvolumes_setflags_fsids_mapped_userns(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int subvolume_fd = -EBADF;
+		bool read_only = false;
+
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		/* The caller's fsids now have mappings in the idmapped mount so
+		 * any file creation must fail.
+		 */
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		if (btrfs_get_subvolume_ro(subvolume_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		if (btrfs_set_subvolume_ro(subvolume_fd, true))
+			die("failure: btrfs_set_subvolume_ro");
+
+		if (btrfs_get_subvolume_ro(subvolume_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (!read_only)
+			die("failure: not read_only");
+
+		if (btrfs_set_subvolume_ro(subvolume_fd, false))
+			die("failure: btrfs_set_subvolume_ro");
+
+		if (btrfs_get_subvolume_ro(subvolume_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		safe_close(subvolume_fd);
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_subvolumes_setflags_fsids_unmapped(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create subvolume */
+	if (btrfs_create_subvolume(t_dir1_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	if (!expected_uid_gid(t_dir1_fd, BTRFS_SUBVOLUME1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int subvolume_fd = -EBADF;
+		bool read_only = false;
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		if (!switch_fsids(0, 0))
+			die("failure: switch fsids");
+
+		if (!caps_down())
+			die("failure: raise caps");
+
+		/*
+		 * The caller's fsids don't have mappings in the idmapped mount
+		 * so any file creation must fail.
+		 */
+
+		if (btrfs_get_subvolume_ro(subvolume_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		if (!btrfs_set_subvolume_ro(subvolume_fd, true))
+			die("failure: btrfs_set_subvolume_ro");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		safe_close(subvolume_fd);
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_subvolumes_setflags_fsids_unmapped_userns(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF, userns_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	userns_fd = get_userns_fd(0, 30000, 10000);
+	if (userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create subvolume */
+	if (btrfs_create_subvolume(t_dir1_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	if (!expected_uid_gid(t_dir1_fd, BTRFS_SUBVOLUME1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int subvolume_fd = -EBADF;
+		bool read_only = false;
+
+		/*
+		 * The caller's fsids don't have mappings in the idmapped mount
+		 * so any file creation must fail.
+		 */
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		if (!switch_userns(userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!expected_uid_gid(t_dir1_fd, BTRFS_SUBVOLUME1, 0,
+				      t_overflowuid, t_overflowgid))
+			die("failure: expected_uid_gid");
+
+		if (!expected_uid_gid(open_tree_fd, BTRFS_SUBVOLUME1, 0,
+				      t_overflowuid, t_overflowgid))
+			die("failure: expected_uid_gid");
+
+		if (btrfs_get_subvolume_ro(subvolume_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		if (!btrfs_set_subvolume_ro(subvolume_fd, true))
+			die("failure: btrfs_set_subvolume_ro");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		safe_close(subvolume_fd);
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+	safe_close(userns_fd);
+
+	return fret;
+}
+
+static int btrfs_snapshots_setflags_fsids_mapped(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int snapshot_fd = -EBADF, subvolume_fd = -EBADF;
+		bool read_only = false;
+
+		if (!switch_fsids(10000, 10000))
+			die("failure: switch fsids");
+
+		if (!caps_down())
+			die("failure: raise caps");
+
+		/*
+		 * The caller's fsids now have mappings in the idmapped mount
+		 * so any file creation must succeed.
+		 */
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		/* create read-write snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1, 0))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 10000, 10000))
+			die("failure: expected_uid_gid");
+
+		snapshot_fd = openat(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1,
+				     O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (snapshot_fd < 0)
+			die("failure: openat");
+
+		if (btrfs_get_subvolume_ro(snapshot_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		if (btrfs_set_subvolume_ro(snapshot_fd, true))
+			die("failure: btrfs_set_subvolume_ro");
+
+		if (btrfs_get_subvolume_ro(snapshot_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (!read_only)
+			die("failure: not read_only");
+
+		if (btrfs_set_subvolume_ro(snapshot_fd, false))
+			die("failure: btrfs_set_subvolume_ro");
+
+		if (btrfs_get_subvolume_ro(snapshot_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		safe_close(snapshot_fd);
+		safe_close(subvolume_fd);
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_snapshots_setflags_fsids_mapped_userns(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int snapshot_fd = -EBADF, subvolume_fd = -EBADF;
+		bool read_only = false;
+
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		/*
+		 * The caller's fsids now have mappings in the idmapped mount so
+		 * any file creation must succeed.
+		 */
+
+		/* create subvolume */
+		if (btrfs_create_subvolume(tree_fd, BTRFS_SUBVOLUME1))
+			die("failure: btrfs_create_subvolume");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		subvolume_fd = openat(tree_fd, BTRFS_SUBVOLUME1,
+				      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (subvolume_fd < 0)
+			die("failure: openat");
+
+		/* create read-write snapshot */
+		if (btrfs_create_snapshot(subvolume_fd, tree_fd,
+					  BTRFS_SUBVOLUME1_SNAPSHOT1, 0))
+			die("failure: btrfs_create_snapshot");
+
+		if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		snapshot_fd = openat(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1,
+				     O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (snapshot_fd < 0)
+			die("failure: openat");
+
+		if (btrfs_get_subvolume_ro(snapshot_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		if (btrfs_set_subvolume_ro(snapshot_fd, true))
+			die("failure: btrfs_set_subvolume_ro");
+
+		if (btrfs_get_subvolume_ro(snapshot_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (!read_only)
+			die("failure: not read_only");
+
+		if (btrfs_set_subvolume_ro(snapshot_fd, false))
+			die("failure: btrfs_set_subvolume_ro");
+
+		if (btrfs_get_subvolume_ro(snapshot_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		safe_close(snapshot_fd);
+		safe_close(subvolume_fd);
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_snapshots_setflags_fsids_unmapped(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, subvolume_fd = -EBADF, tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create subvolume */
+	if (btrfs_create_subvolume(t_dir1_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	if (!expected_uid_gid(t_dir1_fd, BTRFS_SUBVOLUME1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	subvolume_fd = openat(t_dir1_fd, BTRFS_SUBVOLUME1,
+			      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (subvolume_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create read-write snapshot */
+	if (btrfs_create_snapshot(subvolume_fd, t_dir1_fd,
+				  BTRFS_SUBVOLUME1_SNAPSHOT1, 0)) {
+		log_stderr("failure: btrfs_create_snapshot");
+		goto out;
+	}
+
+	if (!expected_uid_gid(t_dir1_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int snapshot_fd = -EBADF;
+		bool read_only = false;
+
+		snapshot_fd = openat(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1,
+				     O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (snapshot_fd < 0)
+			die("failure: openat");
+
+		if (!switch_fsids(0, 0))
+			die("failure: switch fsids");
+
+		if (!caps_down())
+			die("failure: raise caps");
+
+		/*
+		 * The caller's fsids don't have mappings in the idmapped mount
+		 * so any file creation must fail.
+		 */
+
+		if (btrfs_get_subvolume_ro(snapshot_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		if (!btrfs_set_subvolume_ro(snapshot_fd, true))
+			die("failure: btrfs_set_subvolume_ro");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		safe_close(snapshot_fd);
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(subvolume_fd);
+	safe_close(tree_fd);
+
+	return fret;
+}
+
+static int btrfs_snapshots_setflags_fsids_unmapped_userns(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF, subvolume_fd = -EBADF, tree_fd = -EBADF,
+	    userns_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	userns_fd = get_userns_fd(0, 30000, 10000);
+	if (userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create subvolume */
+	if (btrfs_create_subvolume(t_dir1_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	if (!expected_uid_gid(t_dir1_fd, BTRFS_SUBVOLUME1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	subvolume_fd = openat(t_dir1_fd, BTRFS_SUBVOLUME1,
+			      O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (subvolume_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create read-write snapshot */
+	if (btrfs_create_snapshot(subvolume_fd, t_dir1_fd,
+				  BTRFS_SUBVOLUME1_SNAPSHOT1, 0)) {
+		log_stderr("failure: btrfs_create_snapshot");
+		goto out;
+	}
+
+	if (!expected_uid_gid(t_dir1_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (!expected_uid_gid(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int snapshot_fd = -EBADF;
+		bool read_only = false;
+
+		/*
+		 * The caller's fsids don't have mappings in the idmapped mount
+		 * so any file creation must fail.
+		 */
+
+		snapshot_fd = openat(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1,
+				     O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+		if (snapshot_fd < 0)
+			die("failure: openat");
+
+
+		if (!switch_userns(userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!expected_uid_gid(t_dir1_fd, BTRFS_SUBVOLUME1, 0,
+				      t_overflowuid, t_overflowgid))
+			die("failure: expected_uid_gid");
+
+		if (!expected_uid_gid(open_tree_fd, BTRFS_SUBVOLUME1, 0,
+				      t_overflowuid, t_overflowgid))
+			die("failure: expected_uid_gid");
+
+		/*
+		 * The caller's fsids don't have mappings in the idmapped mount
+		 * so any file creation must fail.
+		 */
+
+		if (btrfs_get_subvolume_ro(snapshot_fd, &read_only))
+			die("failure: btrfs_get_subvolume_ro");
+
+		if (read_only)
+			die("failure: read_only");
+
+		if (!btrfs_set_subvolume_ro(snapshot_fd, true))
+			die("failure: btrfs_set_subvolume_ro");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		safe_close(snapshot_fd);
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	/* remove directory */
+	if (btrfs_delete_subvolume(tree_fd, BTRFS_SUBVOLUME1_SNAPSHOT1)) {
+		log_stderr("failure: btrfs_delete_subvolume");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+	safe_close(subvolume_fd);
+	safe_close(tree_fd);
+	safe_close(userns_fd);
+
+	return fret;
+}
+
+#define BTRFS_SUBVOLUME_SUBVOL1 "subvol1"
+#define BTRFS_SUBVOLUME_SUBVOL2 "subvol2"
+#define BTRFS_SUBVOLUME_SUBVOL3 "subvol3"
+#define BTRFS_SUBVOLUME_SUBVOL4 "subvol4"
+
+#define BTRFS_SUBVOLUME_SUBVOL1_ID 0
+#define BTRFS_SUBVOLUME_SUBVOL2_ID 1
+#define BTRFS_SUBVOLUME_SUBVOL3_ID 2
+#define BTRFS_SUBVOLUME_SUBVOL4_ID 3
+
+#define BTRFS_SUBVOLUME_DIR1 "dir1"
+#define BTRFS_SUBVOLUME_DIR2 "dir2"
+
+#define BTRFS_SUBVOLUME_MNT "mnt_subvolume1"
+
+#define BTRFS_SUBVOLUME_SUBVOL1xSUBVOL3 "subvol1/subvol3"
+#define BTRFS_SUBVOLUME_SUBVOL1xDIR1xDIR2 "subvol1/dir1/dir2"
+#define BTRFS_SUBVOLUME_SUBVOL1xDIR1xDIR2xSUBVOL4 "subvol1/dir1/dir2/subvol4"
+
+/*
+ * We create the following mount layout to test lookup:
+ *
+ * |-/mnt/test                    /dev/loop0                   btrfs       rw,relatime,space_cache,subvolid=5,subvol=/
+ * | |-/mnt/test/mnt1             /dev/loop1[/subvol1]         btrfs       rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=268,subvol=/subvol1
+ * '-/mnt/scratch                 /dev/loop1                   btrfs       rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=5,subvol=/
+ */
+static int btrfs_subvolume_lookup_user(void)
+{
+	int fret = -1;
+	int dir1_fd = -EBADF, dir2_fd = -EBADF, mnt_fd = -EBADF,
+	    open_tree_fd = -EBADF, tree_fd = -EBADF, userns_fd = -EBADF;
+	int subvolume_fds[BTRFS_SUBVOLUME_SUBVOL4_ID + 1];
+	uint64_t subvolume_ids[BTRFS_SUBVOLUME_SUBVOL4_ID + 1];
+	uint64_t subvolid = -EINVAL;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+	struct btrfs_iter *iter;
+
+	if (!caps_supported())
+		return 0;
+
+	for (int i = 0; i < ARRAY_SIZE(subvolume_fds); i++)
+		subvolume_fds[i] = -EBADF;
+
+	for (int i = 0; i < ARRAY_SIZE(subvolume_ids); i++)
+		subvolume_ids[i] = -EINVAL;
+
+	if (btrfs_create_subvolume(t_mnt_scratch_fd, BTRFS_SUBVOLUME_SUBVOL1)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	if (btrfs_create_subvolume(t_mnt_scratch_fd, BTRFS_SUBVOLUME_SUBVOL2)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	subvolume_fds[BTRFS_SUBVOLUME_SUBVOL1_ID] = openat(t_mnt_scratch_fd,
+							   BTRFS_SUBVOLUME_SUBVOL1,
+							   O_CLOEXEC | O_DIRECTORY);
+	if (subvolume_fds[BTRFS_SUBVOLUME_SUBVOL1_ID] < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create subvolume */
+	if (btrfs_create_subvolume(subvolume_fds[BTRFS_SUBVOLUME_SUBVOL1_ID], BTRFS_SUBVOLUME_SUBVOL3)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	if (mkdirat(subvolume_fds[BTRFS_SUBVOLUME_SUBVOL1_ID], BTRFS_SUBVOLUME_DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	dir1_fd = openat(subvolume_fds[BTRFS_SUBVOLUME_SUBVOL1_ID], BTRFS_SUBVOLUME_DIR1,
+			 O_CLOEXEC | O_DIRECTORY);
+	if (dir1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (mkdirat(dir1_fd, BTRFS_SUBVOLUME_DIR2, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	dir2_fd = openat(dir1_fd, BTRFS_SUBVOLUME_DIR2, O_CLOEXEC | O_DIRECTORY);
+	if (dir2_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (btrfs_create_subvolume(dir2_fd, BTRFS_SUBVOLUME_SUBVOL4)) {
+		log_stderr("failure: btrfs_create_subvolume");
+		goto out;
+	}
+
+	if (mkdirat(t_mnt_fd, BTRFS_SUBVOLUME_MNT, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	snprintf(t_buf, sizeof(t_buf), "%s/%s", t_mountpoint, BTRFS_SUBVOLUME_MNT);
+	if (sys_mount(t_device_scratch, t_buf, "btrfs", 0,
+		      "subvol=" BTRFS_SUBVOLUME_SUBVOL1)) {
+		log_stderr("failure: mount");
+		goto out;
+	}
+
+	mnt_fd = openat(t_mnt_fd, BTRFS_SUBVOLUME_MNT, O_CLOEXEC | O_DIRECTORY);
+	if (mnt_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (chown_r(t_mnt_scratch_fd, ".", 1000, 1000)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	subvolume_fds[BTRFS_SUBVOLUME_SUBVOL2_ID] = openat(t_mnt_scratch_fd,
+							   BTRFS_SUBVOLUME_SUBVOL2,
+							   O_CLOEXEC | O_DIRECTORY);
+	if (subvolume_fds[BTRFS_SUBVOLUME_SUBVOL2_ID] < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (btrfs_get_subvolume_id(subvolume_fds[BTRFS_SUBVOLUME_SUBVOL1_ID],
+				   &subvolume_ids[BTRFS_SUBVOLUME_SUBVOL1_ID])) {
+		log_stderr("failure: btrfs_get_subvolume_id");
+		goto out;
+	}
+
+	if (btrfs_get_subvolume_id(subvolume_fds[BTRFS_SUBVOLUME_SUBVOL2_ID],
+				   &subvolume_ids[BTRFS_SUBVOLUME_SUBVOL2_ID])) {
+		log_stderr("failure: btrfs_get_subvolume_id");
+		goto out;
+	}
+
+	subvolume_fds[BTRFS_SUBVOLUME_SUBVOL3_ID] = openat(t_mnt_scratch_fd,
+							   BTRFS_SUBVOLUME_SUBVOL1xSUBVOL3,
+							   O_CLOEXEC | O_DIRECTORY);
+	if (subvolume_fds[BTRFS_SUBVOLUME_SUBVOL3_ID] < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (btrfs_get_subvolume_id(subvolume_fds[BTRFS_SUBVOLUME_SUBVOL3_ID],
+				   &subvolume_ids[BTRFS_SUBVOLUME_SUBVOL3_ID])) {
+		log_stderr("failure: btrfs_get_subvolume_id");
+		goto out;
+	}
+
+	subvolume_fds[BTRFS_SUBVOLUME_SUBVOL4_ID] = openat(t_mnt_scratch_fd,
+							   BTRFS_SUBVOLUME_SUBVOL1xDIR1xDIR2xSUBVOL4,
+							   O_CLOEXEC | O_DIRECTORY);
+	if (subvolume_fds[BTRFS_SUBVOLUME_SUBVOL4_ID] < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (btrfs_get_subvolume_id(subvolume_fds[BTRFS_SUBVOLUME_SUBVOL4_ID],
+				   &subvolume_ids[BTRFS_SUBVOLUME_SUBVOL4_ID])) {
+		log_stderr("failure: btrfs_get_subvolume_id");
+		goto out;
+	}
+
+
+	if (fchmod(subvolume_fds[BTRFS_SUBVOLUME_SUBVOL3_ID], S_IRUSR | S_IWUSR | S_IXUSR), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	if (fchmod(subvolume_fds[BTRFS_SUBVOLUME_SUBVOL4_ID], S_IRUSR | S_IWUSR | S_IXUSR), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(mnt_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The open_tree() syscall returns an O_PATH file descriptor which we
+	 * can't use with ioctl(). So let's reopen it as a proper file
+	 * descriptor.
+	 */
+	tree_fd = openat(open_tree_fd, ".", O_RDONLY | O_CLOEXEC | O_DIRECTORY);
+	if (tree_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		bool subvolume3_found = false, subvolume4_found = false;
+
+		if (!switch_fsids(11000, 11000))
+			die("failure: switch fsids");
+
+		if (!caps_down())
+			die("failure: lower caps");
+
+		if (btrfs_iterator_start(tree_fd, 0, &iter))
+			die("failure: btrfs_iterator_start");
+
+		for (;;) {
+			char *subvol_path = NULL;
+			int ret;
+
+			ret = btrfs_iterator_next(iter, &subvol_path, &subvolid);
+			if (ret == 1)
+				break;
+			else if (ret)
+				die("failure: btrfs_iterator_next");
+
+			if (subvolid != subvolume_ids[BTRFS_SUBVOLUME_SUBVOL3_ID] &&
+			    subvolid != subvolume_ids[BTRFS_SUBVOLUME_SUBVOL4_ID])
+				die("failure: subvolume id %llu->%s",
+				    (long long unsigned)subvolid, subvol_path);
+
+			if (subvolid == subvolume_ids[BTRFS_SUBVOLUME_SUBVOL3_ID])
+				subvolume3_found = true;
+
+			if (subvolid == subvolume_ids[BTRFS_SUBVOLUME_SUBVOL4_ID])
+				subvolume4_found = true;
+
+			free(subvol_path);
+		}
+		btrfs_iterator_end(iter);
+
+		if (!subvolume3_found || !subvolume4_found)
+			die("failure: subvolume id");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		bool subvolume3_found = false, subvolume4_found = false;
+
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (btrfs_iterator_start(tree_fd, 0, &iter))
+			die("failure: btrfs_iterator_start");
+
+		for (;;) {
+			char *subvol_path = NULL;
+			int ret;
+
+			ret = btrfs_iterator_next(iter, &subvol_path, &subvolid);
+			if (ret == 1)
+				break;
+			else if (ret)
+				die("failure: btrfs_iterator_next");
+
+			if (subvolid != subvolume_ids[BTRFS_SUBVOLUME_SUBVOL3_ID] &&
+			    subvolid != subvolume_ids[BTRFS_SUBVOLUME_SUBVOL4_ID])
+				die("failure: subvolume id %llu->%s",
+				    (long long unsigned)subvolid, subvol_path);
+
+			if (subvolid == subvolume_ids[BTRFS_SUBVOLUME_SUBVOL3_ID])
+				subvolume3_found = true;
+
+			if (subvolid == subvolume_ids[BTRFS_SUBVOLUME_SUBVOL4_ID])
+				subvolume4_found = true;
+
+			free(subvol_path);
+		}
+		btrfs_iterator_end(iter);
+
+		if (!subvolume3_found || !subvolume4_found)
+			die("failure: subvolume id");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		bool subvolume_found = false;
+
+		if (!switch_fsids(0, 0))
+			die("failure: switch fsids");
+
+		if (!caps_down())
+			die("failure: lower caps");
+
+		if (btrfs_iterator_start(tree_fd, 0, &iter))
+			die("failure: btrfs_iterator_start");
+
+		for (;;) {
+			char *subvol_path = NULL;
+			int ret;
+
+			ret = btrfs_iterator_next(iter, &subvol_path, &subvolid);
+			if (ret == 1)
+				break;
+			else if (ret)
+				die("failure: btrfs_iterator_next");
+
+			free(subvol_path);
+
+			subvolume_found = true;
+			break;
+		}
+		btrfs_iterator_end(iter);
+
+		if (subvolume_found)
+			die("failure: subvolume id");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	userns_fd = get_userns_fd(0, 30000, 10000);
+	if (userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		bool subvolume_found = false;
+
+		if (!switch_userns(userns_fd, 0, 0, true))
+			die("failure: switch_userns");
+
+		if (btrfs_iterator_start(tree_fd, 0, &iter))
+			die("failure: btrfs_iterator_start");
+
+		for (;;) {
+			char *subvol_path = NULL;
+			int ret;
+
+			ret = btrfs_iterator_next(iter, &subvol_path, &subvolid);
+			if (ret == 1)
+				break;
+			else if (ret)
+				die("failure: btrfs_iterator_next");
+
+			free(subvol_path);
+
+			subvolume_found = true;
+			break;
+		}
+		btrfs_iterator_end(iter);
+
+		if (subvolume_found)
+			die("failure: subvolume id");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(dir1_fd);
+	safe_close(dir2_fd);
+	safe_close(open_tree_fd);
+	safe_close(tree_fd);
+	safe_close(userns_fd);
+	for (int i = 0; i < ARRAY_SIZE(subvolume_fds); i++)
+		safe_close(subvolume_fds[i]);
+	snprintf(t_buf, sizeof(t_buf), "%s/%s", t_mountpoint, BTRFS_SUBVOLUME_MNT);
+	sys_umount2(t_buf, MNT_DETACH);
+	unlinkat(t_mnt_fd, BTRFS_SUBVOLUME_MNT, AT_REMOVEDIR);
+
+	return fret;
+}
+
 static void usage(void)
 {
 	fprintf(stderr, "Description:\n");
@@ -9533,20 +13160,25 @@ static void usage(void)
 	fprintf(stderr, "--supported                  Test whether idmapped mounts are supported on this filesystem\n");
 	fprintf(stderr, "--test-core                  Run core idmapped mount testsuite\n");
 	fprintf(stderr, "--test-fscaps-regression     Run fscap regression tests\n");
+	fprintf(stderr, "--scratch-mountpoint         Mountpoint of scratch device used in the tests\n");
+	fprintf(stderr, "--scratch-device             Scratch device used in the tests\n");
 
 	_exit(EXIT_SUCCESS);
 }
 
 static const struct option longopts[] = {
-	{"device",			required_argument,	0,	1},
-	{"fstype",			required_argument,	0,	2},
-	{"mountpoint",			required_argument,	0,	3},
-	{"supported",			no_argument,		0,	4},
-	{"help",			no_argument,		0,	5},
-	{"test-core",			no_argument,		0,	6},
-	{"test-fscaps-regression",	no_argument,		0,	7},
-	{"test-nested-userns",		no_argument,		0,	8},
-	{NULL,				0,			0,	0},
+	{"device",			required_argument,	0,	 1},
+	{"fstype",			required_argument,	0,	 2},
+	{"mountpoint",			required_argument,	0,	 3},
+	{"supported",			no_argument,		0,	 4},
+	{"help",			no_argument,		0,	 5},
+	{"test-core",			no_argument,		0,	 6},
+	{"test-fscaps-regression",	no_argument,		0,	 7},
+	{"test-nested-userns",		no_argument,		0,	 8},
+	{"test-btrfs",			no_argument,		0,	 9},
+	{"scratch-mountpoint",		required_argument,	0,	10},
+	{"scratch-device",		required_argument,	0,	11},
+	{NULL,				0,			0,	 0},
 };
 
 struct t_idmapped_mounts {
@@ -9612,6 +13244,31 @@ struct t_idmapped_mounts t_nested_userns[] = {
 	{ nested_userns,						"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
 };
 
+struct t_idmapped_mounts t_btrfs[] = {
+	{ btrfs_subvolumes_fsids_mapped,				"test subvolumes with mapped fsids",								},
+	{ btrfs_subvolumes_fsids_mapped_userns,				"test subvolumes with mapped fsids inside user namespace",					},
+	{ btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed,		"test subvolume deletion with user_subvol_rm_allowed mount option",				},
+	{ btrfs_subvolumes_fsids_mapped_userns_user_subvol_rm_allowed,	"test subvolume deletion with user_subvol_rm_allowed mount option inside user namespace",	},
+	{ btrfs_subvolumes_fsids_unmapped,				"test subvolumes with unmapped fsids",								},
+	{ btrfs_subvolumes_fsids_unmapped_userns,			"test subvolumes with unmapped fsids inside user namespace",					},
+	{ btrfs_snapshots_fsids_mapped,					"test snapshots with mapped fsids",								},
+	{ btrfs_snapshots_fsids_mapped_userns,				"test snapshots with mapped fsids inside user namespace",					},
+	{ btrfs_snapshots_fsids_mapped_user_subvol_rm_allowed,		"test snapshots deletion with user_subvol_rm_allowed mount option",				},
+	{ btrfs_snapshots_fsids_mapped_userns_user_subvol_rm_allowed,	"test snapshots deletion with user_subvol_rm_allowed mount option inside user namespace",	},
+	{ btrfs_snapshots_fsids_unmapped,				"test snapshots with unmapped fsids",								},
+	{ btrfs_snapshots_fsids_unmapped_userns,			"test snapshots with unmapped fsids inside user namespace",					},
+	{ btrfs_delete_by_spec_id,					"test subvolume deletion by spec id",								},
+	{ btrfs_subvolumes_setflags_fsids_mapped,			"test subvolume flags with mapped fsids",							},
+	{ btrfs_subvolumes_setflags_fsids_mapped_userns,		"test subvolume flags with mapped fsids inside user namespace",					},
+	{ btrfs_subvolumes_setflags_fsids_unmapped,			"test subvolume flags with unmapped fsids",							},
+	{ btrfs_subvolumes_setflags_fsids_unmapped_userns,		"test subvolume flags with unmapped fsids inside user namespace",				},
+	{ btrfs_snapshots_setflags_fsids_mapped,			"test snapshots flags with mapped fsids",							},
+	{ btrfs_snapshots_setflags_fsids_mapped_userns,			"test snapshots flags with mapped fsids inside user namespace",					},
+	{ btrfs_snapshots_setflags_fsids_unmapped,			"test snapshots flags with unmapped fsids",							},
+	{ btrfs_snapshots_setflags_fsids_unmapped_userns,		"test snapshots flags with unmapped fsids inside user namespace",				},
+	{ btrfs_subvolume_lookup_user,					"test unprivileged subvolume lookup",								},
+};
+
 static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 {
 	int i;
@@ -9649,7 +13306,7 @@ int main(int argc, char *argv[])
 {
 	int fret, ret;
 	int index = 0;
-	bool supported = false, test_core = false,
+	bool supported = false, test_btrfs = false, test_core = false,
 	     test_fscaps_regression = false, test_nested_userns = false;
 
 	while ((ret = getopt_long(argc, argv, "", longopts, &index)) != -1) {
@@ -9675,6 +13332,15 @@ int main(int argc, char *argv[])
 		case 8:
 			test_nested_userns = true;
 			break;
+		case 9:
+			test_btrfs = true;
+			break;
+		case 10:
+			t_mountpoint_scratch = optarg;
+			break;
+		case 11:
+			t_device_scratch = optarg;
+			break;
 		case 5:
 			/* fallthrough */
 		default:
@@ -9703,6 +13369,10 @@ int main(int argc, char *argv[])
 	if (t_mnt_fd < 0)
 		die("failed to open %s", t_mountpoint);
 
+	t_mnt_scratch_fd = openat(-EBADF, t_mountpoint_scratch, O_CLOEXEC | O_DIRECTORY);
+	if (t_mnt_fd < 0)
+		die("failed to open %s", t_mountpoint_scratch);
+
 	/*
 	 * Caller just wants to know whether the filesystem we're on supports
 	 * idmapped mounts.
@@ -9756,6 +13426,9 @@ int main(int argc, char *argv[])
 	    !run_test(t_nested_userns, ARRAY_SIZE(t_nested_userns)))
 		goto out;
 
+	if (test_btrfs && !run_test(t_btrfs, ARRAY_SIZE(t_btrfs)))
+		goto out;
+
 	fret = EXIT_SUCCESS;
 
 out:
diff --git a/tests/btrfs/242 b/tests/btrfs/242
new file mode 100755
index 00000000..bb833842
--- /dev/null
+++ b/tests/btrfs/242
@@ -0,0 +1,34 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Christian Brauner.  All Rights Reserved.
+#
+# FS QA Test 242
+#
+# Test that idmapped mounts behave correctly with btrfs specific features such
+# as subvolume and snapshot creation and deletion.
+#
+. ./common/preamble
+_begin_fstest auto quick idmapped subvolume
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_idmapped_mounts
+_require_test
+_require_scratch
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount "-o user_subvol_rm_allowed" >> $seqres.full
+
+echo "Silence is golden"
+
+$here/src/idmapped-mounts/idmapped-mounts --test-btrfs --device "$TEST_DEV" \
+	--mountpoint "$TEST_DIR" --scratch-device "$SCRATCH_DEV" \
+	--scratch-mountpoint "$SCRATCH_MNT" --fstype "$FSTYP"
+
+status=$?
+exit
diff --git a/tests/btrfs/242.out b/tests/btrfs/242.out
new file mode 100644
index 00000000..a46d7770
--- /dev/null
+++ b/tests/btrfs/242.out
@@ -0,0 +1,2 @@
+QA output created by 242
+Silence is golden

base-commit: 4b1e66c2544b61d55ac0e8d58601bbade31d9f59
-- 
2.30.2

