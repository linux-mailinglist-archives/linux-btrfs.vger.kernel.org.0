Return-Path: <linux-btrfs+bounces-12124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E1A58CFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 08:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFF23AA02D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5449E221541;
	Mon, 10 Mar 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oQy0Y4mq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oQy0Y4mq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E0421ABDC
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592185; cv=none; b=IBRu14CuQQuhrfLW7E93OuRtGw1fNPqG0CgcBJGrYCau3LfTNsu2hNRdEnR+/rS2fXL4LzWvOkc5MWnqOjukRgb6IQtyV2S7mHftmT50w2a4oN3n/Zb2OBnXtE+QK5IauLFZg+Fa4kfXr1MRzOUR8UiBMIt/oxcaZlSOVCuFeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592185; c=relaxed/simple;
	bh=SdzAjh6Y8iAjS1aQBmnIXzHV7QyuGatiINs1Gos29ZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X8gLQI2ek6gO3ZVtg8eByZ89eo8way6pYfCA4ogNZkL1OCEX9YnwEwW+p2UBMq0HZP6QBdZMUHBQovhTMDI2Aa+NGcacPtO+IMD6ml27DnKkE63PZ3oGcfcezofX9ZENza9JDOV356bllfVJXUD9wKZdzJv5dZsMLnYzg3coOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oQy0Y4mq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oQy0Y4mq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48AFB1F452
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ctk3fN4t8nRmzGohJfUqpoBos+bar3soYAXowMdGgHo=;
	b=oQy0Y4mqqaj/jBGpn3jWMyN3rELt/RQAX6YAoU02pzOeo19M7tTR9Ajv5laWQF4vzCWxQZ
	cCBVLu3NF9G6Mu5MqWAVVpl930rir4+f3Yj9SyWAW/4ZQ7HTY2EI3fRGkH5B3Giql2XvCO
	4pIs+hTVr8rqKhaRYfnusUtHocE1vWI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ctk3fN4t8nRmzGohJfUqpoBos+bar3soYAXowMdGgHo=;
	b=oQy0Y4mqqaj/jBGpn3jWMyN3rELt/RQAX6YAoU02pzOeo19M7tTR9Ajv5laWQF4vzCWxQZ
	cCBVLu3NF9G6Mu5MqWAVVpl930rir4+f3Yj9SyWAW/4ZQ7HTY2EI3fRGkH5B3Giql2XvCO
	4pIs+hTVr8rqKhaRYfnusUtHocE1vWI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 796F613A70
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zLaGDXSWzmfpMAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/6] btrfs: prepare for larger folios support
Date: Mon, 10 Mar 2025 18:05:56 +1030
Message-ID: <cover.1741591823.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
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

[CHANGELOG]
v2:
- Split the subpage.[ch] modification into 3 patches
- Rebased the latest for-next branch
  Now all dependency are in for-next.

This means:

- Our subpage routine should check against the folio size other than
  PAGE_SIZE

- Make functions handling filemap folios to use folio_size() other than
  PAGE_SIZE

  The most common paths are:
  * Buffered reads/writes
  * Uncompressed folio writeback
    Already handled pretty well

  * Compressed read
  * Compressed write
    To take full advantage of larger folios, we should use folio_iter
    other than bvec_iter.
    This will be a dedicated patchset, and the existing bvec_iter can
    still handle larger folios.

  Internal usages can still use page sized folios, or even pages,
  including:
  * Encoded reads/writes
  * Compressed folios
  * RAID56 internal pages
  * Scrub internal pages

This patchset will handle the above mentioned points by:

- Prepare the subpage routine to handle larger folios
  This will introduce a small overhead, as all checks are against folio
  sizes, even on x86_64 we can no longer skip subpage completely.

  This is done in the first patch.

- Convert straightforward PAGE_SIZE users to use folio_size()
  This is done in the remaining patches.

Currently this patchset is not a exhaustive conversion, I'm pretty sure
there are other complex situations which can cause problems.
Those problems can only be exposed and fixed after switching on the
experimental larger folios support later.

Qu Wenruo (6):
  btrfs: subpage: make btrfs_is_subpage() check against a folio
  btrfs: add a @fsize parameter to btrfs_alloc_subpage()
  btrfs: replace PAGE_SIZE with folio_size for subpage.[ch]
  btrfs: prepare btrfs_launcher_folio() for larger folios support
  btrfs: prepare extent_io.c for future larger folio support
  btrfs: prepare btrfs_page_mkwrite() for larger folios

 fs/btrfs/extent_io.c | 49 ++++++++++++++++++++++++--------------------
 fs/btrfs/file.c      | 19 +++++++++--------
 fs/btrfs/inode.c     |  4 ++--
 fs/btrfs/subpage.c   | 38 +++++++++++++++++-----------------
 fs/btrfs/subpage.h   | 16 +++++++--------
 5 files changed, 66 insertions(+), 60 deletions(-)

-- 
2.48.1


