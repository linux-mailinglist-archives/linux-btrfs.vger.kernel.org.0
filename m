Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF12B29609D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 16:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900620AbgJVOFR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Oct 2020 10:05:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30177 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900618AbgJVOFQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Oct 2020 10:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603375517; x=1634911517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7082qpHqYYHwpnHxvG+goG/UcG/u1EYCDRwU0/UhBwQ=;
  b=gk45kg9T1QpoJClT4+u4r0PmzX6gP7x8DdQcW6jRVhQO7PiqKo2ZgjNv
   +O10tXFxJFteFXI4arTkJCwgwxqv535RIcZ7qNYgbKotjzfftnTFDXwkB
   iGwBBsdzEwBfdmr7N3vTNpOsfW09fYu7NEyHgA8Mr5Z1DR0wnRWZvWnjM
   qBt7eEa2kz/PiAE3xtFzpCrX0pyVYcQUZGJBmDbynpw79Ir2pW0vHkh60
   E2ZqcjcwAd1GKIq5I2pH1R/XasVYatrGPsulTbAhYAmWxMwUsOUMXqv38
   2VQCmIhIAMzw3Db6q1Im4nh8+XyrhF0uMSOXXv4HA6cwamcGkE8IJreTJ
   Q==;
IronPort-SDR: DCV5OZ1BmUKJLKJnEwcjSxr5k0I1dVLZMEHhjCbvj9AeNIa+DmcCaA0xiNo84t4yrA7sjGsBUh
 iMEwCxeiaXQt8Pk8hIEbmJIJvunqkFpES/v0N5jmkwoGJEr9pIC9il6i1qHcKlGdIbp037IByi
 zlHIhXxxm5w+GtYoBLAqeQfb5byh89awZ7W++gs9lELu0fUPe1K7/hxXrmT7SliGAuFPC9sJPT
 vLfrgjG5mEatyQKBPAoowtiNIuPUnS2FVvf/TowL6EqGuG7etoUMMo/FzNjJTzZ6cAhdRvftkI
 50A=
X-IronPort-AV: E=Sophos;i="5.77,404,1596470400"; 
   d="scan'208";a="155059962"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 22:05:17 +0800
IronPort-SDR: poToSilV229yN7ZYqzylu/6YoTCV9SQ1FpLLRQ18PNnPn4NsFdBD4n+81RlQw+X5ZdAmqkj8cJ
 R6XGz3ecPfg2qlLDRk4D5kHGZoMn7AzG3mNc1iw/nhQD/zpMYgUTSB1prHZmlDFHJU3vNUbgMS
 hbxxKz8sXC5WD9EJJSxdmqyD2aflNBEfxAPxvMHhtdJ+zJQF/WBOqhW6oScKJmkL5nF0aXw2Ak
 GxFyfVKRcOCRYWRS3gDpUPrflJ/r0COTTNYVEqefZqqU0DSJcnjnW+9djT40NcRMLiR79Q5CC/
 wAnj26LJWPGLYxDZO5LDl4Qp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 06:51:39 -0700
IronPort-SDR: LX7Ya1FI8F/+FE5IAzbirpBswZde8NxPWxOEQSpAGFbQP3OWSJ2qftScaj+6Nc8og49JnXTo6J
 YB9SHxbdxHTFjmRgsjyKwn9CsecPn4iOd8tv8aWEvCkwp5bIEcwaa+XjG7AGVBkSi2FXpZT4FM
 q17GCf5/PVi9ZgTRUQqZcAkAjPTBwwIx5tpo8CGfYBmI2ENsDWAyAtEf3LtFhfPxpmUyJNw7FY
 mO1/3BMNcehI87PikaWshSCVeq+BElHx9qsJiiQpTscQWQt+Ep+rMUiKZwo8bc4RW1qAwqqYBz
 8wA=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Oct 2020 07:05:15 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: don't fallback to buffered read if we don't need to
Date:   Thu, 22 Oct 2020 23:05:05 +0900
Message-Id: <0584c1f8bdbef5e56a684919df24481e90ddf334.1603375354.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we switched to the iomap infrastructure in b5ff9f1a96e8f ("btrfs:
switch to iomap for direct IO") we're calling generic_file_buffered_read()
directly and not via generic_file_read_iter() anymore.

If the read could read everything there is no need to bother calling
generic_file_buffered_read(), like it is handled in
generic_file_read_iter().

If we call generic_file_buffered_read() in this case we can hit a
situation where we do an invalid readahead and cause this UBSAN splat:
johannes@redsun60:linux(btrfs-misc-next)$ kasan_symbolize.py < ubsan.txt
rapido1:/home/johannes/src/xfstests-dev# cat results/generic/091.dmesg
run fstests generic/091 at 2020-10-21 10:52:32
================================================================================
UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
shift exponent 64 is too large for 64-bit type 'long unsigned int'
CPU: 0 PID: 656 Comm: fsx Not tainted 5.9.0-rc7+ #821
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77
 dump_stack+0x57/0x70 lib/dump_stack.c:118
 ubsan_epilogue+0x5/0x40 lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0x61/0xe9 lib/ubsan.c:395
 __roundup_pow_of_two ./include/linux/log2.h:57
 get_init_ra_size mm/readahead.c:318
 ondemand_readahead.cold+0x16/0x2c mm/readahead.c:530
 generic_file_buffered_read+0x3ac/0x840 mm/filemap.c:2199
 call_read_iter ./include/linux/fs.h:1876
 new_sync_read+0x102/0x180 fs/read_write.c:415
 vfs_read+0x11c/0x1a0 fs/read_write.c:481
 ksys_read+0x4f/0xc0 fs/read_write.c:615
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9 arch/x86/entry/entry_64.S:118
RIP: 0033:0x7fe87fee992e
Code: 0f 1f 40 00 48 8b 15 a1 96 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
RSP: 002b:00007ffe01605278 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000000000004f000 RCX: 00007fe87fee992e
RDX: 0000000000004000 RSI: 0000000001677000 RDI: 0000000000000003
RBP: 000000000004f000 R08: 0000000000004000 R09: 000000000004f000
R10: 0000000000053000 R11: 0000000000000246 R12: 0000000000004000
R13: 0000000000000000 R14: 000000000007a120 R15: 0000000000000000
================================================================================
BTRFS info (device nullb0): has skinny extents
BTRFS info (device nullb0): ZONED mode enabled, zone size 268435456 B
BTRFS info (device nullb0): enabling ssd optimizations

Fixes: b5ff9f1a96e8f ("btrfs: switch to iomap for direct IO")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v1:
- add check for read beyond EOF (Goldwyn)
- Polish subject a bit
---
 fs/btrfs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6f5ecba74f54..1c97e559aefb 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3612,7 +3612,8 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		inode_lock_shared(inode);
 		ret = btrfs_direct_IO(iocb, to);
 		inode_unlock_shared(inode);
-		if (ret < 0)
+		if (ret < 0 || !iov_iter_count(to) ||
+		    iocb->ki_pos >= i_size_read(file_inode(iocb->ki_filp)))
 			return ret;
 	}
 
-- 
2.26.2

