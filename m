Return-Path: <linux-btrfs+bounces-17840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B6FBDE697
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 14:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6E81927BFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 12:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F231326D54;
	Wed, 15 Oct 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r4Sndw2B";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r4Sndw2B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95029CE1
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530340; cv=none; b=OJblNCpfZ7raQomuL52ym/dH0TAgO+ILhyEsC9LD0eQ+ak6TT3Zx7vIwVVHgUZVeT5lMDKGsb+3ac2DRFXNx41J0A8D06ZUR3xAwIBIG6LOlh4H1EJKXZXCFccTiPcSAt6PReXPrtVJUaxTuesUvAekXX5ftk0ftOKzvtz1/Up0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530340; c=relaxed/simple;
	bh=ZVDdyrohPJ3x/MMRWkvsMMq58lzxM3GN7Hn1IYaIw4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZstD3v0E6N5ufB6kLyDgRtmYKgVOfJuYKrNdrjq787YhufnmE2d3BZR3aKWlWk0DguMt9LsLUo8oeP80gAEi3dfp0JlXaoQgaX89idxmgA63N7A+9a0M5+TCPfk/hJytTJAYP9jXfyVWSC+W/wAKiCfNRx5bJC6dBQPf7tKmQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r4Sndw2B; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r4Sndw2B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B564B33858;
	Wed, 15 Oct 2025 12:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760530322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLzDYCfRV7u/HDUgq949JbFiJ4Hf576WgXkbVLG3UHs=;
	b=r4Sndw2BMdaWtl4a+NvHXg9lrVNIa6hO7dkuHLSCLut3MbQC1QTTqb+NV8KHL3G2XAOiKd
	XDs7Vr7EVxEFY5bwK6nzPDU8G4U9hY4EBvsHrUmPUBNxjetzbL3gUzRhAYqaPmy/8bGpip
	5nMlaNJdK0fSWE86QbTGXtIderW3sfc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760530322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLzDYCfRV7u/HDUgq949JbFiJ4Hf576WgXkbVLG3UHs=;
	b=r4Sndw2BMdaWtl4a+NvHXg9lrVNIa6hO7dkuHLSCLut3MbQC1QTTqb+NV8KHL3G2XAOiKd
	XDs7Vr7EVxEFY5bwK6nzPDU8G4U9hY4EBvsHrUmPUBNxjetzbL3gUzRhAYqaPmy/8bGpip
	5nMlaNJdK0fSWE86QbTGXtIderW3sfc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A303D13AE7;
	Wed, 15 Oct 2025 12:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6LJbJ5KP72i2fAAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 15 Oct 2025 12:12:02 +0000
From: Daniel Vacek <neelx@suse.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 2/8] btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
Date: Wed, 15 Oct 2025 14:11:50 +0200
Message-ID: <20251015121157.1348124-3-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015121157.1348124-1-neelx@suse.com>
References: <20251015121157.1348124-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.79 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.953];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.79
X-Spam-Level: 

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Matches kernel change by the same name.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/ctree.h      | 3 ++-
 kernel-shared/uapi/btrfs.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index b08e078b..ccd39813 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -102,7 +102,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	 BTRFS_FEATURE_INCOMPAT_ZONED |			\
 	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 |	\
 	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE |	\
-	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
+	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA |		\
+	 BTRFS_FEATURE_INCOMPAT_ENCRYPT)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index d6eb4fb4..79963870 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -359,6 +359,7 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE (1ULL << 14)
+#define BTRFS_FEATURE_INCOMPAT_ENCRYPT		(1ULL << 15)
 #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
 
 struct btrfs_ioctl_feature_flags {
-- 
2.51.0


