Return-Path: <linux-btrfs+bounces-15820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D2DB196DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 01:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3520F18937D9
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC161547D2;
	Sun,  3 Aug 2025 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DidVsKje";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DidVsKje"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B72153EA
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754265184; cv=none; b=fTXmAIXXmztfJsQ75jbIDbD35i/8XHsCVHJcQdmE18hJtq9r8dJrIIWju25pZk7DemnnV2+2/Kxz72jDPGtRjDkwn0G/Ns+mL+kWO+Y4KQpJOF2+XCOx3lZ2EA0eLLRpgtCUFL9VpANi5v7DRgKpAw+C8I9qSqkPWVCfzX1KGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754265184; c=relaxed/simple;
	bh=8O6nP9fLgXG3yqhCZh2y1+RxAbl9AEUIU74Ar6py2uo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/FKF5E6rYR+8SSuZXShsw8ruKIHco3KA0HzVwXKCLvvPfHoAn4b49LqthYmopx2fHverq0O3ZUkuTP/HjxlflXTviA+xYnb4cEmFW0iSmBZ5ji0waN4C5NTCeWY0ewgJLeMMoQjXPzdWOrBDLq0nIq0vUqHvII/+0Ihgl8ooLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DidVsKje; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DidVsKje; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57467218A0
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754265179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ak+bhZ4XJIyMyEieGDzZtwIBp//4HyypVS79gFIlm1U=;
	b=DidVsKjeyUgjPsJWsyHzZSqORnoRs60yJL7DbmyuG86KtbmVEMc7L2oV0WVgm/ip8BrAdT
	bp920no0q1EXlIZGf0czp6l/RRyYp9WBCQ/4Zt4BhxbdPt3DOaf7zWZHBLEsamB9KgFpzm
	5kx8Tw4gYlc3LmR2O86VhfCkoHwHAMo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DidVsKje
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754265179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ak+bhZ4XJIyMyEieGDzZtwIBp//4HyypVS79gFIlm1U=;
	b=DidVsKjeyUgjPsJWsyHzZSqORnoRs60yJL7DbmyuG86KtbmVEMc7L2oV0WVgm/ip8BrAdT
	bp920no0q1EXlIZGf0czp6l/RRyYp9WBCQ/4Zt4BhxbdPt3DOaf7zWZHBLEsamB9KgFpzm
	5kx8Tw4gYlc3LmR2O86VhfCkoHwHAMo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D6B113974
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WLCEE1r2j2hPZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 03 Aug 2025 23:52:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: docs/seed: add extra notes for v6.17 and newer kernels
Date: Mon,  4 Aug 2025 09:22:37 +0930
Message-ID: <995e85d0a82bba0e2665654d64260feea2f2398d.1754265134.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754265134.git.wqu@suse.com>
References: <cover.1754265134.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 57467218A0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

[BEHAVIOR CHANGE]
In the incoming v6.17 kernel release, due to the changes in commit
40426dd147ff ("btrfs: use the super_block as holder when mounting file
systems"), we can no longer mount a seed device through both sprouted
fs and the seed device.

E.g.

 # mkfs.btrfs -f /dev/test/scratch1
 # mount /dev/test/scratch1 /mnt/btrfs
 # xfs_io -f -c "pwrite 0 16m" /mnt/btrfs/foobar
 # umount /mnt/btrfs
 # btrfstune -S1 /dev/test/scratch1
 # mount /dev/test/scratch1 /mnt/btrfs
 # btrfs device add /dev/test/scratch2 /mnt/btrfs

 Now the sprouted fs is mount, but if one wants to mount the seed
 device, it will fail:

 # mount /dev/test/scratch1  /mnt/btrfs/
 mount: /mnt/btrfs: /dev/mapper/test-scratch1 already mounted or mount point busy.
        dmesg(1) may have more information after failed mount system call.

 The only new dmesg is:

 BTRFS error: failed to open device for path /dev/mapper/test-scratch1 with flags 0x23: -16

[CAUSE]
After that kernel commit, each block device will have its own unique
holder (super block).

This super block block device holder is critical to pass device events
like freeze/thaw/missing to each filesystem.

And after the seed device is sprouted, the holder for the seed device is
the super block of the sprouted fs.

But if some one else tries to mount the seed device again, it will be a
new super block as the holder passed into bdev_file_open_by_path().

Since the seed device already has a different holder, this new
bdev_file_open_by_path() will fail with -EBUSY.

[ENHANCEMENT]
This is a kernel behavior change, but considering the benefit (proper
bdev events passing into the fs) I'd say the old behavior is more like a
hack or a coincidence, other than a properly designed behavior.

So update the documentation to make it more explicit.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/ch-seeding-device.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ch-seeding-device.rst b/Documentation/ch-seeding-device.rst
index 8ca55dacd6a5..7ff35c3a3f8d 100644
--- a/Documentation/ch-seeding-device.rst
+++ b/Documentation/ch-seeding-device.rst
@@ -19,6 +19,16 @@ read-only, it can be used to seed multiple filesystems from one device at the
 same time. The UUID that is normally attached to a device is automatically
 changed to a random UUID on each mount.
 
+.. note::
+
+	Before v6.17 kernel, a seed device can be mounted independently along
+	with sprouted filesystems.
+	But since v6.17 kernel, a seed device can only be mounted either through
+	a sprouted filesystem, or the seed device itself, not both at the same time.
+
+	This is to ensure a block device to have only a single filesystem bounded
+	to it, so that runtime device missing events can be properly handled.
+
 Once the seeding device is mounted, it needs the writable device. After adding
 it, unmounting and mounting with :command:`umount /path; mount /dev/writable
 /path` or remounting read-write with :command:`remount -o remount,rw` makes the
-- 
2.50.1


