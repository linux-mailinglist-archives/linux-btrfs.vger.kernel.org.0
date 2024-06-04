Return-Path: <linux-btrfs+bounces-5430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E58FA927
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 06:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747A51F26217
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 04:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10B613D8A1;
	Tue,  4 Jun 2024 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="etcAJioz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="etcAJioz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B414198A
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474916; cv=none; b=chrekxPjiPc/lK2J7oZWuWPyh1t9vlPMS4hWl7kbppt50Bi3ELUXyk9vipM2hMy+th1myOvLZN3w5S/OcZpJE4Kufss6yaItIcsCcMhkvgmQDG9EqAwZaJJx6n0oCLoKqyl1lAV1bAUyFc60ivHe7rgsywPIvS0ideMEGKTM4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474916; c=relaxed/simple;
	bh=oaA2VpGy+x1nkEqQodnoqvo/Q8lKBpC/jNlLFS8kDVc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XOpCs6ue7tpxcB4qemZlTMqylWfim8fYcG/vBBwlLNwStKo1eHLBkW9X1NUTQH7PItjRbG5zc4ASV+ds4QWrjhVPXESVPwAEWaftQu4yRFIiRLo5O5vyD5Lg2vZOgC6qIatGYl4uguNQqEZKgiaOEwpKaIkUSvco2ogsf33pA5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=etcAJioz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=etcAJioz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B3CF1F7B5
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 04:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717474912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gd+Hhd6x+cEwCcrk7Y1NSlo0+MquHDjzEscf4gxi0gA=;
	b=etcAJiozLxaejd6F4tHLyiDx7e06+8N8NK7l7Fk0xcBfqGqdTq/D18TRm+f9KOu0eBSwOU
	qD89cmr4JWuazZ8oKXbgfhEAprXM7FcRHxCyqpIVXsuf7X2gHC6gbmUHzXHVT/kr/FgLdn
	bn8IRFsmWJ5BHdBub4wbsqwoPxTkDtE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717474912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gd+Hhd6x+cEwCcrk7Y1NSlo0+MquHDjzEscf4gxi0gA=;
	b=etcAJiozLxaejd6F4tHLyiDx7e06+8N8NK7l7Fk0xcBfqGqdTq/D18TRm+f9KOu0eBSwOU
	qD89cmr4JWuazZ8oKXbgfhEAprXM7FcRHxCyqpIVXsuf7X2gHC6gbmUHzXHVT/kr/FgLdn
	bn8IRFsmWJ5BHdBub4wbsqwoPxTkDtE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8C82137C3
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 04:21:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id myZAF1+WXmbbTQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 04:21:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: corrupt-block: fix memory leak in debug_corrupt_sector()
Date: Tue,  4 Jun 2024 13:51:33 +0930
Message-ID: <ebd4d57790941a9c1edef52e09ce0bb4838ab27d.1717474840.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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

ASAN build (make D=asan) would cause memory leak for
btrfs-corrupt-block inside debug_corrupt_sector().

This can be reproduced by fsck/013 test case.

The cause is pretty simple, we just malloc a sector and forgot to free
it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 124597333771..e88319891910 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -70,7 +70,7 @@ static int debug_corrupt_sector(struct btrfs_root *root, u64 logical, int mirror
 			if (ret < 0) {
 				errno = -ret;
 				error("cannot read bytenr %llu: %m", logical);
-				return ret;
+				goto out;
 			}
 			printf("corrupting %llu copy %d\n", logical, mirror_num);
 			memset(buf, 0, sectorsize);
@@ -78,7 +78,7 @@ static int debug_corrupt_sector(struct btrfs_root *root, u64 logical, int mirror
 			if (ret < 0) {
 				errno = -ret;
 				error("cannot write bytenr %llu: %m", logical);
-				return ret;
+				goto out;
 			}
 		}
 
@@ -90,7 +90,8 @@ static int debug_corrupt_sector(struct btrfs_root *root, u64 logical, int mirror
 		if (mirror_num > num_copies)
 			break;
 	}
-
+out:
+	free(buf);
 	return 0;
 }
 
-- 
2.45.2


