Return-Path: <linux-btrfs+bounces-12443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD1DA69CEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 00:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202F1176AC0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F0B22371F;
	Wed, 19 Mar 2025 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rvy61Sdg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rvy61Sdg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658A20C46A
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742428481; cv=none; b=gzKIJznBAwZ/erggD4aeZ30pDPh4wBiuuGeXv8D/GI5dq00VLVHUnZyfrYCfWPd1M93+J5V4gP66Se/wC3g+eWtoZMOFKESzpFskCAVgNx12DhCBCLCOowPWeaAf2igvDc2rI8oaRf3yaDEx5jArv+sVRQi2cSPHSOFn42pZBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742428481; c=relaxed/simple;
	bh=eqegAd/0VPPNeQsTlO0GGoSBlhjcGFZCp+Y4XDFnO9c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u9cOWCh1aHERGIEDKM7lUpo1jnzEG8ZMAlygoP2JTd0/40gjDxyCEfx5SXQ5cENdV8HZLLaDvjj/fmsLg1GQzdnn8BtNXdcqiufWXPydL/WYlVUOZue4mU0w3+a2DzXRb7L/ciPcQjUQ1+cLU3h+toEnUSAx1hgPd9dEpaLZMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rvy61Sdg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rvy61Sdg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 062E021B7B
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 23:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742428477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qdK59v2E9NivzOJeF45fyLr7kC2xW3K801Aw7sjt1Rw=;
	b=rvy61SdgrK7xeQLP42LS02RR2AExlH77IqbvqArHJhd9/2q2zvZVwdQWT2KG0ZjTqMbISh
	bKDRF85jAcPAOEuydUPX4mrwhYk1lCLQ3cAbnY1xzW1oHp78ntqMAl0U3VRMHDj4Aefmet
	Zva2kS/PkbAu+2Dzn8Dov4IjdNjVt7Q=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742428477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qdK59v2E9NivzOJeF45fyLr7kC2xW3K801Aw7sjt1Rw=;
	b=rvy61SdgrK7xeQLP42LS02RR2AExlH77IqbvqArHJhd9/2q2zvZVwdQWT2KG0ZjTqMbISh
	bKDRF85jAcPAOEuydUPX4mrwhYk1lCLQ3cAbnY1xzW1oHp78ntqMAl0U3VRMHDj4Aefmet
	Zva2kS/PkbAu+2Dzn8Dov4IjdNjVt7Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43DA213726
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 23:54:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JpkdAjxZ22ftWgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 23:54:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove force_page_uptodate variable from btrfs_buffered_write()
Date: Thu, 20 Mar 2025 10:24:14 +1030
Message-ID: <66698e7eb0589e818eec555abc3b04969dcb48f1.1742428450.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Commit c87c299776e4 ("btrfs: make buffered write to copy one page a
time") changed how the variable @force_page_uptodate is updated.

Before that commit the variable is only initialized to false at the
beginning of the function, and after hitting a short copy, the next
retry on the same folio will force the foilio to be read from the disk.

But after the commit, the variable is always updated to false for each
iteration, causing prepare_one_folio() never to get a true value passed
in.

The change in behavior is not a huge deal, it only makes a difference
on how we handle short copies:

Old: Allow the buffer to be split

     The first short copy will be rejected, that's the same for both
     cases.

     But for the next retry, we require the folio to be read from disk.

     Then even if we hit a short copy again, since the folio is already
     uptodate, we do not need to handle partial uptodate range, and can
     continue, marking the short copied range as dirty and continue.

     This will split the buffer write into the folio as two buffered
     writes.

New: Do not allow the buffer to be split

     The first short copy will be rejected, that's the same for both
     cases.

     For the next retry, we do nothing special, thus if the short copy
     happened again, we reject it again, until either the short copy is
     gone, or we failed to fault in the buffer.

     This will mean the buffer write into the folio will either fail or
     success, no split will happen.

To me, either solution is fine, but the newer one makes it simpler and
requires no special handling, so I prefer that solution.

And since @force_page_uptodate is always false when passed into
prepare_one_folio(), we can just remove the variable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c2648858772a..b7eb1f0164bb 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -800,7 +800,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
  * On success return a locked folio and 0
  */
 static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64 pos,
-				  u64 len, bool force_uptodate)
+				  u64 len)
 {
 	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
 	u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
@@ -810,8 +810,7 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
 	if (folio_test_uptodate(folio))
 		return 0;
 
-	if (!force_uptodate &&
-	    IS_ALIGNED(clamp_start, blocksize) &&
+	if (IS_ALIGNED(clamp_start, blocksize) &&
 	    IS_ALIGNED(clamp_end, blocksize))
 		return 0;
 
@@ -858,7 +857,7 @@ static gfp_t get_prepare_gfp_flags(struct inode *inode, bool nowait)
  */
 static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_ret,
 				      loff_t pos, size_t write_bytes,
-				      bool force_uptodate, bool nowait)
+				      bool nowait)
 {
 	unsigned long index = pos >> PAGE_SHIFT;
 	gfp_t mask = get_prepare_gfp_flags(inode, nowait);
@@ -881,7 +880,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 		folio_put(folio);
 		return ret;
 	}
-	ret = prepare_uptodate_folio(inode, folio, pos, write_bytes, force_uptodate);
+	ret = prepare_uptodate_folio(inode, folio, pos, write_bytes);
 	if (ret) {
 		/* The folio is already unlocked. */
 		folio_put(folio);
@@ -1127,7 +1126,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		size_t num_sectors;
 		struct folio *folio = NULL;
 		int extents_locked;
-		bool force_page_uptodate = false;
 
 		/*
 		 * Fault pages before locking them in prepare_one_folio()
@@ -1196,8 +1194,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		ret = prepare_one_folio(inode, &folio, pos, write_bytes,
-					force_page_uptodate, false);
+		ret = prepare_one_folio(inode, &folio, pos, write_bytes, false);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
@@ -1240,12 +1237,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 					fs_info->sectorsize);
 		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
 
-		if (copied == 0) {
-			force_page_uptodate = true;
+		if (copied == 0)
 			dirty_sectors = 0;
-		} else {
-			force_page_uptodate = false;
-		}
 
 		if (num_sectors > dirty_sectors) {
 			/* release everything except the sectors we dirtied */
-- 
2.49.0


