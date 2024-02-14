Return-Path: <linux-btrfs+bounces-2366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02EA8541E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 05:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49971C22D72
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 04:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C210BE62;
	Wed, 14 Feb 2024 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mHgnVYk9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mHgnVYk9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1C1B673
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707883485; cv=none; b=PFUgc1VADYaFn38yl9+v6vQaH/aDBaN19WCH1VV5M13BP+lgGpzKaba95GjHMD4+CcoHHELzCZN+u7WLRqMvIo6AKa0QZzJG4RqprUv2xI7urqraOqtGgrftskyhFvcmJyJnveqF5JhrVmM4Or0iC/k6gi5muDUTf8YA+ogq/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707883485; c=relaxed/simple;
	bh=ykvJx2gvC4wyHped6ejTnTBtgeqPyolwns/56+dJ6Sk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dReS0UWrowYl1+ywjUZ7sy7W5HLzQnKxqqElrh5v8hvNxcUqH0fCjTi4B9QgzCjrFfEDVlsJ4b9TvDu2dpeylFSexqlHNG4SSadpPD0s+gxGQaFLdWPU6/SEjnKdeX+K0/iaQWRvOz80HW26jNSxomBLU32Lv4TSJA45bpDHouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mHgnVYk9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mHgnVYk9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CCD321C22
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707883481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBNvps2s8XWEkP3TXEzkkv9LjnXIsPghG4eXbM1KEqg=;
	b=mHgnVYk9x/oNbXRhPTefCavII0uPc8nQGDG6oCIDH7KwyQ161ce7C9/VNX+gWSukqw1Fy3
	PZBaKGRqT9x81sMxNjtgzGI90iUVNATa0qxhnPr0fy4Fu62gDWgRiY5YcElr5zvrIAO1K+
	PEkH1qn0plMh9eGchJso4gkYKFY1QnM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707883481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBNvps2s8XWEkP3TXEzkkv9LjnXIsPghG4eXbM1KEqg=;
	b=mHgnVYk9x/oNbXRhPTefCavII0uPc8nQGDG6oCIDH7KwyQ161ce7C9/VNX+gWSukqw1Fy3
	PZBaKGRqT9x81sMxNjtgzGI90iUVNATa0qxhnPr0fy4Fu62gDWgRiY5YcElr5zvrIAO1K+
	PEkH1qn0plMh9eGchJso4gkYKFY1QnM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5534D1329E
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EMfrBdg7zGVDDAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: unexport btrfs_subpage_start_writer() and btrfs_subpage_end_and_test_writer()
Date: Wed, 14 Feb 2024 14:34:34 +1030
Message-ID: <b5c3c451748d8d92b3d08c537d7c4d5fd716076f.1707883446.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <cover.1707883446.git.wqu@suse.com>
References: <cover.1707883446.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mHgnVYk9
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: 2CCD321C22
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

Both functions are introduced in commit 1e1de38792e0 ("btrfs: make
process_one_page() to handle subpage locking"), but they are never
utilized out of subpage code.

So just unexport them.

Fixes: 1e1de38792e0 ("btrfs: make process_one_page() to handle subpage locking")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 8 ++++----
 fs/btrfs/subpage.h | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 0e49dab8dad2..24f8be565a61 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -290,8 +290,8 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 			     orig_start + orig_len) - *start;
 }
 
-void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
-				struct folio *folio, u64 start, u32 len)
+static void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
+				       struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int nbits = (len >> fs_info->sectorsize_bits);
@@ -304,8 +304,8 @@ void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
 	ASSERT(ret == nbits);
 }
 
-bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
-				       struct folio *folio, u64 start, u32 len)
+static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
+					      struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int nbits = (len >> fs_info->sectorsize_bits);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 55fc42db707e..97ba2c100b0b 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -98,10 +98,6 @@ void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
 void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
 			      struct folio *folio, u64 start, u32 len);
 
-void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
-				struct folio *folio, u64 start, u32 len);
-bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
-				       struct folio *folio, u64 start, u32 len);
 int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
 				  struct folio *folio, u64 start, u32 len);
 void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
-- 
2.43.1


