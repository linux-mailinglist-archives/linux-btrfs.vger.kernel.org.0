Return-Path: <linux-btrfs+bounces-11966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDCDA4B974
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CA03A99D1
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854C1B0406;
	Mon,  3 Mar 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ToH3LS0h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ToH3LS0h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242661E98FF
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990965; cv=none; b=fmrnXiPQtZp/q8KdOaucuB1+HlZ4kqa/5Otr9BqFgLWLU4u/xbgDpBBZf6hqk6gsTwqZ24Z5w9uIjypRUlv3d7ca5Vkr+tDyFpHy7IQm72fNcAClM8DC+fvwyOFiQUqaSnBLcwZDxqXjF+5QG895AvR1oJgjA+ORouIIMRUqCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990965; c=relaxed/simple;
	bh=amig9pL839CNVUFaLN33wLZrMKHpu/ZM/Qtn+uoYJyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdCJYUuPUnr8eBW55Fq8tSlob4XpBYLuDAmC45fUtTHmb+0zjQx8XcSJUIgkSYKxEwlAQtap/RbhiC8aeCDR2drfKEYuSJuRcaYXVXdG0GB0CNx/2/avrnZc3FRvXmg7tH6rV9f0SXkNZ0atzKgYG0W0ICNeeyPT/S0YeUk1dWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ToH3LS0h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ToH3LS0h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F3D01F444;
	Mon,  3 Mar 2025 08:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIcU4NXOQab0ESjlHFcPq43JEzZ39O00AK7oQs902nQ=;
	b=ToH3LS0hXwno2/0DmnC56Mu8f0FEVZA7AzcJ6RSTZRluM4yIoF1KwKh2FK85jlT89qoEgb
	aVeLjTkC6M8jnUaYhqAYkAzAXBmommFigYFV0rPYrvzY2Xi0PMt/z2Z3t9Bn/HqoKb2+JB
	iv/EiYiXdmzmVU8Mxkb4OQo9jM1cNmM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ToH3LS0h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIcU4NXOQab0ESjlHFcPq43JEzZ39O00AK7oQs902nQ=;
	b=ToH3LS0hXwno2/0DmnC56Mu8f0FEVZA7AzcJ6RSTZRluM4yIoF1KwKh2FK85jlT89qoEgb
	aVeLjTkC6M8jnUaYhqAYkAzAXBmommFigYFV0rPYrvzY2Xi0PMt/z2Z3t9Bn/HqoKb2+JB
	iv/EiYiXdmzmVU8Mxkb4OQo9jM1cNmM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F4A013939;
	Mon,  3 Mar 2025 08:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cAa4CNppxWdybwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Mar 2025 08:35:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 3/8] btrfs: fix the qgroup data free range for inline data extents
Date: Mon,  3 Mar 2025 19:05:11 +1030
Message-ID: <67cb189930e47272a89cb159f9a070f7ccd12700.1740990125.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740990125.git.wqu@suse.com>
References: <cover.1740990125.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F3D01F444
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
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Inside function __cow_file_range_inline() since the inlined data no
longer takes any data space, we need to free up the reserved space.

However the code is still using the old page size == sector size
assumption, and will not handle subpage case well.

Thankfully it is not going to cause any problems because we have two extra
safe nets:

- Inline data extents creation is disable for sector size < page size
  cases for now
  But it won't stay that for long.

- btrfs_qgroup_free_data() will only clear ranges which are already
  reserved
  So even if we pass a range larger than what we need, it should still
  be fine, especially there is only reserved space for a single block at
  file offset 0 for an inline data extent.

But just for the sake of consistentcy, fix the call site to use
sectorsize instead of page size.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3652c3485e19..c7b0f1173722 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -672,7 +672,7 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
 	 */
-	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE, NULL);
+	btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
-- 
2.48.1


