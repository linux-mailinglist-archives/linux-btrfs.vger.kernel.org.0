Return-Path: <linux-btrfs+bounces-5456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D398FC013
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 01:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAE71C2289E
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 23:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E68B14D71D;
	Tue,  4 Jun 2024 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EmzaZhpC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EmzaZhpC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51E14D2BF
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544653; cv=none; b=dXj5cbjhCR7X0I0XhrhFM+CZOdsqENe/gbD0FLtNZR/rB6Ul0EG4ejmZByH+QXOPgYQtuep1+i2OGKYZZXN/WfT0+7F20yYhpNad+bXWCR20yJwhf2p9NXIjwlMmn6vq5tWgVdl1NoNKvDEe9Ygv6S0OjhUkaLVxb12YL08S0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544653; c=relaxed/simple;
	bh=lby9aJvZO2Maf4mTJKsdbfcgNIMFEVRB5P9sCbNI7QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9qyatR1rmT+sZsBpZ6SL/Jjp20eOWiwnQuegy83MW/4avRW+SeXW8Puyd1AYfS4KPM8ETrjyWwfUoOH+x0orjgxFlH/QjTN8dW7HPPB8ISUNE43+Q8IYWEdqfhiYfadujRWPac8scGw+J5eY9Re6ciIIiVI+d3foGdd2ONWmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EmzaZhpC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EmzaZhpC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7657021964;
	Tue,  4 Jun 2024 23:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717544649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUbPt4i9aiBseOCv1tcZRBoWFGpBswL0oJhqfeMjZSw=;
	b=EmzaZhpCDY3TBAXT98+hBIAIA/sgGOvR2q/3/HjtiVf+A1LA3QT7UmEQfBit3wJ9HKyN2T
	LNteMDGWWj3Az3P345L5EyizY3GRUDSEoSPcziujdW7hSb0/BdbUVafaR9gorCG7J2JMt1
	EgbLK8VMelmpicz+5kAOpDGY7yj6OZA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EmzaZhpC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717544649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUbPt4i9aiBseOCv1tcZRBoWFGpBswL0oJhqfeMjZSw=;
	b=EmzaZhpCDY3TBAXT98+hBIAIA/sgGOvR2q/3/HjtiVf+A1LA3QT7UmEQfBit3wJ9HKyN2T
	LNteMDGWWj3Az3P345L5EyizY3GRUDSEoSPcziujdW7hSb0/BdbUVafaR9gorCG7J2JMt1
	EgbLK8VMelmpicz+5kAOpDGY7yj6OZA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3858F13A93;
	Tue,  4 Jun 2024 23:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oOwdN8emX2bcJwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 04 Jun 2024 23:44:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 1/4] btrfs-progs: corrupt-block: fix memory leak in debug_corrupt_sector()
Date: Wed,  5 Jun 2024 09:13:41 +0930
Message-ID: <3d9a9ecd46165c18f4ccd15f4e7aad489343dabe.1717544015.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1717544015.git.wqu@suse.com>
References: <cover.1717544015.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7657021964
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

ASAN build (make D=asan) would cause memory leak for
btrfs-corrupt-block inside debug_corrupt_sector().

This can be reproduced by fsck/013 test case.

The cause is pretty simple, we just malloc a sector and forgot to free
it.

Issue: #806
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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


