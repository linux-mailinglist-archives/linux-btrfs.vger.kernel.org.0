Return-Path: <linux-btrfs+bounces-9404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C439C349C
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2024 22:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0011C21011
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2024 21:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE97146A62;
	Sun, 10 Nov 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eoWBRW7R";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eoWBRW7R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB57224D6
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731272423; cv=none; b=oq/iAaXQrb7Oq7wF/x7GtRYqyjGRvhC0HIm0VnKU5AJo4PBskplQBBC2mWhAmjziZ8jub8LjZE3RlXz1+y+5IiwppJlXcJqBWkjVV6B10dS+kVtmcFQzS85+5C9h66tnRPUt4O/minwQw9deKPWBNH5V0vplhR3YpRxRFgXQsiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731272423; c=relaxed/simple;
	bh=FixqHOl21Yj/BN9b4yRkiRbablkO54/BziuEhxX5ONo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nFnP7RJflxXGZgCE+qH1y8KOcly3jLT+B+rm1rbbCHwFLcjcl4LZ2Iz4FDbaIKEhYqgGwTWTwDHKEb0HcI15at+HmvT8GfICudnKH2qJ4aSg2qaBa3V4K2KkgPgBQwoDn0MrwyUGLTSs6vjxeto9BEg1eW+DJFIMXJsTr3lXLV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eoWBRW7R; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eoWBRW7R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58DA11F38E
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2024 21:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731272419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=d0DgH2DHf2GTn5JYMkPQF6XcDDyXKl7bHbyawBprUq0=;
	b=eoWBRW7RrsgY8KotJT66NmiYBLAPuq7wH/YN5DtXHhLFQsZmPu1hnlARW9IJ2Hk58DeeC2
	6pwDaYgn/QOpbe8l0fxQ/GVbzJsMUltrkQwY+OhCCqRq1RhUK1J/ufe2SVp2A0W7wlhpPX
	+T/3M7pklGhZm0VvtTRF5wFMqTlW1p8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731272419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=d0DgH2DHf2GTn5JYMkPQF6XcDDyXKl7bHbyawBprUq0=;
	b=eoWBRW7RrsgY8KotJT66NmiYBLAPuq7wH/YN5DtXHhLFQsZmPu1hnlARW9IJ2Hk58DeeC2
	6pwDaYgn/QOpbe8l0fxQ/GVbzJsMUltrkQwY+OhCCqRq1RhUK1J/ufe2SVp2A0W7wlhpPX
	+T/3M7pklGhZm0VvtTRF5wFMqTlW1p8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E5BC137FB
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2024 21:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m0K0E+IeMWcwOwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2024 21:00:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add extra warning when qgroup is marked inconsistent
Date: Mon, 11 Nov 2024 07:30:00 +1030
Message-ID: <834219eda2fad14d6d75ccc626166b14404e3867.1731272398.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
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

Unlike qgroup rescan, which always shows whether it cleared the
inconsistent flag, we do not have a proper way to show if qgroup is
marked inconsistent.

This was not a big deal before as there aren't that many locations that
can mark qgroup  inconsistent.

But with the introduction of drop_subtree_threshold, qgroup can be
marked inconsistent very frequently, especially for dropping large
subvolume.

Although most user space tools relying on qgroup should do their own
checks and queue a rescan if needed, we have no idea when qgroup is
marked inconsistent, and will be much harder to debug.

So this patch will add an extra warning (btrfs_warn_rl()) when the
qgroup flag is flipped into inconsistent for the first time.

Combined with the existing qgroup rescan messages, it should provide
some clues for debugging.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c82df56fbf3d..8956bee0abee 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -353,6 +353,8 @@ static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
 {
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
 		return;
+	if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT))
+		btrfs_warn_rl(fs_info, "qgroup marked inconsistent");
 	fs_info->qgroup_flags |= (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
 				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN |
 				  BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
-- 
2.47.0


