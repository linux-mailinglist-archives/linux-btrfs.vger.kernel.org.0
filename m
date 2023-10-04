Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C867B7934
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbjJDH4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 03:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241604AbjJDH42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 03:56:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B731A1;
        Wed,  4 Oct 2023 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696406182; x=1727942182;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=JvR2C6eUuboS/j3eliOTn5ekCfiAeAmkp3on/GxQzwo=;
  b=fqc0g03mvvma3/he8nDrbKkxovDdKfvfls1i+6dDLeam3ZimASbRITpn
   jdAt/yGGOJRCIR97v6FHQPEYgjhXqhQ47iDkAvXLVUlJRNnTWjh5qn3Vm
   jkAGullPUXT3Fztl4baShnwkwdi7XwgyoLKu4JYWl2eWyv3qqDsOM6BT+
   dCZMKv8zQGuWle7Tbfg5gKOxUNIZ8pGiyWAQanUMgrT2WL++aVZMKQHZg
   2UakT42QDa9LBwrGmnIjyHbCiggk0+6AHv4cWPk4PZ6z1T0TO8RF+k7wt
   fwjerAPVBH8vzAT0rILSlQG4lAFsmRjZ1CoshGQ5yAuwBsLsy0efDp9II
   w==;
X-CSE-ConnectionGUID: v9bhVRLkQxutlGXFCsFoEA==
X-CSE-MsgGUID: DKkXnFM/TaaDvG5fItj58A==
X-IronPort-AV: E=Sophos;i="6.03,199,1694707200"; 
   d="scan'208";a="351024158"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 15:56:21 +0800
IronPort-SDR: +lGans4/E0RpKHho5agL04usIMX2aCMo2P/iMjFaoxSuoQhVuVW3G6YeR31EqiqWsdj90RPV6y
 7UZqVujtfpMMoxyp1GW2EbNTne2cTuVHWbeqOl2sv7pYqGnHBzCym4CshbVr8h0dbGLuy0jg2/
 cAscI0DCqPmKiKQVkzJRHaguPcR70er51+SiQIzZNrQQVB+BcgBbBqApZykteShu4zEMcYCt9+
 vtR1IOupbi9zhdsqvJsYlDNR2Er3fZvbNgXez3J6PkkdntFjb/MyKNI/wSLSPDjBvlI6Em09XN
 Jhs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2023 00:02:59 -0700
IronPort-SDR: Tdj5abqT7pMwzozbCq6+vEWY7CXsVYEZR79c2Wvnq1NyvXHnzGyOMLZOtEbZTxvR81vjhwWJyq
 Iv8QgJSpRtfolDIaVi12H1bU9kkwbkVKzY5S2xO9M6oS/1jS72bRcwYBMmgsT9doE5cl90Io6k
 bmzKr6nkytvQuUade9ewSr/VUqCTo2+X7Su9lwGHW0AWm4vFiA1wMVBLkt7FwGMA4hTAQGjkcg
 doHltGyGsMYE8c2pOtMQC1kG7hb5bgrMi3XV5QBGJFYMw8pOW23tZGnc9LaQLLJRxH+AJSJwG4
 iJs=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2023 00:56:21 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/4] btrfs: RAID stripe tree updates
Date:   Wed, 04 Oct 2023 00:56:15 -0700
Message-Id: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ8aHWUC/1XM0Q6CIBiG4Vtx/3E0QED0qPtoHdAPJgepA6Oa8
 95Dt1Yeft/2PjNEF7yL0BQzBJd89EOfR3koADvT3xzxNm/glJe0ZpKEOJHHaM3kItEoZaUFGuF
 ayMUYXOtfm3a+5N35OA3hveGJre/X0TsnMUIJq5RWFqnSsj49LR5xuMOqJP5XcroveS6vwiKTw
 iih21+5LMsH97KF3N4AAAA=
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696406180; l=1334;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=JvR2C6eUuboS/j3eliOTn5ekCfiAeAmkp3on/GxQzwo=;
 b=mbsT9Efc45q1ci4kS1sweCGnjA7YXPUjgw8YVfmYNb6yB2fGLMJevPS95BdwPhpVFi2/417pK
 YR+MIve6hDQCTyjUlpqVj4Eiifg0ysBWUF4KCidZvtAPbgoi+DTeNYM
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This batch of RST updates contains the on-disk format changes Qu
suggested. It drastically simplifies the write and path, especially for
RAID10.

Instead of recording all strides of a striped RAID into one stripe tree
entry, we create multiple entries per stride. This allows us to remove the
length in the stride as we can use the length from the key. Using this
method RAID10 becomes RAID1 and RAID0 becomes single from the point of
view of the stripe tree.

---
- Link to first batch: https://lore.kernel.org/r/20230918-rst-updates-v1-0-17686dc06859@wdc.com
- Link to second batch: https://lore.kernel.org/r/20230920-rst-updates-v2-0-b4dc154a648f@wdc.com

---
Johannes Thumshirn (4):
      btrfs: change RST write
      btrfs: remove stride length check on read
      btrfs: remove raid stride length in tree printer
      btrfs: remove stride length from on-disk format

 fs/btrfs/accessors.h            |   2 -
 fs/btrfs/print-tree.c           |   5 +-
 fs/btrfs/raid-stripe-tree.c     | 173 ++--------------------------------------
 include/uapi/linux/btrfs_tree.h |   2 -
 4 files changed, 7 insertions(+), 175 deletions(-)
---
base-commit: 8d3aed36ee6cac09c7bd6bee6ad67dc2a35615af
change-id: 20230915-rst-updates-8c55784ca4ef

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>

