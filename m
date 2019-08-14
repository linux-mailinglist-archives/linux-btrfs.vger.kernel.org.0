Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400DD8C565
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfHNBEQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:04:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:41236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726533AbfHNBEP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:04:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86997B0E5
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2019 01:04:14 +0000 (UTC)
Received: from starscream.home.jeffm.io (starscream-1.home.jeffm.io [IPv6:2001:559:c0d4::1fe])
        by mail.home.jeffm.io (Postfix) with ESMTPS id 0C3CF83DC468;
        Tue, 13 Aug 2019 22:05:08 -0400 (EDT)
Received: by starscream.home.jeffm.io (Postfix, from userid 1000)
        id 8C91A6093C7; Tue, 13 Aug 2019 21:04:11 -0400 (EDT)
From:   Jeff Mahoney <jeffm@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 1/5] btrfs-progs: mkfs: treat btrfs_add_to_fsid as fatal error
Date:   Tue, 13 Aug 2019 21:03:58 -0400
Message-Id: <20190814010402.22546-1-jeffm@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When btrfs_add_to_fsid fails in mkfs we try to close the ctree.  That
complains that we already have a transaction open.  We should be taking
the error path and exit cleanly without writing.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 mkfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 971cb395..b752da13 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1268,7 +1268,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					sectorsize, sectorsize, sectorsize);
 		if (ret) {
 			error("unable to add %s to filesystem: %d", file, ret);
-			goto out;
+			goto error;
 		}
 		if (verbose >= 2) {
 			struct btrfs_device *device;
-- 
2.16.4

