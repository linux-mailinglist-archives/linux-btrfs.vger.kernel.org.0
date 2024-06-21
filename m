Return-Path: <linux-btrfs+bounces-5893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D13912D96
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 20:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F2EB25901
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 18:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ABB17BB3C;
	Fri, 21 Jun 2024 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="VxwGbM0Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA91017B4FE
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996037; cv=none; b=bPK4R1aixgWLLG76mAIkdFOPO10vf9PZTAtN+D6CFlPyGl93AMqoFJadJ8lCD3PA2uyCIK7Ku2b7HJlxFJobqsZQIGOz2aQ0q1AnYzyHYHrrn6Ca/Xa3aplDD6O89WqEcllteAaQ2+Baeh3CDttmNiRX4sto/Sz7+wJW9a9PGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996037; c=relaxed/simple;
	bh=mhv5QF095JIGiSxy41gyJ3vY+0UH8SKekFSGflbaDhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kz2EjE2gYNSjTjsXHCmCe9T0TqxfEpjTjX4+ZheOhNJcVRuLl/mKtvZxC01ktMzY97E8qXMLUd7lA91ozFFcn4BwStN6ktx3BIXGUB1PZA2GvUTg1KUkau5tn+QqYXcIIDGVfzIUyMtwfw+2k13JYgPlLQWp8i7uiVCOACj2FyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=VxwGbM0Q; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c8062f9097so1338626a91.3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718996035; x=1719600835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J62jH7b1P/whf0NuPiJzUpP6AN5sakui0rym/z5iENQ=;
        b=VxwGbM0Qnc7Ftg+1Xe1Zf1QBKwL2RkcM/XGKRNs+16ZQ8PAbk4UGqBou5H/BBEOCb/
         w+QgfBCX3vTJkgBsygJ/wJMjI+liSKaXN2JJNA2LzEXNXNKK7LhD0TXbQ9bGCP4tW7Ep
         iKTXovDUwEgUWjVFQpBA/wj70yrmK+srNlrQuByUX44YHi6P5FKEQ/ndVTu7cLyLO0+g
         wnLUd3rYDT4x/V9dD3+rmYz+cvkscQqKIwxQuV0ZAJohTG6rSvyMJKK0zRvkbBcNHrYb
         wbgXJsZ8zLeOVnkMhYO4rxuviKunsKE6vtxGJmmHjTOadnJSTNVXZDleuK21vOGVKPYg
         4pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996035; x=1719600835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J62jH7b1P/whf0NuPiJzUpP6AN5sakui0rym/z5iENQ=;
        b=ZHVg2Refefk6bzyAFYo4oI435xlahHdBOOXWti1Q+jfiKE24ad3+BkrUEygSJ31YLc
         1hdUtsCnQBEi1ZG4DyBJwKrb3ji7QfdwjvXm7PVPlOzxVamdNxsni/w3zDn/LveWYJIS
         ptuDtFbhxMeN1fDXGoCa7jYYv9haSS/PMl/PrDX5E40CJahHzM5obJTl03/Ws4DrFt9R
         Hg6EO5dIvFu36a7yPOsToVV/L63owimLOH5YvN9MtlQ1hKqitcCrJOerR8wscEppq+kc
         V/H1/k4QfGeRypsZnEDbXlmJiBliSV7c+v80JznUiK9xkWCw0HXx70NOaaATioaJp8CN
         GRwQ==
X-Gm-Message-State: AOJu0Yw40RcA8qCKT+U7qQYFLwfnH1mDmF0qF47lEX/GsweuTOq8mXjO
	VryJ+cU0A2cFsugYVI+JaiTrHTEPfptTjjByFZ6Q7H6c3ZcqsAapDRIumm8q+xKnYQRd6QCxNEB
	0
X-Google-Smtp-Source: AGHT+IEZY5EMrZaORcN7+Jm+IAOuPLRWYYa45v/ShFq7uCekzvVuMXjhHcB+4Jpx8FFTR4t2xIbcPQ==
X-Received: by 2002:a17:90b:3715:b0:2c2:ce7a:7cb6 with SMTP id 98e67ed59e1d1-2c7b5c8ff34mr10316055a91.26.1718996035450;
        Fri, 21 Jun 2024 11:53:55 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::6:1ec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e06e7sm3957366a91.21.2024.06.21.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:53:54 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 5/8] btrfs-progs: subvol list: remove unused filters
Date: Fri, 21 Jun 2024 11:53:34 -0700
Message-ID: <19de1d34351891202202d4bc218214e0c0ce818f.1718995160.git.osandov@fb.com>
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

BTRFS_LIST_FILTER_ROOTID hasn't been used since commit 9e73a416f0ac
("btrfs-progs: use libbtrfsutil for get-default"), and
BTRFS_LIST_FILTER_BY_PARENT hasn't been used since commit 9005b603d723
("btrfs-progs: use libbtrfsutil for subvol show").

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 cmds/subvolume-list.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 060f4f31..cfe165f9 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -193,7 +193,6 @@ enum btrfs_list_column_enum {
 };
 
 enum btrfs_list_filter_enum {
-	BTRFS_LIST_FILTER_ROOTID,
 	BTRFS_LIST_FILTER_SNAPSHOT_ONLY,
 	BTRFS_LIST_FILTER_FLAGS,
 	BTRFS_LIST_FILTER_GEN,
@@ -206,7 +205,6 @@ enum btrfs_list_filter_enum {
 	BTRFS_LIST_FILTER_CGEN_MORE,
 	BTRFS_LIST_FILTER_TOPID_EQUAL,
 	BTRFS_LIST_FILTER_FULL_PATH,
-	BTRFS_LIST_FILTER_BY_PARENT,
 	BTRFS_LIST_FILTER_DELETED,
 	BTRFS_LIST_FILTER_MAX,
 };
@@ -932,11 +930,6 @@ static int list_subvol_search(int fd, struct rb_root *root_lookup)
 	return 0;
 }
 
-static int filter_by_rootid(struct root_info *ri, u64 data)
-{
-	return ri->root_id == data;
-}
-
 static int filter_snapshot(struct root_info *ri, u64 data)
 {
 	return !!ri->root_offset;
@@ -1005,18 +998,12 @@ static int filter_full_path(struct root_info *ri, u64 data)
 	return 1;
 }
 
-static int filter_by_parent(struct root_info *ri, u64 data)
-{
-	return !uuid_compare(ri->puuid, (u8 *)(unsigned long)data);
-}
-
 static int filter_deleted(struct root_info *ri, u64 data)
 {
 	return ri->deleted;
 }
 
 static btrfs_list_filter_func all_filter_funcs[] = {
-	[BTRFS_LIST_FILTER_ROOTID]		= filter_by_rootid,
 	[BTRFS_LIST_FILTER_SNAPSHOT_ONLY]	= filter_snapshot,
 	[BTRFS_LIST_FILTER_FLAGS]		= filter_flags,
 	[BTRFS_LIST_FILTER_GEN_MORE]		= filter_gen_more,
@@ -1027,7 +1014,6 @@ static btrfs_list_filter_func all_filter_funcs[] = {
 	[BTRFS_LIST_FILTER_CGEN_EQUAL]          = filter_cgen_equal,
 	[BTRFS_LIST_FILTER_TOPID_EQUAL]		= filter_topid_equal,
 	[BTRFS_LIST_FILTER_FULL_PATH]		= filter_full_path,
-	[BTRFS_LIST_FILTER_BY_PARENT]		= filter_by_parent,
 	[BTRFS_LIST_FILTER_DELETED]		= filter_deleted,
 };
 
-- 
2.45.2


