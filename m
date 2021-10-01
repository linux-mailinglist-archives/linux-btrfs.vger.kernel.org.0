Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F185441F144
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 17:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhJAPbR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 11:31:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59134 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355026AbhJAPbF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Oct 2021 11:31:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0166022626;
        Fri,  1 Oct 2021 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633102157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAVUt/bzGxxw0gCH1uSZsKAfbjlEf2IncfGEjbjqjO0=;
        b=Miad5ZCBJ4rDOSFc6cPvdsMHAYUI/s8pkHyD4as0g/XDxNidlVMSKVLonrHtkiXA6IHdAU
        pY93wVnx0tGu3qO1BY2JbKqogXcaVBVHKpdZY3DAOE6APK0zq7K8h/BDDGgYjZU5YN+LBo
        JnEjn49FYEm8dtZOsh0GkbIOtlIqC/I=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EED06A3B91;
        Fri,  1 Oct 2021 15:29:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80994DA7F3; Fri,  1 Oct 2021 17:28:59 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs-progs: dump-tree: print complete root_item
Date:   Fri,  1 Oct 2021 17:28:59 +0200
Message-Id: <8943d4f62ac4093d6b4178cf073f986a85fe7ab2.1633101904.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633101904.git.dsterba@suse.com>
References: <cover.1633101904.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The output of root_item in the 'inspect dump-tree' command lacks some
items and some of them are printed conditionally. As the dump utility
is for debugging, it's better to print all the items, with names
matching the structure members and order.

Some values will inevitably be all zeros like uuids or various
timestamps, but that's a minor issue and affecting only a few trees.

Example:

  item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
	  generation 5 root_dirid 0 bytenr 30523392 byte_limit 0 bytes_used 16384
	  last_snapshot 0 flags 0x0(none) refs 1
	  drop_progress key (0 UNKNOWN.0 0) drop_level 0
	  level 0 generation_v2 5
	  uuid 00000000-0000-0000-0000-000000000000
	  parent_uuid 00000000-0000-0000-0000-000000000000
	  received_uuid 00000000-0000-0000-0000-000000000000
	  ctransid 0 otransid 0 stransid 0 rtransid 0
	  ctime 0.0 (1970-01-01 01:00:00)
	  otime 0.0 (1970-01-01 01:00:00)
	  stime 0.0 (1970-01-01 01:00:00)
	  rtime 0.0 (1970-01-01 01:00:00)

  item 3 key (FS_TREE ROOT_ITEM 0) itemoff 14949 itemsize 439
	  generation 4 root_dirid 256 bytenr 30408704 byte_limit 0 bytes_used 16384
	  last_snapshot 0 flags 0x0(none) refs 1
	  drop_progress key (0 UNKNOWN.0 0) drop_level 0
	  level 0 generation_v2 4
	  uuid ec4669b6-6d21-46ab-857e-d60cafde45b3
	  parent_uuid 00000000-0000-0000-0000-000000000000
	  received_uuid 00000000-0000-0000-0000-000000000000
	  ctransid 0 otransid 0 stransid 0 rtransid 0
	  ctime 1633021823.0 (2021-09-30 19:10:23)
	  otime 1633021823.0 (2021-09-30 19:10:23)
	  stime 0.0 (1970-01-01 01:00:00)
	  rtime 0.0 (1970-01-01 01:00:00)

Signed-off-by: David Sterba <dsterba@suse.com>
---
 kernel-shared/print-tree.c | 53 ++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index e5d4b453fc07..5668fd7873db 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -591,55 +591,46 @@ static void print_root_item(struct extent_buffer *leaf, int slot)
 	read_extent_buffer(leaf, &root_item, (unsigned long)ri, len);
 	root_flags_to_str(btrfs_root_flags(&root_item), flags_str);
 
-	printf("\t\tgeneration %llu root_dirid %llu bytenr %llu level %hhu refs %u\n",
+	printf("\t\tgeneration %llu root_dirid %llu bytenr %llu byte_limit %llu bytes_used %llu\n",
 		(unsigned long long)btrfs_root_generation(&root_item),
 		(unsigned long long)btrfs_root_dirid(&root_item),
 		(unsigned long long)btrfs_root_bytenr(&root_item),
-		btrfs_root_level(&root_item),
-		btrfs_root_refs(&root_item));
-	printf("\t\tlastsnap %llu byte_limit %llu bytes_used %llu flags 0x%llx(%s)\n",
-		(unsigned long long)btrfs_root_last_snapshot(&root_item),
 		(unsigned long long)btrfs_root_limit(&root_item),
-		(unsigned long long)btrfs_root_used(&root_item),
+		(unsigned long long)btrfs_root_used(&root_item));
+	printf("\t\tlast_snapshot %llu flags 0x%llx(%s) refs %u\n",
+		(unsigned long long)btrfs_root_last_snapshot(&root_item),
 		(unsigned long long)btrfs_root_flags(&root_item),
-		flags_str);
+		flags_str,
+		btrfs_root_refs(&root_item));
+	btrfs_disk_key_to_cpu(&drop_key, &root_item.drop_progress);
+	printf("\t\tdrop_progress ");
+	btrfs_print_key(&root_item.drop_progress);
+	printf(" drop_level %hhu\n", root_item.drop_level);
+
+	printf("\t\tlevel %hhu generation_v2 %llu\n",
+		btrfs_root_level(&root_item), root_item.generation_v2);
 
 	if (root_item.generation == root_item.generation_v2) {
 		uuid_unparse(root_item.uuid, uuid_str);
 		printf("\t\tuuid %s\n", uuid_str);
-		if (!empty_uuid(root_item.parent_uuid)) {
-			uuid_unparse(root_item.parent_uuid, uuid_str);
-			printf("\t\tparent_uuid %s\n", uuid_str);
-		}
-		if (!empty_uuid(root_item.received_uuid)) {
-			uuid_unparse(root_item.received_uuid, uuid_str);
-			printf("\t\treceived_uuid %s\n", uuid_str);
-		}
-		if (root_item.ctransid) {
-			printf("\t\tctransid %llu otransid %llu stransid %llu rtransid %llu\n",
+		uuid_unparse(root_item.parent_uuid, uuid_str);
+		printf("\t\tparent_uuid %s\n", uuid_str);
+		uuid_unparse(root_item.received_uuid, uuid_str);
+		printf("\t\treceived_uuid %s\n", uuid_str);
+		printf("\t\tctransid %llu otransid %llu stransid %llu rtransid %llu\n",
 				btrfs_root_ctransid(&root_item),
 				btrfs_root_otransid(&root_item),
 				btrfs_root_stransid(&root_item),
 				btrfs_root_rtransid(&root_item));
-		}
-		if (btrfs_timespec_sec(leaf, btrfs_root_ctime(ri)))
-			print_timespec(leaf, btrfs_root_ctime(ri),
+		print_timespec(leaf, btrfs_root_ctime(ri),
 					"\t\tctime ", "\n");
-		if (btrfs_timespec_sec(leaf, btrfs_root_otime(ri)))
-			print_timespec(leaf, btrfs_root_otime(ri),
+		print_timespec(leaf, btrfs_root_otime(ri),
 					"\t\totime ", "\n");
-		if (btrfs_timespec_sec(leaf, btrfs_root_stime(ri)))
-			print_timespec(leaf, btrfs_root_stime(ri),
+		print_timespec(leaf, btrfs_root_stime(ri),
 					"\t\tstime ", "\n");
-		if (btrfs_timespec_sec(leaf, btrfs_root_rtime(ri)))
-			print_timespec(leaf, btrfs_root_rtime(ri),
+		print_timespec(leaf, btrfs_root_rtime(ri),
 					"\t\trtime ", "\n");
 	}
-
-	btrfs_disk_key_to_cpu(&drop_key, &root_item.drop_progress);
-	printf("\t\tdrop ");
-	btrfs_print_key(&root_item.drop_progress);
-	printf(" level %hhu\n", root_item.drop_level);
 }
 
 static void print_free_space_header(struct extent_buffer *leaf, int slot)
-- 
2.33.0

