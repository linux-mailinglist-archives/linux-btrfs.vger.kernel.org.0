Return-Path: <linux-btrfs+bounces-21538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKL6CxS0iWlLBAUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21538-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 11:16:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B635310E0E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 11:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A01FD3014408
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 10:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1B732E6BE;
	Mon,  9 Feb 2026 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP5lqtWo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9EA25487C
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632209; cv=none; b=Su7ThHS8B9KRJOKJt4JA628NiHp/DHyjiXv2g44EeNLzk41cZqtb8PbxiH3cnVz/gWdpt9UmWTtWku6JnJF+SIfNnGcURzGS7w9cFYA165AWV5LMDJkni90qU607f56gQdrWtqLj7zNbI3oyND8pCmOLw0FmW7v6v6zS+aQYzRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632209; c=relaxed/simple;
	bh=UqqKtncNzQZ8N3rjmkJ+dVA+RoZlm5+bMeAE5Ppeb5o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RRff21OeSVl6x2xEGQewD1tFhAXTUz84lI0XA4xOZi6xE6Q8K8MzGwkXNqUerwMBJksWtRd1CYbk2m1ewNcqzfZdvTgClJH4pXTU1g9t9lIDwdDzLkq6IgL+/QHzBX2J+JR4IELbbRjZvbq0BN0Vld0L/fPB6Zh+VdpGSr4yzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP5lqtWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83366C16AAE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 10:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770632209;
	bh=UqqKtncNzQZ8N3rjmkJ+dVA+RoZlm5+bMeAE5Ppeb5o=;
	h=From:To:Subject:Date:From;
	b=eP5lqtWo7pC72Ly9cpRk4Lm+RurwwvjeflNCVlSqQCmrq1N6YrmkwHcq/ZeLdDfeL
	 LGM4tuXkYS4iKpTgrK8bWat9dFgwQ+nynDN2CwLfn8D/04lJzJKdymVz0yu266IjPO
	 gKaV5xzmjWjQsYk3x5Dmb/wYAojvFIpoTNIqpezmjBZEPfYPsgdOS2QkToT//yhFLs
	 KGStbhsAR+wJapMhYNtGxV+1P5Fy00tK1noeQ6cO/3s6QHkppKJVgbwfHI/PoOjl2Y
	 u0S6BGwktzY8/LVExoDyksqqLLIFB1g1p4W9R0HinULB76fgx324XMOUSDF+EGX8uP
	 F7u405r0ntO3w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove duplicated eb uptodate check in btrfs_buffer_uptodate()
Date: Mon,  9 Feb 2026 10:16:46 +0000
Message-ID: <9e7f31b1561a9733de07046f076657e95a3af39a.1770632164.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-21538-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B635310E0E4
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

We are calling extent_buffer_uptodate() twice, and the result will not
change before the second call. So remove the second call.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 53237ec14d49..2e7af6ead4a6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -121,8 +121,7 @@ int btrfs_buffer_uptodate(struct extent_buffer *eb, u64 parent_transid, bool ato
 	if (atomic)
 		return -EAGAIN;
 
-	if (!extent_buffer_uptodate(eb) ||
-	    btrfs_header_generation(eb) != parent_transid) {
+	if (btrfs_header_generation(eb) != parent_transid) {
 		btrfs_err_rl(eb->fs_info,
 "parent transid verify failed on logical %llu mirror %u wanted %llu found %llu",
 			eb->start, eb->read_mirror,
-- 
2.47.2


