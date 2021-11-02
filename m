Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C14429B8
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 09:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhKBIpg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 04:45:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57144 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBIpg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 04:45:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E33DA212BE;
        Tue,  2 Nov 2021 08:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635842580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JJeJabEPQa21+GHcO8q6DRjcS4NMh0gzzfKq3xcRc6A=;
        b=IqAHMyWpvqoGsVGYFoQUKQxTuz6xFfyViz4koK7pK2BDjn0cEM5xmhYjw7va1b7oYNmFvg
        StwetytwKjUSYmlLPLMC0AgQ0AeeNx9y5Dqpn+kWcJZyz2x7ph0k2Mmikgp/8XqCm+xI20
        t/gyakd+zk+4sGGO+GWJdWTt8LFOI6o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 163D113B16;
        Tue,  2 Nov 2021 08:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NGXvNBP6gGGQawAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 02 Nov 2021 08:42:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs: clear free space cache when nospace_cache mount option is specified
Date:   Tue,  2 Nov 2021 16:42:42 +0800
Message-Id: <20211102084242.30581-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With latest btrfs-progs v5.15.x testing branch, fstests/btrfs/215 will
fail like the following:

  MKFS_OPTIONS  -- /dev/mapper/test-scratch1
  MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

  btrfs/215 0s ... [failed, exit status 1]- output mismatch (see ~/xfstests-dev/results//btrfs/215.out.bad)
      --- tests/btrfs/215.out	2020-11-03 15:05:07.920000001 +0800
      +++ ~/xfstests-dev/results//btrfs/215.out.bad	2021-11-02 16:31:17.626666667 +0800
      @@ -1,2 +1,4 @@
       QA output created by 215
      -Silence is golden
      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
      +mount -o nospace_cache /dev/mapper/test-scratch1 /mnt/scratch failed
      +(see ~/xfstests-dev/results//btrfs/215.full for details)
      ...
      (Run 'diff -u ~/xfstests-dev/tests/btrfs/215.out ~/xfstests-dev/results//btrfs/215.out.bad'  to see the entire diff)
  Ran: btrfs/215

[CAUSE]
Currently btrfs doesn't allow mounting with nospace_cache when there is
already a v2 cache.

The logic looks like this, in btrfs_parse_options():

		case Opt_no_space_cache:
			if (btrfs_test_opt(info, FREE_SPACE_TREE)) {
				btrfs_set_opt(info->mount_opt, CLEAR_CACHE);
				btrfs_clear_and_info(info, FREE_SPACE_TREE,
				"disabling and clearing free space tree");
			}
			break;

Then at the end of the same function:

	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
	    !btrfs_test_opt(info, CLEAR_CACHE)) {
		btrfs_err(info, "cannot disable free space tree");
		ret = -EINVAL;
	}

Thus causing above mount failure.

[FIX]
I'm not sure why we don't allow nospace_cache with v2 cache, my
assumption is we don't have generation check for v2 cache, thus if we
make v2 space cache get out of sync with the on-disk data, it can
corrupt the fs.

That needs to be properly addressed, but for now, to allow nospace_cache
with v2 cache, we can simply force to clear v2 cache when nospace_cache
mount option is specified.

Since we're here, also remove a unnecessary new line the v2 cache check
at the end btrfs_parse_options().

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 537d90bf5d84..59e4a756cea6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -887,8 +887,14 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 					     "disabling disk space caching");
 			}
 			if (btrfs_test_opt(info, FREE_SPACE_TREE)) {
+				/*
+				 * For v2 cache with nospace_cache mount option,
+				 * v2 cache can get out of sync if not cleared.
+				 * Thus here we set to clear v2 cache.
+				 */
+				btrfs_set_opt(info->mount_opt, CLEAR_CACHE);
 				btrfs_clear_and_info(info, FREE_SPACE_TREE,
-					     "disabling free space tree");
+				"disabling and clearing free space tree");
 			}
 			break;
 		case Opt_inode_cache:
@@ -1036,7 +1042,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	    !btrfs_test_opt(info, CLEAR_CACHE)) {
 		btrfs_err(info, "cannot disable free space tree");
 		ret = -EINVAL;
-
 	}
 	if (!ret)
 		ret = btrfs_check_mountopts_zoned(info);
-- 
2.33.1

