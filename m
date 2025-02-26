Return-Path: <linux-btrfs+bounces-11828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEB4A4543D
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 05:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E129188F560
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 04:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243D6267720;
	Wed, 26 Feb 2025 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZJUIUvvS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZJUIUvvS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7525E464
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542394; cv=none; b=J1uDj2fJR/VlqYQAYPPZpwodDQ6ACeBcbaNnSjlzPHUkNElIZjMWERUPWs2gjVrQgT/+nMgAPm/Qsl67GD78bjjT6KOWM95en/ZaAhS+LvlCaYoY3yX5olhjv7lWd8/2m5xgUXcN2rS1zsxQ699aT6GPqxtnU6heRQeckOa3Oos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542394; c=relaxed/simple;
	bh=m7yEfoxYEx0FZr2uJaJWk2gY3QoZIzp9sbv6V1wi00A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdnR7zq3J9UwfKTCIA2Ux0tMjb4Df/9L5shdKRIVyH2ncbE93ll26LsQSM3ZDdUV8RiI016ZrghC5COwzbYr90zqT8vEwEHXZF6O4IkcImS836Q7+4zSAlSOvWdiiRsHZtvVc9xXDhJU0EjobEczftxBS4GfvqP+WnQKNF1SSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZJUIUvvS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZJUIUvvS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23A491F388
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740542383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=En/FjS+LZQylCdidz9Dzq92NwF7ZETNjDp4KdFqldzw=;
	b=ZJUIUvvSJ6wghM05VTosxsP9/dFZVGwMZHUokfKuWUZ2PJm4rErDg8U8LO82HIAoQvYtmN
	d49wEyubhlGGfot8pX2ivShiCKzCuKJWvybUZizkxwNY/LPjh5XGhbEY5FfgM0D4mjPjFc
	6CBvSXEGrW75/BM7vuwY7LA8enCoaqg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740542383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=En/FjS+LZQylCdidz9Dzq92NwF7ZETNjDp4KdFqldzw=;
	b=ZJUIUvvSJ6wghM05VTosxsP9/dFZVGwMZHUokfKuWUZ2PJm4rErDg8U8LO82HIAoQvYtmN
	d49wEyubhlGGfot8pX2ivShiCKzCuKJWvybUZizkxwNY/LPjh5XGhbEY5FfgM0D4mjPjFc
	6CBvSXEGrW75/BM7vuwY7LA8enCoaqg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58E3013404
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KPh0Bq6RvmdOegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: fix the incorrect buffer size for super block
Date: Wed, 26 Feb 2025 14:29:15 +1030
Message-ID: <aeb365337a8e4a4a4df1689f428b34cec27c7392.1740542229.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740542229.git.wqu@suse.com>
References: <cover.1740542229.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Inside the function btrfs_add_to_fsid(), we allocate a buffer to write
the superblock to the disk.

However the buffer size is based on block size, which can cause two
problems:

- 2K block size
  The block size is too small for the super block, and we will write
  beyond the buffer and corrupt the memory.

- 16/64K block size
  The block size will be larger than super block size, this will not
  cause any problem but waste some memory.

Fix the bug by using BTRFS_SUPER_INFO_SIZE as the correct buffer size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/device-scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/device-scan.c b/common/device-scan.c
index a34d86652f06..7d7d67fb5b71 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -148,7 +148,7 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 	if (!device)
 		return -ENOMEM;
 
-	buf = calloc(1, sectorsize);
+	buf = calloc(1, BTRFS_SUPER_INFO_SIZE);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.48.1


