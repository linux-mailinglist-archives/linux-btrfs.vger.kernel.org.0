Return-Path: <linux-btrfs+bounces-3581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85B88B5FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 01:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054381F3BE4E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 00:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBAC33FD;
	Tue, 26 Mar 2024 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oOxw7fGv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oOxw7fGv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3F1C32
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412598; cv=none; b=YBgMPxgf5Iwq37Ep9pRYQQrWNDR3Q57HIRlBDEAe4w9ROIOTeObcW0O8r+VOd4VHDr2IWnUg4s9/ZODs7QTAlY/nLcMwRJUz2NoskMlvo/295kfUPV6nmnpTftCWiWG+QbZ0UKpZgT3BHxumivIQuq4NbrOWuuPDxWtG1FLFLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412598; c=relaxed/simple;
	bh=MlpIsCa5jFcKIuYVY7LL8bDrWcMJbFMIZEPxJs92X7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGy++H7FtAX+MRkIRFN/yEFNcgDJZn4grR6mo2PJwUyibls06EHkkO0bn8XBQrK4+XqKK8THONYmy5Od9KuXGnfT+4pT254s+KNPBK0cNKvE2vFF12UXWZOVkE0p8decehmcekUcJiMAD6xgsBF/ptxHwdY1jJZjxREbj+hjay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oOxw7fGv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oOxw7fGv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D0C05CE29
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnQpUzP5gvjlC5TorASiHrgBpUrmdj1oNN2dAjhatTY=;
	b=oOxw7fGv8GgTc1QIFR9LouhPa4dM9PZVaInriiA6D1BFC+ERxNgS7nmlpma/wkzAySf3ac
	NZXdJZEbKMqaxMm2KjJ5AL0iIu/zjxGwyOdkjTHqbIoPBe/7Pkr85XbIBl41MOb+mg58nw
	iezU0s2RtFanrkkzl5pRhRE+Z8nRC20=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnQpUzP5gvjlC5TorASiHrgBpUrmdj1oNN2dAjhatTY=;
	b=oOxw7fGv8GgTc1QIFR9LouhPa4dM9PZVaInriiA6D1BFC+ERxNgS7nmlpma/wkzAySf3ac
	NZXdJZEbKMqaxMm2KjJ5AL0iIu/zjxGwyOdkjTHqbIoPBe/7Pkr85XbIBl41MOb+mg58nw
	iezU0s2RtFanrkkzl5pRhRE+Z8nRC20=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 86CEF13586
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2L99EnEVAmbOJAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs-progs: mkfs: use proper zoned compatible write for bgt feature
Date: Tue, 26 Mar 2024 10:52:43 +1030
Message-ID: <a02d6663b98c19782dc553028b9683fe2929bb37.1711412540.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711412540.git.wqu@suse.com>
References: <cover.1711412540.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.79
X-Spamd-Result: default: False [0.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
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
	 NEURAL_HAM_SHORT(-0.11)[-0.572];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

[BUG]
There is a bug report that mkfs.btrfs can not specify block-group-tree
feature along with zoned devices:

  # mkfs.btrfs /dev/nullb0 -O block-group-tree,zoned
  btrfs-progs v6.7.1
  See https://btrfs.readthedocs.io for more information.

  Resetting device zones /dev/nullb0 (40 zones) ...
  NOTE: several default settings have changed in version 5.15, please make sure
        this does not affect your deployments:
        - DUP for metadata (-m dup)
        - enabled no-holes (-O no-holes)
        - enabled free-space-tree (-R free-space-tree)

  ERROR: error during mkfs: Invalid argument

[CAUSE]
During mkfs, we need to write all the 7 or 8 tree blocks into the
metadata zone, and since it's zoned device, we need to fulfill all the
requirement for zoned writes, including:

- All writes must be in sequential bytenr
- Buffer must be aligned to sector size

The sequential bytenr requirement is already met by the mkfs design, but
the second requirement on memory alignment is never met for metadata, as
we put the contents of a leaf in extent_buffer::data[], which is after a
lot of small members.

Thus metadata IO buffer would never be aligned to sector size (normally
4K).
And we require btrfs_pwrite() and btrfs_pread() to handle the memory
alignment for us.

However in create_block_group_tree() we didn't use btrfs_pwrite(), but
plain pwrite() call directly, which would lead to -EINVAL error due to
memory alignment problem.

[FIX]
Just call btrfs_pwrite() instead of the plain pwrite() in
create_block_group_tree().

Issue: #765
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 5e56b33dda6d..3c48a6c120e7 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -249,8 +249,8 @@ static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_header_nritems(buf, 1);
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, cfg->nodesize,
-		     cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
+	ret = btrfs_pwrite(fd, buf->data, cfg->nodesize,
+			   cfg->blocks[MKFS_BLOCK_GROUP_TREE], cfg->zone_size);
 	if (ret != cfg->nodesize)
 		return ret < 0 ? -errno : -EIO;
 	return 0;
-- 
2.44.0


