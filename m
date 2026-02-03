Return-Path: <linux-btrfs+bounces-21327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI9PKas4gmmVQgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21327-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 19:04:27 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D979DD481
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 19:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2F2D30AF98C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0133A0EBD;
	Tue,  3 Feb 2026 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO+ytZFE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46B36405E
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141819; cv=none; b=kAAA9LLK/rPEKrVIFQBaq/aiE/92Q+/zEfxiIWYV1LGpm7zs3rib+2PCxeAcFhkscIC7+tYkoXC4fc1VacAkVM5j0+JwuEsKtA0Fa6cDzZCXu5NSby3XZW3OCXShs2bBTvlu/BqwuCatgNSU2GWCKkEXDcCvnogDfMPSLVw/hDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141819; c=relaxed/simple;
	bh=bYh4GqRlzqlbDurVee3rGbEIMnw4AnddC4mxTKOUACI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GnNrGb9h8jTAEc+gNs4IsrrmiZxdwvl8wCDfEdRytfqCA6fIBiSbJWdz0MUca1M5rmYIQFPdVeF8X5LzxTNtd40skIsyCxkTdStiI7qA5x7nRFgp+U64B0SJ4gJ42mIKkpwlLx4tHDaHzj7l0DxW4VhlB6qhh17aQE5WRDjYIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO+ytZFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6323C116D0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770141819;
	bh=bYh4GqRlzqlbDurVee3rGbEIMnw4AnddC4mxTKOUACI=;
	h=From:To:Subject:Date:From;
	b=OO+ytZFEM7DbH67L+11Xi8Ly0njGJEol1GDLj9p06psgXZrNPEfa3JGlRPW1gGXR3
	 mh2A4T9/zRle8t3SHV2Lt4FleVWfP6F2y/NY5HfLsk5NO+XVpnjEIZac37KQZFh6ua
	 yBFY6WVOpB+kC1waWyU7pRwkLGXk6po0a73mMr5PmRKSt/OT4p4Koy11DjBxQrckO+
	 bl4XrDnlCreHV2rLZh8pTD5tbT7VPRfzrhpcEHg+vyPp8ka3dMMDks1bPGCsbsnv/R
	 AJjrPiHuhgXVd7wbifIGV8lq+WfEbQdGCSXPQDD5OpWFfuivGKPlg+u81rEEHSk4cp
	 9wQPPTDmf8QkQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use the correct type to initialize block reserve for delayed refs
Date: Tue,  3 Feb 2026 18:03:35 +0000
Message-ID: <c16363c678a392fafd249223228c6c75985e4a59.1770141624.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21327-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:email,zadara.com:email]
X-Rspamd-Queue-Id: 2D979DD481
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

When initializing the delayed refs block reserve for a transaction handle
we are passing a type of BTRFS_BLOCK_RSV_DELOPS, which is meant for
delayed items and not for delayed refs. The correct type for delayed refs
is BTRFS_BLOCK_RSV_DELREFS.

The consequence here is that when releasing unused space from that local
block reserve, instead of transferring it to the global delayed refs
block reserve we transfer it to global block reserve. If the global block
reserve is full, we just return that space to the metadata space info.
There's no harm in that, but ideally we should transfer the excess
reserved space to the delayed refs block reserve.

Reported-by: Alex Lyakas <alex.lyakas@zadara.com>
Link: https://lore.kernel.org/linux-btrfs/CAOcd+r0FHG5LWzTSu=LknwSoqxfw+C00gFAW7fuX71+Z5AfEew@mail.gmail.com/
Fixes: 28270e25c69a ("btrfs: always reserve space for delayed refs when starting transaction")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 87a3f746cecc..08f691661874 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -726,7 +726,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 
 	h->type = type;
 	INIT_LIST_HEAD(&h->new_bgs);
-	btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_BLOCK_RSV_DELOPS);
+	btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_BLOCK_RSV_DELREFS);
 
 	smp_mb();
 	if (cur_trans->state >= TRANS_STATE_COMMIT_START &&
-- 
2.47.2


