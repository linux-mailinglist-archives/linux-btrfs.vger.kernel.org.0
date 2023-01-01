Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3419D65A881
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Jan 2023 02:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjAABCn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 20:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjAABCm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 20:02:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DA45FF6
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 17:02:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67FDF22422;
        Sun,  1 Jan 2023 01:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672534959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UoMwAQsFfopfEs2ts1m2LoCUnPc+kYlbRAQdcgSNG+g=;
        b=LZ9c/y/i/E/tTvsJPpMMex9QhQP0Ayj6osUqExs2IY8fZKBvs162RwrAmdV144UafhpBiC
        uHUa/yO/Tmjo+oiUezwHRJC3z0apQZiR7kNY81t1PIK30+GOz8vZAjgG4lYq739a0EOLSm
        /454nalSYgOx9N/Pnd5w1LV79HbM7Rg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8966513357;
        Sun,  1 Jan 2023 01:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ceH6FK7bsGPWCwAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 01 Jan 2023 01:02:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?=E5=B0=8F=E5=A4=AA?= <nospam@kota.moe>
Subject: [PATCH] btrfs: don't trigger BUG_ON() when repair happens with dev-replace
Date:   Sun,  1 Jan 2023 09:02:21 +0800
Message-Id: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report that a BUG_ON() in btrfs_repair_io_failure()
(originally repair_io_failure() in v6.0 kernel) got triggered when
replacing a unreliable disk:

 BTRFS warning (device sda1): csum failed root 257 ino 2397453 off 39624704 csum 0xb0d18c75 expected csum 0x4dae9c5e mirror 3
 kernel BUG at fs/btrfs/extent_io.c:2380!
 invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 9 PID: 3614331 Comm: kworker/u257:2 Tainted: G           OE      6.0.0-5-amd64 #1  Debian 6.0.10-2
 Hardware name: Micro-Star International Co., Ltd. MS-7C60/TRX40 PRO WIFI (MS-7C60), BIOS 2.70 07/01/2021
 Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
 RIP: 0010:repair_io_failure+0x24a/0x260 [btrfs]
 Call Trace:
  <TASK>
  clean_io_failure+0x14d/0x180 [btrfs]
  end_bio_extent_readpage+0x412/0x6e0 [btrfs]
  ? __switch_to+0x106/0x420
  process_one_work+0x1c7/0x380
  worker_thread+0x4d/0x380
  ? rescuer_thread+0x3a0/0x3a0
  kthread+0xe9/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x22/0x30
  </TASK>

[CAUSE]

Before the BUG_ON(), we got some read errors from the replace target
first, note the mirror number (3, which is beyond RAID1 duplication,
thus it's read from the replace target device).

Then at the BUG_ON() location, we are trying to writeback the repaired
sectors back the failed device.

The check looks like this:

		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
				      &map_length, &bioc, mirror_num);
		if (ret)
			goto out_counter_dec;
		BUG_ON(mirror_num != bioc->mirror_num);

But inside btrfs_map_block(), we can modify bioc->mirror_num especially
for dev-replace:

	if (dev_replace_is_ongoing && mirror_num == map->num_stripes + 1 &&
	    !need_full_stripe(op) && dev_replace->tgtdev != NULL) {
		ret = get_extra_mirror_from_replace(fs_info, logical, *length,
						    dev_replace->srcdev->devid,
						    &mirror_num,
					    &physical_to_patch_in_first_stripe);
		patch_the_first_stripe_for_dev_replace = 1;
	}

Thus if we're repairing the replace target device, we're going to
triggere that BUG_ON().

But in reality, the read failure from the replace target device may be that,
our replace haven't reach the range we're reading, thus we're reading
garbage, but with replace running, the range would be properly filled
later.

Thus in that case, we don't need to do anything but let the replace
routine to handle it.

[FIX]
Instead of a BUG_ON(), just skip the repair if we're repairing the
device replace target device.

Reported-by: 小太 <nospam@kota.moe>
Link: https://lore.kernel.org/linux-btrfs/CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index b8fb7ef6b520..444e20b15e26 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -329,7 +329,16 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 				      &map_length, &bioc, mirror_num);
 		if (ret)
 			goto out_counter_dec;
-		BUG_ON(mirror_num != bioc->mirror_num);
+		/*
+		 * This happens when dev-replace is also happening, and
+		 * the mirror_num indicates the dev-replace target.
+		 *
+		 * In this case, we don't need to do anything, as the read
+		 * error just means the replace progress hasn't reached our
+		 * read range, and later replace routine would handle it well.
+		 */
+		if (mirror_num != bioc->mirror_num)
+			goto out_counter_dec;
 	}
 
 	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
-- 
2.39.0

