Return-Path: <linux-btrfs+bounces-19949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD7DCD51D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 09:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B361304B95A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEF5313E13;
	Mon, 22 Dec 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DnnyAfyy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DnnyAfyy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098B2313294
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766391588; cv=none; b=nlIg/OXKlS+TG2dcdc5Q25lgumhLgEDJyssDBARci4XCZbsX4Tf6Bc9Wg/YNqFsOmq9bBm32fOjMq4/weQzjPp/A5tKzLlpetfW8/+4vh/6Q0uERCZAPA2CRkkQyj86etFlSIfNvSdReWqpcSkif1Oq7oWeTHqQc7o+aPRI5Cl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766391588; c=relaxed/simple;
	bh=66Hhk6VW0OfgRAx3M8esIBV9vo2K59pTmsKy2y2MpvM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iNoGeU/hFOMzr82iF9beD8TTJlzjOQepG5LmzXZLrEHl4pvmNps+W95joL4pJZ10HmqiyOFjfGAMEpjalZqRw7Tpl3Dy3LCdcz6VzZj/3NFllx959qkw9j0LoJTKCSXcBw0P5vB9UopvI/9EismChS7SnbLyP4Wsi9rrYib8JZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DnnyAfyy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DnnyAfyy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0CC7336BD
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 08:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766391583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j8N+NpkZkJl3VILE6L/0cijzNDgECetwOnF8QQBPOcc=;
	b=DnnyAfyyqiCycugEjsZQtJv8d+it1hXS+hIsB08EjA3ZYj5ZT4hifjZXAQrI8seaSaFEMi
	JFuDdPgii275y+8tpWH/UclvEel0v9J2q8U2U4eiJT9RcxuO0EUBuApUkbvh7fe3bHMyOZ
	Ij+DqRfZ0yypAGcyzh1y+2JTa8eIQZg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766391583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j8N+NpkZkJl3VILE6L/0cijzNDgECetwOnF8QQBPOcc=;
	b=DnnyAfyyqiCycugEjsZQtJv8d+it1hXS+hIsB08EjA3ZYj5ZT4hifjZXAQrI8seaSaFEMi
	JFuDdPgii275y+8tpWH/UclvEel0v9J2q8U2U4eiJT9RcxuO0EUBuApUkbvh7fe3bHMyOZ
	Ij+DqRfZ0yypAGcyzh1y+2JTa8eIQZg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 143C43EA63
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 08:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rtAqMR7/SGknPwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 08:19:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: check inlined file extent before accessing members after type
Date: Mon, 22 Dec 2025 18:49:10 +1030
Message-ID: <7796cd714c563e8990b47899600eb5da17754b91.1766391527.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.67 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.07)[-0.325];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.67

During the rework of btrfs_file_extent_item, I hit a call site inside
range_is_hole_in_parent() where I can not find an obvious check on
btrfs_file_extent_item::type before accessing
btrfs_file_extent_disk_bytenr().

Do a proper type check before accessing btrfs_file_extent_disk_bytenr().

Fixes: 82bfb2e7b645 ("Btrfs: incremental send, fix unnecessary hole writes for sparse files")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2522faa97478..d8127a7120c2 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6383,6 +6383,8 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 		extent_end = btrfs_file_extent_end(path);
 		if (extent_end <= start)
 			goto next;
+		if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE)
+			return 0;
 		if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
 			search_start = extent_end;
 			goto next;
-- 
2.52.0


