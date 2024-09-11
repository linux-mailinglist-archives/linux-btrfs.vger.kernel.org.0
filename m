Return-Path: <linux-btrfs+bounces-7950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC022975CC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 00:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0831C227A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 22:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAED14E2DF;
	Wed, 11 Sep 2024 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UKfEEoAz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UKfEEoAz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9B224CF
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726092028; cv=none; b=obxYLMuyLVEA6afcp7T+pYtC9ukJbnLw4PVKPqS0V4zaTfbRD9DbAR6ikyZn1k+HJNve7tKQHCug20hzxGqJrc1XIRlbGmkA3LLCeiUFi3IOYl0Q5afn9rhzq1R5yUqzi+60OAh3KnDrEKMEmzjYXhLYudzzrnZdkoUmAqXfG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726092028; c=relaxed/simple;
	bh=yWlADvVDAzSmLH1XnmrwlIFbqsduNQLXiWhu/mu6i4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHWy/WNzlXUnQbhmAWSyqAVirMM1+0R1o9HgY3OD+RobIqpEZbQnwX9RG9fZoHxiq1SxTY7Jsn3ePwHL8uVja078zqxGH+m+C4JebaJdLtC3VS88J5iT+kvKJg4l5hi8ICQsePWOHFpHhvkQs6x6JAyq96BlXsx/Ufoz1PACklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UKfEEoAz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UKfEEoAz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB6C01FD08;
	Wed, 11 Sep 2024 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726092023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/f4UmKmZM56VUlzXxvRgFwAcQynb75xbnpv+JLXGiOE=;
	b=UKfEEoAz/w95lAKNmVvEuelOkD62SXeIc8IcC0ApmkLfB5N63qIqVyFKXnlWfkBV/fJIBA
	+gMvjpZT92VhifugagUj8rLHD4d7WP/nBcigAvnWd/ew8eVK134TxS6m38MerW7P9m7/TH
	TCVHoYJ7dqOKQ4tAgeaHEzxT4b+Wyyc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726092023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/f4UmKmZM56VUlzXxvRgFwAcQynb75xbnpv+JLXGiOE=;
	b=UKfEEoAz/w95lAKNmVvEuelOkD62SXeIc8IcC0ApmkLfB5N63qIqVyFKXnlWfkBV/fJIBA
	+gMvjpZT92VhifugagUj8rLHD4d7WP/nBcigAvnWd/ew8eVK134TxS6m38MerW7P9m7/TH
	TCVHoYJ7dqOKQ4tAgeaHEzxT4b+Wyyc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37A2413A6E;
	Wed, 11 Sep 2024 22:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uc1dOvUS4mbKXwAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 11 Sep 2024 22:00:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Neil Parton <njparton@gmail.com>,
	Archange <archange@archlinux.org>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: tree-checker: fix the wrong output of data backref objectid
Date: Thu, 12 Sep 2024 07:30:00 +0930
Message-ID: <8c92c9840a6dfba929d412d4af16db96922fd01f.1726091975.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.955];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,archlinux.org,suse.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.79
X-Spam-Flag: NO

[BUG]
There are some reports about invalid data backref objectids, the report
looks like this:

[  195.128789] BTRFS critical (device sda): corrupt leaf: block=333654787489792 slot=110 extent bytenr=333413935558656 len=65536 invalid data ref objectid value 2543

The data ref objectid is the inode number inside the subvolume.

But in above case, the value is completely sane, not really showing the
problem.

[CAUSE]
The root cause of the problem is the deprecated feature, inode cache.

This feature results a special inode number, -12ULL, and it's no longer
recognized by tree-checker, triggering the error.

The direct problem here is the output of data ref objectid. The value
shown is in fact the dref_root (subvolume id), not the dref_objectid
(inode number).

[FIX]
Fix the output to use dref_objectid instead.

Reported-by: Neil Parton <njparton@gmail.com>
Reported-by: Archange <archange@archlinux.org>
Link: https://lore.kernel.org/linux-btrfs/CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com/
Link: https://lore.kernel.org/linux-btrfs/9541deea-9056-406e-be16-a996b549614d@archlinux.org/
Fixes: f333a3c7e832 ("btrfs: tree-checker: validate dref root and objectid")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Grammar fixes as usual
- Add links to both reports
- Update the commit message to include the root cause
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 634d69964fe4..7b50263723bc 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1517,7 +1517,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 				     dref_objectid > BTRFS_LAST_FREE_OBJECTID)) {
 				extent_err(leaf, slot,
 					   "invalid data ref objectid value %llu",
-					   dref_root);
+					   dref_objectid);
 				return -EUCLEAN;
 			}
 			if (unlikely(!IS_ALIGNED(dref_offset,
-- 
2.46.0


