Return-Path: <linux-btrfs+bounces-3208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2AF878D67
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 04:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97088280D6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 03:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB5AD4B;
	Tue, 12 Mar 2024 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hTQ4Mo3r";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hTQ4Mo3r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF09463
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710213113; cv=none; b=fMVKVjZ5y+94PvVqtWDmW/RfP0Aittfbdd+WoXl7W/MA4CtdNoviceknvuF3fW1A2dZBfgdTol9G7ngJk+7uDyltqjiL6JtFdME5Ws5qEmFq1Zs/ZwXphDTFkNuTKTUdR81OQiS+XlX4jW4lBhiBZXmiXr7r8C6tk0IKDX1cRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710213113; c=relaxed/simple;
	bh=ayDkqs17YlxoTgpANa2qcOo1qL8MDmpzdIqJRt5Xbi8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EhTfIqaqUmo/dJflYCSsCR+sJcrPxxqUfNZrVkj6zBaa4TBStYN3PfsWcfcKshh9amS2uJNxlTR9ZUyqPZPE7eoAkIWdPepPTqVZSGFGmXn9Jm1pXPS/fQ6uya8EJ2saq/W0/NPlPRci/LBwMG/7rbl4CNnL68oqFKHTpy9gNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hTQ4Mo3r; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hTQ4Mo3r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BAB35CF30
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710213109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nbt4bkL9PzlsMKr8IB5E7HaHI6BgGitHX0sJT+U6stQ=;
	b=hTQ4Mo3rBiLW6LKSqwfG2hUgj2XZUPfO5pYqKG84voWXfPJRq43u2rkLKKWsGaLs+yhlUr
	rsWiA0GJjMURsdhfa2lkY1z33uW0KFaGqCbZfZ4wmjJRhtY3qKz4HLadctU83v53UMCzTt
	Gw36ZUxMmEcz3G+xc0WJxslhxwtHVYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710213109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nbt4bkL9PzlsMKr8IB5E7HaHI6BgGitHX0sJT+U6stQ=;
	b=hTQ4Mo3rBiLW6LKSqwfG2hUgj2XZUPfO5pYqKG84voWXfPJRq43u2rkLKKWsGaLs+yhlUr
	rsWiA0GJjMURsdhfa2lkY1z33uW0KFaGqCbZfZ4wmjJRhtY3qKz4HLadctU83v53UMCzTt
	Gw36ZUxMmEcz3G+xc0WJxslhxwtHVYs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C49813695
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aSlBC/TH72WZSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:11:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: defrag: better handling for extents which can not be merged with adjacent ones
Date: Tue, 12 Mar 2024 13:41:28 +1030
Message-ID: <cover.1710212957.git.wqu@suse.com>
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
X-Spam-Score: 3.68
X-Spamd-Result: default: False [3.68 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[53.08%]
X-Spam-Flag: NO

[CHANGELOG]
v3:
- Use div_u64() for percentage usage_ratio calculation
  v1 uses "/ 65536" which compiler just optimized to right shift, and
  avoided u64 division.

v2:
- Remove the "lone" naming
  Now the two new members would be named "usage_ratio" and
  "wasted_bytes".
  
- Make "usage_ratio" to be in range [0, 100]
  This should be much easier to understand.

When a file extent which can not be merged with any adjacent ones (e.g.
created by truncating a large file extent) is involved, it would haven no
chance to be touched by defrag.

This would mean that, if we have some truncated extents with very low
utilization ratio, or defragging it can free up a lot of space, defrag
would not touch them no matter what.

This is not ideal for some situations, e.g.:

  # mkfs.btrfs -f $dev
  # mount $dev $mnt
  # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
  # sync
  # truncate -s 4k $mnt/foobar
  # btrfs filesystem defrag $mnt/foobar
  # sync

In above case, if defrag touches the 4k extent, it would free up the
whole 128M extent, which should be a good win.

This patchset would address the problem by introducing a special
entrance for such file extents.
Those file extents meeting either usage ratio or wasted bytes threshold
would be considered as a defrag target, allowing end uesrs to address
above situation.

This change requires progs support (or direct ioctl() calling), by
default they would be disabled.

And my personal recommendation for the ratio would be 5%, and 16MiB.


Qu Wenruo (2):
  btrfs: defrag: add under utilized extent to defrag target list
  btrfs: defrag: allow fine-tuning defrag behavior based on file extent
    usage

 fs/btrfs/defrag.c          | 46 +++++++++++++++++++++++++++++++++++---
 fs/btrfs/ioctl.c           |  6 +++++
 include/uapi/linux/btrfs.h | 40 ++++++++++++++++++++++++++++-----
 3 files changed, 84 insertions(+), 8 deletions(-)

-- 
2.44.0


