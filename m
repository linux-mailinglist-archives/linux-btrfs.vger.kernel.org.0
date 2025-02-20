Return-Path: <linux-btrfs+bounces-11609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44655A3D499
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D017CE01
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438691EF08D;
	Thu, 20 Feb 2025 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="csfNiFvS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="csfNiFvS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2921EE7A1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043379; cv=none; b=VDay3b2wLWHTH4wnf5hIdxPt+QJmFaw5qo4M+F9fJ1Hu/ZRuDQ6BF3MXmueb6N7rg8bBaBRR4CBRw4sNKyBG8d1zjyVFNcNciGQ0HzNOwRtSarsZcokXSX7ud73l0fwtzXF/M5RqRSN3fA90jDVBvtoFi28fnrsymWN61sspB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043379; c=relaxed/simple;
	bh=GVfM36meQ+ETNRRjyKIyNKG8dlVRzVUEbD3XVWgHaPI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6D7TwxirWQ64FITAWPNcq7GNOFLMDVnl4XECEvhr1oQv+MNVcNXEPXKNC1RW2gfEypJw86CzVTSa2y5MUFHOh5nmVDmk3KNzorU8e+tJ11GYJ/XgaNZ0MWRG4Ib0uz7SHMgo6kkxfIJXDW4i/Z7HZH9DByVb/qQOZDsPp7ajCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=csfNiFvS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=csfNiFvS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A8B41F388
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/4ZG04ufGZQP2QmrYrmQD+IFKdQfRFmLlaX5r7XAWo=;
	b=csfNiFvSWRM61fcvufmTzGPsMRtZrWHDwi2iAOPKH2/9VkP7bMEn8cg3X+BvmcyrXPplan
	5ZlVHctmZ1Kk50l0buMdewQrKor3+3Cejtjvm+Cz2NLjG5dZ4KE8jzOKG/owu+PHTyRM3S
	YGc09VHeufTSP+pLv/c/cvcFzIw5Ad4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/4ZG04ufGZQP2QmrYrmQD+IFKdQfRFmLlaX5r7XAWo=;
	b=csfNiFvSWRM61fcvufmTzGPsMRtZrWHDwi2iAOPKH2/9VkP7bMEn8cg3X+BvmcyrXPplan
	5ZlVHctmZ1Kk50l0buMdewQrKor3+3Cejtjvm+Cz2NLjG5dZ4KE8jzOKG/owu+PHTyRM3S
	YGc09VHeufTSP+pLv/c/cvcFzIw5Ad4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E17413A69
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJ6OAmj0tmfBcgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: remove the PAGE_SIZE usage inside inline extent reads
Date: Thu, 20 Feb 2025 19:52:23 +1030
Message-ID: <2e9629067938c31bb59c34655456909c4d00e183.1740043233.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740043233.git.wqu@suse.com>
References: <cover.1740043233.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
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

The inline extent ram size should never exceed btrfs block size, there
is no need to clamp the size against PAGE_SIZE.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3af74f3c5d75..d9ca92d1b927 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6784,7 +6784,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 
 	read_extent_buffer(leaf, tmp, ptr, inline_size);
 
-	max_size = min_t(unsigned long, PAGE_SIZE, max_size);
+	max_size = min_t(unsigned long, sectorsize, max_size);
 	ret = btrfs_decompress(compress_type, tmp, folio, 0, inline_size,
 			       max_size);
 
@@ -6820,7 +6820,7 @@ static int read_inline_extent(struct btrfs_fs_info *fs_info,
 	if (btrfs_file_extent_compression(path->nodes[0], fi) != BTRFS_COMPRESS_NONE)
 		return uncompress_inline(path, folio, fi);
 
-	copy_size = min_t(u64, PAGE_SIZE,
+	copy_size = min_t(u64, sectorsize,
 			  btrfs_file_extent_ram_bytes(path->nodes[0], fi));
 	kaddr = kmap_local_folio(folio, 0);
 	read_extent_buffer(path->nodes[0], kaddr,
-- 
2.48.1


