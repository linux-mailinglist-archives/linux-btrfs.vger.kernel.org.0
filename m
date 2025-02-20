Return-Path: <linux-btrfs+bounces-11629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2958AA3D5F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1DF77AC487
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ED51F3FF5;
	Thu, 20 Feb 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VT9Cif9p";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VT9Cif9p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A91F03E6
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045710; cv=none; b=onnwgEmkwF5aEEamY7SdwBrFSirvCDBjec049l5MP9t8XsoF5KLLgDrqnLWuTf77z95riOgHsc+21chlQ22e9/LRMZqgCsmeDrAV9s15RkQpjsw6/88BR367MxmrhimDE9kh1DL7dXmRv8dti9JUNHGp0TumDc9+FeYP87o5tWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045710; c=relaxed/simple;
	bh=KTki0lLKhE3EJQwAVkFSpcCcER8jHtazyZC0X7by4ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8b69tY4VhJgF9re92G6G3dH5cQYQOOPGLeBLeJCIU7QJn+NF/rcWKzWcr1K/+YgRLwn2pRH9rlmmXSdoftmR2dKilKD2YwkcwmEiuksqwX630OKNf4vve+3qjt8pYGk8os7U49IpbMz+a92w0F3eq69GO3mdWG5yPJC67DrxF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VT9Cif9p; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VT9Cif9p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D9F91F387;
	Thu, 20 Feb 2025 10:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8UUek4OHVzxCP0M3SEcps/zwwrfqJ+3rG+LttP9/q4=;
	b=VT9Cif9pq5VKLV40FyS3bEkdT1Y0cq4U6QE3iRAZzjSoFoFAxzISRZjo2Fm9MFtc5blDdT
	O88B2DGt43VS6WRYXqvwv2JzPxbN5kpqfH3M+hXBeNCCksJGIDd+mpxM5/7qJnL6rs1OPB
	j+KxPNAzkPec63d/bqLC+6rUy1Na7ig=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8UUek4OHVzxCP0M3SEcps/zwwrfqJ+3rG+LttP9/q4=;
	b=VT9Cif9pq5VKLV40FyS3bEkdT1Y0cq4U6QE3iRAZzjSoFoFAxzISRZjo2Fm9MFtc5blDdT
	O88B2DGt43VS6WRYXqvwv2JzPxbN5kpqfH3M+hXBeNCCksJGIDd+mpxM5/7qJnL6rs1OPB
	j+KxPNAzkPec63d/bqLC+6rUy1Na7ig=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36A9B13301;
	Thu, 20 Feb 2025 10:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aoxVDYb9tmepfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:42 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 16/22] btrfs: pass struct btrfs_inode to btrfs_double_mmap_lock()
Date: Thu, 20 Feb 2025 11:01:37 +0100
Message-ID: <cce93112b5e2efa263963894c14dbd28f5f9eda7.1740045551.git.dsterba@suse.com>
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

Pass a struct btrfs_inode to btrfs_double_mmap_lock() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/reflink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 8640dbf1aefa..2e000e96d026 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -617,12 +617,12 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	return ret;
 }
 
-static void btrfs_double_mmap_lock(struct inode *inode1, struct inode *inode2)
+static void btrfs_double_mmap_lock(struct btrfs_inode *inode1, struct btrfs_inode *inode2)
 {
 	if (inode1 < inode2)
 		swap(inode1, inode2);
-	down_write(&BTRFS_I(inode1)->i_mmap_lock);
-	down_write_nested(&BTRFS_I(inode2)->i_mmap_lock, SINGLE_DEPTH_NESTING);
+	down_write(&inode1->i_mmap_lock);
+	down_write_nested(&inode2->i_mmap_lock, SINGLE_DEPTH_NESTING);
 }
 
 static void btrfs_double_mmap_unlock(struct inode *inode1, struct inode *inode2)
@@ -875,7 +875,7 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 		btrfs_inode_lock(BTRFS_I(src_inode), BTRFS_ILOCK_MMAP);
 	} else {
 		lock_two_nondirectories(src_inode, dst_inode);
-		btrfs_double_mmap_lock(src_inode, dst_inode);
+		btrfs_double_mmap_lock(BTRFS_I(src_inode), BTRFS_I(dst_inode));
 	}
 
 	ret = btrfs_remap_file_range_prep(src_file, off, dst_file, destoff,
-- 
2.47.1


