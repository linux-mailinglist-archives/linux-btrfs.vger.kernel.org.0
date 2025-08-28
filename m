Return-Path: <linux-btrfs+bounces-16472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA22B3927C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 06:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3391D98173C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 04:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E51C84DE;
	Thu, 28 Aug 2025 04:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JTT106GE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JTT106GE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B47258A
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756354612; cv=none; b=PZheeiHREdodbEBeCKaoTR0WUmZK0tDsyZzsLHCvZo5pSD8YumqkZkyjxZUKcFjY6S7cZH2ITriNUGN+4NoGprdqeSGa9cNm8ssQshJatNgdUmp4evbcmsOLDbi/RU9GrG6sBUpyok67nEfl5A6mDsf7vdNS6eKS6N3jMfGM/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756354612; c=relaxed/simple;
	bh=vmBicXCd+FgjyN+OMViD74cHYlHybvlNGAMHbyQyW3s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HhFyH5tKiF22RZ/BaAMzICAqcuzxXn5qeisu49yn5Y+bfUpKKiPsSPSnnMPE8pgW8VgKJVB39+aegiUZ44KHiYBOpl6XKIpNXU9q+6rTvryDJ4uh+S09pZAv55P5Wih6y41gjAshNzINxN3KH0dNDGnIj+NwLIoA78X9JVERq+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JTT106GE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JTT106GE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 079B920934
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756354608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Bq8c1Z31w8I2txaiu37TKbqgrr9yNTE1MAKqEUT+4mg=;
	b=JTT106GEiOCvPO7zc745wlKnMWMtul6NSPf3XDztsUbT0d7J1joTMhDoDtuGnRyM3CS0ul
	brjfQ4LmJvs85P9dKr9FkGwhMmmdlO5Lv+7X3c3pZIPlmMRxf4eklAqedfAMhdl5IHXSDV
	nLVzlQ4GtP2R0d50+d7OmYPkOMnWlAU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756354608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Bq8c1Z31w8I2txaiu37TKbqgrr9yNTE1MAKqEUT+4mg=;
	b=JTT106GEiOCvPO7zc745wlKnMWMtul6NSPf3XDztsUbT0d7J1joTMhDoDtuGnRyM3CS0ul
	brjfQ4LmJvs85P9dKr9FkGwhMmmdlO5Lv+7X3c3pZIPlmMRxf4eklAqedfAMhdl5IHXSDV
	nLVzlQ4GtP2R0d50+d7OmYPkOMnWlAU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F38613680
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rshlAC/Yr2hhYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: enhance primary super block writeback errors
Date: Thu, 28 Aug 2025 13:46:21 +0930
Message-ID: <cover.1756353444.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Mark recently exposed a bug that btrfs can add zero sized devices into
an fs.

Inspired by his fix, I also exposed a situation which is pretty
concerning:

 # lsblk  /dev/loop0
 NAME  MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
 loop0   7:0    0  64K  0 loop
 # mount /dev/test/scratch1  /mnt/btrfs/
 # btrfs device add -f /dev/loop0 /mnt/btrfs/
 Performing full device TRIM /dev/loop0 (64.00KiB) ...
 # umount /mnt/btrfs
 # mount /dev/test/scratch1 /mnt/btrfs
 mount: /mnt/btrfs: fsconfig() failed: No such file or directory.
       dmesg(1) may have more information after failed mount system call.
 # dmesg -t | tail -n4
 BTRFS info (device dm-3): using crc32c (crc32c-lib) checksum algorithm
 BTRFS error (device dm-3): devid 2 uuid e449b62e-faca-4cbd-b8cb-bcfb5c549f0b is missing
 BTRFS error (device dm-3): failed to read chunk tree: -2
 BTRFS error (device dm-3): open_ctree failed: -2

That device is too small to even have the primary super block, thus
btrfs just skips it, resulting the fs unable to find the new device in
the next mount.
(Thankfully this can be fixed by mounting degraded and remove the tiny
device)

This exposed several problems related to the super block writeback
behavior:

- We should always try to writeback the primary super block
  If the device is too small, it shouldn't be added in the first place.

  And even if such device is added, we should hit an critical error
  during the first transaction on that device.

- Primary super block write failure is ignored in write_dev_supers()
  Unlike wait_dev_supers(), if we failed to submit the primary sb, but
  succeeded submitting the backup ones, we still call it a aday.

- We treat super block writeback errors too loosely
  Btrfs will not error out even if there is only one device finished the
  super block.

Enhance the error handling by:

- Treat primary sb writeback error more seriously
  In fact we don't care that much about backups, and wait_dev_supers()
  is already doing that.

  So we don't need an atomic_t to track all sb writeback errors, but
  only a single flag for the primary sb.

- Treat newly added device more seriously
  If the super block write into the newly added device failed, it will
  prevent the fs to be mounted, as btrfs can not find the device.

  So here we introduce a concept, critical device, that if sb writeback
  failed for those devices, the transaction should be aborted.

- Treat sb writeback error as if the device is missing
  And if the fs can not handle the missing device and maintain RW, we
  should flip RO.

- Revert failed new device if btrfs_init_new_device() failed
  This can be a problem of the new device itself.
  We should remove the new device if the btrfs_commit_transaction() call
  failed.


All those enhancements lead to a pretty interesting error handling
situation, where a too small device can be added to btrfs, but it will
not commit, and the original fs can still be remounted again correctly:

 # lsblk  /dev/loop0
 NAME  MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
 loop0   7:0    0  64K  0 loop
 # mount /dev/test/scratch1  /mnt/btrfs/
 # btrfs device add -f /dev/loop0 /mnt/btrfs/
 Performing full device TRIM /dev/loop0 (64.00KiB) ...
 ERROR: error adding device '/dev/loop0': Input/output error
 # umount /mnt/btrfs
 # mount /dev/test/scratch1 /mnt/btrfs
 ^^^ This will succeed, as the new device is not committed

Qu Wenruo (4):
  btrfs: enhance primary super block write error detection
  btrfs: return error if the primary super block write to a new device
    failed
  btrfs: treat super block write back error more seriously
  btrfs: add extra error handling for btrfs_init_new_device()

 fs/btrfs/disk-io.c | 93 ++++++++++++++++++++++++++++++++++------------
 fs/btrfs/volumes.c |  9 +++--
 fs/btrfs/volumes.h |  8 +---
 3 files changed, 78 insertions(+), 32 deletions(-)

-- 
2.50.1


