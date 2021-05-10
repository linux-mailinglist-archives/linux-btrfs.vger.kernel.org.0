Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26711379266
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 17:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhEJPUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 11:20:13 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2666 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbhEJPSp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 11:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620659860; x=1652195860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=al3e0y9TyASlFlAkQkav5xNOdq4X0Due/z+pkj6a3xA=;
  b=deE7mwpuvSSrWIOU5EHJWnBO9JnBho3SCTxQBW9pG7VcOotwMVzVVhjo
   rpLvIjzyoVczoS0lP/RnS99Rnf8+I7EMVTXMCuAbLRY4OwPBHooTaLC4u
   qaTxbmH6mLh1JD3cjqVOt4bFkBcqvoFwTqli/gHGYQUG0VeWIaoOx9Jhj
   NTbmAsvpu11ltsybt/KxNzrvzHbZChcn6KfKZiLd4+pNDkaa4+oI29fN8
   itJuBCdiufXax4E+bb+1IPwvIkIyx67NlN718jEhbiUZKpjeZoTPt6zWl
   XgVdZ6xwOCdEEWOZw9/p0C6vyyQcXyizPXWooK2R5fXzqJt9wZSVQxNBW
   Q==;
IronPort-SDR: vPNpLJAL/nljmqEMzmLXPtpmZpOKoHgsUfJ5GdJc4QlnE39cb/5pp7yfhuxcOMJjo1Xw4gI0iH
 JagZZAplqt/10D7eic7+yC2KfUiWLvyyy4A4gbNjVuqqgKlf6xK1QjSPIzMWghqZYTMZiqPW8P
 Q6mwacZuCilg+wVruN3+AgP5qaP5T9Rh3dZ+5UfQ1Y8ytgsdTzxIcBSGXztGnJVOxFMPjTyKqj
 6YjX7zOtmM17E/YNyACJa/DOBEXzxbHCSxVeuBwipp3bEhYrNg389tkpxjsIPa6msFMI4UPxMY
 TLM=
X-IronPort-AV: E=Sophos;i="5.82,287,1613404800"; 
   d="scan'208";a="168187863"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2021 23:17:34 +0800
IronPort-SDR: tXFdRXrkjtpCFUKAtOgEFk6Z+5XCCv0MQJrfouvZG/WPJGm6Eo0kJLgOt3IP5C6An0nPHsF+el
 xQO6A8sosPPqxw5DICS1X7ZmMJZYO/IOZbJSDbhCOf3bkvL1SbvbgqF0MvVobqeHaFGPmDkQCi
 UDfg6C8KmoTHdCTfDV1aiNO0iJAZ0v0MjDXUxXwoCGmk1xHbIY/TIruEOZzKxtVdDd4ehKCeQ6
 3PYn3cJcgO+LNE3DljSZhzY6FxzJYT32q05M98joxjz0k7qSvIXeqEimq41RmHjCtEtl9IGKOw
 msLY67v5J068pHTLFnmdERir
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 07:56:08 -0700
IronPort-SDR: Ok0r8kavXDKBUv91+3XWz2WOG8iuExzkGG4ukwK4gXJ5JePFw9uDKNch4uBLiXXPUXORJEmps5
 LEbQx3/oHUcu/aoEwcscSz2JMB0LtcPjtd746FDQaGCvf4c0ng2clHuC07JetCszMT/pq9lkqF
 OwweDdzs9lw4JROdreKoCPCSc09pzSHJqs6kLKqdNJHLCjF83rOMuzjjIZHJ/zDW4XgegMmOyP
 PDyq/BRo4XZyRSHRBnZXNewO9DfVux+WU009Dz1tjrlF8SjSDmrodN0vn8DSxByHirck6Fy2JY
 BEA=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 May 2021 08:17:33 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: let check_async_write return bool
Date:   Tue, 11 May 2021 00:17:26 +0900
Message-Id: <ac35b9ba276cf4eefcf9641a19eaabae715f6d2d.1620659830.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The 'check_async_write' function is a helper used in
'btrfs_submit_metadata_bio' and it checks if asynchronous writing can be
used for metadata.

Make the function return bool and get rid of the local variable async in
btrfs_submit_metadata_bio storing the result of check_async_write's tests.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c9a3036c23bf..4305e3a26a6b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -917,23 +917,22 @@ static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
 	return btree_csum_one_bio(bio);
 }
 
-static int check_async_write(struct btrfs_fs_info *fs_info,
+static bool check_async_write(struct btrfs_fs_info *fs_info,
 			     struct btrfs_inode *bi)
 {
 	if (btrfs_is_zoned(fs_info))
-		return 0;
+		return false;
 	if (atomic_read(&bi->sync_writers))
-		return 0;
+		return false;
 	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 
 blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 				       int mirror_num, unsigned long bio_flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	int async = check_async_write(fs_info, BTRFS_I(inode));
 	blk_status_t ret;
 
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
@@ -946,7 +945,7 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 		if (ret)
 			goto out_w_error;
 		ret = btrfs_map_bio(fs_info, bio, mirror_num);
-	} else if (!async) {
+	} else if (!check_async_write(fs_info, BTRFS_I(inode))) {
 		ret = btree_csum_one_bio(bio);
 		if (ret)
 			goto out_w_error;
-- 
2.31.1

