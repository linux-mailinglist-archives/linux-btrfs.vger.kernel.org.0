Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E96817589B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 11:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCBKq4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 05:46:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:46488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgCBKqz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 05:46:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 254BDAD79;
        Mon,  2 Mar 2020 10:46:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: use rounddown in decide_stripe_size
Date:   Mon,  2 Mar 2020 12:46:51 +0200
Message-Id: <20200302104651.1703-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Dave, please fold this into c1ac11142016 ("btrfs: factor out decide_stripe_size()")

 fs/btrfs/volumes.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 267847c72c22..111c1270f800 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4994,11 +4994,7 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 {
 	struct btrfs_fs_info *info = fs_devices->fs_info;

-	/*
-	 * Round down to number of usable stripes, devs_increment can be any
-	 * number so we can't use round_down()
-	 */
-	ctl->ndevs -= ctl->ndevs % ctl->devs_increment;
+	ctl->ndevs = rounddown(ctl->ndevs, ctl->devs_increment);

 	if (ctl->ndevs < ctl->devs_min) {
 		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
--
2.17.1

