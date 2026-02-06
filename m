Return-Path: <linux-btrfs+bounces-21434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHApGMk1hmlrLAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21434-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 19:41:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4A11021EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 19:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CF19307FC3A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Feb 2026 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082EC42EEAD;
	Fri,  6 Feb 2026 18:24:58 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA942E012
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770402297; cv=none; b=dP5OmH0eF8jd2Sk+0VGYze/34Fuzotn55jD+BxXHC2g8Hfpa+TSutGWlKWu3NccZ5+RKz/RP8KCJ/OnuVi9++ZH5q7N4GjCcazNzdqqnbbqSHmD5TvwJDq7cfPujUKlM8Pa3hlVvq3jvcUk1SlX1+y1zOPE0evPt6fgfmgkaz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770402297; c=relaxed/simple;
	bh=1N45I4EjeGu3+jI4xIHB8eeIS3TKCNO30iA+sKwN9Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiV4A7aH9VYONWUdhmSKIW5bxxu85mHRQHmer3MB1qklTn6Rs5Yh8diug0p0hImyCtrQa2RN99ugUsB/cAG2G2T+Ri6vr/4joS2MNByOrTg3BjRcuDouF7NJeH1298os3+5haPUffvD3AeKoaFSRb5RMUUCU7f5OJm9lEvwu4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6EAF63E743;
	Fri,  6 Feb 2026 18:24:11 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4390A3EA63;
	Fri,  6 Feb 2026 18:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cJHfD8sxhmkTCQAAD6G6ig
	(envelope-from <neelx@suse.com>); Fri, 06 Feb 2026 18:24:11 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Sterba <dsterba@suse.com>
Cc: linux-block@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>,
	linux-fscrypt@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 27/43] btrfs: setup fscrypt_extent_info for new extents
Date: Fri,  6 Feb 2026 19:22:59 +0100
Message-ID: <20260206182336.1397715-28-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206182336.1397715-1-neelx@suse.com>
References: <20260206182336.1397715-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[suse.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21434-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: BD4A11021EF
X-Rspamd-Action: no action

From: Josef Bacik <josef@toxicpanda.com>

New extents for encrypted inodes must have a fscrypt_extent_info, which
has the necessary keys and does all the registration at the block layer
for them.  This is passed through all of the infrastructure we've
previously added to make sure the context gets saved properly with the
file extents.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Daniel Vacek <neelx@suse.com>
---

v5: https://lore.kernel.org/linux-btrfs/d8ab016d25f70c9365f508af1d8e0b9ab7c09d76.1706116485.git.josef@toxicpanda.com/
 * No changes since.
---
 fs/btrfs/inode.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 15191dffa354..de1989edffc1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7629,6 +7629,16 @@ struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 start,
 	if (file_extent->fscrypt_info) {
 		btrfs_extent_map_set_encryption(em, BTRFS_ENCRYPTION_FSCRYPT);
 		em->fscrypt_info = fscrypt_get_extent_info(file_extent->fscrypt_info);
+	} else if (IS_ENCRYPTED(&inode->vfs_inode)) {
+		struct fscrypt_extent_info *fscrypt_info;
+
+		btrfs_extent_map_set_encryption(em, BTRFS_ENCRYPTION_FSCRYPT);
+		fscrypt_info = fscrypt_prepare_new_extent(&inode->vfs_inode);
+		if (IS_ERR(fscrypt_info)) {
+			btrfs_free_extent_map(em);
+			return ERR_CAST(fscrypt_info);
+		}
+		em->fscrypt_info = fscrypt_info;
 	} else {
 		btrfs_extent_map_set_encryption(em, BTRFS_ENCRYPTION_NONE);
 	}
@@ -9348,6 +9358,9 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 	if (trans)
 		own_trans = false;
 	while (num_bytes > 0) {
+		struct fscrypt_extent_info *fscrypt_info = NULL;
+		int encryption_type = BTRFS_ENCRYPTION_NONE;
+
 		cur_bytes = min_t(u64, num_bytes, SZ_256M);
 		cur_bytes = max(cur_bytes, min_size);
 		/*
@@ -9362,6 +9375,17 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		if (ret)
 			break;
 
+		if (IS_ENCRYPTED(inode)) {
+			fscrypt_info = fscrypt_prepare_new_extent(inode);
+			if (IS_ERR(fscrypt_info)) {
+				btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+				btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 0);
+				ret = PTR_ERR(fscrypt_info);
+				break;
+			}
+			encryption_type = BTRFS_ENCRYPTION_FSCRYPT;
+		}
+
 		/*
 		 * We've reserved this space, and thus converted it from
 		 * ->bytes_may_use to ->bytes_reserved.  Any error that happens
@@ -9373,7 +9397,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		last_alloc = ins.offset;
 		trans = insert_prealloc_file_extent(trans, BTRFS_I(inode),
-						    &ins, NULL, cur_offset);
+						    &ins, fscrypt_info, cur_offset);
 		/*
 		 * Now that we inserted the prealloc extent we can finally
 		 * decrement the number of reservations in the block group.
@@ -9383,6 +9407,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
+			fscrypt_put_extent_info(fscrypt_info);
 			btrfs_free_reserved_extent(fs_info, ins.objectid,
 						   ins.offset, false);
 			break;
@@ -9390,6 +9415,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		em = btrfs_alloc_extent_map();
 		if (!em) {
+			fscrypt_put_extent_info(fscrypt_info);
 			btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
 					    cur_offset + ins.offset - 1, false);
 			btrfs_set_inode_full_sync(BTRFS_I(inode));
@@ -9404,6 +9430,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->ram_bytes = ins.offset;
 		em->flags |= EXTENT_FLAG_PREALLOC;
 		em->generation = trans->transid;
+		em->fscrypt_info = fscrypt_info;
+		btrfs_extent_map_set_encryption(em, encryption_type);
 
 		ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, true);
 		btrfs_free_extent_map(em);
-- 
2.51.0


