Return-Path: <linux-btrfs+bounces-15883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3870AB1BFB4
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521761825E7
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 04:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF81F5434;
	Wed,  6 Aug 2025 04:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TteN19Ve";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TteN19Ve"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5951E5B82
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754455772; cv=none; b=Gt3jAM2zv57ZkTVUoXCbCfEpMIaP5NFOyXHyGUsVmkdeJIQyyMEi+Cfj9eqmO5EFU2WErRjrKaVSroW689n98edgC3w8BA1cta/Wy5RkATRD3H+9t35SPQCOMlyRrFLDTB8Ll/DlLxAXvnNeD3CDV/GO3RKGG7TZD9TbsrvsKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754455772; c=relaxed/simple;
	bh=Zk2Fl5SsZACNxJxIVovh1ri68c9SJiCGT/L65cdXy+Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHUimDNymSKBrNfb1slef47WMlGliwQADr05BwmMHFm+LHj+ZfPjMTqcH4RDmNuULxfgSEdBf2w9mb4pDtTZwBHA0/Owso0Yq9LxCs2x38LUOCVXYASVm4eOHp9AuzSSinvR39DmP9/FCTMek8G78/lkF4GTP0YI67RVQuYvLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TteN19Ve; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TteN19Ve; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A071C1F394
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pi38SMR1rQjW8DCZJVOWVp21LsZhsDGrIAYWOZQy9i8=;
	b=TteN19Ve5cvxujcP4m87X+jvG2U+b64nLiRuhHAKX8czyyloUJbdw4hxTfbCNjs6UJaRpK
	fmrXRAcVFkWEoYpU7YaWBH8oEvgLj3ZDXEMsRwrwKVQpnCGsFzyTKVrGzQvZd+HMujVbah
	fB/lg5xTSdpaRgXwJoegqRhHraayT4k=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pi38SMR1rQjW8DCZJVOWVp21LsZhsDGrIAYWOZQy9i8=;
	b=TteN19Ve5cvxujcP4m87X+jvG2U+b64nLiRuhHAKX8czyyloUJbdw4hxTfbCNjs6UJaRpK
	fmrXRAcVFkWEoYpU7YaWBH8oEvgLj3ZDXEMsRwrwKVQpnCGsFzyTKVrGzQvZd+HMujVbah
	fB/lg5xTSdpaRgXwJoegqRhHraayT4k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDE9213AA8
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GDysJ83ekmjFRwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 06 Aug 2025 04:49:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/6] btrfs-progs: remove is_vol_small() helper
Date: Wed,  6 Aug 2025 14:18:53 +0930
Message-ID: <29c59b6efc1722769b73eb938dd04655fbeff4db.1754455239.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754455239.git.wqu@suse.com>
References: <cover.1754455239.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

The last user of the helper is removed in commit c11e36a29e84
("Btrfs-progs: Do not force mixed block group creation unless '-M'
option is specified").

So there is no one using this helper, and we can safely remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/common.c | 29 -----------------------------
 mkfs/common.h |  1 -
 2 files changed, 30 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index d7a1dc5867eb..c5f73de81194 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -1167,35 +1167,6 @@ bool test_status_for_mkfs(const char *file, bool force_overwrite)
 	return false;
 }
 
-int is_vol_small(const char *file)
-{
-	int fd = -1;
-	int e;
-	struct stat st;
-	u64 size;
-
-	fd = open(file, O_RDONLY);
-	if (fd < 0)
-		return -errno;
-	if (fstat(fd, &st) < 0) {
-		e = -errno;
-		close(fd);
-		return e;
-	}
-	size = device_get_partition_size_fd_stat(fd, &st);
-	if (size == 0) {
-		close(fd);
-		return -1;
-	}
-	if (size < BTRFS_MKFS_SMALL_VOLUME_SIZE) {
-		close(fd);
-		return 1;
-	} else {
-		close(fd);
-		return 0;
-	}
-}
-
 int test_minimum_size(const char *file, u64 min_dev_size)
 {
 	int fd;
diff --git a/mkfs/common.h b/mkfs/common.h
index c600c16622fa..d08a5fd87203 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -106,7 +106,6 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg);
 u64 btrfs_min_dev_size(u32 nodesize, bool mixed, u64 zone_size, u64 meta_profile,
 		       u64 data_profile);
 int test_minimum_size(const char *file, u64 min_dev_size);
-int is_vol_small(const char *file);
 int test_num_disk_vs_raid(u64 metadata_profile, u64 data_profile,
 	u64 dev_cnt, int mixed, int ssd);
 bool test_status_for_mkfs(const char *file, bool force_overwrite);
-- 
2.50.1


