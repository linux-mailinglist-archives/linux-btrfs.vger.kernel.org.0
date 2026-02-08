Return-Path: <linux-btrfs+bounces-21491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPFVCM3XiGm6xAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21491-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:37:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D721109E46
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C71301DAEC
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2085A2F7449;
	Sun,  8 Feb 2026 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OePhh7J7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D12F7AB0
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770575784; cv=none; b=cJFMHH/vlFHzxnr00ttPUjrvZeUtRrHEW1DW5ASbwTzxbNwLK7YJDVcLKwl/Hzq6b0PiDn80jWGWuwydAoSs47jXLwba8hu7mpnOOIcf6NtqVDEBxPlqfyLC/v1V9E9gFKejFwroc+lnDh3qI7qAr7gwLb5hyNi/b4QfV1Kuvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770575784; c=relaxed/simple;
	bh=OXPkAcnt1jGlu6dOkV+wQn2+rw9FHqESXUo3y58iS2o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Pjt19uAQ4I4j5MUR4rrbiXmCXOxDGa1p/WWKSm68h3yKAKeQCSBzVmIJXgw0MSuaLyFVf9W9k7N+5Yq/ouaZfAgZVZRyZqb/jTfHNHwZOSppiuSeKS/jwrLtEr9LE/Yw4wW7ZYLMvYnFjM3aP0e5oIiTLEPO8+es/YFE4YT8SVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OePhh7J7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8121AC4CEF7
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 18:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770575784;
	bh=OXPkAcnt1jGlu6dOkV+wQn2+rw9FHqESXUo3y58iS2o=;
	h=From:To:Subject:Date:From;
	b=OePhh7J7JJvVf8ipy02z91zoLqIcOi9XORhWwWv6FqNEs+kyy6twr1eD7U5EqTumQ
	 eSlwgxWI7TR4vFdydI4Clx0gc2YVPm0ydRNDxekkffPuRTTNtk8Z3F6seqJxDnsjTF
	 y5hjouH0n4yQ+D5KYiTsJKzsp+b7qBOlrmG1FwVHwSR7yuWjo07X57N3TV32uyuNPS
	 FLhsbBLpHOal1qITM2MIp2/bkM+T1WHEkwglXTdGC2fs6Oyb14Xxx4u5RFsHAP+J3b
	 EebCQ07b0RzbBONAIqzWm5HfjskFjcg5/FIZHw7c6LXXDQQZmtcWzhX0cpErEkMano
	 1Qehx6AJh3RXA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix lost return value on error in finish_verity()
Date: Sun,  8 Feb 2026 18:36:21 +0000
Message-ID: <1d384c9ac09392353418f47a8b41366545d73867.1770575632.git.fdmanana@suse.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21491-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org]
X-Rspamd-Queue-Id: 9D721109E46
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

If btrfs_update_inode() or del_orphan() fail, we jump to the 'end_trans'
label and then return 0 instead of the error returned by one of those
calls. Fix this and return the error.

Fixes: 61fb7f04ee06 ("btrfs: remove out label in finish_verity()")
Reported-by: Chris Mason <clm@meta.com>
Link: https://lore.kernel.org/linux-btrfs/20260208161129.3888234-1-clm@meta.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/verity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 06cbd6f00a78..95ea794f20d3 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -552,7 +552,7 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
 	btrfs_set_fs_compat_ro(root->fs_info, VERITY);
 end_trans:
 	btrfs_end_transaction(trans);
-	return 0;
+	return ret;
 
 }
 
-- 
2.47.2


