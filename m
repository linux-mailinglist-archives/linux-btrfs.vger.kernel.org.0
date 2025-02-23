Return-Path: <linux-btrfs+bounces-11724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F417AA41252
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 00:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F9A172567
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 23:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36320469E;
	Sun, 23 Feb 2025 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SM+oztBN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SM+oztBN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493720013A
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740354417; cv=none; b=BBeaEJ+JPQ4fTg2D+6ac1fm2OkQqWS2Rkdi0qOuOe+jTQiLQuiBql/wBdpJ4s4rVgoFYxAxvqccZh7Y1CS/Fwb8p5Mbd5BxXnozAjb04I4UvCneB/Q8ixF0Rl7wFWz8WQ3VQPMCBTpN/MDEj2oXSeNBYuOtZGIcqyLL8n/pW8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740354417; c=relaxed/simple;
	bh=i1NREQEOqwedTH9zvqm/iJi62HhGcl4DAz/l318TYsM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKyoQarr3fjnPIU3M0jY1JP1VuskoL61Gn128ASGz2mHjUeASoKosbPsw/hBZkRBh0swB7jPfQzX26nDbUvEBGsTkmbs4g3HBz6j9JVkl/ufS82QQvitlmHcoG6KT2AOYnMa1XosQiQZhz4goOYyHEpPKHhdXE5VufOP+kA8E40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SM+oztBN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SM+oztBN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6B9021172
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfgUKCIFdC4eL72syVHy8yBytO3KZFhikalpDq23VXY=;
	b=SM+oztBNJq+K4gQA9KXMF65gWPfE2uD4zNpnQVnpJWTRLUfhOftnWMC2LoLkgDyFhioLws
	5HIay4YHndvuVvpOuu41z9MsyTRpr3n+JeWKs1nbTesittNahqLev2x++RY6YoWFUDtE0g
	IeQ5O5n/mmwY6j7ZbUoZQUpF0zkwkMo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfgUKCIFdC4eL72syVHy8yBytO3KZFhikalpDq23VXY=;
	b=SM+oztBNJq+K4gQA9KXMF65gWPfE2uD4zNpnQVnpJWTRLUfhOftnWMC2LoLkgDyFhioLws
	5HIay4YHndvuVvpOuu41z9MsyTRpr3n+JeWKs1nbTesittNahqLev2x++RY6YoWFUDtE0g
	IeQ5O5n/mmwY6j7ZbUoZQUpF0zkwkMo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11AD713A42
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GHq/MGKzu2euTgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: fix the qgroup data free range for inline data extents
Date: Mon, 24 Feb 2025 10:16:17 +1030
Message-ID: <ee3f2825c85a104f23fb3703052383340fb676ce.1740354271.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740354271.git.wqu@suse.com>
References: <cover.1740354271.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Inside function __cow_file_range_inline() since the inlined data no
longer takes any data space, we need to free up the reserved space.

However the code is still using the old page size == sector size
assumption, and will not handle subpage case well.

Thankfully it is not going to cause any problems because we have two extra
safe nets:

- Inline data extents creation is disable for sector size < page size
  cases for now
  But it won't stay that for long.

- btrfs_qgroup_free_data() will only clear ranges which are already
  reserved
  So even if we pass a range larger than what we need, it should still
  be fine, especially there is only reserved space for a single block at
  file offset 0 for an inline data extent.

But just for the sake of consistentcy, fix the call site to use
sectorsize instead of page size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fe2c6038064a..0efe9f005149 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -672,7 +672,7 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
 	 */
-	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE, NULL);
+	btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
-- 
2.48.1


