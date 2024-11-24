Return-Path: <linux-btrfs+bounces-9876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF99D7942
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 00:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EC3162ECB
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 23:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CC7187FF4;
	Sun, 24 Nov 2024 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K6TzjISw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K6TzjISw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B52500BD
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492670; cv=none; b=aE8MV6GKaM+Wn7xDJYsXzEw9SUcyvMIRRoVn4sVXlMHjVbiI7Iza3VWKx6l+Hoeir9yPFrtCZIQOkcJI1xga9JtyPQmmSCtd1LUzeiL3wXR6NBJACj3NbPNtmqWDDqFJkJ0Bu+tuDcK4IXIiTFjyXLt74hnTld0u8NNlWzQ0Upo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492670; c=relaxed/simple;
	bh=gj2Hi0/YO012USvB5c4t5106uuOeJ3L5p3RaxPl8c8Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DM6PH8qVUrHMfNmeAJwGRodhecQG+PEIcV/zHAabMlIquGrQBaZtbOJSEklV018HhyI6eIzQAQoiARHscO8jNFA8HOvlDc6yTnjG2yuHqe+7Nv9d5vXdaG8W2OhISS1MuMZ8neNvC6098BHe8IfyhnyZ4Pb4PxNxIccfS6T7dhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K6TzjISw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K6TzjISw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 024E021189
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732492667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YkW20EHuGQCHEIUxf664Lc9iGqpzUYJO4su/DLzZxHw=;
	b=K6TzjISwl5ob5bew+cllZ7q8ElLu+nZn6cceqmczRpoogJY8ZwQJ3j7k9Sg/B9o8Mo90yP
	xw+eWz0KJ9L690imcPi5NG8WikoAAqi225PZhmhgPigw/e8kp6xtM4Ogo0KAaTlHzTyLmf
	X1t5mKgQrUgUih/DPv7+Oj6wUh41DF0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732492667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YkW20EHuGQCHEIUxf664Lc9iGqpzUYJO4su/DLzZxHw=;
	b=K6TzjISwl5ob5bew+cllZ7q8ElLu+nZn6cceqmczRpoogJY8ZwQJ3j7k9Sg/B9o8Mo90yP
	xw+eWz0KJ9L690imcPi5NG8WikoAAqi225PZhmhgPigw/e8kp6xtM4Ogo0KAaTlHzTyLmf
	X1t5mKgQrUgUih/DPv7+Oj6wUh41DF0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2000B132CF
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YMQIMnm9Q2emSQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/7] btrfs: sector size < page size enhancement
Date: Mon, 25 Nov 2024 10:27:20 +1030
Message-ID: <cover.1732492421.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
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
	NEURAL_HAM_SHORT(-0.20)[-0.985];
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
- Add the new fix for inline data read which can cause data corruption
  Thankfully this doesn't affect any one until the last patch enabling
  the partial uptodate folio support.

  But it is still required before we enabling partial uptodate folio, as
  a btrfs can be generated on x86_64 with inline data extents, then
  booted on an aarch64 system.

- Update the double accounting fix to cover errors from
  writepage_delalloc()
  WHich is the missing case which can still reproduce generic/750 crash.

This series contains several sector size < page size fixes and
optimization:

- Pass generic/563 with 4k sector size and 16K/64K page size
  The last patch.

  The test case is a special cgroup one, which requires the fs to avoid
  reading the whole folio as long as the buffered write range is btrfs
  sector aligned.

- Fix generic/750 failure with 4K sector size and 16K/64K page size
  It's a double ordered extent accounting for sector size < page size
  cases, covering two different error paths.
  The first patch.

The remaining are all preparations for the above goals.

Qu Wenruo (7):
  btrfs: fix double accounting of ordered extents during errors
  btrfs: fix inline data extent reads which zero out the remaining part
  btrfs: extract the inner loop of cow_file_range() to enhance the error
    handling
  btrfs: use FGP_STABLE to wait for folio writeback
  btrfs: make btrfs_do_readpage() to do block-by-block read
  btrfs: avoid deadlock when reading a partial uptodate folio
  btrfs: allow buffered write to skip full page if it's sector aligned

 fs/btrfs/defrag.c       |   6 +-
 fs/btrfs/direct-io.c    |   2 +-
 fs/btrfs/extent_io.c    |  98 +++++++----
 fs/btrfs/file.c         |  13 +-
 fs/btrfs/inode.c        | 362 +++++++++++++++++++++-------------------
 fs/btrfs/ordered-data.c |  67 +++++++-
 fs/btrfs/ordered-data.h |   8 +-
 7 files changed, 325 insertions(+), 231 deletions(-)

-- 
2.47.0


