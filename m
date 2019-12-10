Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0BA11818C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 08:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfLJHwJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 02:52:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:49320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfLJHwJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 02:52:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C3C7AEA2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2019 07:52:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: disk-io: Remove duplicated ASSERT() call
Date:   Tue, 10 Dec 2019 15:52:02 +0800
Message-Id: <20191210075202.47373-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two ASSERT() with completely the same check introduced in
commit f7717d8cdb7d ("btrfs-progs: Remove fsid/metdata_uuid fields
from fs_info").

Just remove it.

Fixes: f7717d8cdb7d ("btrfs-progs: Remove fsid/metdata_uuid fields from fs_info")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 disk-io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/disk-io.c b/disk-io.c
index 659f8b93a7ca..8fe811e861fc 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1248,7 +1248,6 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
 		goto out_devices;
 	}
 
-	ASSERT(!memcmp(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE));
 	ASSERT(!memcmp(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE));
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
 		ASSERT(!memcmp(disk_super->metadata_uuid,
-- 
2.24.0

