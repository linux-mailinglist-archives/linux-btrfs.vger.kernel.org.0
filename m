Return-Path: <linux-btrfs+bounces-5566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D5A900F68
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 05:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AD81F22FCE
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 03:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5343BDF4D;
	Sat,  8 Jun 2024 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qOxVdfB9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qOxVdfB9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86D7F
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717818793; cv=none; b=eCiTFy1AEjT6aN8clQp6fPN4k7U4KIpt3aVF7LNxpnHO5r/rHjXtieRr0RMM8VY+x0PFac7lpLYekEk83XekIJ9ZtDXHJjLxSwyhgMzu0ppmhuemrwOwwSmXDF47WZDQ/X2kvtS0ZwFvWiaWM6NEo1hf8es+nNAB3VuzR/Ql+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717818793; c=relaxed/simple;
	bh=QDIRROYOh6UpFc7EVQJcnbgmgMBC8F9Zs7Lpgl6iz+E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Cl3ClZh7+77rugWTwipg5O3TxJxEvAJpg3JbOMzi3FHMMBXzaCr9TvgQS+P7OJcpptGt/LAq/8O+tZN95qU0oVZwZHCYjaaOB76ESNCxopA3wMjx8kTpsgdGdxy2wQz9VHozHXBDFyUi6ER93QSS3UF2vzVpN7jN7M1aPPe/yio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qOxVdfB9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qOxVdfB9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A68DC21B9D
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 03:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717818789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SUJZchvHwEBL6kOBCBbytZ4Zwd65VmdzjyBDZCePXMk=;
	b=qOxVdfB9gj1WQ8Viq9wz3cvm0LALYi9QqjnAJ82DYw1BuQqSNSDj0TcivMb8wGbSD5REsu
	2dVAFf5Dkbo3/BoSuMUqub5N9TbME3+k5mtNag28OL0vkJfgltM5C3eKM5Al22Dyr+wN8w
	jsZkBP4M2IuFV7uc8NeZCP3Pef0zjsg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717818789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SUJZchvHwEBL6kOBCBbytZ4Zwd65VmdzjyBDZCePXMk=;
	b=qOxVdfB9gj1WQ8Viq9wz3cvm0LALYi9QqjnAJ82DYw1BuQqSNSDj0TcivMb8wGbSD5REsu
	2dVAFf5Dkbo3/BoSuMUqub5N9TbME3+k5mtNag28OL0vkJfgltM5C3eKM5Al22Dyr+wN8w
	jsZkBP4M2IuFV7uc8NeZCP3Pef0zjsg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A13A51398F
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 03:53:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yifiD6TVY2ZxawAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 08 Jun 2024 03:53:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: uapi: record temporary super flags utilized by btrfstune
Date: Sat,  8 Jun 2024 13:22:50 +0930
Message-ID: <57b836631f9c5dcb24ace616bdb76a37b8d084b2.1717818761.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.00 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.20)[71.45%];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.00
X-Spam-Flag: NO

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
 include/uapi/linux/btrfs_tree.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index d24e8e121507..dce827f5b03a 100644
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
+#define BTRFS_SUPER_FLAG_CHANGING_BG_TREE	(1ULL << 48)
+#define BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM	(1ULL << 49)
+#define BTRFS_SUPER_FLAG_CHANGING_META_CSUM	(1ULL << 50)
 
 /*
  * items in the extent btree are used to record the objectid of the
-- 
2.45.2


