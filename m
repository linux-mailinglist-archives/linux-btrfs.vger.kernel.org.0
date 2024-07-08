Return-Path: <linux-btrfs+bounces-6275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BBC929B76
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 07:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112CE1F215A7
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 05:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30128125DE;
	Mon,  8 Jul 2024 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TFNT+ZII";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TFNT+ZII"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067710A3D
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720415689; cv=none; b=Kqq5RcYK8UPfDr0PG8b5MD1ZEKRAPbA1nIqEqc1MSqURwUKJLX2QSVoiVOIar5D+mcnAjaoQiYlJRWwrY6xuOarW8tDsjO4x4NvBfy0pIAbzQKDlg+eY2sLExJJyQSD6c941aPr0UhNgEMnYlN7COJ2z05TVGAdK5G1pzNQVnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720415689; c=relaxed/simple;
	bh=vsffEgL9/FKvxkMmK77ajFylh2WS00aSY+AzesMAaGY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGosoc9LuaKjtV5gKDsGbRuv7717WdCoI0XrL5nT0N6cEMJnMwFooKjUA4dy6ftXgWBIwnUfmRAC5bH42VCQv7RjMaV8EGc3OF6MMGpTdmcomFAVWllGYgLvQUd7A+owtu14p5YxDaKMzEh2KE5DwJnK3O3F0L9hvUkzPpwZDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TFNT+ZII; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TFNT+ZII; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B90DD219E0
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720415685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDa2zMOUlm99ep0ANXN4C1mAyqVY0s/zIVC0uOjxICs=;
	b=TFNT+ZIIZeh2/P2c/NLQCQ36L4snGPrDC6eAkAkQaOKXflQWwklblCsFsSSt7owo2443HW
	fvrCTgN1bmMtqBLVejTehE82js4uDb7P5nek4GeBunxn6/Uxe6MyT8QYlsXCTPID5E+2hL
	7u1r/93uW0S3/94HUzQt1abi2R2va98=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720415685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDa2zMOUlm99ep0ANXN4C1mAyqVY0s/zIVC0uOjxICs=;
	b=TFNT+ZIIZeh2/P2c/NLQCQ36L4snGPrDC6eAkAkQaOKXflQWwklblCsFsSSt7owo2443HW
	fvrCTgN1bmMtqBLVejTehE82js4uDb7P5nek4GeBunxn6/Uxe6MyT8QYlsXCTPID5E+2hL
	7u1r/93uW0S3/94HUzQt1abi2R2va98=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D80C21396E
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cHrTI8R1i2YbZwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jul 2024 05:14:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: fix rand_range()
Date: Mon,  8 Jul 2024 14:44:17 +0930
Message-ID: <d9997239035f5c71a5efc4a6353f79c3836d0a3e.1720415116.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720415116.git.wqu@suse.com>
References: <cover.1720415116.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.73 / 50.00];
	BAYES_HAM(-2.43)[97.39%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.73
X-Spam-Level: 

[BUG]
Btrfs-image with "-s" option is not properly genearting the desired
range [33, 126], thus even with the filename sanitization fixed, it's
still generate filenames beyond ASCII ranges:

	item 9 key (258 INODE_REF 256) itemoff 15549 itemsize 25
		index 3 namelen 15 name: 1���'�gc*&R

[CAUSE]
It's the function rand_range() return value larger than the specified
@upper.

The cause is in the timing when we trim the value down to 32 bits:

	return (unsigned int)(jrand48(rand_seed) % upper);

Unlike the name, jrand48() generate uniformly distrbuted value between
[-2^31, 2^31 - 1], which is the full range of s32.

And the result of a modulus operation with a minus input is still minus.

Thus even if we later convert it to unsigned int, the minus value is
much larger than @upper and caused the problem.

[FIX]
Convert the value to unsigned int first, then do the modulus operation.
Furthermore to prevent the problem from happening again, add a new
UASSERT() to make sure the result is indeed smaller than @upper.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/utils.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/utils.c b/common/utils.c
index 3ca7cff396fe..8f6556b345e8 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -922,12 +922,12 @@ u32 rand_u32(void)
 /* Return random number in range [0, upper) */
 unsigned int rand_range(unsigned int upper)
 {
+	int ret;
+
 	__init_seed();
-	/*
-	 * Use the full 48bits to mod, which would be more uniformly
-	 * distributed
-	 */
-	return (unsigned int)(jrand48(rand_seed) % upper);
+	ret = (unsigned int)(jrand48(rand_seed)) % upper;
+	UASSERT(ret < upper);
+	return ret;
 }
 
 int rand_int(void)
-- 
2.45.2


