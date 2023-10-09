Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C877BE416
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376434AbjJIPNV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346607AbjJIPNU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 11:13:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A3E12B;
        Mon,  9 Oct 2023 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696864389; x=1728400389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XwrPDkt2Er5E2S1iV6wi5sTuMRra6k9W0AgF2nXsvus=;
  b=fYD1JMNmy6Ui+7Wp8KmNYpt4YY6w4GYb0LVdyi777dRxmlLDDfj9XioM
   WMLc3szu2fQ/3kBs0HwA/j0CGcIdGy3qBus4doVsN+AOBWXTQOU+HYSde
   djvegg6iw7r7haOUHJCtALwXCO3BMzF60w7ENJu1C0Y63iUVbG6OxELT3
   dB/PbpQusa3EOhKNm2NIDijK413w7jCDgCEquiPKP0qMQoPU3gx8FXkww
   0QVdxbF8i2D9bHE3Nr0c+ghz+lUn3BWYixjdcG5p3st7ruhFgtxICFnk6
   TWGeiyLKRBFQkdkLUQs9aZhoG3sv7y/Oed1COOubffzz7U8iOKWdddp6O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369231969"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="369231969"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:13:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869287927"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="869287927"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2023 08:13:00 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] ip_tunnel: convert __be16 tunnel flags to bitmaps
Date:   Mon,  9 Oct 2023 17:10:12 +0200
Message-ID: <20231009151026.66145-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Derived from the PFCP support series[0] as this grew bigger (2 -> 14
commits) and involved more core bitmap changes. Only commits 10 and 11
are from the mentioned tree, the rest is new. PFCP itself still depends
on this series.

IP tunnels have their flags defined as `__be16`, including UAPI, and
after GTP was accepted, there are no more free bits left. UAPI (incl.
direct usage of one of the user structs) and explicit Endianness only
complicate things.
Since it would either way end up with hundreds of locs due to all that,
pick bitmaps right from the start to store the flags in the most native
and scalable format with rich API. I don't think it's worth trying to
praise luck and pick smth like u32 only to redo everything in x years :)
More details regarding the IP tunnel flags is in 11 and 14.

The rest is just a good bunch of prereqs and tests: a couple of new
helpers and extensions to the old ones, a few optimizations to partially
mitigate IP tunnel object code growth due to __be16 -> long, and
decouping one UAPI struct used throughout the whole kernel into the
userspace and the kernel space counterparts to eliminate the dependency.

[0] https://lore.kernel.org/netdev/20230721071532.613888-1-marcin.szycik@linux.intel.com

Alexander Lobakin (14):
  bitops: add missing prototype check
  bitops: make BYTES_TO_BITS() treewide-available
  bitops: let the compiler optimize __assign_bit()
  linkmode: convert linkmode_{test,set,clear,mod}_bit() to macros
  s390/cio: rename bitmap_size() -> idset_bitmap_size()
  fs/ntfs3: rename bitmap_size() -> ntfs3_bitmap_size()
  btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
  bitmap: introduce generic optimized bitmap_size()
  bitmap: extend bitmap_{get,set}_value8() to bitmap_{get,set}_bits()
  ip_tunnel: use a separate struct to store tunnel params in the kernel
  ip_tunnel: convert __be16 tunnel flags to bitmaps
  lib/bitmap: add compile-time test for __assign_bit() optimization
  lib/bitmap: add tests for bitmap_{get,set}_bits()
  lib/bitmap: add tests for IP tunnel flags conversion helpers

 drivers/md/dm-clone-metadata.c                |   5 -
 drivers/net/bareudp.c                         |  19 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun.h   |   2 +-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |   6 +-
 .../mellanox/mlx5/core/en/tc_tun_geneve.c     |  12 +-
 .../mellanox/mlx5/core/en/tc_tun_gre.c        |   8 +-
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  16 +-
 .../ethernet/mellanox/mlxsw/spectrum_ipip.c   |  56 +++--
 .../ethernet/mellanox/mlxsw/spectrum_ipip.h   |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |  10 +-
 .../ethernet/netronome/nfp/flower/action.c    |  27 ++-
 drivers/net/geneve.c                          |  44 ++--
 drivers/net/vxlan/vxlan_core.c                |  14 +-
 drivers/s390/cio/idset.c                      |  10 +-
 fs/btrfs/free-space-cache.c                   |   8 +-
 fs/ntfs3/bitmap.c                             |   4 +-
 fs/ntfs3/fsntfs.c                             |   2 +-
 fs/ntfs3/index.c                              |  11 +-
 fs/ntfs3/ntfs_fs.h                            |   2 +-
 fs/ntfs3/super.c                              |   2 +-
 include/linux/bitmap.h                        |  59 ++++--
 include/linux/bitops.h                        |  13 +-
 include/linux/cpumask.h                       |   2 +-
 include/linux/linkmode.h                      |  27 +--
 include/linux/netdevice.h                     |   7 +-
 include/net/dst_metadata.h                    |  10 +-
 include/net/flow_dissector.h                  |   2 +-
 include/net/gre.h                             |  70 +++---
 include/net/ip6_tunnel.h                      |   4 +-
 include/net/ip_tunnels.h                      | 136 ++++++++++--
 include/net/udp_tunnel.h                      |   4 +-
 include/uapi/linux/if_tunnel.h                |  33 +++
 kernel/trace/trace_probe.c                    |   2 -
 lib/math/prime_numbers.c                      |   2 -
 lib/test_bitmap.c                             | 200 +++++++++++++++++-
 net/bridge/br_vlan_tunnel.c                   |   9 +-
 net/core/filter.c                             |  26 +--
 net/core/flow_dissector.c                     |  20 +-
 net/ipv4/fou_bpf.c                            |   2 +-
 net/ipv4/gre_demux.c                          |   2 +-
 net/ipv4/ip_gre.c                             | 144 ++++++++-----
 net/ipv4/ip_tunnel.c                          | 109 +++++++---
 net/ipv4/ip_tunnel_core.c                     |  82 ++++---
 net/ipv4/ip_vti.c                             |  41 ++--
 net/ipv4/ipip.c                               |  33 +--
 net/ipv4/ipmr.c                               |   2 +-
 net/ipv4/udp_tunnel_core.c                    |   5 +-
 net/ipv6/addrconf.c                           |   3 +-
 net/ipv6/ip6_gre.c                            |  85 ++++----
 net/ipv6/ip6_tunnel.c                         |  14 +-
 net/ipv6/sit.c                                |  38 ++--
 net/netfilter/ipvs/ip_vs_core.c               |   6 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |  20 +-
 net/netfilter/nft_tunnel.c                    |  44 ++--
 net/openvswitch/flow_netlink.c                |  61 +++---
 net/psample/psample.c                         |  26 +--
 net/sched/act_tunnel_key.c                    |  36 ++--
 net/sched/cls_flower.c                        |  27 +--
 tools/include/linux/bitmap.h                  |   8 +-
 tools/include/linux/bitops.h                  |   2 +
 tools/perf/util/probe-finder.c                |   2 -
 62 files changed, 1116 insertions(+), 571 deletions(-)

---
Not sure whether it's fine to have that all in one series, but OTOH
there's not much stuff I could split (like, 3 commits), it either
depends directly (new helpers etc.) or will just generate suboptimal
code w/o some of the commits.

I'm also thinking of which tree this would ideally be taken through.
The main subject is networking, but most of the commits are generic.
My idea is to push this via Yury / bitmaps and then ask the netdev
maintainers to pull his tree before they take PFCP (dependent on this
one).

Speaking of bitmap_{read,write}() from [1] vs bitmap_{get,set}_bits()
from #09: they don't really conflict, because the former are
generic-generic and support bound crossing, while the latter require
the width to be a pow-2 and the offset to be a multiple of the width
in order to preserve the optimization level as close to the current
bitmap_{get,set}_value8() as possible...

Old pfcp -> bitmap changelog:

As for former commits (now 10 and 11), almost all of the changes were
suggested by Andy, notably: stop violating bitmap API, use
__assign_bit() where appropriate, and add more tests to make sure
everything works as expected. Apart from that, add simple wrappers for
bitmap_*() used in the IP tunnel code to avoid manually specifying
``__IP_TUNNEL_FLAG_NUM`` each time.

[1] https://lore.kernel.org/lkml/20231006134529.2816540-2-glider@google.com
-- 
2.41.0

