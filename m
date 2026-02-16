Return-Path: <linux-btrfs+bounces-21679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP2BEj1mkmnstgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21679-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 01:35:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB214077E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 01:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5733A3017C30
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 00:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3270A239086;
	Mon, 16 Feb 2026 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="imBVSjE4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87F2236F0;
	Mon, 16 Feb 2026 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771202092; cv=none; b=i29G6XerVzvsQLST8KzIMiK9ky0VZFuiudI1hWwMCCXz+qNObvzcKsdf/M7X8lIhaH/Tv+kNuaei2Mw6fQuML8CL1FzLcnBMBbfC7UEKrQHpLfk20fPJsepbUddXp7HEDV17isZRZ/NQtskrMsHWCQf5UXnNJMcUSq1wCSBkAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771202092; c=relaxed/simple;
	bh=VqFvRxho8VA+YCnshjrjcmu5jJgtaDGAFs9DLGm9D/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CloOWGPNTlqq+5UJ1N/C5GWRZMpYJl6ZUpyz3FDrioTY3+zlUiCJnWRPUE1Fv9BGGEtV2rbKJPAKJiJlS/YXO5C/k1u3URUfn7ocGLpuHtJ3qMtBehBvVrcCk/aN1/o3pLzhVkDSm6Bk2kfD/RSfM2osgGEMFMMhJqkder4L1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=imBVSjE4; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fDkCB5slMz9vDZ;
	Mon, 16 Feb 2026 01:28:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771201702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3TnjK7qYNgBfJ/MTf8UmRV2LSkQ+Wf2L1+Dp7kyuKdQ=;
	b=imBVSjE4Y1MKAL8U8hhAS8eE5WV0PsU6bfSzGm+bxlIDdaEOXv6xLo18MNluIatjjIgDp/
	lld3+ub0Fwvzfd96j1gZeUlAxSRtCdnNrH1Y6gB+o2UBuHmlGE/eHA96OASSQ1wH/+NP7T
	GEY9eG+I5XF7xMTFc16cUoRNRRF9UMVYFuY4yk6No0EdxzlzyP5si5r8x7w6mHQG36WFYA
	JUz130HsZK/8JrzujOTxXRLbA+X+LdO5NXm7bj1PJjVDyBnSlNd2yAJahFb4EN7BHUCVHQ
	yWhT+6jPQsxdducfgHPzYBVt7Z8XlppGgbMarKq4BzspXfm2LQXvmeTA3A+s3A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::2 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: dsterba@suse.com
Cc: clm@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH] btrfs: report filesystem shutdown via fserror
Date: Mon, 16 Feb 2026 01:28:06 +0100
Message-ID: <20260216002806.3831884-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.25 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.91)[subject];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21679-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mssola.com:mid,mssola.com:dkim,mssola.com:email]
X-Rspamd-Queue-Id: E8EB214077E
X-Rspamd-Action: no action

Commit 347b7042fb26 ("Merge patch series "fs: generic file IO error
reporting"") has introduced a common framework for reporting errors to
fsnotify in a standard way.

One of the functions being introduced is 'fserror_report_shutdown' that,
when combined with the experimental support for shutdown in btrfs, it
means that user-space can also easily detect whenever a btrfs filesystem
has been marked as shutdown.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
Note that the for-next branch does not include the mentioned commit. I've
built and tested this patch on top of current Linus' tree.

 fs/btrfs/fs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 3de3b517810e..92fcebf5766e 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -33,6 +33,7 @@
 #include "async-thread.h"
 #include "block-rsv.h"
 #include "messages.h"
+#include <linux/fserror.h>

 struct inode;
 struct super_block;
@@ -1199,8 +1200,10 @@ static inline void btrfs_force_shutdown(struct btrfs_fs_info *fs_info)
 	 * So here we only mark the fs error without flipping it RO.
 	 */
 	WRITE_ONCE(fs_info->fs_error, -EIO);
-	if (!test_and_set_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info->fs_state))
+	if (!test_and_set_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info->fs_state)) {
 		btrfs_crit(fs_info, "emergency shutdown");
+		fserror_report_shutdown(fs_info->sb, GFP_KERNEL);
+	}
 }

 /*
--
2.53.0

