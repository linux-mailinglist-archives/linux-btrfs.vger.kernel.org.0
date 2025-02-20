Return-Path: <linux-btrfs+bounces-11628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BEAA3D5DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDE717D8B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D841F0E42;
	Thu, 20 Feb 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hk7PtcJW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hk7PtcJW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165CF1EC016
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045707; cv=none; b=YRXkNNaGY1DBYYRiZVoEGDjXwqaggk8F9dvAKPqi8znupu/vBDIQMsgg9pnd+A90o+rNQPLNAwjq1go5bzN4Qa9iwjCnEr5VD5l0QQYZU0A9i5k6gnzQjJZ2C8lVEaO+flvJmVgpC6FK4uMW5wXxBdWUCZdqGOPmoTkv/8xWUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045707; c=relaxed/simple;
	bh=NoYOPA8eaNQLhS76r/sGeXHn+NtZ9yUD4AmWsMLLxzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwnS8NKyITzXenYgb2kHaJ4WnyXXzchtLqM3EjsnqR/V9We9+HTIva2a5Y05xsp9EiAPqjt7tKbmLwNFLDe049mkQWnco1I+ukoC/EicZZirr0muMzUJHIolxqTCUnJXs07hdq1iWAFoflMFm0Tlvzq909ySzGcdIHVUJW9uDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hk7PtcJW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hk7PtcJW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94D492117C;
	Thu, 20 Feb 2025 10:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzdeTSvJecpx84OWCfR8GaB5pCJ361rIJH9s+G/BB2c=;
	b=Hk7PtcJWUpLs7RgSx86kZf7Zjd4zjr1O/QO0zM7+DQj2GSA76JhbkzSyX62N29BCkfcOs4
	AuajDO4hVo2NYL3CFjmgdKJQrzuQTmBpYoSMa7pExiYOG0zok2wq2dK4erYif8SU294Qgi
	z6hCn+Pv+TsLnm+OgCVgXK4TZQIrG6s=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzdeTSvJecpx84OWCfR8GaB5pCJ361rIJH9s+G/BB2c=;
	b=Hk7PtcJWUpLs7RgSx86kZf7Zjd4zjr1O/QO0zM7+DQj2GSA76JhbkzSyX62N29BCkfcOs4
	AuajDO4hVo2NYL3CFjmgdKJQrzuQTmBpYoSMa7pExiYOG0zok2wq2dK4erYif8SU294Qgi
	z6hCn+Pv+TsLnm+OgCVgXK4TZQIrG6s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E6E413301;
	Thu, 20 Feb 2025 10:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nLrDIoj9tmeufwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:44 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 17/22] btrfs: pass struct btrfs_inode to btrfs_double_mmap_unlock()
Date: Thu, 20 Feb 2025 11:01:44 +0100
Message-ID: <5f27bde82a63246557bbc6f5b0d8de8835f5ac83.1740045551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740045551.git.dsterba@suse.com>
References: <cover.1740045551.git.dsterba@suse.com>
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
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Pass a struct btrfs_inode to btrfs_double_mmap_unlock() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/reflink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 2e000e96d026..f3aa3f4e9684 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -625,10 +625,10 @@ static void btrfs_double_mmap_lock(struct btrfs_inode *inode1, struct btrfs_inod
 	down_write_nested(&inode2->i_mmap_lock, SINGLE_DEPTH_NESTING);
 }
 
-static void btrfs_double_mmap_unlock(struct inode *inode1, struct inode *inode2)
+static void btrfs_double_mmap_unlock(struct btrfs_inode *inode1, struct btrfs_inode *inode2)
 {
-	up_write(&BTRFS_I(inode1)->i_mmap_lock);
-	up_write(&BTRFS_I(inode2)->i_mmap_lock);
+	up_write(&inode1->i_mmap_lock);
+	up_write(&inode2->i_mmap_lock);
 }
 
 static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
@@ -892,7 +892,7 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 	if (same_inode) {
 		btrfs_inode_unlock(BTRFS_I(src_inode), BTRFS_ILOCK_MMAP);
 	} else {
-		btrfs_double_mmap_unlock(src_inode, dst_inode);
+		btrfs_double_mmap_unlock(BTRFS_I(src_inode), BTRFS_I(dst_inode));
 		unlock_two_nondirectories(src_inode, dst_inode);
 	}
 
-- 
2.47.1


