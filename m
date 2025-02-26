Return-Path: <linux-btrfs+bounces-11842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEE7A45A97
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBB3172BEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231A238171;
	Wed, 26 Feb 2025 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="stRSPQqq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="stRSPQqq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63E238159
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563451; cv=none; b=uI7OMBuutROlh5mNsrUYaVoFWXAtrmvVRjzeoDhv1XBpjBYL/7ZXUifjjd3svx01xnyPShwSozI7c88+8m2KIrm12UTgggPEQZOmfg1teJTURK2SNf2gylZipssTGOvDchSEjGyLMUB3bbGcCS59KrXXqL6SceC07scUrsHFRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563451; c=relaxed/simple;
	bh=2/bfK+VUSjOIs4YlJTjnLaXP1cOUnuCDc23JTfLLVaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoH12iolBemyphSjjH2DF6rG5/NS4N813XgaJKvEnvfs1Ce/CdfNXk3FobR9Ji6ud8pPj/I2RLgbWtiBjoChc7ucuppqzWzpyPOh9lMTjsE7Sc+aovTdXoRQ3KD8mfNm2oLSPBJ9bDwnIHUaPlKinv/ACpavAjRyV0R3Lg/ints=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=stRSPQqq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=stRSPQqq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 667FB1F38A;
	Wed, 26 Feb 2025 09:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lsOcf6/sY5ZjOpnizAMaicATZBFJL6DQq55ihXR7Q8=;
	b=stRSPQqqUL2vtTBbO4Je4xXWi8bqLu2pKgNjGb3KzL1+ekbgYbLTR0cpOzfimF5iYoagNu
	QY7i3iR5trJjXfSn0JWTbHlsId9fCMVMRDVa06XcVULae6Gz31Og85NOOqiuQSsRdI5m9Y
	mSggp4kb4b4UALVuAwpjkVztsyNhTT8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lsOcf6/sY5ZjOpnizAMaicATZBFJL6DQq55ihXR7Q8=;
	b=stRSPQqqUL2vtTBbO4Je4xXWi8bqLu2pKgNjGb3KzL1+ekbgYbLTR0cpOzfimF5iYoagNu
	QY7i3iR5trJjXfSn0JWTbHlsId9fCMVMRDVa06XcVULae6Gz31Og85NOOqiuQSsRdI5m9Y
	mSggp4kb4b4UALVuAwpjkVztsyNhTT8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D12F13A53;
	Wed, 26 Feb 2025 09:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7f61Fvfjvmf3YQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:50:47 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/27] btrfs: use BTRFS_PATH_AUTO_FREE in sample_block_group_extent_item()
Date: Wed, 26 Feb 2025 10:50:47 +0100
Message-ID: <9eeaf3cc2ffb8389c6bf2776dc2505350734b6b5.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 18f58674a16c..cd20bf9289bd 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -584,7 +584,7 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
 	struct btrfs_root *extent_root;
 	u64 search_offset;
 	u64 search_end = block_group->start + block_group->length;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key search_key;
 	int ret = 0;
 
@@ -626,7 +626,6 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
 
 	lockdep_assert_held(&caching_ctl->mutex);
 	lockdep_assert_held_read(&fs_info->commit_root_sem);
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.47.1


