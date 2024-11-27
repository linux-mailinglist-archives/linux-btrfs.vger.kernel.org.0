Return-Path: <linux-btrfs+bounces-9931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECED69DA152
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 05:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22C2283F28
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 04:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943F613CFA5;
	Wed, 27 Nov 2024 04:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oN0v6MXh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oN0v6MXh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969E13AD32
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680424; cv=none; b=Y86ZDhII/BpeJYaJzdFIEeNDB1zw0VCZedMKXfIp3JxTdO62pm7thjTp1QLmHxu9+v54gLFjfnyUvrViS974y0nMhXuwGEJ39kOUWIdhXdslHlzvQnf1biWMzA//kMoybUMKtM+kOhjOElUIdVQ9F2rbbC+ayjiN+nJNS+/5C+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680424; c=relaxed/simple;
	bh=fAGoPXIUpXHKRNtLxKU99zRVmBDOm/AXKcl2aEt9n0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0spe3nhOOLIZRUMvyLMXcNYYY1rc13AYYewvXThSh22qFgr8oNXNkfcMpCQdoeZDRi/5UXcCN3AD+WiUrrwn50fctOfPzybsTkoR8UPlZpYFrHgjfZxYZF2EL7YLHLLqQ/Z0zhHMx6X2BOoxgxB2xNIs8dP9vyB0Uh4FtEDc9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oN0v6MXh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oN0v6MXh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1ACA91F769
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 04:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732680421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlP4Bi/d+5UlY4S1RUD6sEIsTQoy7eh0Q3H3YWnr8Cg=;
	b=oN0v6MXhNFiq6ibnz4u6cjgNbNXewkxjZsL2orYbyutj06P1uO3AiqLaIHUf2/vSjb3f6n
	N0PozACoxuo0Dfhk0yNFm7Tl/rAVP8MqJu3ntvWxr17vDJa5dIaXnLGyb/lPDsBtq+4pAa
	b2WpvyRMRhlOpXgK5aJKvCdv2azzQAU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732680421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlP4Bi/d+5UlY4S1RUD6sEIsTQoy7eh0Q3H3YWnr8Cg=;
	b=oN0v6MXhNFiq6ibnz4u6cjgNbNXewkxjZsL2orYbyutj06P1uO3AiqLaIHUf2/vSjb3f6n
	N0PozACoxuo0Dfhk0yNFm7Tl/rAVP8MqJu3ntvWxr17vDJa5dIaXnLGyb/lPDsBtq+4pAa
	b2WpvyRMRhlOpXgK5aJKvCdv2azzQAU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43A2713983
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 04:07:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4L5lAOSaRmfAYwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 04:07:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: add extra error messages for extent_writepage() failure
Date: Wed, 27 Nov 2024 14:36:38 +1030
Message-ID: <1fec3614cbdbd7fc5a3411b00de28ad7e53df518.1732680197.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732680197.git.wqu@suse.com>
References: <cover.1732680197.git.wqu@suse.com>
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

During my development on aarch64 with 64K page size and 4K sector size,
I'm hitting several problems related to error handling of
extent_writepage(), most of them are caused by
btrfs_run_delalloc_range() failure with -ENOSPC error.

This error itself is already a problem for our data/metadata space
reservation code, but we also need extra info like the submit_bitmap to
calculate if the error handling is doing its job correctly.

So add two btrfs_err_rl()s to indicate the errors that is affecting the
error handling of extent_writepage(), which has already saved me several
times during debugging.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 438974d4def4..e33f843c403c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1240,6 +1240,15 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 						       found_start,
 						       found_start + found_len - 1,
 						       wbc);
+			if (unlikely(ret < 0))
+				btrfs_err_rl(fs_info,
+"failed to run delalloc range, root %lld ino %llu folio %llu submit_bitmap %*pbl start %llu len %u: %d",
+					     inode->root->root_key.objectid,
+					     btrfs_ino(inode),
+					     folio_pos(folio),
+					     fs_info->sectors_per_page,
+					     &bio_ctrl->submit_bitmap,
+					     found_start, found_len, ret);
 		} else {
 			/*
 			 * We've hit an error during previous delalloc range,
@@ -1506,6 +1515,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 				  PAGE_SIZE, bio_ctrl, i_size);
 	if (ret == 1)
 		return 0;
+	if (ret < 0)
+		btrfs_err_rl(fs_info,
+"failed to submit blocks, root %lld ino %llu folio %llu submit_bitmap %*pbl: %d",
+			     BTRFS_I(inode)->root->root_key.objectid,
+			     btrfs_ino(BTRFS_I(inode)),
+			     folio_pos(folio), fs_info->sectors_per_page,
+			     &bio_ctrl->submit_bitmap, ret);
 
 	bio_ctrl->wbc->nr_to_write--;
 
-- 
2.47.0


