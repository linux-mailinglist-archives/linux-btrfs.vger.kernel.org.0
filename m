Return-Path: <linux-btrfs+bounces-3044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD287469D
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 04:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3CB1F233A7
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 03:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC4DDD3;
	Thu,  7 Mar 2024 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tgUuvz1U";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tgUuvz1U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5663C7
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781422; cv=none; b=YhFrpTvhp0MGZzm82cNTx+ev8YjuUQ9pGOza6nPE803viJy33EpDGk2y8JBcqDPeGvqd8arl6FUEVPe7Z1L8YSbExnJOqRArRrW+IFEirFZJIgtB7jz7A/eXFxJdOXK31luhwKLYRLAP/3kGjStHbPi+beWRf8vaTTJ9SXOJX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781422; c=relaxed/simple;
	bh=OABo5+ADR80ZDVQiBTAIcRch1GewyN16/KKjzZMuaps=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jFvVLXvH9cNx2BRYzcbz/Vn+W9n01QPjBAim2oQEweZUelbxB64eJnIddaDucuysHHTq5LmCvgzigtdv4t26LvhyGN4emX94t4PjD/qIZGKielmSvkBSoWBq5AJJ96eUDMDSW1R43RbDT/qwcy6rH1igNpGvkbl/Rwb9a7jj24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tgUuvz1U; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tgUuvz1U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36A338B88F
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 03:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709781418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GCjTefyROhGEQITQa8rWA0t1ZIlOzQlAWG9vy/r5qQg=;
	b=tgUuvz1UPrJ+zvXlYmcXZsvbv2b5YZnnoFwZDNhXNEmjLrprmSNP8rYISrBi5PtEivR4Eg
	BIOc7LmcF8S6NgXHQ0GbK9EVCYq6xzv9d3S7OKBxcmuEq1bGIpVgF1KKaHAKLGVHLg0MuU
	KrSvuHEuEbHJSt1O4mHBF2TgBKTqieM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709781418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GCjTefyROhGEQITQa8rWA0t1ZIlOzQlAWG9vy/r5qQg=;
	b=tgUuvz1UPrJ+zvXlYmcXZsvbv2b5YZnnoFwZDNhXNEmjLrprmSNP8rYISrBi5PtEivR4Eg
	BIOc7LmcF8S6NgXHQ0GbK9EVCYq6xzv9d3S7OKBxcmuEq1bGIpVgF1KKaHAKLGVHLg0MuU
	KrSvuHEuEbHJSt1O4mHBF2TgBKTqieM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 646F313466
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 03:16:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id r3taBqkx6WUqDgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 07 Mar 2024 03:16:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: fix data corruption/rsv leak in subpage zoned cases
Date: Thu,  7 Mar 2024 13:46:37 +1030
Message-ID: <cover.1709781158.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tgUuvz1U
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.44 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.05)[60.27%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.44
X-Rspamd-Queue-Id: 36A338B88F
X-Spam-Flag: NO

[CHANGELOG]
v3:
- Use the minimal fsstress workload with trace_printk() output to
  explain the bug better

v2:
- Update the commit message for the first patch
  As there is something wrong with the ASCII art of the memory layout.

[REPO]
https://github.com/adam900710/linux/tree/subpage_delalloc

The repo includes the subpage delalloc rework, or subpage zoned won't
work at all.


Although my previous subpage delalloc rework fixes quite a lot of
crashes of subpage + zoned support, it's still pretty easy to cause rsv
leak using single thread fsstress.

It turns out that, it's not a simple problem of some rsv leak, but
certain dirty data ranges never got written back and just skipped with
its dirty flags cleared, no wonder that would lead to rsv leak.

The root cause is again in the extent_write_locked_range() function
doing weird subpage incompatible behaviors, especially when it clears
the page dirty flag for the whole page, causing __extent_writepage_io()
unable to locate further dirty ranges to be submitted.

The first patch would solve the problem, meanwhile for the 2nd patch
it's a cleanup, as we will never hit the error for current subpage +
zoned cases.

Qu Wenruo (2):
  btrfs: do not clear page dirty inside extent_write_locked_range()
  btrfs: make extent_write_locked_range() to handle subpage writeback
    correctly

 fs/btrfs/extent_io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.44.0


