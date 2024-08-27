Return-Path: <linux-btrfs+bounces-7583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA87C96198E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8D11F24A9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00791D415A;
	Tue, 27 Aug 2024 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nnk0j+Rv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nnk0j+Rv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CD1D31BA
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795737; cv=none; b=r1GmiEi7h8hfnlZDjK3/2o+up3PeFDM1xz/nDhfiHp+h/fDvlivNsBA8jtR8H42WnW3zRiPZm5/qP07RmHRbLX0FgT7dUqKOaZHBkE0s74OG7O+s9HftuB9P+7myZKbmzUnSi919C2H9s7gb9GU58AT6YroBAJRXR6CIKxLOCyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795737; c=relaxed/simple;
	bh=5+GotFln1QaZHkXVbSkQJ+Mwfci5d58d3SL3KVuyjak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZUUHN5+ekw2zJYTOL9Usm9Ssots+NscswGVef1jLBtNVvPr3u3roDXT/GN2ud8uvKF1qbZfweOGVxtIldhZcgHh5pmjcE8sRCCn4O5OCo6ZVH+WYYUNu+26w+kuCMwri8g7pmjRwFg1CdpLRAyfkavjRkTrzjdRcfyet3573lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nnk0j+Rv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nnk0j+Rv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 870231FB85;
	Tue, 27 Aug 2024 21:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMs3vkKZh69DT3kNsNnrIqSrW3E9fj9XhMW/OudbjOA=;
	b=Nnk0j+Rvf3/aI1vSr3s0T3WQ1Il3qEFDNe1zkjffPab4CMGEyYAKn/U6SrvPwfJcK3a9dj
	BgM6t9g3p1+D9NP7ggg9q4YSyp0cpvTYJkF2YO2NcP2gC5/998Ydj1VaeJdOsiKvzCYx4d
	/1wNvBqji62q1Ycy5KWOsmlQbSsJ2yU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMs3vkKZh69DT3kNsNnrIqSrW3E9fj9XhMW/OudbjOA=;
	b=Nnk0j+Rvf3/aI1vSr3s0T3WQ1Il3qEFDNe1zkjffPab4CMGEyYAKn/U6SrvPwfJcK3a9dj
	BgM6t9g3p1+D9NP7ggg9q4YSyp0cpvTYJkF2YO2NcP2gC5/998Ydj1VaeJdOsiKvzCYx4d
	/1wNvBqji62q1Ycy5KWOsmlQbSsJ2yU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7613013A20;
	Tue, 27 Aug 2024 21:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W1jQHFVLzmaXGgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:33 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/12] btrfs: constify arguments of compare_inode_defrag()
Date: Tue, 27 Aug 2024 23:55:29 +0200
Message-ID: <0dd124f30b6dc7dc1a90f64ae501a7ced0afb9ec.1724795624.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1724795623.git.dsterba@suse.com>
References: <cover.1724795623.git.dsterba@suse.com>
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

A comparator function does not change its parameters, make them const.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index e2949f630584..e4bb5a8651f3 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -45,8 +45,8 @@ struct inode_defrag {
 	u32 extent_thresh;
 };
 
-static int compare_inode_defrag(struct inode_defrag *defrag1,
-				  struct inode_defrag *defrag2)
+static int compare_inode_defrag(const struct inode_defrag *defrag1,
+				const struct inode_defrag *defrag2)
 {
 	if (defrag1->root > defrag2->root)
 		return 1;
-- 
2.45.0


