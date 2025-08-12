Return-Path: <linux-btrfs+bounces-16038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E57AB23C45
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 01:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90FB1A21D6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 23:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2E2E0B5E;
	Tue, 12 Aug 2025 23:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKDZcxr8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588982DF3F8
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 23:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755041318; cv=none; b=V9MqVX7lBL5/D1kHrVdZXrHZ8WEdl5+TTGFQ+XgemTkF6RS0HQ3uwxQTvHWkqdxj+fJcmcTGEMXn8VDHb6pjSPJ6TlE+nwrG7d1eCwK3Xx/5x2Kygb0RVM+0DenKf7Nsp5Zro5RWm/xsjmgXefTqs7fr5I8OjdXwefHpk7M7NUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755041318; c=relaxed/simple;
	bh=JbsILa7f47IItJ3T1Vu+AuZ/eeyjNRcdPQZiN5iPrts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulQLn88KCfKChe0Tg1fhZSJY0wQFBJg80/kGBTABNBkf/YZ3Rmx0g4tXf4V7IW01Lc1UtGx248wOgmoqk0H54WkdzSUzj/xJAM7cwgwReSLWzHkZmTar1d+guPSsxPSpK7olf6mytuxle3Z7VSlOOsbTHW2AejPJwz8Fch8Hg4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKDZcxr8; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71bfdf75cccso39063497b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 16:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755041315; x=1755646115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiXGlgwkwFbmmBmqUizgVoaoM5Ya0R0uZ4MHt3fvjwc=;
        b=jKDZcxr8ULHVbr3KImkgGdSxftMjzi4XysFfz2m/oiry5UJ4sTzSYBFNRwYGkJBQY3
         ygSXV0NSXicRd0N59L+c01lBkGuESs1BmnuBAr5VbBvuOrj/mhllCBpzQj+41QFVnnDr
         dGqc5tW84RRa5RNTPxETkXZ3aJhv/liQMovVaQv+/Tqnk8oXIXqifkvNGTI5jQRkRYPp
         PKL7nrB44i4re84bDFzEWmGyqzLRsnH1+/bP0TW1CJ1M35CxQDCRKb6BZ7u3Rh9x389X
         U6wzXAmuMPPGbiOiTCk7BI4QUncXwfbzAPkGEJ/HVCmFfaotGp1bEHlOjQalNLXeyKwL
         z7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755041315; x=1755646115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiXGlgwkwFbmmBmqUizgVoaoM5Ya0R0uZ4MHt3fvjwc=;
        b=BU/l1+eFIRGENx4OwmoA5PL4szePiDK7HsMlY5QBaMi/lKdEWzIgdNOGWG7+cxHDW1
         IPtjhfar8Ozt+atZY+/gcJbAjn3HvvdQqn8r6AKDM3aEUsXLNhplLz0EAxEj5T+Im6Lf
         6Opda/UgBKaX8Z+95ps8MpCS+V2bn2/KcP0cJnsmqL8wFYg2COxwQCxqDt5ko49Z4gjY
         qIwWL8HK7ga+q67lHhSIMJ7fYr2tTON9YNEA0KBzv6bAD11iK2toPDNiCVCmNsCYiOnr
         HUAsP/J2XpRhFHBAbnRjJZv37EnnstwY+O912K5bHqIZTv21BZkJEWid7TosuGsn/NBV
         alNw==
X-Gm-Message-State: AOJu0YzDJE7LOjfNydY2+EXgWQAtOgB20e00AmlV3QTC1Jfx6e9OiFqq
	x7ToATUEHD6CsxOTGfo4KrEpOSrd2O4XHj679G5r5N4lmWarjUvDN0ke/xplQOGv
X-Gm-Gg: ASbGncvkyQuHirWcY6NbAXPVgg1l5/OtfIz3VvXj3n4vgNdhsrXwHOc5nActzav3Tcb
	A7fvmFfwlQ+618qfXIX2heperZqfTUkjcqmv179LPElAH34Cfv9xnyqnKbZlGo8aN5FMLXIGGYm
	e8X0yf6nWj9PaB68t+k0kRZQD5k+e6RqOgBspIxr2rKZwdFt7szcsXlrk5IpoB9cLFJfZ6O+tbh
	pA/MoTetVxB/jdM5u7lqbaw6osOTqj+HFxLNqWNciagd4YMIORLqH5tgNAJBBjMd/N+JsZUfAz5
	4DnsVoYMVJ+EV5Q35+mzNQznY55o3/RciLyKsmaP5Xq/NTRV3NVLtrQX2nz2hlafYi8FmeljpN2
	hwYAuGwWA15vTDfal
X-Google-Smtp-Source: AGHT+IEexkMCSYZzExvEmG9fV6bEAKY6f08ihcORui6SZ97nFdlqXVkEfUK2ZUV8BvFIvrTlTv+vOw==
X-Received: by 2002:a05:690c:3381:b0:710:e4c4:a938 with SMTP id 00721157ae682-71d4e5b2b7emr12379537b3.38.1755041314881;
        Tue, 12 Aug 2025 16:28:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3f6d0esm79067197b3.32.2025.08.12.16.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 16:28:34 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/1] btrfs: remove ref-verify kconfig
Date: Tue, 12 Aug 2025 16:28:27 -0700
Message-ID: <e0d8842344c237dbd82aea64eb80a81dc1193b3e.1755040815.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1755040815.git.loemra.dev@gmail.com>
References: <cover.1755040815.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove CONFIG_BTRFS_FS_REF_VERIFY Kconfig and add it as part of
CONFIG_BTRFS_DEBUG. This should not be impactful to the performance
of debug. btrfs_ref takes an additional u64, btrfs_fs_info takes an
additional spinlock_t and rb_root. All of the ref_verify logic is
still protected by a mount option.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/Kconfig       | 11 -----------
 fs/btrfs/Makefile      |  2 +-
 fs/btrfs/delayed-ref.c |  2 +-
 fs/btrfs/delayed-ref.h |  2 +-
 fs/btrfs/fs.h          |  4 +---
 fs/btrfs/ref-verify.h  |  4 ++--
 fs/btrfs/super.c       | 10 +---------
 7 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index ea95c90c84748..86d791210c393 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -117,14 +117,3 @@ config BTRFS_EXPERIMENTAL
 	  - large folio support
 
 	  If unsure, say N.
-
-config BTRFS_FS_REF_VERIFY
-	bool "Btrfs with the ref verify tool compiled in"
-	depends on BTRFS_FS
-	default n
-	help
-	  Enable run-time extent reference verification instrumentation.  This
-	  is meant to be used by btrfs developers for tracking down extent
-	  reference problems or verifying they didn't break something.
-
-	  If unsure, say N.
diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 2d5f0482678b8..743d7677b175d 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -36,7 +36,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   lru_cache.o raid-stripe-tree.o fiemap.o direct-io.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
-btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
+btrfs-$(CONFIG_BTRFS_DEBUG) += ref-verify.o
 btrfs-$(CONFIG_BLK_DEV_ZONED) += zoned.o
 btrfs-$(CONFIG_FS_VERITY) += verity.o
 
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index ca382c5b186f4..7b357a4b3ce3d 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -952,7 +952,7 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 mod_root,
 			 bool skip_qgroup)
 {
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+#ifdef CONFIG_BTRFS_DEBUG
 	/* If @real_root not set, use @root as fallback */
 	generic_ref->real_root = mod_root ?: generic_ref->ref_root;
 #endif
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 552ec4fa645d4..448c248f70dc0 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -276,7 +276,7 @@ struct btrfs_ref {
 	 */
 	bool skip_qgroup;
 
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+#ifdef CONFIG_BTRFS_DEBUG
 	/* Through which root is this modification. */
 	u64 real_root;
 #endif
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index f0b090d4ac046..66e08e20ff5ac 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -880,12 +880,10 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_trans_pending_ordered_map;
 	struct lockdep_map btrfs_ordered_extent_map;
 
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+#ifdef CONFIG_BTRFS_DEBUG
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
-#endif
 
-#ifdef CONFIG_BTRFS_DEBUG
 	struct kobject *debug_kobj;
 	struct list_head allocated_roots;
 
diff --git a/fs/btrfs/ref-verify.h b/fs/btrfs/ref-verify.h
index 559bd25a2b7ab..1ce544d53cc56 100644
--- a/fs/btrfs/ref-verify.h
+++ b/fs/btrfs/ref-verify.h
@@ -12,7 +12,7 @@
 struct btrfs_fs_info;
 struct btrfs_ref;
 
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+#ifdef CONFIG_BTRFS_DEBUG
 
 #include <linux/spinlock.h>
 
@@ -53,6 +53,6 @@ static inline void btrfs_init_ref_verify(struct btrfs_fs_info *fs_info)
 {
 }
 
-#endif /* CONFIG_BTRFS_FS_REF_VERIFY */
+#endif /* CONFIG_BTRFS_DEBUG */
 
 #endif
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 831d9cd01244d..f6b61207979a4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -130,8 +130,6 @@ enum {
 	Opt_enospc_debug,
 #ifdef CONFIG_BTRFS_DEBUG
 	Opt_fragment, Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
-#endif
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
 #endif
 	Opt_err,
@@ -254,8 +252,6 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	fsparam_flag_no("enospc_debug", Opt_enospc_debug),
 #ifdef CONFIG_BTRFS_DEBUG
 	fsparam_enum("fragment", Opt_fragment, btrfs_parameter_fragment),
-#endif
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	fsparam_flag("ref_verify", Opt_ref_verify),
 #endif
 	{}
@@ -629,8 +625,6 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 		break;
-#endif
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	case Opt_ref_verify:
 		btrfs_set_opt(ctx->mount_opt, REF_VERIFY);
 		break;
@@ -2462,13 +2456,11 @@ static int __init btrfs_print_mod_info(void)
 #endif
 #ifdef CONFIG_BTRFS_DEBUG
 			", debug=on"
+			", ref-verify=on"
 #endif
 #ifdef CONFIG_BTRFS_ASSERT
 			", assert=on"
 #endif
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
-			", ref-verify=on"
-#endif
 #ifdef CONFIG_BLK_DEV_ZONED
 			", zoned=yes"
 #else
-- 
2.47.3


