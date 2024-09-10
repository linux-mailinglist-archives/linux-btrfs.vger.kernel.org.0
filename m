Return-Path: <linux-btrfs+bounces-7915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B526B9744F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 23:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796B8288792
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 21:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BC81AB50B;
	Tue, 10 Sep 2024 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="puZPAcvG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="puZPAcvG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA67176FCF
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004228; cv=none; b=eDWC9Cg6ZSjnlZVU5VLs+kQ8xtqF3ZGvTe2A3fS+LbyFhF3a+CmOPJVQtUqpx1O7FhdL2D1HxMEORDDxqYOvCIRuPG6pctOcClu3VNokyLXwVqgEjUBewcVqh1nWezSzlKg1OPX1eCOzRMZPdR1RmyQXD2lXWpDMxezFVpHG2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004228; c=relaxed/simple;
	bh=f5rHnRXgUKbIwnSey2bJeLe91wZrYl77w991w8E83yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgrvWBJAe2822be1/SCaOUhHPlPmhxUOs/4Ly7U60ktyFcR906iIZKwxTNpgpoZIj+fg4cUp1xYZ5FxkjbB3lPhcfABXsbMWCw8v+0KjuG/0KcSagMTo6wh+qpnFlcNTmHGkDMvW2csrsCzCdW+vQP6x9UWoObtfYy2ETFr7JxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=puZPAcvG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=puZPAcvG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9299A21A2F;
	Tue, 10 Sep 2024 21:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726004224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PLX8+nBNm1IdTheIHI0d78pWO8iNumaiJQvOIg9T6oo=;
	b=puZPAcvG3CQ/1lXa47CO2Rk+Ufr3WKmGxcKq8JtGRaTCXp/jGMtIHeEV4RXjRB1D92ThgM
	BdNzmsJTr+E4XxTdVSesbIBso9Rqm/jgdis4JM1T0AqHq5zbhEU+aJHnwvgwDPf0uEb4IM
	9990CDnqbqkYKvAbps4/2LjJoFvW5Ss=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=puZPAcvG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726004224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PLX8+nBNm1IdTheIHI0d78pWO8iNumaiJQvOIg9T6oo=;
	b=puZPAcvG3CQ/1lXa47CO2Rk+Ufr3WKmGxcKq8JtGRaTCXp/jGMtIHeEV4RXjRB1D92ThgM
	BdNzmsJTr+E4XxTdVSesbIBso9Rqm/jgdis4JM1T0AqHq5zbhEU+aJHnwvgwDPf0uEb4IM
	9990CDnqbqkYKvAbps4/2LjJoFvW5Ss=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F3A713A3A;
	Tue, 10 Sep 2024 21:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gwsVCf+74GbwLAAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 10 Sep 2024 21:37:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Neil Parton <njparton@gmail.com>,
	Archange <archange@archlinux.org>
Subject: [PATCH] btrfs: tree-checker: fix the wrong output of data backref objectid
Date: Wed, 11 Sep 2024 07:06:45 +0930
Message-ID: <3aea93fcf3d04b38c4ab1cd7de9948599733b202.1726004203.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9299A21A2F
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[gmail.com,archlinux.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG]
There is some reports about back data backref objectids, the report
looks like this:

[  195.128789] BTRFS critical (device sda): corrupt leaf: block=333654787489792 slot=110 extent bytenr=333413935558656 len=65536 invalid data ref objectid value 2543

The data ref objectid is the inode number inside the subvolume.

But in above case, the value is completely sane, not really showing the
problem.

[CAUSE]
The output itself is using dref_root, which is the subvolume id of the
backref.

[FIX]
Fix the output to use dref_objectid instead.

The root cause of that invalid dref_objectid is still under
investigation.

Reported-by: Neil Parton <njparton@gmail.com>
Reported-by: Archange <archange@archlinux.org>
Fixes: f333a3c7e832 ("btrfs: tree-checker: validate dref root and objectid")
Signed-off-by: Qu Wenruo <wqu@suse.com>
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


