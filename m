Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191524E8E36
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 08:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiC1GbL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 02:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiC1GbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 02:31:10 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5491162
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Mar 2022 23:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648448971; x=1679984971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lha5qhLhUobRPvfodJrHsvkGGiEhI4a3hdFH66/rv30=;
  b=AtGSY2wzBgjZXj3QcFrnz74gk0Ji2xkn6VVBcYMqPO44jELRPfn7Gc4J
   gmcK0sADPc7EKe8lazkOZoNc6P1brp2UrTlsFyjpKZxjEmGJ3mwfucc3A
   DlC+lREO1QXyb2ZRiJKrwxiQ512cBYwevDSvaNLMhPrxUP3wsGtuIKOXH
   xX2hD2414fEbEPPicRIea9GR/XqJpeWGWAccejPF2o/OGS2ACGyJCx3l1
   TfEU7E/uAHy3ACNjn2WPO9EBvFNdUjJE/q+i7/I1FzLLqfRY8IsGhAgn5
   qE86OF8pYul4UpLypvtt3g3nOyR5sdbI7s5lnrMfKUsjSGvv9kie5e5zW
   w==;
X-IronPort-AV: E=Sophos;i="5.90,216,1643644800"; 
   d="scan'208";a="300566279"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 14:29:30 +0800
IronPort-SDR: Y8IY9EiY2EiUkuOQDdhf4EpSxxp5boqhCilqdj4MR5zZzFkthvcbYtKtT7gHQWX521lvzPF8N8
 voTTI5C/GvkcdMgvqnOQycpl/7545eJ9dua32Yr4w4ekEXut7ADDU8hCpOkZ+uC+ecGAwxV7kr
 n/suhTBUQWaNqCwuReG1jm+KYam7bL3CDmPDklpPyU/nqHsAE9OcbTlBM69LFUUkoZAQB6lbID
 pzGkiuML+hyH6b9UhHQH/F7awYi5VGIePn5QEOBsZimPlhUSKL9ipyvru98jneFxqiggnbZXzQ
 A3RLUi9X6ZK1dQ1iCy50UU2B
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 23:00:23 -0700
IronPort-SDR: 1j/KtO1fatvIwiWxq4RcQcB/xtQerUfUsvDYfkXg1kjvIwa+NoG/KzPuj3G2vCMbff+Kbv0jxR
 wx4pDThXAwOMtEEBcfKZgB8YfAZ2S6deD7k1MRjFj8uWuscmBkZxpCnIuxYy9qymNQYliPbO8j
 ZULS1+q9ZdEU6+kJJ0fhDLNLRXzmFW14XwuZhG0vOjC3Ihst8ryRcvI1xXYJGtGl8q8q5/katm
 WkqskbP33BV+8QVGTns6VaZ+R5u91B0CO3ztHhzdPmqSZtGXE4iuKaqOAqRLCbuy7LjjFeujFt
 yeY=
WDCIronportException: Internal
Received: from phd006511.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.242])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Mar 2022 23:29:30 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/3] protect relocation with sb_start_write
Date:   Mon, 28 Mar 2022 15:29:19 +0900
Message-Id: <cover.1648448228.git.naohiro.aota@wdc.com>
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

This series is a follow-up to the series below. The old series added
an assertion to btrfs_relocate_chunk() to check if it is protected
with sb_start_write(). However, it revealed another location we need
to add sb_start_write() [1].

https://lore.kernel.org/linux-btrfs/cover.1645157220.git.naohiro.aota@wdc.com/T/

[1] https://lore.kernel.org/linux-btrfs/cover.1645157220.git.naohiro.aota@wdc.com/T/#e06eecc07ce1cd1e45bfd30a374bd2d15b4fd76d8

Patch 1 adds sb_{start,end}_write() to the resumed async balancing.

Patches 2 and 3 add an ASSERT to catch a future error.

--
v3:
  - Only add sb_write_started(), which we really use. (Dave Chinner)
  - Drop patch "btrfs: mark device addition as mnt_want_write_file" (Filipe Manana)
  - Narrow asserting region to btrfs_relocate_block_group() and check only
    when the BG is data BG. (Filipe Manana)
v2:
  - Use mnt_want_write_file() instead of sb_start_write() for
    btrfs_ioctl_add_dev()
  - Drop bogus fixes tag
  - Change the stable target to meaningful 4.9+

Naohiro Aota (3):
  btrfs: mark resumed async balance as writing
  fs: add check functions for sb_start_{write,pagefault,intwrite}
  btrfs: assert that relocation is protected with sb_start_write()

 fs/btrfs/relocation.c | 4 ++++
 fs/btrfs/volumes.c    | 2 ++
 include/linux/fs.h    | 5 +++++
 3 files changed, 11 insertions(+)

-- 
2.35.1

