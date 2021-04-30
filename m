Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75BA36FB95
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhD3NgS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 09:36:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28821 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhD3NgQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 09:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619789728; x=1651325728;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t9sHQHGEhBHDTtkIL6PjbPpu4GTvYD9MYHr9+5I+09A=;
  b=U9US+gi+Fi0OHwoEo7F+hX/i3XeEELGNUjQ8qhAqxQYSMrs9nk9UnnzT
   D/Ju+Egz29c90cdGn4aAMY+IyHQ3yVSRBqITpyNu9Zdu3slNz34Tkkgoy
   xROI4BRNa7gHQvshexZwM4J0WYSovDZWoQK+HSW8jtiV+lejh6rLw8Yok
   KLyM50pT8sGpGf2KFxWT5HHVDmPZouR9PZ3B5u5ZHHmmPg4utOy68LSKv
   fls4IWq55TRum1Xma+VvZFSVk7KQ4QrnatS2uU3CmwSLR86sAhno9w2yx
   yUZTdgvbbFkk+4nqzR8PFlfxIkvJ/ZjZB/Yr6bpngqXSFGjqjOL6eZp6/
   A==;
IronPort-SDR: zeRkATZHzLpiL1H/RZQ10dOPMroShbv4XxUvV+OORIjrv4sCgsvsrpAW1ne9BTmlo+cL+KYsYT
 0YoE8I1aFO7O7uMkBilr1AOdvW41dxbBMt0opWaZI0d48M/xI2S+VF3OmDHGr2QAyCqDUrKIvC
 l6RFK5xBub9zBIp9Dj+0cyjSv90dLSFHNsJ4oxb7qO/aukqK5zYbnduYwa/9RClXiUZLWaXZiJ
 5EoWWNInqXWch5fRV/LF8lQkPUs+nnpCPDGuPjzMXkPCkA30sIuisyu2S6rHOnKZWiYy6J54xh
 IvU=
X-IronPort-AV: E=Sophos;i="5.82,262,1613404800"; 
   d="scan'208";a="166128992"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 21:35:28 +0800
IronPort-SDR: 1KQO7m117dTyHppKCNZMZFByS5EYac55MHHc0CAidne6JbgMLtpgHiuiQHqPxfT0ggo9db63R2
 sXI3kzSIjDdCWByr6JE3+ZBBGuo/YekIMZfOC5H8fiHiucPo+8EmqbRGXujMu3dipoQ9cvt0Sy
 M7rXPmW/QCoFb3eVIVTYs4ewL7LdRIfKcYGIhl0sTlZjbW++vM2J6jHHaLxPrQ5+r6b77S7VKc
 Tfq+pbpMI+fVTOCmbQNuzSSZlA4S223FhS2EGtZ68yTbZcpQtwthn2lLo5SIE+uoDSubhJcK/b
 xPB3TQeS1s1Y87NfKVmv2ckc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 06:14:15 -0700
IronPort-SDR: dzkO9faQUxUdOdyxkFplW6I5GCCGvF1HSMgLCsJKwnLiI11Vd1//q38FCxEmHAEnioMjunK1TI
 /Tcte6LOdE1u6nJAIhBwb4+JvdRIUzdPWgMuNKRJG0aF2mcJ3eV5Q6+g8kV5x5hx/jcjLSJSQG
 smimcJOIOU8xR2+G15Exnm65gpXBnoPjgJqcKtgbJadg6Rb2HNbKsImTrNDcfnf2iJkYHv5wzT
 Ac7ywwL6v5AKN+5mK1Q0NuXbiynDVhI0Hfk3yikvcj29/UETjIMiedc4Ic/bIzTq9g+vH7prnT
 W1U=
WDCIronportException: Internal
Received: from deb000468.ad.shared (HELO localhost.localdomain) ([10.225.0.10])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2021 06:35:28 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] btrfs: zoned: two fixes for generic/475
Date:   Fri, 30 Apr 2021 15:34:16 +0200
Message-Id: <20210430133418.4100-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although generic/475 uses dm-error which is not compatible with a zoned btrfs,
there is nothing that prevents a zoned btrfs from running on dm-error.

Johannes Thumshirn (1):
  btrfs: zoned: bail out if we can't read a reliable write pointer

Naohiro Aota (1):
  btrfs: zoned: sanity check zone type

 fs/btrfs/zoned.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.31.1

