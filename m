Return-Path: <linux-btrfs+bounces-11217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D72A251D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 05:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399A01624D6
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 04:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16BF70809;
	Mon,  3 Feb 2025 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C4nwAU6N";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C4nwAU6N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B352F46
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738556230; cv=none; b=L43B0MrvAGVKx3rXYTghxWSH52oylyFfGrDJjGRt1yQL+S0CI0qVLdWbP7XHihR+0OxwbcVlD6xATweezr9R5MkYgMd7sibR6Hoeo1Lb5x6fMu6tG4sdAU9txX1rU7M5Bm54KlsODoDBFhFQALh+TDPNCEDdHGN9/KJaVaaav44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738556230; c=relaxed/simple;
	bh=zoIqXafYgP7uiuN4ojlFkPDnNWtP/lA90LUn+EscDk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riotBK7F5Fd/XsaP9e0KdR34tWtbflemjIApFKT0U54s6xp0JguWmhClR3qQuuuZIktXYXw876DzuycehOx83vLFOXFbt7vKTYMnQv7Ia6XDXAL8rBOIEwLVXS/+G6VBYNbf7xfWAELSlkGBANPeg4vvV8qX0T5MZr3lSfzdk2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C4nwAU6N; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C4nwAU6N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F1D01F37C;
	Mon,  3 Feb 2025 04:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738556221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PsixfuiQ8YqDRxJPUlZBGk6EaIQNB9aWVUGhRoE7ntE=;
	b=C4nwAU6NnOU4eNgsjuZeD11E2BcDEY8deSHjTubNRdjdXcTSUo05ugHsn6FnNVk2yqg96e
	s4YWdhSTE+xUpjiWV3D34LfBXBA15xD2wnuBAn9Oxb02wHJSy4A9mxMkUsX6pv3YUHD2Md
	uS53ialm52U83R0GVrVWmS/pNCNZpCA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=C4nwAU6N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738556221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PsixfuiQ8YqDRxJPUlZBGk6EaIQNB9aWVUGhRoE7ntE=;
	b=C4nwAU6NnOU4eNgsjuZeD11E2BcDEY8deSHjTubNRdjdXcTSUo05ugHsn6FnNVk2yqg96e
	s4YWdhSTE+xUpjiWV3D34LfBXBA15xD2wnuBAn9Oxb02wHJSy4A9mxMkUsX6pv3YUHD2Md
	uS53ialm52U83R0GVrVWmS/pNCNZpCA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BEE813674;
	Mon,  3 Feb 2025 04:16:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RhKjLztDoGcUBwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Feb 2025 04:16:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Jeff Siddall <news@siddall.name>
Subject: [PATCH] btrfs-progs: balance: add extra delay if converting with a missing device
Date: Mon,  3 Feb 2025 14:46:42 +1030
Message-ID: <c5f42e2e31ffc95f93e62eef7d51a01bfbc9471f.1738556153.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F1D01F37C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG]
There is a reproducer that can trigger btrfs to flips RO:

 # mkfs.btrfs -f -mraid1 -draid1 /dev/sdd /dev/sde
 # mount /dev/sdd /mnt/btrfs
 # echo 1 > /sys/block/sde/device/delete
 # btrfs balance start -mconvert=dup -dconvert=single /mnt/btrfs
 ERROR: error during balancing '.': Input/output error
 There may be more info in syslog - try dmesg | tail

Then btrfs will flip read-only with the following errors:

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
The root cause is that, deleting devices using sysfs interface normally
will trigger the shutdown callback for the fs.

But btrfs doesn't handle that callback at all, thus it can not really
know that device is no longer avaialble, thus btrfs will still try to do
usual read/write on that device.

This is fine if the user do nothing, as RAID1 can handle it properly.

But if we try to convert to SINGLE/DUP, btrfs will still use that device
to allocate new data/metadata chunks.
And if a new metadata chunk is allocated to the removed device, all the
write will be lost, and trigger the super block write/barrier errors
above.

[USER SPACE ENHANCEMENT]
For now, add extra missing devices check at btrfs-balance command.
If there is a missing devices, `btrfs balance` will add a 10 seconds
delay and warn the possible dangerous.

The root fix is to introduce a failing/removed device detection for
btrfs, but that will be a pretty big feature and will take quite some
time before landing it upstream.

Reported-by: Jeff Siddall <news@siddall.name>
Link: https://lore.kernel.org/linux-btrfs/2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/balance.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/cmds/balance.c b/cmds/balance.c
index 4c73273dfdc3..5c17fbc1acb5 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -376,6 +376,45 @@ static const char * const cmd_balance_start_usage[] = {
 	NULL
 };
 
+/*
+ * Return 0 if no missing device found for the fs at @mnt.
+ * Return >0 if there is any missing device for the fs at @mnt.
+ * Return <0 if we hit other errors during the check.
+ */
+static int check_missing_devices(const char *mnt)
+{
+	struct btrfs_ioctl_fs_info_args fs_info_arg;
+	struct btrfs_ioctl_dev_info_args *dev_info_args = NULL;
+	bool found_missing = false;
+	int ret;
+
+	ret = get_fs_info(mnt, &fs_info_arg, &dev_info_args);
+	if (ret < 0)
+		return ret;
+
+	for (int i = 0; i < fs_info_arg.num_devices; i++) {
+		struct btrfs_ioctl_dev_info_args *cur_dev_info;
+		int fd;
+
+		cur_dev_info = (struct btrfs_ioctl_dev_info_args *)&dev_info_args[i];
+
+		/*
+		 * Kernel will report the device path even if we can no
+		 * longer access it anymore. So we have to manually check it.
+		 */
+		fd = open((char *)cur_dev_info->path, O_RDONLY);
+		if (fd < 0) {
+			found_missing = true;
+			break;
+		}
+		close(fd);
+	}
+	free(dev_info_args);
+	if (found_missing)
+		return 1;
+	return 0;
+}
+
 static int cmd_balance_start(const struct cmd_struct *cmd,
 			     int argc, char **argv)
 {
@@ -387,6 +426,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 	bool enqueue = false;
 	unsigned start_flags = 0;
 	bool raid56_warned = false;
+	bool convert_warned  = false;
 	int i;
 
 	memset(&args, 0, sizeof(args));
@@ -481,6 +521,53 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 		args.flags |= BTRFS_BALANCE_TYPE_MASK;
 	}
 
+	/*
+	 * If we are using convert, and there is a missing/failed device at
+	 * runtime (e.g. mounted then remove a device using sysfs interface),
+	 * btrfs has no way to avoid using that failing/removed device.
+	 *
+	 * In that case converting the profile is very dangerous, e.g.
+	 * converting RAID1 to SINGLE/DUP, and new SINGLE/DUP chunks can
+	 * be allocated to that failing/removed device, and cause the
+	 * fs to flip RO due to failed metadata writes.
+	 *
+	 * Meanwhile the fs may work completely fine due to the extra
+	 * duplication (e.g. all RAID1 profiles).
+	 *
+	 * So here warn if one is trying to convert with missing devices.
+	 */
+	for (i = 0; ptrs[i]; i++) {
+		int delay = 10;
+		int ret;
+
+		if (!(ptrs[i]->flags & BTRFS_BALANCE_ARGS_CONVERT) || convert_warned)
+			continue;
+
+		ret = check_missing_devices(argv[optind]);
+		if (ret < 0) {
+			errno = -ret;
+			warning("skipping missing devices check due to failure: %m");
+			break;
+		}
+		if (ret == 0)
+			continue;
+		convert_warned = true;
+		printf("WARNING:\n\n");
+		printf("\tConversion with missing device(s) can be dangerous.\n");
+		printf("\tPlease use `btrfs replace` or `btrfs device remove` instead.\n");
+		if (force) {
+			printf("\tSafety timeout skipped due to --force\n\n");
+			continue;
+		}
+		printf("\tThe operation will continue in %d seconds.\n", delay);
+		printf("\tUse Ctrl-C to stop.\n");
+		while (delay) {
+			printf("%2d", delay--);
+			fflush(stdout);
+			sleep(1);
+		}
+	}
+
 	/* drange makes sense only when devid is set */
 	for (i = 0; ptrs[i]; i++) {
 		if ((ptrs[i]->flags & BTRFS_BALANCE_ARGS_DRANGE) &&
-- 
2.48.1


