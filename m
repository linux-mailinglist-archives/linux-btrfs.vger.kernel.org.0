Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6099A3828DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 11:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhEQJ4k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 05:56:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:57714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhEQJ4g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 05:56:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621245319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=36P8Td/oYD9l6NsxV+1GwLkTTSY5RuG1XIEtmclYXXc=;
        b=LPcUdJsOo3AjzmS1xIWaLfK3jw+Ip5pHKZMRgpZmCyactDMJWmCmSLB80P81Sc1CrRNBNs
        4AOZ8CP5IUmMaHdumHWsxkhVJKFXcW+6OkAUIcWo2eWuwu6q1y4LcvZaveWs+6/RkO325Q
        yMQ/X+KJnZyJWbBuT3dtC89DpHEBX4w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C26A8AF70
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 09:55:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: mkfs: follow sectorsize for mixed mode
Date:   Mon, 17 May 2021 17:55:16 +0800
Message-Id: <20210517095516.129287-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running fstests with 4K sectorsize and 64K page size (aka subpage
support), the following tests failed:

  $ sudo ./check generic/416 generic/619
  FSTYP         -- btrfs
  PLATFORM      -- Linux/aarch64 rockpi4 5.12.0-rc8-custom+ #9 SMP Tue Apr 27 12:49:52 CST 2021
  MKFS_OPTIONS  -- -s 4k /dev/mapper/arm_nvme-scratch1
  MOUNT_OPTIONS -- /dev/mapper/arm_nvme-scratch1 /mnt/scratch

  generic/416     [failed, exit status 1]- output mismatch (see ~/xfstests-dev/results//generic/416.out.bad)
     QA output created by 416
    -wrote 16777216/16777216 bytes at offset 0
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/arm_nvme-scratch1, missing codepage or helper program, or other error.
    +mount failed
    +(see ~/xfstests-dev/results//generic/416.full for details)
    ...
    (Run 'diff -u ~/xfstests-dev/tests/generic/416.out ~/xfstests-dev/results//generic/416.out.bad'  to see the entire diff)
  generic/619     [failed, exit status 1]- output mismatch (see ~/xfstests-dev/results//generic/619.out.bad)
     QA output created by 619
    -Silence is golden
    +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/arm_nvme-scratch1, missing codepage or helper program, or other error.
    +mount failed
    +(see ~/xfstests-dev/results//generic/619.full for details)
    ...
    (Run 'diff -u ~/xfstests-dev/tests/generic/619.out ~/xfstests-dev/results//generic/619.out.bad'  to see the entire diff)
  Ran: generic/416 generic/619
  Failures: generic/416 generic/619
  Failed 2 of 2 tests

[CAUSE]
Those two tests call _scratch_mkfs_sized to create a small fs, all of them
are smaller than the 256M.

Since the fs is small, fstests choose to pass -M to make a mixed btrfs.
(Let's just ignore whether we should pass -M here).

Then on 64K page size system, "mkfs.btrfs -s 4K -M -b 128M $dev" will fail
with the following error message:

  btrfs-progs v5.11
  See http://btrfs.wiki.kernel.org for more information.

  ERROR: illegal nodesize 65536 (not equal to 4096 for mixed block group)

This is caused by the nodesize selection, which always try to choose the
larger value between pagesize and sectorsize.

This hardcoded PAGESIZE usage in mkfs.btrfs makes us to choose 64K
nodesize even we specified to use 4K sectorsize.

[FIX]
Just use sectorsize as nodesize when -M is specified.

With this fix, above two tests now pass for btrfs subpage case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index c910369cbf94..81241054f6c8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1177,8 +1177,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			data_profile = tmp;
 		}
 	} else {
-		u32 best_nodesize = max_t(u32, sysconf(_SC_PAGESIZE), sectorsize);
-
 		if (metadata_profile_opt || data_profile_opt) {
 			if (metadata_profile != data_profile) {
 				error(
@@ -1188,7 +1186,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 
 		if (!nodesize_forced)
-			nodesize = best_nodesize;
+			nodesize = sectorsize;
 	}
 
 	/*
-- 
2.31.1

