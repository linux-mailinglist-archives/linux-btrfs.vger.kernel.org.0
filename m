Return-Path: <linux-btrfs+bounces-4323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1698A7B9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 06:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8541C21800
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 04:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE92945013;
	Wed, 17 Apr 2024 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oAm6rn2x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oAm6rn2x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A70E2CCB4
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713329708; cv=none; b=p38bQ+EqoXVPhrYhsVTASgJ/lMDZ8gavAyX8Z7uaazxyECSsyAx9SZ1rzUcD0QmvkBlKEIgo+52fqvdMZot/8w55YSqwqAgey8RCxU/mC4ObNvqw81FctP+zPAfKD4NjkymNl3qcxqjS0ZSb8+o2Ujx559qoL/RqBS8U01lXttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713329708; c=relaxed/simple;
	bh=3kSDHc20VDuYXYHEKydTVqNaJVkvglfEtLJySo2YpNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRLj/A4KClSAeWbdO459pavBaxo4a8G0w5LCdfYadUxbngdw2hNb4IubSJsxozeAE5D5fe1o9HGoNX1gTpTQaVKN4VyNcMk1r5gy26wyM1w6KqkDzH1dTCpal9twOxgSG3tY2KYbW7b8kJNiZHQSYYvFPvI3kS5UlfnTh+8iqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oAm6rn2x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oAm6rn2x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35BA2202D7;
	Wed, 17 Apr 2024 04:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713329704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcuTw6FcB8UjnmhWfGxe8lIWJWHR8pRHZk5JSAVLV/g=;
	b=oAm6rn2x+8rdPZhjS0zPdmqfTDxjhdOf11STWrws9vGeQnpKg7LvVSTF/LGXo5Pdb9g08r
	h9O1pVlsSPCSywBorEcIiVa24iiSnmK6865V5bYp0Ex+hWmGuffqcf0vcPF/bSabmYnnNM
	cNY8EjIFSWzjTvU6XUXjfgaKFDb1wTE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oAm6rn2x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713329704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcuTw6FcB8UjnmhWfGxe8lIWJWHR8pRHZk5JSAVLV/g=;
	b=oAm6rn2x+8rdPZhjS0zPdmqfTDxjhdOf11STWrws9vGeQnpKg7LvVSTF/LGXo5Pdb9g08r
	h9O1pVlsSPCSywBorEcIiVa24iiSnmK6865V5bYp0Ex+hWmGuffqcf0vcPF/bSabmYnnNM
	cNY8EjIFSWzjTvU6XUXjfgaKFDb1wTE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FCD91384C;
	Wed, 17 Apr 2024 04:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yLtbLyZWH2YkeQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 17 Apr 2024 04:55:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 1/2] btrfs: set correct ram_bytes when splitting ordered extent
Date: Wed, 17 Apr 2024 14:24:38 +0930
Message-ID: <294cfed81888b2ea5ed4fffeb79ef9892443a3d3.1713329516.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713329516.git.wqu@suse.com>
References: <cover.1713329516.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 35BA2202D7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
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

Fixes: d22002fd37bd ("btrfs: zoned: split ordered extent when bio is sent")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
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


