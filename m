Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2BC185E39
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 16:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgCOPco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 11:32:44 -0400
Received: from smtp-16-i2.italiaonline.it ([213.209.12.16]:41983 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728816AbgCOPcn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 11:32:43 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Mar 2020 11:32:31 EDT
Received: from venice.bhome ([84.220.24.82])
        by smtp-16.iol.local with ESMTPA
        id DV7vj4MthjfNYDV7wjCbpr; Sun, 15 Mar 2020 16:24:33 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584285873; bh=jt4w6dnkYpUSOWK1tfEb9bJ7lprFoGEX960VOPw0JNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=e9s5VOgRxlUOhJlfYd2ljeEQrSstX4KfMry+3FRrLv3gPMEAdLQBo6+fl2ob9MEo3
         CDnbLxAtlyDoCtn+qa6mHD9BTao3y75gv3WQe1H2tsEiElzlyTdQmC7sILGoLY64Sr
         2vCCYFVBjyLdM50Zn+XwTAi8t5byfd2FVAZ9VIjZ8yGXjbu5OuGW5oXZQ0EG9XztPn
         bU5nDyaFE2N8GhhgEkQRV3f2JXSorx0C/MFKitYblR/nyqNyphpssEEIk3y8rfAUsh
         9fUx0q3TjDxGv4Q26u06e+U7kgJpYp3KJS4yGMBO10vU6BSKXaTDBPr0zkk1jF8sdm
         CEFDs3S3gpQ8A==
X-CNFS-Analysis: v=2.3 cv=BYemLYl2 c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=1WsdxQMWwRht6XdyZ4EA:9
 a=xiANsDrqc5mZMDCf:21 a=PsMQUIXzGfD6g5LT:21
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/3] btrfs-progs: use the new ioctl BTRFS_IOC_GET_CHUNK_INFO
Date:   Sun, 15 Mar 2020 16:24:30 +0100
Message-Id: <20200315152430.7532-4-kreijack@libero.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200315152430.7532-1-kreijack@libero.it>
References: <20200315152430.7532-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNTHOy5OmWbwdQh/RMuxvxQ5oWlbuKHBXOemcpF83qeQ24OqQGcIAtyr1qJ5/qWfFbh7bg7wYK1djFfFwA0RpVNrQjL4OcAWTuvr3YVonwHHvLuFBwVs
 kcQii1XIBv32w9blOnP+PFucAOGsAGUKWp3z5VBQkEP0F+KtnvZ8DNoWM0lBe38mlD9qD4jrHpix/OR6wxwp/iFgnQjyCcz2RfPWNwQlcXDywOM2EnXKyASG
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Use the new ioctl BTRFS_IOC_GET_CHUNK_INFO in load_chunk_info() instead of
the BTRFS_IOC_TREE_SEARCH. The old method is still present as fallback for
compatibility reason.

The goal is to avoid BTRFS_IOC_TREE_SEARCH because it requires root
privileges.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 cmds/filesystem-usage.c | 108 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 3 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index aa7065d5..79792ee1 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -39,7 +39,7 @@
 /*
  * Add the chunk info to the chunk_info list
  */
-static int add_info_to_list(struct chunk_info **info_ptr,
+static int legacy_add_info_to_list(struct chunk_info **info_ptr,
 			int *info_count,
 			struct btrfs_chunk *chunk)
 {
@@ -130,7 +130,8 @@ static int cmp_chunk_info(const void *a, const void *b)
 		((struct chunk_info *)b)->type);
 }
 
-static int load_chunk_info(int fd, struct chunk_info **info_ptr, int *info_count)
+static int legacy_load_chunk_info(int fd, struct chunk_info **info_ptr,
+					int *info_count)
 {
 	int ret;
 	struct btrfs_ioctl_search_args args;
@@ -182,7 +183,7 @@ static int load_chunk_info(int fd, struct chunk_info **info_ptr, int *info_count
 			off += sizeof(*sh);
 			item = (struct btrfs_chunk *)(args.buf + off);
 
-			ret = add_info_to_list(info_ptr, info_count, item);
+			ret = legacy_add_info_to_list(info_ptr, info_count, item);
 			if (ret) {
 				*info_ptr = NULL;
 				return 1;
@@ -215,6 +216,107 @@ static int load_chunk_info(int fd, struct chunk_info **info_ptr, int *info_count
 	return 0;
 }
 
+/*
+ * Add the chunk info to the chunk_info list
+ */
+static int add_info_to_list(struct chunk_info **info_ptr,
+			int *info_count,
+			struct btrfs_chunk_info *chunk)
+{
+
+	u64 type = chunk->type;
+	u64 size = chunk->length;
+	int num_stripes = chunk->num_stripes;
+	int j;
+
+	for (j = 0 ; j < num_stripes ; j++) {
+		int i;
+		struct chunk_info *p = NULL;
+		u64    devid;
+
+		devid = chunk->stripes[j].devid;
+
+		for (i = 0 ; i < *info_count ; i++)
+			if ((*info_ptr)[i].type == type &&
+			    (*info_ptr)[i].devid == devid &&
+			    (*info_ptr)[i].num_stripes == num_stripes) {
+				p = (*info_ptr) + i;
+				break;
+			}
+
+		if (!p) {
+			int tmp = sizeof(struct btrfs_chunk) *
+						(*info_count + 1);
+			struct chunk_info *res = realloc(*info_ptr, tmp);
+
+			if (!res) {
+				free(*info_ptr);
+				error("not enough memory");
+				return -ENOMEM;
+			}
+
+			*info_ptr = res;
+			p = res + *info_count;
+			(*info_count)++;
+
+			p->devid = devid;
+			p->type = type;
+			p->size = 0;
+			p->num_stripes = num_stripes;
+		}
+
+		p->size += size;
+
+	}
+
+	return 0;
+
+}
+
+static int load_chunk_info(int fd, struct chunk_info **info_ptr,
+				int *info_count)
+{
+
+	char buf[4096];
+	struct btrfs_ioctl_chunk_info *bici =
+		(struct btrfs_ioctl_chunk_info *)buf;
+	int cont;
+
+	bici->buf_size = sizeof(buf);
+	bici->offset = (u64)0;
+
+	do {
+		int i;
+		struct btrfs_chunk_info *ci;
+		int ret;
+
+		cont = false;
+		ret = ioctl(fd, BTRFS_IOC_GET_CHUNK_INFO, bici);
+		if (ret < 0) {
+			int e = errno;
+
+			if (e == ENOTTY)
+				return legacy_load_chunk_info(fd, info_ptr,
+								info_count);
+			else if (e == EAGAIN)
+				cont = true;
+			else
+				return -e;
+		}
+
+		ci = btrfs_first_chunk_info(bici);
+		for (i = 0 ; i < bici->items_count ; i++) {
+			add_info_to_list(info_ptr, info_count, ci);
+			ci = btrfs_next_chunk_info(ci);
+		}
+
+	} while (cont);
+
+	qsort(*info_ptr, *info_count, sizeof(struct chunk_info),
+		cmp_chunk_info);
+
+	return 0;
+}
 /*
  * Helper to sort the struct btrfs_ioctl_space_info
  */
-- 
2.25.1

