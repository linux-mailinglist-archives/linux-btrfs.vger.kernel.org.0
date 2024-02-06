Return-Path: <linux-btrfs+bounces-2183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BEC84C0EA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 00:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5921C21804
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 23:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0782A1C6A5;
	Tue,  6 Feb 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uhD1mKCE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uhD1mKCE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E51CD1B
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262251; cv=none; b=FwUze0Hs7VOtKu6oBUZB+8iIOQFKl7f/ES9paOPTM2ZygeE/tdJgKfzZBqmIPRcWbzCSO/pLHvGaHUUkP3mEheOK8R4glqAvZAhiQ68JkwbeDOUxsWRNej5raaGhu/Z2SQe8XjUBO9sBsVFlNJk3ONCg1XZ+rTWvPLWfPczUu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262251; c=relaxed/simple;
	bh=lMY5lT8oWJ1Knzl4M0UoqNBnrf6w7L14ZhYpxbTPJ/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHNJB3L2pTNLHDDTEMgOnrhrHMhdt/o8QPmvknAFlOL53cWq7vfCgddiPk88oLvSktneJUtPFYuiRpIQz3I/vh3xrHV2YjDJzzgCf9mlf58p52C3ZesuZ/l1sQCsgCdfAN/u3vLw64D6XqgY8gDIfX1M/HZLzFBCAeMHbqlY4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uhD1mKCE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uhD1mKCE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B6B021F68;
	Tue,  6 Feb 2024 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707262246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=stGPSvYspYCVhQGQIOUSWLa67N3Hmy7iFETrP1kugpk=;
	b=uhD1mKCEkSk7DS1ycYUsXEMTcdYnKqTKutLOFlyBWFr8gmx+27bo44/Wx2wut0opRrZvu6
	1xQotsb6h5zTsS8gk1GcNnwaZNXf8rkb+7UYFS/1utMIpAdgB9W1nrnSR2x8hhqtjc2ogY
	gTNZUgEr2+/fVRABqcvG3F8+qxf9UVo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707262246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=stGPSvYspYCVhQGQIOUSWLa67N3Hmy7iFETrP1kugpk=;
	b=uhD1mKCEkSk7DS1ycYUsXEMTcdYnKqTKutLOFlyBWFr8gmx+27bo44/Wx2wut0opRrZvu6
	1xQotsb6h5zTsS8gk1GcNnwaZNXf8rkb+7UYFS/1utMIpAdgB9W1nrnSR2x8hhqtjc2ogY
	gTNZUgEr2+/fVRABqcvG3F8+qxf9UVo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AFEE132DD;
	Tue,  6 Feb 2024 23:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hs28ByXBwmXlVQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 06 Feb 2024 23:30:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: defrag: avoid unnecessary defrag caused by incorrect extent size
Date: Wed,  7 Feb 2024 10:00:42 +1030
Message-ID: <abb506b3d54837f79119cdff6c3e08a61e28eba7.1707259963.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

[BUG]
With the following file extent layout, defrag would do unnecessary IO
and result more on-disk space usage.

 # mkfs.btrfs -f $dev
 # mount $dev $mnt
 # xfs_io -f -c "pwrite 0 40m" $mnt/foobar
 # sync
 # xfs_io -f -c "pwrite 40m 16k" $mnt/foobar.
 # sync

Above command would lead to the following file extent layout:

        item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
                generation 7 type 1 (regular)
                extent data disk byte 298844160 nr 41943040
                extent data offset 0 nr 41943040 ram 41943040
                extent compression 0 (none)
        item 7 key (257 EXTENT_DATA 41943040) itemoff 15763 itemsize 53
                generation 8 type 1 (regular)
                extent data disk byte 13631488 nr 16384
                extent data offset 0 nr 16384 ram 16384
                extent compression 0 (none)

Which is mostly fine. We can allow the final 16K to be merged with the
previous 40M, but it's upon the end users' preference.

But if we defrag the file using the default parameters, it would result
worse file layout:

 # btrfs filesystem defrag $mnt/foobar
 # sync

        item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
                generation 7 type 1 (regular)
                extent data disk byte 298844160 nr 41943040
                extent data offset 0 nr 8650752 ram 41943040
                extent compression 0 (none)
        item 7 key (257 EXTENT_DATA 8650752) itemoff 15763 itemsize 53
                generation 9 type 1 (regular)
                extent data disk byte 340787200 nr 33292288
                extent data offset 0 nr 33292288 ram 33292288
                extent compression 0 (none)
        item 8 key (257 EXTENT_DATA 41943040) itemoff 15710 itemsize 53
                generation 8 type 1 (regular)
                extent data disk byte 13631488 nr 16384
                extent data offset 0 nr 16384 ram 16384
                extent compression 0 (none)

Note the original 40M extent is still there, but a new 32M extent is
created for no benefit at all.

[CAUSE]
There is an existing check to make sure we won't defrag a large enough
extent (the threshold is by default 32M).

But the check is using the length to the end of the extent:

	range_len = em->len - (cur - em->start);

	/* Skip too large extent */
	if (range_len >= extent_thresh)
		goto next;

This means, for the first 8MiB of the extent, the range_len is always
smaller than the default threshold, and would not be defragged.
But after the first 8MiB, the remaining part would fit the requirement,
and be defragged.

Such different behavior inside the same extent caused the above problem,
and we should avoid different defrag decision inside the same extent.

[FIX]
Instead of using @range_len, just use @em->len, so that we have a
consistent decision among the same file extent.

Now with this fix, we won't touch the extent, thus not making it any
worse.

Fixes: 0cb5950f3f3b ("btrfs: fix deadlock when reserving space during defrag")
Reported-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 8fc8118c3225..eb62ff490c48 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1046,7 +1046,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			goto add;
 
 		/* Skip too large extent */
-		if (range_len >= extent_thresh)
+		if (em->len >= extent_thresh)
 			goto next;
 
 		/*
-- 
2.43.0


