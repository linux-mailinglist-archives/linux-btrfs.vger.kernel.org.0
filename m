Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733424E2DA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Mar 2022 17:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348152AbiCUQQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 12:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350972AbiCUQQC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 12:16:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853ED2125B
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647879268; x=1679415268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EF0oN8nIwAo4PrGLqkebbUebX/gL4WF+IspfD6+L/hg=;
  b=Gq6EfkZJ0+bSzHv4qy1b0XVH71pQlc0vom6MhWbPlSc9sHUpXTXwX/5r
   04IZRQCCegzqjLUMgs9gZBhRhgN2uMnT7xj+1E8uODL7OfzkDdGnPyDhw
   NOP0PpUQyvmP2p+SixPgo7OAkx5h3IXfizLhDRLlxDe7jgw3H2Dag+E2P
   onmWFbGCFRBm7wqiqkbLqDJGW2Hnj15Y8ir73RFGudjwEI6NgI/7/v4WB
   TYUDTpL9la+5h698qwvssqJcSGGWjeqXr+KIwfr0rZvEqi+GIZsyTtr52
   QIqHMyfhRZ+S67jxTHA8kq7tsCrWY9Qb3qeIuDhVWvucTaoTLvmJtVy1H
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,199,1643644800"; 
   d="scan'208";a="307836344"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 00:14:27 +0800
IronPort-SDR: GHw/TDvpZAEoow5VuHB7eFh8XHaT2Z5EZiBO46v1IRYRByzY/5417CHqBCRF2HkoY28Y7MDTCV
 fNTxhaO5TR5PTILGUVge+OaWqJvcjz9xADpRxfWZ0pIT9ejC5Y8QRteTgKCQT8KTrE7TNc7OK0
 Onfb/rUA43lYRc+D1jXc7FgXFAZnOp0AGEXXXRLCfnzOb9nL+bkFPtR08rGzvG0jSsPKW+E+Yu
 1jDO7a7E2WecsltZVNfhQpVl8nv78+YMP8YHeHEWhsu7od5FupnlSZRtvalfeu58yBYUKZWoDd
 o+YiRN/p6VR1BxU8sOJQL0mr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:45:27 -0700
IronPort-SDR: gHIAgiRQqOv6GmUKUB4I8CZzfuUxLnMtmQEiJI+zHh2WGBAqOYQtNtPM0Uatop/OW8877UStok
 rkHyngRjjIGwQuMxhnFboPbBxo45Q+oAD05EWSg52ghrtk9ph7ngqzlTXgW4ULetvsUKrfGyRI
 lcjA+nvcOGdSVLYYNF6LNLulGVbPo+GVQltetmYh6qmlzyC7LUi0D8PYmYXNFaZpV7A/6a6PU1
 38IdVRHG/DgnUDcjTsLkAkzUS19XrOTJUSgddXTfpHNioN/tpxKNA8KKeQ7usyNVsdc/EZ7YjP
 rFI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Mar 2022 09:14:26 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/5] btrfs: rework background block group relocation
Date:   Mon, 21 Mar 2022 09:14:09 -0700
Message-Id: <cover.1647878642.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
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

This is a combination of Josef's series titled "btrfs: rework background
block group relocation" and my patch titled "btrfs: zoned: make auto-reclaim
less aggressive" plus another preparation patch to address Josef's comments.

I've opted for rebasinig my path onto Josef's series to avoid and fix
conflicts, as we're both touching the same code.

Here's the original cover letter from Josef:

Currently the background block group relocation code only works for zoned
devices, as it prevents the file system from becoming unusable because of block
group fragmentation.

However inside Facebook our common workload is to download tens of gigabytes
worth of send files or package files, and it does this by fallocate()'ing the
entire package, writing into it, and then free'ing it up afterwards.
Unfortunately this leads to a similar problem as zoned, we get fragmented data
block groups, and this trends towards filling the entire disk up with partly
used data block groups, which then leads to ENOSPC because of the lack of
metadata space.

Because of this we have been running balance internally forever, but this was
triggered based on different size usage hueristics and stil gave us a high
enough failure rate that it was annoying (figure 10-20 machines needing to be
reprovisioned per week).

So I modified the existing bg_reclaim_threshold code to also apply in the !zoned
case, and I also made it only apply to DATA block groups.  This has completely
eliminated these random failure cases, and we're no longer reprovisioning
machines that get stuck with 0 metadata space.

However my internal patch is kind of janky as it hard codes the DATA check.
What I've done here is made the bg_reclaim_threshold per-space_info, this way
a user can target all block group types or just the ones they care about.  This
won't break any current users because this only applied in the zoned case
before.

Additionally I've added the code to allow this to work in the !zoned case, and
loosened the restriction on the threshold from 50-100 to 0-100.

I tested this on my vm by writing 500m files and then removing half of them and
validating that the block groups were automatically reclaimed.

https://lore.kernel.org/linux-btrfs/cover.1646934721.git.josef@toxicpanda.com/

Latest patch from me:
https://lore.kernel.org/linux-btrfs/74cbd8cdefe76136b3f9fb9b96bddfcbcd5b5861.1647342146.git.johannes.thumshirn@wdc.com/

Johannes Thumshirn (2):
  btrfs: make calc_available_free_space available outside of space-info
  btrfs: zoned: make auto-reclaim less aggressive

Josef Bacik (3):
  btrfs: make the bg_reclaim_threshold per-space info
  btrfs: allow block group background reclaim for !zoned fs'es
  btrfs: change the bg_reclaim_threshold valid region from 0 to 100

 fs/btrfs/block-group.c      | 41 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.c |  7 +++++--
 fs/btrfs/space-info.c       | 17 +++++++++++----
 fs/btrfs/space-info.h       | 10 +++++++++
 fs/btrfs/sysfs.c            | 37 +++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.c            | 23 +++++++++++++++++++++
 fs/btrfs/zoned.h            | 12 ++++++-----
 7 files changed, 136 insertions(+), 11 deletions(-)

-- 
2.35.1

