Return-Path: <linux-btrfs+bounces-3211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A941878D76
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 04:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0861F22123
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 03:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2910BBE4B;
	Tue, 12 Mar 2024 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hqoLHkW6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hqoLHkW6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A196BA39
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710213875; cv=none; b=hZzN2zjrd/bjVPWooY13ItzsBQaZNp5QxAiBhdk3sxIjk3utFBhQY1Bq2Hmfbbd+C3fiXw/4WJ+3lGDEBZL1U9+nno+q0PVi73z2WsZ18cGrbxWAmaa8IhJY95PODqZ9JYtxTYWMnBDrpz8pyrDDZSAMf2Fs8TQE6UruAIK3NUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710213875; c=relaxed/simple;
	bh=FjbMyyxllXd8tS3agk//bGHAhCDqyCr21PiT0aIZ+0U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SyBLupGY7PeSdX6oHtitsIAvyMwa5Jry7f+O+wjkv8Fa4fAsMRB/zKF2Gggm2WO5hqgITyAxMvyXpqJdE53l1LzkYiDOHQIy6lUx67k+PFOTJmuFlnS+YxtpjMM73T7CPZZ12uFiuM8+3DJ3Xk4xzKaq/cll5cVegQUPScN1gqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hqoLHkW6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hqoLHkW6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 432D15CF52
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710213870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=alypUco4gQTjyTiHtHpQ4tgAFSRpfXw2Y5hyig7cuC4=;
	b=hqoLHkW6kjGDx0+F/ITXgy6bq60ODs9zWaG86l0bh0ArNR8wEiq4nAQZ98EiH/EgZzt7+P
	NHXm8JApYCJy7W9QfZTGpLVhAab2dvnU3f9QW6As/W6cIyBhChX5P90Bvf22QBFO+67SbO
	S2PwiKRB9ZTiJ2U9qXiZtlHOc9ov+2A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710213870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=alypUco4gQTjyTiHtHpQ4tgAFSRpfXw2Y5hyig7cuC4=;
	b=hqoLHkW6kjGDx0+F/ITXgy6bq60ODs9zWaG86l0bh0ArNR8wEiq4nAQZ98EiH/EgZzt7+P
	NHXm8JApYCJy7W9QfZTGpLVhAab2dvnU3f9QW6As/W6cIyBhChX5P90Bvf22QBFO+67SbO
	S2PwiKRB9ZTiJ2U9qXiZtlHOc9ov+2A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6366A13695
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cIeqCe3K72XKTQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:24:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/2] btrfs: defrag: better handling for extents which can not be merged with adjacent ones
Date: Tue, 12 Mar 2024 13:54:09 +1030
Message-ID: <cover.1710213625.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hqoLHkW6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[43.67%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 432D15CF52
X-Spam-Flag: NO

[CHANGELOG]
v4:
- Remove the "*_LONE_*" mentioning in uapi

- Add extra initialization for the two new members
  This is to avoid fuzz tests to set those two new members without
  setting the coresponding flags.

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
 fs/btrfs/ioctl.c           | 13 +++++++++++
 include/uapi/linux/btrfs.h | 40 ++++++++++++++++++++++++++++-----
 3 files changed, 91 insertions(+), 8 deletions(-)

-- 
2.44.0


