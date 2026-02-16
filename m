Return-Path: <linux-btrfs+bounces-21678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFEbLYhjkmmhtgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21678-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 01:23:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D314071C
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 01:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 252C23002F63
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 00:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF21A23AC;
	Mon, 16 Feb 2026 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="Ej1Yshya"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD422256F;
	Mon, 16 Feb 2026 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771201409; cv=none; b=ewCc20SzfdTTVEjs5eT2LRF5w4tKRTTsw0qYD+Voh6WRQv/I2Ucr9qjC/14RdRfFBhdD5m82JPxqv5vGGIm3imLVBaJftUUHrx9yLJL4JKPjN2ucCBc6tV+e7XEq05H4zJvRgwtV6VT+4TMvbh0vOw+JWQ9jSGvKKa2ariXi2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771201409; c=relaxed/simple;
	bh=75yXZQYYUW/j2rwOw1lzp3Dl0K1bElClMYuoKv++l+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hlHx2Dd9RlLqVoXfZWpT0hiXVZMdOT8sFuXcRaOPfEFoSMCKRIZyVJD7uXZKP3GteHs3sOb4a/TUYUYR5NFT2aNiOt6DStmhmVOU0O3xzcy7y4o9GcznLTQgaa0VC3cr1WCfWGUJKLSxnsRytrovkuJ0eA5fg8PFqy1dI4naZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=Ej1Yshya; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fDk5J2Y3xz9tWy;
	Mon, 16 Feb 2026 01:23:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771201396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mA66zdZr3R9Q3RU2aqPxaLZwEjVI0SzlOQ18aZ09PAA=;
	b=Ej1YshyavVtiW+Rw4CpHLrNUaej0SAZsP1QyfCZZT5jswE7U0hexHxwxMHD4EuLwPOtBu6
	s4O23eENx1Nk+wAsTFIAslciRu0oyY2sH2+q0cidaYnCuzVcXM+kHPBtY8cRSDMLELnzrZ
	cGNAq6VS9m02eOkCetp5FZK2hnxs+trD3d9RqX6tskTIYRaVfFtlKVJXHHC6AHkblqy1gt
	nldF45xY2ETVz5wVjgdEaQMZHYRockYz1JMDJXQ2sF3dDie64MXgtwaMgC5a0xX7qQjePP
	uoLBAbpeJOiHb/X+kCvTu4FU/x90KpLdqbKqeQcIk3+VHisAx5KmjNdLJ5XzOw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::102 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: dsterba@suse.com
Cc: clm@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH] btrfs: don't commit the super block when unmounting a shutdown filesystem
Date: Mon, 16 Feb 2026 01:22:52 +0100
Message-ID: <20260216002252.3831277-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21678-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mssola.com:mid,mssola.com:dkim,mssola.com:email]
X-Rspamd-Queue-Id: D84D314071C
X-Rspamd-Action: no action

When unmounting a filesystem we will try, among many other things, to
commit the super block. On a filesystem that was shutdown, though, this
will always fail with -EROFS as writes are forbidden on this context;
and an error will be reported.

Don't commit the super block on this situation, which should be fine as
the filesystem is frozen before shutdown and, therefore, it should be at
a consistent state.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/disk-io.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 600287ac8eb7..cd2ce6348d88 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4380,9 +4380,18 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 		 */
 		btrfs_flush_workqueue(fs_info->delayed_workers);
 
-		ret = btrfs_commit_super(fs_info);
-		if (ret)
-			btrfs_err(fs_info, "commit super ret %d", ret);
+		/*
+		 * If the filesystem is shutdown, then an attempt to commit the
+		 * super block (or any write) will just fail. Since we freeze
+		 * the filesystem before shutting it down, the filesystem should
+		 * be in a consistent state and not committing the super block
+		 * should be fine.
+		 */
+		if (!btrfs_is_shutdown(fs_info)) {
+			ret = btrfs_commit_super(fs_info);
+			if (ret)
+				btrfs_err(fs_info, "commit super ret %d", ret);
+		}
 	}
 
 	kthread_stop(fs_info->transaction_kthread);
-- 
2.53.0


