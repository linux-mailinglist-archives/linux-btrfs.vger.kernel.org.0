Return-Path: <linux-btrfs+bounces-4854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F065A8C08FA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 03:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC604283DB4
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B20D13C3F6;
	Thu,  9 May 2024 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mOlAARXn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mOlAARXn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98C713BC2F
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715217207; cv=none; b=Wbh+vmU/PelBhMdiXynnv3fdZHIHv8nHX0XLSftQoi0oDMe3LxoXnFFunsRtoIgAPJIEyZXK5AnF/QKxHrGQO48hhr52L8c1CJdVU7dUQ+g6Jj2riFAhAZ3SPmd2y+yu7Rcnm3dAlUkJqVlmk3kf6PS6Rr9IiCydOur91n0s7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715217207; c=relaxed/simple;
	bh=494D4y62287M9xs8GwWX/JLgOeg6P9Yf9+kFKSZ3MvU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lkOousRCinpVmEn2BXtNUDrTq9CTj+ourZycP2ndZ+oh+d97o3Um0ybsH5IBGK1XZNB5uFRUsOFnC3F48eCaOfu+3K40smtL5WQoYoY0qWLeiX7ePD/e+AYTgM8ifNKxfqSYiUa1QKYSQ3pbbqIYwiGne08RL+ziPMpqFf351HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mOlAARXn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mOlAARXn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B5163791E
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 01:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715217204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=k+VS1m5HqoyTJfn0ImHuAVhC4NlBl5KOAOX4qi46UXI=;
	b=mOlAARXnv7YBF5deqlM9FPgBVVE/MBF6Vwhq7O3S9022XqiwOucilUL3GP6+On55tI45MA
	Hv+BZAhHM8VY+bV6ROlol/u2a4Fn7T72Rjci+KodYliRbwPy4YtY3VhqHLOcal2yRn5wN1
	8VAWh8z1YpCTC0awRM4nSrYkHysWW84=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715217204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=k+VS1m5HqoyTJfn0ImHuAVhC4NlBl5KOAOX4qi46UXI=;
	b=mOlAARXnv7YBF5deqlM9FPgBVVE/MBF6Vwhq7O3S9022XqiwOucilUL3GP6+On55tI45MA
	Hv+BZAhHM8VY+bV6ROlol/u2a4Fn7T72Rjci+KodYliRbwPy4YtY3VhqHLOcal2yRn5wN1
	8VAWh8z1YpCTC0awRM4nSrYkHysWW84=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 346C713A24
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 01:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FXH3MzIjPGYkLwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 01:13:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: dump-tree: support simple quota mode status flags
Date: Thu,  9 May 2024 10:43:04 +0930
Message-ID: <0711c49afa2a191a27be65bd806d601e3f8c1e0c.1715217175.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
X-Spam-Score: -2.80
X-Spam-Flag: NO

[BUG]
For simple quota mode btrfs, dump tree does not show the extra flags
correctly:

 # mkfs.btrfs -f -O squota $dev
 # btrfs ins dump-tree -t quota $dev | grep QGROUP_STATUS -A1
	item 0 key (0 QGROUP_STATUS 0) itemoff 16243 itemsize 40
		version 1 generation 10 flags ON scan 0 enable_gen 7

Note just ON is shown, but squota has one extra bit set for it.

[CAUSE]
Just no support for the new flag.

[FIX]
Add the new flag support, also to be consistent with other flags string
output, add output for extra unknown flags.

With a hand crafted image, the output with unknown flags looks like
this:
	item 0 key (0 QGROUP_STATUS 0) itemoff 16243 itemsize 40
		version 1 generation 10 flags ON|SIMPLE_MODE|UNKNOWN(0xf00) scan 0 enable_gen 7

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index a36737712b9d..149e9fcf4218 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -211,19 +211,28 @@ static void bg_flags_to_str(u64 flags, char *ret)
 	}
 }
 
-/* Caller should ensure sizeof(*ret)>= 26 "OFF|SCANNING|INCONSISTENT" */
+/*
+ * Caller should ensure sizeof(*ret)>= 61
+ * "OFF|SCANNING|INCONSISTENT|unknown flags (0xffffffffffffffff)"
+ */
 static void qgroup_flags_to_str(u64 flags, char *ret)
 {
 	ret[0] = 0;
+
 	if (flags & BTRFS_QGROUP_STATUS_FLAG_ON)
 		strcpy(ret, "ON");
 	else
 		strcpy(ret, "OFF");
 
+	if (flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE)
+		strcat(ret, "|SIMPLE_MODE");
 	if (flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN)
 		strcat(ret, "|SCANNING");
 	if (flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)
 		strcat(ret, "|INCONSISTENT");
+	if (flags & ~BTRFS_QGROUP_STATUS_FLAGS_MASK)
+		sprintf(ret + strlen(ret), "unknown flags (0x%llx)",
+			flags & ~BTRFS_QGROUP_STATUS_FLAGS_MASK);
 }
 
 void print_chunk_item(struct extent_buffer *eb, struct btrfs_chunk *chunk)
-- 
2.45.0


