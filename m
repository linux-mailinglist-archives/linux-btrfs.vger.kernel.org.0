Return-Path: <linux-btrfs+bounces-4855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E362C8C0904
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 03:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA0D1C20F0F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 01:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C103313C668;
	Thu,  9 May 2024 01:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GVGhwPoD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GVGhwPoD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324292BB12
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715217567; cv=none; b=Czih++aTFavM0JR5qdI34AiUCCTPPbGQpUVZA9uO5Hhqi70AziWupEZ5Hh5Ng/qoan3PD5FAKXSQcN49JFv+d2V52Gn4lVuEw8vZNJo0imVKTd/vzvUfgSgkTowB781vq/En4zPHVuhwutKzQi5NdbMP6J6c4rQLjt5UmWGYoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715217567; c=relaxed/simple;
	bh=GwTJfSQH3a+pKyth+QTaWrDEImuxGeZggTG1oaPJdxY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VX448/o2UvzZTzbeFneYvOwLex+b+nr6I9z15ZqyNv87eUZwdliZW6gcNaKmo8f4ZExr3kiZTf71ugVlN72Wn0DMgDsU0bBee5aUK8AJYba45ycNX5KdsLoGLYXmVhnTy3KKVOdne5gSJlsIpPY3xGcbG5uc6WylyAhhx9wOUQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GVGhwPoD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GVGhwPoD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45F495D55B
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 01:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715217563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kasYjLOjLI2uc2g3867pbSit7xO6kHAUKNCNItvf9f8=;
	b=GVGhwPoDgvchAMCU9TUFvUXIRarOagsT/i7A1Pc7AbKSL9zzSEampH8UkwZDoUbVpGyHDd
	/iKNUSirw0nGNEQlAuLd80iS1urqfuywgoqgZiTbp2cGU40Q5aFmov1NT4pmfjMv0Y3YRp
	bqgNNre0w1XvsqjEyyW+aqImvoJ1MxU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715217563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kasYjLOjLI2uc2g3867pbSit7xO6kHAUKNCNItvf9f8=;
	b=GVGhwPoDgvchAMCU9TUFvUXIRarOagsT/i7A1Pc7AbKSL9zzSEampH8UkwZDoUbVpGyHDd
	/iKNUSirw0nGNEQlAuLd80iS1urqfuywgoqgZiTbp2cGU40Q5aFmov1NT4pmfjMv0Y3YRp
	bqgNNre0w1XvsqjEyyW+aqImvoJ1MxU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E14713A41
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 01:19:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a8ThAZokPGYuMQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 01:19:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: dump-tree: support simple quota mode status flags
Date: Thu,  9 May 2024 10:49:03 +0930
Message-ID: <4c86accc806fc1a53bdb198168458ca90c288ce4.1715217526.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
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
Changelog:
v2:
- Change the output format for unknown flags to match the example
---
 kernel-shared/print-tree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index a36737712b9d..b303fcdc7ccd 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -211,19 +211,28 @@ static void bg_flags_to_str(u64 flags, char *ret)
 	}
 }

-/* Caller should ensure sizeof(*ret)>= 26 "OFF|SCANNING|INCONSISTENT" */
+/*
+ * Caller should ensure sizeof(*ret)>= 64
+ * "OFF|SCANNING|INCONSISTENT|UNKNOWN(0xffffffffffffffff)"
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
+		sprintf(ret + strlen(ret), "|UNKNOWN(0x%llx)",
+			flags & ~BTRFS_QGROUP_STATUS_FLAGS_MASK);
 }

 void print_chunk_item(struct extent_buffer *eb, struct btrfs_chunk *chunk)
--
2.45.0


