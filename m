Return-Path: <linux-btrfs+bounces-17173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F6B9E836
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 11:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9D64A5199
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235832877F6;
	Thu, 25 Sep 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lDqG56sj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lDqG56sj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC77286D73
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794033; cv=none; b=ZZj21Kw4CvZif0LCMGACtoeg94s2/nosdZYeWYKT4MOuuuqByTW2SvbyP69qJGk5aFqX7oNw30fmGlVttaROGtyhWSG4kGV1pnmXE/MWzJtgDlNvje/RgE6dOR6Qwpv6j8FbdRKYidOjciy6MVExJnPSRfjHGVdS4Hg7+kYyvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794033; c=relaxed/simple;
	bh=X1CdIWAmPe9TZX78wOdFggE6AWSDSCxc2f/MDqDsDLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQiiuyUx9o/sY+nXg8VKxXoQJzHPwYno2NrSIbZvGcWdq8ZeB7tXCZI1g7SjnMqAMZq24anVlaxP0GULnXQyPH64V08JMZWUSZ/wbYljVm8oYKFFadAHy8Nv6XTLH5Zcn/0gBUu4puYX71AF+nY408GUprqAx6ao04FH2+PpoE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lDqG56sj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lDqG56sj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 899E54E80B;
	Thu, 25 Sep 2025 09:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758794029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3tyzvEjk14c0GPmM8WuJYAEaZGBtjRaKMWs8E7JuwEU=;
	b=lDqG56sjbDwLmGIfNhiFAS8dh8uONEfy7KR8KJ0tqebXv44UMeGQ9WTK2xFShEPupC+Tzz
	XJ+LOsoe3NAJ7EhzjmgJaBpfEIbEmwTAVXdaK4IOKxoy1XQzLZKYi8HhGQWMV3VETnc5TN
	qH9rELtLuAiVMWt2fWHwPBZhuVtd/vY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758794029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3tyzvEjk14c0GPmM8WuJYAEaZGBtjRaKMWs8E7JuwEU=;
	b=lDqG56sjbDwLmGIfNhiFAS8dh8uONEfy7KR8KJ0tqebXv44UMeGQ9WTK2xFShEPupC+Tzz
	XJ+LOsoe3NAJ7EhzjmgJaBpfEIbEmwTAVXdaK4IOKxoy1XQzLZKYi8HhGQWMV3VETnc5TN
	qH9rELtLuAiVMWt2fWHwPBZhuVtd/vY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50FCC13869;
	Thu, 25 Sep 2025 09:53:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +k4/BSwR1WjWYgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 25 Sep 2025 09:53:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] btrfs: remove the unnecessary NULL fs_info check from find_lock_delalloc_range()
Date: Thu, 25 Sep 2025 19:23:22 +0930
Message-ID: <686d2506851c2df8cb9ceab5241b15bb01737ebb.1758793968.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[STATIC CHECK REPORT]
Smatch is reporting that find_lock_delalloc_range() used to do a null
pointer check before accessing fs_info, but now we're accessing it for
sectorsize unconditionally.

[FALSE ALERT]
This is a false alert, the existing null pointer check is introduced in
commit f7b12a62f008 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with
fs_info->max_extent_size"), but way before that, commit 7c0260ee098d
("btrfs: tests, require fs_info for root") is already forcing every
btrfs_root to have a correct fs_info pointer.

So there is no way that btrfs_root::fs_info is NULL.

[FIX]
Just remove the unnecessary NULL pointer checker.

Fixes: f7b12a62f008 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202509250925.4L4JQTtn-lkp@intel.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9bea6ff0b3b9..1ee8120ff5be 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -374,8 +374,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	const u64 orig_start = *start;
 	const u64 orig_end = *end;
-	/* The sanity tests may not set a valid fs_info. */
-	u64 max_bytes = fs_info ? fs_info->max_extent_size : BTRFS_MAX_EXTENT_SIZE;
+	u64 max_bytes = fs_info->max_extent_size;
 	u64 delalloc_start;
 	u64 delalloc_end;
 	bool found;
-- 
2.50.1


