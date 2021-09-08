Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C30403D80
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 18:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349298AbhIHQVC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 12:21:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3327 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349076AbhIHQVA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 12:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631117992; x=1662653992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+cft4bI0eM90VfULfvmQ+jRCnOmlZuKmxc8x3bJP46E=;
  b=TSzd2ITGZ5cwPGegGNym+qdizt4X1BIOd/67iBw6kT/jVw4cVN7xRRn/
   UD3lHpgwqqr8p4gjWF0tuAS3/LfzTWqOiS8IQs3uDJ1GIl8ePfOFPbHWx
   b6y4T+eRv1BKshdWt76bPT9sRF4Td6pioy7684bC1+FhwUcMujgUsKULQ
   2P6dqywHPnW9/wSZ3yLNIRK9FX06neYLz9+BeexkQHpQn2SF2qlZJe/1y
   Hl/wcr1RjcpN2mxWaLUkL0wVuEgbDftdFR1oRMMuathrBpvRXm6oOdk5w
   aOsbVUqqFUhjNoWUw3aDnkeG3+Ti0HjiuBGL649X7G+OUDy0/d14J0s7H
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,278,1624291200"; 
   d="scan'208";a="179493954"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 00:19:52 +0800
IronPort-SDR: C+DstAMeYIL6u9mHUJVMzWbBgyjC30kbBxKYun4lroN84OeeItvFu72QcUoPEZX8lR8NYm4tAE
 vKR/5BcBY7CvCKZDzNJgwQjfuhQVQrD02pw07MxK4DbXwpTZTlYCLXxaix2ICfmnxgeP31JmsC
 XNhkYAkhp8Rsz2JB/JWC1SmwBkeu3O/zjpWn21T3Ln3GpFNG/d27K2ly9gDuOXTc4cf5qohNE/
 yk17tHhzlHbzJw3IChH/XM6Ko1DMvfsmCP3aYt6GqolAQl1nUD0zQ65LKAmywiaaQ780te1QOT
 jFcBd91C9OiKLi+4kFq8mmSp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 08:54:49 -0700
IronPort-SDR: KceCkPUJrKUMq2OzFIajylS6nPtPsNZobzspn3UFSFKai+aA1HQtsFWwuqjJhUqIcXk3Id/ybK
 75qbrMOauO0F/TYCxemYNyLNjoo0hwKD1hxOoS5LD43EHl5D8r3IK5h2KFx+o2vFc8TOIUru4o
 T1QE1abUCyyKX6bpY4jxpEJijzha/HzUFioSurGU9R8V3VVrl56Sd+TXlPvRK95V4PXZrixmNu
 ujXaJ2ojH2NqLVMwjDoAbULai4Hdkoc7CZUGKLRI1l6FfPS7E3u4/1MpsYqg/ZfK8UG3efkV9i
 sr0=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Sep 2021 09:19:52 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 8/8] btrfs: zoned: let the for_treelog test in the allocator stand out
Date:   Thu,  9 Sep 2021 01:19:32 +0900
Message-Id: <d808d1647e93712f80219fce21ea991c97078bfd.1631117101.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1631117101.git.johannes.thumshirn@wdc.com>
References: <cover.1631117101.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The statement which decides if an extent allocation on a zoned device is
for the dedicated tree-log block-group or not and if we can use the block
group we picked for this allocation is not easy to read but an important
part of the allocator.

Rewrite into an if condition instead of a plain boolean test to make it
stand out more, like the version which tests for the dedicated
data-relocation block-group.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 708dc6492f97..77ad7bd3b22e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3763,7 +3763,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	u64 log_bytenr;
 	u64 data_reloc_bytenr;
 	int ret = 0;
-	bool skip;
+	bool skip = false;
 
 	ASSERT(btrfs_is_zoned(block_group->fs_info));
 
@@ -3773,8 +3773,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 */
 	spin_lock(&fs_info->treelog_bg_lock);
 	log_bytenr = fs_info->treelog_bg;
-	skip = log_bytenr && ((ffe_ctl->for_treelog && bytenr != log_bytenr) ||
-			      (!ffe_ctl->for_treelog && bytenr == log_bytenr));
+	if (log_bytenr && ((ffe_ctl->for_treelog && bytenr != log_bytenr) ||
+			   (!ffe_ctl->for_treelog && bytenr == log_bytenr)))
+		skip = true;
 	spin_unlock(&fs_info->treelog_bg_lock);
 	if (skip)
 		return 1;
-- 
2.32.0

