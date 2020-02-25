Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9DD16B853
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgBYD5W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34241 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgBYD5T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603039; x=1614139039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lsyM0jh2svvdUUkTSuSBO4Z9YHTah9mGdrGa6zXuy5U=;
  b=ggHy8ioAmziehfJOfG1rI25wN95ZY2gCwDovMQwUBnEJ6n/azROyEFPO
   PfYIkBO8nhrTHWIUYEyg9aUz7rMJCtFDVQwVfCQaIynfRqsTk3M60upCV
   R++idwDcHHTdeEfBOOO6P088Xe9CTbV2sQ+gltmSEBuomnqT6aXrJjdMD
   Zk+wyJWFJCOW22LTxlOpndAxqgTo2gpBPSSQ9OYuDASGgvbHw+EKYgLOc
   m4J/rk+AWAtAQ6W+OCgmxYee/SCG5ow3dw0fscrTvFhz5HlXoElIRZYoC
   0TvgSpiZ3yIVhwE371/cdkCe1d8+1gPpMGHtODVzu3eT1xv1nGTbHXFdp
   w==;
IronPort-SDR: LkINrf7a5pa2VmiDuNBP/35InMxxZdEIcADPY5K9zGhHnyhjrLwylyzm85OfoJGQaxCSkRkNHz
 NQTbTUaPVMXexSsak58VekkkbRT0Mgc9Hcx7jI2A/vWQCARLDnIB2sIqSk2lNR+CX0HEJsdBv2
 tQhYy9fcaity6mddyjcdnaoTZHKtnMoxWhoTE09OVuUz8je+saI8cwa2X66QedKcpFfX3eVX6V
 ekhtmNMtplwAcC3kf5XRylcw7srIFWuP4AhC6+bExQ1KCt1SgN5MDG7aWtL4K84d4Bx3ZGWJvL
 ODY=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168308"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:19 +0800
IronPort-SDR: sVAMJfbkQidmdlB/iZ+crZn0SrNJWjI5NtYsZUt+4t01pgr9fqPmcHbXBbTJw6StXac5u+BEKI
 2/OFuVi7BKFEG65QdXLlwE5AZKpfAi1t7rNanKM3k4XRyyJk/Fuf7bonjFvqr96/rXxWJ+7Nj/
 X27PQ1Zuduika06kcLS9cKqK2BP9cquxJpwp3gI4Gx1vrF5MOtfHbqyvWlkDcM2du9JC6sl1vU
 4T7QC9IPNtyQifWSwY2NJ2637aW6JNjbhwqg+nbiiRv6gMYel9Gif2sY2QP0a2nsbIEh6pEKlH
 VS8kUsp6ziBXEYWHKepeROA2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:47 -0800
IronPort-SDR: 8nMOSDcJMpTzQ5xvPRQlohgN1MXw0TYtqwToT+NUqXIyhYPvpijpZZVjbgqpr86XcLRNK9VrEe
 aTc2QdR8CfrSf5eHQOfuK2Ur0DT1P5x7a/B329SBl6t1x6dRYaclKQswBTp1mXlQtmvlueHbhB
 IipeM/4RISIcFvjuG6U8QiizmvnsHiyDhw8QoE53jG34NJ6YdeqNRXb33TU/EQKLI6AFTReKoL
 sHq993TduBxaamPQRblGzKKYuWffJ4KEolKd1miKLANE2b0wyt3i9Q5EQoP3NrDtyP7NDLPWdM
 TLY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:18 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 18/21] btrfs: drop unnecessary arguments from find_free_extent_update_loop()
Date:   Tue, 25 Feb 2020 12:56:23 +0900
Message-Id: <20200225035626.1049501-19-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that, we don't use last_ptr and use_cluster in the function. Drop these
arguments from it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 46d0338659d7..05edd69f5fe1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3754,10 +3754,9 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
  * Return <0 means we failed to locate any free extent.
  */
 static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
-					struct btrfs_free_cluster *last_ptr,
 					struct btrfs_key *ins,
 					struct find_free_extent_ctl *ffe_ctl,
-					bool full_search, bool use_cluster)
+					bool full_search)
 {
 	struct btrfs_root *root = fs_info->extent_root;
 	int ret;
@@ -4126,9 +4125,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	}
 	up_read(&space_info->groups_sem);
 
-	ret = find_free_extent_update_loop(fs_info, ffe_ctl.last_ptr, ins,
-					   &ffe_ctl, full_search,
-					   ffe_ctl.use_cluster);
+	ret = find_free_extent_update_loop(fs_info, ins, &ffe_ctl, full_search);
 	if (ret > 0)
 		goto search;
 
-- 
2.25.1

