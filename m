Return-Path: <linux-btrfs+bounces-7843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC9F96CC1C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 03:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A3F289056
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 01:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C970BE5E;
	Thu,  5 Sep 2024 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vCcuuQNx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vCcuuQNx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49B8F40
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498833; cv=none; b=svdQqKvaOBLR12Zy3cc66/EW7+fRuvDKsG/D4GpRJ8NN8WAFX1XX9TTaClk8kUelPHgjvoyjz6JKihcFLFugXrKbT73jhZGPUwZjnACgVUJdrttw0xEbA1kPLIGAVYybjE9Jo6ECmsYgFUgpvqLhe9pIC+HOv3RB5Y0QqOu8GLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498833; c=relaxed/simple;
	bh=aQs7B5hDSc9VmdPP0zMfEaki6qhilYRRLTucV0Zv4SQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nT+Cr/UmWKi1yAAAsECNe8GfT4TW3239nWvGW8nZvCI7M6FKGBU2p1nJOsKfIQNgqK2/FPFEbQOpLU+4HGytRepeTqRCYXoqka8cbR0nsM88fvJCXdaoLjW/Wi31MABzKhpXsEldoA3V+DjdOm31108AtYVq6mSDjGLBR63MWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vCcuuQNx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vCcuuQNx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0265E1F7F1
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725498827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=up33wp/QV/MwqUlt7aynqDfX3dgJnr/vFyj1vnnx730=;
	b=vCcuuQNxZlMNYrSmmuJr1Nq9RY/XA4OBqIfE2Rcylh+vZBSITUAWIrUo12EwYSyIGLJfVP
	bjR5T7l8zG79IA45iFzeBAbMEF8DaEseraCjgDr5BOqQkZGkmGoaBpZ8E+Vak5FW6+4I5O
	m0s/GaOLfID4hDu8p/xSHgArWPCvPRE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725498827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=up33wp/QV/MwqUlt7aynqDfX3dgJnr/vFyj1vnnx730=;
	b=vCcuuQNxZlMNYrSmmuJr1Nq9RY/XA4OBqIfE2Rcylh+vZBSITUAWIrUo12EwYSyIGLJfVP
	bjR5T7l8zG79IA45iFzeBAbMEF8DaEseraCjgDr5BOqQkZGkmGoaBpZ8E+Vak5FW6+4I5O
	m0s/GaOLfID4hDu8p/xSHgArWPCvPRE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3556113508
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v/8nOskF2WbMKQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2024 01:13:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs-progs: convert: fix the invalid regular extents for symbol links
Date: Thu,  5 Sep 2024 10:43:20 +0930
Message-ID: <cover.1725498618.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
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
X-Spam-Score: -2.80
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Fix the words "symbol link" to "symbolic link"

- Split the inline extent size limits into two different ones
  One for symbolic links, as they are limited by PATH_MAX - 1.
  The other one for regular data inlined extents.
  They should be no larger than sectorsize - 1.

  Furthremore, both will also be limited by the node size.

Test case btrfs/012 fails randomly after the rework to use fsstress to
populate the fs.

It turns out that, if fsstress creates a symbol link whose target is
4095 bytes (at the max size limit), btrfs-convert will create a regular
extent instead of the expected inline one.

This regular extent for symbol link inodes will be rejected by kernel,
resulting test case failure.

The reason that btrfs-convert created such regular extent is,
btrfs-convert accidentally added one byte for the terminating NUL,
enlarge the should-be inlined file extent to be a regular one.

The first patch will fix the bug.
Then two patches to enahnce btrfs-check to detect the error (regular and
lowmem mode)
Eventually a dedicated test case for btrfs-convert, so in the future we
won't cause the problem again.

Qu Wenruo (4):
  btrfs-progs: convert: fix inline extent size for symbol link
  btrfs-progs: check/original: detect invalid file extent items for
    symbolic links
  btrfs-progs: check/lowmem: detect invalid file extents for symbolic
    links
  btrfs-progs: convert-tests: add a test case to verify large symbolic
    link handling

 check/main.c                                  |  7 +++
 check/mode-lowmem.c                           | 44 +++++++++++++++++++
 convert/source-ext2.c                         | 29 +++++++++---
 convert/source-reiserfs.c                     | 10 ++++-
 kernel-shared/file-item.c                     |  6 +++
 kernel-shared/file-item.h                     | 18 ++++++++
 .../027-large-symbol-link/test.sh             | 27 ++++++++++++
 7 files changed, 133 insertions(+), 8 deletions(-)
 create mode 100755 tests/convert-tests/027-large-symbol-link/test.sh

--
2.46.0


