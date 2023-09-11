Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27A479B643
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355632AbjIKWBd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbjIKMwn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:43 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA8CEB;
        Mon, 11 Sep 2023 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436760; x=1725972760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D+BzdF5oP8uW6qZ5ynzhWFTIk+tOOC9drG8BemLcBr8=;
  b=bqXQuLkulAL78Rh4KqVmmWAh96+kjchfi1fRlbXiLnS3E+7NF+3kE9cv
   6YhnHnHk77dIWUCPJVKQOYuscpI8KuC9fAI51Pn62Wf2HVlvuuplPxvMw
   lyBLVpUDE8Si9rCW+OiXAnwpcmO1fA6Zm2NfjAJyrjxdLjRGCJn4eMLWP
   oOOyPL6EDhh2l36W2jo3JOiQs91561C1Q46noA786Q7sZWblarCTo9T6x
   HqLbt4s3nUCBVFj0om5gdwOyJLvarl9iOpzTptFtzKS6Fkqu36hFJ3x6I
   xFUUDgkU2dII6k6M23+xalY9e8rfjAx35BnWptLvB8Xbfd7lIEy+IMAft
   Q==;
X-CSE-ConnectionGUID: 3aOhP/jlRMKw1kfXvCxFeQ==
X-CSE-MsgGUID: GiOuDSCiShi1su9V0sUdsA==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594404"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:39 +0800
IronPort-SDR: CrDM9AddJJSRhAB+fkFhLIt7MM8km3t9LWi21XiryybeI5VboZIgR5u02huNq98p0ojuzlWa6W
 gc1WZLSi2/1IpsAw1nJ/97oxX8Vz6eEHycw9zYZ4lntwf9iDucRKn3c3LsYtMEhr7E8YBQlm4+
 aIHKX2wxgO47XkzUmyZBSHuVrCif0MYNPc1XapwagFhfSFrPMbcPWqR1OhJ055QzMFrhxOHjuI
 BDAbDO5YIOiNII3TCoUgcDDD4m+RHODZ0f54jXqlVPRgO4vWDtMXhrPl/GsDvRbAGO1TVjKnxm
 sD4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:05:25 -0700
IronPort-SDR: A0hFwIzHLUE+ulyWyD+JBLip4kK2E7H7zfc1M8RRGQIreSvXh5hPAySix6iBdf5kis/Bk+vQJD
 dgbsaMDenLXL1yh1MA4SkKq2J09zxOeMJXFInzUsyywTqD/PO1FOESyAZAsEL8l3cltNHPq7qn
 kJkBilhXkxGbsZNR/2K8A7qqd9UXLyfcOSKRoOgFcxh4dk1K5cMTTG0B2epfplsqhSPhhTMjWN
 3eJCQurFxV8heq0tKCq0Zoov5c8J/8jBGrKxrCoZiKw6p/yGnPm9xztUfFCESanRNSqFctqDB1
 iuM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:38 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/11] btrfs: announce presence of raid-stripe-tree in sysfs
Date:   Mon, 11 Sep 2023 05:52:10 -0700
Message-ID: <20230911-raid-stripe-tree-v8-9-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=1119; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=D+BzdF5oP8uW6qZ5ynzhWFTIk+tOOC9drG8BemLcBr8=; b=UwF2M5arf7IqLn76+V+tFbjy3tb8obqCvnHvN1HJipbCC39KeMqVVtHaW3hUz5nbh0vye5+IH AmQ225ZlfsEB7m2ZAHrEN+Z6uOf+RiKoHrhwWjck8J+XoMFt4wYyUPP
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a filesystem with a raid-stripe-tree is mounted, show the RST feature
in sysfs.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b1d1ac25237b..1bab3d7d251e 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -297,6 +297,8 @@ BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #ifdef CONFIG_BTRFS_DEBUG
 /* Remove once support for extent tree v2 is feature complete */
 BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
+/* Remove once support for raid stripe tree is feature complete */
+BTRFS_FEAT_ATTR_INCOMPAT(raid_stripe_tree, RAID_STRIPE_TREE);
 #endif
 #ifdef CONFIG_FS_VERITY
 BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
@@ -327,6 +329,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #endif
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
+	BTRFS_FEAT_ATTR_PTR(raid_stripe_tree),
 #endif
 #ifdef CONFIG_FS_VERITY
 	BTRFS_FEAT_ATTR_PTR(verity),

-- 
2.41.0

