Return-Path: <linux-btrfs+bounces-21375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JcZCEMOBg2llowMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21375-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 18:28:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8745EEAFA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 18:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8955E3016ED7
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 17:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD76134A76A;
	Wed,  4 Feb 2026 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnMYfOZ7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A16D33B945
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226105; cv=none; b=hp9/6bxYIO0jq2I7TqGUgIC0xsKyGZXsDAiQ6Ldem3weysqr5++92sKzObYu/hAqBE7M/UscgRGQL+8MEA1HCSk4cUXUQ+n45lXoDpEFmN52qACgHewJSe2qvqsgZHVe3O0Z/KvHqv/hR1l/Dv0jAd7tAefPbMoLmfHjdnMtPxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226105; c=relaxed/simple;
	bh=I406EnWiYKNCpt/Hvx7t0Pr7p2+ROqnnQmWYwf6idmg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q1wet816lwUHTB2ZogCDFEbMrnaBx0/WpgvFpClVhC1yfjP0vN6HPooz5CmfmhPkzp86aqRm0/v9ofCuW1zEPyVaYALRYqNGiuOe4OKr1crKAdbtBqQ4C+QV8TJuJsxJ+KamsCgalW859Y4WWdVd9SZCZq15IF0vMf4DaZfqU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnMYfOZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C188C4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770226104;
	bh=I406EnWiYKNCpt/Hvx7t0Pr7p2+ROqnnQmWYwf6idmg=;
	h=From:To:Subject:Date:From;
	b=gnMYfOZ7P9rqfVnkvXRRi2q6u/B3tCLHT4GXdsjfNBQcfajtToAdtIKMC/q7AX7YP
	 5+V2e7LdNSYChAL8a1t9CxXcon9L7VozTT3EmcBMoBWm4Ep+kdaXvoBTGG11oI6dLa
	 3Pq3Dct1ng857lCWtQcF2ie4b2wImvvnFZvXPYRGQpP7ce8wjlTuwO62apu4Y8XFk8
	 HsURTTp+zno2ZhA8CtnnDfEYS90e27obqvj1c5EvTzc5CVaptPDbRTIbSnB1ToAhc1
	 HwBIyXAK9n9vFrLt8rwPO7TF0od3qrWrftprgGciFITjaAAa4Lv5cpPF6QhhCweBpx
	 3y5PUFU8E/spA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix invalid leaf access in btrfs_quota_enable() if ref key not found
Date: Wed,  4 Feb 2026 17:28:20 +0000
Message-ID: <78d48962c97102192c0daea9393b0014430024f0.1770225728.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21375-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org]
X-Rspamd-Queue-Id: 8745EEAFA5
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

If btrfs_search_slot_for_read() returns 1, it means we did not find any
key greather than or equals to the key we asked for, meaning we have
reached the end of the tree and therefore the path is not valid. If
this happens we need to break out of the loop and stop, instead of
continuing and accessing an invalid path.

Fixes: 5223cc60b40a ("btrfs: drop the path before adding qgroup items when enabling qgroups")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f53c313ab6e4..ea1806accdca 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1169,11 +1169,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 			}
 			if (ret > 0) {
 				/*
-				 * Shouldn't happen, but in case it does we
-				 * don't need to do the btrfs_next_item, just
-				 * continue.
+				 * Shouldn't happen because the keu should still
+				 * be there (return 0), but in case it does it
+				 * means we have reached the end of the tree -
+				 * there are no more leaves with items that have
+				 * a key greater than or equals to @found_key,
+				 * so just stop the search loop.
 				 */
-				continue;
+				break;
 			}
 		}
 		ret = btrfs_next_item(tree_root, path);
-- 
2.47.2


