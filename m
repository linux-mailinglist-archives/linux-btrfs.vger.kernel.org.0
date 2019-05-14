Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649561C74D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfENKyu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 06:54:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:40848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfENKyt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 06:54:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F007AFC7
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 10:54:48 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/8] btrfs: Remove impossible WARN_ON
Date:   Tue, 14 May 2019 13:54:40 +0300
Message-Id: <20190514105445.23051-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514105445.23051-1-nborisov@suse.com>
References: <20190514105445.23051-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This WARN_ON can never trigger because src_device cannot be null.
btrfs_find_device_by_devspec always returns either an error or a valid
pointer to the device. Just remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/dev-replace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index ac6600a00188..7db9057d3d3c 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -447,7 +447,6 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	}
 
 	dev_replace->cont_reading_from_srcdev_mode = read_src;
-	WARN_ON(!src_device);
 	dev_replace->srcdev = src_device;
 	dev_replace->tgtdev = tgt_device;
 
-- 
2.17.1

