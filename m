Return-Path: <linux-btrfs+bounces-6451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C00930D7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 07:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8F31F213C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 05:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051BE1F61C;
	Mon, 15 Jul 2024 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lO9wLdBJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lO9wLdBJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799DD2EE
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020678; cv=none; b=lZrnKsDTQ5OcU9QFQmCtm3XiP1Jvb2bMYWPoATUwOGQTMVirILLu/mbIF0UBBzG/N9kwCv+V2pW8kPOe6z2e1zr6eNLxPrA4Mt3RanBFnqS1wJYYP4Yn2MC/CnydsARAvP251r0oYmns5CHX8uVzRXuoRWYyZfHO6S1DmIEJZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020678; c=relaxed/simple;
	bh=w/vq7phKbabSYriYQ98q/aAm+M3CvWOX073X1KZiH9s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWkH+U0d6J1U0jwAbdB4Au1IeAeQynLSa+dP0b6Iuf0/GQ5HOC4jhd8XzSdWwwyFklbe+tDdz47x+6QlcfqbmZn+wQ8VU1wj7bL0h/AKGrsDPRUZQTvTkqWna2tWyQQDCaeeQ7lWvcWoCimpKH1pSI2Gny1Xg2XeprK9NTKv+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lO9wLdBJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lO9wLdBJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DF3921A22
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GmBiy5H2WviIqHht3Nk6TZuAb2q+ySNxNoJPuXBURv0=;
	b=lO9wLdBJyghXyBYN7EHqkHz4XoQDV+E3hN76kaLFrNpBNPSSi60umOKwdsFqr6+jxviSvb
	efQ1raRNSgHUvy+mZl/gdXV6T8iiBGVADFQtViSgb26jSon4AqQu+VIV2ZJcuBZPBb5PI5
	hg37IddNz1Y4qXdU3JnVZjRqnw3JMlc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GmBiy5H2WviIqHht3Nk6TZuAb2q+ySNxNoJPuXBURv0=;
	b=lO9wLdBJyghXyBYN7EHqkHz4XoQDV+E3hN76kaLFrNpBNPSSi60umOKwdsFqr6+jxviSvb
	efQ1raRNSgHUvy+mZl/gdXV6T8iiBGVADFQtViSgb26jSon4AqQu+VIV2ZJcuBZPBb5PI5
	hg37IddNz1Y4qXdU3JnVZjRqnw3JMlc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81CD7137EB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MIY1DwCxlGZRRAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: convert: fix the filename output when rolling back
Date: Mon, 15 Jul 2024 14:47:32 +0930
Message-ID: <2edd8cb2811c90d6a65861379593680f233ade14.1721020542.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721020542.git.wqu@suse.com>
References: <cover.1721020542.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

[BUG]
When rolling back a converted btrfs, the filename output is corrupted:

 $ btrfs-convert -r  ~/test.img
 btrfs-convert from btrfs-progs v6.9.2

 Open filesystem for rollback:
   Label:
   UUID:            df54baf3-c91e-4956-96f9-99413a857576
   Restoring from:  ext2_saved0ƨy/image
                              ^^^ Corruption
 Rollback succeeded

[CAUSE]
The error is in how we handle the filename.
In btrfs all our strings are not '\0' terminated, but with explicit
length.

But in C, most strings are '\0' terminated, so after reading a filename
from btrfs, we need to manually terminate the string.

However the code adding the terminating '\0' looks like this:

	/* Get the filename length. */
	name_len = btrfs_root_ref_name_len(path.nodes[0], root_ref_item);

	/*
	 * This should not happen, but as an extra handling for possible
	 * corrupted btrfs.
	 */
	if (name_len > sizeof(dir_name))
		name_len = sizeof(dir_name) - 1;
	/* Got the real filename into our buffer. */
 	read_extent_buffer(path.nodes[0], dir_name, (unsigned long)(root_ref_item + 1), name_len);

	/* Terminate the string. */
	dir_name[sizeof(dir_name) - 1] = 0;

The problem is, the final termination is totally wrong, it always make
the last buffer char '\0', not using the @name_len we read before.

[FIX]
Use @name_len to terminate the string, as we have already updated it to
handle buffer overflow, it can handle both the regular and corrupted
case.

Fixes: dc29a5c51d63 ("btrfs-progs: convert: update default output")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert/main.c b/convert/main.c
index 8e73aa25b1da..dfb9f44f6f75 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1720,7 +1720,7 @@ static int do_rollback(const char *devname)
 	if (name_len > sizeof(dir_name))
 		name_len = sizeof(dir_name) - 1;
 	read_extent_buffer(path.nodes[0], dir_name, (unsigned long)(root_ref_item + 1), name_len);
-	dir_name[sizeof(dir_name) - 1] = 0;
+	dir_name[name_len] = 0;
 
 	printf("  Restoring from:  %s/%s\n", dir_name, image_name);
 
-- 
2.45.2


