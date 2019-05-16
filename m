Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27DA20178
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfEPImz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 04:42:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbfEPImy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 04:42:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8051AECB
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 08:42:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs-progs: Correctly identify fs on image files in "filesystem" subcommands
Date:   Thu, 16 May 2019 11:42:49 +0300
Message-Id: <20190516084250.19363-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516084250.19363-1-nborisov@suse.com>
References: <20190516084250.19363-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if a new filesystem is created and interrogated with we get
an error:

    truncate -s 3g btrfs.img
    mkfs.btrfs btrfs.img
    btrfs fi show btrfs.img
    ERROR: not a valid btrfs filesystem: /root/btrfs.img

The reason is that the image is not automatically recognised by libblkid
meaning btrfs_scan_devices will not "see" the device, resulting in the
aofrementioned error.

Fix it by detecting when this condition occurs and pass the path to the
file to btrfs_scan_devices, which will correctly add it to libblkid's
cache.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 cmds-filesystem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/cmds-filesystem.c b/cmds-filesystem.c
index 4657deb20fde..0327563154d5 100644
--- a/cmds-filesystem.c
+++ b/cmds-filesystem.c
@@ -771,8 +771,7 @@ static int cmd_filesystem_show(int argc, char **argv)
 		goto out;
 
 devs_only:
-	ret = btrfs_scan_devices(NULL);
-
+	ret = btrfs_scan_devices(type == BTRFS_ARG_REG ? search : NULL);
 	if (ret) {
 		error("blkid device scan returned %d", ret);
 		return 1;
-- 
2.7.4

