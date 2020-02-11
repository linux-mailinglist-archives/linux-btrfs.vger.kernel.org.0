Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21293159B4D
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 22:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBKVkz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 16:40:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43445 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgBKVky (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 16:40:54 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so9189481qtj.10
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 13:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0jgcdIuY6gU1NaU+92gd+csfulh3MbNTikfALkkU4j4=;
        b=ZYqYx2vaNN89ptC4CRm+uuG//K/axsQJkwl3GH6HSnnh/iR5AiQYK0ixr9I1j3SZ5F
         Prs+v1WgKw6X5mbwc7Cayku/OA5F5wOoPeHk4zOZTqMpmYVaVdMKmSUZIoIBREGoMJiQ
         WxVdrWBlSW+djT0qYucdy0hRxtqdhOSMicLLvjCZsUXuqKFiK6tcxKO5z15G1sfltWHE
         iGXUNmTbvwaULq/jJKlhFefxDpUp8CD70OCC9qosGDNjjcL8JdtL221YCLTvbJ4rXH3Y
         /lW09Wxmc3QTRyuQhVYX/KhoCWJRkHeLPgduhEOfAjhTpyNL7avmXLjg66oIEmO3iDGM
         3Ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0jgcdIuY6gU1NaU+92gd+csfulh3MbNTikfALkkU4j4=;
        b=NWxIaPLLvISFUxAGap5/MscbutmXXCg3EyCs5WrgI71lAPxAj3prPYYsjkH+5DzqeF
         YSaoq1kaZ6YRXPYVKECvQ0SBIhCSf2iml3KWyQ2Uu9M5Y2gpMFtTkh7ilG5iw7OkdLsp
         pXHMMCvST2o9sO8cnw7c4QOGw+PpdxULwtrizSqVNkZil6o+aHkcgXJ7t/0z26qwzHvX
         DydSqnWKSCJAABsT2pfqqp5hwuUjfdxTCqS/fWyL6Qo0CjOEf+xewYz/KjtVoCupOsCS
         RqzyxvL0ty84PtBTuTDkxb16wo8MUuSOXQzNaVi2DfIbU6ARL31EIEdW/xMx0pP5wOSj
         8xxw==
X-Gm-Message-State: APjAAAVQRuFJNFLBmN3+N6YJHnOp2+aj8ZUZNKLPoO9SNoNysYcuOPsD
        ytAfJV09uBwH4o85qhX7WWFCo7rsPGg=
X-Google-Smtp-Source: APXvYqygQsa3sFLsSq24a97UzqsxnIr9XFZ/hqHyFBPzGWeLRIiKEkiIMAucZNSgjkF791ErSoqJfQ==
X-Received: by 2002:ac8:74c:: with SMTP id k12mr4368501qth.185.1581457252866;
        Tue, 11 Feb 2020 13:40:52 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e3sm2921263qtb.65.2020.02.11.13.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 13:40:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/4] btrfs: fix bytes_may_use underflow in prealloc error condtition
Date:   Tue, 11 Feb 2020 16:40:42 -0500
Message-Id: <20200211214042.4645-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211214042.4645-1-josef@toxicpanda.com>
References: <20200211214042.4645-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I hit the following warning while running my error injection stress testing

------------[ cut here ]------------
WARNING: CPU: 3 PID: 1453 at fs/btrfs/space-info.h:108 btrfs_free_reserved_data_space_noquota+0xfd/0x160 [btrfs]
RIP: 0010:btrfs_free_reserved_data_space_noquota+0xfd/0x160 [btrfs]
Call Trace:
btrfs_free_reserved_data_space+0x4f/0x70 [btrfs]
__btrfs_prealloc_file_range+0x378/0x470 [btrfs]
elfcorehdr_read+0x40/0x40
? elfcorehdr_read+0x40/0x40
? btrfs_commit_transaction+0xca/0xa50 [btrfs]
? dput+0xb4/0x2a0
? btrfs_log_dentry_safe+0x55/0x70 [btrfs]
? btrfs_sync_file+0x30e/0x420 [btrfs]
? do_fsync+0x38/0x70
? __x64_sys_fdatasync+0x13/0x20
? do_syscall_64+0x5b/0x1b0
? entry_SYSCALL_64_after_hwframe+0x44/0xa9
---[ end trace 70ccb5d0fe51151c ]---

This happens if we fail to insert our reserved file extent.  At this
point we've already converted our reservation from ->bytes_may_use to
->bytes_reserved.  However once we break we will attempt to free
everything from [cur_offset, end] from ->bytes_may_use, but our extent
reservation will overlap part of this.

Fix this problem by adding ins.offset (our extent allocation size) to
cur_offset so we remove the actual remaining part from ->bytes_may_use.

I validated this fix using my inject-error.py script

python inject-error.py -o should_fail_bio -t cache_save_setup -t \
	__btrfs_prealloc_file_range \
	-t insert_reserved_file_extent.constprop.0 \
	-r "-5" ./run-fsstress.sh

where run-fsstress.sh simply mounts and runs fsstress on a disk.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 84e649724549..747d860aedf6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9919,6 +9919,14 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 						  ins.offset, 0, 0, 0,
 						  BTRFS_FILE_EXTENT_PREALLOC);
 		if (ret) {
+			/*
+			 * We've reserved this space, and thus converted it from
+			 * ->bytes_may_use to ->bytes_reserved, which we cleanup
+			 * here.  We need to adjust cur_offset so that we only
+			 * drop the ->bytes_may_use for the area we still have
+			 * remaining in ->>bytes_may_use.
+			 */
+			cur_offset += ins.objectid;
 			btrfs_free_reserved_extent(fs_info, ins.objectid,
 						   ins.offset, 0);
 			btrfs_abort_transaction(trans, ret);
-- 
2.24.1

