Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF70365A61D
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Dec 2022 19:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiLaSsf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 13:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaSsd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 13:48:33 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2106.outbound.protection.outlook.com [40.92.59.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4944D2642
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 10:48:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAojLTQDE02i4D81bXTkTUpgOc6viNdt817PTLTbdE2/so9szZBl5Vhmyp+W59GMH4FIE5Rm9REIv2nuq75mqxgXMsBn0wY+JBjRbEJPeym/o+0U030ntO2wk34Fmai+Abvmf2BmDdAvwQX1LKBbKB11HM5AbgnNpBZAFVmXWSOZy8FTFs4TKwGVdNpE8DsIyGr1tl7zWleRxCbew+ydfHf0EYhaDiNapvP/2JpDCxQAmtAKHAOXhjrherBhUAQtFctz5xsKXvoEMfnMkXOT08zG9JMXPzbZJc8pw88szTXDbwDqQISSp/I7PsfJwQeLqok6em/KWGiJrJPEAPtWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQtFfNU2Yrw+nv2dZmFcezTLoBq7hNXndLEt2JkD9fE=;
 b=Q2npsCz/O6TgFG8XJaLfsElnD7BoyWqwQgjixl8hyZYSYUu85UeKObRLEADCKvMjohZsx+a7TZJDpdnXyNyAs75waIZF6u2YNic0L2mSFKA011I88NrP9AIqbd8o6FkOn7C7svaBHPBp2njL1jn8aUoKPPnnJHq4NCAVx3rht9bHpaxLhsqQvMz/YnZyOSP6MH8qKhwSYQVst/9ueCxmjy5aUumdLjRvU0mkCIZgPFafgxr5MK5lu0XAD2OfN6l+th9fVffyCRMuruCqtu13MqNVP/DnRV9UdIZoLYbjV2UFl2qqK6LQe6EDc21lK57M5MdiTvwKhmkVaKr0bISvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQtFfNU2Yrw+nv2dZmFcezTLoBq7hNXndLEt2JkD9fE=;
 b=br6fKmvhv7UNUDE2pE+jb0u1lKuAuFlmgpB+QZrrbyMX4yHJtRb+01mwZmNAv1AOctwaKkXq4KX4oMxkDKktGgtg5nbyZEPvf2WUqupucqfcwvvBRRaRMrM60D1Vz4cFDXvnpj7g/mlWkuy8pJfP3xfKFu40OHsC7UAgcpGIq6dxoEpItRiaNtzATF+jbBveYxursOKSzFOa0zZSYpNIUMljrCRwjTQEUIQYBld1QEUvdYLQvpnwO47kFEFl1prAQRX6cUz0LpbhbMXQIozreDOf4k8MjXwskSV5VU9CLSKDjrWXDHmuxq2r/B36YteCgFAqxb6GtF3N7bC7jE7wUw==
Received: from PAXP193MB2089.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:226::18)
 by GV1P193MB2277.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:28::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Sat, 31 Dec
 2022 18:48:28 +0000
Received: from PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 ([fe80::9da1:872b:caa3:1379]) by PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 ([fe80::9da1:872b:caa3:1379%5]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 18:48:28 +0000
From:   Siddhartha Menon <siddharthamenon@outlook.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        Siddhartha Menon <siddharthamenon@outlook.com>
Subject: [PATCH 2/2] Fix several style errors in fs/btrfs/inode.c
Date:   Sat, 31 Dec 2022 18:47:49 +0000
Message-ID: <PAXP193MB20897179089B101CFFFB4B7CA7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231184749.28896-1-siddharthamenon@outlook.com>
References: <20221231184749.28896-1-siddharthamenon@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [CcgRbr83s8UVkqmYdLIiYl0dfHOwKke2]
X-ClientProxiedBy: LNXP265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::23) To PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:226::18)
X-Microsoft-Original-Message-ID: <20221231184749.28896-3-siddharthamenon@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB2089:EE_|GV1P193MB2277:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b18b7b-4900-4323-c5e4-08daeb5f9acf
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrKhIkblLwoAe06Ob0ImJmXIGoqjRnYd79pKjFeyxdDxLZJ9h+LgCUhbDNM+srMN3vy+tXClQlyx22ItrL6pH1TyUp9dilC57a/Z4HGlnuRQ+lCdJIaoafk9ykR0zeQLIgsBmt0FqL/6oVzKTM4vCB2uuZ3leSd0fkmydblum4ItHf0GxLG3Zwxh6lMao+F3fPeDSCLVvbeI6nOhrwVnMOK5HegpQuNXTFQGKMibuqrr/kE8YTM18Ci4+GfeoFzbgIxYcR7FZxhVdKx+bf6gBagQkGypZQzruux1IFMYrTaXPaDpVaY/IT3deS8hjunyWPXC4ZCaFw0wWRQX+hiPIvV2gYLknXjDG7rpbIjl5jYkMj4ohPw/QJK4CLfwYLHj9I29zRvtKg/yEH21gRFqldoctBIxoAjoL4iSQPis7iFpa0czv0ZsHH4EZD2DmFCwrq+HT/b/sBzpjVs+n+lmSCBZa9hCXky67tS5bhp+UZfMNYCeJud+7sbhcFs0kklEdRqmaDn+GjoOuwnTdVXQ5on+tUuQn4N+pU0DChIYXG9scZIOI04BL2p6Mm9F1r6bpI+yo3phAjuIyHhJKTypyUMrXlPgogOWW0R7VhKhn8ZVPnDVMFmdB+gKILWiNGQieoHHmtfJLtQS+vcDF3Dt4DWHxRFDgMneDbE2tDGTdSIOEGz1QCb605v76cMjcPLcIm1j8OOJAqbMvbRLIIZzIs05rQFKiRjjP960dVwdoH3haj5HKV0/lifTd/P46hKgLo=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92Z0RbFay900UOSo/0Q8vIRexrXhb2Bmw5BJMtWHYXzEWBGWpLr39ZE4+YRrUBOOh4ebjNnVcLaBqRulgMb7cHrhLR1K7jq16YuUBQkPdM4HPrPCevtR8D/HUft05aDwlf4MvTyAvPDDY7T8crT3OENkcYP3WkVNGUjCtZEVEvCE4d+brLrsykZl9yIgNrgGvtC5SzZLFnUlTr5msjeX7E999J4M/89c56r3QN3MvcquJc5PCD7pIHk30t5p72zFD5C3pus98FcOrs2naNWRmbkBShJhdm0M860fuNG/xyhnRLcw/OKApHoKUfa624Mr8nWfsP2k1emEJMKxxHumWB2+ZsE576wo+t6UcCYj4DSToUEPuI4bEAfGOkiD6dBQ/yJKavd8ocZWeLp0AEp+YWUwf5/dsO64RApWcgbrKp+9kW8DmMQUDghkABVQbOLJLushcxnyA6xDg5ZJX/SJk0NAlNYYzw9yy8GcRqWITu0P0suHhkLulU/ODhh/D2Z60oNfmPKoBh8jst1p9w55GbwOVBXwQMt9yTS4rnMg2um0qnPiIrFmADeifEDZsH5q2K4SSuosC9C6Spps0zWiUC/VCcrr87zrozxjJ2+Ae74RIAmvu+1fmk2fW2aXgEJHfW5gQZs/Xq6pdaRaZKxm4GtDN2LR0UDPCzEntnsn588=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jAoZuxnH7I+dPt60HGsqI59WQ3BVRW/Zzgui4M8sypft+AK/dLfeitXzOmmL?=
 =?us-ascii?Q?V8xpTPofNsxhTkVHV4XrjHodIbaR7fy4zTugcLWSLBRGT2ACDlikP8OlV3eC?=
 =?us-ascii?Q?0SwMZI/Nb8ekALs8laYTi+NBRTAFH3Rj6mgpy32rks3pmktjivR/rRFArMT9?=
 =?us-ascii?Q?fSoHm9BofrXtZK8qzt+ojjTGtV+g4RSqNuFNMaA/lk25bRLN4hUYYuPo0c2N?=
 =?us-ascii?Q?OW6/LLOmyBWVBU/DMxQ4fco+8M/MotMxkT2uvQ2El6rcSiyUd0jUYEeNkM8n?=
 =?us-ascii?Q?xDUatYb6669pMRdmNdeyp1Y26CVnj+YoLuFOVwK0FKzEjhUwIKk1E9oY5s7Y?=
 =?us-ascii?Q?61Jrg1wmCTax3Dlwem36ig+c7AIm8p4q0JgYVa25VHGytQiL2ujcB2kbXS0E?=
 =?us-ascii?Q?TnYaRxOWdM5BLsCxCVSsNfbVNGp8qjrq/AcUA+TPb1ZzlzEVfPYx+1dcZALw?=
 =?us-ascii?Q?JnIDd8NYAD9gmIS6Gkmq+cUOOFyI7GmMxc+JWk4/uvSLDXY+tcVZV/hC4W/O?=
 =?us-ascii?Q?cEIRiOV/lc6CP0mm1+79JMLkQhw0vG2LD5rrvucM72erjtV9GBvO33S0OfZg?=
 =?us-ascii?Q?8A0b2EXiigutuSHQWTtCx0XF0WLa017IqKDQCJitcBsw1VRWPDEbnZtRQo1X?=
 =?us-ascii?Q?Va78xTQZCEJBtTDplUj0IrfHQKpY8OqjHbylmcpuJV+Il1KLeAXrZheSGyd6?=
 =?us-ascii?Q?O8hHjzXgVTWc3dX9vHDjd8CmkPgUEclpReLK3UrxD0iY/w4DUdlFa8DPcdc0?=
 =?us-ascii?Q?atS6r1Eika857ZwpVHRs3qFCLl8NWLXaitrn8bAxAzH4QKHKvKIbo7ZKziRe?=
 =?us-ascii?Q?7X3ChPTvm0ObhSi2CfZ5nQaz4sY7MFEA8UZfPJ/iAcsn9kzHAUDdq5/d+7bG?=
 =?us-ascii?Q?nD1+bvIVJY5Vi8TBpziuRSvTwZiXC9MaXDn/eJtWYoMJsXxdfJ9Y+SLOIgtG?=
 =?us-ascii?Q?cJyFbrvtI+uJvpWL9yF6Keh9lvz4tj8XBGAje1C3tshI8xM7PLFcvV+gfy6e?=
 =?us-ascii?Q?pkR1zHjqmfiDVLN9jvc/hDcK5usjTR1AzPRpjblauXUB3stp1pUv44lA3rce?=
 =?us-ascii?Q?DtTNGgQlZ4b+mORJ6sL3PeOwhsruS4UUFgASiIEZitOWiNvhLgDFUh3LV+pS?=
 =?us-ascii?Q?8cohcCuG6gTL5/S4VUxCsVmQ0oncT6t1bpNUzAgqs9ihDwdOqJEeA+0mqILo?=
 =?us-ascii?Q?T+7kCOUzEsIzAu6ec3U61LV9Hi8Qhaj9Zj/UYvdrsbIAaK6XxMu7B0LSMVHQ?=
 =?us-ascii?Q?pzXpuHY/2kS3B8rSSvQXsMqWrMjOojEXk7XU5DbXgFyy911RgnqbRFiAHTCg?=
 =?us-ascii?Q?Ieg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b18b7b-4900-4323-c5e4-08daeb5f9acf
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 18:48:27.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2277
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Siddhartha Menon <siddharthamenon@outlook.com>
---
 fs/btrfs/inode.c | 49 +++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cb95d47e4d02..ee7ca0e69aa1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -366,6 +366,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		struct page *cpage;
 		int i = 0;
+
 		while (compressed_size > 0) {
 			cpage = compressed_pages[i];
 			cur_size = min_t(unsigned long, compressed_size,
@@ -1221,7 +1222,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	u64 blocksize = fs_info->sectorsize;
 	struct btrfs_key ins;
 	struct extent_map *em;
-	unsigned clear_bits;
+	unsigned int clear_bits;
 	unsigned long page_ops;
 	bool extent_reserved = false;
 	int ret = 0;
@@ -1557,7 +1558,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	u64 num_chunks = DIV_ROUND_UP(end - start, SZ_512K);
 	int i;
 	bool should_compress;
-	unsigned nofs_flag;
+	unsigned int nofs_flag;
 	const blk_opf_t write_flags = wbc_to_write_flags(wbc);
 
 	unlock_extent(&inode->io_tree, start, end, NULL);
@@ -1575,7 +1576,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	memalloc_nofs_restore(nofs_flag);
 
 	if (!ctx) {
-		unsigned clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC |
+		unsigned int clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC |
 			EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 			EXTENT_DO_ACCOUNTING;
 		unsigned long page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK |
@@ -3846,7 +3847,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 				ret = PTR_ERR(trans);
 				goto out;
 			}
-			btrfs_debug(fs_info, "auto deleting %Lu",
+			btrfs_debug(fs_info, "auto deleting %llu",
 				    found_key.objectid);
 			ret = btrfs_del_orphan_item(trans, root,
 						    found_key.objectid);
@@ -3892,8 +3893,8 @@ static noinline int acls_after_inode_item(struct extent_buffer *leaf,
 {
 	u32 nritems = btrfs_header_nritems(leaf);
 	struct btrfs_key found_key;
-	static u64 xattr_access = 0;
-	static u64 xattr_default = 0;
+	static u64 xattr_access;
+	static u64 xattr_default;
 	int scanned = 0;
 
 	if (!xattr_access) {
@@ -4920,7 +4921,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	bool only_release_metadata = false;
 	u32 blocksize = fs_info->sectorsize;
 	pgoff_t index = from >> PAGE_SHIFT;
-	unsigned offset = from & (blocksize - 1);
+	unsigned int offset = from & (blocksize - 1);
 	struct page *page;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
 	size_t write_bytes = blocksize;
@@ -5358,7 +5359,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		struct extent_state *cached_state = NULL;
 		u64 start;
 		u64 end;
-		unsigned state_flags;
+		unsigned int state_flags;
 
 		node = rb_first(&io_tree->state);
 		state = rb_entry(node, struct extent_state, rb_node);
@@ -5842,7 +5843,7 @@ static struct inode *new_simple_dir(struct super_block *s,
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_opflags &= ~IOP_XATTR;
 	inode->i_fop = &simple_dir_operations;
-	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
+	inode->i_mode = 0755;
 	inode->i_mtime = current_time(inode);
 	inode->i_atime = inode->i_mtime;
 	inode->i_ctime = inode->i_mtime;
@@ -5983,7 +5984,7 @@ static int btrfs_opendir(struct inode *inode, struct file *file)
 struct dir_entry {
 	u64 ino;
 	u64 offset;
-	unsigned type;
+	unsigned int type;
 	int name_len;
 };
 
@@ -6667,9 +6668,11 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	if (unlikely(ino == BTRFS_FIRST_FREE_OBJECTID)) {
 		u64 local_index;
 		int err;
+
 		err = btrfs_del_root_ref(trans, key.objectid,
 					 root->root_key.objectid, parent_ino,
 					 &local_index, name);
+
 		if (err)
 			btrfs_abort_transaction(trans, err);
 	} else if (add_backref) {
@@ -8930,20 +8933,20 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 
 	while (1) {
 		ordered = btrfs_lookup_first_ordered_extent(inode, (u64)-1);
+
 		if (!ordered)
 			break;
-		else {
-			btrfs_err(root->fs_info,
-				  "found ordered extent %llu %llu on inode cleanup",
-				  ordered->file_offset, ordered->num_bytes);
 
-			if (!freespace_inode)
-				btrfs_lockdep_acquire(root->fs_info, btrfs_ordered_extent);
+		btrfs_err(root->fs_info,
+			  "found ordered extent %llu %llu on inode cleanup",
+			  ordered->file_offset, ordered->num_bytes);
 
-			btrfs_remove_ordered_extent(inode, ordered);
-			btrfs_put_ordered_extent(ordered);
-			btrfs_put_ordered_extent(ordered);
-		}
+		if (!freespace_inode)
+			btrfs_lockdep_acquire(root->fs_info, btrfs_ordered_extent);
+
+		btrfs_remove_ordered_extent(inode, ordered);
+		btrfs_put_ordered_extent(ordered);
+		btrfs_put_ordered_extent(ordered);
 	}
 	btrfs_qgroup_check_reserved_leak(inode);
 	inode_tree_del(inode);
@@ -9357,10 +9360,10 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	if (ret) {
 		if (ret == -EEXIST) {
 			/* we shouldn't get
-			 * eexist without a new_inode */
-			if (WARN_ON(!new_inode)) {
+			 * eexist without a new_inode
+			 */
+			if (WARN_ON(!new_inode))
 				goto out_fscrypt_names;
-			}
 		} else {
 			/* maybe -EOVERFLOW */
 			goto out_fscrypt_names;
-- 
2.39.0

