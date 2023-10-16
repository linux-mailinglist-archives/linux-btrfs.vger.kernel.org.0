Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0480B7CB09E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjJPQ4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbjJPQ4m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 12:56:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2E1BD7;
        Mon, 16 Oct 2023 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697475256; x=1729011256;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uQiT4Q6mFElej1pV8NDfuC7904o/FoUvXesRhi74k1A=;
  b=CjnO/A7ZxNdcLsB1oD+xv3Ergy6J5B/xvIPNdqgUOX2iAql25VRXvx+H
   7gOcN5np99oTOXx4iej0n/fOCEE0o77Zdkc9c2uDiQfG0QCP9RcVISbyg
   z5HWhtUh8Lu7orhol2ohCkkqEl7L3g9lRgQRTFEJEuBfBo8W4HvHQ1lyd
   v4j1IXr2K+SriUkJBRCLQYbwSL2JG369mRaXZunuD7fUX86Cm2exZfcHt
   YTOQwHl9Yc643oH4yQvYeMNUPfBThN605R3Qn/B9QWuHWzULzKGFSbC4O
   KhreFuKGkIr/IPxJ4+/LKzOpJWelbrQX6ojeMKbl+7naiPStDINusdSUg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="364936987"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="364936987"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:54:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826083910"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="826083910"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2023 09:54:12 -0700
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
Subject: [PATCH v2 00/13] ip_tunnel: convert __be16 tunnel flags to bitmaps
Date:   Mon, 16 Oct 2023 18:52:34 +0200
Message-ID: <20231016165247.14212-1-aleksander.lobakin@intel.com>
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

Based on top of "Implement MTE tag compression for swapped pages"[0]
from Alexander Potapenko as it uses its bitmap_{read,write}() functions
to not introduce another pair of similar ones.

Derived from the PFCP support series[1] as this grew bigger (2 -> 13
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
More details regarding the IP tunnel flags is in 11 and 13.

The rest is just a good bunch of prereqs and tests: a couple of new
helpers and extensions to the old ones, a few optimizations to partially
mitigate IP tunnel object code growth due to __be16 -> long, and
decouping one UAPI struct used throughout the whole kernel into the
userspace and the kernel space counterparts to eliminate the dependency.

[0] https://lore.kernel.org/lkml/20231011172836.2579017-1-glider@google.com
[1] https://lore.kernel.org/netdev/20230721071532.613888-1-marcin.szycik@linux.intel.com

Alexander Lobakin (13):
  bitops: add missing prototype check
  bitops: make BYTES_TO_BITS() treewide-available
  bitops: let the compiler optimize {__,}assign_bit()
  linkmode: convert linkmode_{test,set,clear,mod}_bit() to macros
  s390/cio: rename bitmap_size() -> idset_bitmap_size()
  fs/ntfs3: add prefix to bitmap_size() and use BITS_TO_U64()
  btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
  bitmap: introduce generic optimized bitmap_size()
  bitmap: make bitmap_{get,set}_value8() use bitmap_{read,write}()
  ip_tunnel: use a separate struct to store tunnel params in the kernel
  ip_tunnel: convert __be16 tunnel flags to bitmaps
  lib/bitmap: add compile-time test for __assign_bit() optimization
  lib/bitmap: add tests for IP tunnel flags conversion helpers

 drivers/md/dm-clone-metadata.c                |   5 -
 drivers/net/bareudp.c                         |  19 ++-
 .../ethernet/mellanox/mlx5/core/en/tc_tun.h   |   2 +-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |   6 +-
 .../mellanox/mlx5/core/en/tc_tun_geneve.c     |  12 +-
 .../mellanox/mlx5/core/en/tc_tun_gre.c        |   8 +-
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  16 +-
 .../ethernet/mellanox/mlxsw/spectrum_ipip.c   |  56 ++++---
 .../ethernet/mellanox/mlxsw/spectrum_ipip.h   |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |  10 +-
 .../ethernet/netronome/nfp/flower/action.c    |  27 +++-
 drivers/net/geneve.c                          |  44 +++---
 drivers/net/vxlan/vxlan_core.c                |  14 +-
 drivers/s390/cio/idset.c                      |  12 +-
 fs/btrfs/free-space-cache.c                   |   8 +-
 fs/ntfs3/bitmap.c                             |   4 +-
 fs/ntfs3/fsntfs.c                             |   2 +-
 fs/ntfs3/index.c                              |  11 +-
 fs/ntfs3/ntfs_fs.h                            |   4 +-
 fs/ntfs3/super.c                              |   2 +-
 include/linux/bitmap.h                        |  46 ++----
 include/linux/bitops.h                        |  23 +--
 include/linux/cpumask.h                       |   2 +-
 include/linux/linkmode.h                      |  27 +---
 include/linux/netdevice.h                     |   7 +-
 include/net/dst_metadata.h                    |  10 +-
 include/net/flow_dissector.h                  |   2 +-
 include/net/gre.h                             |  70 +++++----
 include/net/ip6_tunnel.h                      |   4 +-
 include/net/ip_tunnels.h                      | 136 ++++++++++++++---
 include/net/udp_tunnel.h                      |   4 +-
 include/uapi/linux/if_tunnel.h                |  33 ++++
 kernel/trace/trace_probe.c                    |   2 -
 lib/math/prime_numbers.c                      |   2 -
 lib/test_bitmap.c                             | 123 ++++++++++++++-
 net/bridge/br_vlan_tunnel.c                   |   9 +-
 net/core/filter.c                             |  26 ++--
 net/core/flow_dissector.c                     |  20 ++-
 net/ipv4/fou_bpf.c                            |   2 +-
 net/ipv4/gre_demux.c                          |   2 +-
 net/ipv4/ip_gre.c                             | 144 +++++++++++-------
 net/ipv4/ip_tunnel.c                          | 109 ++++++++-----
 net/ipv4/ip_tunnel_core.c                     |  82 ++++++----
 net/ipv4/ip_vti.c                             |  41 +++--
 net/ipv4/ipip.c                               |  33 ++--
 net/ipv4/ipmr.c                               |   2 +-
 net/ipv4/udp_tunnel_core.c                    |   5 +-
 net/ipv6/addrconf.c                           |   3 +-
 net/ipv6/ip6_gre.c                            |  85 ++++++-----
 net/ipv6/ip6_tunnel.c                         |  14 +-
 net/ipv6/sit.c                                |  38 ++---
 net/netfilter/ipvs/ip_vs_core.c               |   6 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |  20 +--
 net/netfilter/nft_tunnel.c                    |  44 +++---
 net/openvswitch/flow_netlink.c                |  61 +++++---
 net/psample/psample.c                         |  26 ++--
 net/sched/act_tunnel_key.c                    |  36 ++---
 net/sched/cls_flower.c                        |  27 ++--
 tools/include/linux/bitmap.h                  |   8 +-
 tools/include/linux/bitops.h                  |   2 +
 tools/perf/util/probe-finder.c                |   2 -
 62 files changed, 1011 insertions(+), 600 deletions(-)

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

From v1[2]:
 * 03: convert assign_bit() to a macro as well, saves some bytes and
   looks more consistent (Yury);
 * 03: enclose each argument into own pair of braces (Yury);
 * 06: use generic BITS_TO_U64() while at it (Yury);
 * 07: pick Acked-by (David);
 * 08: Acked-by, use bitmap_size() in the code from 05 as well (Yury);
 * 09: instead of introducing a new pair of functions, use generic
   bitmap_{read,write}() from [0]. bloat-o-meter shows no regressions
   from the switch (Yury, also Andy).

Old pfcp -> bitmap changelog:

As for former commits (now 10 and 11), almost all of the changes were
suggested by Andy, notably: stop violating bitmap API, use
__assign_bit() where appropriate, and add more tests to make sure
everything works as expected. Apart from that, add simple wrappers for
bitmap_*() used in the IP tunnel code to avoid manually specifying
``__IP_TUNNEL_FLAG_NUM`` each time.

[2] https://lore.kernel.org/lkml/20231009151026.66145-1-aleksander.lobakin@intel.com
-- 
2.41.0

