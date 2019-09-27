Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8A1C03B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 12:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfI0Kwi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 06:52:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:44222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbfI0Kwi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 06:52:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70F44B159;
        Fri, 27 Sep 2019 10:52:36 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] common/rc: Remove special handing of 'dup' argument for btrfs
Date:   Fri, 27 Sep 2019 13:52:32 +0300
Message-Id: <20190927105233.14926-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

_scratch_pool_mkfs special cases the command executed when 'dup' option
is used when creating a filesystem. This is wrong since 'dup' works
for all profiles and number of devices. This bug manifested while
exercising btrfs' balance argument combinations test.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/rc | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index 9f2c252e5aa5..1b150cbad2f6 100644
--- a/common/rc
+++ b/common/rc
@@ -885,13 +885,7 @@ _scratch_pool_mkfs()
 {
     case $FSTYP in
     btrfs)
-        # if dup profile is in mkfs options call _scratch_mkfs instead
-        # because dup profile only works with single device
-        if [[ "$*" =~ dup ]]; then
-            _scratch_mkfs $*
-        else
-            $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
-        fi
+        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
         ;;
     *)
         echo "_scratch_pool_mkfs is not implemented for $FSTYP" 1>&2
-- 
2.7.4

