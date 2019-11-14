Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56650FCCE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 19:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKNSOT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 13:14:19 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33177 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfKNSOT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 13:14:19 -0500
Received: by mail-qv1-f67.google.com with SMTP id x14so2749577qvu.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2019 10:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DbPGo6DXdHrqbQY848SrFqcPgPqBSZJhcnStCClIIUI=;
        b=vMOtW5cLEPRbgQbYzBKE13qVD95iFF4qtYIXAiGBK1U5qNWXsk+l6WBJaDlKY86O/m
         YycDNTi/1x2dkhX6nImTxzSetqfdZ1Z9N4HwoI5YyJOJdZNaSt8xIrPV33A0wwmPN5Yb
         kx28ruGmNHALkq62B/jEl1juf1KrXnN+Kt5VHYIrtRSDcLTcCuNCOgTZUGyhOqRENDnW
         D9WHAqqh/H4cXP4TJwN9AYFU+2ppFC4QUr498ugy18gfHb3xWlFK14ix5aKhbeF+yPLn
         em5XAMWa9Civw6YzZdzJENwyy9vGpeJKIGsqZX+Jj/qQvUs9W2pYCfFrGzNe04ynRarv
         UCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbPGo6DXdHrqbQY848SrFqcPgPqBSZJhcnStCClIIUI=;
        b=ly8BmY8o0XgGw+eODvWLv60dhjfI63s9m5RNe53LkLkyU227l1+1jrgmop4PGfnqg6
         604BrVE2OYrs6tsnwPmZWGCbJYvRYnI3h15hepG9V8NhIxlQS8N/rJoSh+DhBHUrryw1
         ITk94DjbpiIbPEiGL4oI3SonDW/TI0FE6L85o0LW7KHJ73V7DPrLdZ9JHyQZ9FewwZ+j
         UcHE7OShMgjyKtSZSrv8OCHUGIfW/MIyEG+sDyZtTC/0olWJCOyBBLUWl0/zc8f/YcEx
         PueVNT9SRXA0E7ms1/Y4ieOTwkrBJyrZs76eTxB56ci1wql19a14eD6mfJnfXj0Ud1h2
         +Gqg==
X-Gm-Message-State: APjAAAXgUpqsZe4isszF+BPvdnjWmJgN3ZgwBHwxg6uTi6BYbROzBN2y
        mqVFFwAO/jgguAadZhfXKjDJjw==
X-Google-Smtp-Source: APXvYqz/oM+mYYdZoyEDE5B3lQ/j03gh1Ed1qXBAUNIDsWE/tDNCcQq8fDOFmn61i5argYwEVZ6YFg==
X-Received: by 2002:a0c:f114:: with SMTP id i20mr9347659qvl.167.1573755257780;
        Thu, 14 Nov 2019 10:14:17 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a10sm3400753qtd.29.2019.11.14.10.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 10:14:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH][v2] fsstress: add the ability to create/delete subvolumes
Date:   Thu, 14 Nov 2019 13:14:15 -0500
Message-Id: <20191114181415.4633-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191114155836.3528-2-josef@toxicpanda.com>
References: <20191114155836.3528-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch adds support to fsstress for creating and deleting subvolumes
on a btrfs file system.  We link in the libbtrfsutil library to handle
the mechanics of creating and deleting subvolumes instead of duplicating
the ioctl logic.  There is code to check if we're on a btrfs fs at
startup time and if so 0 out the frequency of the btrfs specific
operations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- fixed the #include location for btrfsutil.h in fsstress.c.  The old centos box
  I had built this fine, but on modern boxes I was tripped up because I put this
  in a weird #ifdef thing for renameat2.  Moving it to the top so it actually
  gets included and the build works.

 configure.ac           |   1 +
 include/builddefs.in   |   1 +
 ltp/Makefile           |   4 +
 ltp/fsstress.c         | 227 ++++++++++++++++++++++++++++++++++-------
 m4/package_libbtrfs.m4 |   5 +
 5 files changed, 203 insertions(+), 35 deletions(-)
 create mode 100644 m4/package_libbtrfs.m4

diff --git a/configure.ac b/configure.ac
index 19798824..4bb50b32 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,6 +67,7 @@ AC_PACKAGE_WANT_FALLOCATE
 AC_PACKAGE_WANT_OPEN_BY_HANDLE_AT
 AC_PACKAGE_WANT_LINUX_PRCTL_H
 AC_PACKAGE_WANT_LINUX_FS_H
+AC_PACKAGE_WANT_LIBBTRFSUTIL
 
 AC_HAVE_COPY_FILE_RANGE
 
diff --git a/include/builddefs.in b/include/builddefs.in
index 2605e42d..e7894b1a 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -68,6 +68,7 @@ HAVE_ATTR_LIST = @have_attr_list@
 HAVE_FIEMAP = @have_fiemap@
 HAVE_FALLOCATE = @have_fallocate@
 HAVE_COPY_FILE_RANGE = @have_copy_file_range@
+HAVE_LIBBTRFSUTIL = @have_libbtrfsutil@
 
 GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
 
diff --git a/ltp/Makefile b/ltp/Makefile
index e4ca45f4..ebf40336 100644
--- a/ltp/Makefile
+++ b/ltp/Makefile
@@ -24,6 +24,10 @@ LCFLAGS += -DAIO
 LLDLIBS += -laio -lpthread
 endif
 
+ifeq ($(HAVE_LIBBTRFSUTIL), true)
+LLDLIBS += -lbtrfsutil
+endif
+
 ifeq ($(HAVE_FALLOCATE), true)
 LCFLAGS += -DFALLOCATE
 endif
diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 9f5ec1d0..45325a67 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -10,6 +10,9 @@
 #include <stddef.h>
 #include "global.h"
 
+#ifdef HAVE_BTRFSUTIL_H
+#include <btrfsutil.h>
+#endif
 #ifdef HAVE_ATTR_ATTRIBUTES_H
 #include <attr/attributes.h>
 #endif
@@ -127,6 +130,8 @@ typedef enum {
 	OP_SETXATTR,
 	OP_SPLICE,
 	OP_STAT,
+	OP_SUBVOL_CREATE,
+	OP_SUBVOL_DELETE,
 	OP_SYMLINK,
 	OP_SYNC,
 	OP_TRUNCATE,
@@ -149,6 +154,7 @@ typedef struct opdesc {
 
 typedef struct fent {
 	int	id;
+	int	ft;
 	int	parent;
 	int	xattr_counter;
 } fent_t;
@@ -176,20 +182,22 @@ struct print_string {
 	int max;
 };
 
-#define	FT_DIR	0
-#define	FT_DIRm	(1 << FT_DIR)
-#define	FT_REG	1
-#define	FT_REGm	(1 << FT_REG)
-#define	FT_SYM	2
-#define	FT_SYMm	(1 << FT_SYM)
-#define	FT_DEV	3
-#define	FT_DEVm	(1 << FT_DEV)
-#define	FT_RTF	4
-#define	FT_RTFm	(1 << FT_RTF)
-#define	FT_nft	5
-#define	FT_ANYm	((1 << FT_nft) - 1)
+#define	FT_DIR		0
+#define	FT_DIRm		(1 << FT_DIR)
+#define	FT_REG		1
+#define	FT_REGm		(1 << FT_REG)
+#define	FT_SYM		2
+#define	FT_SYMm		(1 << FT_SYM)
+#define	FT_DEV		3
+#define	FT_DEVm		(1 << FT_DEV)
+#define	FT_RTF		4
+#define	FT_RTFm		(1 << FT_RTF)
+#define	FT_SUBVOL	5
+#define	FT_SUBVOLm	(1 << FT_SUBVOL)
+#define	FT_nft		6
+#define	FT_ANYm		((1 << FT_nft) - 1)
 #define	FT_REGFILE	(FT_REGm | FT_RTFm)
-#define	FT_NOTDIR	(FT_ANYm & ~FT_DIRm)
+#define	FT_NOTDIR	(FT_ANYm & (~FT_DIRm & ~FT_SUBVOLm))
 
 #define	FLIST_SLOT_INCR	16
 #define	NDCACHE	64
@@ -248,6 +256,8 @@ void	setfattr_f(int, long);
 void	setxattr_f(int, long);
 void	splice_f(int, long);
 void	stat_f(int, long);
+void	subvol_create_f(int, long);
+void	subvol_delete_f(int, long);
 void	symlink_f(int, long);
 void	sync_f(int, long);
 void	truncate_f(int, long);
@@ -313,6 +323,8 @@ opdesc_t	ops[] = {
 	{ OP_SETXATTR, "setxattr", setxattr_f, 1, 1 },
 	{ OP_SPLICE, "splice", splice_f, 1, 1 },
 	{ OP_STAT, "stat", stat_f, 1, 0 },
+	{ OP_SUBVOL_CREATE, "subvol_create", subvol_create_f, 1, 1},
+	{ OP_SUBVOL_DELETE, "subvol_delete", subvol_delete_f, 1, 1},
 	{ OP_SYMLINK, "symlink", symlink_f, 2, 1 },
 	{ OP_SYNC, "sync", sync_f, 1, 1 },
 	{ OP_TRUNCATE, "truncate", truncate_f, 2, 1 },
@@ -328,6 +340,7 @@ flist_t	flist[FT_nft] = {
 	{ 0, 0, 'l', NULL },
 	{ 0, 0, 'c', NULL },
 	{ 0, 0, 'r', NULL },
+	{ 0, 0, 's', NULL },
 };
 
 int		dcache[NDCACHE];
@@ -372,11 +385,11 @@ int	creat_path(pathname_t *, mode_t);
 void	dcache_enter(int, int);
 void	dcache_init(void);
 fent_t	*dcache_lookup(int);
-void	dcache_purge(int);
+void	dcache_purge(int, int);
 void	del_from_flist(int, int);
 int	dirid_to_name(char *, int);
 void	doproc(void);
-int	fent_to_name(pathname_t *, flist_t *, fent_t *);
+int	fent_to_name(pathname_t *, fent_t *);
 bool	fents_ancestor_check(fent_t *, fent_t *);
 void	fix_parent(int, int, bool);
 void	free_pathname(pathname_t *);
@@ -407,6 +420,7 @@ int	unlink_path(pathname_t *);
 void	usage(void);
 void	write_freq(void);
 void	zero_freq(void);
+void	non_btrfs_freq(const char *);
 
 void sg_handler(int signum)
 {
@@ -560,6 +574,7 @@ int main(int argc, char **argv)
             exit(1);
         }
 
+	non_btrfs_freq(dirname);
 	(void)mkdir(dirname, 0777);
 	if (logname && logname[0] != '/') {
 		if (!getcwd(rpath, sizeof(rpath))){
@@ -795,6 +810,7 @@ add_to_flist(int ft, int id, int parent, int xattr_counter)
 	}
 	fep = &ftp->fents[ftp->nfiles++];
 	fep->id = id;
+	fep->ft = ft;
 	fep->parent = parent;
 	fep->xattr_counter = xattr_counter;
 }
@@ -962,18 +978,22 @@ dcache_lookup(int dirid)
 	int	i;
 
 	i = dcache[dirid % NDCACHE];
-	if (i >= 0 && (fep = &flist[FT_DIR].fents[i])->id == dirid)
+	if (i >= 0 && i < flist[FT_DIR].nfiles &&
+	    (fep = &flist[FT_DIR].fents[i])->id == dirid)
+		return fep;
+	if (i >= 0 && i < flist[FT_SUBVOL].nfiles &&
+	    (fep = &flist[FT_SUBVOL].fents[i])->id == dirid)
 		return fep;
 	return NULL;
 }
 
 void
-dcache_purge(int dirid)
+dcache_purge(int dirid, int ft)
 {
 	int	*dcp;
-
 	dcp = &dcache[dirid % NDCACHE];
-	if (*dcp >= 0 && flist[FT_DIR].fents[*dcp].id == dirid)
+	if (*dcp >= 0 && *dcp < flist[ft].nfiles &&
+	    flist[ft].fents[*dcp].id == dirid)
 		*dcp = -1;
 }
 
@@ -989,32 +1009,58 @@ del_from_flist(int ft, int slot)
 	flist_t	*ftp;
 
 	ftp = &flist[ft];
-	if (ft == FT_DIR)
-		dcache_purge(ftp->fents[slot].id);
+	if (ft == FT_DIR || ft == FT_SUBVOL)
+		dcache_purge(ftp->fents[slot].id, ft);
 	if (slot != ftp->nfiles - 1) {
-		if (ft == FT_DIR)
-			dcache_purge(ftp->fents[ftp->nfiles - 1].id);
+		if (ft == FT_DIR || ft == FT_SUBVOL)
+			dcache_purge(ftp->fents[ftp->nfiles - 1].id, ft);
 		ftp->fents[slot] = ftp->fents[--ftp->nfiles];
 	} else
 		ftp->nfiles--;
 }
 
+void
+delete_subvol_children(int parid)
+{
+	flist_t	*flp;
+	int	i;
+again:
+	for (i = 0, flp = flist; i < FT_nft; i++, flp++) {
+		int c;
+		for (c = 0; c < flp->nfiles; c++) {
+			if (flp->fents[c].parent == parid) {
+				int id = flp->fents[c].id;
+				del_from_flist(i, c);
+				if (i == FT_DIR || i == FT_SUBVOL)
+					delete_subvol_children(id);
+				goto again;
+			}
+		}
+	}
+}
+
 fent_t *
 dirid_to_fent(int dirid)
 {
 	fent_t	*efep;
 	fent_t	*fep;
 	flist_t	*flp;
+	int	ft = FT_DIR;
 
 	if ((fep = dcache_lookup(dirid)))
 		return fep;
-	flp = &flist[FT_DIR];
+again:
+	flp = &flist[ft];
 	for (fep = flp->fents, efep = &fep[flp->nfiles]; fep < efep; fep++) {
 		if (fep->id == dirid) {
 			dcache_enter(dirid, fep - flp->fents);
 			return fep;
 		}
 	}
+	if (ft == FT_DIR) {
+		ft = FT_SUBVOL;
+		goto again;
+	}
 	return NULL;
 }
 
@@ -1091,8 +1137,9 @@ errout:
  * Return 0 on error, 1 on success;
  */
 int
-fent_to_name(pathname_t *name, flist_t *flp, fent_t *fep)
+fent_to_name(pathname_t *name, fent_t *fep)
 {
+	flist_t	*flp = &flist[fep->ft];
 	char	buf[NAME_MAX + 1];
 	int	i;
 	fent_t	*pfep;
@@ -1112,7 +1159,7 @@ fent_to_name(pathname_t *name, flist_t *flp, fent_t *fep)
 #endif
 		if (pfep == NULL)
 			return 0;
-		e = fent_to_name(name, &flist[FT_DIR], pfep);
+		e = fent_to_name(name, pfep);
 		if (!e)
 			return 0;
 		append_pathname(name, "/");
@@ -1188,7 +1235,7 @@ generate_fname(fent_t *fep, int ft, pathname_t *name, int *idp, int *v)
 
 	/* prepend fep parent dir-name to it */
 	if (fep) {
-		e = fent_to_name(name, &flist[FT_DIR], fep);
+		e = fent_to_name(name, fep);
 		if (!e)
 			return 0;
 		append_pathname(name, "/");
@@ -1270,7 +1317,7 @@ get_fname(int which, long r, pathname_t *name, flist_t **flpp, fent_t **fepp,
 
 				/* fill-in what we were asked for */
 				if (name) {
-					e = fent_to_name(name, flp, fep);
+					e = fent_to_name(name, fep);
 #ifdef DEBUG
 					if (!e) {
 						fprintf(stderr, "%d: failed to get path for entry:"
@@ -1852,6 +1899,35 @@ zero_freq(void)
 		p->freq = 0;
 }
 
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
+
+opty_t btrfs_ops[] = {
+	OP_SUBVOL_CREATE,
+	OP_SUBVOL_DELETE,
+};
+
+void
+non_btrfs_freq(const char *path)
+{
+	opdesc_t		*p;
+#ifdef HAVE_BTRFSUTIL_H
+	enum btrfs_util_error	e;
+
+	e = btrfs_util_is_subvolume(path);
+	if (e != BTRFS_UTIL_ERROR_NOT_BTRFS)
+		return;
+#endif
+	for (p = ops; p < ops_end; p++) {
+		int i;
+		for (i = 0; i < ARRAY_SIZE(btrfs_ops); i++) {
+			if (p->op == btrfs_ops[i]) {
+				p->freq = 0;
+				break;
+			}
+		}
+	}
+}
+
 void inode_info(char *str, size_t sz, struct stat64 *s, int verbose)
 {
 	if (verbose)
@@ -3103,7 +3179,7 @@ creat_f(int opno, long r)
 	v |= v1;
 	if (!e) {
 		if (v) {
-			(void)fent_to_name(&f, &flist[FT_DIR], fep);
+			(void)fent_to_name(&f, fep);
 			printf("%d/%d: creat - no filename from %s\n",
 				procid, opno, f.path);
 		}
@@ -3767,7 +3843,7 @@ link_f(int opno, long r)
 	v |= v1;
 	if (!e) {
 		if (v) {
-			(void)fent_to_name(&l, &flist[FT_DIR], fep);
+			(void)fent_to_name(&l, fep);
 			printf("%d/%d: link - no filename from %s\n",
 				procid, opno, l.path);
 		}
@@ -3858,7 +3934,7 @@ mkdir_f(int opno, long r)
 	v |= v1;
 	if (!e) {
 		if (v) {
-			(void)fent_to_name(&f, &flist[FT_DIR], fep);
+			(void)fent_to_name(&f, fep);
 			printf("%d/%d: mkdir - no filename from %s\n",
 				procid, opno, f.path);
 		}
@@ -3896,7 +3972,7 @@ mknod_f(int opno, long r)
 	v |= v1;
 	if (!e) {
 		if (v) {
-			(void)fent_to_name(&f, &flist[FT_DIR], fep);
+			(void)fent_to_name(&f, fep);
 			printf("%d/%d: mknod - no filename from %s\n",
 				procid, opno, f.path);
 		}
@@ -4364,7 +4440,7 @@ do_renameat2(int opno, long r, int mode)
 		v |= v1;
 		if (!e) {
 			if (v) {
-				(void)fent_to_name(&f, &flist[FT_DIR], dfep);
+				(void)fent_to_name(&f, dfep);
 				printf("%d/%d: rename - no filename from %s\n",
 					procid, opno, f.path);
 			}
@@ -4378,6 +4454,7 @@ do_renameat2(int opno, long r, int mode)
 	if (e == 0) {
 		int xattr_counter = fep->xattr_counter;
 		bool swap = (mode == RENAME_EXCHANGE) ? true : false;
+		int ft = flp - flist;
 
 		oldid = fep->id;
 		oldparid = fep->parent;
@@ -4386,7 +4463,7 @@ do_renameat2(int opno, long r, int mode)
 		 * Swap the parent ids for RENAME_EXCHANGE, and replace the
 		 * old parent id for the others.
 		 */
-		if (flp - flist == FT_DIR)
+		if (ft == FT_DIR || ft == FT_SUBVOL)
 			fix_parent(oldid, id, swap);
 
 		if (mode == RENAME_WHITEOUT) {
@@ -4647,6 +4724,86 @@ stat_f(int opno, long r)
 	free_pathname(&f);
 }
 
+void
+subvol_create_f(int opno, long r)
+{
+#ifdef HAVE_BTRFSUTIL_H
+	enum btrfs_util_error	e;
+	pathname_t		f;
+	fent_t			*fep;
+	int			id;
+	int			parid;
+	int			v;
+	int			v1;
+	int			err;
+
+	init_pathname(&f);
+	if (!get_fname(FT_DIRm | FT_SUBVOLm, r, NULL, NULL, &fep, &v))
+		parid = -1;
+	else
+		parid = fep->id;
+	err = generate_fname(fep, FT_SUBVOL, &f, &id, &v1);
+	v |= v1;
+	if (!err) {
+		if (v) {
+			(void)fent_to_name(&f, fep);
+			printf("%d/%d: subvol_create - no filename from %s\n",
+			       procid, opno, f.path);
+		}
+		free_pathname(&f);
+		return;
+	}
+	e = btrfs_util_create_subvolume(f.path, 0, NULL, NULL);
+	if (e == BTRFS_UTIL_OK)
+		add_to_flist(FT_SUBVOL, id, parid, 0);
+	if (v) {
+		printf("%d/%d: subvol_create %s %d(%s)\n", procid, opno,
+		       f.path, e, btrfs_util_strerror(e));
+		printf("%d/%d: subvol_create add id=%d,parent=%d\n", procid,
+		       opno, id, parid);
+	}
+	free_pathname(&f);
+#endif
+}
+
+void
+subvol_delete_f(int opno, long r)
+{
+#ifdef HAVE_BTRFSUTIL_H
+	enum btrfs_util_error	e;
+	pathname_t		f;
+	fent_t			*fep;
+	int			v;
+	int			oldid;
+	int			oldparid;
+
+	init_pathname(&f);
+	if (!get_fname(FT_SUBVOLm, r, &f, NULL, &fep, &v)) {
+		if (v)
+			printf("%d:%d: subvol_delete - no subvolume\n", procid,
+			       opno);
+		free_pathname(&f);
+		return;
+	}
+	e = btrfs_util_delete_subvolume(f.path, 0);
+	check_cwd();
+	if (e == BTRFS_UTIL_OK) {
+		oldid = fep->id;
+		oldparid = fep->parent;
+		delete_subvol_children(oldid);
+		del_from_flist(FT_SUBVOL, fep - flist[FT_SUBVOL].fents);
+	}
+	if (v) {
+		printf("%d/%d: subvol_delete %s %d(%s)\n", procid, opno, f.path,
+		       e, btrfs_util_strerror(e));
+		if (e == BTRFS_UTIL_OK)
+			printf("%d/%d: subvol_delete del entry: id=%d,parent=%d\n",
+			       procid, opno, oldid, oldparid);
+	}
+	free_pathname(&f);
+#endif
+}
+
 void
 symlink_f(int opno, long r)
 {
@@ -4670,7 +4827,7 @@ symlink_f(int opno, long r)
 	v |= v1;
 	if (!e) {
 		if (v) {
-			(void)fent_to_name(&f, &flist[FT_DIR], fep);
+			(void)fent_to_name(&f, fep);
 			printf("%d/%d: symlink - no filename from %s\n",
 				procid, opno, f.path);
 		}
diff --git a/m4/package_libbtrfs.m4 b/m4/package_libbtrfs.m4
new file mode 100644
index 00000000..4822cc4a
--- /dev/null
+++ b/m4/package_libbtrfs.m4
@@ -0,0 +1,5 @@
+AC_DEFUN([AC_PACKAGE_WANT_LIBBTRFSUTIL],
+  [ AC_CHECK_HEADERS(btrfsutil.h, [ have_libbtrfsutil=true ],
+                     [ have_libbtrfsutil=false ])
+    AC_SUBST(have_libbtrfsutil)
+  ])
-- 
2.21.0

