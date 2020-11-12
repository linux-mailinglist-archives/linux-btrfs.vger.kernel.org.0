Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10102AFF5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 06:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgKLFc3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 00:32:29 -0500
Received: from gateway20.websitewelcome.com ([192.185.55.25]:43149 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728200AbgKLBhF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 20:37:05 -0500
X-Greylist: delayed 1330 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2020 20:37:04 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 88C13400C638D
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 19:12:00 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id d1CNkREk2YLDnd1COkWb6t; Wed, 11 Nov 2020 19:14:52 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LQYfNp4tF4s4+oTN7dn1diEkbUugTCV38k9i9HVR1WM=; b=q50ttnduFuRtYFTjYcncCqOiGR
        YfDJxGI1ChB19D7b0GoxxYCPGuZIXDo2doP8QExme3Tu/47kjuR31qjRV+vGegSXUoNQUVKYAakeF
        c/4Zqvs2nYpFM4oRdU0i0ckLXLSU8XJgtOlqwSpozI7ZG5j4yGKEpiGjOiedKL90qRMJ4+edAH4k6
        /XFFe8WSlYlVt/C0xzp2z5BS3DVCC2840UmCsw378Cc1MgRN1N0Gy1qcXoqZI4hjt9lcnVy3o5mRN
        e4A/dkidXgI7tvHzvUvclJHCHcEcXs0Yf9Bxi2oeaOz+mvoO5TvmGkPFiR1KOap5Spf5r8+CQKm0B
        Z3+ixf7Q==;
Received: from 200.146.50.182.dynamic.dialup.gvt.net.br ([200.146.50.182]:45016 helo=localhost.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1kd1CM-000CUp-F4; Wed, 11 Nov 2020 22:14:51 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs-progs: inspect: Fix logical-resolve by starting the lookup from root_id
Date:   Wed, 11 Nov 2020 22:14:00 -0300
Message-Id: <20201112011400.6866-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 200.146.50.182
X-Source-L: No
X-Exim-ID: 1kd1CM-000CUp-F4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 200.146.50.182.dynamic.dialup.gvt.net.br (localhost.de) [200.146.50.182]:45016
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

logical-resolve is currently broken on systems that have a child
subvolume being mounted without access to the parent subvolume.
This is the default for SLE/openSUSE installations, since we have the
subvolume '@' not being mounted, only it's child subovlumes (var, root, ...).

If we try to look for a file on /var, this happens:

btrfs inspect-internal logical-resolve -v 339570688 /
ioctl ret=0, total_size=4096, bytes_left=4056, bytes_missing=0, cnt=3, missed=0
ERROR: cannot access '//@/var': No such file or directory

Since subvolume '@' isn't mounted, the normal file lookup fails. The fix
in this case is the start the file lookup in the subvolume that contains
the file, and not from the top subvolume of the system.

To not break current subvol_uuid_search_init function calling
btrfs_list_path_for_root, a new argument was added to switch between the
old behavior and the new one. With the fix in place, logical-resolve
works as expected:

btrfs inspect-internal logical-resolve -v 339570688 /
ioctl ret=0, total_size=65536, bytes_left=65496, bytes_missing=0, cnt=3, missed=0
ioctl ret=0, bytes_left=4055, bytes_missing=0 cnt=1, missed=0
//var/log/zypp/history

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 btrfs-list.c        | 11 ++++++++---
 btrfs-list.h        |  2 +-
 cmds/inspect.c      |  2 +-
 common/send-utils.c |  2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/btrfs-list.c b/btrfs-list.c
index 4b95bcdf..abe36da8 100644
--- a/btrfs-list.c
+++ b/btrfs-list.c
@@ -1801,7 +1801,7 @@ int btrfs_list_find_updated_files(int fd, u64 root_id, u64 oldest_gen)
 	return ret;
 }
 
-char *btrfs_list_path_for_root(int fd, u64 root)
+char *btrfs_list_path_for_root(int fd, u64 root, bool full_path)
 {
 	struct root_lookup root_lookup;
 	struct rb_node *n;
@@ -1832,8 +1832,13 @@ char *btrfs_list_path_for_root(int fd, u64 root)
 			break;
 		}
 		if (entry->root_id == root) {
-			ret_path = entry->full_path;
-			entry->full_path = NULL;
+			if (full_path) {
+				ret_path = entry->full_path;
+				entry->full_path = NULL;
+			} else {
+				ret_path = entry->name;
+				entry->name = NULL;
+			}
 		}
 
 		n = rb_prev(n);
diff --git a/btrfs-list.h b/btrfs-list.h
index ea06e663..3043d2ac 100644
--- a/btrfs-list.h
+++ b/btrfs-list.h
@@ -172,7 +172,7 @@ int btrfs_list_subvols_print(int fd, struct btrfs_list_filter_set *filter_set,
 		       const char *raw_prefix);
 int btrfs_list_find_updated_files(int fd, u64 root_id, u64 oldest_gen);
 int btrfs_list_get_default_subvolume(int fd, u64 *default_id);
-char *btrfs_list_path_for_root(int fd, u64 root);
+char *btrfs_list_path_for_root(int fd, u64 root, bool full_path);
 int btrfs_list_get_path_rootid(int fd, u64 *treeid);
 int btrfs_get_subvol(int fd, struct root_info *the_ri);
 int btrfs_get_toplevel_subvol(int fd, struct root_info *the_ri);
diff --git a/cmds/inspect.c b/cmds/inspect.c
index 2530b904..828e38e2 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -236,7 +236,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 		DIR *dirs = NULL;
 
 		if (getpath) {
-			name = btrfs_list_path_for_root(fd, root);
+			name = btrfs_list_path_for_root(fd, root, false);
 			if (IS_ERR(name)) {
 				ret = PTR_ERR(name);
 				goto out;
diff --git a/common/send-utils.c b/common/send-utils.c
index 58eca58f..ddb15261 100644
--- a/common/send-utils.c
+++ b/common/send-utils.c
@@ -657,7 +657,7 @@ int subvol_uuid_search_init(int mnt_fd, struct subvol_uuid_search *s)
 					goto skip;
 
 				path = btrfs_list_path_for_root(mnt_fd,
-					btrfs_search_header_objectid(sh));
+					btrfs_search_header_objectid(sh), true);
 				if (!path)
 					path = strdup("");
 				if (IS_ERR(path)) {
-- 
2.26.2

