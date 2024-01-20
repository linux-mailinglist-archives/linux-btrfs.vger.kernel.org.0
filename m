Return-Path: <linux-btrfs+bounces-1583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 230AB833355
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 10:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75C8B22F8F
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D608ED27D;
	Sat, 20 Jan 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pZL/NMfd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pZL/NMfd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10EFD262
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Jan 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705741912; cv=none; b=YlC9Zb9S9fA/huLJc89v/qUMsx3MYPTw/BBAdxAQ11N71f19HZUbLqySsXZXUoMByYrefexW3R+V8oOMguBnpD9aqLmGGT04ADV9p2sRylzVJ2SgDdb+FJ2kQeLRgFM6zy7daBP70ZgfgphTDIcXhmoo8qgcTF/hm0bZ7eSbd4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705741912; c=relaxed/simple;
	bh=LWY27RCqZlc5NAEZSaCX0r3Rjst2+fx3WUSuLHSfU8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSQ96ALS+qnTXj5hUayAyRkevBfK5GFIW0d6c8amc6zJWjA7OuP1sq1J11x5+IupddG/vBej1e+gxVhb5reUeT5csxy/CfCoa+9zMOU2P2Q/8BPUdaUVehFnbrGSvfYTqr+QWRa72Vd/mNxnzQRF27d8CEpyd9bGpNdFOWMiQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pZL/NMfd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pZL/NMfd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7FD21F854;
	Sat, 20 Jan 2024 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705741907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2Bd1gsv3cxz74eq6GuE2gr1CKDn6gRuD5Ha1UH9rD9c=;
	b=pZL/NMfdq1hcn8+OJl9r8kqW+eHqfHm9Ih+Kd4VzIFIjhevqSEid2DQ+QVD6hZ7Zgpfaz3
	04a5dmgO+AyFJjnVuamriJNqwjj+0fCQLQOQcB7OFXatLLN+9QDY+mWoikXTgOsKQzNTNL
	CsrNw+fFKb5cLszK0EGWGYDSbyeUJ1s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705741907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2Bd1gsv3cxz74eq6GuE2gr1CKDn6gRuD5Ha1UH9rD9c=;
	b=pZL/NMfdq1hcn8+OJl9r8kqW+eHqfHm9Ih+Kd4VzIFIjhevqSEid2DQ+QVD6hZ7Zgpfaz3
	04a5dmgO+AyFJjnVuamriJNqwjj+0fCQLQOQcB7OFXatLLN+9QDY+mWoikXTgOsKQzNTNL
	CsrNw+fFKb5cLszK0EGWGYDSbyeUJ1s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68691136F5;
	Sat, 20 Jan 2024 09:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M2p7B1KOq2W5WgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 20 Jan 2024 09:11:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] btrfs: do not ASSERT() if the newly created subvolume already got read
Date: Sat, 20 Jan 2024 19:41:28 +1030
Message-ID: <6a80cb4b32af89787dadee728310e5e2ca85343f.1705741883.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="pZL/NMfd"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.40 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.71)[0.902];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 3.40
X-Rspamd-Queue-Id: A7FD21F854
X-Spam-Flag: NO

[BUG]
There is a syzbot crash, triggered by the ASSERT() during subvolume
creation:

 assertion failed: !anon_dev, in fs/btrfs/disk-io.c:1319
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/disk-io.c:1319!
 invalid opcode: 0000 [#1] PREEMPT SMP KASAN
 RIP: 0010:btrfs_get_root_ref.part.0+0x9aa/0xa60
  <TASK>
  btrfs_get_new_fs_root+0xd3/0xf0
  create_subvol+0xd02/0x1650
  btrfs_mksubvol+0xe95/0x12b0
  __btrfs_ioctl_snap_create+0x2f9/0x4f0
  btrfs_ioctl_snap_create+0x16b/0x200
  btrfs_ioctl+0x35f0/0x5cf0
  __x64_sys_ioctl+0x19d/0x210
  do_syscall_64+0x3f/0xe0
  entry_SYSCALL_64_after_hwframe+0x63/0x6b
 ---[ end trace 0000000000000000 ]---

[CAUSE]
During create_subvol(), after inserting root item for the newly created
subvolume, we would trigger btrfs_get_new_fs_root() to get the
btrfs_root of that subvolume.

The idea here is, we have preallocated an anonymous device number for
the subvolume, thus we can assign it to the new subvolume.

But there is really nothing preventing things like backref walk to read
the new subvolume.
If that happens before we call btrfs_get_new_fs_root(), the subvolume
would be read out, with a new anonymous device number assigned already.

In that case, we would trigger ASSERT(), as we really expect no one to
read out that subvolume (which is not yet accessible from the fs).
But things like backref walk is still possible to trigger the read on
the subvolume.

Thus our assumption on the ASSERT() is not correct in the first place.

[FIX]
Fix it by removing the ASSERT(), and just free the @anon_dev, reset it
to 0, and continue.

If the subvolume tree is read out by something else, it should have
already get a new anon_dev assigned thus we only need to free the
preallocated one.

Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 2dfb1e43f57d ("btrfs: preallocate anon block device at first phase of snapshot creation")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 57be7dd44da5..5d5faa844408 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1336,8 +1336,17 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 again:
 	root = btrfs_lookup_fs_root(fs_info, objectid);
 	if (root) {
-		/* Shouldn't get preallocated anon_dev for cached roots */
-		ASSERT(!anon_dev);
+		/*
+		 * Some other caller may have read out the newly inserted
+		 * subvolume already. (For things like backref walk etc).
+		 * Not that common but still possible.
+		 * In that case, we just need to free the anon_dev.
+		 */
+		if (unlikely(anon_dev)) {
+			free_anon_bdev(anon_dev);
+			anon_dev = 0;
+		}
+
 		if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
 			btrfs_put_root(root);
 			return ERR_PTR(-ENOENT);
-- 
2.43.0


