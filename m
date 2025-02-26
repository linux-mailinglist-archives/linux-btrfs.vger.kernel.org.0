Return-Path: <linux-btrfs+bounces-11867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE9A45ACE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C481887019
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485E26A094;
	Wed, 26 Feb 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HfnMtiop";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CFnozcuq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EDA24E009
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563556; cv=none; b=KN0y3jpvtHDCMxeBlamFf+8bt1i11ad19sd5ikpOlskXZNNzYfew8/A2mXw/U+QdbrHnf06Yxipds4Y2s+5RYyDzj63sVNRwvHnn2gvhtQER10rLK7XfmCG6IjVd7cFPkGE2B21LGcy+63Gi6TSSLJY0hbvPWw1xEha/BJo5uzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563556; c=relaxed/simple;
	bh=E9VIhHldBLTLUB08WhB5/mmFVlCZFjtkAw73tA29n6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAo0SoLtdG4xlrGfdzBi5aRf1LNjVK33SEGu8G55F+Qcec8NUOOUaIsZMk2NA9LFW0dq1vkDpGRiUFoNzalLqjnAgz8JIFOiLKWiiUI3cQN4LONno17GDgSoOvL6T6iHZBl7BrVxJyP0JC/74aGj8tx/TlRiCWo4aZ1P0T+nlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HfnMtiop; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CFnozcuq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 20D031F45E;
	Wed, 26 Feb 2025 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wS7mk4cKxZqHbp/YXY1wMl5QbA666AUAMrRjbIgDF3E=;
	b=HfnMtiopz8yG5aP+6AmLH20OpZKEn37LXVcO8TRNw68lRCQCRVuOq50nIhlbxNeGrcKks0
	eYFrQJB6UyOjTBBwkNb/2CSbxz70JovlDWdBZL3B1TW9coCk3HoEFZKntlg+jpLWnusPh3
	W4n4BmYQ7e6Fzuk4h/D0UziwCa2fdOI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CFnozcuq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wS7mk4cKxZqHbp/YXY1wMl5QbA666AUAMrRjbIgDF3E=;
	b=CFnozcuqTbsp3SoJ42nQB8qAZ78mPTqdsLTRzbYzvqefCraWFW4UqIChtwRt2X6k13KGeJ
	SpCo4Fe5NrZ0p+WBOCGL+AZgPFovzodOegyLxOAhZRtk2D3yLkxF9C9UxUopFeJUU6ti5R
	6Ma+DvqLmOoqDZK2VPTcOi/Z6fm1Q+4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A3D813A53;
	Wed, 26 Feb 2025 09:51:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1B1mBjDkvmdtYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:44 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 23/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_del_csums()
Date: Wed, 26 Feb 2025 10:51:43 +0100
Message-ID: <704025559310b70dd7a7d215fe88475241bef6e3.1740562070.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 20D031F45E
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file-item.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index e0475465ba51..344b4db487a0 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -871,7 +871,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, u64 bytenr, u64 len)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	u64 end_byte = bytenr + len;
 	u64 csum_end;
@@ -1007,7 +1007,6 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		}
 		btrfs_release_path(path);
 	}
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.47.1


