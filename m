Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF701C748
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfENKyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 06:54:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:40882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfENKyu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 06:54:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6C10AFC7
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 10:54:49 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 8/8] btrfs: Remove redundant assignment of tgt_device->commit_total_bytes
Date:   Tue, 14 May 2019 13:54:45 +0300
Message-Id: <20190514105445.23051-9-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514105445.23051-1-nborisov@suse.com>
References: <20190514105445.23051-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is already done in btrfs_init_dev_replace_tgtdev which is the first
phase of device replace, called before doing scrub. During that time
exclusive lock is held. Additionally btrfs_fs_device::commit_total_bytes
is always set based on the size of the underlying block device which
shouldn't change once set. This makes the 2nd assignment of the variable
in the finishing phase redundant.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/dev-replace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 8ec9328609bd..5005a03ba847 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -669,7 +669,6 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	btrfs_device_set_disk_total_bytes(tgt_device,
 					  src_device->disk_total_bytes);
 	btrfs_device_set_bytes_used(tgt_device, src_device->bytes_used);
-	tgt_device->commit_total_bytes = src_device->commit_total_bytes;
 	tgt_device->commit_bytes_used = src_device->bytes_used;
 
 	btrfs_assign_next_active_device(src_device, tgt_device);
-- 
2.17.1

