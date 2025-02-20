Return-Path: <linux-btrfs+bounces-11627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F54BA3D5F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54F47AC3C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11621F0E38;
	Thu, 20 Feb 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cBXro5G/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cBXro5G/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C21EF0BA
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045704; cv=none; b=Nhy1nC2zvoZUSKEgGcW6GKQG3rDRriTB+SncIGCfbsC/8xx2mDkZvFo3a8qXYcVCZXMPTYKCyB/0SoWdns+F5EVQS3ckAP4GEwoZMnZk7NRUir6Si9xWMlqO6JoiM/RQ4ZznMIjqGNnuPhF7tQE35Mp5Q2Fy799bxf/PoDZNol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045704; c=relaxed/simple;
	bh=pwrE+MtHGnKFI65MIA9uWFahAlPX7Z+CAnT/qMWXK/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anljz4DymVpHjfXnrd7Bcx2sDIP/jBuHJtuCVUEos5iKWc45/Vgs23fkWfmqxmxrBraCP1Fbhi3YxWwkQl+K/BM1+bieLMO9gf0zNSjip8XCAHFqskJtBW2Y1YM3qFvXj8tsdonzoYUCalZrwAnzKrhkH7Vr+hZNrgln3Aapuic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cBXro5G/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cBXro5G/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1581F388;
	Thu, 20 Feb 2025 10:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ7Mrfq6glY7GxB36VTRUdRWERLCfZikLLEstiSgdiw=;
	b=cBXro5G/muDGenDFzx2kO67CWMXGP1uWcDeUZU4QU0D7pqiAOMCucdsAKExIqpED/8Z6nN
	DC2r0mut3gpkgXW9xn2uI1xpga1yIXHB7F09oy6W5B/dqqa+PVqtjhUWAcLKYW23oi55HE
	CrUF+AWytXMCi+AR3Zi/qTq5uNt2LKs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="cBXro5G/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ7Mrfq6glY7GxB36VTRUdRWERLCfZikLLEstiSgdiw=;
	b=cBXro5G/muDGenDFzx2kO67CWMXGP1uWcDeUZU4QU0D7pqiAOMCucdsAKExIqpED/8Z6nN
	DC2r0mut3gpkgXW9xn2uI1xpga1yIXHB7F09oy6W5B/dqqa+PVqtjhUWAcLKYW23oi55HE
	CrUF+AWytXMCi+AR3Zi/qTq5uNt2LKs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 645D213301;
	Thu, 20 Feb 2025 10:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gumAGH39tmeTfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:33 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 14/22] btrfs: props: switch prop_handler::extract to struct btrfs_inode
Date: Thu, 20 Feb 2025 11:01:33 +0100
Message-ID: <78b2aa0a1ccc8933dae251c19bec57b39b445db8.1740045551.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 6C1581F388
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Pass a struct btrfs_inode to the extract() callback as it's an internal
interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/props.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 10af7088e7ab..adc956432d2f 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -27,7 +27,7 @@ struct prop_handler {
 	int (*validate)(const struct btrfs_inode *inode, const char *value,
 			size_t len);
 	int (*apply)(struct btrfs_inode *inode, const char *value, size_t len);
-	const char *(*extract)(const struct inode *inode);
+	const char *(*extract)(const struct btrfs_inode *inode);
 	bool (*ignore)(const struct btrfs_inode *inode);
 	int inheritable;
 };
@@ -360,13 +360,13 @@ static bool prop_compression_ignore(const struct btrfs_inode *inode)
 	return false;
 }
 
-static const char *prop_compression_extract(const struct inode *inode)
+static const char *prop_compression_extract(const struct btrfs_inode *inode)
 {
-	switch (BTRFS_I(inode)->prop_compress) {
+	switch (inode->prop_compress) {
 	case BTRFS_COMPRESS_ZLIB:
 	case BTRFS_COMPRESS_LZO:
 	case BTRFS_COMPRESS_ZSTD:
-		return btrfs_compress_type2str(BTRFS_I(inode)->prop_compress);
+		return btrfs_compress_type2str(inode->prop_compress);
 	default:
 		break;
 	}
@@ -409,7 +409,7 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 		if (h->ignore(inode))
 			continue;
 
-		value = h->extract(&parent->vfs_inode);
+		value = h->extract(parent);
 		if (!value)
 			continue;
 
-- 
2.47.1


