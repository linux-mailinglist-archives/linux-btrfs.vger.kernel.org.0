Return-Path: <linux-btrfs+bounces-8696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 538BA996DCF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A231C22AC4
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7E84D02;
	Wed,  9 Oct 2024 14:30:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FE18EAD
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484255; cv=none; b=uewP1ZRoV0U5VaMKSHFDleJbQlHwz3oMrQfW+qC//imB7CvyAbTd1q14zMGcHKH9rRtZsG/ZIvtvNdnEfGhsG2KgvZ2z3Ab/QOVfHl+BW2+TTcJiwNr419W6trBt642iqh85ZdLpNYp+Ep7C1akRSx8/9s2Q6sjABQWlzkQUo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484255; c=relaxed/simple;
	bh=yRzO7L2ABjCFY/fsik9G4MNHextnPoIBAflRKV0RJRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSlKfjLQTtDKa1YHydIUh3N/tt9oQvW1e+tffSs1rby9LCM7lURVchXUhKB/T8wnqQkygyHqWF6Cr/nxbkTgv1Z0MZvUsxiHegeFOkufbrQdODXYY890/lynhT29hOL/rB0DpaOuw1t1ajRlMKF+7zYP1+eZVoRKcYLmp9f5ZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 044911F7C8;
	Wed,  9 Oct 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2AFB136BA;
	Wed,  9 Oct 2024 14:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3o89O5qTBmftRAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:30:50 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/25] btrfs: zstd: assert the timer pointer in callback
Date: Wed,  9 Oct 2024 16:30:50 +0200
Message-ID: <c7ced95da874e59e8d95de5fe23371737adaa235.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 044911F7C8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Make sure we got the right timer struct for the zstd workspace reclaim
work.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zstd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 15f8a83165a3..5232b56d5892 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -111,6 +111,8 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 	unsigned long reclaim_threshold = jiffies - ZSTD_BTRFS_RECLAIM_JIFFIES;
 	struct list_head *pos, *next;
 
+	ASSERT(timer == &wsm.timer);
+
 	spin_lock(&wsm.lock);
 
 	if (list_empty(&wsm.lru_list)) {
-- 
2.45.0


