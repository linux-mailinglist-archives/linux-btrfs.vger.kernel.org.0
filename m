Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3DA2308A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 13:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgG1L0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 07:26:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8600 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgG1LZt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 07:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595935549; x=1627471549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4JJm/WV2QmCG9qnvOeej/OqnI6cuwgEagMYVPPngcOE=;
  b=qj0PZFG+VoBlz+FMfHFFg/H6o9/qIbbHfu3TcklqYRhMa4Yfg/UYcooq
   sWF6beLrSuzsMC5mzjvN5WQmtFe/Oljkr2h1EctASEegl9Hdh8ZxauYrz
   a0hhR5Mr8KN35u7SH1ucCsUNLdaueyWLTzlg0eH3FJSSI2Gff761U5/fP
   HolOxw6JLpJycUB3F5c89B9yF9aamYG03hSZiqndm1dV+xpI7eGvJxH5C
   j7c2Iw/V2KUJ2bv6EFmjIpRa8betOs1ytXT8xqnQLts+ZcQy+/yU1VTjd
   /rKmZG5LG2GV3U5MbweSYwgFWFe4733uXYjFmh4N1DMcMNCOVsEBpHtRA
   A==;
IronPort-SDR: c5xKE0gpDnUY1ko0Ny7EUiXwY/p3vGldkyMz8prz2cujQM0FVP2WW6RrW4CK5nKdZh7wyBKVT8
 f13/yg2TD4kYkwWocP44PSCX9lP1R0FvYCgEzNyZMnidRo7iLPMfydzrzWSMHMlEvlxZ1J+Pzx
 u3++YLWq/zPMd69Diid8lOlSUMpxu0haQQr93JoWCbx9zohwwmxf+3fDxstOx9PQpQPTTfIRVC
 I1te3UDVU7j94t8aF7VPRtUJ/0Gh2W4lVeYUTQeGViVaPy303jr+oIZw0i0ZBF21aIce0cI1z+
 PLs=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="143547653"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 19:25:48 +0800
IronPort-SDR: stebF0xNo3/azNUsSPtVGAnqmPQ0038qK/rnIE2j+3rFWVD9qDOV+AqRGGeqAEU1Ds8jEjg8Nb
 zoHsDmQejBdZ9pLa6ZB6Q7FMJCHuwnuX8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 04:13:58 -0700
IronPort-SDR: UE793VzALh5kTHJAKGAVZ6nXPGz5jWJZI+JHwSTn3EYN/Gu4FMFie3YbwIOJuPlLcoIRcbSFFa
 P0EfUJKtR+wQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2020 04:25:48 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: handle errors from async submission
Date:   Tue, 28 Jul 2020 20:25:41 +0900
Message-Id: <20200728112541.3401-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs' async submit mechanism is able to handle errors in the submission
path and the meta-data async submit function correctly passes the error
code to the caller.

In btrfs_submit_bio_start() and btrfs_submit_bio_start_direct_io() we're
not handling the errors returned by btrfs_csum_one_bio() correctly though
and simply call BUG_ON(). This is unnecessary as the caller of these two
functions - run_one_async_start - correctly checks for the return values
and sets the status of the async_submit_bio. The actual bio submission
will be handled later on by run_one_async_done only if
async_submit_bio::status is 0, so the data won't be written if we
encountered an error in the checksum process.

Simply return the error from btrfs_csum_one_bio() to the async submitters,
like it's done in btree_submit_bio_start().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 611b3412fbfd..edb468e8db3d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2154,11 +2154,8 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
 				    u64 bio_offset)
 {
 	struct inode *inode = private_data;
-	blk_status_t ret = 0;
 
-	ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
-	BUG_ON(ret); /* -ENOMEM */
-	return 0;
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 }
 
 /*
@@ -7612,10 +7609,8 @@ static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
 				    struct bio *bio, u64 offset)
 {
 	struct inode *inode = private_data;
-	blk_status_t ret;
-	ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, offset, 1);
-	BUG_ON(ret); /* -ENOMEM */
-	return 0;
+
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, offset, 1);
 }
 
 static void btrfs_end_dio_bio(struct bio *bio)
-- 
2.26.2

