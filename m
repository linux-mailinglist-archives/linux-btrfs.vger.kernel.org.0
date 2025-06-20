Return-Path: <linux-btrfs+bounces-14825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD3CAE1FC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 18:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B229E3A4AFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DEA2DFA35;
	Fri, 20 Jun 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V/zc8zBq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V/zc8zBq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86213774D
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435615; cv=none; b=Qj7BwySLmKxVkSBQDSUE4ntI+pba8b4UvAGiBLxvFNTZIPJmTwSjWf9cXTI/CQN8yUJ3zHBFEXy6Nxbz9lJvxQuQ6oIsdaYSEjSrBcCQx2fQ2pVVqLyk1SIbUkfXLUMKDdKPZhH93yS9QaaJOBNLpCPSa+h5NWditICxe1o8y74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435615; c=relaxed/simple;
	bh=9ncPnCkhw+WV1AMlZPE5WdwLb7Eatlrep5OI0YKESzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSScHOTC6CKvygZ1w5KwNqhfTSBsRKbzNyIxeO1WVAvHY6DA0TEE33R5n0Bh1g07RuHHs5ruaryXk8Dvkzl7e47XpHabh6rfjibW1hs6wPh6tYz5M22Q7VSu+rM5kyxIvX0xb3UreCE7YUzI9YDFrY5ElPwQO9rhi+zNLmTgOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V/zc8zBq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V/zc8zBq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B71971F38D;
	Fri, 20 Jun 2025 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750435610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=def8ke5pnzBKBMzGQ59wxSEnDghwISuE4bOkLvuIJ6g=;
	b=V/zc8zBqJo71/kB8aDv/peOwkR0KScuTa8AonFdY22mnHGsD2sC7LdM/aaLXgtzbSpGBal
	Bq2VHZDNeriDSJkReS7Y/MH14SenySY2P7HyDIBnjzGEjI5lsdqZJLwzf1tULOXVQF7D1E
	UCfTY24NezuPqqmA26E4ncbviLDPr4Y=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="V/zc8zBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750435610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=def8ke5pnzBKBMzGQ59wxSEnDghwISuE4bOkLvuIJ6g=;
	b=V/zc8zBqJo71/kB8aDv/peOwkR0KScuTa8AonFdY22mnHGsD2sC7LdM/aaLXgtzbSpGBal
	Bq2VHZDNeriDSJkReS7Y/MH14SenySY2P7HyDIBnjzGEjI5lsdqZJLwzf1tULOXVQF7D1E
	UCfTY24NezuPqqmA26E4ncbviLDPr4Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF14D13736;
	Fri, 20 Jun 2025 16:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gaq4KhqHVWjBagAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 20 Jun 2025 16:06:50 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use our message helpers instead of pr_err/pr_warn/pr_info
Date: Fri, 20 Jun 2025 18:06:45 +0200
Message-ID: <20250620160645.3744830-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
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
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B71971F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

Our message helpers accept NULL for the fs_info in the context that does
not provide and print the common header of the message. The use of pr_*
helpers is only for special reasons, like module loading, device
scanning or multi-line output (print-tree).

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c    | 10 +++++-----
 fs/btrfs/disk-io.c        |  2 +-
 fs/btrfs/extent-io-tree.c |  3 ++-
 fs/btrfs/extent_io.c      |  4 ++--
 fs/btrfs/print-tree.c     |  2 +-
 fs/btrfs/sysfs.c          |  5 ++---
 fs/btrfs/volumes.c        |  8 ++++----
 fs/btrfs/zstd.c           |  3 +--
 8 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 48d07939fee4a0..a4934eb1ecdc99 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -789,8 +789,8 @@ static void btrfs_init_workspace_manager(int type)
 	 */
 	workspace = alloc_workspace(type, 0);
 	if (IS_ERR(workspace)) {
-		pr_warn(
-	"BTRFS: cannot preallocate compression workspace, will try later\n");
+		btrfs_warn(NULL,
+			   "cannot preallocate compression workspace, will try later");
 	} else {
 		atomic_set(&wsm->total_ws, 1);
 		wsm->free_ws = 1;
@@ -888,9 +888,9 @@ struct list_head *btrfs_get_workspace(int type, int level)
 					/* once per minute */ 60 * HZ,
 					/* no burst */ 1);
 
-			if (__ratelimit(&_rs)) {
-				pr_warn("BTRFS: no compression workspaces, low memory, retrying\n");
-			}
+			if (__ratelimit(&_rs))
+				btrfs_warn(NULL,
+				"no compression workspaces, low memory, retrying");
 		}
 		goto again;
 	}
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0cd22952286358..1f8abc3f4f8bf7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3995,7 +3995,7 @@ int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags)
 	}
 
 	if (min_tolerated == INT_MAX) {
-		pr_warn("BTRFS: unknown raid flag: %llu", flags);
+		btrfs_warn(NULL, "unknown raid flag: %llu", flags);
 		min_tolerated = 0;
 	}
 
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 84da01996336c1..66361325f6dcea 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -43,7 +43,8 @@ static inline void btrfs_extent_state_leak_debug_check(void)
 
 	while (!list_empty(&states)) {
 		state = list_first_entry(&states, struct extent_state, leak_list);
-		pr_err("BTRFS: state leak: start %llu end %llu state %u in tree %d refs %d\n",
+		btrfs_err(NULL,
+		       "state leak: start %llu end %llu state %u in tree %d refs %d",
 		       state->start, state->end, state->state,
 		       extent_state_in_tree(state),
 		       refcount_read(&state->refs));
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c8c53a008c5315..aec2a7390b5c1c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -75,8 +75,8 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 	while (!list_empty(&fs_info->allocated_ebs)) {
 		eb = list_first_entry(&fs_info->allocated_ebs,
 				      struct extent_buffer, leak_list);
-		pr_err(
-	"BTRFS: buffer leak start %llu len %u refs %d bflags %lu owner %llu\n",
+		btrfs_err(fs_info,
+		       "buffer leak start %llu len %u refs %d bflags %lu owner %llu",
 		       eb->start, eb->len, refcount_read(&eb->refs), eb->bflags,
 		       btrfs_header_owner(eb));
 		list_del(&eb->leak_list);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 21605b03f51188..74e38da9bd39cd 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -190,7 +190,7 @@ static void print_uuid_item(const struct extent_buffer *l, unsigned long offset,
 			    u32 item_size)
 {
 	if (!IS_ALIGNED(item_size, sizeof(u64))) {
-		pr_warn("BTRFS: uuid item with illegal size %lu!\n",
+		btrfs_warn(l->fs_info, "uuid item with illegal size %lu",
 			(unsigned long)item_size);
 		return;
 	}
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b860470cffc4c8..9e7a812651e826 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -160,8 +160,7 @@ static int can_modify_feature(struct btrfs_feature_attr *fa)
 		clear = BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR;
 		break;
 	default:
-		pr_warn("btrfs: sysfs: unknown feature set %d\n",
-				fa->feature_set);
+		btrfs_warn(NULL, "sysfs: unknown feature set %d", fa->feature_set);
 		return 0;
 	}
 
@@ -2247,7 +2246,7 @@ void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
 
 	ret = kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, action);
 	if (ret)
-		pr_warn("BTRFS: Sending event '%d' to kobject: '%s' (%p): failed\n",
+		btrfs_warn(NULL, "sending event %d to kobject: '%s' (%p): failed",
 			action, kobject_name(&disk_to_dev(bdev->bd_disk)->kobj),
 			&disk_to_dev(bdev->bd_disk)->kobj);
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0fbda06162594b..1b623bae927cff 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -675,8 +675,8 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING) {
 		if (btrfs_super_incompat_flags(disk_super) &
 		    BTRFS_FEATURE_INCOMPAT_METADATA_UUID) {
-			pr_err(
-		"BTRFS: Invalid seeding and uuid-changed device detected\n");
+			btrfs_err(NULL,
+				  "invalid seeding and uuid-changed device detected");
 			goto error_free_page;
 		}
 
@@ -820,7 +820,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		if (same_fsid_diff_dev) {
 			generate_random_uuid(fs_devices->fsid);
 			fs_devices->temp_fsid = true;
-		pr_info("BTRFS: device %s (%d:%d) using temp-fsid %pU\n",
+			btrfs_info(NULL, "device %s (%d:%d) using temp-fsid %pU",
 				path, MAJOR(path_devt), MINOR(path_devt),
 				fs_devices->fsid);
 		}
@@ -1474,7 +1474,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 
 	devt = file_bdev(bdev_file)->bd_dev;
 	if (btrfs_skip_registration(disk_super, path, devt, mount_arg_dev)) {
-		pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
+		btrfs_debug(NULL, "skip registering single non-seed device %s (%d:%d)",
 			  path, MAJOR(devt), MINOR(devt));
 
 		btrfs_free_stale_devices(devt, NULL);
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 4a796a049b5a24..ff0292615e1f37 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -200,8 +200,7 @@ void zstd_init_workspace_manager(void)
 
 	ws = zstd_alloc_workspace(ZSTD_BTRFS_MAX_LEVEL);
 	if (IS_ERR(ws)) {
-		pr_warn(
-		"BTRFS: cannot preallocate zstd compression workspace\n");
+		btrfs_warn(NULL, "cannot preallocate zstd compression workspace");
 	} else {
 		set_bit(ZSTD_BTRFS_MAX_LEVEL - 1, &wsm.active_map);
 		list_add(ws, &wsm.idle_ws[ZSTD_BTRFS_MAX_LEVEL - 1]);
-- 
2.49.0


