Return-Path: <linux-btrfs+bounces-4506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2DA8B0151
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 07:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6FB1C22A09
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 05:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554C156872;
	Wed, 24 Apr 2024 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jGRMXMTx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jGRMXMTx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4715667A
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937816; cv=none; b=tNjHGk32ayVjsuHurdc6GTYGQkX9UGPKeb2cQRw50tsGxvKYR/XTG9sjBC8k4dsfVnZxTV0yZqsZw7v0rE7xREqRZsgtwwZutGigVHMVqMSGSWXykvnutRdg6B4yAlsF/vgpzsWpUqCX4y/FJrJEedLriCITYV02VfJNPdN5fuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937816; c=relaxed/simple;
	bh=2vmns49i/PmfVHbts89SasbYB7WFCYxWPA78SQokHv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQ4H+HkhD5fU50VodyEoDOIbHAqRg6v5PZoochNsOQCyzFfGjslBURCdoMii29EDeJKe27S/54qiz7y3l64PedEr5aVGQ8vCLCSexYtWgQt/S6jwNbjiQPSjRzweAh4qZKHgTj3ZrKArpOQcmpQkOEg3YlRGEfXXp+oxd2eayb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jGRMXMTx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jGRMXMTx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CDB960F4E;
	Wed, 24 Apr 2024 05:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713937810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o55ENwh6MbZ0jA7F+pnikhI24r+cKbV4DW/VJPgHO0Y=;
	b=jGRMXMTx/L5RuqiVci5Rajyyj1z3lma3DHUQ7PftROMYRBDeAB3f8Kzl1TTqZ0MNE2GRfC
	o+Zmz9vBWA4axUuHX6HsahlHUr89iSQThpB17TtGkBbQ+mkFiT5St9l03Vb01Mn2c1zshv
	6P4eQxbZq9LfAbRl02PzrocDOE1bzz0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713937810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o55ENwh6MbZ0jA7F+pnikhI24r+cKbV4DW/VJPgHO0Y=;
	b=jGRMXMTx/L5RuqiVci5Rajyyj1z3lma3DHUQ7PftROMYRBDeAB3f8Kzl1TTqZ0MNE2GRfC
	o+Zmz9vBWA4axUuHX6HsahlHUr89iSQThpB17TtGkBbQ+mkFiT5St9l03Vb01Mn2c1zshv
	6P4eQxbZq9LfAbRl02PzrocDOE1bzz0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B28F13724;
	Wed, 24 Apr 2024 05:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RjWsOpCdKGaGdwAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 24 Apr 2024 05:50:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: HAN Yuwei <hrx@bupt.moe>
Subject: [PATCH] btrfs-progs: fsfeatures: hide RST behind experimental builds
Date: Wed, 24 Apr 2024 15:19:50 +0930
Message-ID: <a45bd8eb8d16b648368b2e83f12a72ea44dab71c.1713937746.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -0.10
X-Spam-Level: 
X-Spamd-Result: default: False [-0.10 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.30)[74.96%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

[BUG]
There is a report that with v6.7.1 btrfs-progs, `mkfs.btrfs -O rst`, but
kernel 6.7/6.8 are unable to mount it at all.

[CAUSE]
Although the feature string states the raid-stripe-tree feature is
supported since v6.7 kernel, it's not correct.
Only debug kernel with CONFIG_BTRFS_DEBUG would support the RST feature.

Thus RST is still considered experimental.

[FIX]
Move the RST mkfs features back to experimental.

This patch would only hide the RST features from 'mkfs -O' options, the
existing supporting code for RST would still be there, thus
non-experimental build of `btrfs check` can still verify a btrfs with
RST.

Reported-by: HAN Yuwei <hrx@bupt.moe>
Fixes: b421fdff9574 ("btrfs-progs: move raid-stripe-tree and squota build out of experimental")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index c5e81629ccea..7aaddab6a192 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -222,6 +222,7 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "block group tree, more efficient block group tracking to reduce mount time"
 	},
+#if EXPERIMENTAL
 	{
 		.name		= "rst",
 		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE,
@@ -238,6 +239,7 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "raid stripe tree, enhanced file extent tracking"
 	},
+#endif
 	{
 		.name		= "squota",
 		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA,
-- 
2.44.0


