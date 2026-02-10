Return-Path: <linux-btrfs+bounces-21578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJhOJi6uimkKNAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21578-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 05:03:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B54116D42
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 05:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 377ED301AF40
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 04:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD355283C89;
	Tue, 10 Feb 2026 04:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OARCZfiA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OARCZfiA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EEB2F851
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770696213; cv=none; b=rRUvIA/olrnsSfyXopCgMF7UoCHBR7PiL7TN1Ld/9I/pUhcHGNEQQbffNw8EdI/xy1BYyTfdIiWKKfqPQnz2qrzsNU5MjzUJEX0AvizjHfSFqM0VcXRZKRzM7TKiCYPCMzijpZwYN7nwgHZ4ghaDCIVJpTheCLJQinNVp2CCjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770696213; c=relaxed/simple;
	bh=2ExzDZZYsrkoTtLzGfSA7K4Uw+78sesGf8sBPgJfuRs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0nq6efqkKSDM99+EHrUCpziOO/Otof8otWXFMHjQ0PYxysdz4C2HGZ3Lg9vrcqyHIJvS4jJuO5lBmWhl1SQvURgp+qArg0H1DtelNA6TACsYQxucL+ryC6guRvR1YuHKp9kzSrpBnA5m9zwEDo2QCBoZR76SRCc0istH+ARmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OARCZfiA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OARCZfiA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7886A3E70F
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770696201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3NhwQndkmdfqxax3f5s228qtnyOuOAzmmANC+M5r0pg=;
	b=OARCZfiArwi/1jpKpxT+We9lt1jsU8g+EDRGJ+XQTKcW3y3FXJeM9CDW3SGT9lCIkmM+pp
	A+aBZmy5aFiqPNn9ORD+gBa8TFKI2UrwzM6f8WOq7yN9JOqxjBVO+skUmF7zzk3TGLBPT+
	6z3Y22JNzKFV9gxckdyOdNtP2pl3BIE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OARCZfiA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770696201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3NhwQndkmdfqxax3f5s228qtnyOuOAzmmANC+M5r0pg=;
	b=OARCZfiArwi/1jpKpxT+We9lt1jsU8g+EDRGJ+XQTKcW3y3FXJeM9CDW3SGT9lCIkmM+pp
	A+aBZmy5aFiqPNn9ORD+gBa8TFKI2UrwzM6f8WOq7yN9JOqxjBVO+skUmF7zzk3TGLBPT+
	6z3Y22JNzKFV9gxckdyOdNtP2pl3BIE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68E0D3EA62
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UPupBQiuimm/bwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: move larger data folios out of experimental features
Date: Tue, 10 Feb 2026 14:32:58 +1030
Message-ID: <f93d153fcf09125c407f25f2d81e6a9cad1506b7.1770695952.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770695952.git.wqu@suse.com>
References: <cover.1770695952.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21578-lists,linux-btrfs=lfdr.de];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 44B54116D42
X-Rspamd-Action: no action

This feature is introduced in v6.17 under experimental, and we had
several small bugs related or exposed by that feature:

 e9e3b22ddfa7 ("btrfs: fix beyond-EOF write handling")
 18de34daa7c6 ("btrfs: truncate ordered extent when skipping writeback past i_size")

Otherwise the feature is being frequently tested by btrfs developers.

The latest fix only arrived in v6.19, after two releases I think it's time
to move this feature out of experimental.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Kconfig       | 2 +-
 fs/btrfs/btrfs_inode.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 5e75438e0b73..d0451cf93849 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -110,7 +110,7 @@ config BTRFS_EXPERIMENTAL
 
 	  - extent tree v2 - complex rework of extent tracking
 
-	  - large folio and block size (> page size) support
+	  - large block size (> page size) support
 
 	  - asynchronous checksum generation for data writes
 
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 73602ee8de3f..9a9d7651d74e 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -536,11 +536,9 @@ static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
 	ASSERT(is_data_inode(inode));
 
 	/* We only allow BITS_PER_LONGS blocks for each bitmap. */
-#ifdef CONFIG_BTRFS_EXPERIMENTAL
 	mapping_set_folio_order_range(inode->vfs_inode.i_mapping,
 				      inode->root->fs_info->block_min_order,
 				      inode->root->fs_info->block_max_order);
-#endif
 }
 
 void btrfs_calculate_block_csum_folio(struct btrfs_fs_info *fs_info,
-- 
2.52.0


