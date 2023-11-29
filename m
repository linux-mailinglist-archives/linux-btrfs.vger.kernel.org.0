Return-Path: <linux-btrfs+bounces-441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A6A7FDF19
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 19:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA46B213C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EEF5C3E8;
	Wed, 29 Nov 2023 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NPZ4jjG5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3343DD1
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 10:10:36 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso6334185276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701281435; x=1701886235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uy98llGvq1FZ6sxIjHpcyVkHZ+62BAOVjcOPLqwk3U=;
        b=NPZ4jjG5M98xrHP/0GqpeEg6ZFnmz0ZUyXtYGoQIRL1mKVmLbK34XWd4PLcq3Wox5l
         PhHYe9eXAY95j0m2rVl5Gs4IhR2EiSVhCnUJmO6TI8/Q8dmjOp2HV2cs84y6sRW9m69e
         jxrjHrOKeUQ4uIV6EF/n5mALWgSqYydX/z1em0wa4ro1oDTutjGGplcLHqp8enbjMkpE
         7yot08dk4PreVoxgz+7jqiyBjzF2tgE0Xgs8E+NMgj14q9nIP2zIvz24/nTO8dqAThJJ
         i0A0JeN4wXcXbr8wV4vuJ41Ie/oisRKBgLHWuOhHKQxwiCwohkWAo0xd2lZAyYKMjEpQ
         kGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281435; x=1701886235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uy98llGvq1FZ6sxIjHpcyVkHZ+62BAOVjcOPLqwk3U=;
        b=eW5HP7IDnpxD9jplxeBut7Srmr9BD7toYDi6jc1j9U4cIlVvWhNfsFB+i6IyLZhE6t
         y6HxWI8um/rT0fP5vwKZXe0YbcjLYR0sk8XA0x61nPkJgOYKsTR3B+bTawwStbaXn89v
         V4/pWAs6gku/nNWgZNkq7LD/9k6vJPBqRfWaUpxYX41HQ1akd1YV7FCZlsKekPqoi7if
         +uTGzsKqXhe0lZE7yVhxDmTiUarnrmL0CNTKez6tWE49TZaRymU3fNuxiNC6cpQPNQ4a
         3UND8SzM82LFDfqdCmHiKsITd7t6ejD9cokP7TJtcy3Jz9kiDL3uV7Gah5xsiLEfFTFJ
         TjRw==
X-Gm-Message-State: AOJu0YyafgPBnphM7febIClsZvP6orXs4mv/EpihbgBxjY4mPlKkh8ta
	3dyXn465OIcAilM6YMTJFRlxFwkc8nVEVD5X1+q0Pw==
X-Google-Smtp-Source: AGHT+IH3gWhSlcNW/35SwVOEnUm+lbZNlej/VWEtOFq2FcK93rR4R37xNhW/ffd/M31xY9927BUJWg==
X-Received: by 2002:a81:8686:0:b0:5ce:f683:cd3 with SMTP id w128-20020a818686000000b005cef6830cd3mr15104439ywf.13.1701281435060;
        Wed, 29 Nov 2023 10:10:35 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id em14-20020a05690c2b0e00b005cda3901d4dsm4364617ywb.77.2023.11.29.10.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:10:34 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: cache that we don't have security.capability set
Date: Wed, 29 Nov 2023 13:10:31 -0500
Message-ID: <8a8b4385143d66feec39e3925a399c118846a686.1701281422.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When profiling a workload I noticed we were constantly calling getxattr.
These were mostly coming from __remove_privs, which will lookup if
security.capability exists to remove it.  However instrumenting getxattr
showed we get called nearly constantly on an idle machine on a lot of
accesses.

These are wasteful and not free.  Other security LSM's have a way to
cache their results, but capability doesn't have this, so it's asking us
all the time for the xattr.

Fix this by setting a flag in our inode that it doesn't have a
security.capability xattr.  We set this on new inodes and after a failed
lookup of security.capability.  If we set this xattr at all we'll clear
the flag.

I haven't found a test in fsperf that this makes a visible difference
on, but I assume fs_mark related tests would show it clearly.  This is a
perf report output of the smallfiles100k run where it shows 20% of our
time spent in __remove_privs because we're looking up the non-existent
xattr.

--21.86%--btrfs_write_check.constprop.0
  --21.62%--__file_remove_privs
    --21.55%--security_inode_need_killpriv
      --21.54%--cap_inode_need_killpriv
        --21.53%--__vfs_getxattr
          --20.89%--btrfs_getxattr

Obviously this is just CPU time in a mostly IO bound test, so the actual
effect of removing this callchain is minimal.  However in just normal
testing of an idle system tracing showed around 100 getxattr calls per
minute, and with this patch there are 0.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h |  1 +
 fs/btrfs/inode.c       |  7 +++++
 fs/btrfs/xattr.c       | 59 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 5572ae52444e..de9f71743b6b 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -69,6 +69,7 @@ enum {
 	BTRFS_INODE_VERITY_IN_PROGRESS,
 	/* Set when this inode is a free space inode. */
 	BTRFS_INODE_FREE_SPACE_INODE,
+	BTRFS_INODE_NO_CAP_XATTR,
 };
 
 /* in memory btrfs inode */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 096b3004a19f..f8647d8271b7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6225,6 +6225,13 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
 
+	/*
+	 * We don't have any capability xattrs set here yet, shortcut any
+	 * queries for the xattrs here.  If we add them later via the inode
+	 * security init path or any other path this flag will be cleared.
+	 */
+	set_bit(BTRFS_INODE_NO_CAP_XATTR, &BTRFS_I(inode)->runtime_flags);
+
 	/*
 	 * Subvolumes don't inherit flags from their parent directory.
 	 * Originally this was probably by accident, but we probably can't
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 3cf236fb40a4..caf8de1158b9 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -382,6 +382,56 @@ static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
 	return btrfs_setxattr_trans(inode, name, buffer, size, flags);
 }
 
+static int btrfs_xattr_handler_get_security(const struct xattr_handler *handler,
+					    struct dentry *unused,
+					    struct inode *inode,
+					    const char *name, void *buffer,
+					    size_t size)
+{
+	int ret;
+	bool is_cap = false;
+
+	name = xattr_full_name(handler, name);
+
+	/*
+	 * security.capability doesn't cache the results, so calls into us
+	 * constantly to see if there's a capability xattr.  Cache the result
+	 * here in order to avoid wasting time doing lookups for xattrs we know
+	 * don't exist.
+	 */
+	if (!strcmp(name, XATTR_NAME_CAPS)) {
+		is_cap = true;
+		if (test_bit(BTRFS_INODE_NO_CAP_XATTR,
+			     &BTRFS_I(inode)->runtime_flags))
+			return -ENODATA;
+	}
+
+	ret = btrfs_getxattr(inode, name, buffer, size);
+	if (ret == -ENODATA && is_cap)
+		set_bit(BTRFS_INODE_NO_CAP_XATTR,
+			&BTRFS_I(inode)->runtime_flags);
+	return ret;
+}
+
+static int btrfs_xattr_handler_set_security(const struct xattr_handler *handler,
+					    struct mnt_idmap *idmap,
+					    struct dentry *unused,
+					    struct inode *inode,
+					    const char *name,
+					    const void *buffer,
+					    size_t size, int flags)
+{
+	if (btrfs_root_readonly(BTRFS_I(inode)->root))
+		return -EROFS;
+
+	name = xattr_full_name(handler, name);
+	if (!strcmp(name, XATTR_NAME_CAPS))
+		clear_bit(BTRFS_INODE_NO_CAP_XATTR,
+			  &BTRFS_I(inode)->runtime_flags);
+
+	return btrfs_setxattr_trans(inode, name, buffer, size, flags);
+}
+
 static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 					struct mnt_idmap *idmap,
 					struct dentry *unused, struct inode *inode,
@@ -420,8 +470,8 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 
 static const struct xattr_handler btrfs_security_xattr_handler = {
 	.prefix = XATTR_SECURITY_PREFIX,
-	.get = btrfs_xattr_handler_get,
-	.set = btrfs_xattr_handler_set,
+	.get = btrfs_xattr_handler_get_security,
+	.set = btrfs_xattr_handler_set_security,
 };
 
 static const struct xattr_handler btrfs_trusted_xattr_handler = {
@@ -473,6 +523,11 @@ static int btrfs_initxattrs(struct inode *inode,
 		}
 		strcpy(name, XATTR_SECURITY_PREFIX);
 		strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
+
+		if (!strcmp(name, XATTR_NAME_CAPS))
+			clear_bit(BTRFS_INODE_NO_CAP_XATTR,
+				  &BTRFS_I(inode)->runtime_flags);
+
 		err = btrfs_setxattr(trans, inode, name, xattr->value,
 				     xattr->value_len, 0);
 		kfree(name);
-- 
2.41.0


