Return-Path: <linux-btrfs+bounces-11417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA0CA330AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 21:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3C71889D33
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 20:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7CB202C21;
	Wed, 12 Feb 2025 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bi2qFHi0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bi2qFHi0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93E220125B
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391724; cv=none; b=rFJJDtx6KQy9zkhzjbuH2s8Gml8XQxiEFao0jR9uKZY/dCaAuVy4FykTd/7salukLl3D6Wpbxe17rcACshcOH8MrQ4MMf6rHQGXQpQfWaD/BribMzDlcmlvDV6mzf8RCireU3stq5OQE3yq8hVSJgcDcZvPQFu7TqiKhZj910bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391724; c=relaxed/simple;
	bh=6K2/WnWPk9px0xqh5dhSSdGfNCF4qRIHSnaqO0fXvsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3vrAj6zbpe1rOQZJ6C+NrwXng8fiNe3B9I1DqPCXWacncrofUetwalcURxjOaNCWqdE6HXxKRPZLYNtRcjwPpbpfCr8WJCt/NBpRXNq7hM7xNog2jid+PN6EvdYEX2kT/+ijHpGORlonp74MPhZl0jzLb3txHFGEaVrQuxCUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bi2qFHi0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bi2qFHi0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0BF6337C7;
	Wed, 12 Feb 2025 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739391720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pZXQt22F20M5GVF5Sr6mujckZwqARBf4Wsc3Dut3yc=;
	b=Bi2qFHi0yeS8m4oYYQ2FuNPX718f5VgnC752IJcxbFA31Rl+bdXe0Bhg6bPpVgQgVIz59W
	fH8oTOiLxfdM5KwAqx3QCWrB/gZoxBud9kauHB8pA/bhEv2yS7Zvzg7MgoNmk8KDfrVu/2
	rGVcUwWuV1Btr9GPlf4FB4A3FpPEHS8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739391720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pZXQt22F20M5GVF5Sr6mujckZwqARBf4Wsc3Dut3yc=;
	b=Bi2qFHi0yeS8m4oYYQ2FuNPX718f5VgnC752IJcxbFA31Rl+bdXe0Bhg6bPpVgQgVIz59W
	fH8oTOiLxfdM5KwAqx3QCWrB/gZoxBud9kauHB8pA/bhEv2yS7Zvzg7MgoNmk8KDfrVu/2
	rGVcUwWuV1Btr9GPlf4FB4A3FpPEHS8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C91C413AEF;
	Wed, 12 Feb 2025 20:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k7UWMegCrWeaJgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Feb 2025 20:22:00 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/7] btrfs: async-thread: switch local variables need_order bool
Date: Wed, 12 Feb 2025 21:22:00 +0100
Message-ID: <c4bfd16e64c1d0cf6d9b621b6d90b718658b63c5.1739391605.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739391605.git.dsterba@suse.com>
References: <cover.1739391605.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Use bool for 0/1 indicators in thresh_exec_hook() and
btrfs_work_helper().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/async-thread.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index a4c51600a408..f3bffe08b290 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -168,7 +168,7 @@ static inline void thresh_exec_hook(struct btrfs_workqueue *wq)
 {
 	int new_current_active;
 	long pending;
-	int need_change = 0;
+	bool need_change = false;
 
 	if (wq->thresh == NO_THRESHOLD)
 		return;
@@ -196,15 +196,14 @@ static inline void thresh_exec_hook(struct btrfs_workqueue *wq)
 		new_current_active--;
 	new_current_active = clamp_val(new_current_active, 1, wq->limit_active);
 	if (new_current_active != wq->current_active)  {
-		need_change = 1;
+		need_change = true;
 		wq->current_active = new_current_active;
 	}
 out:
 	spin_unlock(&wq->thres_lock);
 
-	if (need_change) {
+	if (need_change)
 		workqueue_set_max_active(wq->normal_wq, wq->current_active);
-	}
 }
 
 static void run_ordered_work(struct btrfs_workqueue *wq,
@@ -296,7 +295,7 @@ static void btrfs_work_helper(struct work_struct *normal_work)
 	struct btrfs_work *work = container_of(normal_work, struct btrfs_work,
 					       normal_work);
 	struct btrfs_workqueue *wq = work->wq;
-	int need_order = 0;
+	bool need_order = false;
 
 	/*
 	 * We should not touch things inside work in the following cases:
@@ -307,7 +306,7 @@ static void btrfs_work_helper(struct work_struct *normal_work)
 	 * So we save the needed things here.
 	 */
 	if (work->ordered_func)
-		need_order = 1;
+		need_order = true;
 
 	trace_btrfs_work_sched(work);
 	thresh_exec_hook(wq);
-- 
2.47.1


