Return-Path: <linux-btrfs+bounces-15879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F80B1BFAF
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34232188A831
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 04:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671A1F1311;
	Wed,  6 Aug 2025 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lDaixEsS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lDaixEsS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D01EFFB7
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754455758; cv=none; b=m+uxsPTAO0fzVH4ae+fiGtXLiHHOhV0FqUFHSDh4JIIOo3B246HnwmNX81TECq53j5EwAF8yVEIL7Azqegp0LPAt+FyOBD8NDZ0kBevGPr/4ROKkF8okW9p+5dshFQMkppPBtt8g9u5Grbls/J2dT8BWpOr2vW91RM2OHk1O78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754455758; c=relaxed/simple;
	bh=bfolrE5xenxJHM11rT4WbL5qvmw+YANUuxUztYWjcZU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hYIbBA4K6/2i76u513jAkn1atsvT/YyZ7i9vhg8EYkOKh0+FZBvmBlBdN/qlHJwMNA1p7nFbKEQrm70kwRWi/91j3hTL2f119qHPIp/cN8pE1SeR4kMmab2duJETR/NsF72fh8HU5Tk8Ffv8huFMfEt31m4xjjuGM23pUIzXTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lDaixEsS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lDaixEsS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 889A1211F5
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qBtBghV/RUmjvikSBF/P6YaWjszPaysUPJ17vN7rl+c=;
	b=lDaixEsS1Ns1plYuhOg137Cwo3HO6lZ4KUQMHh0qeHlZ1bih0/VWTQvTbejBSjMOYmaW2U
	5uDmnMvizwDKNiOmZpfioFfywOdF8v4e2k8Iykn5g8kkxc3cgGmaHfuYwvofECRSY+8R/K
	gj1CKKT1P09ttNjLXZyv1kmoZOJIwWo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qBtBghV/RUmjvikSBF/P6YaWjszPaysUPJ17vN7rl+c=;
	b=lDaixEsS1Ns1plYuhOg137Cwo3HO6lZ4KUQMHh0qeHlZ1bih0/VWTQvTbejBSjMOYmaW2U
	5uDmnMvizwDKNiOmZpfioFfywOdF8v4e2k8Iykn5g8kkxc3cgGmaHfuYwvofECRSY+8R/K
	gj1CKKT1P09ttNjLXZyv1kmoZOJIwWo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1F3513AA8
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bkJxIMjekmjFRwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 06 Aug 2025 04:49:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/6] btrfs-progs: device_get_partition_size*() enhancement and cleanup
Date: Wed,  6 Aug 2025 14:18:49 +0930
Message-ID: <cover.1754455239.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[CHANGELOG]
v2:
- Include and update Zoltan's fix to device_get_partition_size_sysfs()
  The "/dev/block/<device>/size" attribute is always in sector unit
  (512Bytes), independent from the physical device's block size.

  So the fix is pretty straightforward, just do the left shift before
  returning.

  And update the commit message to properly reflect that.

- Use s64 as the return value of device_get_partition_size*()
  Kernel ensures the max sector number of a device is LLONG_MAX >> 9,
  so s64 is more than enough to cover the device size, and we are safe
  to use the minus part to pass errors.

- Extra error handling when device_get_partition_size*() failed
  Ouput an error message and exit.
  Most callers are already doing that correctly but some are not.

- Keep the sysfs method as the fallback way to grab device size
  Since the device_get_partition_size_sysfs() can be easily fixed, no
  need to use complex path search for sector size.

- Add a new cleanup to remove is_vol_small()

Zoltan recently sent a fix to solve the bug in
device_get_partition_size_sysfs(), which is causing problems for "btrfs
dev usage".

It turns out that, the bug is just the attribute
"/sys/block/<device>/size" is in sector unit (512B), not in bytes.

So fix the bug first by reporting the correct size in bytes.

Then remove several unused functions exposed during the error handling
cleanup.

Finally cleanup device_get_partition_size*() helpers to provide a proper
error handling, not just return 0 for errors, but proper minus erro
code, and extra overflow check.

Qu Wenruo (5):
  btrfs-progs: remove the unnecessary device_get_partition_size() call
  btrfs-progs: remove device_get_partition_size_fd()
  btrfs-progs: remove is_vol_small() helper
  btrfs-progs: add error handling for device_get_partition_size()
  btrfs-progs: add error handling for
    device_get_partition_size_fd_stat()

Zoltan Racz (1):
  btrfs-progs: fix the wrong size from device_get_partition_size_sysfs()

 check/main.c            |  8 ++++-
 check/mode-lowmem.c     |  9 ++++-
 cmds/filesystem-usage.c | 15 ++++++---
 cmds/replace.c          | 14 ++++++--
 common/device-utils.c   | 74 ++++++++++++++++++-----------------------
 common/device-utils.h   |  5 ++-
 kernel-shared/volumes.c | 11 ++++--
 kernel-shared/zoned.c   | 18 +++++++---
 mkfs/common.c           | 39 ++++------------------
 mkfs/common.h           |  1 -
 mkfs/main.c             | 14 +++++---
 11 files changed, 110 insertions(+), 98 deletions(-)

--
2.50.1


