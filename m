Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3DD7A7794
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjITJbk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 05:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjITJbg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 05:31:36 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EC283;
        Wed, 20 Sep 2023 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695202288; x=1726738288;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=sZ5Dr2PiQ6q5nHhudDrxu+4wUrbRZ02g3sCCxtq5yNQ=;
  b=UuRerGVU5JXPOzlFyGjGgkaYhZP9nQfhqHcL+QOSTjVp2k2mMMPCzQOe
   qODeqnw09l1pPcCxrzytqpnTHuY/0PCtBt9tBcfehWcRPKdoP3p3MDzLn
   mFlF95TzoOFdRv39hxzq1MO5v5ojUJTEVvhi4OCRpYH38JVoF4Ls0Hw9n
   7XQSA3jUvtTlHu42RGYhDO2rrzQFi3V0qDDWRrapl2UVSFMlRiV3SpFTW
   N4NJmcVOTgiQ3PPtvAugv4iAiun8tQMvoE9hv3jlnt8IDAyi1QwMzDx6R
   PNZ9p2K6qfFXyH4yQdyo7U2lR/M4LJtiW3VYihGo4H5txZwvN6tHhGk6g
   Q==;
X-CSE-ConnectionGUID: cqR4Wp7zQqmoNHUOW55ulA==
X-CSE-MsgGUID: 5f6UnlOES3qUVb0+LhkM5A==
X-IronPort-AV: E=Sophos;i="6.02,161,1688400000"; 
   d="scan'208";a="356502793"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2023 17:31:27 +0800
IronPort-SDR: km4BqbOke2kX25R//o//mcqH9/phPynzIu3ZFqmyGDVFNHxRtcaNbdWq64Y/HuWpJkKIE1T8AH
 9N/kU8PJ3g4Ly9fx+O/2X7JHT3iNccgnX6HRl4YobfnJQ3k7LFyc9rhN5gdL0jgmlXGAIRWW3a
 XRdBmdCRyqMdKfEpp6guUBFFu69uytJepB9a1aYrvaq6r+5TKjptUiynnmMeaIAsbgbeK3/xbP
 XvY+GvgJHQsxCV5ygpy0keispACwsQAlK+yfK1BXmdv37hBQ/l+LTzR9AU00vR/P/nmkqKgSFt
 rL0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 01:44:02 -0700
IronPort-SDR: ZXb3lM9zV7b2lXlalP0AxfHR9zGRpE0df1zihYSq/jLgMD5p8xfS760bpUXls7g3MS/fFSCY3U
 3/9P2QYeB0bv6kQdhJZL2OiFBzaRb63gcq9Vh57OzGpD7bOWYzXrj2UELp50gNdgISw4/gdEWP
 9lRDK9DeYIYgXGxgx4KimX9O93pnVjLWlTODOaPNhpcu7uMxeTvJSxeVhJ6UZNzwLmDp4bWoZs
 c1bSXBhKPAd20rOFnE1KpnJiOu5ZN/TMQMdOaXJWEHxgucw41cyVmt6kvvEh52jY0ejaohD6O2
 2KI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Sep 2023 02:31:27 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] btrfs: RAID stripe tree updates
Date:   Wed, 20 Sep 2023 02:31:16 -0700
Message-Id: <20230920-rst-updates-v2-0-b4dc154a648f@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOS7CmUC/1XMQQ7CIBCF4as0sxYDWCh15T1MF2SYWhaWBipqG
 u4uNnHh8n/J+zZIFD0lODcbRMo++TDXkIcGcLLzjZh3tUFyeeK9UCymlT0WZ1dKzKBSnWnRtjR
 CfSyRRv/atetQe/JpDfG941l8159j/pwsGGei00Y75Nqo/vJ0eMRwh6GU8gEhqxWApAAAAA==
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695202286; l=702;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=sZ5Dr2PiQ6q5nHhudDrxu+4wUrbRZ02g3sCCxtq5yNQ=;
 b=NqTu5Edo6aGVOd75o+fj3evWKXTVEfIt6sI3nKaGICTgBjz84lmugDy13wvqN6IlYpYhskafx
 2nEjbbo8QVLDX5q0vtCwR45yMZw+KNWZQ9GwZNtZDBi1r/7ZPv1QQqQ
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is the second batch of updates for the RAID stripe tree patchset in
for-next which address some of the review comments.

---
- Link to first batch: https://lore.kernel.org/r/20230918-rst-updates-v1-0-17686dc06859@wdc.com

---
Johannes Thumshirn (2):
      btrfs: check for incompat bit in btrfs_insert_raid_extent
      btrfs: check for incompat bit in btrfs_need_stripe_tree_update

 fs/btrfs/raid-stripe-tree.c | 2 +-
 fs/btrfs/raid-stripe-tree.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: e70275b918d304c9687a91e990a8ef440658c3bf
change-id: 20230915-rst-updates-8c55784ca4ef

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>

