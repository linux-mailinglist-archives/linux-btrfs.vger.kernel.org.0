Return-Path: <linux-btrfs+bounces-3578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFC588B5F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 01:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE002C723C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 00:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D465217F0;
	Tue, 26 Mar 2024 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ro5xNXWV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ro5xNXWV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9ED179
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412595; cv=none; b=lggvEbkLWpFfTUyF8GT0yp740jjEo2xfK9ZCfL/3rQnhedodIThybf2pJoih43EmEeQihcBADCMv0TLkWSMjWWB5GQazu7CDOcKkJmEEg+YRS7aXw91ubZxB5EBE7P8fo1tki9sv46n9YxaTfDSzy16NSa1FF23hWZPHFd4zvSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412595; c=relaxed/simple;
	bh=0mRiCO4xUiRyCuIMWQI9H7kCRWvpucbJuON2SDDmdgc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j1nzaMrwvB3pFPl3tKOz2W5TIbctl61QVElyKfJ7KPBIpe1A8npPjBeXtnvzAHft3epbNzvy75FsOEIOP8U5a5QLvaFqmelxxJotJZv9CSJRWBPMKC0CPrDyHlWkOea+pXl4pceGMmwe+PUaGi0M4IZem751jwvXFV1BX5GYqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ro5xNXWV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ro5xNXWV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22F885CE25
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rDSitrzkKVelOUnhkCNNlmHsuit+FXDGoig230RMN1w=;
	b=ro5xNXWVeMVpvqTCpDJFr/2Bc0C8zbZk6fjaggpQ9drjj9mHeIfJ3erICC7kaFWb970Qss
	8M7dVOowiB3hXNPizL40y3fDthyn4MTzOJIJG+ftU8rgTwFNVbAmkyfN5kfUjGgRlWym2h
	FZtm3fDV61GUocM9EUTzBl0UIBeJGHI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rDSitrzkKVelOUnhkCNNlmHsuit+FXDGoig230RMN1w=;
	b=ro5xNXWVeMVpvqTCpDJFr/2Bc0C8zbZk6fjaggpQ9drjj9mHeIfJ3erICC7kaFWb970Qss
	8M7dVOowiB3hXNPizL40y3fDthyn4MTzOJIJG+ftU8rgTwFNVbAmkyfN5kfUjGgRlWym2h
	FZtm3fDV61GUocM9EUTzBl0UIBeJGHI=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C95013586
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4nstOGwVAmbOJAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs-progs: zoned devices support for bgt feature
Date: Tue, 26 Mar 2024 10:52:40 +1030
Message-ID: <cover.1711412540.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.41
X-Spamd-Result: default: False [3.41 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.19)[-0.967];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.30)[74.90%]
X-Spam-Flag: NO

[REPO]
https://github.com/adam900710/btrfs-progs/tree/zoned_bgt

There is a bug report that, the following tool would fail on zone
devices:

- mkfs.btrfs -O block-group-tree
- btrfstune --convert-to-block-group-tree|--convert-from-block-group-tree

The mkfs failure is caused by zoned incompatible pwrite() calls for
block group tree metadata.

The btrfstune failure is caused by the incorrectly opened fd.


Before fixing both bugs, do two small cleanups, one caught by clangd LSP
server, the other caught by my later check on the test case output (a
missing newline).

Then fixes for each bug, and new test cases for each bug.

Qu Wenruo (6):
  btrfs-progs: remove unused header for tune/main.c
  btrfs-progs: tune: add the missing newline for
    --convert-from-block-group-tree
  btrfs-progs: mkfs: use proper zoned compatible write for bgt feature
  btrfs-progs: tune: properly open zoned devices for RW
  btrfs-progs: tests-mkfs: add test case for zoned block group tree
    feature
  btrfs-progs: tests-misc: add a test case to check zoned bgt conversion

 mkfs/common.c                                 |  4 +-
 .../063-btrfstune-zoned-bgt/test.sh           | 55 +++++++++++++++++++
 tests/mkfs-tests/031-zoned-bgt/test.sh        | 40 ++++++++++++++
 tune/convert-bgt.c                            |  2 +-
 tune/main.c                                   |  7 ++-
 5 files changed, 103 insertions(+), 5 deletions(-)
 create mode 100755 tests/misc-tests/063-btrfstune-zoned-bgt/test.sh
 create mode 100755 tests/mkfs-tests/031-zoned-bgt/test.sh

--
2.44.0


