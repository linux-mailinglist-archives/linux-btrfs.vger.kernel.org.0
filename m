Return-Path: <linux-btrfs+bounces-15980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A194B2005D
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371CC3AB3D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187512D94A5;
	Mon, 11 Aug 2025 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f7yV9kOB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f7yV9kOB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98E18CC13
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897622; cv=none; b=Zj8SWxduEBUejS0ABBZQpzTmjEgpF7tfaV2C/PaNmspB9sRBvBWQm6UyeSUGD0zV7PangrJfNuJ0rWs9sBvfrn7pCuzMTw9K+oRev7jjxoN2ADL7rCqnhwfysp4MrbyzBtCyz5HYgsiJa/kJihnaibDF4j2zOzg0jrsBfxnf6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897622; c=relaxed/simple;
	bh=FRTz/F6c+z3/1hWnm6WFzkuMZ9ZkcMU4f3RXrv8pQkk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bftT+PDpyNn9/p92+36ZozOgXF5v5sIZ3z8rRjrUHtzXnM9DtP6lsf8tKIMleX0Y+9LlmBKknfNTAtlTwZ4FqWdDAG53MG2vQT9XRNZTo2zJHJBvisaCKYzuMTtHMV63/2lzGCcZJVj4PUbBfDciAFtogDeo9AvR/clRmrt/iVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f7yV9kOB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f7yV9kOB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F0BB5BE07
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 07:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754897618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Je5LeMSomxIcTCuEcWk/rQajJuKvCo5CrNrNHkrfcpM=;
	b=f7yV9kOBQ518CocgZYr/71ubHEQz5SyhYqu5g2WckqG/yP/iwIB4Nl1Fpq5eO8aRu7Joef
	BK2Ja32WL404T8fgXzr0uvyEehVoJk3G7u0rzPRar2AmVfsW9PQrGcn4Ovdwr/IUpfuIxN
	rfXcel3knpG6KGbOhWDR2p/utgX1b/U=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754897618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Je5LeMSomxIcTCuEcWk/rQajJuKvCo5CrNrNHkrfcpM=;
	b=f7yV9kOBQ518CocgZYr/71ubHEQz5SyhYqu5g2WckqG/yP/iwIB4Nl1Fpq5eO8aRu7Joef
	BK2Ja32WL404T8fgXzr0uvyEehVoJk3G7u0rzPRar2AmVfsW9PQrGcn4Ovdwr/IUpfuIxN
	rfXcel3knpG6KGbOhWDR2p/utgX1b/U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67C7013A55
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 07:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N+UlCdGcmWiAVwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 07:33:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: prevent device path updating during mount
Date: Mon, 11 Aug 2025 17:03:15 +0930
Message-ID: <46498bbf2891a2c9539b33d17155ad9cd5f9401a.1754897590.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[REGRESSION]
After commit bddf57a70781 ("btrfs: delay btrfs_open_devices() until
super block is created"), test case btrfs/315 can fail like this
randomly:

btrfs/315 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/315.out.bad)
    --- tests/btrfs/315.out	2025-08-11 16:40:36.496000000 +0930
    +++ /home/adam/xfstests/results//btrfs/315.out.bad	2025-08-11 16:41:04.304000000 +0930
    @@ -1,7 +1,7 @@
     QA output created by 315
     ---- seed_device_must_fail ----
     mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
    -mount: File exists
    +mount: /mnt/test/315/tempfsid_mnt: WARNING: source write-protected, mounted read-only
     ---- device_add_must_fail ----
     wrote 9000/9000 bytes at offset 0
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/315.out /home/adam/xfstests/results//btrfs/315.out.bad'  to see the entire diff)
Ran: btrfs/315
Failures: btrfs/315
Failed 1 of 1 tests

[CAUSE]
The failure is that the second seed device (with a duplicated fsid and
dev uuid) is mounted successfully, which is unexpected.

In my environment, the following 2 devices involved in the
"seed_device_must_fail" run are:

 lrwxrwxrwx 1 root root 7 Aug 11 09:03 /dev/test/scratch1 -> ../dm-2
 lrwxrwxrwx 1 root root 7 Aug 11 09:03 /dev/test/scratch2 -> ../dm-4

Note the kernel dmesg of that run, when mounting the first seed device
(scratch1), the real device got mounted is the second seed device
(scratch2):

 BTRFS: device fsid 7c8a5017-0c44-456f-8acf-57663f954e53 devid 1 transid 9 /dev/mapper/test-scratch1 (253:2) scanned by mount (3343974)
 BTRFS info (device dm-4): first mount of filesystem 7c8a5017-0c44-456f-8acf-57663f954e53
 BTRFS info (device dm-4): using crc32c (crc32c-generic) checksum algorithm
 BTRFS info (device dm-4): using free-space-tre

Note that "(device dm-4)" line, this means /dev/test/scratch2 is
mounted when running "mount /dev/test/scratch1 /mnt/scratch".

Then when trying to mount /dev/test/scratch2, since the same device is
already mounted, it returns the same super block and do not fail.

The root cause is, when setting seed device flags for both devices,
a btrfs device scan is triggered, that scan is delayed and can happen at
any time.

So there is a race window between scanning the second device and
mounting the first device, where the device path can be replaced
halfway:

     Mount scratch1                |          Scanning scratch2
-----------------------------------+-------------------------------------
btrfs_get_tree_super()             |
|- btrfs_scan_one_device()         |
|  We're mounting "scratch1"       |
|                                  |
|- btrfs_fs_devices_inc_holding()  |
|- mutex_unlock(&uuid_mutex);      |
|                                  | btrfs_scan_one_device()
|                                  | |- device_list_add()
|                                  |    |- rcu_assign_pointer()
|                                  |       This changes the device->name
|                                  |       to "scratch2"
|- sget_fc()                       |
|  This creates a new super block  |
|- mutex_lock(&uuid_mutex)         |
|- btrfs_fs_devices_dec_holding()  |
|- btrfs_open_devices()            |
   |- btrfs_open_one_device()      |
      "scratch2" is opened as that |
      is recorded in device->name   |

Commit bddf57a70781 ("btrfs: delay btrfs_open_devices() until super
block is created") introduced fs_devices holding mechanism to allow
devices to be opened after super block is created.

But that holding period doesn't keep device->name untouched, allowing
a duplicated device to replace the path, thus mounting the incorrect
device.

[FIX]
Also check fs_devices->holding value before replacing the device->name.
If fs_devices->holding is not zero, meaning someone is trying to mount
the fs, then do not allow device->name to be updated.

Although this situation is rare, require certain race window and
two devices with duplicated fsid/dev uuid (which is already very cursed),
still output a warning message so that end users can be informed about
such cursed situation.

Fixes: bddf57a70781 ("btrfs: delay btrfs_open_devices() until super block is created")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa7a929a0461..4fdd84e0bff9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -934,6 +934,20 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				  path, found_transid, device->generation);
 			return ERR_PTR(-EEXIST);
 		}
+		if (fs_devices->holding) {
+			/*
+			 * The fs_devices are already hold by an ongoing mount.
+			 *
+			 * We can not update the device path, or a duplicated
+			 * fsid/dev-uuid can replace the original path, causing
+			 * another device to be mounted.
+			 */
+			btrfs_warn(NULL,
+				   "device %s is trying to update path for a device being mounted",
+				   path);
+			mutex_unlock(&fs_devices->device_list_mutex);
+			return ERR_PTR(-EEXIST);
+		}
 
 		/*
 		 * We are going to replace the device path for a given devid,
-- 
2.50.1


