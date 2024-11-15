Return-Path: <linux-btrfs+bounces-9679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BF09CD6CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 07:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF824B22B4F
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 06:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05317CA1B;
	Fri, 15 Nov 2024 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YdNWrhIc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YdNWrhIc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197E4317C
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650648; cv=none; b=DreMNKuLPWpBc4eLFE+WkuGmMAOgVR/OhNCrOxX4aLYWWFjKI9llVBXtOxUzXCP1ikecHkJZeBZM24BtjqHmOuRtbIuYJVxDkPt+ObUs0hT7X1/h7bVe7asYub6z07g+5CfimbNjCWQXowblZZe9++gWXZyOLSGo+MW+M/DAJaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650648; c=relaxed/simple;
	bh=6QzXF7rkungjTblAYOV3ZXE4Ac2f/uknX/JyBmvMZUw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLYqJdo0ojaAWjQ+9Q3LCWIdBewr82py1RctccV+py8/dXuwsIA8uFo66EiGz+b/F2Ee270yMwvBnTjKsgRAjp8sK+IjLyeAXVjSo+nTrC93IFWIABZIvUFxl7OyRUSdvdh9XVrP6rowT/hXzyx6XygZyoeZ/AK2eLdFe9kq9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YdNWrhIc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YdNWrhIc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 868AB2118B
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731650644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVaYFuZpfjd/rAq0WNN4wIJd/YH5tqnClLopUV9BJKE=;
	b=YdNWrhIc+bbSjTCL6Jy6hfww4LJelMjreYiXk0nBYe0Sd4oZGEgeNpaTqho7G1iR2u13An
	axUwDFQbDRwnD9jJaa3dbuR/2RhkaXrTYoMITOP/f4r2sf25W2EtQ5jPtr4h1gQAw6LtBV
	xkryK0pO77Rwf4GYt1/uEAJEW838pqc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731650644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVaYFuZpfjd/rAq0WNN4wIJd/YH5tqnClLopUV9BJKE=;
	b=YdNWrhIc+bbSjTCL6Jy6hfww4LJelMjreYiXk0nBYe0Sd4oZGEgeNpaTqho7G1iR2u13An
	axUwDFQbDRwnD9jJaa3dbuR/2RhkaXrTYoMITOP/f4r2sf25W2EtQ5jPtr4h1gQAw6LtBV
	xkryK0pO77Rwf4GYt1/uEAJEW838pqc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B45A9134B8
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GCxKHFPkNmdQBgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix the qgroup data free range for inline data extents
Date: Fri, 15 Nov 2024 16:33:43 +1030
Message-ID: <7191cda8e7f4093b165af73dd37cd25e7c565b7d.1731650263.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731650263.git.wqu@suse.com>
References: <cover.1731650263.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Inside function __cow_file_range_inline() since the inlined data no
longer takes any data space, we need to free up the reserved space.

However the code is still using the old page size == sector size
assumption, and will not handle subpage case well.

Thankfully it is not going to cause problem because we have two safe
nets:

- Inline data extents creation is disable for sector size < page size
  cases for now
  But it won't stay that for long.

- btrfs_qgroup_free_data() will only clear ranges which are already
  reserved
  So even if we pass a range larger than what we need, it should still
  be fine, especially there should only be one sector reserved.

But just for the sake of consistentcy, fix the call site to use
sectorsize instead of page size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f8803d9522e7..a0599369ca0c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -711,7 +711,7 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
 	 */
-	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE, NULL);
+	btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
-- 
2.47.0


