Return-Path: <linux-btrfs+bounces-5689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3498C905FAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 02:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3121F227D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 00:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE12D63A5;
	Thu, 13 Jun 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z39kWuOV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z39kWuOV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832E4C69
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238233; cv=none; b=fF+UzJPEE4zT7O39PC5PjyzUH7AevvCKrTdpM31vz79thKVpZb+KsZJf5x325CN2tJPSkLErlcrx5UWpZGL+ov7LKqh+FXt9Xjm5CJGKuUl7xRya0YZKtbAzH5hGIfI3EvoJ+U1u1tHBuYxJWsmckdCBzhx9Ooyssa75rq+7w4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238233; c=relaxed/simple;
	bh=yN7wXSXE5AHaQKKmHYiiiNvdSMEVq+DC2PsS2T7U2sQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u1qhd5X+6vNAP0wDF70PlQFLm0mQrU6xppce7eD84maN06lU84oAeC1/X3MUvEyC3qW89F2BXDk3ZYFpqsPYnshhN6aWsurh7lUcbIErTjgOX03wf3wTkox3UGaEng2mRIT26bSg8gx0PLwRghvIvOT8YcntaltfvGwrfZs0YZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z39kWuOV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z39kWuOV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B0CC34B83
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718238229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pmeIsZPpcVtKsIOZtEVtl7AllFSiTzc4F3pxuSegJ+0=;
	b=Z39kWuOVGHfIQ6ybxF1K89z8fC/IbVzJOloxEcQZojgBs1oxIl+/ySn2hU6jISntRi5tB4
	ve3UCjnyDVkZ6QFQ8agxVzP9kKsXIdQKKhPA8ClRxupmOOp523L1kR3GPu1wCZwuXXqfIP
	kxHQ51VKdH185PZNEzaLp2mhfWkCJ3U=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718238229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pmeIsZPpcVtKsIOZtEVtl7AllFSiTzc4F3pxuSegJ+0=;
	b=Z39kWuOVGHfIQ6ybxF1K89z8fC/IbVzJOloxEcQZojgBs1oxIl+/ySn2hU6jISntRi5tB4
	ve3UCjnyDVkZ6QFQ8agxVzP9kKsXIdQKKhPA8ClRxupmOOp523L1kR3GPu1wCZwuXXqfIP
	kxHQ51VKdH185PZNEzaLp2mhfWkCJ3U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08CDE13A7F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +0qyKxM8amY9YQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: move RST feature back to experimental
Date: Thu, 13 Jun 2024 09:53:21 +0930
Message-ID: <cover.1718238120.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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

Although we have exported raid-stripe-tree feature to end users,
the feature is still experimental as only kernels with
CONFIG_BTRFS_DEBUG can even mount it.

This results a feature mismatch in btrfs-progs and kernels, and can lead
to complains/confusion from end users.

This patchset would hide RST feature back behind experimental builds for
mkfs, and completely disable rst for convert, so end users won't and
can't enable RST by accident.

Now RST related test cases (mkfs/029, mkfs/030) are skipped for
regular builds, and a new test case (mkfs/033) is skipped for
experimental builds to make sure there is really no way to enable RST
support for non-experimental builds.

The new experimental build detection also provides the basis for
other experimental features like csum conversion in the future (recent
days).

Both regular and experimental builds have passed the full test suite
(except random misc/055 failure, which is caused by a clear-stale
behavior change, and will be addressed separately)

Qu Wenruo (4):
  btrfs-progs: convert: remove raid-stripe-tree support
  btrfs-progs: hide rst related mkfs tests behind experimental builds
  btrfs-progs: fsfeatures: move RST back to experimental
  btrfs-progs: mkfs-tests: ensure regular builds won't enable rst
    feature

 common/fsfeatures.c                           |  2 ++
 common/fsfeatures.h                           |  3 +-
 mkfs/main.c                                   |  2 ++
 tests/common                                  | 29 ++++++++++++++++
 tests/convert-tests/001-ext2-basic/test.sh    |  2 +-
 tests/convert-tests/003-ext4-basic/test.sh    |  2 +-
 .../005-delete-all-rollback/test.sh           |  2 +-
 .../convert-tests/010-reiserfs-basic/test.sh  |  2 +-
 .../011-reiserfs-delete-all-rollback/test.sh  |  2 +-
 tests/convert-tests/024-ntfs-basic/test.sh    |  2 +-
 tests/mkfs-tests/029-raid-stripe-tree/test.sh |  1 +
 tests/mkfs-tests/030-zoned-rst/test.sh        |  1 +
 tests/mkfs-tests/033-zoned-reject-rst/test.sh | 34 +++++++++++++++++++
 13 files changed, 76 insertions(+), 8 deletions(-)
 create mode 100755 tests/mkfs-tests/033-zoned-reject-rst/test.sh

--
2.45.2


