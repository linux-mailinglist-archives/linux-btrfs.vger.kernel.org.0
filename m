Return-Path: <linux-btrfs+bounces-5891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2AA912D94
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 20:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE70F1C25D94
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD57B17BB2B;
	Fri, 21 Jun 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="WJOgL9Zb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C9217BB27
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996035; cv=none; b=Y58RDRkJWKC4FWj+jTgLTaPWOCiD6arUiia7VITwo7ehUshQfn5e+2NT9riLWhpciWD5SisJmKLQ4DvqvH7+aqHmZqGW6VB28QfJvQz6gtkMJHeylMA0+iVE1Jvp9E9qaBsoIEOncZF0Jw/AsIyMHJSeiKpTdZklY/+Fpzqya9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996035; c=relaxed/simple;
	bh=Psh8J7wK6rm63m8IkRe8at9CAbKf0BDiSY2fDzeW5TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coPnaBrJtHZTJx0Yc4KluQnnKc2BKJNVEQHgJ2mTwad4H7f48Ygt70a8ftF4WuJhX6UxcF0g3fttci4S3kfNUO7vl22T40HZ2DWdQcJ3GS5dP9hfFkL4NvTvWNUFAZODkGGFGD8Z8pGWINylrNxPfvCykOIwMuOTySVEEzxYMhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=WJOgL9Zb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7065e31ee3cso470848b3a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 11:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718996033; x=1719600833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgsONUIW6hQ1GQ3rkK8S8br7yH5EZzfCmWfTPiaM4X4=;
        b=WJOgL9ZbLi39ePkf72r39jYzofSlgehKRR/peTPLU6foe9kdsfpTnUkx4GnAt5VqiH
         FtD2TiFo/j3vmKaAeHqZsC0dduHEf5iHKzuByhIJw5Y+KlaOnytIzRo1VipUDfNY2nxB
         BVepuXkmBXT0XpmKDsCZrhNZDNpJM98cOF77cMMglYx58Aounrf7kpHb9s66VGLusuW6
         WIed3E3+PkfwxrWsjpwL3BCWOLd2TPCsHwtM0chVuSa/LiKqkM8UDn05ps+Pn28YaSy7
         EsnOCQO80joEHTahXw4Al6Ugr/ZDAFFmLALSiBHLHr3X7Obp4B1225ZE+c5WYpXHXWf9
         /eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996033; x=1719600833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgsONUIW6hQ1GQ3rkK8S8br7yH5EZzfCmWfTPiaM4X4=;
        b=fxQTHvQZtKfbupnosOs5fImSMx2olAgU4Vca4v5T8AmoOZsq7Cdhfk0HgZUROaB5QT
         B3FfFYj1NIxgyYoeeBqYl9FkTKj/ngOH/UheLTyKhgGWgbFM6NFCGCa4d7k/oSmiyIGx
         ujIkoGAIFVNJieAVor25ikbWWi3dBPEUrQtA4xcuiz0YcdnTc3YYHph1+o8iGlEXSCCu
         +Gmx5JnriMumtngj5xRWJhj70yFAepVGiyIjssxtejPUIi3OIQhBO+Z8siq0PzSLrJW+
         YaOzwntUV4QYytOF8iQwoIqk3aWKUovva3ecUREWL6ldjnwvtcqtYCB+5p7ggkpb8lCa
         22Cg==
X-Gm-Message-State: AOJu0YySa3T/4+HYUrMkA4c8VAG2rXqo36HbjFWv1DZT6+B6cKpThVM5
	UGIoKsupGwwnKq++DydES+b9/mWdGDjgPccwBYICoAPOvL2wUuLeO0EwhRyRcIWqMuvXWrRjr6Y
	q
X-Google-Smtp-Source: AGHT+IGySu39iwl8z/YjYKwM2IujjqlpjavTZS0/+FCsiGONDFe5RfT30VPifVBJgii5l/ZkiN62rQ==
X-Received: by 2002:a05:6a20:3d8b:b0:1ba:f390:5532 with SMTP id adf61e73a8af0-1bcbb45f7f2mr11357571637.27.1718996032571;
        Fri, 21 Jun 2024 11:53:52 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::6:1ec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e06e7sm3957366a91.21.2024.06.21.11.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:53:50 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 3/8] libbtrfsutil: don't check for UID 0 in subvolume iterator
Date: Fri, 21 Jun 2024 11:53:32 -0700
Message-ID: <bbf035d7f6c53443fd6a9a1524a99c8c6e5e07ee.1718995160.git.osandov@fb.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718995160.git.osandov@fb.com>
References: <cover.1718995160.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

The subvolume iterator API explicitly checks whether geteuid() == 0 to
decide whether to use the unprivileged BTRFS_IOC_GET_SUBVOL_ROOTREF and
BTRFS_IOC_INO_LOOKUP_USER ioctls or the privileged BTRFS_IOC_TREE_SEARCH
ioctl. This breaks in user namespaces:

  $ unshare -r python3 -c 'import btrfsutil; print(list(btrfsutil.SubvolumeIterator("/home")))'
  Traceback (most recent call last):
    File "<string>", line 1, in <module>
  btrfsutil.BtrfsUtilError: [BtrfsUtilError 12 Errno 1] Could not search B-tree: Operation not permitted

Instead of the explicit check, let's try the privileged mode first, and
if it fails with a permission error, fall back to the unprivileged mode
(which has been supported since Linux 4.18). Note that we have to try
the privileged mode first, since even for privileged users, the
unprivileged mode may omit some subvolumes that are hidden by filesystem
mounts.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 libbtrfsutil/subvolume.c | 41 +++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
index 70f2ec70..eba1c9a2 100644
--- a/libbtrfsutil/subvolume.c
+++ b/libbtrfsutil/subvolume.c
@@ -32,11 +32,6 @@
 
 #include "btrfsutil_internal.h"
 
-static bool is_root(void)
-{
-	return geteuid() == 0;
-}
-
 /*
  * This intentionally duplicates btrfs_util_is_subvolume_fd() instead of opening
  * a file descriptor and calling it, because fstat() and fstatfs() don't accept
@@ -807,7 +802,11 @@ struct search_stack_entry {
 };
 
 struct btrfs_util_subvolume_iterator {
-	bool use_tree_search;
+	/*
+	 * 1 if using tree search, 0 if using unprivileged ioctls, -1 if not
+	 * determined yet.
+	 */
+	int use_tree_search;
 	int fd;
 	/* cur_fd is only used for subvolume_iterator_next_unprivileged(). */
 	int cur_fd;
@@ -1009,14 +1008,14 @@ PUBLIC enum btrfs_util_error btrfs_util_create_subvolume_iterator_fd(int fd,
 {
 	struct btrfs_util_subvolume_iterator *iter;
 	enum btrfs_util_error err;
-	bool use_tree_search;
+	int use_tree_search;
 
 	if (flags & ~BTRFS_UTIL_SUBVOLUME_ITERATOR_MASK) {
 		errno = EINVAL;
 		return BTRFS_UTIL_ERROR_INVALID_ARGUMENT;
 	}
 
-	use_tree_search = top != 0 || is_root();
+	use_tree_search = top == 0 ? -1 : 1;
 	if (top == 0) {
 		err = btrfs_util_is_subvolume_fd(fd);
 		if (err)
@@ -1666,13 +1665,29 @@ PUBLIC enum btrfs_util_error btrfs_util_subvolume_iterator_next(struct btrfs_uti
 								char **path_ret,
 								uint64_t *id_ret)
 {
+	/*
+	 * On the first iteration, iter->use_tree_search < 0. In that case, we
+	 * try a tree search, and if it fails with a permission error, we fall
+	 * back to the unprivileged ioctls.
+	 */
 	if (iter->use_tree_search) {
-		return subvolume_iterator_next_tree_search(iter, path_ret,
-							   id_ret);
-	} else {
-		return subvolume_iterator_next_unprivileged(iter, path_ret,
-							    id_ret);
+		enum btrfs_util_error err;
+		struct search_stack_entry *entry;
+
+		err = subvolume_iterator_next_tree_search(iter, path_ret,
+							  id_ret);
+		if (iter->use_tree_search > 0)
+			return err;
+
+		if (err != BTRFS_UTIL_ERROR_SEARCH_FAILED || errno != EPERM) {
+			iter->use_tree_search = 1;
+			return err;
+		}
+		entry = iter->search_stack;
+		entry->id = entry->search.key.min_objectid;
+		iter->use_tree_search = 0;
 	}
+	return subvolume_iterator_next_unprivileged(iter, path_ret, id_ret);
 }
 PUBLIC enum btrfs_util_error btrfs_util_subvolume_iter_next(struct btrfs_util_subvolume_iterator *iter,
 							     char **path_ret,
-- 
2.45.2


