Return-Path: <linux-btrfs+bounces-12228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E32BA5DB1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 12:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D07C17507A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9623ED56;
	Wed, 12 Mar 2025 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IfMXPJ2V";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IfMXPJ2V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576A23AE83
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777959; cv=none; b=JHTGYNEHFtX/PYhYdOIyjKjkqOM6vj55ncDxYsotKwPCugCNrXONN/qfWqwq0iCJBrKfeZyKCLK/1S1Q+71Y4/AxgagQWeHXKf8t0dP/VW7FxidpUDAw93LgUGntTduQHslvUKq89YHujLhv4ZgzLMf+EH34sGsF+mXa+pGLPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777959; c=relaxed/simple;
	bh=U02vXfZJDSo9drfUkuauaMRnlZDUJXJZKuBX6c5YjiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eggMUDKspVI+tTrIe5dToHWkOhSa0JEzyLtvLk7ljcP+uSiZbrzEqR4OVLSQsQGlSsZOq94nZXR381eKHhMAI8oJjTqyHLVSeTWsDLfB2l3qX0M+5noyjInJB3kDSJYI8JPb8RYkL3QjgMZX9uviGD4hGg5IDj1r0QbS+w0RrIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IfMXPJ2V; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IfMXPJ2V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75DFC21169;
	Wed, 12 Mar 2025 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741777955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAvxe78/aoUyEQPUIUtC3sY6CELAzVMsyV+xu9y+IV0=;
	b=IfMXPJ2VLtQ2hZp2iKfltqfGF1XtVAgsZkmdw8V3pr3BLrwIOIS6Gq20jR0ftmbLdgYznh
	mOqyfiHI7mmJDy7EBkype8exUYOE2ZBVSg4yH9nu/3IRWyAe4LTuDbvnHTAa34No1PkCFG
	ED4TBqyoabyITY5BB0W/GtgwXYRvibo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741777955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAvxe78/aoUyEQPUIUtC3sY6CELAzVMsyV+xu9y+IV0=;
	b=IfMXPJ2VLtQ2hZp2iKfltqfGF1XtVAgsZkmdw8V3pr3BLrwIOIS6Gq20jR0ftmbLdgYznh
	mOqyfiHI7mmJDy7EBkype8exUYOE2ZBVSg4yH9nu/3IRWyAe4LTuDbvnHTAa34No1PkCFG
	ED4TBqyoabyITY5BB0W/GtgwXYRvibo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F1F7132CB;
	Wed, 12 Mar 2025 11:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q0AfGyNs0Wc5NgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Mar 2025 11:12:35 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 3/6] btrfs: add zeroout mode to CLEAR_FREE ioctl
Date: Wed, 12 Mar 2025 12:12:27 +0100
Message-ID: <f49588399c982a7813955f472822bdd49eb71f79.1741777050.git.dsterba@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Add new type of clearing that will write zeros to the unused space
(similar to what trim/discard would do).

The mode is implemented by blkdev_issue_zeroout() that can write zeros
to the blocks explicitly unless the hardware implements UNMAP command
that unmaps the blocks that effectively appear as zeroed. This is
handled transparently.

As a special case of thin provisioning device, the UNMAP is usually
handled and can free the underlying space.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c     | 6 ++++++
 include/uapi/linux/btrfs.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 942584b9018a..35bef44f069d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1250,10 +1250,16 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 static int btrfs_issue_clear_op(struct block_device *bdev, u64 start, u64 size,
 				enum btrfs_clear_op_type clear)
 {
+	unsigned int flags = BLKDEV_ZERO_KILLABLE;
+
 	switch (clear) {
 	case BTRFS_CLEAR_OP_DISCARD:
 		return blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					    size >> SECTOR_SHIFT, GFP_NOFS);
+	case BTRFS_CLEAR_OP_ZERO:
+		return blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
+					    size >> SECTOR_SHIFT, GFP_NOFS,
+					    flags);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index cfa1136815f1..7529bc0c6efa 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1101,6 +1101,12 @@ enum btrfs_err_code {
  */
 enum btrfs_clear_op_type {
 	BTRFS_CLEAR_OP_DISCARD,
+	/*
+	 * Write zeros to the range, either overwrite or with hardware offload
+	 * that can unmap the blocks internally.
+	 * (Same as blkdev_issue_zeroout() with 0 flags).
+	 */
+	BTRFS_CLEAR_OP_ZERO,
 	BTRFS_NR_CLEAR_OP_TYPES,
 };
 
-- 
2.47.1


