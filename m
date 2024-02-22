Return-Path: <linux-btrfs+bounces-2625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C951D85EFE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 04:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0EB1F23704
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 03:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203717562;
	Thu, 22 Feb 2024 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J4f9jdoq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J4f9jdoq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FB1642F
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572648; cv=none; b=CPad4pVdWy9sxN/cBHShWhWW9rGIOlWSTEA21BeE2lM8s4j72HZ1OCOKqdc4yogXaOX0SFADAOMqkM6qCJSHrsczgszZ499jfuZXVJVGP/7REzqMOwUkGr+Sgq2HuXHHpk/Do/FhM9JSktoNoD9VgOx83h/L3Oap4YrTAmxDyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572648; c=relaxed/simple;
	bh=zn+KQNYiaTXL+HzLpUwfvI74GraiUyeyD1lBpR8e9YM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jU+jmzjDwYNTohB36IhCiyMJ30N8wQdgNc473cusiaSZQ/G+MWm8EnaSgDXs7717Ef7oWl7/Mn/MKI4E5V6gxPC3ZBKfFscADq8RW+AoS1sx+DnbvEOLU/pGyKxTQmYcN8L3P0mz87K5yov53QiTHc+C5uk7Uk3cjWmVnXB9nns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J4f9jdoq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J4f9jdoq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 657AC21D4F
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 03:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708572644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=39al/GCZGuRGNUQQmBko1rzTJH2djey/pP1bRS63hcQ=;
	b=J4f9jdoqfpFl6u9cLtEaeXUOEokHoZmq311/Luq+ZtARYzS01mvvQ1b+r956/4ZOF2YjTO
	cpzxjVpVqZxPyTkTVy7tBwwh3N52YviOuPMECTU3EB/1f4tBbyoKZdIxzr4yLO+cNdIxyI
	pF7uWZ9dN2O20qQDCPyeOpfls2UNUrY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708572644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=39al/GCZGuRGNUQQmBko1rzTJH2djey/pP1bRS63hcQ=;
	b=J4f9jdoqfpFl6u9cLtEaeXUOEokHoZmq311/Luq+ZtARYzS01mvvQ1b+r956/4ZOF2YjTO
	cpzxjVpVqZxPyTkTVy7tBwwh3N52YviOuPMECTU3EB/1f4tBbyoKZdIxzr4yLO+cNdIxyI
	pF7uWZ9dN2O20qQDCPyeOpfls2UNUrY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9744513A3D
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 03:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mZ2BFuO/1mXNXgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 03:30:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: compression: remove dead comments on btrfs_compress_heuristic()
Date: Thu, 22 Feb 2024 14:00:25 +1030
Message-ID: <6ddea79ce1701adca117880a492a3e08282e318c.1708572619.git.wqu@suse.com>
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
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.91%]
X-Spam-Flag: NO

Since commit a440d48c7f93 ("Btrfs: heuristic: implement sampling
logic"), btrfs_compress_heuristic() is no longer a simple "return true",
but more complex system to determine if we should compress.

Thus the comment is dead and can be confusing, just remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Furthermore, the current btrfs_compress_heuristic() looks a little too
conservative, resulting a pretty low compression ratio for some common
workload, and driving end users to go "compress-force" options.
---
 fs/btrfs/compression.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 0b8833baf404..b2b94009959d 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1476,11 +1476,6 @@ static void heuristic_collect_sample(struct inode *inode, u64 start, u64 end,
 /*
  * Compression heuristic.
  *
- * For now is's a naive and optimistic 'return true', we'll extend the logic to
- * quickly (compared to direct compression) detect data characteristics
- * (compressible/incompressible) to avoid wasting CPU time on incompressible
- * data.
- *
  * The following types of analysis can be performed:
  * - detect mostly zero data
  * - detect data with low "byte set" size (text, etc)
-- 
2.43.2


