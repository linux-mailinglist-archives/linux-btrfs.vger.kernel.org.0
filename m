Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0103D14E440
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 21:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgA3Urq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 15:47:46 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34223 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgA3Urp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 15:47:45 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so2208445qvf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5J6Ek4hzUve+e8R5ZLGFZHJQcANfHjuLHxkqFiigqjk=;
        b=W3MIUIEZ8Tr+qlZgxUjtxUQ/QBRDSEAbhDMtzcqCk6eFYJg/kRxtFtpWOEjL85ho8n
         v5pccchl5niv0kH1PcZM8aTmp9S4nHm/K4d11n8+D3mnyCZcpX4YDH8u6o9xSjLy3iPh
         F47usd4gZd9dBzyVPiefv8ml+SY68fP9ZL37htf3pmywnBFerCHq9HwijVVi5uCgqdbu
         QiOczCZzcB8kv4iqV4eRHTCmM1FRme/afzWR2S6oJzPgg0YFIjgJ/Shd1K0v6QtASgxD
         WIV9sRBXYm0HRdmR/r8nHm6dM6Dy7xx70lM0P75UB4pyGIbJhBE0peQRPEsc6j1skExD
         32oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5J6Ek4hzUve+e8R5ZLGFZHJQcANfHjuLHxkqFiigqjk=;
        b=e/RdTJd/SUGx6d+BStiRiMLD3mKFTKz4iy+jIxy2uWjdNRH4H+ca2Dn23Y3tJ2A91i
         dDU+QJmGMB1izS8RO+PXg8YfeAygZQdiHlaGAJATFymSXVGIs+VBnd/PywhaG7OhkYnf
         sbCovc2Vfz+1vZlBbzVsPzB7UTXEQjIp+9+YHMEU5pPoNmcECTtlFhZQOr63idvPy1UR
         MyCs8yyPLlQX0c5jmR4uamM/O/PujG8bgi+izkbY3BZkFJnV6+cNQEnn5WNntq+77zwA
         Iv/oSPuQTVngMw5tLHHDpWAMJJnVmKpBcetwZopzqPXIO9n/udSDG1be/DcGjKUJ614y
         sFog==
X-Gm-Message-State: APjAAAWf/FxsHt5b/waLh7sCyWb5uATUbAxU9s8YQ10K8rh1vtMo5x2y
        7JVY+35i+sAyCs0BHd/qjyA0dMC/PV6E0Q==
X-Google-Smtp-Source: APXvYqyCwGmdE5Mbk71tA2Usx30TQ9TPLvPb3ZwwJ/E8sdqFjCuFezfqUoPVsPCmr7VjNM7g+MyrGw==
X-Received: by 2002:ad4:514e:: with SMTP id g14mr6711872qvq.196.1580417262473;
        Thu, 30 Jan 2020 12:47:42 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o55sm3806594qtf.46.2020.01.30.12.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:47:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs-progs: fix lowmem check's handling of holes
Date:   Thu, 30 Jan 2020 15:47:36 -0500
Message-Id: <20200130204736.49224-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130204736.49224-1-josef@toxicpanda.com>
References: <20200130204736.49224-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Lowmem check had the opposite problem of normal check, it caught gaps
that started at 0, but would still fail with my fixes in place.  This is
because lowmem check doesn't take into account the isize of the inode.
Address this by making sure we do not complain about gaps that are after
isize.  This makes lowmem pass with my fixes applied, and still fail
without my fixes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 2f76d634..fd503aa6 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2029,7 +2029,8 @@ static int check_file_extent_inline(struct btrfs_root *root,
  * Return 0 if no error occurred.
  */
 static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
-			     unsigned int nodatasum, u64 *size, u64 *end)
+			     unsigned int nodatasum, u64 isize, u64 *size,
+			     u64 *end)
 {
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key fkey;
@@ -2152,7 +2153,7 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 	}
 
 	/* Check EXTENT_DATA hole */
-	if (!no_holes && *end != fkey.offset) {
+	if (!no_holes && (fkey.offset < isize) && (*end != fkey.offset)) {
 		if (repair)
 			ret = punch_extent_hole(root, path, fkey.objectid,
 						*end, fkey.offset - *end);
@@ -2165,7 +2166,8 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 		}
 	}
 
-	*end = fkey.offset + extent_num_bytes;
+	if (fkey.offset + extent_num_bytes < isize)
+		*end = fkey.offset + extent_num_bytes;
 	if (!is_hole)
 		*size += extent_num_bytes;
 
@@ -2726,7 +2728,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 					root->objectid, inode_id, key.objectid,
 					key.offset);
 			}
-			ret = check_file_extent(root, path, nodatasum,
+			ret = check_file_extent(root, path, nodatasum, isize,
 						&extent_size, &extent_end);
 			err |= ret;
 			break;
-- 
2.24.1

