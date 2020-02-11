Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA97415928F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 16:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgBKPK3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 10:10:29 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35875 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBKPK3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 10:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581433829; x=1612969829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z6/oNl5fCqrWsZv5kCRdk5Kp8wD8KPTsVVg8kwy+imA=;
  b=DEeM07CKIctRXUhBiQpDEOcpKvTkDJbYhhuWEgbeAEV8EU/VUb7j3Vm4
   uWHb0/63Y7hrZz3ffX+8jm8FzBlxxBqNZ4WR1lswhu47DCqml0+4fF661
   Lp4PeIhBnZwzevmQpH5lAh1uHPla7pHKVfP5hEUzeux8y6h0DPixBXRq0
   UKiBDPqxzwJ1WJbon40/tQM5yJriltc3CbeXvPBkNvDhx7fzOTBwK6Lh+
   c0wQLaid/Bjqe1nkxuFeGh1pH98l1lX6dcm6ERVBW2Mj3QRPiLsZV5b6o
   1Hrs5eSK/c8w3YEge+YhzKmn5d2mR98QkBdd+5OlN5M+dZA+OIjhW62+g
   A==;
IronPort-SDR: eIR4V/GoNu+uofO/NAhlSLWcfwjMtqmlYLx5DA95ocih8FmpvmTQpk9shzpBclF1VFEWTkLVq3
 ByGjV1dKnWiuZdA3i3lakRevxpScWXnLxZdsyIgaX5X9WrQSKlluRsF68BYbEMF/VCXP1t/Yug
 HO1NoMEmtZfzcRIqb3jh+d4aIQlOhZRn+CgXUfVIXJPfqOYpdCpGdNxNJ5xXIwexiLTdON2Sqw
 tkvvrO4AhQ8ix0RE4phLjAde76ht9iOuCpbKDTMpWGI08Ju4ZpIxtecKTS27YOh7LHvL1913cf
 WGw=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="130128669"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 23:10:29 +0800
IronPort-SDR: TO9k3NPjHzeFIz16rorxjjD9yVkDo0FC2gbUnwVmQp99JWl0ATP1/cadPix1GkTq2OKWPGa/7i
 sGZtJKH5xvHRhfg3s1BBMqj3z39TIeNj7QaGQGPQtJ9ReOsJxh/XgTNUR/GCye6tOlqquT3PZm
 mOSHMnZMgn6qSqykF4iADgQVu20q8K46tEXe4sB+QY1h1IR/aI5joZRiolGcx/xS5aOb8V6E53
 IJsW8YCVK+U6g6wGm2b1CBgUfJ5yDzKlJ3nOp+uGkoragz+U6ZD3+Z/0z1XrhiyOznNswYBjzp
 LwGBh2Ll7LO4glsmGs5Ec1fM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 07:03:19 -0800
IronPort-SDR: 7quCl7yGqMn7H3ZhsCIqnoOOpufLuMZp8/IbCdbfGpG35PM6pRLyqUex80FAClirHYTeKQ40uh
 yUUwq2X3wa4SC5BJTo245YCOmdcWB3LGio82k+/wK49B+aPQOOn698KH5TwgzSjgVH5jCs1Tlw
 xnCam35KzWCWcWlayRbJAg/yoO6nt7unljYugI8aJrsja+i6cd/ZfNdpVIClNEcEuPalqaRmUE
 IJnAUtCV0juUiBZVM1jhv4Y2Lf/IENoRC3swyflYxWOYDNDr+j6Q3hE0WuStjCti7VOkvz3JuZ
 UDQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 07:10:28 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/5] Fix memory leak on failed cache-writes
Date:   Wed, 12 Feb 2020 00:10:18 +0900
Message-Id: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fstests' test case generic/475 reliably leaks the btrfs_io_ctl::pages
allocated in __btrfs_write_out_cache().

The first four patches are small things I noticed while hunting down the
problem and are independant of the last patch in this series freeing the pages
when we throw away a dirty block group.

Johannes Thumshirn (5):
  btrfs: use inode from io_ctl in io_ctl_prepare_pages
  btrfs: make the uptodate argument of io_ctl_add_pages() boolean.
  btrfs: use standard debug config option to enable free-space-cache
    debug prints
  btrfs: simplify error handling in __btrfs_write_out_cache()
  btrfs: free allocated pages jon failed cache write-out

 fs/btrfs/disk-io.c          |  6 ++++++
 fs/btrfs/free-space-cache.c | 44 ++++++++++++++++++++++++--------------------
 fs/btrfs/free-space-cache.h |  1 +
 3 files changed, 31 insertions(+), 20 deletions(-)

-- 
2.16.4

