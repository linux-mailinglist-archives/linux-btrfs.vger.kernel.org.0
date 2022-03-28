Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C44E96A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 14:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbiC1Mdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 08:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiC1Mdt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 08:33:49 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAC64D621
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648470727; x=1680006727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qC+1GJogQ3SfMKhncuR6Q2BTV29fAzh62/b73Er/Wzw=;
  b=URIZeALo/Lh3KaBxUs2IpuLgJE/rfxgWfcq+fmRVAVJhMTCXzH/JeCbg
   qkKIX3eLt6fL1NCAu4wXkQuqdh3ZkwyqRGMmISRnjbQwbVTagrPZ7T1UY
   KREmelswvjYYAfGpqrliO51Y+jLqoGmSQew9rUG00AlIpD8NZ6eemJerY
   Q1jR0M9s80Nd5kj1O8cfgm6jaM8J/dNwq9vx+s/m8x/8zfQq3otGX172C
   yHo18XnUz7ERltyG0ZMQ2iONr42CLnEkK26ecvQmhrBZCVvcEJD9rG8AB
   5Ym+5rOmAb6I4rAD4sPlan/5reCHUG5XEYVVvWa9Dgy/W2RWUiibEGA7w
   w==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643644800"; 
   d="scan'208";a="300589752"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 20:32:07 +0800
IronPort-SDR: giek9tqfrCDeoP1pFFKKjPJtIQYQ6cGy27UL16OS3ZVNGqe4sIEi8/KjgO3bZHNwAcBVngQqE0
 cDYWKFcWPIvis4PipEHVVvmrfgHmHA5GVEVFRh/KbCgSiDvLC5plgwgEVvOkw9iOhdpLC9hWcu
 R7WlqKrNMwQmjQjCTCON9RaadzQW5QpldeVTaLbIWWAJbMDUoHEAA4z+riNFS6xuxnEzInR6aH
 lloGBPsLP8P18So3LM5rD/gQrlB8MixW3lCpvTXrN/ppBxxM7b8VsOOUbizWD9UBQbDh9ryqRi
 tz1tqAWOliveFHDK/cCmA3JE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 05:03:53 -0700
IronPort-SDR: KdiJQFSVoYKQvHHCGu8jgEXFQ4u3+pP7+M8UTQhwoR2gT1THY4fjCkw9xwJ9dH91xnmUS4WtNk
 hKxAy/dL0YDH/CH65Sf3C/66GUlWQtX40gyhujApBdrHsEcKMXHlCA3ZFFR3gtVF1sYqTFv3w1
 LbbpcXtcMAnRVilG67raQ1Ke4D701QpgDWNYhvAzIq2buKh5mgB6wrxtsucAXKz03fKB1ToRMB
 3SFUmuSZcPmHCcaaCa6z5wWIb3TM7L9fQ8KUkpPX1DQ3ni82U90S+K9JY+tw2cGjGTpaoTJKv2
 4Ts=
WDCIronportException: Internal
Received: from b6wzvt2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.101])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Mar 2022 05:32:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: fix outstanding extents calculation
Date:   Mon, 28 Mar 2022 21:32:05 +0900
Message-Id: <06cc127b5d3c535917e90fbdce0534742dcde478.1648470587.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running generic/406 causes the following WARNING in btrfs_destroy_inode()
which tells there is outstanding extents left.

In btrfs_get_blocks_direct_write(), we reserve a temporary outstanding
extents with btrfs_delalloc_reserve_metadata() (or indirectly from
btrfs_delalloc_reserve_space(()). We then release the outstanding extents
with btrfs_delalloc_release_extents(). However, the "len" can be modified
in the CoW case, which releasing fewer outstanding extents than expected.

Fix it by calling btrfs_delalloc_release_extents() for the original length.

    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 757 at fs/btrfs/inode.c:8848 btrfs_destroy_inode+0x1e6/0x210 [btrfs]
    Modules linked in: btrfs blake2b_generic xor lzo_compress
    lzo_decompress raid6_pq zstd zstd_decompress zstd_compress xxhash zram
    zsmalloc
    CPU: 0 PID: 757 Comm: umount Not tainted 5.17.0-rc8+ #101
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS d55cb5a 04/01/2014
    RIP: 0010:btrfs_destroy_inode+0x1e6/0x210 [btrfs]
    Code: fe ff ff 0f 0b e9 d6 fe ff ff 0f 0b 48 83 bb e0 01 00 00 00 0f 84
    65 fe ff ff 0f 0b 48 83 bb 78 ff ff ff 00 0f 84 63 fe ff ff <0f> 0b 48
    83 bb 70 ff ff ff 00 0f 84 61 fe ff ff 0f 0b e9 5a fe ff
    RSP: 0018:ffffc9000327bda8 EFLAGS: 00010206
    RAX: 0000000000000000 RBX: ffff888100548b78 RCX: 0000000000000000
    RDX: 0000000000026900 RSI: 0000000000000000 RDI: ffff888100548b78
    RBP: ffff888100548940 R08: 0000000000000000 R09: ffff88810b48aba8
    R10: 0000000000000001 R11: ffff8881004eb240 R12: ffff88810b48a800
    R13: ffff88810b48ec08 R14: ffff88810b48ed00 R15: ffff888100490c68
    FS:  00007f8549ea0b80(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007f854a09e733 CR3: 000000010a2e9003 CR4: 0000000000370eb0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
     <TASK>
     destroy_inode+0x33/0x70
     dispose_list+0x43/0x60
     evict_inodes+0x161/0x1b0
     generic_shutdown_super+0x2d/0x110
     kill_anon_super+0xf/0x20
     btrfs_kill_super+0xd/0x20 [btrfs]
     deactivate_locked_super+0x27/0x90
     cleanup_mnt+0x12c/0x180
     task_work_run+0x54/0x80
     exit_to_user_mode_prepare+0x152/0x160
     syscall_exit_to_user_mode+0x12/0x30
     do_syscall_64+0x42/0x80
     entry_SYSCALL_64_after_hwframe+0x44/0xae
    RIP: 0033:0x7f854a000fb7

Fixes: f0bfa76a11e9 ("btrfs: fix ENOSPC failure when attempting direct IO write into NOCOW range")
CC: stable@vger.kernel.org # 5.17
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c7b15634fe70..5c0c54057921 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7409,6 +7409,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	u64 block_start, orig_start, orig_block_len, ram_bytes;
 	bool can_nocow = false;
 	bool space_reserved = false;
+	u64 prev_len;
 	int ret = 0;
 
 	/*
@@ -7436,6 +7437,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			can_nocow = true;
 	}
 
+	prev_len = len;
 	if (can_nocow) {
 		struct extent_map *em2;
 
@@ -7465,8 +7467,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			goto out;
 		}
 	} else {
-		const u64 prev_len = len;
-
 		/* Our caller expects us to free the input extent map. */
 		free_extent_map(em);
 		*map = NULL;
@@ -7497,7 +7497,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	 * We have created our ordered extent, so we can now release our reservation
 	 * for an outstanding extent.
 	 */
-	btrfs_delalloc_release_extents(BTRFS_I(inode), len);
+	btrfs_delalloc_release_extents(BTRFS_I(inode), prev_len);
 
 	/*
 	 * Need to update the i_size under the extent lock so buffered
-- 
2.35.1

