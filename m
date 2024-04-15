Return-Path: <linux-btrfs+bounces-4283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F678A5E40
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 01:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0008FB21E52
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 23:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF4415921E;
	Mon, 15 Apr 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KqLorfPN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KqLorfPN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E1156F35
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223470; cv=none; b=ijZnsgEMUJ63nmz4f0+0VaNvojpewWJ+/jemhz4o2zlbJ1dltAl6bjg6bh/I8hUW0Ua2uUeLKg1rgFvytmgU+Dm/ATOOrK6APgcHd+lGyE5PvmCijjhSjH1oXp4/jS78l7qOwLXb4eHghUWJDE/HPqxC+OL2XXJU2GlFtrWJ0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223470; c=relaxed/simple;
	bh=ylrv5iNw1gJZQ2apo9C1QXH+5rjIyNWOLAohj6Xo7Rg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvVTIELIxJbXMFdYllQa3CpDRsRPuNLlU4oLIvR5bVyy05NjewcTE8gOlt+48QdjrgYPot6EZ7FBUcwI9xqGM6Wc/ThEz0cnsNp+uVDLocoMGBms6rSiv/yuCgN0nW1/fICbtAxEegJKj2226Vwi/Wh6pSTQM1o3hgkdaRL9L+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KqLorfPN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KqLorfPN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DAF95D4E2
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713223466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkEIjOGDIOauGx/Ms8U6qF7+VAx+yvqD3GiJvTvsEW4=;
	b=KqLorfPNt6Te4YM7cXRa0XM//6GcpCz5QsygCDixoNM4EjZ+G0I7yTzDx9EMYmcQztDxkR
	m5QcOY7xEyTiGrBkrDxP5bBwwrQjiIWsHpws4sym7Xj4wrUXz3EL8flfeP4dUiSsFJozSL
	2RN+yJBdWeyWtXEnz4Oa50jNMkA7AuQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713223466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkEIjOGDIOauGx/Ms8U6qF7+VAx+yvqD3GiJvTvsEW4=;
	b=KqLorfPNt6Te4YM7cXRa0XM//6GcpCz5QsygCDixoNM4EjZ+G0I7yTzDx9EMYmcQztDxkR
	m5QcOY7xEyTiGrBkrDxP5bBwwrQjiIWsHpws4sym7Xj4wrUXz3EL8flfeP4dUiSsFJozSL
	2RN+yJBdWeyWtXEnz4Oa50jNMkA7AuQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A93F813957
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gFvrGim3HWZzSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: set correct ram_bytes when splitting ordered extent
Date: Tue, 16 Apr 2024 08:54:05 +0930
Message-ID: <8f23c433c686f87ae863071e1c16950c7b9ebd44.1713223082.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713223082.git.wqu@suse.com>
References: <cover.1713223082.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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
When running generic/287, the following file extent items can be
generated:

        item 16 key (258 EXTENT_DATA 2682880) itemoff 15305 itemsize 53
                generation 9 type 1 (regular)
                extent data disk byte 1378414592 nr 462848
                extent data offset 0 nr 462848 ram 2097152
                extent compression 0 (none)

Note that file extent item is not a compressed one, but its ram_bytes is
way larger than its disk_num_bytes.

According to btrfs on-disk scheme, ram_bytes should match disk_num_bytes
if it's not a compressed one.

[CAUSE]
Since commit b73a6fd1b1ef ("btrfs: split partial dio bios before
submit"), for partial dio writes, we would split the ordered extent.

However the function btrfs_split_ordered_extent() doesn't update the
ram_bytes even it has already shrunk the disk_num_bytes.

Originally the function btrfs_split_ordered_extent() is only introduced
for zoned devices in commit d22002fd37bd ("btrfs: zoned: split ordered
extent when bio is sent"), but later commit b73a6fd1b1ef ("btrfs: split
partial dio bios before submit") makes non-zoned btrfs affected.

Thankfully for un-compressed file extent, we do not really utilize the
ram_bytes member, thus it won't cause any real problem.

[FIX]
Also update btrfs_ordered_extent::ram_bytes inside
btrfs_split_ordered_extent().

Fixes: b73a6fd1b1ef ("btrfs: split partial dio bios before submit")
Fixes: d22002fd37bd ("btrfs: zoned: split ordered extent when bio is sent")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ordered-data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b749ba45da2b..c2a42bcde98e 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1188,6 +1188,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	ordered->disk_bytenr += len;
 	ordered->num_bytes -= len;
 	ordered->disk_num_bytes -= len;
+	ordered->ram_bytes -= len;
 
 	if (test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags)) {
 		ASSERT(ordered->bytes_left == 0);
-- 
2.44.0


