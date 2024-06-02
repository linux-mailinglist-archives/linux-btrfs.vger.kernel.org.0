Return-Path: <linux-btrfs+bounces-5390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADA38D7385
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 05:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5651C225C8
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 03:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44C61BF53;
	Sun,  2 Jun 2024 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JBUnA0Yt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JBUnA0Yt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F562BE78
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299970; cv=none; b=m2FroZFOPochoN+ZYb6PgzqiPtGWEIBJobikUuc2wsjY5AP1T2ibdxQESsT57silociUpjoJc2AhrPDdZCE+sl0Kk48VD4K/r4Z03qJ9qk7GBahnvHir8kYgmC0AHTCrHTtssja/NTc5gbI/VIWRX8zECkZr0mPuIM2NJEseFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299970; c=relaxed/simple;
	bh=hN0iZ53KLyPbBVQczw20sabPb4OllUIadR6knD5QovA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYrqNq64HCyAfkTyzqy/3DxCqzbzdz2SUUbK87Y5lQwABrgZVYhIBIwe8Ry/yDaQe0nnp/ZN8mmLtt2P11JrVHsHoD7CTkUuX/gCEfNRViUT+VnZ/KRCqgMXEHbuvgUJmKgcXWXkLqUQYdrpI9CfeKxn/BMxgjpI9K4N2fOL41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JBUnA0Yt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JBUnA0Yt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9046220DD
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 03:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717299959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6ljnJspzZHW4E4racpWtAaHpHlHRPbvh3a0oSS44zs=;
	b=JBUnA0YtTWU1KjneG6A/+Z6Z5vibv0K0lBjq4/UGcfonoNQBogGhyYWvYeV17fwlVHpBw3
	8JFfX14Lz7Yah8lUzc6XvzPT4ssk7QXbz/NxoqmOcSMURAVVloGz/m9WogNwx7xqRrZaNA
	feLIvUMd7qwoPRCcZwa5flG+m947Mnw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717299959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6ljnJspzZHW4E4racpWtAaHpHlHRPbvh3a0oSS44zs=;
	b=JBUnA0YtTWU1KjneG6A/+Z6Z5vibv0K0lBjq4/UGcfonoNQBogGhyYWvYeV17fwlVHpBw3
	8JFfX14Lz7Yah8lUzc6XvzPT4ssk7QXbz/NxoqmOcSMURAVVloGz/m9WogNwx7xqRrZaNA
	feLIvUMd7qwoPRCcZwa5flG+m947Mnw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D64601399C
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 03:45:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Fz8IfbqW2bnOAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 02 Jun 2024 03:45:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: change-csum: handle finished dev-replace correctly
Date: Sun,  2 Jun 2024 13:15:33 +0930
Message-ID: <9de738a44fa38169541ca97ab9994585b5104fe1.1717299366.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717299366.git.wqu@suse.com>
References: <cover.1717299366.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.17 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.03)[55.77%];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: 0.17
X-Spam-Flag: NO

[BUG]
If a btrfs experienced dev-replace, even it's already finished,
btrfstune would refuse to change its csum:

  WARNING: Experimental build with unstable or unfinished features
  WARNING: Switching checksums is experimental, do not use for valuable data!

  Proceed to switch checksums
  ERROR: running dev-replace detected, please finish or cancel it.
  ERROR: btrfstune failed

[CAUSE]
The current dev-replace detection is only checking if we have
DEV_REPLACE item in device tree.
However DEV_REPLACE item will also exist even if a dev-replace finished,
so the existing check can not handle such case at all.

[FIX]
If an dev-replace item is found, further check the state of the item to
prevent false alerts.

Fixes: #798
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index 0780a18b090b..c2972a509914 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -73,16 +73,28 @@ static int check_csum_change_requreiment(struct btrfs_fs_info *fs_info, u16 new_
 	key.type = BTRFS_DEV_REPLACE_KEY;
 	key.offset = 0;
 	ret = btrfs_search_slot(NULL, dev_root, &key, &path, 0, 0);
-	btrfs_release_path(&path);
 	if (ret < 0) {
+		btrfs_release_path(&path);
 		errno = -ret;
 		error("failed to check the dev-reaplce status: %m");
 		return ret;
 	}
 	if (ret == 0) {
-		error("running dev-replace detected, please finish or cancel it.");
-		return -EINVAL;
+		struct btrfs_dev_replace_item *ptr;
+		u64 state;
+
+		ptr = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				     struct btrfs_dev_replace_item);
+		state = btrfs_dev_replace_replace_state(path.nodes[0], ptr);
+		if (state == BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED ||
+		    state == BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED) {
+			btrfs_release_path(&path);
+			error(
+	"running/suspended dev-replace detected, please finish or cancel it");
+			return -EINVAL;
+		}
 	}
+	btrfs_release_path(&path);
 
 	if (fs_info->csum_type == new_csum_type) {
 		error("the fs is already using csum type %s (%u)",
-- 
2.45.1


