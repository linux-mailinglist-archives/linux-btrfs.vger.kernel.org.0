Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA737271DEA
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 10:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgIUI1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 04:27:15 -0400
Received: from mail1.windriver.com ([147.11.146.13]:54116 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIUI1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 04:27:15 -0400
X-Greylist: delayed 3450 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 04:27:10 EDT
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 08L8QwFs023449
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 21 Sep 2020 01:26:59 -0700 (PDT)
Received: from pek-qzhang2-d1.wrs.com (128.224.162.183) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 01:26:39 -0700
From:   <qiang.zhang@windriver.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <johannes.thumshirn@wdc.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] btrfs: Fix missing close devices
Date:   Mon, 21 Sep 2020 16:26:37 +0800
Message-ID: <20200921082637.26009-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

When the btrfs fill super error, we should first close devices and
then call deactivate_locked_super func to free fs_info.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 fs/btrfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8840a4fa81eb..3bfd54e8f388 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1675,6 +1675,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
 	security_free_mnt_opts(&new_sec_opts);
 	if (error) {
+		btrfs_close_devices(fs_devices);
 		deactivate_locked_super(s);
 		return ERR_PTR(error);
 	}
-- 
2.17.1

