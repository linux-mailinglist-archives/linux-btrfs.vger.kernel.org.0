Return-Path: <linux-btrfs+bounces-3799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA17892D9E
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Mar 2024 23:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D142A1C20E24
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Mar 2024 22:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74864D9E6;
	Sat, 30 Mar 2024 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E/rY0l7Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C92E3E8
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711837497; cv=none; b=SKqiLO51VabxTckP5NTzoLEWnP8TZADPrK1RGGPsTSk0i6iDQ1WTf48V4UFdEsAHjCWoqfOe813g7kU1bD9RR7XTwh5WBy4DaDm1OBYRSa10IO/zqppJojkhIxbdv8Vl9hdc5pWATBkGsfg4oa1x0VrpR881g24t/Oix6Fykvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711837497; c=relaxed/simple;
	bh=ciB0rI3Wpm/6lBxLtnt1GpE7qJv/2TQKLHDuN5SN+Ac=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UGrzRR4JSs4FOr+cUroylM4uPlIgp3mz/gKK7IgvB/cTX8TAHqjKcioMU+F3Ck5zjKiDgmeO4hHYvg8mbud/fYIVGz9GLJFmFfrfY1N72WjuUkYKVbDleVAMDR+1PeKpV4xYBJphg6lRWo5/hAP0a2h5EBYiNUFZIZW1tivBmJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E/rY0l7Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4ADD137344
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711837485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8MdfDC7EAyiYQn3ziTahbacv4Hp0ZgZG+4Zpi9gzp84=;
	b=E/rY0l7YE5KQz9038Ci/kX1Sip4M53Qx4ZPR4CwgCfsYXVjerw62faHXkuOCy+rUid/7iF
	Kp/pMMu3rmc7UIUPDBxSAVM79kv4NjbbFM0SuUj2u2RATN9IcFs7qfhDju0SnMuTOyUfGr
	ldiFu04ZtHSqFi4nSLHWzWjD23ZQOtE=
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8484813A7E
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id D1jqDyyRCGb7QQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: header cleanups
Date: Sun, 31 Mar 2024 08:54:24 +1030
Message-ID: <cover.1711837050.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO

[REPO]
https://github.com/adam900710/btrfs-progs/tree/headers_cleanup

This series is focusing on cleanup the unused headers.

This is mostly done by clangd, although it has some false alerts related
to macro usages of a header.

But still it's pretty awesome to cleanup a lot of unnecessary headers.
Only one special touch on pretty_size() macro, to change it to a static
inline function to workaround the clangd bug.

The first patch would do the main heavy lifting, meanwhile the second
patch is doing the BTRFS_FLAT_INCLUDES related cleanups for library-test
code.

Unfortunately I didn't touch anything inside crypto/*, the main reason
is I'm not confident enough to verify all the optimization for different
instructions.

(And even less motivation after the infamous recent XZ backdoor attempt,
 by a possibly state-sponsored sleeping agent, ruining the trust among
 open source community.)

Qu Wenruo (2):
  btrfs-progs: headers cleanup
  btrfs-progs: library-test: header and BTRFS_FLAT_INCLUDES cleanups

 btrfs-corrupt-block.c        |  1 -
 btrfs-sb-mod.c               |  2 --
 btrfs.c                      |  1 -
 cmds/device.c                |  1 -
 cmds/filesystem-du.c         |  1 -
 cmds/filesystem-usage.c      |  1 -
 cmds/inspect.c               |  3 ---
 cmds/quota.c                 |  1 -
 cmds/receive-dump.c          |  1 -
 cmds/receive.c               |  1 -
 cmds/reflink.c               |  2 --
 cmds/restore.c               |  1 -
 cmds/scrub.c                 |  3 ---
 common/device-scan.c         |  1 -
 common/open-utils.c          |  1 -
 common/path-utils.c          |  1 -
 common/send-stream.c         |  1 -
 common/send-utils.c          |  1 -
 common/string-utils.c        |  2 --
 common/units.h               |  7 ++++++-
 common/utils.c               |  1 -
 convert/main.c               |  1 -
 convert/source-ext2.c        |  1 -
 kernel-lib/mktables.c        |  5 +----
 kernel-shared/dir-item.c     |  1 -
 kernel-shared/extent-tree.c  |  1 -
 kernel-shared/file-item.c    |  1 -
 kernel-shared/file.c         |  2 --
 kernel-shared/inode-item.c   |  2 --
 kernel-shared/messages.c     |  1 -
 kernel-shared/root-tree.c    |  1 -
 kernel-shared/tree-checker.c |  1 -
 kernel-shared/uuid-tree.c    |  3 ---
 kernel-shared/zoned.c        |  1 -
 libbtrfs/crc32c.c            |  5 ++---
 mkfs/common.c                |  1 -
 mkfs/rootdir.c               |  1 -
 tests/fsstress.c             | 25 ++++++++++++-------------
 tests/ioctl-test.c           |  1 -
 tests/library-test.c         | 22 +++-------------------
 40 files changed, 24 insertions(+), 86 deletions(-)

--
2.44.0


