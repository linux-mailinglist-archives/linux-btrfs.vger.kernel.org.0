Return-Path: <linux-btrfs+bounces-5581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA81090182B
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jun 2024 22:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DEE1C20CE7
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jun 2024 20:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33DA4D8BD;
	Sun,  9 Jun 2024 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YF8wfPiM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YF8wfPiM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A71F951
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Jun 2024 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717966406; cv=none; b=o79TOhqpOnHbxiiTaX1V+l1OzIYr1AvWRxo695ofGZFPRh0Bu2ScrYDj4yhiHgYijFEgiDfals+RYplBsiYCDFlYKa2Hlf6sgs+BhUL28BhWC58yWwAp5GL0HvhE8Poo1l9qnOJAQLya/4nGobBKa1S0ko8nDYS4NbtUdKh5Vag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717966406; c=relaxed/simple;
	bh=thbqx14356mfUiWbtxjvFGsHfOoDHT0OLkzIR/u4aDg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=brZUxiTgeAZKSqWGQzGRo2Q8iRduiMDhfr0P2S7XAVtg7fVRzwj5f14bXTPHF8QX236CQ7Xk1mVcRLILtpue/81Zrpywskgr+Hk3ZNziPilE8zQtXzApu2f2lMyUMlR0gW9ANRfAKX+4IklcC6B3/0HWYXZ/tnYz4rA+lP5Uq28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YF8wfPiM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YF8wfPiM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 221DB1F747
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Jun 2024 20:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717966396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pu/BQa+TdYMOklqvp5fWYB1Spd28R7rxE1RfRdRRo58=;
	b=YF8wfPiMmuLXJyUO7GhxtvUWaJ3wJAuaZuEXWXsEZp6v5XsB9fs5AgSHqJ/jocX9lbdSm/
	q2iZzQuFM6uNgbwcQowRSPljVEpMbSlbuL3zYBLgd71U0+eQWcTZZRBVTPqDC0soVSsUfF
	V5Dmi28Iqrcip4cBR2UCq/9ez0F/q1U=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YF8wfPiM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717966396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pu/BQa+TdYMOklqvp5fWYB1Spd28R7rxE1RfRdRRo58=;
	b=YF8wfPiMmuLXJyUO7GhxtvUWaJ3wJAuaZuEXWXsEZp6v5XsB9fs5AgSHqJ/jocX9lbdSm/
	q2iZzQuFM6uNgbwcQowRSPljVEpMbSlbuL3zYBLgd71U0+eQWcTZZRBVTPqDC0soVSsUfF
	V5Dmi28Iqrcip4cBR2UCq/9ez0F/q1U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3208913A55
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Jun 2024 20:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cNSzNToWZmY2MgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 09 Jun 2024 20:53:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: uapi: record temporary super flags utilized by btrfstune
Date: Mon, 10 Jun 2024 06:22:56 +0930
Message-ID: <4b9edf48c6071085f376e9861faf4dd6ecdac95b.1717966255.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.33 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.32)[75.47%];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -0.33
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 221DB1F747
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

[BUG]
There is a bug report that a canceled csum conversion (still
experimental feature) resulted unexpected super flags:

csum_type		0 (crc32c)
csum_size		4
csum			0x14973811 [match]
bytenr			65536
flags			0x1000000001
			( WRITTEN |
			  CHANGING_FSID_V2 )
magic			_BHRfS_M [match]

Meanwhile for a fs under csum conversion it should have either
CHANGING_DATA_CSUM or CHANGING_META_CSUM.

[CAUSE]
It turns out that, due to btrfs-progs keeps its own extra flags inside
its own ctree.h headers, not the shared uapi headers, we have
conflicting super flags:

kernel-shared/uapi/btrfs_tree.h:#define BTRFS_SUPER_FLAG_METADUMP_V2	(1ULL << 34)
kernel-shared/uapi/btrfs_tree.h:#define BTRFS_SUPER_FLAG_CHANGING_FSID	(1ULL << 35)
kernel-shared/uapi/btrfs_tree.h:#define BTRFS_SUPER_FLAG_CHANGING_FSID_V2 (1ULL << 36)
kernel-shared/ctree.h:#define BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM	(1ULL << 36)
kernel-shared/ctree.h:#define BTRFS_SUPER_FLAG_CHANGING_META_CSUM	(1ULL << 37)

Note that CHANGING_FSID_V2 is conflicting with CHANGING_DATA_CSUM.

[FIX]
The proper fix would be done inside btrfs-progs, but to keep everything
properly recorded, we should have everything inside the same uapi
header.

This patch would copy all the new flags into uapi header, and change the
value for CHANGING_DATA_CSUM and CHANGING_META_CSUM, while keep the
value of CHANGING_BG_TREE untouched.

Thankfully csum change is still only experimental and all those
CHANGING_* flags are transient (only for btrfs-progs to resume the
conversion, and kernel will reject them all), the damage is still minor.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Keep the number consistent between kernel and btrfs-progs
---
 include/uapi/linux/btrfs_tree.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index d24e8e121507..c7636331e566 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -777,6 +777,14 @@ struct btrfs_stripe_extent {
 #define BTRFS_SUPER_FLAG_CHANGING_FSID	(1ULL << 35)
 #define BTRFS_SUPER_FLAG_CHANGING_FSID_V2 (1ULL << 36)
 
+/*
+ * Those are temporaray flags utilized by btrfs-progs to do offline conversion.
+ * They are rejected by kernel.
+ * But still keep them all here to avoid conflicts.
+ */
+#define BTRFS_SUPER_FLAG_CHANGING_BG_TREE	(1ULL << 38)
+#define BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM	(1ULL << 39)
+#define BTRFS_SUPER_FLAG_CHANGING_META_CSUM	(1ULL << 40)
 
 /*
  * items in the extent btree are used to record the objectid of the
-- 
2.45.2


