Return-Path: <linux-btrfs+bounces-17165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29BB9C590
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 00:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CE53B6A5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 22:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E18291864;
	Wed, 24 Sep 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="QfoCnwrH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="INjK7KHl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B226B971
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752679; cv=none; b=ElinSO/2RIeCjhzrY5gY/pLzvYt8Qm1AYl/0PxkyYZOKkHKM8zvMjzmITJ4B3sL2ZvBPRyycaqFbKvvdtqnmxESJn9+FQ+y9mGypVTLH4F+vzmnKpDCeak5pkr/XmYxgxtK+bnUs9rDioSjSXfa1MGYgy80pP/sJf5plKi7Nbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752679; c=relaxed/simple;
	bh=bF/yG6ReFuL21xklqyBjomhR9qwuUivXti/hkRcVxNk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qPVrYyRnVmc5JN37CUMMeh+Tuyy8Kj1rghdt/7YRRZOhVmCCnXk7kDXQ1ErwC+F+GpZ8jzT0KecvaA4kSp4B5Fw9zs/2ftkzjxAPepG598BhOUAlsZjw5hlPIoP5EV3lA4maEPaIt4WhBUaxAjPSgAXQBzeFMHBH8HSztgUAli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=QfoCnwrH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=INjK7KHl; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 14A937A01A5;
	Wed, 24 Sep 2025 18:24:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 24 Sep 2025 18:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1758752675; x=1758839075; bh=CnKGaACX02DaO5HwPsEMI
	N5V3u6yfKzEMBJc/Sco1H0=; b=QfoCnwrHVfgRPwWq8qQguu/ued8LyLFkCWY3f
	Bx6OjqEyIS5Irr4TLFFu8JtyHrqpKa6uZP6847IJ/Cv64UuQLnoVAepQv1AUCXWB
	r3eJWXcijPyVmHKEVwY52QYTSmOOB2M4FUrScIOU5iYv1dvgUd4wPJPXmjCzF5nU
	m7psbhgDmJaz9YBtpqiiW+D0TBvEGj6e/nk/MrnftBm1mAvCBiU9BdxwiWXtbwx/
	tvK6w/DdsEtSTc2ElwfiuJEjxk/1XThGIwnilFdQYWsWlf/amc0bSu0Wnr4unUvE
	rjC/chA0WjSV9/3aPvWgid0E5WfOfGZrLlYhYMZ1NwzgVUDaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758752675; x=1758839075; bh=CnKGaACX02DaO5HwPsEMIN5V3u6yfKzEMBJ
	c/Sco1H0=; b=INjK7KHlgcqzVUZUK0TQZe5RzEvkcssnxRsfUitSEtKly4NKgUE
	h67VMQ5QqbZ2gNwul1wngVJzdytOuK8GE9sVPS0eoMoJXgryckG71Yqozw0eok96
	JG972LXO/epapD4dk/n4ML13NSobcFz0lgAb8n7B1/cWA2XEDla2u5Ol+kuxATLq
	AQnY/IRZnfFehA46epMP8n8f0JSdU41J1n6+iB1HLe+q0dT5tBJmYJ3nxKL56R/s
	C+byABXvR3+ivUo72pvDIrgH/azy9YccOZnFQcjnQ98f4jFzU1A3OpAw4RdKqhld
	nBVZeOztGfbxMRVvDUFGL0QSTAdMGq3hs9Q==
X-ME-Sender: <xms:o2_UaM8hDee8fl_AT0mB7oK7hExAbJg1pnIcjS70xU2deA9-HPmmaA>
    <xme:o2_UaKv-XrIdih2IzUwHYGcyMIOx1pT75PJHqplBtLu-Lb0MBbJZIWnaEoQjRV54J
    eMNRJx1rWDWBZ2eqTbNWXx45rf8XhwnRSdB8Yo1RQLVBXW5eNFnGg>
X-ME-Received: <xmr:o2_UaPoGLY9dOdnJtiCVhSAfackLHatCL1BTV0D5aweROMa7ILwKpy1kA3EIgPn7IOc3rVPNAq3GbtyLKjnz5Fvpiek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekudduteefke
    fffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:o2_UaHndwszquBFuSlpjH1VQU-lfPMuSQFCt4prlDLpjmwW7UcpBQA>
    <xmx:o2_UaDyARUUf7Nn44u9GMrWZngRD4wGuv-1Efvy-yHWBHuMtrhJjig>
    <xmx:o2_UaPlstczPDjyG26kudKdrPbckhFIevsVzR4kjnLRTx6TMF_Llvw>
    <xmx:o2_UaMfOR2gIOgp-toWLXyY9OzQlrr4nayXhEqt-TaH9p9CM7-DCOA>
    <xmx:o2_UaIiWrIbFdhe8ZJh6iQdB2LoS_46osZYWZWJjy0QiUnoczSLt3K4W>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 18:24:35 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: don't ignore ENOMEM in btrfs_add_chunk_map()
Date: Wed, 24 Sep 2025 15:24:25 -0700
Message-ID: <0d537ef90213e54835f7aaa090498787db27b33a.1758752652.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_set_extent_bit() can return ENOMEM, which
chunk_map_device_(set|clear)_bits() was ignoring, so
btrfs_add_chunk_map() was silently failing in those cases. This led to
double allocating dev extents, ultimately resulting in an EEXIST in
add_dev_extent_item(): (ignore the btrfs_force_chunk_alloc_store thing,
we are using a DEBUG feature that isn't widely used here)

  ------------[ cut here ]------------
  BTRFS: Transaction aborted (error -17)
  WARNING: CPU: 5 PID: 3586339 at fs/btrfs/block-group.c:2764 btrfs_create_pending_block_groups+0x5fc/0x620
  RIP: 0010:btrfs_create_pending_block_groups+0x5fc/0x620
  Code: 9c fd ff ff 48 c7 c7 e8 69 64 82 44 89 ee e8 4b 87 e6 ff 0f 0b e9 99 fe ff ff 48 c7 c7 e8 69 64 82 48 8b 34 24 e8 34 87 e6 ff <0f> 0b eb a0 48 c7 c7 e8 69 64 82 44 89 e6 e8 21 87 e6 ff 0f 0b e9
  RSP: 0018:ffffc90060693d38 EFLAGS: 00010286
  RAX: 0000000000000026 RBX: ffff8882be92fed8 RCX: 0000000000000027
  RDX: ffff88bf42f6e040 RSI: ffff88bf42f60c48 RDI: ffff88bf42f60c48
  RBP: ffff888282585d18 R08: 0000000000000000 R09: 0000000000000000
  R10: 4000000000000000 R11: 000000000000691d R12: ffff88c0471a3300
  R13: 0000001dc6500000 R14: ffff8882829d9000 R15: ffff8882be92ff40
  FS:  00007f7ccbc2c740(0000) GS:ffff88bf42f40000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000004e421c8 CR3: 0000000cd6384001 CR4: 0000000000770ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __warn+0xa0/0x130
   ? btrfs_create_pending_block_groups+0x5fc/0x620
   ? report_bug+0xf2/0x150
   ? handle_bug+0x3d/0x70
   ? exc_invalid_op+0x16/0x40
   ? asm_exc_invalid_op+0x16/0x20
   ? btrfs_create_pending_block_groups+0x5fc/0x620
   ? btrfs_create_pending_block_groups+0x5fc/0x620
   __btrfs_end_transaction.llvm.3999538623537568469+0x3d/0x1c0
   btrfs_force_chunk_alloc_store+0xaf/0x100
   ? sysfs_kf_read+0x90/0x90
   kernfs_fop_write_iter.llvm.10031329899921036925+0xd0/0x180
   __x64_sys_write+0x279/0x5a0
   do_syscall_64+0x63/0x130
   ? exc_page_fault+0x63/0x130
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f7ccb4ff28f
  Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 a9 89 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 fc 89 f8 ff 48
  RSP: 002b:00007ffda7138f20 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 0000000009c13140 RCX: 00007f7ccb4ff28f
  RDX: 0000000000000001 RSI: 0000000004e401b0 RDI: 00000000000000c8
  RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000008000 R11: 0000000000000293 R12: 0000000000000000
  R13: 0000000000408820 R14: 0000000000407f00 R15: 00007ffda7138fc0
   </TASK>
  ---[ end trace 0000000000000000 ]---
  BTRFS: error (device nvme0n1p2 state A) in btrfs_create_pending_block_groups:2764: errno=-17 Object already exists
  BTRFS warning (device nvme0n1p2 state EA): Skipping commit of aborted transaction.
  BTRFS: error (device nvme0n1p2 state EA) in cleanup_transaction:2018: errno=-17 Object already exists

This was pretty confusing to debug and I think it would be helpful to
get the proper ENOMEM error sent up to the appropriate transaction when
it happens.

Note:
Most callsites of btrfs_set_extent_bit() are not checked, however, which
does give me pause. Either we have a lot more inaccuracies like this out
there, or I have misanalyzed this scenario. I was able to reproduce the
above calltrace by injecting enomem errors in to the set_extent_bits
path here, for what it's worth.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/volumes.c | 47 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2bec544d8ba3..eda5b6b907d9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5434,28 +5434,42 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 	}
 }
 
-static void chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsigned int bits)
+static int chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsigned int bits)
 {
+	int ret;
+
 	for (int i = 0; i < map->num_stripes; i++) {
 		struct btrfs_io_stripe *stripe = &map->stripes[i];
 		struct btrfs_device *device = stripe->dev;
 
-		btrfs_set_extent_bit(&device->alloc_state, stripe->physical,
-				     stripe->physical + map->stripe_size - 1,
-				     bits | EXTENT_NOWAIT, NULL);
+		ret = btrfs_set_extent_bit(
+			&device->alloc_state, stripe->physical,
+			stripe->physical + map->stripe_size - 1,
+			bits | EXTENT_NOWAIT, NULL);
+		if (ret)
+			return ret;
 	}
+	ret = 0;
+	return ret;
 }
 
-static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
+static int chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
 {
+	int ret;
+
 	for (int i = 0; i < map->num_stripes; i++) {
 		struct btrfs_io_stripe *stripe = &map->stripes[i];
 		struct btrfs_device *device = stripe->dev;
 
-		btrfs_clear_extent_bit(&device->alloc_state, stripe->physical,
-				       stripe->physical + map->stripe_size - 1,
-				       bits | EXTENT_NOWAIT, NULL);
+		ret = btrfs_clear_extent_bit(
+			&device->alloc_state, stripe->physical,
+			stripe->physical + map->stripe_size - 1,
+			bits | EXTENT_NOWAIT, NULL);
+		if (ret)
+			return ret;
 	}
+	ret = 0;
+	return ret;
 }
 
 void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map)
@@ -5488,6 +5502,7 @@ static int btrfs_chunk_map_cmp(const struct rb_node *new,
 EXPORT_FOR_TESTS
 int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map)
 {
+	int ret;
 	struct rb_node *exist;
 
 	write_lock(&fs_info->mapping_tree_lock);
@@ -5498,11 +5513,19 @@ int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *m
 		write_unlock(&fs_info->mapping_tree_lock);
 		return -EEXIST;
 	}
-	chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
-	chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
-	write_unlock(&fs_info->mapping_tree_lock);
 
-	return 0;
+	ret = chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
+	if (ret)
+		goto out;
+	ret = chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
+
+out:
+	if (ret) {
+		rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
+		RB_CLEAR_NODE(&map->rb_node);
+	}
+	write_unlock(&fs_info->mapping_tree_lock);
+	return ret;
 }
 
 EXPORT_FOR_TESTS
-- 
2.50.1


