Return-Path: <linux-btrfs+bounces-21516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NgEEEu9UiWnY6wQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21516-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 04:30:55 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C410B630
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 04:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 708F130078F3
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 03:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FDF1E3DDE;
	Mon,  9 Feb 2026 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C0dkG2gl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C0dkG2gl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C018AE3
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770607846; cv=none; b=U9ogU3XEqUDJPoxjmYV3663bvIhc46Mz+U5eJBSlJP5TqhCuS55i8fEEAvVCsYalfZvabeBzIPanWb5Z6S5pP/Imiyt2HP5wxsmBLB5zPbXyJHzxCxT5c5YPQc8yNbHQMIEGS9xGb4hSSc91FekLKW9Mp1U1uKJKGq3TgL9FeHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770607846; c=relaxed/simple;
	bh=PXR9x+oMj/MPZPv1F9jB6JgZc/OwlemEGids7ulSk6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbyVsO0QASJ1JUMwZZMU2bTiPAjvO0AHSwm0BUG6Qo+Q2XCVBLbFa58Jg/jA2lnsGR298s7KWX02g/6AtuTpf3IXEIP7Iei6MgZj0KO14JjNAcu3KJP2JFGRNiHHmXLDqvvU6uQQbcKhByL4nwKznEwxPJtpZye+YTPw9kutJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C0dkG2gl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C0dkG2gl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC2E23E6E1;
	Mon,  9 Feb 2026 03:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770607844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2iC0itCku5YiuF+y1vxrx8ZdBXJi0zdF0+XEofUit3w=;
	b=C0dkG2gl05clTkGuZ2CzN2njNd6nViuuaNt1D/6VQPC9gr2jL1crMynsRP2g2FiH+v8iw4
	BETdpgVDmLW+XyV86TzKF5vaVtR+xEfgjkagKrZro4cBvmT4SyVaWUT/MGBuEY47adhyTM
	BqWsuWsvMERJb5RlzkNMsOvsuIoXgss=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770607844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2iC0itCku5YiuF+y1vxrx8ZdBXJi0zdF0+XEofUit3w=;
	b=C0dkG2gl05clTkGuZ2CzN2njNd6nViuuaNt1D/6VQPC9gr2jL1crMynsRP2g2FiH+v8iw4
	BETdpgVDmLW+XyV86TzKF5vaVtR+xEfgjkagKrZro4cBvmT4SyVaWUT/MGBuEY47adhyTM
	BqWsuWsvMERJb5RlzkNMsOvsuIoXgss=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 616B23EA63;
	Mon,  9 Feb 2026 03:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +aBmBONUiWn8KgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 09 Feb 2026 03:30:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@meta.com>
Subject: [PATCH v2] btrfs: fix the inline compressed extent check in inode_need_compress()
Date: Mon,  9 Feb 2026 14:00:16 +1030
Message-ID: <3cd5a484ffc3d8a499b062cbda89793d560b85d7.1770607799.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21516-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 933C410B630
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
Changelog:
v2:
- Fix a off-by-one bug in the disk_i_size check
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b6c763a17406..7b23ae6872fc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -811,7 +811,8 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 	 * do not even bother try compression, as there will be no space saving
 	 * and will always fallback to regular write later.
 	 */
-	if (start != 0 && end + 1 - start <= fs_info->sectorsize)
+	if (end + 1 - start <= fs_info->sectorsize &&
+	    !(start == 0 && end + 1 >= inode->disk_i_size))
 		return 0;
 	/* Defrag ioctl takes precedence over mount options and properties. */
 	if (inode->defrag_compress == BTRFS_DEFRAG_DONT_COMPRESS)
-- 
2.52.0


