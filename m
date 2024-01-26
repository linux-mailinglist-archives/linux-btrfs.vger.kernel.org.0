Return-Path: <linux-btrfs+bounces-1838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6778383E744
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 00:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F42D28DDFF
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 23:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A254FA7;
	Fri, 26 Jan 2024 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r6oE4XmL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r6oE4XmL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34620320
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312941; cv=none; b=sCm+/Y02NPaKr89+uQ+r7WBjnbDq6X6Xe8ftugNnD2cn6opRknb5MIfY0BPmfo0OO3XKGNFtRvaB7FdXbsyeb1FrjvlKH076mpkOQ58SA/PfaEXWsrr3mnt9s4cswxARMH4i+2dPC/khIM8oG5zibF4e88t2Yw3+7n/Pjtr+wJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312941; c=relaxed/simple;
	bh=bRX7mA7ChvAJockjZX6JwgSPPHihnS6A13kSzfvNgpY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IpueBh69FqTEgkEcAinqQitSQ2IqXoHVP/wAEuL/d2oZZ5nyTqybKQe9TyymqDoVafFvo9RWi4yFC3qGfcED43Vt+xF+xrr3D5YkYYgFvEOjwShpGt3Oj6iNWikZ1VxCSBtEhpDh+j4JDXSWkBfwZdo+sxVFLjOpMNkEYRnGpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r6oE4XmL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r6oE4XmL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CAC2221DB
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 23:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706312935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DRu2xPmMCW349dcgwIHXiHhHXIVOGq3u1tiktWok5lc=;
	b=r6oE4XmLDqxtCyKYCM06MCbs/ocW4NGe04VJ8sLbjrTZF4thXd6/D6RcxbZBjNtwoOwgyX
	h7zCHvrdz402UPE/U60UO5tfUHSuqHn1jZGPac5rkLRcqStPZR+QV8RMXUSrhHi1V7hdPI
	r7n1jFQOrB0dsFoY+TbFwf2PctwVxkk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706312935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DRu2xPmMCW349dcgwIHXiHhHXIVOGq3u1tiktWok5lc=;
	b=r6oE4XmLDqxtCyKYCM06MCbs/ocW4NGe04VJ8sLbjrTZF4thXd6/D6RcxbZBjNtwoOwgyX
	h7zCHvrdz402UPE/U60UO5tfUHSuqHn1jZGPac5rkLRcqStPZR+QV8RMXUSrhHi1V7hdPI
	r7n1jFQOrB0dsFoY+TbFwf2PctwVxkk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 959A7134C3
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 23:48:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /HeRFeZEtGWeCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 23:48:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tree-checker: dump the page status if hit something wrong
Date: Sat, 27 Jan 2024 10:18:36 +1030
Message-ID: <f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

[BUG]
There is a bug report about very suspicious tree-checker got triggered:

  BTRFS critical (device dm-0): corrupted node, root=256
block=8550954455682405139 owner mismatch, have 11858205567642294356
expect [256, 18446744073709551360]
  BTRFS critical (device dm-0): corrupted node, root=256
block=8550954455682405139 owner mismatch, have 11858205567642294356
expect [256, 18446744073709551360]
  BTRFS critical (device dm-0): corrupted node, root=256
block=8550954455682405139 owner mismatch, have 11858205567642294356
expect [256, 18446744073709551360]
  SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=dm-0
ino=5737268

[ANALYZE]
The root cause is still unclear, but there are some clues already:

- Unaligned eb bytenr
  The block bytenr is 8550954455682405139, which is not even aligned to
  2.
  This bytenr is fetched from extent buffer header, not from eb->start.

  This means, at the initial time of read, eb header bytenr is still
  correct (the very basis check to continue read), but later something
  wrong happened, got at least the first page corrupted.
  Thus we got such obviously incorrect value.

- Invalid extent buffer header owner
  The read itself is triggered for subvolume 256, but the eb header
  owner is 11858205567642294356, which is not really possible.
  The problem here is, subovlume id is limited to (1 << 48 - 1),
  and this one definitely goes beyond that limit.

  So this value is another garbage.

We already got two garbage from an extent buffer, which passed the
initial bytenr and csum checks, but later the contents become garbage at
some point.

This looks like a page lifespan problem (e.g. we didn't proper hold the
page).

[ENHANCEMENT]
The current tree-checker only output things from the extent buffer,
nothing with the page status.

So this patch would enhance the tree-checker output by also dumpping the
first page, which would look like this:

 page:00000000aa9f3ce8 refcount:4 mapcount:0 mapping:00000000169aa6b6 index:0x1d0c pfn:0x1022e5
 memcg:ffff888103456000
 aops:btree_aops [btrfs] ino:1
 flags: 0x2ffff0000008000(private|node=0|zone=2|lastcpupid=0xffff)
 page_type: 0xffffffff()
 raw: 02ffff0000008000 0000000000000000 dead000000000122 ffff88811e06e220
 raw: 0000000000001d0c ffff888102fdb1d8 00000004ffffffff ffff888103456000
 page dumped because: eb page dump
 BTRFS critical (device dm-3): corrupt leaf: root=5 block=30457856 slot=6 ino=257 file_offset=0, invalid disk_bytenr for file extent, have 10617606235235216665, should be aligned to 4096
 BTRFS error (device dm-3): read time tree block corruption detected on logical 30457856 mirror 1

From the dump we can see some extra info, something can help us to do
extra cross-checks:

- Page refcount
  if it's too low, it definitely means something bad.

- Page aops
  Any mapped eb page should have btree_aops with inode number 1.

- Page index
  Since a mapped eb page should has its bytenr matching the page
  position, (index << PAGE_SHIFT) should match the bytenr of the
  bytenr from the critical line.

- Page Private flags
  A mapped eb page should have Private flag set to indicate it's managed
  by btrfs.

Link: https://marc.info/?l=linux-btrfs&m=170629708724284&w=2
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 4fa95eca285e..c8fbcae4e88e 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -65,6 +65,7 @@ static void generic_err(const struct extent_buffer *eb, int slot,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
+	dump_page(folio_page(eb->folios[0], 0), "eb page dump");
 	btrfs_crit(fs_info,
 		"corrupt %s: root=%llu block=%llu slot=%d, %pV",
 		btrfs_header_level(eb) == 0 ? "leaf" : "node",
@@ -92,6 +93,7 @@ static void file_extent_err(const struct extent_buffer *eb, int slot,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
+	dump_page(folio_page(eb->folios[0], 0), "eb page dump");
 	btrfs_crit(fs_info,
 	"corrupt %s: root=%llu block=%llu slot=%d ino=%llu file_offset=%llu, %pV",
 		btrfs_header_level(eb) == 0 ? "leaf" : "node",
@@ -152,6 +154,7 @@ static void dir_item_err(const struct extent_buffer *eb, int slot,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
+	dump_page(folio_page(eb->folios[0], 0), "eb page dump");
 	btrfs_crit(fs_info,
 		"corrupt %s: root=%llu block=%llu slot=%d ino=%llu, %pV",
 		btrfs_header_level(eb) == 0 ? "leaf" : "node",
@@ -647,6 +650,7 @@ static void block_group_err(const struct extent_buffer *eb, int slot,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
+	dump_page(folio_page(eb->folios[0], 0), "eb page dump");
 	btrfs_crit(fs_info,
 	"corrupt %s: root=%llu block=%llu slot=%d bg_start=%llu bg_len=%llu, %pV",
 		btrfs_header_level(eb) == 0 ? "leaf" : "node",
@@ -1003,6 +1007,7 @@ static void dev_item_err(const struct extent_buffer *eb, int slot,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
+	dump_page(folio_page(eb->folios[0], 0), "eb page dump");
 	btrfs_crit(eb->fs_info,
 	"corrupt %s: root=%llu block=%llu slot=%d devid=%llu %pV",
 		btrfs_header_level(eb) == 0 ? "leaf" : "node",
@@ -1258,6 +1263,7 @@ static void extent_err(const struct extent_buffer *eb, int slot,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
+	dump_page(folio_page(eb->folios[0], 0), "eb page dump");
 	btrfs_crit(eb->fs_info,
 	"corrupt %s: block=%llu slot=%d extent bytenr=%llu len=%llu %pV",
 		btrfs_header_level(eb) == 0 ? "leaf" : "node",
-- 
2.43.0


