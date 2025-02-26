Return-Path: <linux-btrfs+bounces-11829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B35A4543E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 05:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F77D18929F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 04:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E8D2676DD;
	Wed, 26 Feb 2025 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ihAR/+lY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ihAR/+lY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4425E452
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542399; cv=none; b=DPCwAhUVSN4FCrvhPkIp5PNigY5CAzIm4/kLiAZImz9pG7VLx/A2q5AWl4fptAjiJYl0TbnbJue0zL7DDsZ6oeUA1nu/0oMyYInDy8qgPKKHXQEYXcM8KL91Hyt69NgZiwF5Q1jyiA1zJnvzuhaOnA51RxQXuRoXE8guqSQ3oTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542399; c=relaxed/simple;
	bh=xjAbjP7MWtf249OT42Fp45CBfMuhM+wV5wqkuWdnVXo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGAciZnShIg54TxuKiFUWONrgV0Kh8He/agHMg9U4c2hAafwHkUp45EfulLeyShHq1MitWCh71DkUfb++gXhiKCGrZF8/7Ubf1pYw9woLU/n2t+3SnQqXKOzthWk1sKnprJHv3kuYzJjRx/kzvL20T+HiHKrWT+7fnIHLknW8Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ihAR/+lY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ihAR/+lY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B560121193
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740542385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ksmf5yRK+jmwzYn0vPzSmhsdy9l3pDdKF5mD2XeZf14=;
	b=ihAR/+lY6kBDIrWiStE8TpZWoTIGUSs/laTvKKMwGljMqC7oF7/Zm3HP/Dt9OowlbcWNZ2
	vwqLAZfDGafVK1d6w3rKcHAc1zJO5FmQl14dL0TLOHXMKH37e8O/KblA/5EEOOml2NJZY9
	97LqKIa4ta3+KQCT71vz6WXQsfMqnDw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740542385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ksmf5yRK+jmwzYn0vPzSmhsdy9l3pDdKF5mD2XeZf14=;
	b=ihAR/+lY6kBDIrWiStE8TpZWoTIGUSs/laTvKKMwGljMqC7oF7/Zm3HP/Dt9OowlbcWNZ2
	vwqLAZfDGafVK1d6w3rKcHAc1zJO5FmQl14dL0TLOHXMKH37e8O/KblA/5EEOOml2NJZY9
	97LqKIa4ta3+KQCT71vz6WXQsfMqnDw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE63913404
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJEmJ7CRvmdOegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: convert: check the sectorsize against BTRFS_MIN_BLOCKSIZE
Date: Wed, 26 Feb 2025 14:29:17 +1030
Message-ID: <4a0875f0bcfc7182bf9ba13be752eea948b666ce.1740542229.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740542229.git.wqu@suse.com>
References: <cover.1740542229.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
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
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This allow experimental btrfs-convert builds to handle 2K block sized
ext4, which is needed to pass convert related test cases in fstests.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert/main.c b/convert/main.c
index edc2c0d97c29..0dc75c9eb1c6 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1201,7 +1201,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 
 	UASSERT(cctx.total_bytes != 0);
 	blocksize = cctx.blocksize;
-	if (blocksize < 4096) {
+	if (blocksize < BTRFS_MIN_BLOCKSIZE) {
 		error("block size is too small: %u < 4096", blocksize);
 		goto fail;
 	}
-- 
2.48.1


