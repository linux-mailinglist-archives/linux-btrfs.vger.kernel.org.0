Return-Path: <linux-btrfs+bounces-2658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B4860B71
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 08:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AC728739B
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 07:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D514297;
	Fri, 23 Feb 2024 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ea9HbKAK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ea9HbKAK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F412E7D
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674250; cv=none; b=l2ejGJZ8RAdrx8x1p5my+5Bko55WxmYGCM4PXL4v87MTEVfzd/P6/me7LlxGQuS7GwLl2TTUFWnJnVNUJYgza7a1Hk7ExKcyRmb8wGJerDWV8Apy0RG1sVQb44Atp7zpKNX9Txe2j2E/e7jkdrk2GRXzCiD3iY1GuoyR1oTeqH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674250; c=relaxed/simple;
	bh=CrZgHlnLBrnpL3ohIIpBctM4A/NbmGy3eJDHp3xYif0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8196olquWcQFzeU/1ctmfU+igfiajuEhYm65sti5wFIMbiTwkBQID5FWo1HS3/nBlu5wVRFKGkr6HtiBMJoDFdUD7lRi39kUsmhxMNU0HsYsJuXt6b19RIQicSxehw9VAvvXvoRJ8WtyK/LsCbUGWxpyV/FjzhKlUU//OPvHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ea9HbKAK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ea9HbKAK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64C3E21E5A;
	Fri, 23 Feb 2024 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708674241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mDI4x3Eukw47OmUe0/980RlkUhxAPJRzXusiRepqcRk=;
	b=Ea9HbKAKGaD2ZeL+Yf6rf+10Ge6SrdxXE0EsC9hD4WvXG0p4rH4381Y4f2NnFPM7MsMlJy
	ZW5AGuUkWZg9iJZklUO8w6kgR0RxwXsISrvfTW7uhiDwVX+Iy7X6EI/e39nJRUUO74FThT
	mUv2QhXwgkIciLQKbotPPtGIuzxvAAY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708674241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mDI4x3Eukw47OmUe0/980RlkUhxAPJRzXusiRepqcRk=;
	b=Ea9HbKAKGaD2ZeL+Yf6rf+10Ge6SrdxXE0EsC9hD4WvXG0p4rH4381Y4f2NnFPM7MsMlJy
	ZW5AGuUkWZg9iJZklUO8w6kgR0RxwXsISrvfTW7uhiDwVX+Iy7X6EI/e39nJRUUO74FThT
	mUv2QhXwgkIciLQKbotPPtGIuzxvAAY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 696E713776;
	Fri, 23 Feb 2024 07:44:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id DjtzB8BM2GUsKQAAn2gu4w
	(envelope-from <wqu@suse.com>); Fri, 23 Feb 2024 07:44:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Fabian Vogt <fvogt@suse.com>
Subject: [PATCH] btrfs: qgroup: always free reserved space for extent records
Date: Fri, 23 Feb 2024 18:13:38 +1030
Message-ID: <aa1dd06ced5ae3d775646ffa2eff05d0ce6da6df.1708674214.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.2
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

[BUG]
If qgroup is marked inconsistent (e.g. caused by operations needing full
subtree rescan, like creating a snapshot and assign to a higher level
qgroup), btrfs would immediately start leaking its data reserved space.

The following script can easily reproduce it:

 mkfs.btrfs -O quota -f $dev
 mount $dev $mnt
 btrfs subv create $mnt/subv1
 btrfs qgroup create 1/0 $mnt

 # This snapshot creation would mark qgroup inconsistent,
 # as the ownership involves different higher level qgroup, thus
 # we have to rescan both source and snapshot, which can be very
 # time consuming, thus here btrfs just choose to mark qgroup
 # inconsistent, and let users to determine when to do the rescan.
 btrfs subv snapshot -i 1/0 $mnt/subv1 $mnt/snap1

 # Now this write would lead to qgroup rsv leak.
 xfs_io -f -c "pwrite 0 64k" $mnt/file1

 # And at unmount time, btrfs would report 64K DATA rsv space leaked.
 umount $mnt

And we would have the following dmesg output for the unmount:

 BTRFS info (device dm-1): last unmount of filesystem 14a3d84e-f47b-4f72-b053-a8a36eef74d3
 BTRFS warning (device dm-1): qgroup 0/5 has unreleased space, type 0 rsv 65536

[CAUSE]
Since commit e15e9f43c7ca ("btrfs: introduce
BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting"),
we introduce a mode for btrfs qgroup to skip the timing consuming
backref walk, if the qgroup is already inconsistent.

But this skip also covered the data reserved freeing, thus the qgroup
reserved space for each newly created data extent would not be freed,
thus cause the leakage.

[FIX]
Make the data extent reserved space freeing mandatory.

The qgroup reserved space handling is way cheaper compared to the
backref walking part, and we always have the super sensitive leak
detector, thus it's definitely worthy to always free the qgroup
reserved data space.

Fixes: e15e9f43c7ca ("btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting")
Reported-by: Fabian Vogt <fvogt@suse.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1216196
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3846433d83d9..b3bf08fc2a39 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2957,11 +2957,6 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 				ctx.roots = NULL;
 			}
 
-			/* Free the reserved data space */
-			btrfs_qgroup_free_refroot(fs_info,
-					record->data_rsv_refroot,
-					record->data_rsv,
-					BTRFS_QGROUP_RSV_DATA);
 			/*
 			 * Use BTRFS_SEQ_LAST as time_seq to do special search,
 			 * which doesn't lock tree or delayed_refs and search
@@ -2985,6 +2980,11 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 			record->old_roots = NULL;
 			new_roots = NULL;
 		}
+		/* Free the reserved data space */
+		btrfs_qgroup_free_refroot(fs_info,
+				record->data_rsv_refroot,
+				record->data_rsv,
+				BTRFS_QGROUP_RSV_DATA);
 cleanup:
 		ulist_free(record->old_roots);
 		ulist_free(new_roots);
-- 
2.43.2


