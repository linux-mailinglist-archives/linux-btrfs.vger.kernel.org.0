Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA68321B73
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 16:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhBVPay (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 10:30:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:42042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231577AbhBVPaR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 10:30:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7C5DAC69
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 15:29:30 +0000 (UTC)
Date:   Mon, 22 Feb 2021 09:29:45 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: Improve default explanation in man page
Message-ID: <20210222152945.xt7w5ldajsv5ehlg@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The manpage mentions defaults as on or off. This does not explicitly
explain which setting is on, especially in tri-state or more settings.

Change defaults to explain which settings are chosen by default.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
index e5edbe53..e64c4f1c 100644
--- a/Documentation/btrfs-man5.asciidoc
+++ b/Documentation/btrfs-man5.asciidoc
@@ -42,7 +42,7 @@ have been applied.
 
 *acl*::
 *noacl*::
-(default: on)
+(default: acl)
 +
 Enable/disable support for Posix Access Control Lists (ACLs).  See the
 `acl`(5) manual page for more information about ACLs.
@@ -52,7 +52,7 @@ mount fails if 'acl' is requested but the feature is not compiled in.
 
 *autodefrag*::
 *noautodefrag*::
-(since: 3.0, default: off)
+(since: 3.0, default: noautodefrag)
 +
 Enable automatic file defragmentation.
 When enabled, small random writes into files (in a range of tens of kilobytes,
@@ -72,7 +72,7 @@ broken up reflinks.
 
 *barrier*::
 *nobarrier*::
-(default: on)
+(default: barrier)
 +
 Ensure that all IO write operations make it through the device cache and are stored
 permanently when the filesystem is at its consistency checkpoint. This
@@ -131,7 +131,7 @@ seconds (5 minutes). Use with care.
 *compress='type[:level]'*::
 *compress-force*::
 *compress-force='type[:level]'*::
-(default: off, level support since: 5.1)
+(default: compress=no, level support since: 5.1)
 +
 Control BTRFS file data compression.  Type may be specified as 'zlib',
 'lzo', 'zstd' or 'no' (for no compression, used for remounting).  If no type
@@ -159,7 +159,7 @@ NOTE: If compression is enabled, 'nodatacow' and 'nodatasum' are disabled.
 
 *datacow*::
 *nodatacow*::
-(default: on)
+(default: datacow)
 +
 Enable data copy-on-write for newly created files.
 'Nodatacow' implies 'nodatasum', and disables 'compression'. All files created
@@ -173,7 +173,7 @@ at the cost of potential partial writes, in case the write is interrupted
 
 *datasum*::
 *nodatasum*::
-(default: on)
+(default: datasum)
 +
 Enable data checksumming for newly created files.
 'Datasum' implies 'datacow', ie. the normal mode of operation. All files created
@@ -221,7 +221,7 @@ system at that point.
 *discard=sync*::
 *discard=async*::
 *nodiscard*::
-(default: off, async support since: 5.6)
+(default: nodiscard, async support since: 5.6)
 +
 Enable discarding of freed file blocks.  This is useful for SSD devices, thinly
 provisioned LUNs, or virtual machine images; however, every storage layer must
@@ -246,7 +246,7 @@ of actually discarding the blocks.
 
 *enospc_debug*::
 *noenospc_debug*::
-(default: off)
+(default: noenospc_debug)
 +
 Enable verbose output for some ENOSPC conditions. It's safe to use but can
 be noisy if the system reaches near-full state.
@@ -267,7 +267,7 @@ parameters, eg. 'panic', 'oops' or 'crashkernel'.
 
 *flushoncommit*::
 *noflushoncommit*::
-(default: off)
+(default: noflushoncommit)
 +
 This option forces any data dirtied by a write in a prior transaction to commit
 as part of the current commit, effectively a full filesystem sync.
@@ -290,7 +290,7 @@ option 'BTRFS_DEBUG' is not enabled.
 
 *inode_cache*::
 *noinode_cache*::
-(since: 3.0, default: off)
+(since: 3.0, default: noinode_cache)
 +
 Enable free inode number caching. Not recommended to use unless files on your
 filesystem get assigned inode numbers that are approaching 2^64^. Normally, new
@@ -313,7 +313,7 @@ Alternatively, files with high inode numbers can be copied to a new subvolume
 which will effectively start the inode numbers from the beginning again.
 
 *nologreplay*::
-(default: off, even read-only)
+(default: logreplay, even read-only)
 +
 The tree-log contains pending updates to the filesystem until the full commit.
 The log is replayed on next mount, this can be disabled by this option.  See

-- 
Goldwyn
