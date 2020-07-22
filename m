Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6680022944A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgGVJAp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 05:00:45 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44273 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbgGVJAo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 05:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595408446; x=1626944446;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i23Db2/vl160bgTBfaWzoMJ2zWexaUO1h+ZKRlAJke8=;
  b=pHlQ0P7S8gj67wrh9rpc9OSTKTtizghWWe6av7pigXv76KzunYT8hGbK
   1HWq/Rxuf2N+gAPBbMjyk8bLynU6PzqDn7T8us4sLXFTaczgc4QZDKuP/
   xkk4mp4RGXbN4Jj1q12n3EE+gS5gSpaokP9JZF4BnRMGnB8ahvZ3vMf+t
   gtvqtwFVOYc5nI0KBNqVqYby9Ksw404ugIy2LzwC8ezUrnxQnLjW7swDE
   9nXHok6JVDupMgWEtw3VZGKyPN7W+EjlUE0GxiZ+qAcEJHRStONNEl2q+
   7Epb90nxiedd79jjgoDz/hFV8xSWfsasEMO7K6IBFMyEuTOAW2iUFobbt
   w==;
IronPort-SDR: TXpayqXD+Fm5l1V/YKJxt0LLMm48GEygH6rSGbmJ4p5nAyk9vFPmSeoZ8EA+wNVX1BhlY70HHR
 SDkGf3AiwXgf5xUZoXFKIRXE4UAq0ozBlUmkiHCnvXCCtpbP+E50JLFi6F0BbJmhvB7TBlZ2Dl
 xbgVlC5RQBVKuVfXBucili9FtGlWgv25wXqdJWyWqcBscYAVAs5LNRIs8FRkILuHWxzHZp2PrG
 tlMcQkOJ17/9uMX7k+Ao0Y6DvQGMNiV9uYPoj4lZf4x+f3PY2vhK/J1D5zDcLWaSFs5x0eLb5F
 oj0=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="246143154"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 17:00:45 +0800
IronPort-SDR: LZpomrcC3bFWtCbG+JeeKCm8Ug+cexmShQECtRA/saQcLm1lL39dQU8PXQwSeoUG9Q6PMX10RC
 /rZMItaaQZiPAhXzo9YULTMUMcR6uaUjM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:49:01 -0700
IronPort-SDR: EP+fQv1hPUkfuUcoXKFxsa7fuv9WPHHebnWOjP3zSUUMZ1cVMExlvSKtvG63wtuJbK7hh2aB3B
 NPJmve7zqO0A==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Jul 2020 02:00:44 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: open-code remount flag setting in btrfs_remount
Date:   Wed, 22 Jul 2020 18:00:39 +0900
Message-Id: <20200722090039.17402-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we're (re)mounting a btrfs filesystem we set the
BTRFS_FS_STATE_REMOUNTING state in fs_info to serialize against async
reclaim or defrags.

This flag is set in btrfs_remount_prepare() called by btrfs_remount(). As
btrfs_remount_prepare() does nothing but setting this flag and doesn't
have a second caller, we can just open-code the flag setting in
btrfs_remount().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/super.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a4f0bb29b8d6..19b1f0e8034e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1782,11 +1782,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 				new_pool_size);
 }
 
-static inline void btrfs_remount_prepare(struct btrfs_fs_info *fs_info)
-{
-	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
-}
-
 static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
 				       unsigned long old_opts, int flags)
 {
@@ -1837,7 +1832,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	int ret;
 
 	sync_filesystem(sb);
-	btrfs_remount_prepare(fs_info);
+	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
 	if (data) {
 		void *new_sec_opts = NULL;
-- 
2.26.2

