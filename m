Return-Path: <linux-btrfs+bounces-7615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7A96279C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 14:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AB01C23A39
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 12:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83C3184114;
	Wed, 28 Aug 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EzPi4Oju";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZBA4dWXg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EzPi4Oju";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZBA4dWXg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9F17BEBD
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849167; cv=none; b=MW7hW2Vl8YV89/Wk7z8co3p42yLHQRgGc65AsWcq46riqapu0LndLEDScw+rS1cT+x6X2kuacBKNi39xJDUVEwIAKiaw4G3orTSQU5nhRnDR3LVobNVZ95Q7S5hySlvnK118Fq4v3IJ1+IM63jE69dI6b2qACOI9uTc0ZNcHBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849167; c=relaxed/simple;
	bh=03ARXyd4Tv3gpGaPXHZrnvmgNTPQGpElvqXa/CZEQes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srrfn7NOO2WeNWVC14kOb5jGL0tG+WSwt/auaX2dc0Nl1mWaFlPN/mxqZKWZzNoq3/fGWqVGO8QKRlEsO9W6Y0QjE7el0f7tSRZU9X2qsWSRoJnHE4J7vOlpPTNVUtYCDdLzAx8iaQ2/pzIiGuHaCZG0yRR5yOd/JU7j44xixeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EzPi4Oju; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZBA4dWXg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EzPi4Oju; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZBA4dWXg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66FBB1FC24;
	Wed, 28 Aug 2024 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724849164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auSG0LUQdGkwrh9MT1KoDQJhX6+dLnR0kQ4Drmha41Y=;
	b=EzPi4OjulCKzBDmOXalOEC38uhm3fjS072k6G8rVJpoCKFPjnEWHIeEtN4IyhlT/91nPhx
	HGhygwjrvtp/lbJsBPORbpag4WB02Dk/fgSdFDaQ8SAEA8wohv5zkZb54TAYC6AtL1Qt2O
	StNUAEdyMiO60OYxsydsjVv4GYxYSrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724849164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auSG0LUQdGkwrh9MT1KoDQJhX6+dLnR0kQ4Drmha41Y=;
	b=ZBA4dWXgyDingo4V9WcJGOe4wQECAuSze+gEwbzhGoNWuSmi3W8/NgrDA6nc3ou3XhStHc
	Z9Ihl428r3H3CYBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EzPi4Oju;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZBA4dWXg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724849164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auSG0LUQdGkwrh9MT1KoDQJhX6+dLnR0kQ4Drmha41Y=;
	b=EzPi4OjulCKzBDmOXalOEC38uhm3fjS072k6G8rVJpoCKFPjnEWHIeEtN4IyhlT/91nPhx
	HGhygwjrvtp/lbJsBPORbpag4WB02Dk/fgSdFDaQ8SAEA8wohv5zkZb54TAYC6AtL1Qt2O
	StNUAEdyMiO60OYxsydsjVv4GYxYSrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724849164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auSG0LUQdGkwrh9MT1KoDQJhX6+dLnR0kQ4Drmha41Y=;
	b=ZBA4dWXgyDingo4V9WcJGOe4wQECAuSze+gEwbzhGoNWuSmi3W8/NgrDA6nc3ou3XhStHc
	Z9Ihl428r3H3CYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27304138D2;
	Wed, 28 Aug 2024 12:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jt66Awwcz2YNGQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 28 Aug 2024 12:46:04 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/2] btrfs: reduce scope of extent locks during buffered write
Date: Wed, 28 Aug 2024 08:45:50 -0400
Message-ID: <f50af2f3cbcfc390265a09ac1962a8afb1b5c22d.1724847323.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724847323.git.rgoldwyn@suse.com>
References: <cover.1724847323.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66FBB1FC24
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reduce the scope of locking while performing writes. The scope is
limited to changing extent bits, which is in btrfs_dirty_pages().
btrfs_dirty_pages() is also called from __btrfs_write_out_cache(), and
it expects extent locks held. So, perform extent locking around
btrfs_dirty_pages() only.

The inode lock will insure that no other process is writing to this
file, so we don't need to worry about multiple processes dirtying
folios.

However, the write has to make sure that there are no ordered extents in
the range specified. So, call btrfs_wait_ordered_range() before
initiating the write. In case of nowait, bail if there exists an
ordered range within the write range.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 109 +++++++-----------------------------------------
 1 file changed, 16 insertions(+), 93 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 76f4cc686af9..6c5f712bfa0f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -976,83 +976,6 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 
 }
 
-/*
- * This function locks the extent and properly waits for data=ordered extents
- * to finish before allowing the pages to be modified if need.
- *
- * The return value:
- * 1 - the extent is locked
- * 0 - the extent is not locked, and everything is OK
- * -EAGAIN - need re-prepare the pages
- * the other < 0 number - Something wrong happens
- */
-static noinline int
-lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
-				size_t num_pages, loff_t pos,
-				size_t write_bytes,
-				u64 *lockstart, u64 *lockend, bool nowait,
-				struct extent_state **cached_state)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u64 start_pos;
-	u64 last_pos;
-	int i;
-	int ret = 0;
-
-	start_pos = round_down(pos, fs_info->sectorsize);
-	last_pos = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
-
-	if (start_pos < inode->vfs_inode.i_size) {
-		struct btrfs_ordered_extent *ordered;
-
-		if (nowait) {
-			if (!try_lock_extent(&inode->io_tree, start_pos, last_pos,
-					     cached_state)) {
-				for (i = 0; i < num_pages; i++) {
-					unlock_page(pages[i]);
-					put_page(pages[i]);
-					pages[i] = NULL;
-				}
-
-				return -EAGAIN;
-			}
-		} else {
-			lock_extent(&inode->io_tree, start_pos, last_pos, cached_state);
-		}
-
-		ordered = btrfs_lookup_ordered_range(inode, start_pos,
-						     last_pos - start_pos + 1);
-		if (ordered &&
-		    ordered->file_offset + ordered->num_bytes > start_pos &&
-		    ordered->file_offset <= last_pos) {
-			unlock_extent(&inode->io_tree, start_pos, last_pos,
-				      cached_state);
-			for (i = 0; i < num_pages; i++) {
-				unlock_page(pages[i]);
-				put_page(pages[i]);
-			}
-			btrfs_start_ordered_extent(ordered);
-			btrfs_put_ordered_extent(ordered);
-			return -EAGAIN;
-		}
-		if (ordered)
-			btrfs_put_ordered_extent(ordered);
-
-		*lockstart = start_pos;
-		*lockend = last_pos;
-		ret = 1;
-	}
-
-	/*
-	 * We should be called after prepare_pages() which should have locked
-	 * all pages in the range.
-	 */
-	for (i = 0; i < num_pages; i++)
-		WARN_ON(!PageLocked(pages[i]));
-
-	return ret;
-}
-
 /*
  * Check if we can do nocow write into the range [@pos, @pos + @write_bytes)
  *
@@ -1246,7 +1169,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		size_t copied;
 		size_t dirty_sectors;
 		size_t num_sectors;
-		int extents_locked;
+		int extents_locked = false;
 
 		/*
 		 * Fault pages before locking them in prepare_pages
@@ -1310,13 +1233,19 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		}
 
 		release_bytes = reserve_bytes;
-again:
 		ret = balance_dirty_pages_ratelimited_flags(inode->i_mapping, bdp_flags);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
 			break;
 		}
 
+		if (nowait && !btrfs_has_ordered_extent(BTRFS_I(inode), pos, write_bytes)) {
+			btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
+			break;
+		} else {
+			btrfs_wait_ordered_range(BTRFS_I(inode), pos, write_bytes);
+		}
+
 		/*
 		 * This is going to setup the pages array with the number of
 		 * pages we want, so we don't really need to worry about the
@@ -1330,20 +1259,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		extents_locked = lock_and_cleanup_extent_if_need(
-				BTRFS_I(inode), pages,
-				num_pages, pos, write_bytes, &lockstart,
-				&lockend, nowait, &cached_state);
-		if (extents_locked < 0) {
-			if (!nowait && extents_locked == -EAGAIN)
-				goto again;
-
-			btrfs_delalloc_release_extents(BTRFS_I(inode),
-						       reserve_bytes);
-			ret = extents_locked;
-			break;
-		}
-
 		copied = btrfs_copy_from_user(pos, write_bytes, pages, i);
 
 		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
@@ -1389,6 +1304,14 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		release_bytes = round_up(copied + sector_offset,
 					fs_info->sectorsize);
 
+		if (pos < inode->i_size) {
+			lockstart = round_down(pos, fs_info->sectorsize);
+			lockend = round_up(pos + copied, fs_info->sectorsize);
+			lock_extent(&BTRFS_I(inode)->io_tree, lockstart,
+				      lockend, &cached_state);
+			extents_locked = true;
+		}
+
 		ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
 					dirty_pages, pos, copied,
 					&cached_state, only_release_metadata);
-- 
2.46.0


