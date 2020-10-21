Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9F295170
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 19:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443498AbgJURWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 13:22:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49232 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443310AbgJURWy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 13:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603300973; x=1634836973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Veuc1QFmhHuOZ0polzZppRfGpwrsEi0x7Z035IKoEis=;
  b=S8gFwGShrfbYNprOT3YB7eE02ENdpTnDG4/tpdlBJu3Osa2EX6nkBKWk
   Lgfi+sd9pU5BkYWQHL3+rTo8XzoDY7h09N1+e4mjr1WrtmMAced/re/EX
   dA33lsIURuPtRLfn8tBxcLyhCd6mmy4YKbeOkst6ez6sUUBgpI/ky26+Y
   ueBmxd9UNAE9E9g8P92Jyg2Bxmk56Z+oBv1ab21dRBmjIVrPRn7vna3Zl
   RYjxvOqlXyuTDqIcXOmBJrXeMG40seG26pPJENq3HZuHGSuRgPPKlRPOB
   hUPPIlkCTrXbu9T0UO6Tb5V3qn1/+XaJl1bWVeJHWcsJSHG6/M6fJDbh6
   g==;
IronPort-SDR: AZ6/DbNv+I3NyXAV634pGpky3bDgK1gfknFFOIlxiXDkiECj7VA4y/NUghAiOigKbREcwZmqIZ
 JEgJ5xslvcs9LgT+YaRLLJ0sNxAsVxpjQvIr4Ze1vwifSFpkQYx5isQFvnydlJBdtg4MJzIn+U
 SJOnnnAL5eERBZY0sn7tgb+TLhhoNKLtLZPk0cDYQh/vjQOVTBr0of1XexBqONmSb3FqiWvkNP
 ciedTxhle2hqmIBT50zmC3AV9xUavEvhqzZ+jXHPDHsQDaliF8XPohIbU714r/AfDBDKrIKwL/
 ibA=
X-IronPort-AV: E=Sophos;i="5.77,401,1596470400"; 
   d="scan'208";a="150622069"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 01:22:53 +0800
IronPort-SDR: 3nuXsURlcyOx7AFdtCDv6volp2T6CsDKzewb4P8PS8R/X/6gXBqvrT1K5r9b5yP5lwVgOysIUY
 Pm8lm2/c38XLp59v0ts9MgwhwJfM5bUh02z29Nq1BsjTbycLLrYr+biIpr1BOsky+H3qXpYE4L
 SPQR1h0U1VaiCK0yGBqMakWRy27sRJLE40kDvWCb1T8F6YF48eyqaIw40MTXmGdYIXBELpO4QL
 Hy14vUopMrxhK2Smsp/5G+UfDOF1ewref4zE1U7DQCz+zrFYXh4JHE+WHEJ+b8Qooo+eIcYK8w
 QxCmpPiiIyCukocxHbqOeLbN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 10:09:17 -0700
IronPort-SDR: 5iVmx2zIIQPzNHR2Qg9o+bOxZqdNst3fVKX0hhnWZ5YBXRirrh9mK2MA11ICWX/t35XbJE8omn
 +O/bCi9ypYZBTk3x1XD2wk8D+fVMQDvbeaucnE1ViFZQykCX/oGum3RuxHEvzzunyypE0RUdVc
 JOoK938DC6OeA0xzGEDMa2gSH8L3/PfbjNHrlZgGzlTY32q5K0bSloK/iFxM2vpULJJXBrySnA
 0oieD6GLz+IqFlLSuAj/n4tRWCMXkCxWQSaZLEI9x3PjnrO+LBhIiIaT/DrLEzc5V9+xSkPuAr
 VWk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Oct 2020 10:22:52 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: skip call to generic_file_buffered_read if we don't need to
Date:   Thu, 22 Oct 2020 02:22:49 +0900
Message-Id: <e9b1d098cd97cf275009a80d0ce087ba39267dcf.1603300854.git.johannes.thumshirn@wdc.com>
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
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6f5ecba74f54..8e6def2c463d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3612,7 +3612,7 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		inode_lock_shared(inode);
 		ret = btrfs_direct_IO(iocb, to);
 		inode_unlock_shared(inode);
-		if (ret < 0)
+		if (ret < 0 || (ret > 0 && iov_iter_count(to) == 0))
 			return ret;
 	}
 
-- 
2.26.2

