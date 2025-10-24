Return-Path: <linux-btrfs+bounces-18324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48744C08502
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 01:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8865A35217E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 23:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF42D7D41;
	Fri, 24 Oct 2025 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iCCn+AER";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iCCn+AER"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350A1F1932
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761348668; cv=none; b=E1CMmnUxuwzIgB9txwqJ+uCVT1pR7wK4TXS6FJqjhfApGpDoV7zD9mNprNQIxAQmfKOv6mO4mn/EDzoYwp+hbHoSMTD4CM58my5khYs6E6j1V9m6m4W2rAEHukEWR4D0V+XbUVFn1ZDl1aCmASWKamTVqgL0gl4pMuLR33FeLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761348668; c=relaxed/simple;
	bh=zzZHjIJaIuprT7amgEL30R1s7Z3lKFNoOleiL4XIGBo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Oxsikm27qf3ZyidDOhSXp5wYMn8ZGZftbZgh6clHAqAJo89dsEpvj/aq5dn1WnwiU+XgF1vrz+qeD5Ly07Oqfa6uysZt2zWjEmzStIQVL8K+DddBGzHnE1fvkd+5iti8pWnQAg7DBQarMvNfBAsW4Ai8udyDXNtMb0YLfM1V6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iCCn+AER; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iCCn+AER; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81273211F7
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 23:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761348660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FFAcp5/2aNcGAj2jU0WxYEpdxAzRiBO1NGlkBK5FlDg=;
	b=iCCn+AERndVX/UvYzp/BswiMiSspuPXew7DoywbWWG+t8OKGdKsKVwhKGeszenvOAKmq4x
	gcx9ES0s0GCPVWR/r8t5tlq7SJN311qMMwPVHHjxmiC+7AQRyF3T/snGWuZ503PnYH2f+7
	GYxet3WwGnikUx+ee8pvdH2AMuWX6hs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=iCCn+AER
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761348660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FFAcp5/2aNcGAj2jU0WxYEpdxAzRiBO1NGlkBK5FlDg=;
	b=iCCn+AERndVX/UvYzp/BswiMiSspuPXew7DoywbWWG+t8OKGdKsKVwhKGeszenvOAKmq4x
	gcx9ES0s0GCPVWR/r8t5tlq7SJN311qMMwPVHHjxmiC+7AQRyF3T/snGWuZ503PnYH2f+7
	GYxet3WwGnikUx+ee8pvdH2AMuWX6hs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB54B132C2
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 23:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RjXbHjMM/GidQwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 23:30:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: convert: prevent data chunks to go beyond device size
Date: Sat, 25 Oct 2025 10:00:41 +1030
Message-ID: <f88a750276cab164dc07fabe09b171307ce64e64.1761348631.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 81273211F7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

[BUG]
There is a bug report that kernel is rejecting a converted btrfs that
has dev extents beyond device boundary.

The invovled device extent is at 999627694980, length is 30924800,
meanwhile the device is 999658557440.

The device is size not aligned to 64K, meanwhile the dev extent is
aligned to 64K.

[CAUSE]
For converted btrfs, the source fs has all its freedom to choose its
size, as long as it's aligned to the fs block size.

So when adding new converted data block groups we need to do extra
alignment, but in make_convert_data_block_groups() we are rounding up
the end, which can exceed the device size.

[FIX]
Instead of rounding up to stripe boundary, rounding it down to prevent
going beyond the device boundary.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/convert/main.c b/convert/main.c
index e279e3d40c5f..5c40c08ddd72 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -948,8 +948,8 @@ static int make_convert_data_block_groups(struct btrfs_trans_handle *trans,
 			u64 cur_backup = cur;
 
 			len = min(max_chunk_size,
-				  round_up(cache->start + cache->size,
-					   BTRFS_STRIPE_LEN) - cur);
+				  round_down(cache->start + cache->size,
+					     BTRFS_STRIPE_LEN) - cur);
 			ret = btrfs_alloc_data_chunk(trans, fs_info, &cur_backup, len);
 			if (ret < 0)
 				break;
-- 
2.51.0


