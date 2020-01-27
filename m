Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F71914A79F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 16:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgA0P7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 10:59:38 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39162 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgA0P7i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 10:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580140778; x=1611676778;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q81nV/Ve647iTm2w7p2/7yB+AMs/hw+ic+RERsphMj4=;
  b=SHRwoMGK3labSPdzJBy1CpFjQiEmi/59Dp7sGYnCOsqB7Yvd0Ge+VY/D
   dEbZ1lukfY4SVmbhT/yuUWhmP4jIcO5CANFPMugxOtYeYdfo8A2TfLwHk
   XrJQ+qLbvZCeqbwDRaNfQc3ospxDAkeqrftbUT894I84++1B6J4yAXXQw
   tceDx32NblSaO0j9OmC0+FhuM8WsfWQkwv0hNbm2mz1WcbemvOsbSGmqh
   pICRQrQxOgm11VdvF/vuhLskypT4DC1DxwQf/DO+bBhSbL5jNkEZZGDWz
   aZIxPOLakH5zOxU1li4zuZfeLzVwBpTZikMT/qFdJIkE8za0NfpzpCnbX
   g==;
IronPort-SDR: ADqmRu/IpxUXVxeFvzL0Z6ps3gOKxqgtgk24I8vb8t52wZQjUskxHE1Ls0aRMCr5gx4hO3nIj/
 rzR8Y2/AcPcIhVsi+W8nUfr7sfL4dAqZONtJa+lo7mgo8mmwMWHoQkBu6iGQU/NYs5QB1s0DUB
 JmMpgc/y4iRF/Ph02kj2T/53+Bxxd9BOb2n88VV2PySJff8jHABVsHebKr582ijr/K/+gZRZSD
 WNckJgSX9MI/NaI4WDaNO9vWdpIsJOKu5JEe2tsh9PS8PNRuxUy/+8sR17L8vToFjiD6xNo88h
 x9g=
X-IronPort-AV: E=Sophos;i="5.70,370,1574092800"; 
   d="scan'208";a="132851972"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2020 23:59:37 +0800
IronPort-SDR: Oe393YyPFIV4iCZLONbPAZxEt4OY3yzQd0jVJVJNfSMMNQMehl/7UdqGL+uhudYAkrSSCWfj0E
 j624ThqNdn9g0HluFwRjaw7lPUfhMnUl6vtGOgMJbNZY9L6LCXykNyXnuUf0DnzBbrV31eekp+
 GOxPwyblD3XIhvqTYjiUTYtdC+d2BiQE7kX+d6IT1IzWccacIe0ynlrPN/QQFkz8KFaq03e5SJ
 ZLh5I41Ft2WaWyYuNTijVBLhjPS+OJ6elvJ07NyihQx8NB/zaM4ukM4A8L5C4+2GCRi6Sn/NsE
 R50bXl8YHJRzRdFqJn2lCbOI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 07:52:51 -0800
IronPort-SDR: DH06aD2lpRUanI2Wwrl6N9jMKTRHSeLn8jjMwexbqCsUM2Pg0xaCjXeWFJjQvEMyMG+ous5sa5
 Nxtyo+zK3/00fOS07k4aaXfhPeD1Xiu5jFXCmwNaI/HYA92RscYaYQH0jWvPckgbKIebdLkTDW
 PXc95cGWdI9Zh+NpHfJ2tljHh8cOPYRhXuVK3f7hRFUrWuHXyWnSpjZ49S1++E2GJM1uAUAFZC
 PGE9ExkVRdeq3qZaTHTKlOBkHRvyb5mW8IOQfgndk0fbPD3oz000KwIp/4tRgCZ6Fn9OdLScgZ
 jn4=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2020 07:59:36 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/5] btrfs: remove buffer heads form superblock handling
Date:   Tue, 28 Jan 2020 00:59:26 +0900
Message-Id: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch series removes the use of buffer_heads from btrfs' super block read
and write paths. It also converts the integrity-checking code to only work
with pages and BIOs.

Compared to buffer heads, this gives us a leaner call path, as the
buffer_head code wraps around getting pages from the page-cache and adding
them to BIOs to submit.

The first patch removes buffer_heads from superblock reading.  The second
removes it from super_block writing and the subsequent patches remove the
buffer_heads from the integrity check code.

It's based on misc-next from Wednesday January 22, and doesn't show any
regressions in xfstests to the baseline.

Changes to v2:
- Removed patch #1 again
- Added Reviews from Josef
- Re-visited page locking, but not changes, it retains the same locking scheme
  the buffer_heads had
- Incroptorated comments from David regarding open-coding functions
- For more details see the idividual patches.


Changes to v1:
- Added patch #1
- Converted sb reading and integrity checking to use the page cache
- Added rationale behind the conversion to the commit messages.
- For more details see the idividual patches.


Johannes Thumshirn (5):
  btrfs: remove buffer heads from super block reading
  btrfs: remove use of buffer_heads from superblock writeout
  btrfs: remove btrfsic_submit_bh()
  btrfs: remove buffer_heads from btrfsic_process_written_block()
  btrfs: remove buffer_heads form superblock mirror integrity checking

 fs/btrfs/check-integrity.c | 218 +++++++++++--------------------------
 fs/btrfs/check-integrity.h |   2 -
 fs/btrfs/disk-io.c         | 200 +++++++++++++++++++++-------------
 fs/btrfs/disk-io.h         |   4 +-
 fs/btrfs/volumes.c         |  66 ++++++-----
 fs/btrfs/volumes.h         |   2 -
 6 files changed, 230 insertions(+), 262 deletions(-)

-- 
2.24.1

