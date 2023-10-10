Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E066F7BFFE6
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjJJPC1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 11:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjJJPC0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 11:02:26 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C103A7
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696950145; x=1728486145;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bDilZiuld1IBCKzQ2aMzg/NcVsHX9AVVObjjvg7eBCY=;
  b=tp5FVUtho0qQMpoZBe95YA1TGinm+5BRG2T+3EGRb75xbbc2nuXPPO8z
   EoY36E6kVqHOUUPdeI9gUZ4bS3vwzM39WitPbop6qVn6V5SNKYTcYVCKF
   njgsSJ0AcZKsibX1auOS3YPLX9hiZj6y/DiIkHm84xEk42npQzS7kz8EK
   E=;
X-IronPort-AV: E=Sophos;i="6.03,213,1694736000"; 
   d="scan'208";a="363357630"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 15:02:23 +0000
Received: from EX19MTAUEB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id 605E3A0C45
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 15:02:22 +0000 (UTC)
Received: from EX19D030UEC004.ant.amazon.com (10.252.137.217) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 15:02:22 +0000
Received: from EX19D030UEC003.ant.amazon.com (10.252.137.182) by
 EX19D030UEC004.ant.amazon.com (10.252.137.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 15:02:21 +0000
Received: from EX19D030UEC003.ant.amazon.com ([fe80::6222:63e7:9834:7b89]) by
 EX19D030UEC003.ant.amazon.com ([fe80::6222:63e7:9834:7b89%3]) with mapi id
 15.02.1118.037; Tue, 10 Oct 2023 15:02:21 +0000
From:   "Ospan, Abylay" <aospan@amazon.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: btrfs_extent_map memory consumption results in "Out of memory"
Thread-Topic: btrfs_extent_map memory consumption results in "Out of memory"
Thread-Index: Adn7hypl09BTxineSnqUNneAxmdLqQ==
Date:   Tue, 10 Oct 2023 15:02:21 +0000
Message-ID: <13f94633dcf04d29aaf1f0a43d42c55e@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.178.24]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings Btrfs development team!

I would like to express my gratitude for your outstanding work on Btrfs. Ho=
wever, I recently experienced an 'out of memory' issue as described below.

Steps to reproduce:

1. Run FIO test on a btrfs partition with random write on a 300GB file:

cat <<EOF >> rand.fio=20
[global]
name=3Dfio-rand-write
filename=3Dfio-rand-write
rw=3Drandwrite
bs=3D4K
direct=3D1
numjobs=3D16
time_based
runtime=3D90000

[file1]
size=3D300G
ioengine=3Dlibaio
iodepth=3D16
EOF

fio rand.fio

2. Monitor slab consumption with "slabtop -s -a"

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
25820620 23138538  89%    0.14K 922165       28   3688660K btrfs_extent_map

3. Observe oom-killer:
[49689.294138] ip invoked oom-killer: gfp_mask=3D0xc2cc0(GFP_KERNEL|__GFP_N=
OWARN|__GFP_COMP|__GFP_NOMEMALLOC), order=3D3, oom_score_adj=3D0
...
[49689.294425] Unreclaimable slab info:
[49689.294426] Name                      Used          Total=09
[49689.329363] btrfs_extent_map     3207098KB    3375622KB
...

Memory usage by btrfs_extent_map gradually increases until it reaches a cri=
tical point, causing the system to run out of memory.

Test environment: Intel CPU, 8GB RAM (To expedite the reproduction of this =
issue, I also conducted tests within QEMU with a restricted amount of memor=
y).=20
Linux kernel tested: LTS 5.15.133, and mainline 6.6-rc5

Quick review of the 'fs/btrfs/extent_map.c' code reveals no built-in limita=
tions on memory allocation for extents mapping.
Are there any known workarounds or alternative solutions to mitigate this i=
ssue?

Thank you!

--
Abylay Ospan


