Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38FA242DC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 19:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgHLRCI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 13:02:08 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.222]:20837 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726503AbgHLRCH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 13:02:07 -0400
X-Greylist: delayed 1488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 13:02:06 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id E311913044E9
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 11:37:14 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 5tkYk2dcIBD8b5tkYkankf; Wed, 12 Aug 2020 11:37:14 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pO77dVds1g9gtkb3TWWO4PVsOHRc//6M3zgKr1rAC04=; b=D+kVlanrCxqvyWgGb5EDeChJzQ
        RpifXx5/cuOURJt+JQ1+QTmXN2fQKBrgVau4W0nt18VAe8J/Sv8KxSOwdKzpSpzwl7ddwPUYmQN+h
        BwlqsUtizSQWArrVp9SlQHVqF40ZAkBV6OzuylsZaYX6nkS+TeTh5FE5Wck6NhnIwMjQy74+HNV3Z
        q0LcQCc+y+tGt1P2ByVWfEJNgrOFb4dXp4h+QzMkCnOB6U68x3lATNNuNuY65DJBnYkqjN88w439c
        zLFDVgsNAHaWPJf2rMBGS+zx7iW54Ct/fvch3IdtJkQLHFiTiPx8arS6loP1j9PKLdvQ3sV5z9H2T
        nq8lNKpw==;
Received: from [179.185.221.211] (port=55300 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k5tkY-004J9r-Ct; Wed, 12 Aug 2020 13:37:14 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [RFC PATCH 1/8] btrfs: fs_context: Add initial fscontext parameters
Date:   Wed, 12 Aug 2020 13:36:47 -0300
Message-Id: <20200812163654.17080-2-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812163654.17080-1-marcos@mpdesouza.com>
References: <20200812163654.17080-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.221.211
X-Source-L: No
X-Exim-ID: 1k5tkY-004J9r-Ct
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.221.211]:55300
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 5
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

The same old parameters but now using the fs_parameter_spec form. As
the fscontext has a flag_no variant we don't need to map the Opt_no*
version of the same flags.

Opt_fragment is added as a generic entry point for all fragment type to
be used only in fscontext argument parser.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/super.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 53639de3a064..4e6654af90ea 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -6,6 +6,7 @@
 #include <linux/blkdev.h>
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_parser.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/time.h>
@@ -370,6 +371,7 @@ enum {
 	Opt_check_integrity_print_mask,
 	Opt_enospc_debug, Opt_noenospc_debug,
 #ifdef CONFIG_BTRFS_DEBUG
+	Opt_fragment,
 	Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
@@ -458,6 +460,65 @@ static const match_table_t rescue_tokens = {
 	{Opt_err, NULL},
 };
 
+static const struct fs_parameter_spec btrfs_fs_parameters[] = {
+	fsparam_flag_no("acl", Opt_acl),
+	fsparam_flag_no("autodefrag", Opt_defrag),
+	fsparam_flag_no("barrier", Opt_barrier),
+	fsparam_flag("clear_cache", Opt_clear_cache),
+	fsparam_u32("commit", Opt_commit_interval),
+	fsparam_flag("compress", Opt_compress),
+	fsparam_string("compress", Opt_compress_type),
+	fsparam_flag("compress-force", Opt_compress_force),
+	fsparam_string("compress-force", Opt_compress_force_type),
+	fsparam_flag_no("datacow", Opt_datacow),
+	fsparam_flag_no("datasum", Opt_datasum),
+	fsparam_flag("degraded", Opt_degraded),
+	fsparam_string("device", Opt_device),
+	fsparam_flag_no("discard", Opt_discard),
+	fsparam_string("discard", Opt_discard_mode),
+	fsparam_string("fatal_errors", Opt_fatal_errors),
+	fsparam_flag_no("flushoncommit", Opt_flushoncommit),
+	fsparam_flag_no("inode_cache", Opt_inode_cache),
+	fsparam_string("max_inline", Opt_max_inline),
+	fsparam_u32("metadata_ratio", Opt_ratio),
+	fsparam_flag("norecovery", Opt_norecovery),
+	fsparam_flag("rescan_uuid_tree", Opt_rescan_uuid_tree),
+	fsparam_flag("skip_balance", Opt_skip_balance),
+	fsparam_flag_no("space_cache", Opt_space_cache),
+	fsparam_string("space_cache", Opt_space_cache_version),
+	fsparam_string("subvol", Opt_subvol),
+	fsparam_u64("subvolid", Opt_subvolid),
+	fsparam_flag_no("ssd", Opt_ssd),
+	fsparam_flag_no("ssd_spread", Opt_ssd_spread),
+	fsparam_u32("thread_pool", Opt_thread_pool),
+	fsparam_flag_no("treelog", Opt_treelog),
+	fsparam_flag("user_subvol_rm_allowed", Opt_user_subvol_rm_allowed),
+
+	/* Debugging options */
+	fsparam_flag("check_int", Opt_check_integrity),
+	fsparam_flag("check_int_data", Opt_check_integrity_including_extent_data),
+	fsparam_u32("check_int_print_mask", Opt_check_integrity_print_mask),
+
+	/* Rescue options */
+	fsparam_string("rescue", Opt_rescue),
+	/* Deprecated, with alias rescue=nologreplay */
+	fsparam_flag("nologreplay", Opt_nologreplay),
+	/* Deprecated, with alias rescue=usebackuproot */
+	fsparam_flag("usebackuproot", Opt_usebackuproot),
+
+	/* Deprecated options */
+	fsparam_flag("recovery", Opt_recovery),
+	fsparam_flag_no("enospc_debug", Opt_enospc_debug),
+
+ #ifdef CONFIG_BTRFS_DEBUG
+	fsparam_string("fragment", Opt_fragment),
+ #endif
+ #ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	fsparam_flag("ref_verify", Opt_ref_verify),
+ #endif
+	{}
+};
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -2269,6 +2330,7 @@ static struct file_system_type btrfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "btrfs",
 	.mount		= btrfs_mount,
+	.parameters	= btrfs_fs_parameters,
 	.kill_sb	= btrfs_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
 };
@@ -2277,6 +2339,7 @@ static struct file_system_type btrfs_root_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
+	.parameters	= btrfs_fs_parameters,
 	.kill_sb	= btrfs_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
 };
-- 
2.28.0

