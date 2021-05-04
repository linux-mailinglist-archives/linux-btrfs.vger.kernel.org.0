Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A00372743
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 10:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEDIc3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 04:32:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37723 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhEDIc2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 May 2021 04:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620117095; x=1651653095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=01zJf/lWORTTE9xoddbcW977cq90wd/5ikkZ8539bKw=;
  b=TO6LLAfZr4HfazhPJR/tXR9kbxbcYUopzFuX0jyMehJ0LIxqXXxDr5U9
   MH4si3M0c3RNgcIjtljq2bPx7nVMaWTt3LTGqHQq8S/9lmT78ularjPJI
   xGSS3O49yKgMkgYS3xqOXKG0H2DLfrBNuByJQF7lNWnIn37V3xuSzyFUc
   PKRWUZ9YKBMeWVRdez1oEPlWqswIKj2kiQ7iapIdLUwLB6aMiO6JCO0qq
   BvC40/rPhJEPuLkrwDU/zxQyqS7Zpd1gb9VAWc360KxPnyGkm//31ZHE4
   niozfLXrTDfu+b7CTBiJZil6WnIQugatnep2OL1cJyR1VBnlF38UrtiwN
   A==;
IronPort-SDR: FK2CLTFa4ZcPKGxafPQBiqSyvxWzY0qZ/bKdgvmZ7ssEYtWOg2zD7Q2SgL1P5voefdYI37j8AI
 yuLRx6/IP9JWfQIOfFoW9WdgWNOm5WHjU0BtO/tVNZmoSc005011na8TkkcPg8Qsx5//n/V6y9
 9OReyvE6EP3BgfyJi2wv8tVrhw66cFifPS7ohfhABbibweSkMcpOddprlZPfGRXnzYYGWLGhY/
 pHJF1YBXynl9bZ2QB9MbVqQpkecwVSgo1fO5wiGQn0rHR7C0QancDVqfhJT5r6IKVjkuufHbvL
 k68=
X-IronPort-AV: E=Sophos;i="5.82,271,1613404800"; 
   d="scan'208";a="167613988"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2021 16:31:34 +0800
IronPort-SDR: eXVxQhwYST5Ze28Dc96XbdArZ3VJL98OTRNiGC8YDwqEzxwPH7o5zxA/9loqhzdbkla7VDUYAv
 42Ws1bFaj56Y9tETO890iRm/Ns/97doFQbusW/g/zm+neLNUW6wMnuQwkTo895fIwXUFxc4c1l
 D3WWEha3KAJ12eU4dPHEX+xJflSq6rB2mOajik7O0DxJOI6UxcS/Hghs0QBBNdSKPfbEbhLR3f
 8Xwv0YFPJfANsB4GE7ugxb/vh7H92+w8J5h+lVmViz/Unx9w3KOvN5/hHvd+OnDqucksxZ2O9R
 ca3BOmmIlU/VEWTFngXIk9iO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 01:10:17 -0700
IronPort-SDR: 6gJdQlUHN0YNq9EEt2Bmq+3lOTqz3B9kUsSIzgBEEitMFht+bHNhpcotFlUT9UCz6d5EbS4m8g
 Ow+S4jvpVUdE6OoowRSWaz5h9+vddU6PGVSjcfNwnHYb/VMC6sLCejQKNnbtioIHWBHpSc+RIX
 9cIXAAQ/nZvlD2a7NemyJW+UA83bo3lfsfVaVjlAB1/Q2CAZW9hwLtE1HarqbRTPmGdl2dvZqQ
 agrGmcfnirZYdY4VVd4NZtvc9KfMtui6tjEofMZEYSqitCYj7y4lS8PXHli+ckRG7SNtlWId5o
 Hao=
WDCIronportException: Internal
Received: from 3x7y6s2.ad.shared (HELO localhost.localdomain) ([10.225.32.59])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 May 2021 01:31:32 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] btrfs: zoned: two fixes for generic/475
Date:   Tue,  4 May 2021 10:30:22 +0200
Message-Id: <20210504083024.28072-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although generic/475 uses dm-error which is not compatible with a zoned btrfs,
there is nothing that prevents a zoned btrfs from running on dm-error.

Changes to v1:
- be more verbose in the error messages

Johannes Thumshirn (1):
  btrfs: zoned: bail out if we can't read a reliable write pointer

Naohiro Aota (1):
  btrfs: zoned: sanity check zone type

 fs/btrfs/zoned.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

-- 
2.31.1

