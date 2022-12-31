Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D5365A51C
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Dec 2022 15:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiLaOla (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 09:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaOl1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 09:41:27 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2013.outbound.protection.outlook.com [40.92.91.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51F71098;
        Sat, 31 Dec 2022 06:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TR517TMHCthZV1yYqYtCjfY3MhZBNFeKnxa9Th0FvsKSVdgZW+lrpnW0jH1P8qn5247qwQcquTJ/2Kef4bOdAiSq7ZcfxqRjpTlBoIU8LKl+3UeupnrryvpXLRzfiyEoic+q8mMs+2jPEhT5/mWQr3WxTdI8sxvvCFuq5NXBHbeGRHGQzu/Gy2Tn9YY0K/YO5uQCRNKF3D69GdauSD4L6ZB2M8n2c/aJkLsx/RHukDBlIEPtkH/3xvCIkkL834bp7jc/1zZEZO/9xsI6+Y0o2riKnT6awpPHRyX48ea9L6bHjBKrgxvwR+nPnuzcRrmAvY0Y4ugfYEYBWT+GbUUAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWU4fXpggvRan6McthT5xh6pMLEIO3yk6bxWqSfO8y4=;
 b=YajOU7jxe2At3djQm643/R6jUYRoNs4BllL/xmuTwf9XWbPSHiveNAqWRwD6EkKvNjnoy+Kp31L9m8Qsb35ejq/ktzFrEj8nHmN6fSEQOR8N+pHV8CNB80IeA3RPXmq0Ua2VY9GJB0iesfUaipoUXApHnLcA1GQajfZ3jEbPoaxTHYz32wzh4UmS23AfcynJNKeT700UDdwnGOKnrhoVBwkPiUTkWNJctmWr0c9+pIQYcQNSab2j+BC2Wn4IbPqEovHJwfv+xS9xK6QiCyUP3lE9Xk7Rv39PUZiAo0RMa4HxAvqLQvtwiQbFybjUVV2j67Nls+uomoh6R8xIUEkdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWU4fXpggvRan6McthT5xh6pMLEIO3yk6bxWqSfO8y4=;
 b=CqH7vaZb+ZhIu68rw4GssrMAriBk+uDS1m5RXentVZEtIhxlzS3XRNZ6H3Xx56GD3zR99qO+R788P+iEsw0WOZjgMLQtCAuP8pSVwlA5tYkfLY5uxlpAz17wVQOJTfkECAJJkUkSqH7UPIAT6cjBpMycZyFZANCHxtHjStUgGJMxBH/UdnLn+DcikDDY4bP2hdM9YCY7hiFfEJ9BPUzPEWluz8PUNNMLa3cmpbkeVt7lCs02rqN3DIbo9PYIzEif/4u0CxnFOmIlsKrhO0ShVG26c4qVrhoAWZV31k1qtuJXffYxpEXPG4MSAuhEE9kMxL6seJm5SnwG0vmhA0uamQ==
Received: from PAXP193MB2089.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:226::18)
 by AS8P193MB2061.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 14:41:23 +0000
Received: from PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 ([fe80::9da1:872b:caa3:1379]) by PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 ([fe80::9da1:872b:caa3:1379%5]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 14:41:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 31 Dec 2022 14:41:21 +0000
Message-ID: <PAXP193MB208932D21DE0E604AC51FBB8A7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
From:   "Siddhartha Menon" <siddharthamenon@outlook.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Check the return value of unpin_exten_cache. Cleanup style.
X-Mailer: aerc 0.13.0
X-TMN:  [mhZNB6jM+OmRqjJ1kenxvE7AOyb9t7Yt]
X-ClientProxiedBy: LO4P123CA0338.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::19) To PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:226::18)
X-Microsoft-Original-Message-ID: <CPG2Y3RSGZHY.1G47UGDEJ47AR@aqvarium>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB2089:EE_|AS8P193MB2061:EE_
X-MS-Office365-Filtering-Correlation-Id: d67c637f-1300-4818-b65f-08daeb3d162f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs7D49iemo9kjFhX98+qKoQJGAKXLMeJRyZF0KgxwanSxkY33RPyvtZP93U3uVcMba1BZWDD+80xPJhTs1EkN3IRndFpeA8+yIfvLgALlTh8tNOHsQHMZ1gt32MK/M5ONUJVKsrEpfetxLN33x1yNHNRKN8hLBhIBF6GhRpucYqMbPxrQWksvt+a47LSzE8iZrJJvk5Sl3w/N+F/VkeY3OOg4jETBIKmT53Lxwt0SkBDCn4ixvqmFqjYSOYs8/Rxmj1snPn3FXcILWGcbal3nAfumjG7SzJNCWWWKhAWO/PmUXBtTxg/3mUwhVf6RgqiMcjS271s6lk9FbRtEspmC2taHPg+bWwkRDIw7xvuFwG7BZCTAwvAMtiLBUVfPDr0U297kE5cU2PUXK0WYfp6fqYnTbQ9Zst8nrUO3ock6opwcwbN6drkmHRF8x2Bpy7xFg4WDJ/hF3s79Vv1IKXN1pDNYHl169r2d8ddkFdHqO7w7/2WoKBpb1kksP0gZTSy5CE8EVyFQ/V9wUvfKgw/SXhPYGSfUup0S+QR9nhtU+EQwB+xwTw7+eqmiz0Je6tgQrNGaHHP3BcXayghvFPpTNCLoQUU3aFj/pux1veGedI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk9Nakk2czVZY3FXak9JZkIzdy8vTjNtZUlwMGlHUytOSThnMm5OK25QSlZQ?=
 =?utf-8?B?REVsVXpubVVjemNWUngyWnFNbmJ0dFlqa3l4cVl0bXF1VU5Ca01ZcTFCSTFB?=
 =?utf-8?B?b0gzM0dHZXgvVXp2R05qanNlMzl5ZStFMnNET0pxY3gySDdjNnZHZkJFb1Av?=
 =?utf-8?B?MElsWTJYZFNsSXpCL1BDWkJVWk5YZHY2UVY1enY5eGpkUG5jN2RraGhxRjQ5?=
 =?utf-8?B?WVlIYkhEM0loZUxlcndCc2RYZi9BMTdDbzVZM1c5aHNtSmM0WXZ0SHgzYWxC?=
 =?utf-8?B?TmdzZnVucEV6Uy83YzNsWlpjRlFaUTlobTlFMXowbC9CSXZ3RGJzNnFqSFNr?=
 =?utf-8?B?QkFWMys3UUlwcWFnQjBDMFRkOTZUU0tIM042L3JtQ250ZExEYkdNd1R4RFNl?=
 =?utf-8?B?ZEN1T1BpRm16a24vM2xMRHJhVTdhQ21oTWlyRHIrVDZIOTBIWno3eVVjMnQ3?=
 =?utf-8?B?azJ6K0UvbTR0TGJQZEFJQlpzY2dHTktGRGpBZ0pabk1jamhoZjJWRzdrNkQx?=
 =?utf-8?B?Mk1GNWJLZTRmSXVsQW1keHhuOEFyNXI3NlBsUUJadWRmM2NGc3JBTDhtUjY0?=
 =?utf-8?B?M21BbXh2NUlwSVl0dWJSQTRabzQwUk82dDlBK09rZjM1WTRWWklzeGdvVlBP?=
 =?utf-8?B?eW5YaDQvQ2o1QXV0bXlPTnRUejVPYXJxQWppNTdXRTNleENab0J1emdyTitp?=
 =?utf-8?B?eG9veitjM0VURU5FbGIvWVFKamNOQ0w2a2N1M3RydGIyc040WWdFTFpMenV6?=
 =?utf-8?B?ODZsQzdjd0YyR3Zxd2lENktaRlRvTmpzRFp5Y2JmeG9GSmV6L3djd3lBTzQ3?=
 =?utf-8?B?SWxEZURMbFlLdGI0YTVXWlhyQVREdmMvMFVFQ1NtV1VRYlNLWHBCOVF1Z0cy?=
 =?utf-8?B?WEdkcGVPUmVkcXNXazUyb0ZTdWNSQ2hRNURMeWVseHhzb3lOMVM0Ky9XSHd0?=
 =?utf-8?B?S2xkS3h4N0tWZVY1MlBkYnNsSExGWGhITTFXcDNMeDVQUGMybHZ2RUxOQ2pa?=
 =?utf-8?B?ZEdXcG9OZ0dXZUtLM0ZtNTdRUWFFVldRM2RrODhlc2dEZDBoQmdGSHZSdEJr?=
 =?utf-8?B?RGNrVXNxWGFoUlNob3g0Q0FHa3U2UTZBZXBza1htVkViSzhEYk5PZkRnd1pj?=
 =?utf-8?B?MjhVeDNmNTlrQmVDOHM4QUIwa0MrRlhuZTJncHluNWM2Nm5Nb1UvTUhDNzdT?=
 =?utf-8?B?VkxRdERNQy9sbTZtOGV1bGY5WERRZ3lFVGJkN0ZPQWprdFAvc0tqeDc3QU8v?=
 =?utf-8?B?Qm1kaEdiQjcwWHpLSFFqNko4eGplbUM1MHBDNGpaSmZZejBCZlpZK09pbWpP?=
 =?utf-8?B?TWQzbGFhV3Faam1uVW1VYWQvTzhLVGVIQWsxaEpQaHg5TGg3ZDBiT2luV2pC?=
 =?utf-8?B?eDdjeVFvWFNMV1Yra0hsSWxUbnFlN3FCVGdqOVNyMjFnNDVmeUxQdUV1enJ5?=
 =?utf-8?B?aWhXYTgyeHE2YlF3L1NFNkRjWHVkeE9KSTNtdzRzelJMM244TmNtR2w5eldt?=
 =?utf-8?B?NCt2ZmhoSVZ2M0NPZ2ZKRFQvdHR3bk1ZZW9tQ0FEb3g2V2FFUEx3Yk05SzBM?=
 =?utf-8?B?Zi9UcjhkZ3UwMS84Z1UxMDN4NEZyODdSSE9LclNaVVFHK2JKM2VyUGVBKzUz?=
 =?utf-8?B?aTN3UmlBUzBvZFAzdUZGSERRQVJnQWJCQ053dGlvQm4yVmFFWlBWdklFSlZM?=
 =?utf-8?B?d1VBTzdycmtOUDB2TC9lNEtCKzg0SDRvM2tnUXdTZGR4a2hWOXVhVmZycXI5?=
 =?utf-8?Q?GGaIOIyEMlywt+BNM4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67c637f-1300-4818-b65f-08daeb3d162f
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 14:41:22.9117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From ef7af0146f74e6282ea5bb6ddd3573e12294d23a Mon Sep 17 00:00:00 2001
From: Siddhartha Menon <siddharthamenon@outlook.com>
Date: Sat, 31 Dec 2022 14:22:25 +0000
Subject: [PATCH 0/2] Check the return value of unpin_exten_cache. Cleanup s=
tyle.

These patches hopefully fix a bug and cleanup the style.

It seems that in inode.c:3335 the function `unpin_exten_cache` is called bu=
t it's
return value is not saved. Therefore the following if statement is checking=
 an
old value of `ret`.

This is my first patch so I offer my sincerest apologies if I have done
something wrong. I am happy to receive feedback. Thank you.

Siddhartha Menon (2):
  Check return value of unpin_exten_cache
  Fix several style errors in fs/btrfs/inode.c

 fs/btrfs/inode.c | 51 +++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

--=20
2.39.0

From b27046612d5ace53632617f671216ebb0ac200f6 Mon Sep 17 00:00:00 2001
From: Siddhartha Menon <siddharthamenon@outlook.com>
Date: Sat, 31 Dec 2022 13:41:56 +0000
Subject: [PATCH 1/2] Check return value of unpin_exten_cache

Signed-off-by: Siddhartha Menon <siddharthamenon@outlook.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8bcad9940154..cb95d47e4d02 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3331,7 +3331,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_exte=
nt *ordered_extent)
 						ordered_extent->disk_num_bytes);
 		}
 	}
-	unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
+	ret =3D unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offs=
et,
 			   ordered_extent->num_bytes, trans->transid);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
--=20
2.39.0

From ef7af0146f74e6282ea5bb6ddd3573e12294d23a Mon Sep 17 00:00:00 2001
From: Siddhartha Menon <siddharthamenon@outlook.com>
Date: Sat, 31 Dec 2022 14:14:53 +0000
Subject: [PATCH 2/2] Fix several style errors in fs/btrfs/inode.c

Signed-off-by: Siddhartha Menon <siddharthamenon@outlook.com>
---
 fs/btrfs/inode.c | 49 +++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cb95d47e4d02..ee7ca0e69aa1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -366,6 +366,7 @@ static int insert_inline_extent(struct btrfs_trans_hand=
le *trans,
 	if (compress_type !=3D BTRFS_COMPRESS_NONE) {
 		struct page *cpage;
 		int i =3D 0;
+
 		while (compressed_size > 0) {
 			cpage =3D compressed_pages[i];
 			cur_size =3D min_t(unsigned long, compressed_size,
@@ -1221,7 +1222,7 @@ static noinline int cow_file_range(struct btrfs_inode=
 *inode,
 	u64 blocksize =3D fs_info->sectorsize;
 	struct btrfs_key ins;
 	struct extent_map *em;
-	unsigned clear_bits;
+	unsigned int clear_bits;
 	unsigned long page_ops;
 	bool extent_reserved =3D false;
 	int ret =3D 0;
@@ -1557,7 +1558,7 @@ static int cow_file_range_async(struct btrfs_inode *i=
node,
 	u64 num_chunks =3D DIV_ROUND_UP(end - start, SZ_512K);
 	int i;
 	bool should_compress;
-	unsigned nofs_flag;
+	unsigned int nofs_flag;
 	const blk_opf_t write_flags =3D wbc_to_write_flags(wbc);
=20
 	unlock_extent(&inode->io_tree, start, end, NULL);
@@ -1575,7 +1576,7 @@ static int cow_file_range_async(struct btrfs_inode *i=
node,
 	memalloc_nofs_restore(nofs_flag);
=20
 	if (!ctx) {
-		unsigned clear_bits =3D EXTENT_LOCKED | EXTENT_DELALLOC |
+		unsigned int clear_bits =3D EXTENT_LOCKED | EXTENT_DELALLOC |
 			EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 			EXTENT_DO_ACCOUNTING;
 		unsigned long page_ops =3D PAGE_UNLOCK | PAGE_START_WRITEBACK |
@@ -3846,7 +3847,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 				ret =3D PTR_ERR(trans);
 				goto out;
 			}
-			btrfs_debug(fs_info, "auto deleting %Lu",
+			btrfs_debug(fs_info, "auto deleting %llu",
 				    found_key.objectid);
 			ret =3D btrfs_del_orphan_item(trans, root,
 						    found_key.objectid);
@@ -3892,8 +3893,8 @@ static noinline int acls_after_inode_item(struct exte=
nt_buffer *leaf,
 {
 	u32 nritems =3D btrfs_header_nritems(leaf);
 	struct btrfs_key found_key;
-	static u64 xattr_access =3D 0;
-	static u64 xattr_default =3D 0;
+	static u64 xattr_access;
+	static u64 xattr_default;
 	int scanned =3D 0;
=20
 	if (!xattr_access) {
@@ -4920,7 +4921,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, l=
off_t from, loff_t len,
 	bool only_release_metadata =3D false;
 	u32 blocksize =3D fs_info->sectorsize;
 	pgoff_t index =3D from >> PAGE_SHIFT;
-	unsigned offset =3D from & (blocksize - 1);
+	unsigned int offset =3D from & (blocksize - 1);
 	struct page *page;
 	gfp_t mask =3D btrfs_alloc_write_mask(mapping);
 	size_t write_bytes =3D blocksize;
@@ -5358,7 +5359,7 @@ static void evict_inode_truncate_pages(struct inode *=
inode)
 		struct extent_state *cached_state =3D NULL;
 		u64 start;
 		u64 end;
-		unsigned state_flags;
+		unsigned int state_flags;
=20
 		node =3D rb_first(&io_tree->state);
 		state =3D rb_entry(node, struct extent_state, rb_node);
@@ -5842,7 +5843,7 @@ static struct inode *new_simple_dir(struct super_bloc=
k *s,
 	inode->i_op =3D &simple_dir_inode_operations;
 	inode->i_opflags &=3D ~IOP_XATTR;
 	inode->i_fop =3D &simple_dir_operations;
-	inode->i_mode =3D S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
+	inode->i_mode =3D 0755;
 	inode->i_mtime =3D current_time(inode);
 	inode->i_atime =3D inode->i_mtime;
 	inode->i_ctime =3D inode->i_mtime;
@@ -5983,7 +5984,7 @@ static int btrfs_opendir(struct inode *inode, struct =
file *file)
 struct dir_entry {
 	u64 ino;
 	u64 offset;
-	unsigned type;
+	unsigned int type;
 	int name_len;
 };
=20
@@ -6667,9 +6668,11 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	if (unlikely(ino =3D=3D BTRFS_FIRST_FREE_OBJECTID)) {
 		u64 local_index;
 		int err;
+
 		err =3D btrfs_del_root_ref(trans, key.objectid,
 					 root->root_key.objectid, parent_ino,
 					 &local_index, name);
+
 		if (err)
 			btrfs_abort_transaction(trans, err);
 	} else if (add_backref) {
@@ -8930,20 +8933,20 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
=20
 	while (1) {
 		ordered =3D btrfs_lookup_first_ordered_extent(inode, (u64)-1);
+
 		if (!ordered)
 			break;
-		else {
-			btrfs_err(root->fs_info,
-				  "found ordered extent %llu %llu on inode cleanup",
-				  ordered->file_offset, ordered->num_bytes);
=20
-			if (!freespace_inode)
-				btrfs_lockdep_acquire(root->fs_info, btrfs_ordered_extent);
+		btrfs_err(root->fs_info,
+			  "found ordered extent %llu %llu on inode cleanup",
+			  ordered->file_offset, ordered->num_bytes);
=20
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
@@ -9357,10 +9360,10 @@ static int btrfs_rename(struct user_namespace *mnt_=
userns,
 	if (ret) {
 		if (ret =3D=3D -EEXIST) {
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
--=20
2.39.0

