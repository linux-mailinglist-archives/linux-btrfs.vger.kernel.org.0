Return-Path: <linux-btrfs+bounces-2640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5FA85F7D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 13:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192911C241DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A665FBA2;
	Thu, 22 Feb 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mkMgN76a";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mkMgN76a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1A5FB8C
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604099; cv=none; b=RYaEgOpVPAa3E/o5BlT0uZ/mSUoeLwF9EZPUYmmZ6srqiJAEr3TwEHCfMznSYrRYOkI2sqZYt2UKoGhS4CQT5FXqFT8uQzEPLrbadEXYueSgA6BOvhHzGQIzPEoU6ERynUuZ/aN08rNG4ZA9eL6rwnaLv9rYIh+oXuSBV+qa6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604099; c=relaxed/simple;
	bh=VY9TEP6T5/dOg4pOEWVN4ylMyrD3lEVHrl0fWONa4MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy8lko+Slm4d1rjN636GcRE0xcX+XR0m+HQcpWD4Yq9JPTYpLdTl6p0sWqBqIEgSxIBejLP2G0In48O5btqPH2ODn++Avc3ywpJ3jWZScx558qxPNkSxt8PVlgS65R3077AXqHvNBrtTX8i/wIDBXf/lTPSUkbFM/HzpH2Y7ZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mkMgN76a; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mkMgN76a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8CBED1F457;
	Thu, 22 Feb 2024 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708604095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7KXAq9OD1tkD3w5aiiOQL4/h8Vdx1mFbChJGOcgEh0=;
	b=mkMgN76aRvZa13knO6aSQmU7Jh1OmUHM0nAtBnhBq204ANzQDrSlTdDm+wICbysV24X2O3
	r70/ykBJk7kfDqqtZKOhLArJUPd1am81K0f2AqV0Yf4LzeHVMm/BIyqD+JA7xtkkLJRjWZ
	myzG9O8knFdLmvZIOwlwqfeojjM1sMs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708604095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7KXAq9OD1tkD3w5aiiOQL4/h8Vdx1mFbChJGOcgEh0=;
	b=mkMgN76aRvZa13knO6aSQmU7Jh1OmUHM0nAtBnhBq204ANzQDrSlTdDm+wICbysV24X2O3
	r70/ykBJk7kfDqqtZKOhLArJUPd1am81K0f2AqV0Yf4LzeHVMm/BIyqD+JA7xtkkLJRjWZ
	myzG9O8knFdLmvZIOwlwqfeojjM1sMs=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 85E1F13A6B;
	Thu, 22 Feb 2024 12:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MNSpIL8612V4RQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 22 Feb 2024 12:14:55 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] btrfs: handle transaction commit errors in flush_reservations()
Date: Thu, 22 Feb 2024 13:14:14 +0100
Message-ID: <6bc5ec4e7b211203ce55ae8050a912cd97927697.1708603965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708603965.git.dsterba@suse.com>
References: <cover.1708603965.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Other errors in flush_reservations() are handled and also in the caller.
Ignoring commit might make some sense as it's called right after join so
it's to poke the whole commit machinery to free space.

However for consistency return the error. The caller
btrfs_quota_disable() would try to start the transaction which would
in turn fail too so there's no effective change.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/qgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 044331228bd0..3846433d83d9 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1324,7 +1324,7 @@ static int flush_reservations(struct btrfs_fs_info *fs_info)
 	trans = btrfs_join_transaction(fs_info->tree_root);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
 
 	return ret;
 }
-- 
2.42.1


