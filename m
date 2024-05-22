Return-Path: <linux-btrfs+bounces-5217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6E68CC9D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 01:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8046B21ED6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 23:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181FF1494C8;
	Wed, 22 May 2024 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qUWPA+7v";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qUWPA+7v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED02E631
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421694; cv=none; b=dIlk4adbme6Qlgi77sUzhEfNGCEzymzJc3g5QIs8HK4AATH90OghkvF3f+d0oBZQOBgmUmMzD8N3jKdTdPQ0aIdH90/fJmLBhRtjAx8VhjnSfiMP7LJCH5iPrzOyaQ0JTheXjHO9IzQBJdJ7hD5ACbKQU8UZeQRoQtfbP8RAfow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421694; c=relaxed/simple;
	bh=D+5giIjcj16UTYHcud05m/iL/c+yA2qBogJODlmGDfA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jOYzsje2DaUnpqIh0ErqZxeSOyBfuYZLcfdsa2ghSIB/WaO+zGs/BLpwnSjmjFbDiKUOdGqzg5jhTmFb+c5d1ufl4G31ZxnWI4oGkO4/+RgJVQIbc9C9vc+BNwVMykNvWltD3T49aKqP7SYneu/ksCo705WaWAD085upC8l/eYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qUWPA+7v; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qUWPA+7v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BBA321A2F
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716421690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SPKIh2yV8VvhLbSyy2SQbAhG/8Mf4lX0OvFBT5msqMI=;
	b=qUWPA+7vrpdL/MeZKUMOL+C70Kp07ZV1NOowr1/Gk5B/U92Ki60Ha/58QeCbuGCQWPj4J4
	6dIk43hbVyRAjjxWUaG3Sr2SWxifpmr09obIh8FXMAfWx9AxJexEcV4eSmWPrxHsL4fMZ2
	e2PvLLbs5Ldmn2ejur74j6+eD9/WoRA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716421690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SPKIh2yV8VvhLbSyy2SQbAhG/8Mf4lX0OvFBT5msqMI=;
	b=qUWPA+7vrpdL/MeZKUMOL+C70Kp07ZV1NOowr1/Gk5B/U92Ki60Ha/58QeCbuGCQWPj4J4
	6dIk43hbVyRAjjxWUaG3Sr2SWxifpmr09obIh8FXMAfWx9AxJexEcV4eSmWPrxHsL4fMZ2
	e2PvLLbs5Ldmn2ejur74j6+eD9/WoRA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AFF813A1E
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BDgYBjmETmb6aQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: enhance function extent_range_clear_dirty_for_io()
Date: Thu, 23 May 2024 09:17:44 +0930
Message-ID: <cover.1716421534.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.74 / 50.00];
	BAYES_HAM(-1.94)[94.72%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.74
X-Spam-Flag: NO

[Changelog]
v2:
- Split the original patch into 3

- Return the error from filemap_get_folio() to be future-proof

- Enhance the comments for the new ASSERT() on
  extent_range_clear_dirty_for_io() error
  In fact, even if some pages are missing, we do not need to handle the
  error at compress_file_range(), as btrfs_compress_folios() and each
  compression routine would handle the missing folio correctly.

  Thus the new ASSERT() is only an early warning for developers.

This is a preparation for the (near) future support of sector perfect
subpage compression support. (the current one requires full page
alignment).

The function extent_range_clear_dirty_for_io() is just a simple start.

Qu Wenruo (3):
  btrfs: move extent_range_clear_dirty_for_io() into inode.c
  btrfs: make extent_range_clear_dirty_for_io() subpage compatible
  btrfs: remove the BUG_ON() inside extent_range_clear_dirty_for_io()

 fs/btrfs/extent_io.c | 15 ---------------
 fs/btrfs/extent_io.h |  1 -
 fs/btrfs/inode.c     | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 17 deletions(-)

-- 
2.45.1


