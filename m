Return-Path: <linux-btrfs+bounces-12229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3AFA5DB1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 12:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911E63B7E9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004723ED71;
	Wed, 12 Mar 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OtBLg4Eg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OtBLg4Eg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D71E3DDE
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777965; cv=none; b=BW8RZ4shkxyufBFVGe8Z+TT8M919D5jq+F3Kcd+mZuiGm58qPsrucZBcjO4I6KRcEE+Nb8wn9tFnIUXtFkyxOcLy8tgy8M+DDsuPm2hzs1FNNYHAwOQtPXTt4maGHnI58SQbEtlBF7B24+p/92+mqSfRfujuXAN4Y+Gfnyx9FEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777965; c=relaxed/simple;
	bh=BPxvemC2PRqbl8OmkUee+16knfdJvfGyuURD1rTPsbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/R9Fe/ORJPG1o+rYfL3S/D+QrDlFMtug+QY86ufXvrwLt3jLxyHUjZNv3T5LxaEec634hxaGcLD1tZSgMf6sBXokkSwSgnMg5RMPYCymU6/kiIYDmuBhcVbl7IYeblELPOvFmIDJCueH3o4WrZrbRfM39S30kBkADCv5dPXkt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OtBLg4Eg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OtBLg4Eg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4D9121187;
	Wed, 12 Mar 2025 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741777957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5Z4qlnor8GV/e5Lygriv5tzmfe68+UFpE7ys2IuXWU=;
	b=OtBLg4EgLIMr6K1evfqrTH6rFm9emGuZvk3gD3rcJzkwhXhbQarb/Itg4MNS4Wuj01u4RJ
	KqjMKwlbGLjjrUV/QYHAZKwHJcOEeqWpQXE5Jw+a61be3MNYgCYH2wMyPHCBRj6j+C1TLV
	gPX+nst4N4ShpQ8r8k6HmTTSPNEOyZs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741777957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5Z4qlnor8GV/e5Lygriv5tzmfe68+UFpE7ys2IuXWU=;
	b=OtBLg4EgLIMr6K1evfqrTH6rFm9emGuZvk3gD3rcJzkwhXhbQarb/Itg4MNS4Wuj01u4RJ
	KqjMKwlbGLjjrUV/QYHAZKwHJcOEeqWpQXE5Jw+a61be3MNYgCYH2wMyPHCBRj6j+C1TLV
	gPX+nst4N4ShpQ8r8k6HmTTSPNEOyZs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC8F7132CB;
	Wed, 12 Mar 2025 11:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3UjuMSVs0Wc+NgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Mar 2025 11:12:37 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 4/6] btrfs: add secure erase mode to CLEAR_FREE ioctl
Date: Wed, 12 Mar 2025 12:12:37 +0100
Message-ID: <ab2657697f676f729728c1d82caa726144a9f22c.1741777050.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1741777050.git.dsterba@suse.com>
References: <cover.1741777050.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Add another type of clearing that will do secure erase on the unused
space.

This requires hardware support and works as a regular discard while also
deleting any copied or cached blocks. Same as "blkdiscard --secure".

The unused space ranges may not be aligned to the secure erase block or
be of a sufficient length, the exact result depends on the device.
Some blocks may still contain valid data even after this ioctl.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c     | 3 +++
 include/uapi/linux/btrfs.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 35bef44f069d..1e2fe403ee89 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1253,6 +1253,9 @@ static int btrfs_issue_clear_op(struct block_device *bdev, u64 start, u64 size,
 	unsigned int flags = BLKDEV_ZERO_KILLABLE;
 
 	switch (clear) {
+	case BTRFS_CLEAR_OP_SECURE_ERASE:
+		return blkdev_issue_secure_erase(bdev, start >> SECTOR_SHIFT,
+						 size >> SECTOR_SHIFT, GFP_NOFS);
 	case BTRFS_CLEAR_OP_DISCARD:
 		return blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					    size >> SECTOR_SHIFT, GFP_NOFS);
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7529bc0c6efa..229a07843965 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1107,6 +1107,13 @@ enum btrfs_clear_op_type {
 	 * (Same as blkdev_issue_zeroout() with 0 flags).
 	 */
 	BTRFS_CLEAR_OP_ZERO,
+	/*
+	 * Do a secure erase operation on the range. If supported by the
+	 * underlying hardware, this works as regular discard except that all
+	 * copies of the discarded blocks that were possibly created by
+	 * garbage collection must also be erased.
+	 */
+	BTRFS_CLEAR_OP_SECURE_ERASE,
 	BTRFS_NR_CLEAR_OP_TYPES,
 };
 
-- 
2.47.1


