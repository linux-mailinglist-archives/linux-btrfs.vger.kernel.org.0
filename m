Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F256D6655
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjDDO5D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 10:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjDDO4g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 10:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429103C02
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhiCGxChrVJlRUkYdDGuEzFvZQCsRtVvsPA45L+6JnY=;
        b=Q96FW3iDlDESgJ1LA39l2jez1SvxCWPxq9iXNRvStAZqwGyriL+tH3tCfNcOUSoZQu2jM+
        /VAPMw89W5EqfwwNwjDTgdElRUjxkWnQBUlC9C/MF443N5ajAxRrS3GSRZQTeVeOpCEm0k
        L1B86jT8/nOxkTEKHw/n8AUQmoDHOMU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-eOv7S3YIN8-rNTeLxhjrjA-1; Tue, 04 Apr 2023 10:55:38 -0400
X-MC-Unique: eOv7S3YIN8-rNTeLxhjrjA-1
Received: by mail-qv1-f71.google.com with SMTP id f3-20020a0cc303000000b005c9966620daso14611473qvi.4
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 07:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhiCGxChrVJlRUkYdDGuEzFvZQCsRtVvsPA45L+6JnY=;
        b=MDzmHQn+74+b1+w0kvOZApj456RmthnNB+P68GImVns2NA6YUx6ElYHkWcbd6LY9jv
         3FAhEiy7OnUD2EDaKNdE6F8N+X9ChHn/DX6kGwf3p6vQ5pMFr62twFNIGuWa3G5Owqn6
         ZNzcTgEoitezm2pa9qrLG4SEUgIWCPlHCIxMJPPmMniGcmM0Kg4TDGZKGa7nhCNTDz58
         WF+hFFkWkzfUOwcnhRuPRY6GFx5RRUVpp770109GCk74jKkj+LH79Hb1sutGMm9rmgaV
         TgwRfyreu5eqs+y+EZqmqKVT+YDFs5oIVao0IALxTWIBHbzfAjIaPvyw8418rbNcqFgg
         ktLA==
X-Gm-Message-State: AAQBX9fWXWat8rFJahcbB6xSHDeXweGPVlAl+VeO2gKW/nKMEMk88GHv
        ZMx6C8jgtYG1B+/RyerR6k4YMEJjVYxWCosiNhYqHiQouMzQhCI+hpjP9063FZygtqQuMXgFjy2
        sW6EOiQ+HjwYZ9vaX8dKCRw==
X-Received: by 2002:a05:6214:f05:b0:571:13c:6806 with SMTP id gw5-20020a0562140f0500b00571013c6806mr3972704qvb.33.1680620137276;
        Tue, 04 Apr 2023 07:55:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z8MfugNU6YKVlXuq75L3kQ3utmgGFoqTKtMHqOCvYgrWH2c48gYF9y20EeEoB2IWzu0Fdckw==
X-Received: by 2002:a05:6214:f05:b0:571:13c:6806 with SMTP id gw5-20020a0562140f0500b00571013c6806mr3972665qvb.33.1680620136915;
        Tue, 04 Apr 2023 07:55:36 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:36 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 17/23] xfs: initialize fs-verity on file open and cleanup on inode destruction
Date:   Tue,  4 Apr 2023 16:53:13 +0200
Message-Id: <20230404145319.2057051-18-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_file.c  | 8 ++++++++
 fs/xfs/xfs_super.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 705250f9f90a..947b5c436172 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -31,6 +31,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1169,9 +1170,16 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error = 0;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d6f22cb94ee2..d40de32362b1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -46,6 +46,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -667,6 +668,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 
-- 
2.38.4

