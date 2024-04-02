Return-Path: <linux-btrfs+bounces-3814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAB6894B50
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 08:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F232818B3
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 06:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0051B5AA;
	Tue,  2 Apr 2024 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="evIutyoE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1358182BD
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039026; cv=none; b=ASYuSgBxWOcvUaDD+A4UNzaCZ3pJi0LqX9OJByEsWCsWTp8++auBlGj6imRxKrn8QsJEzw7VMT8rTfSbKp7BIwACppn4J2yL9eVA8kSNEmX35DQJR+3egJbsVj4TOBOx+qwuC7t/zg01pbbFL4MF3taKNeo/oQJtbIm2a/do9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039026; c=relaxed/simple;
	bh=Nzl2b7ymXbWOlpCKxfvC0imU54WK2LKBh592AizEjJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d3nUvL7ZEoILIoYzLcTiYAltkfNIjEaeam05NH/c+T1lrYMjaV1ajGAKb+8OJx1Q+jBF3jdKOn7HfFlhDRJpk3ywjVaSFG9nN4yOAYb4lVN3OgUjvf9jJ1HdMs40cOcgPfMai/cZK1391SirLRAkEo3WfOY+D4Zo2GMwJselCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=evIutyoE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2089A20CA3
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 06:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712039023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/PXIJws8JZ1V0+/RqizFFPDZMEVvKRBmx2BCncFFETY=;
	b=evIutyoERMWhRRuFLc+BRuK4KYZqUKsDXXCtBanbvQ+5XSlpjolKlgCBTe3sctLQSIDP7F
	mdpHUzYwOvaSci2YGbnbjpQ1fffPiqGQp+5iKLrIX7xj9JABYcYJeBzbE8Qya7Jbit53zg
	D5o3AvsFJGzdHVUek+FoF7ATcVx704c=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E73E13A90
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 06:23:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id S7yzOG2kC2biOQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 06:23:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: more explaination on extent_map members
Date: Tue,  2 Apr 2024 16:53:18 +1030
Message-ID: <cover.1712038308.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[40.08%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.20
X-Spam-Level: *
X-Spam-Flag: NO

Btrfs uses extent_map to represent a in-memory file extent.

There are severam members that are 1:1 mappe in on-disk file extent
items and extent maps:

- extent_map::start	==	key.offset
- extent_map::len	==	file_extent_num_bytes
- extent_map::ram_bytes	==	file_extent_ram_bytes

But that's all, the remaining are pretty different:

- Use block_start to indicate holes/inline extents
  Meanwhile btrfs on-disk file extent items go with a dedicated type for
  inline extents, and disk_bytenr 0 for holes.

- Extra members for fsync optimization
  I'm still not 100% sure how mod_start and mod_len really works though.

- Weird block_start/orig_block_len/orig_start
  In theory we can directly go with the same file_extent_disk_bytenr,
  file_extent_disk_num_bytes and file_extent_offset to calculate the
  remaining members (block_start/orig_start/orig_block_len/block_len).

  But for whatever reason, we didn't go that path and have a hell of
  weird and inconsistent calculation for them.

I do not have the confidence to handle the mess yet, but as the first
step, I would add comments for those members mostly according to
btrfs_extent_item_to_extent_map(), and hopefully we can improve the
situation in not-far-away future.

Qu Wenruo (2):
  btrfs: add extra comments on extent_map members
  btrfs: simplify the inline extent map creation

 fs/btrfs/extent_map.h | 62 ++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/file-item.c  | 14 ++++++----
 2 files changed, 70 insertions(+), 6 deletions(-)

-- 
2.44.0


