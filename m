Return-Path: <linux-btrfs+bounces-12345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FACA662DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 00:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089431745D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 23:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0249320469E;
	Mon, 17 Mar 2025 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="sceQ2aVQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YrTHUm6K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9379D2
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255270; cv=none; b=GKYjSAezh/NvtDT1+rgqTWFaR+cs+LIPFJ/TsJQas8ipBBj4VxuxpVeY+0Zz0Jk2CAZkq1S6D/QKN5CEVGgsr2e3t3MxJGNZGc5ZQijoUabEitM5hYrGEnPzrqqmDPTiiHbWitJcLzKdGBwMB0YIwpcBQAYsesf5yR4i8T+vkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255270; c=relaxed/simple;
	bh=w4OWfTA01pMbXMUV1wI05QXkKx341Chn14Bm1evIbhI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E6DH/w3TOkQvRqn9gdTvAtG+jpmam183bKG/M/K7n3GnK9GvimDMYrKVkGT2ZqoJ4E3FzTV64dlsiJsvFUSrXY8mFBIrKHpGTHjZgSr++USQUJITu+mTw0DZR0FPDJbaTOzvJk34f3twGWM0Hsmzc15wuYR5ivWQOvFBWichyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=sceQ2aVQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YrTHUm6K; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ECDBC11401EF;
	Mon, 17 Mar 2025 19:47:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 17 Mar 2025 19:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1742255266; x=1742341666; bh=NooX6fGY2gwol8CaAhcZ2
	p/IvdxOblOanSEQMcyflgc=; b=sceQ2aVQnWesGZR8R64PVrDeAKO9hTiTD/R3q
	4FTNr3lnOZ/aqcnVw0bWiCGPVk2YRUXpJc35OXj51ZiHWTWjnqPrnSD5gkvf3wZR
	WG3TtEfN7x+oBl/gqWYDL0hYmNhvoAWvyKw/ej51oEU3+nbh0fgLBdv7PFGLBUaz
	OqDTICZd/rDkdUNAlcKV0d6uLmNbz+Krvp7j0NFGFaHLM/ZSOKUcDgsWEIzKPaoV
	Leve8O3CtXccp0O0P3EOSmPUNjHDrYj2g94FJwdFmjkihwGZMBF1TMOYE4A+65Mr
	ynN6NjE8DBRvABs+wMhK7zyYUKkTcy7SAG/0HBBjFHPc+OLjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742255266; x=1742341666; bh=NooX6fGY2gwol8CaAhcZ2p/IvdxOblOanSE
	QMcyflgc=; b=YrTHUm6KeRMT+1QySxGz0WGAQrC2Xo0vPnZbJP7vC3nrHhh//X9
	8imLF2R/a0L/ED0VY2Vd/ACOvrHgcEym+Y2geIsSvFUpkPUPwoVnw3SluP8Og3St
	GlluTkuEPxUpJUbi+5TWCFbxqxngS+hCpNdGXC3NpMqyuLe/J73ulPAK6RC2x0ou
	MjSkRx1FRExcmTYSsu06+DxFHl4/wtXPtGudqjpKTZP2zBTM2raKw9SuKKP6bAvb
	JM142n3nSDuop3Yr/l7EtkZqf8r8nrvGd/hBLyhR7hncuM+nmy0X8t0zGHPjzwb2
	AYi9EH8+MRWtJKFJrSV4YbRk5Zeknz+SzZQ==
X-ME-Sender: <xms:orTYZ0LFVJrNdV8e3amImVaLRd_3SmwARRFWDcUG-MQ8JL17Jo2zEg>
    <xme:orTYZ0JlHzyUwa8XdDxxLVhfYy6NEDhZTa3jgvNN60R7WgiZtQueLuNs3QgufXgXn
    nGWjtwEm1dWzYUFPbM>
X-ME-Received: <xmr:orTYZ0vBj1rCsBbCbUIvdTJf0FN8BcQlLBcCo9lX-o-Uh5jzUDdxVGZ05l8CtXQbZ4ZIhH-E2kRb3gD1ta7wYPiQvTAKC2e7Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeetgeegfeehkefgudffgf
    elteeigedtjeeihfehudeiiefgfedugfefueekhfduheenucffohhmrghinhepghhithhh
    uhgsrdgtohhmpdhruhhnrdhshhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuh
    igqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhn
    vghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:orTYZxYb5jYL-FVF2yAJ9_Mi1phui5mgalgMIfrG8dKtu9OlBlbWZQ>
    <xmx:orTYZ7YQ22SOxb2qVRwuyyLkCfMJvJCEy7M_CYIbieNBAanM9OQ4gw>
    <xmx:orTYZ9A9-H6hpPoGOxbJKPg2l3mLQXP81ScphTZMKowYSDIn-661PQ>
    <xmx:orTYZxbDmOUv38u_8JANcl58l1M7Z6DlX5aZ8ctn8tONlXNyL3z2fA>
    <xmx:orTYZ6k-t0DcdGGnEewVqyUUVA2O1FbWVTEIL0x4Nsy5zmFSC7thk3uF>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 19:47:46 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix broken drop_caches on extent_buffer folios
Date: Mon, 17 Mar 2025 16:47:38 -0700
Message-ID: <1c50d284270034703a5c99a42799ff77de871934.1742255123.git.boris@bur.io>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The (correct) commit
e41c81d0d30e ("mm/truncate: Replace page_mapped() call in invalidate_inode_page()")
replaced the page_mapped(page) check with a refcount check. However,
this refcount check does not work as expected with drop_caches for
btrfs's metadata pages.

Btrfs has a per-sb metadata inode with cached pages, and when not in
active use by btrfs, they have a refcount of 3. One from the initial
call to alloc_pages, one (nr_pages == 1) from filemap_add_folio, and one
from folio_attach_private. We would expect such pages to get dropped by
drop_caches. However, drop_caches calls into mapping_evict_folio via
mapping_try_invalidate which gets a reference on the folio with
find_lock_entries(). As a result, these pages have a refcount of 4, and
fail this check.

For what it's worth, such pages do get reclaimed under memory pressure,
so I would say that while this behavior is surprising, it is not really
dangerously broken.

The following script produces such pages and uses drgn to further
analyze the state of the folios at various stages in the lifecycle
including drop_caches and memory pressure.
https://github.com/boryas/scripts/blob/main/sh/strand-meta/run.sh

When I asked the mm folks about the expected refcount in this case, I
was told that the correct thing to do is to donate the refcount from the
original allocation to the page cache after inserting it.
https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/

Therefore, attempt to fix this by adding a put_folio() to the critical
spot in alloc_extent_buffer where we are sure that we have really
allocated and attached new pages.

Since detach_extent_buffer_folio() has relatively complex logic w.r.t.
early exits and whether or not it actually calls folio_detach_private(),
the easiest way to ensure we don't incur a UAF in that function is to
wrap it in a buffer refcount so that the private reference cannot be the
last one.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_io.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7abe6ca5b38ff..207fa2d0de472 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2823,9 +2823,13 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
 		if (!folio)
 			continue;
 
+		/*
+		 * Avoid accidentally putting the last refcount during
+		 * detach_extent_buffer_folio() with an extra
+		 * folio_get()/folio_put() pair as a buffer.
+		 */
+		folio_get(folio);
 		detach_extent_buffer_folio(eb, folio);
-
-		/* One for when we allocated the folio. */
 		folio_put(folio);
 	}
 }
@@ -3370,8 +3374,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * btree_release_folio will correctly detect that a page belongs to a
 	 * live buffer and won't free them prematurely.
 	 */
-	for (int i = 0; i < num_extent_folios(eb); i++)
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		folio_unlock(eb->folios[i]);
+		/*
+		 * A folio that has been added to an address_space mapping
+		 * should not continue holding the refcount from its original
+		 * allocation indefinitely.
+		 */
+		folio_put(eb->folios[i]);
+	}
 	return eb;
 
 out:
-- 
2.47.1


