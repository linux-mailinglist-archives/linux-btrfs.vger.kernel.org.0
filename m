Return-Path: <linux-btrfs+bounces-15787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B59B1794E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 01:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3D94E824C
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 23:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E0F27F000;
	Thu, 31 Jul 2025 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Sq2piSjT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RpM8om7h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1727E7FC
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003463; cv=none; b=Dscq7XsGkITfKCiYIJ0LRJqoRQUnRfT1Bnk2v2iLJDAZc7Q76uM0TT02aYZZMv80DaizVH5NXM5lP7KBd7GvrnqrIX2xi6YyBNLifDsj2FunbijqaC2I8OdYfigUMulA9rWvAesGkJLDRO5YH4OG/X+pbf7XJtjlOOb/hVeQ4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003463; c=relaxed/simple;
	bh=w5j1uP07We/FB93+vzaps0k+/8Ig4cwlDfXk2cEgb5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pTLHhmTtW4rCXjpWJ8aMG+W/dPR8P1OFRCafrZ6heRJQFcLbqL2KqYxHWXUl9s22LLEAgKFILjUz8INmLEpGGE05UPX+rlFc7ew1s/bAEd680992Wo8kMzr29cWY1eu7rVKQUOIoVZljMmJwwK86tvJffz2FIQa3Nc+jGXiCt+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Sq2piSjT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RpM8om7h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8C961F7ED
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754003458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DmLb4obz66tdC+6CjbIZmqUtlEUG0lAsOIumXHhyLHo=;
	b=Sq2piSjT78X+omHlsUA73aWwlw0HdicnY05teRxjtA5V++Hp3s1kZTYKu15Rt5MgfmDU71
	gbyR+1kMBrUYhJAWhMLk0mnAVJyOX4Pg6nG26VmDbrBtywaC3WUlpFqWGMkX8vtz4ozfBK
	mU7S675Qd8+T6Q2oq9tk9QWm9TASgOI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754003457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DmLb4obz66tdC+6CjbIZmqUtlEUG0lAsOIumXHhyLHo=;
	b=RpM8om7hSZ7MzozXUx9xjHt7ttdOFEx3pv8MSzf+KFdldFtJZr4sUICUprirhBKIN6INgJ
	YkGBVIwd4HlbKn59Ai9tBmZ3+NK4LBq5uavQ4a1YlMP6nRzURjcPeRcX8M2c1d0lUXgp75
	mYdcWX8yCTCFK6GDJ7wikJZCsVeg+lo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E569D13876
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 23:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +fXoKAD4i2iBDwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 23:10:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: subvolume: fix a bug that leads to unnecessary error message
Date: Fri,  1 Aug 2025 08:40:39 +0930
Message-ID: <f72a754b3e1b4e6b7ef09ed6451166ccbd9103af.1754003430.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[BUG]
When a btrfs is mounted with "user_subvol_rm_allowed" mount option,
unprivileged users are allowed to delete a subvolume using "btrfs
subvolume delete" command.

But in that case, there is always a warning message:

 $ btrfs subvolume delete /mnt/btrfs/dir1/subv1/
 WARNING: cannot read default subvolume id: Operation not permitted
 Delete subvolume 257 (no-commit): '/mnt/btrfs/dir1/subv1'

[CAUSE]
The warning message is caused by tree search ioctl, which is to
determine if we're deleting the default subvolume.
This search is just to give a more helpful error message, and even
without it deleting the default subvolume will fail anyway.

Thus commit 0e66228959c4 ("btrfs-progs: subvol delete: hide a warning on
an unprivileged delete") tries to hide the warning for unprivileged
users.

But unfortunately the function geteuid() returns the effective user id,
thus we should hide the warning for non-zero uid, not the opposite.

[FIX]
Change the condition to output the warning only when the uid is 0.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/subvolume.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 08918c1efbb5..3523fc410835 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -498,7 +498,7 @@ again:
 	default_subvol_id = 0;
 	err = btrfs_util_subvolume_get_default_fd(fd, &default_subvol_id);
 	if (err == BTRFS_UTIL_ERROR_SEARCH_FAILED) {
-		if (geteuid() != 0)
+		if (geteuid() == 0)
 			warning("cannot read default subvolume id: %m");
 	}
 
-- 
2.50.1


