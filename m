Return-Path: <linux-btrfs+bounces-6032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8380891B5D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 06:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCE9284615
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 04:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F85325624;
	Fri, 28 Jun 2024 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QzXfDB2d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B62AF0D
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719550387; cv=none; b=uNchmd7yLILGNZHL7jO5T+MsTWg33kif5wIYzZDQmIwUo9plGLElRRuRgcognBPUovkj6nTh+41lEOGm5J7xLG5wccMOOMRgJ6ldUA2a4YOLzRQ5LXIP+SisbiCVU+42fnPj0pbS9xDci6JgZ548c73IVprM5BhoVtVl4JzwFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719550387; c=relaxed/simple;
	bh=IUO3uptGVsk/h7Cn2WpWA54jbVcg/GlkyqYyKlYP0jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdiiQ6KdiUxsTNrb24/E2f6MiID8XvKLWKIeADfmwSJShmvOw3iRUqXtfsMbKZ1CWOf6h3Bmr376oEBx/gDUA7umzOutYfIF9KB06Marpqc1Z+D6MTtL57ZF6RkSkhO6XanHyMQD3LZ9TsuuFyP2l/TItFkBNPDxpAOR7wa2afU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QzXfDB2d; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719550385; x=1751086385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IUO3uptGVsk/h7Cn2WpWA54jbVcg/GlkyqYyKlYP0jc=;
  b=QzXfDB2d5eu/bSEUV829RQjeCh6uBdyxYkl8AE2yF4OBXNg2G06itSHy
   GsLIkmNjbKslV8yeM6zrJUp1HDopXs9dT6ij4xR9if/sn0Oc/mq0YJt8c
   vtg/DtR8aMp5my9NDbWtzlKQmdqCbrbxe7v4yOBw9/KjCA9g3rI0Pl+4f
   +/AQ7jfa5sAU293mnGImFLx+7rSOtZr1yrRA0pr80GxrQHRbcB4KMe4JW
   bKxSgdpPijXJRgDazgIE3zqEb2usxPoMOg66g+HNGsHZTSxtZQXXxfUle
   oc9uCPVyOJ9OlMr9rx//FwZgVy3TJJ/qJmY7zih6OaAOZjqRcyw9VM6zq
   Q==;
X-CSE-ConnectionGUID: EeK+bzChT16yQIgMZYIXzw==
X-CSE-MsgGUID: WVzEbAZmRv+lLdaqFFI0jw==
X-IronPort-AV: E=Sophos;i="6.09,168,1716220800"; 
   d="scan'208";a="20224159"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2024 12:48:42 +0800
IronPort-SDR: 667e32e1_A6CvtN+4bGDBem3yeaMTKCAN/6HAjNErXZDzYyHIn6a5vra
 WFnpBzH6ClbDR/cbd7R2vUqzldTM/WNs1S2rlrA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jun 2024 20:49:53 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.89])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2024 21:48:42 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: [PATCH] btrfs: avoid possible parallel list adding
Date: Fri, 28 Jun 2024 13:32:24 +0900
Message-ID: <58e8574ccd70645c613e6bc7d328e34c2f52421a.1719549099.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a potential parallel list adding for retrying in
btrfs_reclaim_bgs_work and adding to the unused list. Since the block
group is removed from the reclaim list and it is on a relocation work,
it can be added into the unused list in parallel. When that happens,
adding it to the reclaim list will corrupt the list head and trigger
list corruption like below.

Fix it by taking fs_info->unused_bgs_lock.

[27177.504101][T2585409] BTRFS error (device nullb1): error relocating ch= unk 2415919104
[27177.514722][T2585409] list_del corruption. next->prev should be ff1100= 0344b119c0, but was ff11000377e87c70. (next=3Dff110002390cd9c0)
[27177.529789][T2585409] ------------[ cut here ]------------
[27177.537690][T2585409] kernel BUG at lib/list_debug.c:65!
[27177.545548][T2585409] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[27177.555466][T2585409] CPU: 9 PID: 2585409 Comm: kworker/u128:2 Tainted: G        W          6.10.0-rc5-kts #1
[27177.568502][T2585409] Hardware name: Supermicro SYS-520P-WTR/X12SPW-TF, BIOS 1.2 02/14/2022
[27177.579784][T2585409] Workqueue: events_unbound btrfs_reclaim_bgs_work[btrfs]
[27177.589946][T2585409] RIP: 0010:__list_del_entry_valid_or_report.cold+0x70/0x72
[27177.600088][T2585409] Code: fa ff 0f 0b 4c 89 e2 48 89 de 48 c7 c7 c0
8c 3b 93 e8 ab 8e fa ff 0f 0b 4c 89 e1 48 89 de 48 c7 c7 00 8e 3b 93 e8
97 8e fa ff <0f> 0b 48 63 d1 4c 89 f6 48 c7 c7 e0 56 67 94 89 4c 24 04
e8 ff f2
[27177.624173][T2585409] RSP: 0018:ff11000377e87a70 EFLAGS: 00010286
[27177.633052][T2585409] RAX: 000000000000006d RBX: ff11000344b119c0 RCX:0000000000000000
[27177.644059][T2585409] RDX: 000000000000006d RSI: 0000000000000008 RDI:ffe21c006efd0f40
[27177.655030][T2585409] RBP: ff110002e0509f78 R08: 0000000000000001 R09:ffe21c006efd0f08
[27177.665992][T2585409] R10: ff11000377e87847 R11: 0000000000000000 R12:ff110002390cd9c0
[27177.676964][T2585409] R13: ff11000344b119c0 R14: ff110002e0508000 R15:dffffc0000000000
[27177.687938][T2585409] FS:  0000000000000000(0000) GS:ff11000fec880000(0000) knlGS:0000000000000000
[27177.700006][T2585409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[27177.709431][T2585409] CR2: 00007f06bc7b1978 CR3: 0000001021e86005 CR4:0000000000771ef0
[27177.720402][T2585409] DR0: 0000000000000000 DR1: 0000000000000000 DR2:0000000000000000
[27177.731337][T2585409] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:0000000000000400
[27177.742252][T2585409] PKRU: 55555554
[27177.748207][T2585409] Call Trace:
[27177.753850][T2585409]  <TASK>
[27177.759103][T2585409]  ? __die_body.cold+0x19/0x27
[27177.766405][T2585409]  ? die+0x2e/0x50
[27177.772498][T2585409]  ? do_trap+0x1ea/0x2d0
[27177.779139][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0x72
[27177.788518][T2585409]  ? do_error_trap+0xa3/0x160
[27177.795649][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0x72
[27177.805045][T2585409]  ? handle_invalid_op+0x2c/0x40
[27177.812022][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0x72
[27177.820947][T2585409]  ? exc_invalid_op+0x2d/0x40
[27177.827608][T2585409]  ? asm_exc_invalid_op+0x1a/0x20
[27177.834637][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0x72
[27177.843519][T2585409]  btrfs_delete_unused_bgs+0x3d9/0x14c0 [btrfs]

There is a similar retry_list code in btrfs_delete_unused_bgs(), but it is
safe, AFAIC. Since the block group was in the unused list, the used bytes
should be 0 when it was added to the unused list. Then, it checks
block_group->{used,resereved,pinned} are still 0 under the
block_group->lock. So, they should be still eligible for the unused list,
not the reclaim list.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Suggested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Fixes: 4eb4e85c4f81 ("btrfs: retry block group reclaim without infinite loop")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7cde40fe6a50..498442d0c216 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1945,8 +1945,17 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 next:
 		if (ret && !READ_ONCE(space_info->periodic_reclaim)) {
 			/* Refcount held by the reclaim_bgs list after splice. */
-			btrfs_get_block_group(bg);
-			list_add_tail(&bg->bg_list, &retry_list);
+			spin_lock(&fs_info->unused_bgs_lock);
+			/*
+			 * This block group might be added to the unused list
+			 * during the above process. Move it back to the
+			 * reclaim list otherwise.
+			 */
+			if (list_empty(&bg->bg_list)) {
+				btrfs_get_block_group(bg);
+				list_add_tail(&bg->bg_list, &retry_list);
+			}
+			spin_unlock(&fs_info->unused_bgs_lock);
 		}
 		btrfs_put_block_group(bg);
 
-- 
2.45.2


