Return-Path: <linux-btrfs+bounces-8411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD2598CAFD
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 03:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E73628602A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 01:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD1979CC;
	Wed,  2 Oct 2024 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vYerSLtZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vYerSLtZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A86D1C2E
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833980; cv=none; b=bHnuxP1vsMtjj9H086oy81XgWudjyv5PX1RA2F67JpMsftMo1EzITBR/011kmlL/O2q//802umXOLGbWDHHyK7ZLdDB9c4BcJ3HJvGbXx0TkIlSL4JWJobulkO4CLjDNOUdoir+R2m+TpfxTOn/iMg7rpvWDxJ4KaOFw4dRkP20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833980; c=relaxed/simple;
	bh=KwGRZ+gMfN6o2j1igk3U1xrvTW1NTK7AG3klvS1jbf0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pkv4o+SZ7Csm21gidzm+Qlajd3XKfljDvC616Gji2pab78+dyligCNXyxi2l00WyKJXmeIR/K7FfcExnUkk9q+LXeaKBhFQENX3Y+V1vofVo+WSEF+BjISXSxVkK16fhzkBD0uBR4MGIAQmqEK74I+zkRtA5alRizSz+gvhkeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vYerSLtZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vYerSLtZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3CE5F21B21
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 01:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727833976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ly2St8D3D8LmK0KSBZA9nScXIubsJ+pwmXoFlUlzaY=;
	b=vYerSLtZjg/tXNOiPPCJ312y3ap+TjcDQkp3oPY0osuu1BSji5IJM2ZuKL/C4X8N/+T7og
	VIj92+8RtYtkGkDYTnD75ziUb2oq7M8/xGWpT7KGBcUmJNdmyxkwLxXf/YPQ256t56ODbF
	AJkv0NxT4QVwVE3z6/NNMvEhSDffzAE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=vYerSLtZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727833976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ly2St8D3D8LmK0KSBZA9nScXIubsJ+pwmXoFlUlzaY=;
	b=vYerSLtZjg/tXNOiPPCJ312y3ap+TjcDQkp3oPY0osuu1BSji5IJM2ZuKL/C4X8N/+T7og
	VIj92+8RtYtkGkDYTnD75ziUb2oq7M8/xGWpT7KGBcUmJNdmyxkwLxXf/YPQ256t56ODbF
	AJkv0NxT4QVwVE3z6/NNMvEhSDffzAE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E71813A51
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 01:52:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yEF3C3en/GaHVAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2024 01:52:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: allow buffered write to skip full page if it's sector aligned
Date: Wed,  2 Oct 2024 11:22:34 +0930
Message-ID: <ac2639ec4e9ac176d33e95ef7ecf008fa6be5461.1727833878.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727833878.git.wqu@suse.com>
References: <cover.1727833878.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CE5F21B21
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG]
Since the support of sector size < page size for btrfs, test case
generic/563 fails with 4K sector size and 64K page size:

    --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
    +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-09-30 09:09:16.155312379 +0930
    @@ -3,7 +3,8 @@
     read is in range
     write is in range
     write -> read/write
    -read is in range
    +read has value of 8388608
    +read is NOT in range -33792 .. 33792
     write is in range
    ...

[CAUSE]
The test case creates a 8MiB file, then buffered write into the 8MiB
using 4K block size, to overwrite the whole file.

On 4K page sized systems, since the write range covers the full sector and
page, btrfs will no bother reading the page, just like what XFS and EXT4
do.

But 64K page sized systems, although the write is sector aligned, it's
not page aligned, thus btrfs still goes the full page alignment check,
and read the full page out.

This causes extra data read, and fail the test case.

[FIX]
To skip the full page read, we need to do the following modification:

- Do not trigger full page read as long as the buffered write is sector
  aligned
  This is pretty simple by modifying the check inside
  prepare_uptodate_page().

- Skip already uptodate sectors during full page read
  Or we can lead to the following data corruption:

  0       32K        64K
  |///////|          |

  Where the file range [0, 32K) is dirtied by buffered write, the
  remaining range [32K, 64K) is not.

  When reading the full page, since [0,32K) is only dirtied but not
  written back, there is no data extent map for it, but a hole covering
  [0, 64k).

  If we continue reading the full page range [0, 64K), the dirtied range
  will be filled with 0 (since there is only a hole covering the whole
  range).
  This causes the dirtied range to get lost.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 6 ++++++
 fs/btrfs/file.c      | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 09eb8a204375..ea118c89e365 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -981,6 +981,12 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			end_folio_read(folio, true, cur, end - cur + 1);
 			break;
 		}
+
+		if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
+			end_folio_read(folio, true, cur, blocksize);
+			continue;
+		}
+
 		em = __get_extent_map(inode, folio, cur, end - cur + 1,
 				      em_cached);
 		if (IS_ERR(em)) {
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fe4c3b31447a..64e28ebd2d0b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -860,6 +860,7 @@ static int prepare_uptodate_page(struct inode *inode,
 				 struct page *page, u64 pos,
 				 u64 len, bool force_uptodate)
 {
+	const u32 sectorsize = inode_to_fs_info(inode)->sectorsize;
 	struct folio *folio = page_folio(page);
 	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
 	u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
@@ -869,8 +870,8 @@ static int prepare_uptodate_page(struct inode *inode,
 		return 0;
 
 	if (!force_uptodate &&
-	    IS_ALIGNED(clamp_start, PAGE_SIZE) &&
-	    IS_ALIGNED(clamp_end, PAGE_SIZE))
+	    IS_ALIGNED(clamp_start, sectorsize) &&
+	    IS_ALIGNED(clamp_end, sectorsize))
 		return 0;
 
 	ret = btrfs_read_folio(NULL, folio);
-- 
2.46.2


