Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886226198ED
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Nov 2022 15:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiKDONV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Nov 2022 10:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiKDONB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Nov 2022 10:13:01 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD932F662
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Nov 2022 07:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667571163; x=1699107163;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JH2j13lJxlkeB5cFNwvu11D3FLwRYrLAq2TCvOoE474=;
  b=rVSk+eJnY0r1sg7mnKWAnSLAj0OAb62Wn3R7IlNX7Hb1ZxnMQtVKjD5d
   HxHJdF492uLxIkX/Gk/X2WMs3dSPPOLyXF1pHwzKcZ1Uj7geYbe9z4uYd
   usPylaE/qtoXzGc5HYKzdOiu6mSP/fuDI7xljLjPzEqg9QLLaSWZYH4Oa
   IsMWXpoXhh0zZ7FPOBUJQHz+hWaOD4cO5YLC7B0WyEaZRIHfWkHmIbyb9
   yrC/niPf1fMdkjPp7VbY3RsHOkCtqvys77mtLtuK0VY0v/c0HtK1mT/D3
   hJ84JA9oFi+CJpVrKD6mWIS6d3qbqomt+1T85h8+5Ec0UKb3uIFt4Upd0
   A==;
X-IronPort-AV: E=Sophos;i="5.96,137,1665417600"; 
   d="scan'208";a="327603634"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2022 22:12:42 +0800
IronPort-SDR: pVR8Mp3mfgPzFqVq0N10whXyG1MC0eJM8fw+IiVbcryORWONp6hJPtD1uBXEz3N+7KVE9HJoUW
 QLGH5/MYz97YJqtHQF1/y/7mUb8/ev17UTPbtnVSmvuuh/O8RJZ70cX6Opb9YdnPLONpxw9L11
 jJRUwq65bU3KEt0iwNQQEZ+82bhZoEG+KFq/26NvufhIJYs1kM6yntrBWTi30Eg8Kx2y05IVyX
 zLzoq2JegG9sIvlD9G4HZasrMCs33XNjoziXFZx9ddocRL1/cWTx/shIGJisLPon0G666zlEBN
 M0s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2022 06:31:53 -0700
IronPort-SDR: zYJQRF1m1igdGb7H4AbpAxTXRKQyZouL8kSvavKXnvbDNXki+sVEt/c/0K0HZDQs7k+dm99Rnk
 xqg22tRb8iOIR+45rcpaBLu3kdsBsiBfWJNdDa16aP6M/atplUDnt4nNr9p2pdnwM/KSCxfkzL
 qILkplLoS0nNFvDJHhcjaHwOjkddj3ozNynitn/F7qojJKVDJ1HCLuts2K9gBc/CioNH/SMd2O
 dDbaEBnpQdDmE7zNqDOaRv/E0q117SZm3lIbOVFWwOPqwOzDdsEQHv2ih/eReJwxsMNi+SXddB
 sbM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2022 07:12:42 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 0/3] btrfs: zoned: misc fixes for problems uncovered by fstests
Date:   Fri,  4 Nov 2022 07:12:32 -0700
Message-Id: <cover.1667571005.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've started running fstests with an increased number of zoned devices in
SCRATCH_DEV_POOL and here's the fixes for the fallout of these.

All three patches are unrelated to each other (i.e. no dependencies).

Johannes Thumshirn (3):
  btrfs: zoned: clone zoned device info when cloning a device
  btrfs: zoned: init device's zone info for seeding
  btrfs: zoned: fix locking imbalance on scrub

 fs/btrfs/disk-io.c |  4 +++-
 fs/btrfs/scrub.c   |  1 -
 fs/btrfs/volumes.c | 23 +++++++++++++++++++++--
 fs/btrfs/volumes.h |  2 +-
 fs/btrfs/zoned.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   | 10 ++++++++++
 6 files changed, 77 insertions(+), 5 deletions(-)

-- 
2.37.3

