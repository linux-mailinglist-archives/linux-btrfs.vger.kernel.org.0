Return-Path: <linux-btrfs+bounces-21722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIhSL1i5lGlmHQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21722-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 19:54:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1319614F62A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 19:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11A54301F310
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9412D372B59;
	Tue, 17 Feb 2026 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="49UseQPj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043B29898B
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354447; cv=none; b=jQ5xUqVaq4KWwBciwpI0OIksOWfYZxvEObNH4hQy5UerF8ePMbMA0PG+xp8+RrMZGz2cHHRCOW6pPT1NZHhVlV9Dp+CDdDo78L0SzJh/5tXCHkftSs4BB2Lm27vryrg3+FjFd6ln5p51MJK78LmG7nh+/eDWCKKrrjNbJwlM+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354447; c=relaxed/simple;
	bh=iAjVTptg1wSg4153Q86Ok/TalSlRKM5vCNqpsc3THcI=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=tB1BWWUnS38Q4BmLKQs8cilU4dIiRvjeV5wqOlRFwYBHj/EehBnZ5enm3/V85rgH6L5ibxlXjtv3zP6Y0hXYEsFvifwBFuoykCFSrEEtnpyoo8d1dlWVCCMZfiQ2vbIyLZB9Xx2NSxq0e43Rd7KJyr/kxczumNd4VDjqs/4bmG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=49UseQPj; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 14FCF303131;
	Tue, 17 Feb 2026 18:54:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1771354444;
	bh=ckezU9CDSereNpkcYiqkt7lSN65/vIBUsJVAVK+vumQ=;
	h=From:To:Cc:Subject:Date;
	b=49UseQPjg30x0flRQVmIjIH/HjPsq0gjsQNtbJ//iQ4ku7AyYsdA6dHdb1nnZFU5M
	 gU2U98BPB3VcTOesqNm5GxYRrrAzZMjnpXDLk+Ds5l0xh0sM62xmd4fHDrgt9BZLPJ
	 YGBUxIbiG6rwMdVJ3cJpkhrjQJOOgcP0Fnsdiu88=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	wqu@suse.com
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH] btrfs: fix error message in btrfs_validate_super()
Date: Tue, 17 Feb 2026 18:53:19 +0000
Message-ID: <20260217185335.21013-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21722-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[harmstone.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,harmstone.com:mid,harmstone.com:dkim,harmstone.com:email]
X-Rspamd-Queue-Id: 1319614F62A
X-Rspamd-Action: no action

Fix the superblock offset mismatch error message in
btrfs_validate_super(): we changed it so that it considers all the
superblocks, but the message still assumes we're only looking at the
first one.

The change from %u to %llu is because we're changing from a constant to
a u64.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Fixes: 069ec957c35e ("btrfs: Refactor btrfs_check_super_valid")
---
 fs/btrfs/disk-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 600287ac8eb7..f39008591631 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2533,8 +2533,8 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 
 	if (unlikely(mirror_num >= 0 &&
 		     btrfs_super_bytenr(sb) != btrfs_sb_offset(mirror_num))) {
-		btrfs_err(fs_info, "super offset mismatch %llu != %u",
-			  btrfs_super_bytenr(sb), BTRFS_SUPER_INFO_OFFSET);
+		btrfs_err(fs_info, "super offset mismatch %llu != %llu",
+			  btrfs_super_bytenr(sb), btrfs_sb_offset(mirror_num));
 		ret = -EINVAL;
 	}
 
-- 
2.52.0


