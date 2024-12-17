Return-Path: <linux-btrfs+bounces-10476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114EF9F4AFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 13:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CB416DF37
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 12:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C21F37BF;
	Tue, 17 Dec 2024 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QxywzRdt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE91E3DFA
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438788; cv=none; b=ZphkI5E1eOERmbOBBwGqUXJVtTXWvx32JEjQKLj8AfHL1CjcngkBsfuyFOYSTC4iA4+o11cnPdMw/S+phEFEBZ+/n/IZgD358WvJrL6/ADKSnrFPf+g5eu7JfFqqAXKeH+XjkyMdAqzD/xWCws5G1H9JLI8+sbuKb6v2O8v669M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438788; c=relaxed/simple;
	bh=nyPLepdPiFn6D+OGD+MjSqXBJcNJ9+UCod+pDt9/UQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nypjEiBiHtSjPjb352dqc9UQWiKdBu8nLazMGj4G1Uh0W0XdYmUuisxUcZ2v+SImbLkTLRHTKMJSwXjQEX/TIDJsrXVderf+b8z5N1dn47CJi3euRkWoVmifAJBcoz8vEPpSloLy4or4wpl1yCzhmP8a3IfBpaTvH+p82F14wZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=QxywzRdt; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4BHBdjoN019843
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 04:33:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=bKv5BuYbPe0RVZ5KawS7S2S
	fYc8+BUTb6VmUSA7oGGU=; b=QxywzRdtNQYKdSmbEKRYOlXQP5wBiUvg1HkdA8W
	3sRDmGb8xhhfapENGdJHKSq6jHxu/H2gOP+znqarJzaNlP1gqcn/JIcMI2zviwEz
	NmTpfSOne8db5lSyCMhfHz+iiLwnQ+BeR9Q7xHIYnqq6/Bvrs4WuF1YsBdJjsxmn
	8Vj8=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 43k0n22jd3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 04:33:05 -0800 (PST)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 17 Dec 2024 12:33:03 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id A705D9A23362; Tue, 17 Dec 2024 12:32:56 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <fstests@vger.kernel.org>
CC: <linux-btrfs@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>,
        Mark
 Harmstone <maharmstone@fb.com>
Subject: [PATCH 1/2] configure: use pkg-config to find liburing
Date: Tue, 17 Dec 2024 12:32:43 +0000
Message-ID: <20241217123249.2481120-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IKfZyKauy5FYDk8Z-2PII8G4J11iuY6P
X-Proofpoint-ORIG-GUID: IKfZyKauy5FYDk8Z-2PII8G4J11iuY6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Change our autoconf macros so that instead of checking for the presence
of liburing.h, we use pkg-config.

The benefit of this is that we can then check the version of liburing,
and do conditional compilation based on this. There's a macro
IO_URING_CHECK_VERSION already, but it's only in relatively recent
versions of liburing.h.

This replaces HAVE_URING_H, defined by AC_CHECK_HEADERS, with
HAVE_URING. I also had to rename PKG_{MAJOR,MINOR,REVISION,BUILD} to
start with PACKAGE_, to avoid "possibly undefined macro" errors; it
looks like pkg-config assumes that anything called PKG_* is for its own
use.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 VERSION                         | 8 ++++----
 m4/package_globals.m4           | 4 ++--
 m4/package_liburing.m4          | 6 +++++-
 release.sh                      | 2 +-
 src/feature.c                   | 4 ++--
 src/vfs/idmapped-mounts.c       | 6 +++---
 src/vfs/idmapped-mounts.h       | 2 +-
 src/vfs/tmpfs-idmapped-mounts.c | 6 +++---
 src/vfs/utils.c                 | 4 ++--
 src/vfs/utils.h                 | 6 +++---
 src/vfs/vfstest.c               | 6 +++---
 11 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/VERSION b/VERSION
index 7294a002..afcab53e 100644
--- a/VERSION
+++ b/VERSION
@@ -1,7 +1,7 @@
 #
 # This file is used by configure to get version information
 #
-PKG_MAJOR=3D1
-PKG_MINOR=3D1
-PKG_REVISION=3D1
-PKG_BUILD=3D1
+PACKAGE_MAJOR=3D1
+PACKAGE_MINOR=3D1
+PACKAGE_REVISION=3D1
+PACKAGE_BUILD=3D1
diff --git a/m4/package_globals.m4 b/m4/package_globals.m4
index ce7a8c51..c8d5d124 100644
--- a/m4/package_globals.m4
+++ b/m4/package_globals.m4
@@ -9,9 +9,9 @@ AC_DEFUN([AC_PACKAGE_GLOBALS],
     AC_SUBST(pkg_name)
=20
     . ./VERSION
-    pkg_version=3D${PKG_MAJOR}.${PKG_MINOR}.${PKG_REVISION}
+    pkg_version=3D${PACKAGE_MAJOR}.${PACKAGE_MINOR}.${PACKAGE_REVISION}
     AC_SUBST(pkg_version)
-    pkg_release=3D$PKG_BUILD
+    pkg_release=3D$PACKAGE_BUILD
     test -z "$BUILD_VERSION" || pkg_release=3D"$BUILD_VERSION"
     AC_SUBST(pkg_release)
=20
diff --git a/m4/package_liburing.m4 b/m4/package_liburing.m4
index c92cc02a..0553966d 100644
--- a/m4/package_liburing.m4
+++ b/m4/package_liburing.m4
@@ -1,4 +1,8 @@
 AC_DEFUN([AC_PACKAGE_WANT_URING],
-  [ AC_CHECK_HEADERS(liburing.h, [ have_uring=3Dtrue ], [ have_uring=3Df=
alse ])
+  [ PKG_CHECK_MODULES([LIBURING], [liburing],
+    [ AC_DEFINE([HAVE_LIBURING], [1], [Use liburing])
+      have_uring=3Dtrue
+    ],
+    [ have_uring=3Dfalse ])
     AC_SUBST(have_uring)
   ])
diff --git a/release.sh b/release.sh
index 5b78ec79..70fbf47e 100644
--- a/release.sh
+++ b/release.sh
@@ -5,7 +5,7 @@
=20
 . ./VERSION
=20
-version=3D${PKG_MAJOR}.${PKG_MINOR}.${PKG_REVISION}
+version=3D${PACKAGE_MAJOR}.${PACKAGE_MINOR}.${PACKAGE_REVISION}
 date=3D`date +"%-d %B %Y"`
=20
 echo "Cleaning up"
diff --git a/src/feature.c b/src/feature.c
index 7e474ce5..7df36acf 100644
--- a/src/feature.c
+++ b/src/feature.c
@@ -42,7 +42,7 @@
 #include <libaio.h>
 #endif
=20
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 #include <liburing.h>
 #endif
=20
@@ -227,7 +227,7 @@ check_aio_support(void)
 static int
 check_uring_support(void)
 {
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 	struct io_uring ring;
 	int err;
=20
diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index f4dfc3f3..ed9992f9 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -2206,7 +2206,7 @@ out:
 }
=20
=20
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 int tcore_io_uring_idmapped(const struct vfstest_info *info)
 {
 	int fret =3D -1;
@@ -2743,7 +2743,7 @@ out_unmap:
=20
 	return fret;
 }
-#endif /* HAVE_LIBURING_H */
+#endif /* HAVE_LIBURING */
=20
 /* Validate that protected symlinks work correctly on idmapped mounts. *=
/
 int tcore_protected_symlinks_idmapped_mounts(const struct vfstest_info *=
info)
@@ -8859,7 +8859,7 @@ static const struct test_struct t_idmapped_mounts[]=
 =3D {
 	{ tcore_hardlink_crossing_idmapped_mounts,				true,	"cross idmapped mou=
nt hardlink",								},
 	{ tcore_hardlink_from_idmapped_mount,					true,	"hardlinks from idmappe=
d mounts",								},
 	{ tcore_hardlink_from_idmapped_mount_in_userns,			true,	"hardlinks from=
 idmapped mounts in user namespace",						},
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 	{ tcore_io_uring_idmapped,						true,	"io_uring from idmapped mounts",	=
							},
 	{ tcore_io_uring_idmapped_userns,					true,	"io_uring from idmapped mou=
nts in user namespace",						},
 	{ tcore_io_uring_idmapped_unmapped,					true,	"io_uring from idmapped m=
ounts with unmapped ids",						},
diff --git a/src/vfs/idmapped-mounts.h b/src/vfs/idmapped-mounts.h
index 4a2c7b39..688394c8 100644
--- a/src/vfs/idmapped-mounts.h
+++ b/src/vfs/idmapped-mounts.h
@@ -30,7 +30,7 @@ int tcore_fscaps_idmapped_mounts_in_userns_separate_use=
rns(const struct vfstest_
 int tcore_hardlink_crossing_idmapped_mounts(const struct vfstest_info *i=
nfo);
 int tcore_hardlink_from_idmapped_mount(const struct vfstest_info *info);
 int tcore_hardlink_from_idmapped_mount_in_userns(const struct vfstest_in=
fo *info);
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 int tcore_io_uring_idmapped(const struct vfstest_info *info);
 int tcore_io_uring_idmapped_userns(const struct vfstest_info *info);
 int tcore_io_uring_idmapped_unmapped(const struct vfstest_info *info);
diff --git a/src/vfs/tmpfs-idmapped-mounts.c b/src/vfs/tmpfs-idmapped-mou=
nts.c
index 0899aed9..d8212bce 100644
--- a/src/vfs/tmpfs-idmapped-mounts.c
+++ b/src/vfs/tmpfs-idmapped-mounts.c
@@ -167,7 +167,7 @@ static int tmpfs_hardlink_from_idmapped_mount_in_user=
ns(const struct vfstest_inf
 	return tmpfs_nested_mount_setup(info, tcore_hardlink_from_idmapped_moun=
t_in_userns);
 }
=20
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 static int tmpfs_io_uring_idmapped(const struct vfstest_info *info)
 {
 	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped);
@@ -184,7 +184,7 @@ static int tmpfs_io_uring_idmapped_unmapped_userns(co=
nst struct vfstest_info *in
 {
 	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped_unmapped_=
userns);
 }
-#endif /* HAVE_LIBURING_H */
+#endif /* HAVE_LIBURING */
=20
 static int tmpfs_protected_symlinks_idmapped_mounts(const struct vfstest=
_info *info)
 {
@@ -272,7 +272,7 @@ static const struct test_struct t_tmpfs[] =3D {
 	{ tmpfs_hardlink_crossing_idmapped_mounts,				T_REQUIRE_USERNS | T_REQU=
IRE_IDMAPPED_MOUNTS,	"tmpfs cross idmapped mount hardlink",								},
 	{ tmpfs_hardlink_from_idmapped_mount,					T_REQUIRE_USERNS | T_REQUIRE_=
IDMAPPED_MOUNTS,	"tmpfs hardlinks from idmapped mounts",								},
 	{ tmpfs_hardlink_from_idmapped_mount_in_userns,				T_REQUIRE_USERNS | T=
_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs hardlinks from idmapped mounts in user n=
amespace",						},
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 	{ tmpfs_io_uring_idmapped,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_M=
OUNTS,	"tmpfs io_uring from idmapped mounts",								      },
 	{ tmpfs_io_uring_idmapped_userns,					T_REQUIRE_USERNS | T_REQUIRE_IDMA=
PPED_MOUNTS,	"tmpfs io_uring from idmapped mounts in user namespace",				=
	      },
 	{ tmpfs_io_uring_idmapped_unmapped,					T_REQUIRE_USERNS | T_REQUIRE_ID=
MAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts with unmapped ids",		=
			      },
diff --git a/src/vfs/utils.c b/src/vfs/utils.c
index 0ab5de15..c1c7951c 100644
--- a/src/vfs/utils.c
+++ b/src/vfs/utils.c
@@ -502,7 +502,7 @@ out:
 	return fret;
 }
=20
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 int io_uring_openat_with_creds(struct io_uring *ring, int dfd, const cha=
r *path,
 			       int cred_id, bool with_link, int *ret_cqe)
 {
@@ -555,7 +555,7 @@ int io_uring_openat_with_creds(struct io_uring *ring,=
 int dfd, const char *path,
 out:
 	return ret;
 }
-#endif /* HAVE_LIBURING_H */
+#endif /* HAVE_LIBURING */
=20
 /* caps_up - raise all permitted caps */
 int caps_up(void)
diff --git a/src/vfs/utils.h b/src/vfs/utils.h
index 872fd96f..c086885a 100644
--- a/src/vfs/utils.h
+++ b/src/vfs/utils.h
@@ -25,7 +25,7 @@
 #include <sys/capability.h>
 #endif
=20
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 #include <liburing.h>
 #endif
=20
@@ -349,11 +349,11 @@ static inline bool switch_fsids(uid_t fsuid, gid_t =
fsgid)
 	return true;
 }
=20
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 extern int io_uring_openat_with_creds(struct io_uring *ring, int dfd,
 				      const char *path, int cred_id,
 				      bool with_link, int *ret_cqe);
-#endif /* HAVE_LIBURING_H */
+#endif /* HAVE_LIBURING */
=20
 extern int chown_r(int fd, const char *path, uid_t uid, gid_t gid);
 extern int rm_r(int fd, const char *path);
diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
index f842117d..e0c897bb 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -1222,7 +1222,7 @@ out:
 	return fret;
 }
=20
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 static int io_uring(const struct vfstest_info *info)
 {
 	int fret =3D -1;
@@ -1495,7 +1495,7 @@ out_unmap:
=20
 	return fret;
 }
-#endif /* HAVE_LIBURING_H */
+#endif /* HAVE_LIBURING */
=20
 /* The following tests are concerned with setgid inheritance. These can =
be
  * filesystem type specific. For xfs, if a new file or directory or node=
 is
@@ -2349,7 +2349,7 @@ static const struct option longopts[] =3D {
 static const struct test_struct t_basic[] =3D {
 	{ fscaps,							T_REQUIRE_USERNS,	"fscaps on regular mounts",									}=
,
 	{ hardlink_crossing_mounts,					0,			"cross mount hardlink",										}=
,
-#ifdef HAVE_LIBURING_H
+#ifdef HAVE_LIBURING
 	{ io_uring,							0,			"io_uring",											},
 	{ io_uring_userns,						T_REQUIRE_USERNS,	"io_uring in user namespace",=
									},
 #endif
--=20
2.45.2


