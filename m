Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA610F93A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 08:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfLCHrG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 02:47:06 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:43344 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfLCHrG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Dec 2019 02:47:06 -0500
Received: by mail-pj1-f67.google.com with SMTP id g4so1167140pjs.10
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 23:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RzFgH0t2/tGgc3tkkZGZS2S/c43mqydH8uRXaQzXTEw=;
        b=vBD41ysR0B8fggWZ18RMZ6JovdrelE7JIK0PlKEFhOepOtmNOGiKLN2eXqwqufLmlj
         32/6JdMzfmupa6NjdkIxRM+RWiZYWPGghcHwCAHQWvGU1wBTO11mZiRWXEFoIjkFeGRF
         ABsLUQ0ysfsOW0ECztAniH4jdF+EjfiHtsqMuubMZzNTT0TWUT7x5eNsCPN2XSSNrNcU
         NUN9Etaz/qULcxtrdZ0+ppgQrhdggaQAOQ6aRzCMwlXymjIykvk06wT9VkKduip3sx6a
         +EkDLSl31Am6E+ekjH5OHzw3OjFAoJd0ShnRIQqR/cR19qEjT4KmGYRMaU7qlMK4oCcs
         5GpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RzFgH0t2/tGgc3tkkZGZS2S/c43mqydH8uRXaQzXTEw=;
        b=NtecIJafw+rVybKDD7GPdgzHXzCGpHchvj+jADPHHjYOK13EdVGnqWEWo87pR518Uv
         0rkep9zjWgEMURZhHypIBSupB/keEyG1WQhTcJRVd5BxHWzepaqE6XFcbANJkdlQW9s+
         WQRIy7WKAnPEP9cl9e2AQeZx5TmgKAmY2S4Tcuxyt+ShAx7HtpVh1jZ9f83jENlx8QUm
         X/DDnBlawh2gR3GqA6NkEfpbZVFuGXB0/rHN1Rs9AmgeXfEz+6T+h2Gl210/ZRKkA5eI
         YaQz37TLReL4RW1yM67GsAmYITDlateQzzOf1hyPTPmhklmw+civ3iap2tBPAv19wXTi
         0oBg==
X-Gm-Message-State: APjAAAXMQDN35BIbjhVzdqlPMRNyh3NO/AKtdDsFo5POx+tjC7701I/d
        DHTQlKlafTk4Gmnc4IcPYgVybrH5v+Vm2A==
X-Google-Smtp-Source: APXvYqw5ZwDttpYAHWa7YMJsrKR9Sfxb80j6Zx1Cpi61vaFmTVOk3uyVUV4nN17EGz6yXpRl/whPpQ==
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr3603512plp.111.1575359224250;
        Mon, 02 Dec 2019 23:47:04 -0800 (PST)
Received: from vader ([2620:10d:c090:180::c0f1])
        by smtp.gmail.com with ESMTPSA id n15sm2238488pgf.17.2019.12.02.23.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 23:47:03 -0800 (PST)
Date:   Mon, 2 Dec 2019 23:47:02 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: Re: [PATCH 7/9] btrfs: drop create parameter to btrfs_get_extent()
Message-ID: <20191203074702.GA829117@vader>
References: <cover.1575336815.git.osandov@fb.com>
 <3012e96179bf1427eca8e26332c7c4475f31c76b.1575336816.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3012e96179bf1427eca8e26332c7c4475f31c76b.1575336816.git.osandov@fb.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 02, 2019 at 05:34:23PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> We only pass this as 1 from __extent_writepage_io(). The parameter
> basically means "pretend I didn't pass in a page". This is silly since
> we can simply not pass in the page. Get rid of the parameter from
> btrfs_get_extent(), and since it's used as a get_extent_t callback,
> remove it from get_extent_t and btree_get_extent(), neither of which
> need it.
> 
> While we're here, let's document btrfs_get_extent().
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/ctree.h     |  2 +-
>  fs/btrfs/disk-io.c   |  4 ++--
>  fs/btrfs/disk-io.h   |  4 ++--
>  fs/btrfs/extent_io.c |  6 +++---
>  fs/btrfs/extent_io.h |  6 ++----
>  fs/btrfs/file.c      | 17 ++++++++---------
>  fs/btrfs/inode.c     | 41 ++++++++++++++++++++++++-----------------
>  fs/btrfs/ioctl.c     |  2 +-
>  8 files changed, 43 insertions(+), 39 deletions(-)

I missed the sanity tests. This needs the following folded in (which I
can do if I have to resend this series):

diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 09ecf7dc7b08..bb8efc5ce9e3 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -263,7 +263,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 
 	/* First with no extents */
 	BTRFS_I(inode)->root = root;
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, sectorsize);
 	if (IS_ERR(em)) {
 		em = NULL;
 		test_err("got an error when we shouldn't have");
@@ -283,7 +283,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	 */
 	setup_file_extents(root, sectorsize);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, (u64)-1, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, (u64)-1);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -305,7 +305,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -333,7 +333,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -356,7 +356,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Regular extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -384,7 +384,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* The next 3 are split extents */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -413,7 +413,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -435,7 +435,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -469,7 +469,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Prealloc extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -498,7 +498,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* The next 3 are a half written prealloc extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -528,7 +528,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -561,7 +561,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -596,7 +596,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Now for the compressed extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -630,7 +630,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Split compressed extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -665,7 +665,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -692,7 +692,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -727,8 +727,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* A hole between regular extents but no hole extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset + 6,
-			sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset + 6, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -755,7 +754,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, SZ_4M, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, SZ_4M);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -788,7 +787,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -872,7 +871,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	insert_inode_item_key(root);
 	insert_extent(root, sectorsize, sectorsize, sectorsize, 0, sectorsize,
 		      sectorsize, BTRFS_FILE_EXTENT_REG, 0, 1);
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, 2 * sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, 2 * sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -895,7 +894,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, sectorsize,
-			2 * sectorsize, 0);
+			      2 * sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
