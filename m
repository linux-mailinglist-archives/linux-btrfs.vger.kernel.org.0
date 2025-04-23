Return-Path: <linux-btrfs+bounces-13277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56514A9800E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 09:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661F03BED20
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 07:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29F71F4171;
	Wed, 23 Apr 2025 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BY14dd1k";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BY14dd1k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A822676D9
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392000; cv=none; b=lHAP80lBbXJJf+J57tKuIdy3mIcl+ZwoSvBC0VEQep0L48WONxxakejG7JncOSmlMlUx2ydrJN4gwJIvzc1c3ipF0f0QNMjqZEA0zTkmaKgHuYgG6geFk8I9QY6V8uCrCeQ31dpTWQNAG9J2EUzuo1NbOoz+dExYuADXrjpZ2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392000; c=relaxed/simple;
	bh=YnCcBRqDYy+MXbqJy0Rv7Stx5hPGv/UpmoT8/isxrzg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kiuagtUM92TXo7ZlFQp09bFqU4YFw4dh2yAFbgq8Ak5ag3qvUmnpniWzHKbLFgfWW6zA/Wzs/E4zbQ5Jsjvbn2TmR/2tfCj+1J3VfVwlxfigP2E9g6UCtdzMYty0RIqA36ZHHf5Ho8GIhNRNUxZ69ee7fwQqTh1lesbV+ejExiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BY14dd1k; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BY14dd1k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97D16211A7
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 07:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745391992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SzAjRfRbQ2Jc8zyJt3SlgzEOZoDu5Vv3qxpHXyH/tVo=;
	b=BY14dd1knNnxQyRDLQV0pFvXQmEZyeUNWbKh8x7OANUI476Ii+ej0ZM3VReKYdBRIrjmqk
	Bc+MTtMtQvD0jywr3iqzowPRwuFj4Sxp5Zy1ECyiMpwgbo5rrp+ogfS9TuztvKDnGl95+Z
	ThAP/PrVTonpThlE+864td2K4bB83+s=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745391992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SzAjRfRbQ2Jc8zyJt3SlgzEOZoDu5Vv3qxpHXyH/tVo=;
	b=BY14dd1knNnxQyRDLQV0pFvXQmEZyeUNWbKh8x7OANUI476Ii+ej0ZM3VReKYdBRIrjmqk
	Bc+MTtMtQvD0jywr3iqzowPRwuFj4Sxp5Zy1ECyiMpwgbo5rrp+ogfS9TuztvKDnGl95+Z
	ThAP/PrVTonpThlE+864td2K4bB83+s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D91A113A3D
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 07:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GP3RJneRCGhdXgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 07:06:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: subpage: reject tree blocks which are not node size aligned
Date: Wed, 23 Apr 2025 16:36:14 +0930
Message-ID: <91dc04836a16638e97df7cd50aad462b20400a47.1745391961.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
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

When btrfs subpage support (fs block < page size) is introduced, a subpage
btrfs will only reject tree blocks which cross page boundaries.

This used to be a compromise to simplify the tree block handling and
still allows subpage cases to read some old converted btrfses which do
not have proper chunk alignment done.

But in practice, if we have the following unaligned tree block on a 64K
page sized system:

  0                           32K           44K             60K  64K
  |                                         |///////////////|    |

Although btrfs has no problem reading the tree block at [44K, 60K), if
extent allocator is allocating another tree block, it may choose the
range [60K, 74K), as extent allocator has no awareness if it's a subpage
metadata request.

Then we got -EINVAL from the following sequence:

 btrfs_alloc_tree_block()
 |- btrfs_reserve_extent()
 |  Which returned range [60K, 74K)
 |- btrfs_init_new_buffer()
    |- btrfs_find_create_tree_block()
       |- alloc_extent_buffer()
          |- check_eb_alignment()
	     Which returned -EINVAL, because the range crosses the page
	     boundary.

This situation will not solve itself and should mostly mark the fs
read-only.

Thankfully we didn't really get such reports in the real world because:

- The original unaligned tree block is only caused by older
  btrfs-convert
  It's before the btrfs-convert rework done in v4.6, where converted
  btrfs can have metadata block groups which are not aligned to
  node size nor stripe size (64K).

  But after btrfs-progs v4.6, all chunks allocated will be stripe (64K)
  aligned, thus no more such problem.

Considering how old the fix is (v4.x), meanwhile subpage support for
btrfs is only introduced in v5.15, it should be safe to reject those
unaligned tree blocks.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 152bf042eb0f..6f2c468cf741 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3070,9 +3070,9 @@ static bool check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 	}
 
 	if (fs_info->nodesize < PAGE_SIZE &&
-	    offset_in_page(start) + fs_info->nodesize > PAGE_SIZE) {
+	    !IS_ALIGNED(start, fs_info->nodesize)) {
 		btrfs_err(fs_info,
-		"tree block crosses page boundary, start %llu nodesize %u",
+		"tree block is not node size aligned, start %llu nodesize %u",
 			  start, fs_info->nodesize);
 		return true;
 	}
-- 
2.49.0


