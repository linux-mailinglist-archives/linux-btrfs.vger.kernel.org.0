Return-Path: <linux-btrfs+bounces-3020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D146872723
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 19:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8872824E5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997F1C29B;
	Tue,  5 Mar 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Sn7myDpq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Sn7myDpq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A31426F;
	Tue,  5 Mar 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665152; cv=none; b=IL8CARoXCi5plKG5mhmAbKyKbl6bWffSB+CoE7bpmgD/Jc0m+8Mhdsq7zWSWV3U7yjkXDZaUTnc+h1+YZUv5xzGJ/eQmuTiO8vTJUdfRijD3mkQXV/VVHfsh1WA8QiGnyZzhxBvV2tCjQlqejT0BR+bMviCrELM3dki7Z5E0/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665152; c=relaxed/simple;
	bh=RBROlcULh9KPgSbGUT6BfF0xPYIu5+Qaoa+2K0hXShw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3N1tm8TNe1iJch5q6CkjBsJvF/xAxON1zTJDb2hE+5ZUl6D0mn1ZmG3qAOICre5QMk95yTXoPLvfC5qpA4fDPFNzEH7gXLZNTCfixFyBJmo+17K4YHhzkp6uL7KRBUj0R/2XGTJoWCwUxSQywiVGdO2eTVrkOaQAlqQahqia5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Sn7myDpq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Sn7myDpq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 775492101B;
	Tue,  5 Mar 2024 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=S7WdJeVOdyYjn8GSihBCWHVA0AxMNBhucvcnKpoFjpg=;
	b=Sn7myDpqBQ+tkl5tkqXs+VB/aJVvvLEhCtVWkjnjMx3MQS1lZth4VFZyRwz4VcgD2pVRv8
	e0utOUoMiM0uxSsy1X0c0rKpKgJ4KuKNYB5bPrGe8FT36XT/hOsUC2/anKdQfgGb7y/750
	mpDwzzKPR1kRlr/FH9hQd9eOddlezc8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=S7WdJeVOdyYjn8GSihBCWHVA0AxMNBhucvcnKpoFjpg=;
	b=Sn7myDpqBQ+tkl5tkqXs+VB/aJVvvLEhCtVWkjnjMx3MQS1lZth4VFZyRwz4VcgD2pVRv8
	e0utOUoMiM0uxSsy1X0c0rKpKgJ4KuKNYB5bPrGe8FT36XT/hOsUC2/anKdQfgGb7y/750
	mpDwzzKPR1kRlr/FH9hQd9eOddlezc8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E83913466;
	Tue,  5 Mar 2024 18:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8ByzGnpr52UuBQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 05 Mar 2024 18:59:06 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/8] Btrfs fstests fixups
Date: Tue,  5 Mar 2024 19:51:57 +0100
Message-ID: <cover.1709664047.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.46 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.44)[78.77%]
X-Spam-Level: ****
X-Spam-Score: 4.46
X-Spam-Flag: NO

Hi,

I'm sending first batch of fixups on behalf of Josef.  I think most of
them have been sent to fstests@ at some point.  They have been in our CI
branch and consider them tested and working for our needs. All of them
are btrfs-specific and will not affect other filesystems.  (The change
in common/rc only moves a helper.) The last patch is a new test split
from another one.

Josef Bacik (8):
  btrfs/011: increase the runtime for replace cancel
  btrfs/012: adjust how we populate the fs to convert
  btrfs/131: don't run with subpage blocksizes
  btrfs/213: make the test more reliable
  btrfs/271: adjust failure condition
  btrfs/287,btrfs/293: filter all btrfs subvolume delete calls
  btrfs/291: remove image file after teardown
  btrfs/400: test normal qgroup operations in a compress friendly way

 check               |   6 ---
 common/rc           |   5 +++
 tests/btrfs/011     |   9 +++-
 tests/btrfs/012     |  14 +++---
 tests/btrfs/022     |  86 ++---------------------------------
 tests/btrfs/131     |   4 ++
 tests/btrfs/213     |  20 ++++-----
 tests/btrfs/271     |  11 ++---
 tests/btrfs/287     |   4 +-
 tests/btrfs/287.out |   2 +-
 tests/btrfs/291     |   2 +-
 tests/btrfs/293     |   6 +--
 tests/btrfs/293.out |   4 +-
 tests/btrfs/400     | 107 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/400.out |   2 +
 15 files changed, 161 insertions(+), 121 deletions(-)
 create mode 100755 tests/btrfs/400
 create mode 100644 tests/btrfs/400.out

-- 
2.42.1


