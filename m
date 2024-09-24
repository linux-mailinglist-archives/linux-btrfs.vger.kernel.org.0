Return-Path: <linux-btrfs+bounces-8185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ACE983C4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 07:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59696B2265B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 05:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2EE45C1C;
	Tue, 24 Sep 2024 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ok33knwQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ok33knwQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E15282FE
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 05:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155051; cv=none; b=sA/hyJq1nYRUazvyr/to+8oqEeCsfQgFRIfD9CeMrZRQBp5FaOMzOPA7DovI8QdWrw73s88BbwKDzJT7aeWSriTXIDOZsR8dR8nRAULiLM1I1inYIKCtC8FOMhs2Fg5r9vCCyTXXC/MeB7OBt+4wMVjoEoewJ1pHI2oBO/e9vbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155051; c=relaxed/simple;
	bh=j6ODxGqbKo4/LKZZp7+bwzGuq3UZyzHKpgdwcYVnhe4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUEhvai/rac6b89z57Z48DvrS7s5+XLtrZOvSNRDRaF3lXhIf14cCkmGceJbV5tJ2Ps2Eh1+jb2g2n+QI2vyAbAJPndvYIhsy1ZE3UYsaK5ljJ2XP6cxuUv/cgZTLTzSdrYcOYcMhvHvpBEQFq0zQOhpPjNe2cQlag6t6/8Xw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ok33knwQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ok33knwQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 479721F76B
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 05:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727155047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvDwcxnzQ5VoEtC9t8kv5BxTKpzDXLRO/t63swV6XXM=;
	b=Ok33knwQMQig4EHZaCMSqoHfJpQKHMdy9l5uca7d9apQQ1MHbjdJYIAI69zAeFlTSobha1
	kv/KAPPqs5pSW77VhQxDHco9W1uD0BWcFw4dtx2QmGhReDmCZ1mjoEcgCzcMucWb8F7BwU
	w/vqeWnIzU/PlkRV17esNne/JkmQ9Gk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Ok33knwQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727155047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvDwcxnzQ5VoEtC9t8kv5BxTKpzDXLRO/t63swV6XXM=;
	b=Ok33knwQMQig4EHZaCMSqoHfJpQKHMdy9l5uca7d9apQQ1MHbjdJYIAI69zAeFlTSobha1
	kv/KAPPqs5pSW77VhQxDHco9W1uD0BWcFw4dtx2QmGhReDmCZ1mjoEcgCzcMucWb8F7BwU
	w/vqeWnIzU/PlkRV17esNne/JkmQ9Gk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88FA31386E
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 05:17:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YNVNE2ZL8maFQgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 05:17:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: avoid unnecessary device path update for the same device
Date: Tue, 24 Sep 2024 14:47:06 +0930
Message-ID: <bb5f08852d68f7424b1113deb74586527912c290.1727154543.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727154543.git.wqu@suse.com>
References: <cover.1727154543.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 479721F76B
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[PROBLEM]
It is very common for udev to trigger device scan, and every time a
mounted btrfs device got re-scan from different soft links, we will get
unnecessary renames like this:

 BTRFS: device fsid 2378be81-fe12-46d2-a9e8-68cf08dd98d5 devid 1 transid 7 /proc/self/fd/3 (253:2) scanned by mount_by_fd (11096)
 BTRFS info (device dm-2): first mount of filesystem 2378be81-fe12-46d2-a9e8-68cf08dd98d5
 BTRFS info (device dm-2): using crc32c (crc32c-intel) checksum algorithm
 BTRFS info (device dm-2): using free-space-tree
 BTRFS info: devid 1 device path /proc/self/fd/3 changed to /dev/dm-2 scanned by (udev-worker) (11092)
 BTRFS info: devid 1 device path /dev/dm-2 changed to /dev/mapper/test-scratch1 scanned by (udev-worker) (11092)

The program "mount_by_fd" has the following simple source code:

 #include <fcntl.h>
 #include <stdio.h>
 #include <sys/mount.h>

 int main(int argc, char *argv[]) {
	int fd = open(argv[1], O_RDWR);
	char path[256];

	snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
	return mount(path, argv[2], "btrfs", 0, NULL);
 }

Note that, all the above paths are all just pointing to "/dev/dm-2".
The "/proc/self/fd/3" is the proc fs, describing all the opened fds.
The "/dev/mapper/test-scratch1" is the soft link created by LVM2.

[CAUSE]
Inside device_list_add(), we are using a very primitive way checking if
the device has changed, strcmp().

Which can never handle links well, no matter if it's hard or soft links.

So every different link of the same device will be treated as different
device, causing the unnecessary device name update.

[FIX]
Introduce a helper, is_same_device(), and use path_equal() to properly
detect the same block device.
So that the different soft links won't trigger the rename race.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 995b0647f538..b713e4ebb362 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -732,6 +732,32 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb)
 	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
 }
 
+static bool is_same_device(struct btrfs_device *device, const char *new_path)
+{
+	struct path old = { .mnt = NULL, .dentry = NULL };
+	struct path new = { .mnt = NULL, .dentry = NULL };
+	char *old_path;
+	bool is_same = false;
+	int ret;
+
+	if (!device->name)
+		goto out;
+
+	old_path = rcu_str_deref(device->name);
+	ret = kern_path(old_path, LOOKUP_FOLLOW, &old);
+	if (ret)
+		goto out;
+	ret = kern_path(new_path, LOOKUP_FOLLOW, &new);
+	if (ret)
+		goto out;
+	if (path_equal(&old, &new))
+		is_same = true;
+out:
+	path_put(&old);
+	path_put(&new);
+	return is_same;
+}
+
 /*
  * Add new device to list of registered devices
  *
@@ -852,7 +878,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				MAJOR(path_devt), MINOR(path_devt),
 				current->comm, task_pid_nr(current));
 
-	} else if (!device->name || strcmp(device->name->str, path)) {
+	} else if (!device->name || !is_same_device(device, path)) {
 		/*
 		 * When FS is already mounted.
 		 * 1. If you are here and if the device->name is NULL that
-- 
2.46.1


