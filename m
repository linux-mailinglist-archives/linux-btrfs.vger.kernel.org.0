Return-Path: <linux-btrfs+bounces-2315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C1A850D65
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 06:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC95284437
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 05:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433B6FB6;
	Mon, 12 Feb 2024 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fCgCmqlh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fCgCmqlh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372336AAD
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707716198; cv=none; b=irPhJWZjAU39HqPBAmvfzL+iN3NX/DQ+8QZ+AS/vvsPiwXg7DdFramVqD2Tkk7CX/a2MnmtTbyscsDoes+IurhnxvE8qtxKm67TAbEfqiGDY/+AhYXaEGh2d87/A3xTd2yS1GSkrWbRqhQgj9pWlktPkq9xjVYIAajCUEEbdiBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707716198; c=relaxed/simple;
	bh=qdbAZY80JFMYDlp3AI6ZXUeuS5G+k7gM+10lzGfABG0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bUvR11flp3goVwmBHfsgE0zWgz0MUXo+AZgNr7Fa5kliiX9X/Dbb81jyv3siANZ1zeIyHA+NSxWnwb67pZqtEpRTiXZFYVlNos9GKvk20pmFA+SbE09lw2jG4WPpnd67o/7v7qCD+k2AJaWJF2FYSerRlak6AHGU1g17HOOxauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fCgCmqlh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fCgCmqlh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 576A31F449
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 05:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707716194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sD4jKN8eGwP9Ozj7HC6A1Nr8JCiVULn2npRjKweiaIU=;
	b=fCgCmqlho1TtrXNlqJva/x9TPsISYzKstIQo3B6NfzPZFLJpCQ0nKAx6J3Iw+p/3bnLbRB
	ctEFHDPXXa/5Fw7NRk+2qu2zjwSvol2sAw2Ktvc6OY0kdqbk+OcXfcwhO2MXc2+F3tgFqi
	F1I+YjVqcdS+UMToESokleQU5QHIDlk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707716194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sD4jKN8eGwP9Ozj7HC6A1Nr8JCiVULn2npRjKweiaIU=;
	b=fCgCmqlho1TtrXNlqJva/x9TPsISYzKstIQo3B6NfzPZFLJpCQ0nKAx6J3Iw+p/3bnLbRB
	ctEFHDPXXa/5Fw7NRk+2qu2zjwSvol2sAw2Ktvc6OY0kdqbk+OcXfcwhO2MXc2+F3tgFqi
	F1I+YjVqcdS+UMToESokleQU5QHIDlk=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 636C413212
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 05:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vCZxB2GuyWVeSAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 05:36:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: mkfs: do not default to 4K sectorsize if the fs is zoned
Date: Mon, 12 Feb 2024 16:06:30 +1030
Message-ID: <f679cbd1b09fff494b58f37520a9ab727c3ff313.1707716170.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fCgCmqlh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.48 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[45.58%]
X-Spam-Score: 1.48
X-Rspamd-Queue-Id: 576A31F449
X-Spam-Flag: NO

With some help from a reporter using loongson (with 16K page size), and
a zoned device, it turns out that, zoned code is not compatible with
subpage's requirement.

Mostly conflicts on the multiple re-entry into the same @locked_page
using extent_write_locked_range().

The function is only utilized by compression for non-zoned btrfs, but
would be the default entry for all writes for zoned btrfs.

So we can not default to 4K for subpage zoned combination.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index b50b78b5665a..f54c1a055ae2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1383,15 +1383,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		printf("See %s for more information.\n\n", PACKAGE_URL);
 	}
 
-	if (!sectorsize)
-		sectorsize = (u32)SZ_4K;
-	if (btrfs_check_sectorsize(sectorsize))
-		goto error;
-
-	if (!nodesize)
-		nodesize = max_t(u32, sectorsize, BTRFS_MKFS_DEFAULT_NODE_SIZE);
-
-	stripesize = sectorsize;
 	saved_optind = optind;
 	device_count = argc - optind;
 	if (device_count == 0)
@@ -1470,6 +1461,29 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		features.incompat_flags |= BTRFS_FEATURE_INCOMPAT_ZONED;
 	}
 
+	if (!sectorsize) {
+		/*
+		 * Zoned btrfs utilize extent_write_locked_range(), which can not
+		 * handle multiple entries into the same locked page.
+		 *
+		 * For non-zoned btrfs, subpage workaround the problem by requiring
+		 * full page alignment for compression (the only path utilizing
+		 * that path).
+		 * But since zoned btrfs always goes that path, kernel can not support
+		 * writes into subpage zoned btrfs.
+		 */
+		if (!opt_zoned)
+			sectorsize = (u32)SZ_4K;
+		else
+			sectorsize = (u32)getpagesize();
+	}
+	if (btrfs_check_sectorsize(sectorsize))
+		goto error;
+
+	if (!nodesize)
+		nodesize = max_t(u32, sectorsize, BTRFS_MKFS_DEFAULT_NODE_SIZE);
+
+	stripesize = sectorsize;
 	/*
 	* Set default profiles according to number of added devices.
 	* For mixed groups defaults are single/single.
-- 
2.43.0


