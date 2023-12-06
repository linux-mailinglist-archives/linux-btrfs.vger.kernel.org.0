Return-Path: <linux-btrfs+bounces-725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC08078FA
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 20:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8915B20F9D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 19:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD186EB75;
	Wed,  6 Dec 2023 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="6PVCOHgv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3F62D46
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 11:52:27 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id K7rM2B00T04l9eU017rNWw; Wed, 06 Dec 2023 19:51:22 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>,
	Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/4] btrfs-info: some utility to query a filesystem info
Date: Wed,  6 Dec 2023 20:32:42 +0100
Message-ID: <43518c3559b4cb77b4ad9c246b1ecb39e83e6c77.1701891165.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701891165.git.kreijack@inwind.it>
References: <cover.1701891165.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1701892282; bh=Pb+hMyO5ZBB6J8+Yj9zlblmzKVIodY09KhRM0RLucng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=6PVCOHgvr/yuRaXPS7jyulMtY6Qsgb/jceSBTjU0+6c/M/G1coh/Y82defT9CppCA
	 jBeY3fy3ssOVTc7KMBUEkV9X12aNTpeWkBBJzLfbAwDiX1YnKeB1pnOmLyuVsv6VXT
	 Rr+dhcFOwLgdTlcSxMtupgyHBLB8TsC+Qe3t3kUc=

From: Goffredo Baroncelli <kreijack@inwind.it>

btrfs_info_XXX are a set of function to query the layout of a btrfs
filesystem.

Example:

	const struct btrfs_info *bi;
	int r = btrfs_info_find(path, &bi);
	if (r < 0) {
		printf("Error: %d - %s\n", -r, strerror(-r));
		return;
	}

	print("Label: %s\n", bi->label);
	print("UUID: %s\n", bi->uuid);

	printf("Devices:");
	for (const struct btrfs_info_device *bid = bi->devices ;
		bid ; bid = bid->next)
			printf("\t%s\n", bid->name);

	if (bi->mounts) {
		printf("Mounts:")
		for (const btrfs_info_mount *bim = bi->mounts ;
			bim ; bim = bim->next )
				print("\t%s\n", bim->dest);
	}


The client doesn't have to manage any memory allocation/deletion.
The functions return an internal list build on the basis of the
information returned by /proc/self/mountinfo and libblkid.
It is not required to be root; however only root can access
the devid of the devices.

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 Makefile            |    1 +
 common/btrfs-info.c | 1036 +++++++++++++++++++++++++++++++++++++++++++
 common/btrfs-info.h |  220 +++++++++
 3 files changed, 1257 insertions(+)
 create mode 100644 common/btrfs-info.c
 create mode 100644 common/btrfs-info.h

diff --git a/Makefile b/Makefile
index b7585674..2182bf03 100644
--- a/Makefile
+++ b/Makefile
@@ -213,6 +213,7 @@ objects = \
 	common/parse-utils.o	\
 	common/path-utils.o	\
 	common/rbtree-utils.o	\
+	common/btrfs-info.o	\
 	common/send-stream.o	\
 	common/send-utils.o	\
 	common/sort-utils.o	\
diff --git a/common/btrfs-info.c b/common/btrfs-info.c
new file mode 100644
index 00000000..d5c508f2
--- /dev/null
+++ b/common/btrfs-info.c
@@ -0,0 +1,1036 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#include <blkid/blkid.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/sysmacros.h>
+#include <string.h>
+#include <errno.h>
+#include <assert.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <inttypes.h>
+
+#include "common/btrfs-info.h"
+#include "kernel-shared/ctree.h"
+
+static void free_info_dev(struct btrfs_info_device *pdev)
+{
+	if (pdev) {
+		free((char *)pdev->name);
+		free((char *)pdev->uuid_sub);
+		free((char *)pdev->partuuid);
+	}
+	free(pdev);
+}
+
+static void free_info_mount(struct btrfs_info_mount *p)
+{
+	if (p) {
+		free((char *)p->subvol);
+		free((char *)p->rootpath);
+		free((char *)p->dest);
+		free((char *)p->options);
+	}
+	free(p);
+}
+
+static void btrfs_info_free(struct btrfs_info *p)
+{
+	while (p) {
+		struct btrfs_info *pnext2;
+
+		pnext2 = (struct btrfs_info *)p->next;
+
+		free((char *)p->uuid);
+		free((char *)p->label);
+
+		struct btrfs_info_device *pdev;
+
+		pdev = (struct btrfs_info_device *)p->devices;
+		while (pdev) {
+			struct btrfs_info_device *pnext;
+
+			pnext = (struct btrfs_info_device *)pdev->next;
+
+			free_info_dev(pdev);
+			pdev = pnext;
+		}
+
+		struct btrfs_info_mount *pmnt;
+
+		pmnt = (struct btrfs_info_mount *)p->mounts;
+		while (pmnt) {
+			struct btrfs_info_mount *pnext;
+			pnext = (struct btrfs_info_mount *)pmnt->next;
+
+			free_info_mount(pmnt);
+			pmnt = pnext;
+		}
+
+		free(p);
+		p = pnext2;
+	}
+}
+
+static int get_dev_id(const char *devname, const char *uuid_sub, uint64_t *ret)
+{
+	*ret = (uint64_t)-1;
+
+	if (access(devname, R_OK))
+		return 0;
+
+	int fd = open(devname, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	int64_t offsets[] = { 64*1024, 64*1024*1024, 256 * 1024*1024*1024llu, 0 };
+	int j;
+
+	for (j = 0 ; offsets[j] ; j++) {
+
+		struct btrfs_super_block sb;
+		int r = lseek(fd, offsets[j], SEEK_SET);
+		if (r < 0)
+			continue;
+
+		int l = read(fd, &sb, sizeof(sb));
+		if (l != sizeof(sb))
+			continue;
+
+		/*
+		 * TODO: check:
+		 * - cksum
+		 */
+
+		if (le64_to_cpu(sb.magic) != BTRFS_MAGIC)
+			continue;
+
+		unsigned char *p = sb.dev_item.uuid;
+		const char *p2 = uuid_sub;
+		int i;
+
+		for (i = 0; i < BTRFS_UUID_SIZE ; i++, p++, p2 += 2) {
+			if (*p2 == '-')
+				p2++;
+			if (!*p2 || !*(p2+1))
+				break;
+
+			char buf[3] = { *p2, *(p2+1), 0 };
+			unsigned char v = (unsigned char)strtoul(buf, NULL, 16);
+
+			if (v != *p)
+				break;
+		}
+		if (i < BTRFS_UUID_SIZE)
+			continue;
+
+		*ret = le64_to_cpu(sb.dev_item.devid);
+		return 0;
+	}
+	close(fd);
+	return -EINVAL;
+
+}
+
+static int append_btrfs_info_device(struct btrfs_info *bi, const char *name,
+				    const char *uuid_sub, const char *partuuid,
+				    int major, int minor)
+{
+	struct btrfs_info_device *p = NULL;
+
+	p = calloc(1, sizeof(struct btrfs_info_device));
+	if (!p)
+		goto nomem;
+
+	if (get_dev_id(name, uuid_sub, &p->devid) < 0)
+		goto nomem;
+
+	if (!name)
+		name = "";
+	p->name = strdup(name);
+	if (!p->name)
+		goto nomem;
+
+	p->uuid_sub = strdup(uuid_sub);
+	if (!p->uuid_sub)
+		goto nomem;
+
+	if (!partuuid)
+		partuuid = "";
+	p->partuuid = strdup(partuuid);
+	if (!p->partuuid)
+		goto nomem;
+
+	p->major = major;
+	p->minor = minor;
+
+	p->next = bi->devices;
+	bi->devices = p;
+
+	return 0;
+
+nomem:
+	free_info_dev(p);
+	return -ENOMEM;
+
+}
+
+static int append_or_get_btrfs_info(const char *uuid,
+				    struct btrfs_info **root,
+				    struct btrfs_info **ret)
+{
+	const struct btrfs_info *pc;
+
+	for (pc = *root ; pc ; pc = pc->next)
+		if (!strcmp(pc->uuid, uuid)) {
+			*ret = (struct btrfs_info *)pc;
+			return 0;
+		}
+
+	struct btrfs_info *p;
+
+	p = calloc(1, sizeof(struct btrfs_info));
+	if (!p) {
+		*ret = NULL;
+		return -ENOMEM;
+	}
+
+	p->uuid = strdup(uuid);
+	if (!p->uuid) {
+		free(p);
+		*ret = NULL;
+		return -ENOMEM;
+	}
+
+	p->next = *root;
+	*ret = *root = p;
+
+	return 0;
+}
+
+void btrfs_info_dump_single_entry(const struct btrfs_info *p, FILE *o)
+{
+	fprintf(o, "UUID:    %s\n", p->uuid);
+	fprintf(o, "LABEL:   %s\n", p->label);
+
+	fprintf(o, "devices:\n");
+	const struct btrfs_info_device *pdev;
+
+	for (pdev = p->devices ; pdev ; pdev = pdev->next) {
+		fprintf(o, "\tdev:      %s\n", pdev->name);
+		fprintf(o, "\tUUID_SUB: %s\n", pdev->uuid_sub);
+		fprintf(o, "\tPARTUUID: %s\n", pdev->partuuid);
+		fprintf(o, "\tmajor:    %d\n", pdev->major);
+		fprintf(o, "\tminor:    %d\n", pdev->minor);
+		fprintf(o, "\tdevid:    %" PRIu64 "\n", pdev->devid);
+		fprintf(o, "\n");
+	}
+
+	fprintf(o, "mounts:\n");
+	const struct btrfs_info_mount *pmnt;
+
+	for (pmnt = p->mounts ; pmnt ; pmnt = pmnt->next) {
+		fprintf(o, "\tdest:     %s\n", pmnt->dest);
+		fprintf(o, "\trootpath: %s\n", pmnt->rootpath);
+		fprintf(o, "\tsubvol:   %s\n", pmnt->subvol);
+		fprintf(o, "\toptions:  %s\n", pmnt->options);
+		fprintf(o, "\tseq:      %d\n", pmnt->seq);
+		fprintf(o, "\tover:     %d\n", pmnt->over);
+		fprintf(o, "\n");
+	}
+
+	fprintf(o, "\n");
+}
+
+void btrfs_info_dump(const struct btrfs_info *p, FILE *o)
+{
+	for (; p ; p = (struct btrfs_info *)p->next)
+		btrfs_info_dump_single_entry(p, o);
+}
+
+/*
+ * /proc/self/mountinfo escapes space, '\' and comma with the sequence
+ * \ooo
+ */
+static char *unescape(char *src)
+{
+	if (!src)
+		return NULL;
+
+	char *p, *s;
+
+	p = s = src;
+
+	while (*s) {
+		if (*s != '\\') {
+			*p++ = *s++;
+			continue;
+		}
+
+		/* convert \xxx to a char value */
+		s++; /* skip '\' */
+
+		int v, i;
+
+		for (v = 0, i = 0 ; i < 3 ; i++) {
+			assert(isdigit(*s));
+			v = v * 8 + *s++ - '0';
+		}
+		*p++ = v;
+	}
+	*p = 0;
+	return src;
+}
+
+static char *find_subvol(const char *options)
+{
+	const char *p1 = options;
+
+	while (p1) {
+		const char *p2 = strchr(p1, ',');
+		if (!p2) {
+			p2 = p1;
+			while (*p2)
+				p2++;
+		}
+
+		/* NB: strlen(subvol=) == 7 */
+		if (strncmp(p1, "subvol=", 7)) {
+			p1 = p2;
+			if (*p1)
+				p1++;
+			continue;
+		}
+
+		p1 += 7;
+		int l = p2 - p1 + 1;
+
+		char *dest = malloc(l);
+		if (!dest)
+			return NULL;
+
+		strncpy(dest, p1, l);
+		return dest;
+	}
+	return strdup("");
+}
+
+static int add_mounts(struct btrfs_info *root,
+		      int seq, int over, const char *rootpath, const char *dest,
+		      const char *options1, const char *options2,
+		      const char *dev)
+{
+	struct stat st;
+	const struct btrfs_info *bi;
+	int mj, mn, l;
+	struct btrfs_info_mount *pmnt;
+
+	stat(dev, &st);
+	mj = major(st.st_rdev);
+	mn = minor(st.st_rdev);
+
+	for (bi = root ; bi ; bi = bi->next) {
+		const struct btrfs_info_device *bdev;
+
+		for (bdev = bi->devices ; bdev ; bdev = bdev->next) {
+			if (bdev->major == mj && bdev->minor == mn)
+				break;
+		}
+		if (bdev)
+			break;
+	}
+
+	if (!bi)
+		return -ENOENT;
+
+	pmnt = calloc(1, sizeof(struct btrfs_info_mount));
+	if (!pmnt)
+		goto nomem;
+
+	pmnt->dest = unescape(strdup(dest));
+	if (!pmnt->dest)
+		goto nomem;
+
+	pmnt->rootpath = unescape(strdup(rootpath));
+	if (!pmnt->dest)
+		goto nomem;
+
+	l = strlen(options1) + strlen(options2) + 2;
+	pmnt->options = malloc(l);
+	if (!pmnt->options)
+		goto nomem;
+
+	strcpy((char *)pmnt->options, options1);
+	strcat((char *)pmnt->options, ",");
+	strcat((char *)pmnt->options, options2);
+
+	pmnt->subvol = unescape(find_subvol(pmnt->options));
+	if (!pmnt->subvol)
+		goto nomem;
+
+	pmnt->seq = seq;
+	pmnt->over = over;
+
+	pmnt->next = bi->mounts;
+	((struct btrfs_info *)bi)->mounts = pmnt;
+
+	return 0;
+
+nomem:
+	free_info_mount(pmnt);
+	return -ENOMEM;
+}
+
+struct _btrfs_info_dest {
+	const char *dest;
+	int seq;
+
+	struct _btrfs_info_dest *next;
+};
+
+static void free_info_dests(struct _btrfs_info_dest *p)
+{
+	while (p) {
+		struct _btrfs_info_dest *pnext = p->next;
+
+		free((char *)p->dest);
+		free(p);
+		p = pnext;
+	}
+}
+
+static int add_info_dest(struct _btrfs_info_dest **info_dests,
+			 const char *dest, int seq)
+{
+	struct _btrfs_info_dest *bi_dest;
+
+	bi_dest = calloc(1, sizeof(struct _btrfs_info_dest));
+	if (!bi_dest)
+		return -ENOMEM;
+
+	bi_dest->dest = strdup(dest);
+	if (!bi_dest->dest) {
+		free(bi_dest);
+		return -ENOMEM;
+	}
+
+	bi_dest->seq = seq;
+
+	bi_dest->next = *info_dests;
+	*info_dests = bi_dest;
+
+	return 0;
+}
+
+static int btrfs_info_init(struct btrfs_info **root_ret,
+			   struct _btrfs_info_dest **info_dests_ret)
+{
+	int r;
+	blkid_cache cache;
+	blkid_dev_iterate iter;
+	blkid_dev dev;
+	struct btrfs_info *root = NULL;
+	struct _btrfs_info_dest *info_dests = NULL;
+	FILE *fp = NULL;
+	char buf[2048];
+	int ret;
+
+	*root_ret = NULL;
+	*info_dests_ret = NULL;
+
+	r = blkid_get_cache(&cache, NULL);
+	if (r < 0) {
+		fprintf(stderr, "ERROR: cannot load cache\n");
+		return -EACCES;
+	}
+
+	iter = blkid_dev_iterate_begin(cache);
+	blkid_dev_set_search(iter, "TYPE", "btrfs");
+	while (!blkid_dev_next(iter, &dev)) {
+		struct stat st;
+		const char *n = blkid_dev_devname(dev);
+		struct btrfs_info *p;
+		const char *l, *uuid, *uuid_sub, *partuuid;
+
+		uuid = blkid_get_tag_value(cache, "UUID", n);
+		uuid_sub = blkid_get_tag_value(cache, "UUID_SUB", n);
+		r = append_or_get_btrfs_info(uuid, &root, &p);
+
+		if (r < 0) {
+			fprintf(stderr, "ERROR: not enough memory\n");
+			blkid_dev_iterate_end(iter);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		l = blkid_get_tag_value(cache, "LABEL", n);
+		if (l) {
+			p->label = strdup(l);
+			if (!p->label) {
+				fprintf(stderr, "ERROR: not enough memory\n");
+				blkid_dev_iterate_end(iter);
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+
+		partuuid = blkid_get_tag_value(cache, "PARTUUID", n);
+
+		r = stat(n, &st);
+		if (r < 0) {
+			fprintf(stderr, "ERROR: cannot stat '%s'\n", n);
+			blkid_dev_iterate_end(iter);
+			ret = -ENODEV;
+			goto out;
+		}
+
+		r = append_btrfs_info_device(p, n, uuid_sub, partuuid,
+					     major(st.st_rdev), minor(st.st_rdev));
+		if (r < 0) {
+			fprintf(stderr, "ERROR: not enough memory\n");
+			blkid_dev_iterate_end(iter);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+	}
+	blkid_dev_iterate_end(iter);
+
+	fp = fopen("/proc/self/mountinfo", "r");
+	if (!fp) {
+		int e = errno;
+
+		fprintf(stderr, "ERROR: cannot open '/proc/self/mountinfo': %s [%d]\n",
+		    strerror(e), e);
+		ret = -EACCES;
+		goto out;
+	}
+
+	while (fgets(buf, 2047, fp) != NULL) {
+		int l = strlen(buf);
+		char *tk;
+		char *dest = NULL, *subvol = NULL, *options1 = NULL;
+		char *devname = NULL, *options2 = NULL;
+		int seq = -1, i, over = -1;
+		int skip = 0;
+
+		if (l < 1)
+			continue;
+		if (buf[l-1] != '\n') {
+			fprintf(stderr, "ERROR: line too long in '/proc/self/mountinfo'\n");
+			ret = -E2BIG;
+			goto out;
+		}
+
+		buf[l-1] = 0;
+
+		for (tk = strtok(buf, " "), i = 0;
+		     tk;
+		     tk = strtok(NULL, " "), i++) {
+			switch (i) {
+			case 0:
+				seq = atoi(tk);
+				break;
+			case 1:
+				over = atoi(tk);
+				break;
+			case 3:
+				subvol = tk;
+				break;
+			case 4:
+				dest = tk;
+				break;
+			case 5:
+				options1 = tk;
+				break;
+			case 8:
+				if (strcmp(tk, "btrfs"))
+					skip = 1;
+				break;
+			case 9:
+				devname = tk;
+				break;
+			case 10:
+				options2 = tk;
+				break;
+			}
+		}
+
+		if (add_info_dest(&info_dests, dest, seq) < 0) {
+			fprintf(stderr, "ERROR: not enough memory\n");
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		if (skip)
+			continue;
+
+		r = add_mounts(root, seq, over, subvol, dest,
+			       options1, options2, devname);
+		if (r < 0) {
+			fprintf(stderr, "ERROR: not enough memory\n");
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	ret = 0;
+out:
+
+	if (ret) {
+		btrfs_info_free(root);
+		free_info_dests(info_dests);
+	} else {
+		*root_ret = root;
+		*info_dests_ret = info_dests;
+	}
+	if (fp)
+		fclose(fp);
+	return ret;
+
+}
+
+static struct btrfs_info *_btrfs_info_global; /* default to NULL */
+static struct _btrfs_info_dest *_btrfs_info_dests_global; /* default to NULL */
+
+int btrfs_info_get(const struct btrfs_info **ret)
+{
+	int r = 0;
+	if (!_btrfs_info_global)
+		r = btrfs_info_init(&_btrfs_info_global,
+				    &_btrfs_info_dests_global);
+
+	if (ret)
+		*ret = _btrfs_info_global;
+	return r;
+}
+
+int btrfs_info_refresh(const struct btrfs_info **ret)
+{
+	if (_btrfs_info_global) {
+		btrfs_info_free(_btrfs_info_global);
+		free_info_dests(_btrfs_info_dests_global);
+		_btrfs_info_global = NULL;
+		_btrfs_info_dests_global = NULL;
+	}
+	return btrfs_info_get(ret);
+}
+
+int btrfs_info_find_by_label(const char *label, const struct btrfs_info **ret)
+{
+	const struct btrfs_info *root;
+
+	if (ret)
+		*ret = NULL;
+
+	int r = btrfs_info_get(&root);
+	if (r)
+		return r;
+
+	const struct btrfs_info *p;
+
+	for (p = root; p ; p = p->next) {
+		if (!strcmp(p->label, label)) {
+			if (ret)
+				*ret = p;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+int btrfs_info_find_by_uuid(const char *uuid, const struct btrfs_info **ret)
+{
+	const struct btrfs_info *root;
+
+	if (ret)
+		*ret = NULL;
+
+	int r = btrfs_info_get(&root);
+	if (r)
+		return r;
+
+	const struct btrfs_info *p;
+
+	for (p = root; p ; p = p->next) {
+		if (!strcasecmp(p->uuid, uuid)) {
+			if (ret)
+				*ret = p;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+int btrfs_info_find_by_dev(const char *dev, const struct btrfs_info **ret,
+			    const char **retdev)
+{
+
+	if (ret)
+		*ret = NULL;
+	if (retdev)
+		*retdev = NULL;
+
+	struct stat st;
+	int r;
+
+	r = stat(dev, &st);
+	if (r)
+		return -EINVAL;
+
+	int mj, mn;
+
+	mj = major(st.st_rdev);
+	mn = minor(st.st_rdev);
+
+	const struct btrfs_info *root;
+
+	r = btrfs_info_get(&root);
+	if (r)
+		return r;
+
+	const struct btrfs_info *p;
+
+	for (p = root ; p ; p = p->next) {
+		const struct btrfs_info_device *d;
+
+		for (d = p->devices; d ; d = d->next) {
+			if (mj == d->major && mn == d->minor) {
+				if (ret)
+					*ret = p;
+				if (retdev)
+					*retdev = d->name;
+				return 0;
+			}
+		}
+	}
+
+	return -ENOENT;
+}
+
+int btrfs_info_find_by_uuid_sub(const char *uuid_sub,
+				const struct btrfs_info **ret,
+				const char **retdev)
+{
+	if (ret)
+		*ret = NULL;
+	if (retdev)
+		*retdev = NULL;
+
+	const struct btrfs_info *root;
+	int r = btrfs_info_get(&root);
+	if (r)
+		return r;
+
+	const struct btrfs_info *p;
+	for (p = root; p ; p = p->next) {
+		const struct btrfs_info_device *d;
+
+		for (d = p->devices; d ; d = d->next) {
+			if (!strcmp(uuid_sub, d->uuid_sub)) {
+				if (ret)
+					*ret = p;
+				if (retdev)
+					*retdev = d->name;
+				return 0;
+			}
+		}
+	}
+
+	return -ENOENT;
+}
+
+int btrfs_info_find_by_partuuid(const char *partuuid,
+				const struct btrfs_info **ret,
+				const char **retdev)
+{
+
+	if (ret)
+		*ret = NULL;
+	if (retdev)
+		*retdev = NULL;
+
+	const struct btrfs_info *root;
+	int r = btrfs_info_get(&root);
+	if (r)
+		return r;
+
+	const struct btrfs_info *p;
+
+	for (p = root; p ; p = p->next) {
+		const struct btrfs_info_device *d;
+
+		for (d = p->devices; d ; d = d->next) {
+			if (!strcmp(partuuid, d->partuuid)) {
+				if (ret)
+					*ret = p;
+				if (retdev)
+					*retdev = d->name;
+				return 0;
+			}
+		}
+	}
+
+	return -ENOENT;
+}
+
+int btrfs_info_find_by_path(const char *path,
+			    const struct btrfs_info **ret)
+{
+	if (ret)
+		*ret = NULL;
+
+	/* fill the cache */
+	const struct btrfs_info *root;
+	int r = btrfs_info_get(&root);
+	if (r) {
+		/* if /proc or /sys aren't available, return path */
+		return r;
+	}
+
+	/*
+	 * search in all the possible mount points first, then look for the found seq
+	 */
+	int seq = -1;
+	struct _btrfs_info_dest *bi_dest;
+
+	for (bi_dest = _btrfs_info_dests_global; bi_dest; bi_dest = bi_dest->next) {
+		int l = strlen(bi_dest->dest);
+		if (strncmp(bi_dest->dest, path, l))
+			continue;
+		/*
+		 * search for the highest seq
+		 */
+		if (seq != -1 && seq > bi_dest->seq)
+			continue;
+
+		seq = bi_dest->seq;
+	}
+
+	/*
+	 * look if seq is a valid btrfs mountpoint
+	 */
+	const struct btrfs_info *p;
+
+	for (p = root ; p ; p = p->next) {
+		const struct btrfs_info_mount *pm;
+
+		for (pm = p->mounts ; pm ; pm = pm->next)
+			if (pm->seq == seq) {
+				if (ret)
+					*ret = p;
+				return 0;
+			}
+	}
+
+	return -ENOENT;
+}
+
+int btrfs_info_find(const char *filter, const struct btrfs_info **ret)
+{
+
+	if (ret)
+		*ret = NULL;
+
+	if (!strncmp(filter, "LABEL=", 6))
+		return btrfs_info_find_by_label(filter + 6, ret);
+
+	if (!strncmp(filter, "UUID=", 5))
+		return btrfs_info_find_by_uuid(filter + 5, ret);
+
+	if (!strncmp(filter, "UUID_SUB=", 9))
+		return btrfs_info_find_by_uuid_sub(filter + 9, ret, NULL);
+
+	if (!strncmp(filter, "PARTUUID=", 9))
+		return btrfs_info_find_by_partuuid(filter + 9, ret, NULL);
+
+	struct stat st;
+	int r;
+
+	r = stat(filter, &st);
+	if (r < 0) {
+		fprintf(stderr, "ERROR: cannot access '%s'\n", filter);
+		return -EINVAL;
+	}
+	if (S_ISBLK(st.st_mode))
+		return btrfs_info_find_by_dev(filter, ret, NULL);
+
+	char *path = realpath(filter, NULL);
+	if (!path) {
+		fprintf(stderr, "ERROR: in realpath(%s)\n", filter);
+		return -EINVAL;
+	}
+
+	r = btrfs_info_find_by_path(path, ret);
+	free(path);
+
+	return r;
+}
+
+const char *btrfs_info_find_valid_path(const struct btrfs_info *bfs)
+{
+	const struct btrfs_info_mount *pm;
+	const char *ret = NULL;
+
+	for (pm = bfs->mounts ; pm ; pm = pm->next) {
+		int seq = -1;
+		struct _btrfs_info_dest *bi_dest;
+
+		for (bi_dest = _btrfs_info_dests_global; bi_dest; bi_dest = bi_dest->next) {
+			int l = strlen(bi_dest->dest);
+
+			if (strncmp(bi_dest->dest, pm->dest, l))
+				continue;
+
+			/*
+			 * search for the highest seq
+			 */
+			if (seq != -1 && seq > bi_dest->seq)
+				continue;
+
+			seq = bi_dest->seq;
+		}
+
+		if (seq != pm->seq)
+			continue;
+		if (access(pm->dest, R_OK|X_OK))
+			continue;
+
+		/*
+		 * search for the shortest path
+		 */
+		if (!ret || strlen(ret) > strlen(pm->dest))
+			ret = pm->dest;
+	}
+
+	return ret;
+}
+
+const char *btrfs_info_find_valid_dev(const struct btrfs_info *bfs)
+{
+	const struct btrfs_info_device *pd;
+
+	for (pd = bfs->devices ; pd ; pd = pd->next) {
+		if (access(pd->name, R_OK|X_OK))
+			return pd->name;
+	}
+
+	return NULL;
+}
+
+
+int btrfs_info_find_dev(const char *filter,
+			const struct btrfs_info **inforet,
+			const char **retdev)
+{
+	int r;
+
+	if (!strncmp(filter, "UUID_SUB=", 9)) {
+		r = btrfs_info_find_by_uuid_sub(filter + 9, inforet, retdev);
+		if (r < 0)
+			*retdev = NULL;
+	} else if (!strncmp(filter, "PARTUUID=", 9)) {
+		r = btrfs_info_find_by_partuuid(filter + 9, inforet, retdev);
+		if (r < 0)
+			*retdev = NULL;
+	} else {
+		r = btrfs_info_find_by_dev(filter, inforet, retdev);
+		if (r < 0)
+			*retdev = filter;
+	}
+
+	return r;
+}
+
+#ifdef TEST
+/*
+ * compile with:
+ * gcc -DTEST  -Wall -I.. -I../include -o /tmp/btrfs-info btrfs-info.c -lblkid
+ */
+int main(int argc, char **argv)
+{
+
+	if (argc == 1) {
+		struct btrfs_info *root = NULL;
+		struct _btrfs_info_dest *dest_root = NULL;
+
+		btrfs_info_init(&root, &dest_root);
+		btrfs_info_dump(root, stdout);
+		btrfs_info_free(root);
+		free_info_dests(dest_root);
+
+		return 0;
+	}
+
+	int i = 1;
+
+	while (i < argc) {
+
+		const char *filter = argv[i];
+		const char *retdev = NULL;
+		const char *retpath = NULL;
+		const struct btrfs_info *info;
+		int r;
+
+		if (!strncmp(argv[i], "/dev/", 5) ||
+		    !strncmp(argv[i], "PARTUUID=", 9) ||
+		    !strncmp(argv[i], "UUID_SUB=", 9)) {
+			/* search by dev */
+			r = btrfs_info_find_dev(filter, &info, &retdev);
+			if (!r)
+				retpath = btrfs_info_find_valid_path(info);
+		} else if (!strncmp(argv[i], "UUID=", 5) ||
+			   !strncmp(argv[i], "LABEL=", 6)) {
+			/* search by a filesystem ID */
+			r = btrfs_info_find(filter, &info);
+			if (!r) {
+				retpath = btrfs_info_find_valid_path(info);
+				retdev = btrfs_info_find_valid_dev(info);
+			}
+		} else {
+			/* search by path */
+			r = btrfs_info_find(filter, &info);
+			if (!r) {
+				retpath = filter;
+				retdev = btrfs_info_find_valid_dev(info);
+			}
+		}
+
+		if (r) {
+			fprintf(stderr, "ERROR: cannot find info about '%s'; %s [%d]\n",
+				argv[i], strerror(-r), -r);
+			i += 1;
+			continue;
+		}
+		printf("%s:\n", argv[i]);
+		btrfs_info_dump_single_entry(info, stdout);
+		printf("\n");
+
+		printf("path: %s\n", retpath);
+		printf("dev:  %s\n", retdev);
+		i++;
+	}
+
+	return 0;
+}
+
+#endif
diff --git a/common/btrfs-info.h b/common/btrfs-info.h
new file mode 100644
index 00000000..791ae4f7
--- /dev/null
+++ b/common/btrfs-info.h
@@ -0,0 +1,220 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#pragma once
+
+#include <stdint.h>
+
+struct btrfs_info_device {
+	int major, minor;
+	uint64_t devid;		/* only if invoked by root */
+	const char *name;
+	const char *uuid_sub;
+	const char *partuuid;
+
+	const struct btrfs_info_device *next;
+};
+
+struct btrfs_info_mount {
+	const char *dest;	/* dest dir of mount */
+	const char *rootpath;	/* src dir of mount */
+	const char *subvol;	/* subvol which contains src dir */
+	const char *options;	/* comma separated options */
+	int seq, over;
+
+	const struct btrfs_info_mount *next;
+};
+/*
+ * Two words about the differences between 'rootpath' and 'subvol'.
+ * VFS doesn't have the concept of subvol. But it has the concept to mount a
+ * subdir of a filesystem.
+ * BTRFS uses this capability to mount a subvolume of a filesystem using
+ * the -o subvol=<subvolpath> syntax. But this is equal to the more generic syntax
+ * -o X-mount.subdir=<subvolpath> . In the latter case you are not limited to
+ * mount a subvol but it is possible to mount an arbitrary subdir.
+ *
+ * In case you do a
+ *   mount -o X-mount.subdir=<subvolpath/subdirname> <dev> <dest>
+ * you will get
+ *   dest = <dest>
+ *   rootpath = <subvolpath/subdirname>
+ *   subvol = <subvolpath>
+ *
+ * Instead if you do
+ *   mount -o X-mount.subdir=<subvolpath> <dev> <dest>
+ * or
+ *   mount -o subvol=<subvolpath> <dev> <dest>
+ * you will get
+ *   dest = <dest>
+ *   rootpath = <subvolpath>
+ *   subvol = <subvolpath>
+ */
+
+struct btrfs_info {
+	/* UUID of the filesystem */
+	const char *uuid;
+
+	/* LABEL of the filesystem, may be empty "" */
+	const char *label;
+
+	/*
+	 * this is a list of the mount points; mounts may be NULL if the
+	 * filesystem is not mounted
+	 */
+	const struct btrfs_info_mount *mounts;
+
+	/* list of filesystem devices */
+	const struct btrfs_info_device *devices;
+
+	/* next filesystem in the list */
+	const struct btrfs_info *next;
+};
+
+/*
+ * This function returns the btrfs_info structures list in *ret, doing a scan
+ * if it wasn't already done.
+ *
+ * This function return 0 if everything is OK, or -errno in case of error.
+ */
+int btrfs_info_get(const struct btrfs_info **ret);
+/*
+ * This function returns the btrfs_info structures list, a scan is performed
+ * always.
+ *
+ * This function return 0 if everything is OK, or -errno in case of error.
+ */
+int btrfs_info_refresh(const struct btrfs_info **ret);
+
+/*
+ * This function returns the btrfs_info structure related to a btrfs filesystem
+ * that contains the path 'path'. If path is a device, the information of
+ * the filesystem containing a device is returned.
+ *
+ * This function return 0 if everything is OK, or -errno in case of error.
+ */
+int btrfs_info_find_by_path(const char *path, const struct btrfs_info **ret);
+
+/*
+ * This function returns the btrfs_info structure related to a btrfs filesystem
+ * that matches the UUID 'uuid'
+ *
+ * This function return 0 if everything is OK, or -errno in case of error.
+ */
+int btrfs_info_find_by_uuid(const char *uuid, const struct btrfs_info **ret);
+
+/*
+ * This function returns the btrfs_info structure related to a btrfs filesystem
+ * that matches the label 'label'.
+ *
+ * This function return 0 if everything is OK, or -errno in case of error.
+ */
+int btrfs_info_find_by_label(const char *label, const struct btrfs_info **ret);
+
+/*
+ * This function returns the btrfs_info structure related to a btrfs filesystem
+ * that matches the UUID_SUB 'uuid_sub'
+ * If retdev is not null, it will contains the device path.
+ *
+ * This function return 0 if everything is OK, or -errno in case of error.
+ */
+int btrfs_info_find_by_uuid_sub(const char *uuid_sub,
+				const struct btrfs_info **ret,
+				const char **retdev);
+
+/*
+ * This function returns the btrfs_info structure related to a btrfs filesystem
+ * that matches the block device 'dev'.
+ * If retdev is not null, it will contains the canonical device path.
+ *
+ * This function return 0 if everything is OK, or -errno in case of error.
+ */
+int btrfs_info_find_by_dev(const char *dev, const struct btrfs_info **ret,
+			   const char **retdev);
+
+/*
+ * This function returns the btrfs_info structure related to a btrfs filesystem
+ * that matches the partuuid 'partuuid'.
+ * If retdev is not null, it will contains the device path.
+ *
+ * This function return 0 if everything is OK, or -errno in case of error.
+ */
+int btrfs_info_find_by_partuuid(const char *partuuid,
+				const struct btrfs_info **ret,
+				const char **retdev);
+
+/*
+ * This function returns the btrfs_info structure related to a btrfs filesystem
+ * that matches by UUID_SUB, partuuid or device.
+ * If retdev is not null, it will contains the device path.
+ *
+ * This function return 0 if everything is OK, or -errno in case of error.
+ */
+int btrfs_info_find_dev(const char *filter,
+			const struct btrfs_info **ret,
+			const char **retdev);
+
+/*
+ * This function returns the btrfs_info structure related to a btrfs filesystem
+ * that match:
+ *   - an UUID, if filter is "UUID=<uuid>"
+ *   - or a LABEL, if filter is "LABEL=<label>"
+ *   - or a device, if filter is "<devname>", and <devname> is a block device
+ *   - or otherwise a filesystem which contains the path 'filter' (the filter
+ *     is canonicalized before)
+ *
+ * This function return 0 if everything is OK, or -errno in case of error.
+ */
+int btrfs_info_find(const char *filter, const struct btrfs_info **ret);
+
+/*
+ * return a accessible [*] mountpoint of a btrfs filesystem.
+ * [*] accessible means:
+ *   - the user has the right to access it R/X
+ *   - the mount point is not hided by another mount
+ *
+ * This function return NULL in case of an accessible path doesn't exist
+ */
+const char *btrfs_info_find_valid_path(const struct btrfs_info *bfs);
+
+/*
+ * return a accessible [*] dev of a btrfs filesystem.
+ * [*] accessible means:
+ *   - the user has the right to access it R/X
+ *
+ * This function return NULL in case of an accessible device doesn't exist
+ */
+const char *btrfs_info_find_valid_dev(const struct btrfs_info *bfs);
+
+/*
+ * check if a filesystem is mounted
+ *
+ * This function return 0 if the filesystem is not mounted, otherwise a value
+ * different from 0
+ */
+static inline int btrfs_info_is_mounted(const struct btrfs_info *bfs)
+{
+	return bfs->mounts != NULL;
+}
+
+/*
+ * dump an entry of btrfs info list
+ */
+void btrfs_info_dump_single_entry(const struct btrfs_info *p, FILE *o);
+
+/*
+ * dump a list of btrfs info
+ */
+void btrfs_info_dump(const struct btrfs_info *p, FILE *o);
-- 
2.43.0


