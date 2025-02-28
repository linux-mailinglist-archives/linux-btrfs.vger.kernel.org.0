Return-Path: <linux-btrfs+bounces-11945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A6CA49C64
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 15:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF30218970B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C302702B9;
	Fri, 28 Feb 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TGy9grTp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TGy9grTp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47E26E94D
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754186; cv=none; b=uOIy6bQZkzkBBl4J2NhTcszxRdoNLywznJoMweX2rL21gytvnrJHfu96uYOswcj2XNZ82dGMsKFLKhHSyJDl0rFEc+AXBsMLLvmJHECTt1b538K2dY8okPHHYg00vj18ILVHAnbTDu28BxNwkIgfn2EvnSHa2ph8Kbb+a/Z1lQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754186; c=relaxed/simple;
	bh=yPSjoNyI/hLoPpckMYnNOHPiY8CZw3v9BPfmK4fCvlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tg6FlVbo+Oy/P9QJYWs45N+dQKceVHHRSY+5SEsyU5zExwo2Q5dmNeBI6epFJCs7NkzvxXPhJrUCFHm6ab2SgcuP/GM5ytRGoZtUTBCD2zfCLJXayHCsn9p9u4z31gf95S6EJPdBV6x29th+OEaHP9w/EX853K3e5m3VuGCP4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TGy9grTp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TGy9grTp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C81321184;
	Fri, 28 Feb 2025 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWGWqZT3JPMI2DYg/vVqqTRU+qcEqWhH+B/MCBMLr5s=;
	b=TGy9grTpgy/WEpda9X28n47FeFaRqRS4JWi62HVJGfYomi7PgnaI+B+0tbm6s8kS0i6zQI
	fk8eVAQxoeSESTD+S6x5uUAgvnxi3aKdCWjGacJPcIoUifvPccwNk7qqtQnQe83/sZG89O
	790wWRc1RdVCusLAJ+KdxMF5C6gGxVE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TGy9grTp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWGWqZT3JPMI2DYg/vVqqTRU+qcEqWhH+B/MCBMLr5s=;
	b=TGy9grTpgy/WEpda9X28n47FeFaRqRS4JWi62HVJGfYomi7PgnaI+B+0tbm6s8kS0i6zQI
	fk8eVAQxoeSESTD+S6x5uUAgvnxi3aKdCWjGacJPcIoUifvPccwNk7qqtQnQe83/sZG89O
	790wWRc1RdVCusLAJ+KdxMF5C6gGxVE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 355DF137AC;
	Fri, 28 Feb 2025 14:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 75sFDQfNwWduPQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 28 Feb 2025 14:49:43 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: add more zeroout modes to CLEAR_FREE ioctl
Date: Fri, 28 Feb 2025 15:49:42 +0100
Message-ID: <207cb619230063cd62a5857dc1b98139e1f3a4d6.1740753608.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740753608.git.dsterba@suse.com>
References: <cover.1740753608.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3C81321184
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The zeroing mode BTRFS_CLEAR_OP_ZERO is safe for use regardless of the
underlying device capabilities, either zeros are written or the device
will unmap the blocks. This a safe behaviour.

In case it's desired to do one or the another add modes that can enforce
that or fail when unsupported;

- CLEAR_OP_ZERO - overwrite by zero blocks, forbid unmapping blocks by
                  the device

- CLEAR_OP_ZERO_NOFALLBACK - unmap the blocks by device and do not fall
                             back to overwriting by zeros

Implemented by __blkdev_issue_zeroout() and also documented there.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c     | 11 +++++++++--
 include/uapi/linux/btrfs.h |  5 +++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e38760fbf324..779216aa8ce0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1259,10 +1259,17 @@ static int btrfs_issue_clear_op(struct block_device *bdev, u64 start, u64 size,
 	case BTRFS_CLEAR_OP_DISCARD:
 		return blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					    size >> SECTOR_SHIFT, GFP_NOFS);
+	case BTRFS_CLEAR_OP_ZERO_NOUNMAP:
+		flags |= BLKDEV_ZERO_NOUNMAP;
+		return blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
+					    size >> SECTOR_SHIFT, GFP_NOFS, flags);
+	case BTRFS_CLEAR_OP_ZERO_NOFALLBACK:
+		flags |= BLKDEV_ZERO_NOFALLBACK;
+		return blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
+					    size >> SECTOR_SHIFT, GFP_NOFS, flags);
 	case BTRFS_CLEAR_OP_ZERO:
 		return blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
-					    size >> SECTOR_SHIFT, GFP_NOFS,
-					    flags);
+					    size >> SECTOR_SHIFT, GFP_NOFS, flags);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 018f0f1bbd5f..12e54f3b0a13 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1104,6 +1104,11 @@ enum btrfs_clear_op_type {
 	 * garbage collection must also be erased.
 	 */
 	BTRFS_CLEAR_OP_SECURE_ERASE,
+
+	/* Overwrite by zeros, do not try to unmap blocks. */
+	BTRFS_CLEAR_OP_ZERO_NOUNMAP,
+	/* Request unmapping the blocks and don't fall back to writing zeros. */
+	BTRFS_CLEAR_OP_ZERO_NOFALLBACK,
 	BTRFS_NR_CLEAR_OP_TYPES,
 };
 
-- 
2.47.1


