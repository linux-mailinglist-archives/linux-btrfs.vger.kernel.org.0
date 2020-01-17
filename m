Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556C7140B7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAQNsy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:54 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36429 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgAQNsx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:53 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so22716490qkc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4adHR5F024ZCFETalNl7qYodPCR2rclkM9ufEryDrI4=;
        b=FkV3+C1awOkIh5cMv2hRAkjEhLpaTfx9Q6zBN4kNkhEM6jDMrv/sZEGqh99KCjJWvh
         cK2MvVtpkLASxCtNgD1NSOWDJEzkTp31jhkTpGeRjCjdaYGwf3+5/jtxKGsyn4GfUWpE
         PolT7xoiSrcituHO+M0h9d6lA63KABttFOeM8Id3z1nqnBZKhw3u9pqKtcb9cpOuRoco
         mIjHE4h4EmwJJ8h6l36h4TIjeLBQ+BF60NR9ZbDSK3tv01cIKwMI4R1uTngjkCu3Asft
         8nQj7SChH/Q/w/HjayZP6rnLiZXcFopGm3ZOEZUQpmotcHwooBu8Fw39SNaOBhrXQFZl
         m45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4adHR5F024ZCFETalNl7qYodPCR2rclkM9ufEryDrI4=;
        b=gHjrKgc2JFr8CEbra3IVCnE9jB8BdvbZGWFrMpAuyzLBPquz6nvN4TpWJRj8QsUHq2
         7qjBwt0fPJM2HF1BGM4pBzOh9Rhch6/LZEaPK5OyDl3cVnKI65+088/zk6xbTlVVSNFG
         t/7IZpimLFmMfnyIRbsadI6pD6v+mSyvdrP8y9U/t2k6QXWDfVyzPomYkUkq3OZDO6TZ
         9mIvHHEjtLLFEJsIHBjXN/xd3FcYK040xyHTY209Erg2BCcSgMoblkz0CHpX2hdICduV
         /o/Qr8s7PdlBgQt2Oy9mmnWJZXIi+21n0D46oAApMAG0vD6CCPxT4Cb3is1Ll9HDyY7R
         vV6Q==
X-Gm-Message-State: APjAAAXZHhrnpgCq3Xkb82Tq5VzQc5HQ4H7X9MBCDdVcDFaWaZT18GAQ
        jxBHmAFv+P7gKhUe2gfjZBoqlb6kx6/fJQ==
X-Google-Smtp-Source: APXvYqw94VmzVuTDvNSgThAtbrK3OHr95VWSk4EfzwAhF+ga4TXawznRq55qAhy9+3cqc+o7IzjbIA==
X-Received: by 2002:a37:bcc7:: with SMTP id m190mr33894122qkf.103.1579268932021;
        Fri, 17 Jan 2020 05:48:52 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j185sm11811939qkc.96.2020.01.17.05.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 30/43] btrfs: hold a ref on the root in scrub_print_warning_inode
Date:   Fri, 17 Jan 2020 08:47:45 -0500
Message-Id: <20200117134758.41494-31-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the root for the bytenr that is failing, so we need to hold a
ref on the root for that operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/scrub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b5f420456439..f9ee327d7978 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -658,6 +658,10 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 		ret = PTR_ERR(local_root);
 		goto err;
 	}
+	if (!btrfs_grab_fs_root(local_root)) {
+		ret = -ENOENT;
+		goto err;
+	}
 
 	/*
 	 * this makes the path point to (inum INODE_ITEM ioff)
@@ -668,6 +672,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 
 	ret = btrfs_search_slot(NULL, local_root, &key, swarn->path, 0, 0);
 	if (ret) {
+		btrfs_put_fs_root(local_root);
 		btrfs_release_path(swarn->path);
 		goto err;
 	}
@@ -688,6 +693,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 	ipath = init_ipath(4096, local_root, swarn->path);
 	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(ipath)) {
+		btrfs_put_fs_root(local_root);
 		ret = PTR_ERR(ipath);
 		ipath = NULL;
 		goto err;
@@ -711,6 +717,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 				  min(isize - offset, (u64)PAGE_SIZE), nlink,
 				  (char *)(unsigned long)ipath->fspath->val[i]);
 
+	btrfs_put_fs_root(local_root);
 	free_ipath(ipath);
 	return 0;
 
-- 
2.24.1

