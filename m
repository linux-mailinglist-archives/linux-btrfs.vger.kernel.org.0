Return-Path: <linux-btrfs+bounces-21513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBlOKAtHiWm25gQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21513-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 03:31:39 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D910B17D
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 03:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 955DA300888E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 02:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC0C28725B;
	Mon,  9 Feb 2026 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="di1abowQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="di1abowQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699A14A60F
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 02:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604291; cv=none; b=ROqMYhm+hhCyRB7EpIzy5X7W9zr5+u7+rGaJc3V63dqZXxZMtv1qHlIILA9ck6mLbIkw+qYkHGAjPq5UpGbVaX8ThAq89wtQSC8rpQLTynUsjzzXpQk/6RvkhlpT/XWNS8iBfQ2DIvVGqWZRFCEYhutCy66QhxGNp/qYGhzMvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604291; c=relaxed/simple;
	bh=hi603AHR6B9sZ6fXdiN2CjwItyIKsuC2slk3W0ter/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NcUi2lgdgeWu6Kijlz48d7EuGju//zo6yZSuYdbNWgL+4ueCfAun4ROkivyc6NeiOwVnvkcOdoO+7G+vSHCAlAnGzIG1AWY/HCRtoNrudmGzSQ84Fzfk+g+cVRhiZ7i4GUMzfw2uCvTB9hkHQxPverqTRtPYMN9CW4As/KOe5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=di1abowQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=di1abowQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E3585BCC3;
	Mon,  9 Feb 2026 02:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770604289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AakJ2i5z5OnhyUQrMIhtp592uNJyvsu44xdX5x6yU0w=;
	b=di1abowQWL2gNYjXcNnIEIuISbzkM8mHcWQuwzHPCqKbt1BsxyIxBwFrAs7gq6wBY0nI8u
	LEST9ynqNoyvul2WMuRzUD0ULQvhATCXFABiDfGZtT3os3qZ9Eu0r8VySqzJYuu9N0q8Kv
	KGV0n1hYyu8vXKZUyfppO3zoDM6sYUA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=di1abowQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770604289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AakJ2i5z5OnhyUQrMIhtp592uNJyvsu44xdX5x6yU0w=;
	b=di1abowQWL2gNYjXcNnIEIuISbzkM8mHcWQuwzHPCqKbt1BsxyIxBwFrAs7gq6wBY0nI8u
	LEST9ynqNoyvul2WMuRzUD0ULQvhATCXFABiDfGZtT3os3qZ9Eu0r8VySqzJYuu9N0q8Kv
	KGV0n1hYyu8vXKZUyfppO3zoDM6sYUA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3538B3EA63;
	Mon,  9 Feb 2026 02:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GqdANf9GiWmvfwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 09 Feb 2026 02:31:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@meta.com>
Subject: [PATCH] btrfs: fix the inline compressed extent check in inode_need_compress()
Date: Mon,  9 Feb 2026 13:01:09 +1030
Message-ID: <62400465995ad5bb953bfc48d31efd05fc58a24e.1770604259.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21513-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A4D910B17D
X-Rspamd-Action: no action

[BUG]
Since commit 59615e2c1f63 ("btrfs: reject single block sized compression
early"), the following script will result the inode to have NOCOMPRESS
flag, meanwhile old kernels don't:

	# mkfs.btrfs -f $dev
	# mount $dev $mnt -o max_inline=2k,compress=zstd
	# truncate -s 8k $mnt/foobar
	# xfs_io -f -c "pwrite 0 2k" $mnt/foobar
	# sync

Before that commit, the inode will not have NOCOMPRESS flag:

	item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
		generation 9 transid 9 size 8192 nbytes 4096
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 3 flags 0x0(none)

But after that commit, the inode will have NOCOMPRESS flag:

	item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
		generation 9 transid 10 size 8192 nbytes 4096
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 3 flags 0x8(NOCOMPRESS)

This will make a lot of files no longer to be compressed.

[CAUSE]
The old compressed inline check looks like this:

	if (total_compressed <= blocksize &&
	   (start > 0 || end + 1 < inode->disk_i_size))
		goto cleanup_and_bail_uncompressed;

That inline part check is equal to "!(start == 0 && end + 1 >=
inode->disk_i_size)", but the new check no longer has that disk_i_size
check.

Thus it means any single block sized write at file offset 0 will pass
the inline check, which is wrong.

Furthermore, since we have merged the old check into
inode_need_compress(), there is no disk_i_size based inline check
anymore, we will always try compressing that single block at file offset
0, then later find out it's not a net win and go to the
mark_incompressible tag.

This results the inode to have NOCOMPRESS flag.

[FIX]
Add back the missing disk_i_size based check into inode_need_compress().

Now the same script will no longer cause NOCOMPRESS flag.

Fixes: 59615e2c1f63 ("btrfs: reject single block sized compression early")
Reported-by: Chris Mason <clm@meta.com>
Link: https://lore.kernel.org/linux-btrfs/20260208183840.975975-1-clm@meta.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b6c763a17406..24738a1034a8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -811,7 +811,8 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 	 * do not even bother try compression, as there will be no space saving
 	 * and will always fallback to regular write later.
 	 */
-	if (start != 0 && end + 1 - start <= fs_info->sectorsize)
+	if (end + 1 - start <= fs_info->sectorsize &&
+	    !(start == 0 && end >= inode->disk_i_size))
 		return 0;
 	/* Defrag ioctl takes precedence over mount options and properties. */
 	if (inode->defrag_compress == BTRFS_DEFRAG_DONT_COMPRESS)
-- 
2.52.0


