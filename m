Return-Path: <linux-btrfs+bounces-22284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBSUMHoArmnF+gEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22284-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 00:04:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CDC2329B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 00:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A43F3032F73
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2026 23:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E5E34C816;
	Sun,  8 Mar 2026 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TSizcgCt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TSizcgCt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F0355F4B
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011019; cv=none; b=fNam5jgAXuxwQR+BgHy/clkKVW2d1Ekuiby/zUyfiegKMNSxyU5doDndb3U+3OCd8FHc+2/NnB6Y/atBJpkpx3KeCykzMFgnDju+DUtiw5EH8N3G2aQVr7atbfTLGuTDLlxzlOfmNO12VLbfiMU9gzoMMqbU9fV84zGiQtNxuXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011019; c=relaxed/simple;
	bh=UCF9eynisJVZ3iokdxE76ZkAWeE0lUbZb58TC1eqvfo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXXOiovvw5uBTgzlD3bVwrcONh/eNfqwMGoE2u1Y5jUh9PMC9kCcPw5e5dB7DKMAoGltI9Nae5Nxk3th7W+2W43XV9dJoZUNCklgc4wmkMkpkObdmtZIQvFeguOo8zlrtuAJgAmRMC/Nd6r9z3eTfCLAHjJ6TW6c/MXmI24t/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TSizcgCt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TSizcgCt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08FE85BE0E
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773011002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqPaWOZaC2zWmLymDfa9XcM0h8MK5Pgw5+Dy4XC+arw=;
	b=TSizcgCtdcbRpizc3a6J3Oyay9lAjfQ3d8g9Up6l+wx5uqDY5GHktxysbTPr4DAdVG2kn8
	Y4CE31LUaX5aK1vE/xRuybH7F5WUhcM54sKzb0CAcDXbaZOhk4u8KdWNneAysf6paNekJw
	M5dx1zEXFo3hRvJ3onuPiBS0J/vImQU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773011002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqPaWOZaC2zWmLymDfa9XcM0h8MK5Pgw5+Dy4XC+arw=;
	b=TSizcgCtdcbRpizc3a6J3Oyay9lAjfQ3d8g9Up6l+wx5uqDY5GHktxysbTPr4DAdVG2kn8
	Y4CE31LUaX5aK1vE/xRuybH7F5WUhcM54sKzb0CAcDXbaZOhk4u8KdWNneAysf6paNekJw
	M5dx1zEXFo3hRvJ3onuPiBS0J/vImQU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 472773EBA8
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OKreAjkArmkNbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 08 Mar 2026 23:03:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 3/6] btrfs: introduce the skeleton of delayed bbio endio function
Date: Mon,  9 Mar 2026 09:32:52 +1030
Message-ID: <a22ee5d09bd6e895fdd50cf6c7ddad4866cc365f.1773009120.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773009120.git.wqu@suse.com>
References: <cover.1773009120.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 28CDC2329B7
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
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22284-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

A delayed bbio will not be directly submitted, but queued into a
workqueue, doing the heavy lifting compression there.

The compression and uncompressed fallback are not implemented in this
patch.

Only the main endio function and helper to queue workload into a
workqueue is implemented.

The endio function is mostly the same as end_bbio_data_write(), except
the extra memory allocation/freeing for the bbio->private.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 67 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4876c136f819..bee38419fe0f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -97,6 +97,12 @@ struct data_reloc_warn {
 	int mirror_num;
 };
 
+struct delayed_bio_private {
+	struct work_struct work;
+	struct btrfs_bio *delayed_bbio;
+	atomic_t pending_ios;
+};
+
 /*
  * For the file_extent_tree, we want to hold the inode lock when we lookup and
  * update the disk_i_size, but lockdep will complain because our io_tree we hold
@@ -7647,18 +7653,71 @@ struct extent_map *btrfs_create_delayed_em(struct btrfs_inode *inode,
 	return em;
 }
 
-void btrfs_submit_delayed_write(struct btrfs_bio *bbio)
+static void run_delayed_bbio(struct work_struct *work)
 {
-	ASSERT(bbio->is_delayed);
+	struct delayed_bio_private *dbp = container_of(work, struct delayed_bio_private, work);
+	struct btrfs_bio *parent = dbp->delayed_bbio;
 
 	/*
-	 * Not yet implemented, and should not hit this path as we have no
-	 * caller to create delayed extent map.
+	 * Increase the pending_ios so that parent bbio won't end
+	 * until all child ones are submitted.
 	 */
+	atomic_inc(&dbp->pending_ios);
+	/* Compressed and uncompressed fallback is not yet implemented. */
 	ASSERT(0);
+	if (atomic_dec_and_test(&dbp->pending_ios))
+		btrfs_bio_end_io(parent, parent->status);
+}
+
+static void end_bbio_delayed(struct btrfs_bio *bbio)
+{
+	struct delayed_bio_private *dbp = bbio->private;
+	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct folio_iter fi;
+	const u32 bio_size = bio_get_size(&bbio->bio);
+	const bool uptodate = bbio->status == BLK_STS_OK;
+
+	ASSERT(bbio->is_delayed);
+
+	bio_for_each_folio_all(fi, &bbio->bio) {
+		u64 start = folio_pos(fi.folio) + fi.offset;
+		u32 len = fi.length;
+
+		btrfs_folio_clear_writeback(fs_info, fi.folio, start, len);
+	}
+	btrfs_mark_ordered_io_finished(inode, bbio->file_offset, bio_size, uptodate);
+	kfree(dbp);
 	bio_put(&bbio->bio);
 }
 
+void btrfs_submit_delayed_write(struct btrfs_bio *bbio)
+{
+	struct delayed_bio_private *dbp;
+
+	ASSERT(bbio->is_delayed);
+
+	bbio->end_io = end_bbio_delayed;
+	dbp = kzalloc(sizeof(struct delayed_bio_private), GFP_NOFS);
+	if (!dbp) {
+		btrfs_bio_end_io(bbio, errno_to_blk_status(-ENOMEM));
+		return;
+	}
+	atomic_set(&dbp->pending_ios, 0);
+	dbp->delayed_bbio = bbio;
+	bbio->private = dbp;
+	/*
+	 * TODO: find a way to properly allow sequential extent allocation.
+	 *
+	 * The existing btrfs async workqueue will execute the sequential workload
+	 * twice, the second one to free the structure.
+	 * But our current submission path can only be called once, after that
+	 * the bbio will be gone thus can not afford to use btrfs async workqueue.
+	 */
+	INIT_WORK(&dbp->work, run_delayed_bbio);
+	schedule_work(&dbp->work);
+}
+
 /*
  * For release_folio() and invalidate_folio() we have a race window where
  * folio_end_writeback() is called but the subpage spinlock is not yet released.
-- 
2.53.0


