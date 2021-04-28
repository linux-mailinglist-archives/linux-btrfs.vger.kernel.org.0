Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189EF36D430
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 10:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhD1IrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 04:47:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48814 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhD1IrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 04:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619599576; x=1651135576;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZMRNZluHliYRaQm/Ek5AWW77WnH6wwpqF1l5RETKePI=;
  b=S9YyHMS2LQljtxF28z7XkWkRsdVPIBhiTuBuhYUMk30XzP35wI5Ah5Bs
   WjU9MSy3Ft4oP2PNoLn/DmSHTAhsoDygH0Bi3mmQ2S8jRkCvJyKvqfnA9
   bCr2hdnf3OIz4vp4EUfBNAwgdUhXjITHLOyx3pa2B7hh/spqs3cTMrO4I
   En280spaj6MQ/LVjWsfsGGzPas7Ye5LEBiX8p+w1N0SbMQRXDvVsqSvWo
   7VAzJgnKl3xHfFjTGbN35tHVQ1cEGGD9Jt5kaGTAkdbrRO5hy5BepIy/j
   Li2WaEZ1E6G84LYT/YlOOj0gX6fx9JTaggXHf64d4qy2MGvKe9UQGfc4E
   Q==;
IronPort-SDR: BKI49OUIyIQ3dIvkT0YRHynOuvcvSNH1mcuvWsjLPPkZjgGkf327ffkddSF9MoXatUNs02sOI5
 GyBcpW2hB2BvG3qfQJbX1L3+Dd984NjpwcUxhEyZuGlS6Ma57Iz4ZiD/wCjjQKaFUXbd/GDg7E
 UpzafMcrCIpmy+8khUToZcQVNrISlaWfkpfJQUPB6qZlxHtVCDcE2Sy3sHRLqrDOmxFyfk73Ow
 zrJyo18EeYU4WegbRGYLHXODLx0jI3QrLgcU21zyzWJjXDldukZBO5rogAxMerVDbRuoJr/Tqv
 Ee0=
X-IronPort-AV: E=Sophos;i="5.82,257,1613404800"; 
   d="scan'208";a="167061144"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2021 16:46:16 +0800
IronPort-SDR: M17NkKZh7ZmoUwCpLEYcRqxZ9z0zR/CfYk9uDxt1da9UHCwJpak4juev6HWexdN1yhuHc9qWiM
 OusMsLiozYgvYwwUtxKBG+WoZMVx5gw4mpQe8+NVBwtMyoCMgI8VYi3YUY7eFnNkXnbXmTBwen
 67cz8HT5Up/b/917iiztSQoHgVQ1RqBPtIGzwdxsr/HbR2FgW57nJyIf3MBjEwkTiTuJ1c4A4U
 ds+i7ztWnc3IkSuydyFiNofBzemQJnmD1fBN/p9JXWcWs2xc7JGm6jnhIvnDk0xNvg3zueua7Y
 oaYexVDK7TwoFeXQd6w6mV4z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 01:26:36 -0700
IronPort-SDR: xD4i6ogex6DQssHFpzsvYUg6tqWWzXyc2CE/SvTQlrtZNQkOZsHHjpBiyHe9Hmsiswt8+5ko6Z
 Du3vlhhCtAUMi/3rCwDLkqx8fgDPtYJMqsEEhIyBgIACnHr1PfYZsEwo1s7KOSCTeqZLV5MXMb
 zULkwkYqsLETX7gK3f8wUh+G4bkxvdzq2c+SWzs923RBoMC8dE8XSOvYvUWtjvIxVqjUkI22FA
 pQJRX0M2wQq/JPLbJRamNd7NBGmsTJAMPxP8LYo0hbCsrzw2Nq6sFrOLKYCzPEXlpa3KI6ulim
 xzE=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Apr 2021 01:46:16 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] fstests: first few support patches for zoned btrfs
Date:   Wed, 28 Apr 2021 17:46:06 +0900
Message-Id: <20210428084608.21213-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series adds preparations for xfstests for testing on zoned block
devices and a first test for btrfs' zoned block device support.

General zoned block device support for btrfs was merged with v5.12 and the
zone auto reclaim feature is staged to be merged with v5.13.

Changes since v1:
- rebased onto master
- drop unnecessary patch
- comment sleep and commit= mount option use

Johannes Thumshirn (1):
  btrfs: add test for zone auto reclaim

Naohiro Aota (1):
  common/rc: introduce zone check commands

 common/config       |   1 +
 common/rc           |  44 +++++++++++++++++++
 tests/btrfs/236     | 103 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/236.out |   2 +
 tests/btrfs/group   |   1 +
 5 files changed, 151 insertions(+)
 create mode 100755 tests/btrfs/236
 create mode 100644 tests/btrfs/236.out

-- 
2.31.1

