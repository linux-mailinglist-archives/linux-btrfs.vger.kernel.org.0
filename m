Return-Path: <linux-btrfs+bounces-3023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A4872726
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 19:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532B31F2A2A0
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0268225775;
	Tue,  5 Mar 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="drihjmYp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="drihjmYp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D7D250FE;
	Tue,  5 Mar 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665161; cv=none; b=GiGG6H68iAIx6Fn2MVOZ6s5/O/9vom5YwoaYEfN9cQrOrQc7VzBf74lC7QlxLNKc5ynXIRpdzLVPDE5GXBmCt6o9meIk8m1Is26cWja6Z+1wYZ7oq2iMNNtHc2ZCHFsvy406P4afkiL6gS1Exrnoq+oasg+yFNdxdAPrdfmhyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665161; c=relaxed/simple;
	bh=LrIOHtg8N/EpGlWKKOL+coje7+xK7gQg0ih+NZ5cj+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WclUnIw8rJXPIICE0yT3X7X+JLTUF2Zv3eP93L17BIUE7BZbziN5yhk0YeYZ9AFYbABekGwOTBZkJDUMCrWpsoQ7/ufOTV0RRBnOfRZSQtc6qCfKoFMrnTk5zfJJbWA/HwKmV3+OdnYbjj0h6Udsqdqgcf/gk3dVeuueETM0ynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=drihjmYp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=drihjmYp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E8C4200FA;
	Tue,  5 Mar 2024 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9TYYLM5/mC98mabg1iwK9lMqDFZeHRXi4ce0skkBV0=;
	b=drihjmYp3MxzEHVfGQA384quSerwcppihMXH3j1ZT8sJNFD33kLL9+NN+yaNbRQBebBXFa
	AM+sDRwZVvlRw5J+0eCJbzCt8boO2uP5f1sT8+8TUCM+MgZ9xoMIMrNxFI47D9NbH+SpIY
	dgszIF/glY06NigQu+c/yBHwRVcUXR0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9TYYLM5/mC98mabg1iwK9lMqDFZeHRXi4ce0skkBV0=;
	b=drihjmYp3MxzEHVfGQA384quSerwcppihMXH3j1ZT8sJNFD33kLL9+NN+yaNbRQBebBXFa
	AM+sDRwZVvlRw5J+0eCJbzCt8boO2uP5f1sT8+8TUCM+MgZ9xoMIMrNxFI47D9NbH+SpIY
	dgszIF/glY06NigQu+c/yBHwRVcUXR0=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 88A4513466;
	Tue,  5 Mar 2024 18:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id eldaIYVr52VDBQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 05 Mar 2024 18:59:17 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs/131: don't run with subpage blocksizes
Date: Tue,  5 Mar 2024 19:52:12 +0100
Message-ID: <3f9c8b6a7ac5b9286999a725a53d6cca55d9a74e.1709664047.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1709664047.git.dsterba@suse.com>
References: <cover.1709664047.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=drihjmYp
X-Spamd-Result: default: False [2.74 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.95)[94.76%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.74
X-Rspamd-Queue-Id: 8E8C4200FA
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

From: Josef Bacik <josef@toxicpanda.com>

This test requires a feature that is incompatible with subpage
blocksizes.  Check to see if that's what we're testing and simply skip
this test.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/131 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/btrfs/131 b/tests/btrfs/131
index 1e072b285ecfea..529ee3e80f87eb 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -21,6 +21,10 @@ _require_btrfs_fs_feature free_space_tree
 # Zoned btrfs does not support space_cache(v1)
 _require_non_zoned_device "${SCRATCH_DEV}"
 
+_scratch_mkfs >/dev/null 2>&1
+[ "$(_get_page_size)" -gt "$(_scratch_btrfs_sectorsize)" ] && \
+	_notrun "cannot run with subpage sectorsize"
+
 mkfs_v1()
 {
 	_scratch_mkfs >/dev/null 2>&1
-- 
2.42.1


