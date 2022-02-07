Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7619F4AB45F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 07:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiBGFur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 00:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiBGDLE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 22:11:04 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 19:11:02 PST
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EA5C061A73;
        Sun,  6 Feb 2022 19:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644203462; x=1675739462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JWmy6hDKVlqRqGF1ZrgICtGTL/LQ+JWtNfM+slfWVEY=;
  b=VdBihq5FxNIFnLNPXWT96XXv3v+c4clqedOzJiOTLwArEweL6mNnpDLp
   KMWn2kBtQNiyIfsMls7lm3FgnyE1Uax5U6B3mjfMvHBbY2vXgZ2Z4INBU
   I19UeKXY60f/StOfXvE5NeIO9Tyx2CpAmOb79hABiZ8YxZRYnMqe1nfmh
   Lyprn6tkUcgRoGUNMZgj/aja0hT+CjclGJD3ZnRdR9a2iBHCHfBSRGLET
   SvjNx1rzKhIUKKIAPxN34/dbG6ccHY873emjGJ/7on2azTDReGNkgYC1X
   OF0bwz6SSLcgObkRSvuyiQrcj+XIsajnegdiUUPvncXGcFrZMLLE9qqdX
   A==;
X-IronPort-AV: E=Sophos;i="5.88,348,1635177600"; 
   d="scan'208";a="304195987"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 11:09:59 +0800
IronPort-SDR: Uni/sAofY1Nwpt5YW+SAkWVzHKH5sWpKITXGdYbGCQAb3oljIOYXoBnxX4OQpgIXFAtG3MgfO8
 5+18HNNriRj52A4iwG5m+A2iiEFQ504wSCmCapuaNKkTgA96cHamjaU+P8CJn4DITADUkg6Qm6
 tYBiUdFcSkxHK+hMJz/rDbpNjeXxg9SUJwDGTyV5k8HBq02+jpBflA1jTDhz42WwXgmri+pedX
 CHfi1Xk95cRT7C2TWsPav5g8CzlUHuMjhLaUDFgKFt2yNd2tYKyjs6T8o8aOcfpDkJ3TCD+5Wj
 gmV933ik8gmSry6D+0kA1Qod
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 18:41:50 -0800
IronPort-SDR: NZnOtTdm8S8O4IJ+kHWL8Da6nGQIixdfNJngR2YO8OnaNo614uig0OK/DpTDb8Kp1JHO7l2cau
 rWZlYB5+npIZ9P0TeC8bim+F6tZShNxRSZtqiMIZTchzp0jv/8WcovAUwUgV9k7kSFOa00ajUF
 954phsT7rvO5RgFy2tsPFGuVq0dB7CU2EFocgtIfdJSD0Gbg9DhtLK6P0o7CdF+2Pctoer94FM
 fRACnP139AzkTSZs58cyV5OHtrJomdrD9Ctn3DmOpa+N3PlccNMmdp4ZVVxUs4dgzLMk7B+bOl
 qEQ=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 19:09:58 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/7] fstests: fix _scratch_mkfs_sized failure handling
Date:   Mon,  7 Feb 2022 12:09:51 +0900
Message-Id: <20220207030958.230618-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a repost of the series posted to fstests list before [1]. This time, I
add linux-btrfs to To: list, since it fixes a failure observed with btrfs on
zoned devices. Reviews and comments will be appreciated.

[1] https://lore.kernel.org/fstests/20220124111050.183628-1-shinichiro.kawasaki@wdc.com/


When generic/204 is run for btrfs-zoned filesystem on zoned block devices with
GB size order, it takes very long time to complete. The test case creates 115MiB
filesystem on the scratch device and fills files in it within decent run time.
However, with btrfs-zoned condition, the test case creates filesystem as large
as the device size and it takes very long time to fill it all. Three causes were
identified for the long run time, and this series addresses them.

The first cause is mixed mode option that _scratch_mkfs_sized helper function
adds to mkfs.btrfs. This option was added for both regular btrfs and
zoned-btrfs. However, zoned-btrfs does not support mixed mode. The mkfs with
mixed mode fails and results in _scratch_mkfs_sized failure. The mixed mode
shall not be specified for btrfs-zoned filesystem.

The second cause is no check of return code from _scratch_mkfs_sized. The test
case generic/204 calls both _scratch_mkfs and _scratch_mkfs_sized, and does not
check return code from them. If _scratch_mkfs succeeds and _scratch_mkfs_sized
fails, the scratch device still has valid filesystem created by _scratch_mkfs.
Following test workload can be executed without failure, but the filesystem
does not have the size specified for _scratch_mkfs_sized. The return code of
_scratch_mkfs_sized shall be checked to catch the mkfs failure.

The third cause is unnecessary call of the _scratch_mkfs helper function in the
test case generic/204. This helper function is called together with _filter_mkfs
helper function to obtain block size of the test target filesystem. However, the
_filter_mkfs function works only for xfs, and does nothing for other filesystems
including btrfs. Such preparation unique to xfs shall be done only for xfs.

In this series, the first patch addresses the first cause. Following three
patches address the second cause. They cover not only generic/204 but also
other test cases which have the same problem. The last three patches address the
third problem. Two of them are preparation patches to clarify that the function
_filter_mkfs is xfs unique. And the last patch modifies generic/204 so that xfs
unique test preparation are run only for xfs.

Shin'ichiro Kawasaki (7):
  common/rc: fix btrfs mixed mode usage in _scratch_mkfs_sized
  generic/{171,172,173,174,204}: check _scratch_mkfs_sized return code
  ext4/021: check _scratch_mkfs_sized return code
  xfs/015: check _scratch_mkfs_sized return code
  common: rename _filter_mkfs to _xfs_filter_mkfs
  common: move _xfs_filter_mkfs from common/filter to common/xfs
  generic/204: do xfs unique preparation only for xfs

 common/attr       |  2 +-
 common/filter     | 53 -----------------------------------------------
 common/rc         |  8 +++----
 common/xfs        | 45 +++++++++++++++++++++++++++++++++++++++-
 tests/ext4/021    |  2 +-
 tests/generic/171 |  2 +-
 tests/generic/172 |  2 +-
 tests/generic/173 |  2 +-
 tests/generic/174 |  2 +-
 tests/generic/204 | 26 ++++++++++++++---------
 tests/xfs/004     |  2 +-
 tests/xfs/007     |  2 +-
 tests/xfs/010     |  2 +-
 tests/xfs/013     |  2 +-
 tests/xfs/015     |  4 ++--
 tests/xfs/016     |  2 +-
 tests/xfs/029     |  2 +-
 tests/xfs/030     |  2 +-
 tests/xfs/031     |  6 +++---
 tests/xfs/033     |  4 ++--
 tests/xfs/041     |  2 +-
 tests/xfs/044     |  2 +-
 tests/xfs/050     |  2 +-
 tests/xfs/052     |  2 +-
 tests/xfs/058     |  2 +-
 tests/xfs/067     |  2 +-
 tests/xfs/070     |  2 +-
 tests/xfs/071     |  2 +-
 tests/xfs/073     |  2 +-
 tests/xfs/076     |  2 +-
 tests/xfs/078     |  2 +-
 tests/xfs/092     |  2 +-
 tests/xfs/104     |  6 +++---
 tests/xfs/108     |  2 +-
 tests/xfs/109     |  2 +-
 tests/xfs/110     |  2 +-
 tests/xfs/111     |  2 +-
 tests/xfs/144     |  2 +-
 tests/xfs/153     |  2 +-
 tests/xfs/163     |  4 ++--
 tests/xfs/168     |  6 +++---
 tests/xfs/176     |  2 +-
 tests/xfs/178     |  2 +-
 tests/xfs/186     |  2 +-
 tests/xfs/189     |  2 +-
 tests/xfs/250     |  2 +-
 tests/xfs/259     |  2 +-
 tests/xfs/276     |  2 +-
 tests/xfs/279     |  2 +-
 tests/xfs/288     |  2 +-
 tests/xfs/292     |  4 ++--
 tests/xfs/299     |  4 ++--
 tests/xfs/335     |  2 +-
 tests/xfs/336     |  2 +-
 tests/xfs/337     |  2 +-
 tests/xfs/341     |  2 +-
 tests/xfs/342     |  2 +-
 tests/xfs/443     |  2 +-
 tests/xfs/448     |  2 +-
 tests/xfs/490     |  2 +-
 tests/xfs/502     |  2 +-
 tests/xfs/513     |  2 +-
 tests/xfs/530     |  2 +-
 tests/xfs/533     |  2 +-
 64 files changed, 135 insertions(+), 139 deletions(-)

-- 
2.34.1

