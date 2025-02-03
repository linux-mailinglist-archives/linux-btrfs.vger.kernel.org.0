Return-Path: <linux-btrfs+bounces-11216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5FA2518D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 04:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2871883CDE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 03:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3C2AD0F;
	Mon,  3 Feb 2025 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KmUVXJqU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KmUVXJqU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5312C13B
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738552111; cv=none; b=cf904lwOpf/yjSnGRYH9ANHKbrHtyfgbAyxHdQz14PHLXuSqAf8kEGV9yQmR2Stzu2DJQ8Sk3K3fSTIsBsBycJfWFvszdge+gvAUldFeYE1LuP8FOZQUonIolqAZcw76kldoDTjtv7iLr73LcYiPipwWVxNS++J/Eiujs19h7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738552111; c=relaxed/simple;
	bh=OxhL8Pfi6yJOqVC2Mr8x4CmrR99RokLIffGyVdR+SQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjsfJPUXvgwzvT+rMgK1qVksWhZtu9fqDvoEC0b+CT5kGgl0Y5LA8O6Ku47xu4cq6F1vVCTeG3OBTeS6hdimAZYfP7mrD9jxTH4xbD36N5iCUdCvaFOZ/DZTrXZBedj/BnSXz+zYRkQPnW6NaFnVistxPTBP7ciWPXY87AaeHxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KmUVXJqU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KmUVXJqU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1540E2115B;
	Mon,  3 Feb 2025 03:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738552101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=14AMpYJAt8c0YQTIc9lx6dbWLLYdKP+ygFDKVaEyT5Q=;
	b=KmUVXJqU1VIjTaWBIMK1PK+Z/lJAoAdjY7nmPywD335y2DHEgZVycEwF23gKOvD4ORKNiP
	AmvwEa4JnDP+KqxwzE76V70GIJDyhaeCiiVgQd9IQoIZ/sXiEuhNcWsjGtJMCLYKpxqmIR
	8u80YZoTEL/zAPXnVYM5sagdUPRZsBs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KmUVXJqU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738552101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=14AMpYJAt8c0YQTIc9lx6dbWLLYdKP+ygFDKVaEyT5Q=;
	b=KmUVXJqU1VIjTaWBIMK1PK+Z/lJAoAdjY7nmPywD335y2DHEgZVycEwF23gKOvD4ORKNiP
	AmvwEa4JnDP+KqxwzE76V70GIJDyhaeCiiVgQd9IQoIZ/sXiEuhNcWsjGtJMCLYKpxqmIR
	8u80YZoTEL/zAPXnVYM5sagdUPRZsBs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 131D113795;
	Mon,  3 Feb 2025 03:08:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0uSLMSMzoGdCdQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Feb 2025 03:08:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Jeff Siddall <news@siddall.name>
Subject: [PATCH] btrfs-progs: doc: add a warning when converting to a profile with lower duplication
Date: Mon,  3 Feb 2025 13:38:02 +1030
Message-ID: <8a6796cc4018b38376c228dbdb5a4fafc174e08b.1738552010.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1540E2115B
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
There is a bug report that, a running btrfs with one of its device
deleted using sysfs ('/sys/block/<dev>/device/delete'), btrfs will still
read write on that device.

Normally it's fine as long as all chunks can tolerate that removed
device (e.g. all RAID1).

But the problem is when one is trying to lower the duplication by
converting to a less-safe profile:

  # mkfs.btrfs -f -m raid1 -d raid1 /dev/sdd /dev/sde
  # mount /dev/sdd /mnt
  # echo 1 > /sys/block/sde/device/delete
  # btrfs balance start --force -mdup -dsingle /mnt

This will lead to the fs mounted RO, with the following error messages:

 sd 6:0:0:0: [sde] Synchronizing SCSI cache
 ata7.00: Entering standby power mode
 btrfs: attempt to access beyond end of device
 sde: rw=6145, sector=21696, nr_sectors = 32 limit=0
 btrfs: attempt to access beyond end of device
 sde: rw=6145, sector=21728, nr_sectors = 32 limit=0
 btrfs: attempt to access beyond end of device
 sde: rw=6145, sector=21760, nr_sectors = 32 limit=0
 BTRFS error (device sdd): bdev /dev/sde errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device sdd): bdev /dev/sde errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device sdd): bdev /dev/sde errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device sdd): bdev /dev/sde errs: wr 3, rd 0, flush 1, corrupt 0, gen 0
 btrfs: attempt to access beyond end of device
 sde: rw=145409, sector=128, nr_sectors = 8 limit=0
 BTRFS warning (device sdd): lost super block write due to IO error on /dev/sde (-5)
 BTRFS error (device sdd): bdev /dev/sde errs: wr 4, rd 0, flush 1, corrupt 0, gen 0
 btrfs: attempt to access beyond end of device
 sde: rw=14337, sector=131072, nr_sectors = 8 limit=0
 BTRFS warning (device sdd): lost super block write due to IO error on /dev/sde (-5)
 BTRFS error (device sdd): bdev /dev/sde errs: wr 5, rd 0, flush 1, corrupt 0, gen 0
 BTRFS error (device sdd): error writing primary super block to device 2
 BTRFS info (device sdd): balance: start -dconvert=single -mconvert=dup -sconvert=dup
 BTRFS info (device sdd): relocating block group 1372585984 flags data|raid1
 BTRFS error (device sdd): bdev /dev/sde errs: wr 5, rd 0, flush 2, corrupt 0, gen 0
 BTRFS warning (device sdd): chunk 2446327808 missing 1 devices, max tolerance is 0 for writable mount
 BTRFS: error (device sdd) in write_all_supers:4044: errno=-5 IO failure (errors while submitting device barriers.)
 BTRFS info (device sdd state E): forced readonly
 BTRFS warning (device sdd state E): Skipping commit of aborted transaction.
 BTRFS error (device sdd state EA): Transaction aborted (error -5)
 BTRFS: error (device sdd state EA) in cleanup_transaction:2017: errno=-5 IO failure
 BTRFS info (device sdd state EA): balance: ended with status: -5

[CAUSE]
Btrfs doesn't have any runtime device error handling, it fully rely on
the extra copy provided.

For the sysfs block device removal, normally there is a device shutdown
callback to the running fs, but unfortunately btrfs doesn't support this
callback either.

Thus even with that device removed, btrfs will still access that
removed device (both read and write, even if they will all fail).

Normally for a full RAID1 btrfs, it will still be fine reading/write the
fs as usual.
And the proper action is to replace the removed/missing/failing device
with a newer one using `btrfs device replace`.

But when doing the convert, btrfs will allocate new metadata chunks on
to the removed device (which will lose all writes).

And since the new metadata profile is DUP, which can not handle any
missing device of that metadata chunk, finally it triggers the final
protection at transaction commit time, and flips the fs RO, before it
causing any real data loss.

[DOC ENHANCEMENT]
Add a warning to the `convert` filter about the dangerous doing convert
to a less-safe profile when there is a known failing/removed device.

And mention the proper way to handle such failing/missing device.

The root fix is to introduce a failing/removed device detection for
btrfs, but that will be a pretty big feature and will take quite some
time before landing it upstream.

Reported-by: Jeff Siddall <news@siddall.name>
Link: https://lore.kernel.org/linux-btrfs/2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/ch-balance-filters.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/ch-balance-filters.rst b/Documentation/ch-balance-filters.rst
index 81a0ca8f0345..d1ef6fa17e3c 100644
--- a/Documentation/ch-balance-filters.rst
+++ b/Documentation/ch-balance-filters.rst
@@ -79,10 +79,24 @@ convert=<profile>
                 Starting with kernel 4.5, the ``data`` chunks can be converted to/from the
                 ``DUP`` profile on a single device.

-        .. note::
                 Starting with kernel 4.6, all profiles can be converted to/from ``DUP`` on
                 multi-device filesystems.

+	.. warning::
+		Btrfs doesn't detect bad/missing devices at runtime, thus if
+		there is a known failing device, or a device is deleted by
+		``/sys/block/<dev>/device/delete`` sysfs interface, btrfs will still
+		access and try to write into that failing/removed device.
+
+		In such case, one should not convert to a profile with lower
+		duplication (e.g. from ``RAID1`` to ``SINGLE``), as btrfs can
+		create new chunks on that failing/removed device, and cause
+		various problems.
+
+		And the proper action is to use ``btrfs replace`` or
+		``btrfs device remove`` to handle the failing/missing
+		device first. Then convert with all devices working correctly.
+
 limit=<number>, limit=<range>
         Process only given number of chunks, after all filters are applied. This can be
         used to specifically target a chunk in connection with other filters (``drange``,
--
2.48.1


