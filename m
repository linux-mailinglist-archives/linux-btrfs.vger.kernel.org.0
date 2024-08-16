Return-Path: <linux-btrfs+bounces-7221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F01953ECE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 03:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543ABB213EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 01:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5777B1DFEB;
	Fri, 16 Aug 2024 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mymc92bG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mymc92bG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA5B647;
	Fri, 16 Aug 2024 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723770663; cv=none; b=uaN14Kh/07EzTXkET5Tl+r/Ajs5WCKht2TZiio+kPKP7d9mP0YeCoK2qsNSye8tsxPvhHG5lQCmetWeG/bkcwBZgwZri59NVkMPZdeXEq4WBiQb0klsnoFgsPW51WjkynLEJApFcdbRmX7i1dBrHsQvS96d1KfW8ieWwLbNsoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723770663; c=relaxed/simple;
	bh=Wg98roUs9UnDkZvwfwUi/QM50bCz9k2dNbQZp4JxeGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubB4dWtVVl6AdU0/yCSZ1u8KuO+ZmaV+UrQ/ynCqTs1IFuNIALjra1fIFTKvAiJZQoHFdjBQpGVjlnqTpJ30WUfFcj4/xjEEDWk/fAp2piZp4MbhA4B0iPmfefcicovxRIiksDaOyFbeBAQuob3QnH2OwX6dQpLX/Hd0cohmtf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mymc92bG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mymc92bG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96ABC2288B;
	Fri, 16 Aug 2024 01:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723770657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5izJoME/EgOGqrOxxJbNIFZPzL4ZTxq6Pfp9grC9ENs=;
	b=mymc92bGEglNExdRewcYIqalOz7g4HU6w6wnnOnNoVLg/iLJjODpnq1VZu5tz22QpOmhXd
	xQmezh+zbTvqdCcKmSr9TUBLY9spBxTfPBxSxtxsKzaaZBs63UVgl+3JcM66TATv2CVIlf
	uXt6xd2KSBFmDjtH/ITDfde/X5tRSN8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723770657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5izJoME/EgOGqrOxxJbNIFZPzL4ZTxq6Pfp9grC9ENs=;
	b=mymc92bGEglNExdRewcYIqalOz7g4HU6w6wnnOnNoVLg/iLJjODpnq1VZu5tz22QpOmhXd
	xQmezh+zbTvqdCcKmSr9TUBLY9spBxTfPBxSxtxsKzaaZBs63UVgl+3JcM66TATv2CVIlf
	uXt6xd2KSBFmDjtH/ITDfde/X5tRSN8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74E3E13983;
	Fri, 16 Aug 2024 01:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xLXcCyCnvmbXJwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 16 Aug 2024 01:10:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: only enable extent map shrinker for DEBUG builds
Date: Fri, 16 Aug 2024 10:40:38 +0930
Message-ID: <09ca70ddac244d13780bd82866b8b708088362fb.1723770634.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]

Although there are several patches improving the extent map shrinker,
there are still reports of too frequent shrinker behavior, taking too
much CPU for the kswapd process.

So let's only enable extent shrinker for now, until we got more
comprehensive understanding and a better solution.

Link: https://lore.kernel.org/linux-btrfs/3df4acd616a07ef4d2dc6bad668701504b412ffc.camel@intelfx.name/
Link: https://lore.kernel.org/linux-btrfs/c30fd6b3-ca7a-4759-8a53-d42878bf84f7@gmail.com/
Fixes: 956a17d9d050 ("btrfs: add a shrinker for extent maps")
CC: stable@vger.kernel.org # 6.10+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
I also checked how XFS (the only other fs implemented the
free_cached_objects callback) implemented the callback.

They did two things:

- Make sure there is only one queued reclaim
  Currently we only do the reclaim for kswapd, but for multi-node
  systems, we can still have multiple kswapd processes.

  But I do not think that's the root cause.

- With an extra delay of 60% of xfs_syncd_centiseccs
  The default value for xfs_syncd_centiseccs is 3000 centiseconds (30s),
  with a minimal 100 centiseconds (1s).
  This results the reclaim work only to be executed at most every 18
  seconds by default (or 0.6s for the minimal interval).

  I believe this is the root cause, we have no extra delay and that
  makes btrfs to shrink extent maps too frequently.
---
 fs/btrfs/super.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 11044e9e2cb1..98fa0f382480 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2402,7 +2402,13 @@ static long btrfs_nr_cached_objects(struct super_block *sb, struct shrink_contro
 
 	trace_btrfs_extent_map_shrinker_count(fs_info, nr);
 
-	return nr;
+	/*
+	 * Only report the real number for DEBUG builds, as there are reports of
+	 * serious performance degradation caused by too frequent shrinks.
+	 */
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
+		return nr;
+	return 0;
 }
 
 static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_control *sc)
-- 
2.46.0


