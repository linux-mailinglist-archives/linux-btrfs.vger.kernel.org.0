Return-Path: <linux-btrfs+bounces-20828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MO1KRK3cGndZAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20828-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:22:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EAA55EEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F3A6689107
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A47946C;
	Wed, 21 Jan 2026 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPqYWvv+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881D478E4A
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994054; cv=none; b=XrdkPmhn/ibpA76X2Kj5p/M9RRHwuGiaxB8zJcx0FrR9XC9A5WucMXD1aCi0GHQUBsrBjcNza3Ayh9U0IKncLpMUppJkGMBAZ15R2rjvQO9PMmq9tDbMsQINkbdcehNevrm4WsK502X3yk/KtHvoKBtWFgyMVXoX/Zzmehkd6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994054; c=relaxed/simple;
	bh=NtxTR3SHeF0mIrhtIWbmEdq7ssO+8t6gRyozx7zivOI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4QT8bg0hXfxzQ8guaCI1kOrSq4Po/ZnAYYQB4ytY2flWrbMmzPpXDQ7fPw6DR5+UAUML+s8DblRplStZX6r1K5G0B3bV/aYNfbONKxhkG/upkIyn9UfXkV/PCL1UZ7ziwPpCOkrKl8x869nDmWRmcM++HlNbJXLLcm3eAPZZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPqYWvv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C69BC116D0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994052;
	bh=NtxTR3SHeF0mIrhtIWbmEdq7ssO+8t6gRyozx7zivOI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gPqYWvv+ePY9OQsFeKySENSxOqXYAp86327y0PFEMolUrQsi7FOhCtahK62YoN1A4
	 d0eVqJkh62pcqHzn801+yC/s7cgzt93UXFMt2VGWRR2t5PjwuUJEDVC4Fxtd4WIfJt
	 0+N+SOIdcrFbGYbJ8ejfFakrG1yKE1lwu6Wa+vjyp34t3OVN2iB2iU8H1qsb1KHNkd
	 wXCMxC4RWexJVb8iya2KSf6kA5iOufXFzjZHHsEFhK/QTmYDTWqhCyfYfYq59Jpn90
	 yo3fjmYrgpmBsksDpD98TZN0ukpUvS7gvaeyeFkSdiL+aMI3lsRJ26SbdNkQoLK7eI
	 3TI4OM/YJmI4g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 18/19] btrfs: remove out label in btrfs_init_space_info()
Date: Wed, 21 Jan 2026 11:13:52 +0000
Message-ID: <da2eebb1e4abc811a4e79661c985f98e7b235b89.1768993725.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768993725.git.fdmanana@suse.com>
References: <cover.1768993725.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20828-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 44EAA55EEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There is no point in having the label since all it does is return the
value in the 'ret' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index bc493243f777..bb5aac7ee9d2 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -329,7 +329,7 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 	struct btrfs_super_block *disk_super;
 	u64 features;
 	u64 flags;
-	int mixed = 0;
+	bool mixed = false;
 	int ret;
 
 	disk_super = fs_info->super_copy;
@@ -338,28 +338,28 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 
 	features = btrfs_super_incompat_flags(disk_super);
 	if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS)
-		mixed = 1;
+		mixed = true;
 
 	flags = BTRFS_BLOCK_GROUP_SYSTEM;
 	ret = create_space_info(fs_info, flags);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (mixed) {
 		flags = BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA;
 		ret = create_space_info(fs_info, flags);
 		if (ret)
-			goto out;
+			return ret;
 	} else {
 		flags = BTRFS_BLOCK_GROUP_METADATA;
 		ret = create_space_info(fs_info, flags);
 		if (ret)
-			goto out;
+			return ret;
 
 		flags = BTRFS_BLOCK_GROUP_DATA;
 		ret = create_space_info(fs_info, flags);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	if (features & BTRFS_FEATURE_INCOMPAT_REMAP_TREE) {
@@ -367,7 +367,6 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 		ret = create_space_info(fs_info, flags);
 	}
 
-out:
 	return ret;
 }
 
-- 
2.47.2


