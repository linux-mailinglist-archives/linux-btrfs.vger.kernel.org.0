Return-Path: <linux-btrfs+bounces-6115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013491E9D7
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 22:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7999282BAD
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 20:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398EA16F8F0;
	Mon,  1 Jul 2024 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Nk55bVdI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h4y032if"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9BB1591E3
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867203; cv=none; b=cAKEK95niE++dpI6gG6khnEy5fwWWZbtGkukPWH+wKGSpPU9AvPkFzKdwjGsq7TwXa8Q1bSfPLTFyGNAtCjITxpjy9WzEc4pBSSf8VQv/8rE8hvHi5GglWLD70f0cNfZRQxeNvQZpcOiz1T/C5B9cLX9GqsMpoFXnYbt9PRpZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867203; c=relaxed/simple;
	bh=MqmsmNv9RIk6I2Wg5j2c1oTYP8hwrRxH9qpwRwQQyro=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZN+SYGR98ZTszFCV/U4e243IpKTGOC4hb7P2qgbb5ANzzKnnc/cK0jP1O6tJtAhsBEkrtYJH0kgQkXAbwT1DBKRiN+28m3e0nRb/JRdBUzwao2oqphN9ZPvrNmVczWBun+Do43mcXijl/wClXyLK4ExRPVzGJYWVLryPzektY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Nk55bVdI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h4y032if; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id ADAA213804B9;
	Mon,  1 Jul 2024 16:53:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 01 Jul 2024 16:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1719867199; x=1719953599; bh=BJ2++wckD7GH8XSCLkde/
	2FPMUVQIxkERLU/2BtMtnc=; b=Nk55bVdI/RCfLafg03P6f3N2u0LPayEMG8YO3
	CFXJizKfw1bGi2CJ7109jSgBxjCi6NV3YgXwE3fCLExfLQKBzam4rJlosy0anbio
	cY6v4EgAztNQWtanzJMwUZ+sixHWu8Hudy9BNxgIYIMZUlxXcsblWv5RWzHICaWS
	4LYNDvyRXlBHpS6t5qCdmFyXzplLJ5NtjesNtwhus0W6rrtQ+QhEzR6WNTAHLg6W
	Q6+/td5MnQslRiTQkYIcRZIQJYEyGJaL7U52LtWUqMuGfmxx9eEULQqwVZnA26Tr
	Mz2yM6m250/bUsZQp5YCu5dk3KP7d7swHciFxvQH7zocvJ81w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719867199; x=1719953599; bh=BJ2++wckD7GH8XSCLkde/2FPMUVQ
	IxkERLU/2BtMtnc=; b=h4y032if23KBy3mYYeI5wYpA6QuVcsLwoW1M85+JuHGX
	OW6i2bjn3yKfvmeaeue6hcGNOOQAsrMwIG8UJ4P7QVxPlDxTlgTWKFtdSjjxEYCu
	oWJKiz+KrqUvQVHbpTICLLqWfyuA8+bDbhInMw1OiT2pkD7PfEQ4De5G00RAIvdh
	G0bW42JIC2NNIgLmgeBRTtroWaXw7Xz7gzTIjwOfruv8K4NbWAs/GKz8b5m0Fy3N
	3kDgu/lYWhJoHjlc9ENCZUO7WvXf/8xeDk4qv9CS8mVo6mYhEbbsw7mJI+ZVc8GX
	p2ASvF5sVEcn3gN4gxcV+scwVrReQ0w3hP9W70Jv1Q==
X-ME-Sender: <xms:PxeDZobPml21TZaGnG9QZkQKQWNSnHMcEol-68E2HqUJMuWTf5NBuQ>
    <xme:PxeDZjbc2rzAlzkEIWIMonEYwlb9rZYM3UmQ5dQoKBk2EigNGYwlWG7bo8UBO7aC9
    cRxW36pfOPIga-tJ1o>
X-ME-Received: <xmr:PxeDZi-fMNhmeNLfzNT7_UbcUmm_dvuH68AEgzvKSPl9Lva8LHlOX_yQBV_ljZN_OU9MD6wYLobtv6jbte18X8sSEds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:PxeDZipt74FL062-_3wd4num9jGMJ5swLD5bmjM1qDlI1ONwvY1E-Q>
    <xmx:PxeDZjr7ALqwj16jptDoscEuAC9nw3I3SuC6H7qs6I1jv3Z9VZC8ZA>
    <xmx:PxeDZgSwf3reTsFVceCCm7ddWzEkAD-neJBCAFmJpanfoZWtFHoh3w>
    <xmx:PxeDZjobzw66ORxQaNZcO8osS9olcSzPpngt14mvyTohPSKummqIhg>
    <xmx:PxeDZq11VqgDnJ9CqEaUTbZjKH7QvNNglVpFVFhGxCulzmKNvRtWv2y4>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jul 2024 16:53:19 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix __folio_put with no deref in btrfs_do_encoded_write
Date: Mon,  1 Jul 2024 13:52:34 -0700
Message-ID: <5d7a3eabf63e5c60a8ceb243221bc8778117a8e8.1719867140.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The conversion to folios switched __free_page to __folio_put in the
error path in btrfs_do_encoded_write.

However, this gets the page refcounting wrong. If we do hit that error
path (I reproduced by modifying btrfs_do_encoded_write to pretend to
always fail in a way that jumps to out_folios and running the xfstest
btrfs/281), then we always hit the following BUG freeing the folio:

BUG: Bad page state in process btrfs  pfn:40ab0b
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x61be5 pfn:0x40ab0b
 flags: 0x5ffff0000000000(node=0|zone=2|lastcpupid=0x1ffff)
raw: 05ffff0000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000061be5 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: nonzero _refcount
Call Trace:
<TASK>
dump_stack_lvl+0x3d/0xe0
bad_page+0xea/0xf0
free_unref_page+0x8e1/0x900
? __mem_cgroup_uncharge+0x69/0x90
__folio_put+0xe6/0x190
btrfs_do_encoded_write+0x445/0x780
? current_time+0x25/0xd0
btrfs_do_write_iter+0x2cc/0x4b0
btrfs_ioctl_encoded_write+0x2b6/0x340

It turns out __free_page dereferenced the page while __folio_put does
not. Switch __folio_put to folio_put which does dereference the page
first.

Fixes: 400b172b8cdc ("btrfs: compression: migrate compression/decompression paths to folios")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0a11d309ee89..12fb7e8056a1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9558,7 +9558,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 out_folios:
 	for (i = 0; i < nr_folios; i++) {
 		if (folios[i])
-			__folio_put(folios[i]);
+			folio_put(folios[i]);
 	}
 	kvfree(folios);
 out:
-- 
2.45.2


