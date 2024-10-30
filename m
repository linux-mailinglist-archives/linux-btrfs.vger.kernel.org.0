Return-Path: <linux-btrfs+bounces-9235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC369B5BC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 07:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBA0283D5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 06:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415A81D1F77;
	Wed, 30 Oct 2024 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pJPe4jTr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pJPe4jTr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34DE63CB
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270080; cv=none; b=FbxThpZ0eA6qaiLKOA6/DJkwc86BJPQgzi+idiud+//7ndPTwU5Kx8/qU8GEm6WSTjC9zn/JwRB7TO4CB3/g2R3n1LiVM5thGZvO7w5QcYoB/GIVQ90hRD602C7KTD/1vfb/7TGbP8rki06HtbpiXXL2iWpO/CkPBclxY8FbEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270080; c=relaxed/simple;
	bh=riwxwpwVidbVWZO8HjaCu1cu4Gw2MSCjEvBvrPq6Uoc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=r6XI9rfhe9uwhKa+MySR8pATmGASpNUNBgoshyd6dLBwcsDxiD+9K72JNO3VN5YyrmTmqRa5OzL8laaKinGWaD2ZYT8zAR90h9cObwkdy9yv3BFGLQmI+u2LNv7dFHCLMoupsfHQWK5jkGybnfB0bCS0n8YkPbQU81TWms1ayLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pJPe4jTr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pJPe4jTr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A04631FDCA
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 06:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730270075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8rSG+JTWleC0JYjqNdHs0CKXyRzOTuPdnA5FPxX4q30=;
	b=pJPe4jTrvWlENP4kEjTp9h7zyBqVtWmMpE9J5AzW4H0Gzq5nhjnCi44C5FakNPsU+rVa9g
	GQgjH3bONJlvyOZtsWGO5mrw+uTR7aY3vTrftdTkCc685oQ1xgZPkdSH0yZ3C5LGVZuXIZ
	YnYgLjtqtxr7keuN1zfOfp3Pc/IGJBI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pJPe4jTr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730270075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8rSG+JTWleC0JYjqNdHs0CKXyRzOTuPdnA5FPxX4q30=;
	b=pJPe4jTrvWlENP4kEjTp9h7zyBqVtWmMpE9J5AzW4H0Gzq5nhjnCi44C5FakNPsU+rVa9g
	GQgjH3bONJlvyOZtsWGO5mrw+uTR7aY3vTrftdTkCc685oQ1xgZPkdSH0yZ3C5LGVZuXIZ
	YnYgLjtqtxr7keuN1zfOfp3Pc/IGJBI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA138136A5
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 06:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LtJUJnrTIWcFcwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 06:34:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: sector size < page size enhancement
Date: Wed, 30 Oct 2024 17:03:56 +1030
Message-ID: <cover.1730269807.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A04631FDCA
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This series contains several sector size < page size fixes and
optimization:

- Pass generic/563 with 4k sector size and 16K/64K page size
  The last patch.

  The test case is a special cgroup one, which requires the fs to avoid
  reading the whole folio as long as the buffered write range is btrfs
  sector aligned.

- Fix generic/750 failure with 4K sector size and 16K/64K page size
  It's a double ordered extent accounting for sector size < page size
  cases.
  The first patch.

The remaining are all preparations for the above goals.

It's now rebased to the latest misc-next branch.

Qu Wenruo (6):
  btrfs: fix double accounting of ordered extents during errors
  btrfs: extract the inner loop of cow_file_range() to enhance the error
    handling
  btrfs: use FGP_STABLE to wait for folio writeback
  btrfs: make btrfs_do_readpage() to do block-by-block read
  btrfs: avoid deadlock when reading a partial uptodate folio
  btrfs: allow buffered write to skip full page if it's sector aligned

 fs/btrfs/defrag.c       |   6 +-
 fs/btrfs/direct-io.c    |   2 +-
 fs/btrfs/extent_io.c    |  85 ++++++----
 fs/btrfs/file.c         |  13 +-
 fs/btrfs/inode.c        | 347 ++++++++++++++++++++--------------------
 fs/btrfs/ordered-data.c |  67 +++++++-
 fs/btrfs/ordered-data.h |   8 +-
 7 files changed, 306 insertions(+), 222 deletions(-)

-- 
2.47.0


