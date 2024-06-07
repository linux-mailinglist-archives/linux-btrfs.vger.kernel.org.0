Return-Path: <linux-btrfs+bounces-5558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7126D900884
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 17:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF603B2143E
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7790C1957E3;
	Fri,  7 Jun 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F1MyOKgi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="odq7ZnV7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958D54660;
	Fri,  7 Jun 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773491; cv=none; b=aDxPHsI50nXz5ilenZ875D3ort2DIkwwCTTmE7YIOZ8UhA4X3KyMMy6u6wY+F6AOxSZOgLcAk0PQ5cxFAV/7bd6keZoG2remwrEZcbKUHUfCRsl5yOsZdIQ9RcjUCwuV3FvG/uOkCjqcYCePH73rL8W3d0oSfYbfPx5NRJWZTZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773491; c=relaxed/simple;
	bh=46eiL3n7740sy9h8YQoi5Nr9j6AlZg3ptAj7G+nRV4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y7oRqfxOgpXsF2sKGoAmAJ6ny4VFNBnQfj2riP9I/vWysJtE7YZ+ylhe8BUXiH5PFtV9D5PL9eKJCBoKtG3H/TgNDUjFQUIgSaeP4GndkUdJSLFG0TEz5zBia5oRuCy3fGbQL12GafZnXnF7wbnad2tFzI6ZItWiWRDTdm3+IE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F1MyOKgi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=odq7ZnV7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EFF1821B6B;
	Fri,  7 Jun 2024 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717773487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kwjqxJMZL83q8d52d/Qaewk3aeVcuPuXb72BXcqc4Ww=;
	b=F1MyOKgiUYhsORqpvUkkI/L+oBHM4sMLqhMsjMB0OQr3Kl5bGqTXvPQTWG0IQxA8HHujzU
	j53eZn361+BWmRzLtOFojXwYB68hZJr3Mws29pYpf+CnX59a3+DKA0KVLmaXkz6DJBu4Od
	vUSkTtCAis8OQotOgrr1FGVgfsw10ZA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717773486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kwjqxJMZL83q8d52d/Qaewk3aeVcuPuXb72BXcqc4Ww=;
	b=odq7ZnV7Cl/DOhQdNjPG3oZBNrns2QgLwgG6lyUSyfP72pXAifO+2gUb51eUCtFd2448QG
	qAla5wm9vxbIiKTQShR0YWUCqUBU99sOahz3S/V91wnQqteRE3lc7J2qUaLimOGU6n9X5k
	+nTguBTDRs9ymLQtqKcuya/OQ2eb5AA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8D9F134C7;
	Fri,  7 Jun 2024 15:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nFjXOK4kY2bsGgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 07 Jun 2024 15:18:06 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.10-rc3, part 2
Date: Fri,  7 Jun 2024 17:18:02 +0200
Message-ID: <cover.1717771196.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Hi,

a few more fixes, two are for serious problems which are hard to hit,
details in the changelogs. Please pull, thanks.

- fix handling of folio private changes, the private value holds pointer
  to our extent buffer structure representing a metadata range, release
  and create of the range was not properly synchronized when updating
  the private bit which ended up in double folio_put, leading to all
  sorts of breakage

- fix a crash, reported as duplicate key in metadata, but caused by a
  race of fsync and size extending write, requires prealloc target
  range + fsync and other conditions (log tree state, timing)

- fix leak of qgroup extent records after transaction abort

----------------------------------------------------------------
The following changes since commit f13e01b89daf42330a4a722f451e48c3e2edfc8d:

  btrfs: ensure fast fsync waits for ordered extents after a write failure (2024-05-28 16:35:12 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc2-tag

for you to fetch changes up to f3a5367c679d31473d3fbb391675055b4792c309:

  btrfs: protect folio::private when attaching extent buffer folios (2024-06-06 21:42:22 +0200)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: fix leak of qgroup extent records after transaction abort

Omar Sandoval (1):
      btrfs: fix crash on racing fsync and size-extending write into prealloc

Qu Wenruo (1):
      btrfs: protect folio::private when attaching extent buffer folios

 fs/btrfs/disk-io.c   | 10 +--------
 fs/btrfs/extent_io.c | 60 +++++++++++++++++++++++++++-------------------------
 fs/btrfs/tree-log.c  | 17 +++++++++------
 3 files changed, 43 insertions(+), 44 deletions(-)

