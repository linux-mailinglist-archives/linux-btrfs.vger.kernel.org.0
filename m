Return-Path: <linux-btrfs+bounces-10787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08642A051B4
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 04:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9E2188A2C9
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E086C19CC27;
	Wed,  8 Jan 2025 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CfXh+D8N";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CfXh+D8N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5352B9B9
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736307868; cv=none; b=FEPTO8Ogqy1pH5nGtEhTYUgjdGs9vkcEaZT3ArGmfjSxybUtwUFxu76s5Yg0B360QOX42K5ubeVOdqlOu4Ka65RYuGvccozKiAz7GonvowOVlKmfqJBNNkuaC2Mymv/o9SUGl140CtWrJ1prf1YcOxPURMtQPWTRfw7MqyBhp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736307868; c=relaxed/simple;
	bh=9hCIbBXEJ4//hr1obb8LJCWoGagtThKeb9E2ZeY995U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEl1CG8vPQ20fFmEZi2PrNwQQWTAj0UyZZRGk5dnK/7gS8ae2mtWxq4aX3Rt2tvmiVJVI2E0wwefQ2Jl26YT6fv/cxiWCPrL6Wuac6MKdSR1U7LSqDUgxwKCXoElldaxBdGcAxvalYaBPJXlWnN6SXOrBAEXtRn6WCDOlW+Spyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CfXh+D8N; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CfXh+D8N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F7ED210F3;
	Wed,  8 Jan 2025 03:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736307863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Boymny99ry4Orkl2gCcMIPhbU3QzsnUF/74gk5attC8=;
	b=CfXh+D8N2B0bFqIRFKB02iSTjNmYZrCzzA+t58vAeH6i0L2xW90RAuKv3fwU45CCSdr969
	IsyJzwPXmjjmnGKomMADbZ3mV8R1/NVOeen4lek469boca9It5XG2mEVVTBdyAhSAQHYyh
	JsHQy4i5srssTmSWHIKHnREpzsuf9iE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736307863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Boymny99ry4Orkl2gCcMIPhbU3QzsnUF/74gk5attC8=;
	b=CfXh+D8N2B0bFqIRFKB02iSTjNmYZrCzzA+t58vAeH6i0L2xW90RAuKv3fwU45CCSdr969
	IsyJzwPXmjjmnGKomMADbZ3mV8R1/NVOeen4lek469boca9It5XG2mEVVTBdyAhSAQHYyh
	JsHQy4i5srssTmSWHIKHnREpzsuf9iE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B3571387C;
	Wed,  8 Jan 2025 03:44:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hrw5B5b0fWdgDgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 08 Jan 2025 03:44:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH] btrfs: add the missing error handling inside get_canonical_dev_path
Date: Wed,  8 Jan 2025 14:14:04 +1030
Message-ID: <60f37e9b853b0c37f6e1895658bd2500b27a93ad.1736307675.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Inside function get_canonical_dev_path(), we call d_path() to get the
final device path.

But d_path() can return error, and in that case the next strscpy() call
will trigger an invalid memory access.

Add back the missing error handling for d_path().

Reported-by: Boris Burkov <boris@bur.io>
Fixes: 7e06de7c83a7 ("btrfs: canonicalize the device path before adding it")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d..3d0ac8bdb21f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -797,6 +797,10 @@ static int get_canonical_dev_path(const char *dev_path, char *canonical)
 	if (ret)
 		goto out;
 	resolved_path = d_path(&path, path_buf, PATH_MAX);
+	if (IS_ERR(resolved_path)) {
+		ret = PTR_ERR(resolved_path);
+		goto out;
+	}
 	ret = strscpy(canonical, resolved_path, PATH_MAX);
 out:
 	kfree(path_buf);
-- 
2.47.1


