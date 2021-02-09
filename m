Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDF4314E75
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 12:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhBILvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 06:51:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhBILt6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 06:49:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2693D64E3B
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Feb 2021 11:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612871355;
        bh=Ix8sK+v3/nrZ5dnsB2JDucVLA4p8ek+mQnSiOO/mcxU=;
        h=From:To:Subject:Date:From;
        b=lD3viqVq5L8bLcfSj47tBZn7EsnLg1iD3qOHsx+QFdXu99jaiWtmH+BidRkIo88GD
         7xWu4hpLL9d+laqittLjTOM20u8PH20isM6U0SdlqJXSECg9ijvAYiKh3XUCaaC5/u
         A1sbWSfyHhInwn+cWNWKjHAHlANiMl4l5DyYtilX/a9PImPsPUOghNTsClfBUt4OVK
         nOW/6+hNFyk95unHkJ7XcIRGkT9Osy8TB2R8P9aeBoJJJIIxqW5eLEFHCSx9NgviVe
         ICSwbP4cLy4mh+zENjtojYzSyy8sb45FB+zlFCrvdob7wOKeXngDwkpvxZaPdy7ARd
         RL5v4v0qtXqKw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: remove workaround for setting capabilities in the receive command
Date:   Tue,  9 Feb 2021 11:49:12 +0000
Message-Id: <e35e5d556cd5964a4ab80bdd997856ee5be8b888.1612870936.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We had a few bugs on the kernel side of send/receive where capabilities
ended up being lost after receiving a send stream. They all stem from the
fact that the kernel used to send all xattrs before issuing the chown
command, and the later clears any existing capabilities in a file or
directory.

Initially a workaround was added to btrfs-progs' receive command, in commit
123a2a085027e ("btrfs-progs: receive: restore capabilities after chown"),
and that fixed some instances of the problem. More recently, other instances
of the problem were found, a proper fix for the kernel was made, which fixes
the root problem by making send always emit the sexattr command for setting
capabilities after issuing a chown command. This was done in kernel commit
89efda52e6b693 ("btrfs: send: emit file capabilities after chown"), which
landed in kernel 5.8.

However, the workaround on the receive command now causes us to incorrectly
set a capability on a file that should not have it, because it assumes all
setxattr commands for a file always comes before a chown.

Example reproducer:

  $ cat send-caps.sh
  #!/bin/bash

  DEV1=/dev/sdh
  DEV2=/dev/sdi

  MNT1=/mnt/sdh
  MNT2=/mnt/sdi

  mkfs.btrfs -f $DEV1 > /dev/null
  mkfs.btrfs -f $DEV2 > /dev/null

  mount $DEV1 $MNT1
  mount $DEV2 $MNT2

  touch $MNT1/foo
  touch $MNT1/bar
  setcap cap_net_raw=p $MNT1/foo

  btrfs subvolume snapshot -r $MNT1 $MNT1/snap1

  btrfs send $MNT1/snap1 | btrfs receive $MNT2

  echo
  echo "capabilities on destination filesystem:"
  echo
  getcap $MNT2/snap1/foo
  getcap $MNT2/snap1/bar

  umount $MNT1
  umount $MNT2

When running the test script, we can see that both files foo and bar get
the capability set, when only file foo should have it:

  $ ./send-caps.sh
  Create a readonly snapshot of '/mnt/sdh' in '/mnt/sdh/snap1'
  At subvol /mnt/sdh/snap1
  At subvol snap1

  capabilities on destination filesystem:

  /mnt/sdi/snap1/foo cap_net_raw=p
  /mnt/sdi/snap1/bar cap_net_raw=p

Since the kernel fix was backported to all currently supported stable
releases (5.10.x, 5.4.x, 4.19.x, 4.14.x, 4.9.x and 4.4.x), remove the
workaround from receive. Having such a workaround relying on the order
of commands in a send stream is always troublesome and doomed to break
one day.

A test case for fstests will come soon.

Reported-by: Richard Brown <rbrown@suse.de>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 cmds/receive.c | 49 -------------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index 2aaba3ff..b4099bc4 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -77,14 +77,6 @@ struct btrfs_receive
 	struct subvol_uuid_search sus;
 
 	int honor_end_cmd;
-
-	/*
-	 * Buffer to store capabilities from security.capabilities xattr,
-	 * usually 20 bytes, but make same room for potentially larger
-	 * encodings. Must be set only once per file, denoted by length > 0.
-	 */
-	char cached_capabilities[64];
-	int cached_capabilities_len;
 };
 
 static int finish_subvol(struct btrfs_receive *rctx)
@@ -825,22 +817,6 @@ static int process_set_xattr(const char *path, const char *name,
 		goto out;
 	}
 
-	if (strcmp("security.capability", name) == 0) {
-		if (bconf.verbose >= 4)
-			fprintf(stderr, "set_xattr: cache capabilities\n");
-		if (rctx->cached_capabilities_len)
-			warning("capabilities set multiple times per file: %s",
-				full_path);
-		if (len > sizeof(rctx->cached_capabilities)) {
-			error("capabilities encoded to %d bytes, buffer too small",
-				len);
-			ret = -E2BIG;
-			goto out;
-		}
-		rctx->cached_capabilities_len = len;
-		memcpy(rctx->cached_capabilities, data, len);
-	}
-
 	if (bconf.verbose >= 3) {
 		fprintf(stderr, "set_xattr %s - name=%s data_len=%d "
 				"data=%.*s\n", path, name, len,
@@ -961,23 +937,6 @@ static int process_chown(const char *path, u64 uid, u64 gid, void *user)
 		error("chown %s failed: %m", path);
 		goto out;
 	}
-
-	if (rctx->cached_capabilities_len) {
-		if (bconf.verbose >= 3)
-			fprintf(stderr, "chown: restore capabilities\n");
-		ret = lsetxattr(full_path, "security.capability",
-				rctx->cached_capabilities,
-				rctx->cached_capabilities_len, 0);
-		memset(rctx->cached_capabilities, 0,
-				sizeof(rctx->cached_capabilities));
-		rctx->cached_capabilities_len = 0;
-		if (ret < 0) {
-			ret = -errno;
-			error("restoring capabilities %s: %m", path);
-			goto out;
-		}
-	}
-
 out:
 	return ret;
 }
@@ -1155,14 +1114,6 @@ static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
 		goto out;
 
 	while (!end) {
-		if (rctx->cached_capabilities_len) {
-			if (bconf.verbose >= 4)
-				fprintf(stderr, "clear cached capabilities\n");
-			memset(rctx->cached_capabilities, 0,
-					sizeof(rctx->cached_capabilities));
-			rctx->cached_capabilities_len = 0;
-		}
-
 		ret = btrfs_read_and_process_send_stream(r_fd, &send_ops,
 							 rctx,
 							 rctx->honor_end_cmd,
-- 
2.28.0

