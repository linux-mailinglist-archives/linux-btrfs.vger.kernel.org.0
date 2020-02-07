Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3E155047
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 03:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgBGB7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 20:59:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:35040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbgBGB7w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 20:59:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 288A6AC79;
        Fri,  7 Feb 2020 01:59:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/3] fstests: btrfs: Use word mathcing for _btrfs_get_subvolid()
Date:   Fri,  7 Feb 2020 09:59:40 +0800
Message-Id: <20200207015942.9079-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207015942.9079-1-wqu@suse.com>
References: <20200207015942.9079-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Current _btrfs_get_subvolid() can't handle the following case at all:
  # btrfs subvol list $SCRATCH_MNT
  ID 256 gen 9 top level 5 path subv1
  ID 257 gen 7 top level 256 path subv1/subv2
  ID 258 gen 8 top level 256 path subv1/subv3
  ID 259 gen 9 top level 256 path subv1/subv4

If we call "_btrfs_get_subvolid $SCRATCH_MNT subv1" we will get a list
of all subvolumes, not the subvolid of subv1.

To address this problem, we go egrep to match $name which starts with a
space, and at the end of a line.
So that all other subvolumes won't hit.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/btrfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/btrfs b/common/btrfs
index 19ac7cc4..85b33e4c 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -7,7 +7,7 @@ _btrfs_get_subvolid()
 	mnt=$1
 	name=$2
 
-	$BTRFS_UTIL_PROG sub list $mnt | grep $name | awk '{ print $2 }'
+	$BTRFS_UTIL_PROG sub list $mnt | egrep "\s$name$" | awk '{ print $2 }'
 }
 
 # _require_btrfs_command <command> [<subcommand>|<option>]
-- 
2.23.0

