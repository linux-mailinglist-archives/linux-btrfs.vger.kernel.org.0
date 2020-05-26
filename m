Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953541E23FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 16:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgEZOVg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 May 2020 10:21:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15674 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEZOVg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 May 2020 10:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590502895; x=1622038895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Vg8ByXNMirVH+KYy2/prxpv2O/CQYC3LADm4k/WnKs=;
  b=AydyPJtyvui9UGukAhM2WQuNU+eWnq4gpPi184QmKUzDOioMkSZrwFIq
   wPbhlDJvETliCUlo1etFUJApg2sDhi9ul56cQM817LOQUG3oncTSc3Wkx
   bvtPvPzL0PTmzcb6R8T9WavEcmhSMtQPfUenBsrsyZE945ldriMp0e0wB
   cDXFJGLL+jXv8aEqpsth1s97xdXT8CbPJ2Rhdgdm32H1xYRl2K4qmZLqS
   JMuGfkY1RuFgSnW7bVSpiQvlj9XPbBu5/gYAVDpEDMquzLZSi9TgnchbZ
   Af3BQzCQdrh77FWtgGZG9xnWJAXnb42dzQCZTVPGSK7yjCzob9h9KXINh
   g==;
IronPort-SDR: qq7L8uKLjCtozqPesseeggrjI+Va8oNjzyDlNBLj8Z2yTdib/lQkKkh1x5DfbRFnYovHQp+IWn
 4SZrVIJ9Zzta0vgLzMj8qOEVeQep4F0eIKLUs6neea81XBBzWMh7LjagiHZ0mpY6N6Q9AoXZjX
 jP5E7mCsIJMewerG67vLl/xGYBwghOi1b7u8mNKCDhBIduuCovsDCAG7NqNpdBSPakUxciKT0D
 SjtPpyUilHBhm9puj2Jc9eRE7dSBtRd84uGGqwPkr4cBwZ8Fn1M3rIyoxS/fxqn+2aCrMy1PH7
 LGM=
X-IronPort-AV: E=Sophos;i="5.73,437,1583164800"; 
   d="scan'208";a="247571873"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2020 22:21:35 +0800
IronPort-SDR: ONweaomnSLpeLRSa08owHWZPtcTgyGynlenVFS5dB+8wvCWo7NzCxsMHHzfqElMcF4z3x4/6XO
 uToN0/YT+ZzIV/x0nqPnVll+IfRsfCl8Q=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 07:10:54 -0700
IronPort-SDR: xKInQMTTY5oJkjOaHGxRRbxA0E+bkVhuyeFSIWSquEENfWntF45rGsYqvp3xe7NIhIhjKQhBqZ
 ZzDkj3WX9qZw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 May 2020 07:21:34 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/3] 3 small cleanups for find_first_block_group
Date:   Tue, 26 May 2020 23:21:21 +0900
Message-Id: <20200526142124.36202-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While trying to learn the Block Group code I've found some cleanup
possibilities for find_first_block_group().

Here's a proposal to make $ffbg a bit more easier to read by untangling the
gotos and if statements.

The patch set is based on misc-next from May 26 morning with 
HEAD 3f4a266717ed ("btrfs: split btrfs_direct_IO to read and write part")
and xfstests showed no regressions to the base misc-next in my test setup.

Johannes Thumshirn (3):
  btrfs: remove pointless out label in find_first_block_group
  btrfs: get mapping tree directly from fsinfo in find_first_block_group
  btrfs: factor out reading of bg from find_frist_block_group

 fs/btrfs/block-group.c | 103 +++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 50 deletions(-)

-- 
2.24.1

