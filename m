Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537F07A16AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 08:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjIOG64 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 02:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjIOG6z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 02:58:55 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D62D44;
        Thu, 14 Sep 2023 23:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694761093; x=1726297093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lxGzvWzbTKQ2Sj4zdJMywrN9FqZ7L4CQgJPKJgLEhRA=;
  b=MKB1mJyEhEHDrZn8CUkqRYaM3U8RwGoMYfoFxFLFMjWn6yobq7+OUEBV
   +hbuknC3werEUPtfVHuDX8s38t6PCElF3//lhIVBl2SiO7zhQPWwjClaX
   3UpXz2zn4uGGi8QAth0YosIdUmrkeJQUXQG83ph9MzKtPibIriGsj4ZBe
   hiLouspmJ/W6VYrycjS3JusMp9w5/aZbXdzsqJzOHPRGHNYVGmGUljEML
   h2pRrIIW5dGF8cD7hiiRLZH47tcBHs6rp7l6UlRdZMKjYIjBL7CbaK+Oz
   gVYwE/9MwCTEzRG72bKC8eGpgwygErW8rDDNT1OLymrQCQKc/9R3Tb5Wm
   g==;
X-CSE-ConnectionGUID: ja26uOMIQ1yJDKYY7SWuDA==
X-CSE-MsgGUID: vIygUmNOQjiNmTSKwi859w==
X-IronPort-AV: E=Sophos;i="6.02,148,1688400000"; 
   d="scan'208";a="244368680"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 14:58:13 +0800
IronPort-SDR: u76Q1DxDyuuU+pmgiAN7zcft50JWpk1+9IsT7RWOhd4Uygly6F1ZnQOrq1k7u8k3IWrjfwvnCW
 MvjXs/xIUYy++EY/37obK1rzFix81GTGSRqUtMHRjH3yCK26U6OleK4odf38UpzNwaJEwGdNB9
 vGu8Rnux8scfjp+bMaIw6mVg+fzZErNUGCDByGqZjGF7vqFSQyCVRSos/pUzKAAwoQBryx+D2k
 aios2jyzuLja1FUf5jgJcDlKUCt9dx0nM2QCz3NnFAvjKv6HrpKCNKvjsDjcin9RAr4gQyfW/y
 1KI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 23:10:54 -0700
IronPort-SDR: 0l4LyZd4brxN/g7Ca1lKFo9HeeGQpFdg0Ep8H3kAKEviO2orl3hcrBFq/oyyJ2Tk4wCVhVSVTD
 jnQ/GNhU9dkJDQkkIt92vfkvER0tPW9el5Rv6yO6wpRkxlzkUo/Qrw+P+VXXZBBgtY19HxoQ+x
 up4gQ+h/PvV8N2CGfWlKzGrjEO35o/xoprecFWUMqYUtvREgxPhWQWfYOiIP53NTdSNg3O2yvd
 +GECNxekpM/bj/y6EIboTSIEjchnYqqr3GUWDCWIkKW5JA2Z3c7X9cdT/2rB7dfg7MzgUZ4LRo
 T/g=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.78])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 23:58:12 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] btrfs/072: 
Date:   Fri, 15 Sep 2023 15:57:58 +0900
Message-ID: <cover.1694760780.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running btrfs/072 on a zoned null_blk device fails with a mismatch of the
number of extents. That mismatch happens because the max size of extent is
limited by not only BTRFS_MAX_UNCOMPRESSED, but also zone_append_max_bytes
on the zoned mode.

Fix the issue by calculating the expected number of extents instead of
hard-coding it in the output file.

Also, use _fixed_by_kernel_commit to rewrite the fixing commit indication
in the comment.

Naohiro Aota (2):
  btrfs/072: support smaller extent size limit
  btrfs/072: use _fixed_by_kernel_commit to tell the fixing kernel
    commit

 tests/btrfs/076     | 29 ++++++++++++++++++++++++-----
 tests/btrfs/076.out |  3 +--
 2 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.42.0

