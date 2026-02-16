Return-Path: <linux-btrfs+bounces-21695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDW2BJOYk2ly6wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21695-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 23:22:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2B5147E9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 23:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C30E130071C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 22:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E63289378;
	Mon, 16 Feb 2026 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KMW6gdTX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KMW6gdTX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DE14A60F
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771280524; cv=none; b=cXqmo1/pxu9JQlbouxzx/FZWf/tD39LA2a79kV/l81xVJLQJD3l2jhgcSR9bhZOsHfzOkbRXEj6561QaMCcKDvfkeN/CKlVrpNyHinb+nC2Q7PWrT2A13Vj4JxBTNzSyMy3+N/Gfn63SUNPhw15a3LuiTm9TKKEIQHp2PtERShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771280524; c=relaxed/simple;
	bh=UCnWoFtHS7KBu4TSlthEiYOvN312y7A2WSxw3JFWFzc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lh5k3c76lVXUio23jWxWOIu1jt4AIL9NhdxJSw0ZgyEy9zP+EuRQyoN5aEW8XB8r9rbR/bedhjUBOmLOwbfc3d5af77N9ig96Cgo+miIf165O4fe4BvUElQzPE5MP9UaaFMSvlqEUacMFiwaPAk1WfuPYNGmkmcvV4dfzddanPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KMW6gdTX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KMW6gdTX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97B473E730
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 22:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771280521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jb3CVSEI/0K+NXQ4/hj+lnfwESlu4Ki0RdnPoL7jZX8=;
	b=KMW6gdTXUodiyxYZfz5wiEXIoEJAF/aUnuKpd/XgejtibynWYUHoOa/vPdRS7Z9eP8g0Ti
	Ri9S3tLCgZJKO1o+PyviT6i+n3td0yt4YEwlB6CaH6ZntmP1p+SKOWrj4BSExTz406375I
	xO0cw0lEKxXKfxTXXmEb0j5e57TvMQg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771280521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jb3CVSEI/0K+NXQ4/hj+lnfwESlu4Ki0RdnPoL7jZX8=;
	b=KMW6gdTXUodiyxYZfz5wiEXIoEJAF/aUnuKpd/XgejtibynWYUHoOa/vPdRS7Z9eP8g0Ti
	Ri9S3tLCgZJKO1o+PyviT6i+n3td0yt4YEwlB6CaH6ZntmP1p+SKOWrj4BSExTz406375I
	xO0cw0lEKxXKfxTXXmEb0j5e57TvMQg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCF8B3EA62
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 22:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l+qAI4iYk2mfBAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 22:22:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix and prevent off-by-one bug when calling strncpy_null()
Date: Tue, 17 Feb 2026 08:51:37 +1030
Message-ID: <de4239be029b274e2d6a8e0035afc66e81333ad7.1771280483.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21695-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 9C2B5147E9C
X-Rspamd-Action: no action

[BUG]
There is a bug report that with asan enabled, "btrfs device stat
--offline" will trigger the following out-of-boundary write error:

=================================================================
==4929==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7da0fd9e6100 at pc 0x7f90ff11ae55 bp 0x7ffcd98b97f0 sp 0x7ffcd98b8f98
WRITE of size 1025 at 0x7da0fd9e6100 thread T0
    #0 0x7f90ff11ae54 in strncpy /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_interceptors.cpp:628
    #1 0x55ed2020e8ab in strncpy_null common/string-utils.c:62
    #2 0x55ed202ad500 in get_fs_info_offline cmds/device.c:798
    #3 0x55ed202ade4a in cmd_device_stats cmds/device.c:895
    #4 0x55ed2011a4fb in cmd_execute cmds/commands.h:126
    #5 0x55ed2011ae55 in handle_command_group /home/adam/btrfs-progs/btrfs.c:184
    #6 0x55ed2011a4fb in cmd_execute cmds/commands.h:126
    #7 0x55ed2011bc61 in main /home/adam/btrfs-progs/btrfs.c:469
    #8 0x7f90fec27634  (/usr/lib/libc.so.6+0x27634) (BuildId: 2f722da304c0a508c891285e6840199c35019c8d)
    #9 0x7f90fec276e8 in __libc_start_main (/usr/lib/libc.so.6+0x276e8) (BuildId: 2f722da304c0a508c891285e6840199c35019c8d)
    #10 0x55ed2011a3d4 in _start (/home/adam/btrfs-progs/btrfs+0x873d4) (BuildId: 3a69cb43ff4e39c3dbc079d8086fb9082f21490a)

0x7da0fd9e6100 is located 0 bytes after 4096-byte region [0x7da0fd9e5100,0x7da0fd9e6100)
allocated by thread T0 here:
    #0 0x7f90ff120cb5 in malloc /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55ed202ad012 in get_fs_info_offline cmds/device.c:777
    #2 0x55ed202ade4a in cmd_device_stats cmds/device.c:895
    #3 0x55ed2011a4fb in cmd_execute cmds/commands.h:126
    #4 0x55ed2011ae55 in handle_command_group /home/adam/btrfs-progs/btrfs.c:184
    #5 0x55ed2011a4fb in cmd_execute cmds/commands.h:126
    #6 0x55ed2011bc61 in main /home/adam/btrfs-progs/btrfs.c:469
    #7 0x7f90fec27634  (/usr/lib/libc.so.6+0x27634) (BuildId: 2f722da304c0a508c891285e6840199c35019c8d)
    #8 0x7f90fec276e8 in __libc_start_main (/usr/lib/libc.so.6+0x276e8) (BuildId: 2f722da304c0a508c891285e6840199c35019c8d)
    #9 0x55ed2011a3d4 in _start (/home/adam/btrfs-progs/btrfs+0x873d4) (BuildId: 3a69cb43ff4e39c3dbc079d8086fb9082f21490a)

SUMMARY: AddressSanitizer: heap-buffer-overflow common/string-utils.c:62 in strncpy_null
Shadow bytes around the buggy address:
  0x7da0fd9e5e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7da0fd9e5f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7da0fd9e5f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7da0fd9e6000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7da0fd9e6080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x7da0fd9e6100:[fa]fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7da0fd9e6180: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7da0fd9e6200: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7da0fd9e6280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7da0fd9e6300: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7da0fd9e6380: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
==4929==ABORTING

[CAUSE]
Inside get_fs_info_offline(), we call strncpy_null() to fill
di_args[i].path, but that path array is only BTRFS_DEVICE_PATH_NAME_MAX
sized, and we're passing "BTRFS_DEVICE_PATH_NAME_MAX + 1" as size.

This will make strncpy_null() to always set the last byte to 0, which
triggers the above access beyond boundary.

[FIX]
For that specific caller, just use the size of that array.
We can not change the definition of btrfs_ioctl_dev_info_args, as that
is part of the user API.
But most other structures have already include one extra byte to handle
the terminating zero.

And since we're here, replace all strncpy_null() to use sizeof() as its
size parameter when the target is a fixed size array, to prevent similar
problems from happening.

Most call sites are already doing that, but there are still several
sites using open-coded sizes.

Issue: #1088
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c     | 2 +-
 cmds/device.c             | 5 ++---
 cmds/inspect.c            | 4 ++--
 cmds/replace.c            | 4 ++--
 cmds/subvolume.c          | 4 ++--
 common/filesystem-utils.c | 5 +++--
 convert/source-ext2.c     | 2 +-
 mkfs/common.c             | 2 +-
 mkfs/main.c               | 4 ++--
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 1f73bd57e4b3..b06e85a86829 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -1410,7 +1410,7 @@ int main(int argc, char **argv)
 				inode = arg_strtou64(optarg);
 				break;
 			case 'f':
-				strncpy_null(field, optarg, FIELD_BUF_LEN);
+				strncpy_null(field, optarg, sizeof(field));
 				break;
 			case 'x':
 				file_extent = arg_strtou64(optarg);
diff --git a/cmds/device.c b/cmds/device.c
index 58081c69d05f..168766a47ba2 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -796,7 +796,7 @@ static int get_fs_info_offline(struct btrfs_fs_info *fs_info,
 			 */
 			if (device->name)
 				strncpy_null((char *)di_args[i].path, device->name,
-					     BTRFS_DEVICE_PATH_NAME_MAX + 1);
+					     sizeof(di_args[i].path));
 			i++;
 		}
 	}
@@ -937,8 +937,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 		char path[BTRFS_DEVICE_PATH_NAME_MAX + 1];
 		int err2;
 
-		strncpy_null(path, (char *)di_args[i].path,
-			     BTRFS_DEVICE_PATH_NAME_MAX + 1);
+		strncpy_null(path, (char *)di_args[i].path, sizeof(path));
 
 		args.devid = di_args[i].devid;
 		args.nr_items = BTRFS_DEV_STAT_VALUES_MAX;
diff --git a/cmds/inspect.c b/cmds/inspect.c
index 14a2d7f41727..7b85ac955681 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -259,7 +259,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 			if (name[0] == 0) {
 				path_ptr[-1] = '\0';
 				path_fd = fd;
-				strncpy_null(mount_path, full_path, PATH_MAX);
+				strncpy_null(mount_path, full_path, sizeof(mount_path));
 			} else {
 				char *mounted = NULL;
 				char subvol[PATH_MAX];
@@ -292,7 +292,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 					continue;
 				}
 
-				strncpy_null(mount_path, mounted, PATH_MAX);
+				strncpy_null(mount_path, mounted, sizeof(mount_path));
 				free(mounted);
 
 				path_fd = btrfs_open_dir(mount_path);
diff --git a/cmds/replace.c b/cmds/replace.c
index 8dc7d6af25e4..2c6fb5bce28a 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -267,7 +267,7 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 		}
 	} else if (path_is_block_device(srcdev) > 0) {
 		strncpy_null((char *)start_args.start.srcdev_name, srcdev,
-			     BTRFS_DEVICE_PATH_NAME_MAX + 1);
+			     sizeof(start_args.start.srcdev_name));
 		start_args.start.srcdevid = 0;
 		ret = device_get_partition_size(srcdev, &srcdev_size);
 		if (ret < 0) {
@@ -303,7 +303,7 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	}
 
 	strncpy_null((char *)start_args.start.tgtdev_name, dstdev,
-		     BTRFS_DEVICE_PATH_NAME_MAX + 1);
+		     sizeof(start_args.start.tgtdev_name));
 	ret = btrfs_prepare_device(fddstdev, dstdev, &dstdev_block_count, 0,
 			PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE |
 			(discard ? PREP_DEVICE_DISCARD : 0) |
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index f88c97e7da70..50348fce5295 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -151,9 +151,9 @@ static int create_one_subvolume(const char *dst, struct btrfs_util_qgroup_inheri
 	char *dstdir;
 	enum btrfs_util_error err;
 
-	strncpy_null(dupname, dst, PATH_MAX);
+	strncpy_null(dupname, dst, sizeof(dupname));
 	newname = path_basename(dupname);
-	strncpy_null(dupdir, dst, PATH_MAX);
+	strncpy_null(dupdir, dst, sizeof(dupdir));
 	dstdir = path_dirname(dupdir);
 
 	if (create_parents) {
diff --git a/common/filesystem-utils.c b/common/filesystem-utils.c
index e323e37dac57..331dfb993afc 100644
--- a/common/filesystem-utils.c
+++ b/common/filesystem-utils.c
@@ -104,7 +104,8 @@ static int set_label_unmounted(const char *dev, const char *label)
 		error_msg(ERROR_MSG_START_TRANS, "set label");
 		return PTR_ERR(trans);
 	}
-	strncpy_null(root->fs_info->super_copy->label, label, BTRFS_LABEL_SIZE);
+	strncpy_null(root->fs_info->super_copy->label, label,
+		     sizeof(root->fs_info->super_copy->label));
 
 	btrfs_commit_transaction(trans, root);
 
@@ -125,7 +126,7 @@ static int set_label_mounted(const char *mount_path, const char *labelp)
 	}
 
 	memset(label, 0, sizeof(label));
-	strncpy_null(label, labelp, BTRFS_LABEL_SIZE);
+	strncpy_null(label, labelp, sizeof(label));
 	if (ioctl(fd, BTRFS_IOC_SET_FSLABEL, label) < 0) {
 		error("unable to set label of %s: %m", mount_path);
 		close(fd);
diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index c6a27d48b5e5..647e64411c06 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -659,7 +659,7 @@ static int ext2_copy_single_xattr(struct btrfs_trans_handle *trans,
 		data = databuf;
 		datalen = bufsize;
 	}
-	strncpy_null(namebuf, xattr_prefix_table[name_index], XATTR_NAME_MAX + 1);
+	strncpy_null(namebuf, xattr_prefix_table[name_index], sizeof(namebuf));
 	strncat(namebuf, EXT2_EXT_ATTR_NAME(entry), entry->e_name_len);
 	if (name_len + datalen > BTRFS_LEAF_DATA_SIZE(root->fs_info) -
 	    sizeof(struct btrfs_item) - sizeof(struct btrfs_dir_item)) {
diff --git a/mkfs/common.c b/mkfs/common.c
index 120da07f1374..85cfa60d25aa 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -499,7 +499,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		btrfs_set_super_nr_global_roots(&super, 1);
 
 	if (cfg->label)
-		strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE);
+		strncpy_null(super.label, cfg->label, sizeof(super.label));
 
 	/* create the tree of root objects */
 	memset(buf->data, 0, cfg->nodesize);
diff --git a/mkfs/main.c b/mkfs/main.c
index 422dbcacffdc..15719dd9e30b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1711,7 +1711,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					exit(1);
 				break;
 			case 'U':
-				strncpy_null(fs_uuid, optarg, BTRFS_UUID_UNPARSED_SIZE);
+				strncpy_null(fs_uuid, optarg, sizeof(fs_uuid));
 				break;
 			case 'K':
 				opt_discard = false;
@@ -1731,7 +1731,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				}
 				break;
 			case GETOPT_VAL_DEVICE_UUID:
-				strncpy_null(dev_uuid, optarg, BTRFS_UUID_UNPARSED_SIZE);
+				strncpy_null(dev_uuid, optarg, sizeof(dev_uuid));
 				break;
 			case GETOPT_VAL_SHRINK:
 				shrink_rootdir = true;
-- 
2.52.0


