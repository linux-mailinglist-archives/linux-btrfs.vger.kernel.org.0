Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C3F354E3E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhDFIHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:07:22 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49866 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbhDFIHW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696437; x=1649232437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7O+2l5EybKc0cuw/4xGgzK7sFDK0pZ9OPsSG7iBxgGM=;
  b=j3JzhgtGG2eNl8wBAgZO5G6g2VFvtfp/CjfDn6xXyJGOxd3I0VtXMgnb
   BQ7AFJl1lAZ+/kQ/6odXIS3G6xeKkvmQmicxsab520JmghrtcmMw/64jl
   tT7ZfjWtvYPNA06Nwi2q7GMRSI4lDwxoA0C9odLNjqT/lojOshbkuWhH6
   Ioaqz26UjaLzF9JbMR0WoT/guvHytMZSEQ9Ylzr+X2NvuPqJHGsp6iOFu
   wVvmTouJBg1uGKSckImGZHv4plWC0RTuPqMR79c6kkePE3e3VAA8o1QGV
   690bDGce+JE+MMjc2x8cDc3wZyWxRY4+HXx8/NXvnYu2FeZQhcOIBh5Av
   g==;
IronPort-SDR: 0PMg1zIEATpSvyETRoKRXhW0v/4MXo905gvPQaUnKh/ZbeonTn35/q1cTxMeTSZ64l4hoXY+w+
 WHpINmrySCCdUP2mbol0na21l34aK7i/GlzG1s3+Vq1JSIzb82LpDHU8ZQjZVHfY968fvyUkA7
 1+bCgCsq7wFxKeBjmBaGfEtWoPsV/oXw0EjlNeZpivLwyEq5cj2sCFFFlff2ubd+IMnmrNwTkl
 sEmeCtdX+XqapzXkjbOjnW4AQBqnPOyONl9xyCLJh+yCcYebIpAkJaVW153w6FW6+8GZhMYcCO
 tL8=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="268290639"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:07:01 +0800
IronPort-SDR: YZeImzVe5BSMS1mqRoZVhuknwTK/Zqofbt0d06LUrenWIkNX5pW/FxZNee53YlyPCcuo2thRlM
 04l6kjGCTXLUlQTnNm46CudmIFJ6fH3dZ/hCTHCcgtoEUfRFm9ifKUuY91fIDBRAEPcycRPQLa
 uChSuz8Gf2jhFjLDG8VmXZEo7/Ynz/OO4FUt0qftkH1ni1QOdaplOv8I0W7n2ycbfL+R9ItQ+r
 tWTCvqwTN303OgXb0CBBfY85nHM1tIry+yc0go0icqbHOEv0MQoIcR9ivv9AgZ/+asSASvQztD
 OskEeegk1iO/JH379KPdpDM3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:19 -0700
IronPort-SDR: ytWW+dkcU0sAVhvKQ4RTOPrHRWaHNEj24HsPVpqh2OYY463neGgQ/MjmCKvZd8Sg2qRmEztu/N
 tEtC9V1IzTDkqwSIDUiJ+8oZjlBeBPy0MxlZEK/x08DwxTeS5P+SKqq+JkZykVRxdKVF3lGpkS
 K9Uy4zlq2QMzyDps2hdtepbg/OWGbSqXV7elWWohCfPGCSWDLdfCefrgE+gFAUMlWdZo3876Jv
 MvJVcErR+axyCNqqGNk1cfKwMhTto954NRe9bpjuwJZUw224B3ogMQ1yajqae2Q1l99r5A/wQm
 Q50=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:06:54 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 00/12] btrfs-progs: refactor and generalize chunk/dev_extent allocation
Date:   Tue,  6 Apr 2021 17:05:42 +0900
Message-Id: <cover.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the userland counterpart of the following series.

https://lore.kernel.org/linux-btrfs/20200225035626.1049501-1-naohiro.aota@wdc.com/

This series refactors chunk allocation and device_extent allocation
functions and make them generalized to be able to implement other
allocation policy easily.

On top of this series, we can simplify userland side of the zoned series as
adding a new type of chunk allocator and extent allocator for zoned block
devices. Furthermore, we will be able to implement and test some other
allocator in the idea page of the wiki e.g. SSD caching, dedicated metadata
drive, chunk allocation groups, and so on.

This series also fixes a bug of calculating the stripe size in DUP profile,
and cleans up the code.

* Refactoring chunk/dev_extent allocator

Two functions are separated from find_free_dev_extent_start().
dev_extent_search_start() decides the starting position of the search.
dev_extent_hole_check() checks if a hole found is suitable for device
extent allocation.

Split some parts of btrfs_alloc_chunk() into three functions.
init_alloc_chunk_policy() initializes the parameters of an allocation.
decide_stripe_size() decides the size of chunk and device_extent. And,
create_chunk() creates a chunk and device extents.

* Patch organization

Patches 1 and 2 refactor find_free_dev_extent_start().

Patches 3 to 6 refactor btrfs_alloc_chunk() by moving the code into three
other functions.

Patch 7 uses create_chunk() to simplify btrfs_alloc_data_chunk().

Patch 8 fixes a bug of calculating stripe size in DUP profile.

Patches 9 to 12 clean up btrfs_alloc_chunk() code by dropping unnecessary
parameters, and using better macro/variable name to clarify the meaning.


Naohiro Aota (12):
  btrfs-progs: introduce chunk allocation policy
  btrfs-progs: refactor find_free_dev_extent_start()
  btrfs-progs: convert type of alloc_chunk_ctl::type
  btrfs-progs: consolidate parameter initialization of regular allocator
  btrfs-progs: factor out decide_stripe_size()
  btrfs-progs: factor out create_chunk()
  btrfs-progs: rewrite btrfs_alloc_data_chunk() using create_chunk()
  btrfs-progs: fix to use half the available space for DUP profile
  btrfs-progs: use round_down for allocation calcs
  btrfs-progs: drop alloc_chunk_ctl::stripe_len
  btrfs-progs: simplify arguments of chunk_bytes_by_type()
  btrfs-progs: rename calc_size to stripe_size

 kernel-shared/volumes.c | 514 +++++++++++++++++++++-------------------
 kernel-shared/volumes.h |   6 +
 2 files changed, 274 insertions(+), 246 deletions(-)

-- 
2.31.1

