Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153C549C5A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 09:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbiAZI7o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 03:59:44 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42046 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiAZI7n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 03:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643187584; x=1674723584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CLtNpb5t3XOROz7kwxmxqfsnZe+aHLTKijLXzbNQCns=;
  b=XiqdeWnO3QchfMf7nl68B9zTeJFyN6qAPX5kregjh8y64U1qgPE+zWi+
   5QoMulLfmzV3Wz6veRVcNRmJlCXtX4QY+pd8LtkefGqtqN674YjWOQNRV
   G9QTgkGNU7GoPwCTDbmPc82CJ6XbtJYa7QzBIn6Hgb3oV6TpQ1siGTg7m
   YbQ7T66GusHhyl8ccxV8DK+3KykppDY879RflQU52t5jONuRDftxyU56O
   uJa2zyrwDOow0mc5Q4I1bTqccaGLgcHO55m3xWrLHqKqy6iKVx9zTS9dR
   tRWE2zG8cK50jXesBguq6mRP242fWejNwvjtnNmUmYhaAQXUQtVebJvEL
   g==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635177600"; 
   d="scan'208";a="192406580"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 16:59:44 +0800
IronPort-SDR: 4fgnGLj1xgsRsGyqI3Yy9Aeo19v3YI5kZXMbiNWjpMcrekNiNxafwDAvQhwZBc8CBY3lAbwVUU
 6cBliOt9Vpvt+d5aA595mVTHmNl/IoBmEPs+joLg4xdQ4hkCR0uEQ9QjWmWC29JOHBAsIkECMu
 2G9su3pVyvEmsksoUiHFCsWBV9Xua6Grjb+q8fwZf+DvjBgiyLQiMjP2XicNLqgUj7YcShRSZC
 VypGtsjEocp1gtXaoMcuF0thvRLOR6DU6ULl4nNwKpHjn8fo0rpa2o6gtfeTFhR3yOX4uxwNj8
 2ILo+zmXxmpHpNgamZknDFcw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 00:31:48 -0800
IronPort-SDR: 1nyqVzBK4hxkJ+End4+oOn/K/UiBLiJg9HtnFnQX/jK71zNul46I3mzChEWo4pKUngHpZIqNdj
 3JoQHTyEPQLay6NM7MUOrCzLdP489kmsxteciP6g7cDHYdrHJvC3IvyQIGqYhMP4N+X3nBbg8V
 HunIvSbXace5G5MWoD91YTjOE3GDZAWu1U7/bezO1wemKZK/OQOfg5bErian6j5iieEGKP8ixj
 YIU/Ir3LPWJY26SENBUIFPBIoQeUzQrkc5L5582O416O4U/HL8ba/pkfiRq2nnVEBq7WWpCDAF
 EQc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 00:59:43 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: implement metadata DUP for zoned mode
Date:   Wed, 26 Jan 2022 00:59:29 -0800
Message-Id: <cover.1643185812.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs' default block-group profile for metadata on rotating devices has been
DUP for a long time. Recently the default also changed for non-rotating
devices.

Technically, there is no reason why btrfs on zoned devices can't use DUP for
metadata as well. All I/O to metadata block-groups is serialized via the
zoned_meta_io_lock and written with regular REQ_OP_WRITE operations. Therefore
reordering due to REQ_OP_ZONE_APPEND cannot happen on metadata (as opposed to
data).

The first three patches lay the groundwork by making sure zoned btrfs can work
with more than one stripe and the last patch then implements DUP on metadata
block groups in zoned btrfs.

Johannes Thumshirn (4):
  btrfs: zoned: make zone activation multi stripe capable
  btrfs: zoned: make zone finishing multi stripe capable
  btrfs: zoned: prepare for allowing DUP on zoned
  btrfs: zoned: allow DUP on meta-data block groups

 fs/btrfs/zoned.c | 162 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 105 insertions(+), 57 deletions(-)

-- 
2.31.1

