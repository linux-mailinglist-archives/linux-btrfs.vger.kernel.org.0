Return-Path: <linux-btrfs+bounces-20827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODyuFDS3cGlwZQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20827-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:23:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9D355F07
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDFCC688D69
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B7481248;
	Wed, 21 Jan 2026 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD24sv+N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51248122C
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994052; cv=none; b=JZs2uO1OScm8qYLQEXTZ2i9Vu217V78WLDEjGIKuTny2gNLL17CxxHWsMo/YPVN6DH4j0/+TwsdwRIeO7NNtX7O00l8/fsNLT6H/PvF9Xbo9NYCPFLdfK9IMcR6CgjNLHIQ7ov0Fb6h16cdtw21wj24BK0/e594plqmDUvOjyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994052; c=relaxed/simple;
	bh=4M+9R5CziadNALs948lx2cTnTC0LKbQM7m4OnXn1Qe4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lH+PkbM5tnZFihfDIfjJSP0/fCZwhWgD6NcPLamBF/O1h/1qlJ1vcCPodEuY4Beim5G16yg6bSedGxpxMUmRFP3mdNpzMAaS6fnrb7RetOmZ/bwokhRXxGj6vmHELatZ8fbOXWlxg2afSy2SPK5MZQADVHnircdueMUZGyYfcOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD24sv+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D622C116D0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994052;
	bh=4M+9R5CziadNALs948lx2cTnTC0LKbQM7m4OnXn1Qe4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jD24sv+N2bo7Qpq9aSvlZ2Yl/6+PEt9LooR+NZ5ru542sXYJxfwG0218NIgsTbdoF
	 P0vKwuGVNjaIO4AzXDmf14vsS9jCkSOuRNJsCCTE6GHACKCZV+ntWXIXykS3enUhRl
	 oYYvKsZSx6XrsCFZKEUj0lRmpM3fjhEaW4ZwDzP0TbEkBTfspB6UZp1HDirFukl2U8
	 TtqUJGB4uMaTps4+nk3Qn0oO150OPa9OHb45w1rgqEgIkXfC08syi13OnyuMRc7aw1
	 u3ZANMxXi9qxivrpW8tynxngEC3JE3W5ep5Tt1TVIXbo/g2hepHM3GgCRllWcoevE+
	 Et8v0a7OTkehQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 17/19] btrfs: remove out label in btrfs_check_rw_degradable()
Date: Wed, 21 Jan 2026 11:13:51 +0000
Message-ID: <54673512f7b4ba245b28a02405454d282278547c.1768993725.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20827-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: DA9D355F07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There is no point in having the label since all it does is return the
value in the 'ret' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index af0197b242a7..cff2412bc879 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7576,10 +7576,9 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 
 	map = btrfs_find_chunk_map(fs_info, 0, U64_MAX);
 	/* No chunk at all? Return false anyway */
-	if (!map) {
-		ret = false;
-		goto out;
-	}
+	if (!map)
+		return false;
+
 	while (map) {
 		int missing = 0;
 		int max_tolerated;
@@ -7604,15 +7603,14 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 	"chunk %llu missing %d devices, max tolerance is %d for writable mount",
 				   map->start, missing, max_tolerated);
 			btrfs_free_chunk_map(map);
-			ret = false;
-			goto out;
+			return false;
 		}
 		next_start = map->start + map->chunk_len;
 		btrfs_free_chunk_map(map);
 
 		map = btrfs_find_chunk_map(fs_info, next_start, U64_MAX - next_start);
 	}
-out:
+
 	return ret;
 }
 
-- 
2.47.2


