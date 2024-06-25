Return-Path: <linux-btrfs+bounces-5950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89C5915DF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 07:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE4EB21A51
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 05:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B291F1448E0;
	Tue, 25 Jun 2024 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="balI8U4G";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="balI8U4G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FBF144306
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292086; cv=none; b=pyP6TEu12ekHO4kE8kZVdc0z1PXOl4BzBTneAz1mEse63URbGdIkF80lqTakeCtJG4Sq2udGmoxZN7ktHojzirE7TdNUefVBpWD3+H+5LOfAVmwF2C106bhGgYZrFzrgZZvZZQOStcdG6fHXxO75oW3b8B/vOabgULr31kthg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292086; c=relaxed/simple;
	bh=0nyyD4dEOuOYtk1bDJrbYw1XaxBHlJBL8IIsi5b8+cQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HL+0NQVBcHtk771eokN6zhAnUiDHbA0m55BjEQNmY4j1vukZN1nfYloHaSYdLGfQAnEsO8KPW51ASHCM/RweVipo2DxbYcSaiPTwW9cBZgxR/L6b/6Xe1Xjc07MrtPZe164xJAdMigQ9CWAwq9Ke4CiY5fb2ql7qYb5aIM55P08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=balI8U4G; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=balI8U4G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACA9321A28
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719292076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vaq4dpnMgMxzG0nAxzlJh0vZzkQmVbgP5ufPN0PjRN8=;
	b=balI8U4GtbpeHUWr3/1Zmi8PgyNKb3ilmO1EDsTdx3L7eLu1WowLnaeFjIpHpjldHAHV/t
	mFsYfBtFzerblwtyFbT+7bHEe5ETtMOlk+Ed4n1EMCNdCLWeay/R5el1yqYwuC4eIVQBa3
	0X6TVrmccn3uFTTSn2qg2MZ+QeJ5cr0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719292076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vaq4dpnMgMxzG0nAxzlJh0vZzkQmVbgP5ufPN0PjRN8=;
	b=balI8U4GtbpeHUWr3/1Zmi8PgyNKb3ilmO1EDsTdx3L7eLu1WowLnaeFjIpHpjldHAHV/t
	mFsYfBtFzerblwtyFbT+7bHEe5ETtMOlk+Ed4n1EMCNdCLWeay/R5el1yqYwuC4eIVQBa3
	0X6TVrmccn3uFTTSn2qg2MZ+QeJ5cr0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6EEC1384C
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QFs2H6tQembqdgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: make validate_extent_map() to catch ram_bytes mismatch
Date: Tue, 25 Jun 2024 14:37:28 +0930
Message-ID: <8ae9d9cbfce4a3c1d21a413d5072694b1814aad1.1719291793.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719291793.git.wqu@suse.com>
References: <cover.1719291793.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Previously validate_extent_map() is only to catch bugs related to
extent_map member cleanups.

But with recent btrfs-check enhancement to catch ram_bytes mismatch with
disk_num_bytes, it would be much better to catch such extent maps
earlier.

So this patch would add extra ram_bytes validation for extent maps.

Please note that, older filesystems with such mismatch won't trigger this error:

- extent_map::ram_bytes is already fixed when reading from disk
  At btrfs_extent_item_to_extent_map() we override extent_map::ram_bytes
  to disk_num_bytes for non-compressed regular/preallocated extents.

So this enhanced sanity checks should not affect end users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index b869a0ee24d2..6961cc73fe3f 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -317,6 +317,11 @@ static void validate_extent_map(struct btrfs_fs_info *fs_info, struct extent_map
 		if (em->offset + em->len > em->disk_num_bytes &&
 		    !extent_map_is_compressed(em))
 			dump_extent_map(fs_info, "disk_num_bytes too small", em);
+		if (!extent_map_is_compressed(em) &&
+		    em->ram_bytes != em->disk_num_bytes)
+			dump_extent_map(fs_info,
+		"ram_bytes mismatch with disk_num_bytes for non-compressed em",
+					em);
 	} else if (em->offset) {
 		dump_extent_map(fs_info, "non-zero offset for hole/inline", em);
 	}
-- 
2.45.2


