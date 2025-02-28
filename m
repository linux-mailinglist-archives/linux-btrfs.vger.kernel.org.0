Return-Path: <linux-btrfs+bounces-11943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1ADA49C62
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 15:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478D53AC03D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0712702B7;
	Fri, 28 Feb 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fIV5NplP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fIV5NplP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4926E642
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754178; cv=none; b=GuI1MxhiYY1E6dTNG9H35TTR4UppWyLxaWqPGglaBJMhrut1Z3aYIjiNOU7vWsCWjzqqz94UCWS/Ut2BK2Ux32PrriQIdHzThoHm3EvU+OKe+tNJhR5uSmOKueTxyw/Z2grKPMi8S2Tgp1XlZax5v1BZn0ErIHUjWqaJwZsZjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754178; c=relaxed/simple;
	bh=o0UaAIa/iCFmYWQvDXQcygNZ2SL1awJlsBPbEJiPoQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CG7q7K9D8MQFBl47BIDVgJfAxv63UqaZ4yHfAJb2Z/fX71cppd8CYm4qfXRLaON1QSFk2rshuq1M2haUlb6/pINol91MhGLKAAuHrfVnwoi6d30Dl7euqEAjtBiL3OLDDLVKzrbIrussp8uXsS5CZVLPxsApJt4PnyrdtIMeTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fIV5NplP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fIV5NplP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C60221184;
	Fri, 28 Feb 2025 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHfsZu4VneLqsuY8fyU6NqzHx4QJAMohxB5CV/wB70c=;
	b=fIV5NplP24iaSx3pA9zi/6j32btZD8vUbYT1OlAZEOvXv3gNOiriO8Np46t7M4i7dHvvBd
	ZBx6XrQywhkqPX4j/J5PFKPgNtyxlPKL9T15g09k3fm8uJSl74DpqqH+MhxmljixC1RyU1
	v9Sr99PApIWw2slXvcXFhbSBSY4t1QU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHfsZu4VneLqsuY8fyU6NqzHx4QJAMohxB5CV/wB70c=;
	b=fIV5NplP24iaSx3pA9zi/6j32btZD8vUbYT1OlAZEOvXv3gNOiriO8Np46t7M4i7dHvvBd
	ZBx6XrQywhkqPX4j/J5PFKPgNtyxlPKL9T15g09k3fm8uJSl74DpqqH+MhxmljixC1RyU1
	v9Sr99PApIWw2slXvcXFhbSBSY4t1QU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75E40137AC;
	Fri, 28 Feb 2025 14:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K0jGHP7MwWdXPQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 28 Feb 2025 14:49:34 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: add zeroout mode to CLEAR_FREE ioctl
Date: Fri, 28 Feb 2025 15:49:34 +0100
Message-ID: <20063b99847a5ac0e2d88a2d4b2082f7aa7ec40d.1740753608.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
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
index 4ab9850b7383..6c45625a293a 100644
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
index 278010aff02e..65700c289140 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1091,6 +1091,12 @@ enum btrfs_err_code {
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


