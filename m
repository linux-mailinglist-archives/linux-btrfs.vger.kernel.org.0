Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E36C1F54E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgFJMdV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12377 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgFJMdU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792400; x=1623328400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WyQ6EdGrDBJ85L50q4rornSAZwekDOExXJYAO+7r67g=;
  b=C/hVVfafXaI0K0jdesUZfT4HHXlBOn2vLRGSanOu2oCnqceDkb/a/4N2
   8sqGdBAXrj42FTciIzD2g/TSEYPaBL3lZG7MmYKOFiM+Ie6tE+3KyCSpr
   5A9fvMBa2O1jPYFNhxtKNqOs0Sti55rp3hoHOaYEX0LmQ0BBa1kqdXeJ/
   57+Uy5PlPo61oX80cQYCOxvKx/6l/ZOUwTMv4lf9ctnm/gY4Mc0OpMMB8
   te16d+/vOyOK8XOHlWQVuIrh2vCog7tdZt/f4AhNuVduRk5qAJoUBzOOw
   8gsu5DUJKeqadODBaBSkobKSyQsmNiunrh1rLyK/A1dkUEKzMXZ7fYjho
   w==;
IronPort-SDR: 6ljXuC/AMUHD/P6rZ2AuBSAOzXNkOONc9g1Z0+sytbT7EX2/L8UzAp8eI5szWtbv3x7Zesh2jS
 dCfgdMfmFOMKfCkATh1S4ZnkHoU2GKFrlw25s/2v4Z6MiRC/UHe9Gv3yll9HDbEDXJ8CjkPhl3
 JZJeGpI74v/nFHC8q9nTECf7HOGKHt5derIhtRNAdRVFj9aF+s0wgsyiqMqZeUCPJZrU0bKkTb
 vmwZHGPHqcNrtx+MTDLFnwCNeW03YS2PI1rq5rbG4ibCizFSDtbJyFu7pOs1lISuXbshy+btUq
 tfY=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632682"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:04 +0800
IronPort-SDR: PkwAYLJ8WqiNBNFt91CFRnA58Md53fWD3v6YyibY6xCZTrxWNiHkMeIxIohDHUjNT4tMNsIvhF
 k/oToltAp4BJZoHfFvMZlVwA1PPSuTljo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:31 -0700
IronPort-SDR: jy8XDn+LBgWYTAeoKcFFDfxyQEtAgUiYs76y+XIGglhB0pKbaRz7/QNNJGSEd+p1A0qFDSKaJp
 d3s1fqskvLEg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:03 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 00/15] btrfs-progs: simplify chunk allocation a bit
Date:   Wed, 10 Jun 2020 21:32:43 +0900
Message-Id: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While playing a bit with the RAID code, I've come up with some cleanups for
the chunk allocatin in progs. It's not aligned to what we're doing in the
kernel, but the code has diverged so much it is a daunting task to converge it
again.

Johannes Thumshirn (15):
  btrfs-progs: simplify minimal stripe number checking
  btrfs-progs: simplify assignment of number of RAID stripes
  btrfs-progs: introduce alloc_chunk_ctl structure
  btrfs-progs: cache number of devices for chunk allocation
  btrfs-progs: pass alloc_chunk_ctl to chunk_bytes_by_type
  btrfs-progs: introduce raid profile table for chunk allocation
  btrfs-progs: consolidate assignment of minimal stripe number
  btrfs-progs: consolidate assignment of sub_stripes
  btrfs-progs: consolidate setting of RAID1 stripes
  btrfs-progs: do table lookup for simple RAID profiles' num_stripes
  btrfs-progs: consolidate num_stripes sanity check
  btrfs-progs: compactify num_stripe setting in btrfs_alloc_chunk
  btrfs-progs: introduce init_alloc_chunk_ctl
  btrfs-progs: don't pretend RAID56 has a different stripe length
  btrfs-progs: consolidate num_stripes setting for striping RAID levels

 volumes.c | 261 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 148 insertions(+), 113 deletions(-)

-- 
2.26.2

