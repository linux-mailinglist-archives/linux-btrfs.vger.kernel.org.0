Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410257CB1A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 19:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjJPRzF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjJPRzF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 13:55:05 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6929F;
        Mon, 16 Oct 2023 10:55:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59b5484fbe6so59595477b3.1;
        Mon, 16 Oct 2023 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697478902; x=1698083702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bw4UalwD6RTLFekVHi/CP+1fpgIfdUhpzj+EU1oO1Y=;
        b=Ehnii5Fvv+q37inI2bgPxt/tDJwBITGIAX/JudZB10YG5v4J/xm1zEymVLuCOezk8C
         wPnZ+OqIoww/SNHoGCE4NDGvneA5ikO3we7X2k7LtvA6i157fBKWcTNS+Ly5bgAYwt4i
         XRqio5LvVONQdmUHwBii2+OQxjUCLT6Lhp/dAn0ma6e/tzGE0OzqS/FqUd1skNuL60ym
         AfGkxs6fo1HdGjeVSiyFRTTQib9jjV8EUZRMDXV9m8EBK0xAgDTJZgtMbaMSqguLCZt5
         4961jUOSki5MharLFidAZ3jRjPB426zzdR3ORzSbXLxdklpiohH+7IRMMJRvI9MH5ao5
         MFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697478902; x=1698083702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bw4UalwD6RTLFekVHi/CP+1fpgIfdUhpzj+EU1oO1Y=;
        b=otrILlBHyA75SqU+D8A5qpt90aoVxL0NJtzfcldtc7UTTyqpVxB8qCaQqNlzeQpg26
         /uR4cP4IlWSzEnPr0EvbUIKqUP00vC9I5ul7F2WbUgpNnvgMx/YiJLKObmCFufsGiV3o
         yVNoNVnvsu2OsHIw4q8KvV0DF449ewziIWM2p0adILtkuQTQomKvkaWiRAMbbkslfSnc
         4GvOm5C8Xhriof0wBUYN6pXH0TdFHevemxEaqa8Yi3eLKfqwsz2EqpJzkQYgtOHSEknX
         I8FNiLatrJ6NfNklkTDLw26sHVeydbAv+KAo/wixoSiHjiR46je/aItKaw60DD180XDP
         rgZA==
X-Gm-Message-State: AOJu0Yyz5wiyf6h7a9XYj6Iz0NbKCAqqvNb5PX8HU9toL/Zd9o+vTD/z
        GTuDjm7yaSii1MHz6+JRaQA=
X-Google-Smtp-Source: AGHT+IGTSnIMdj/n4Ja3NbcbsGlcoAWOTqGIDx359ahueXqqmFI98BytrXJ2gg+e90t8fNnGTP3pNA==
X-Received: by 2002:a05:690c:95:b0:5a8:6286:bee with SMTP id be21-20020a05690c009500b005a862860beemr5534482ywb.4.1697478901928;
        Mon, 16 Oct 2023 10:55:01 -0700 (PDT)
Received: from localhost ([2607:fb90:be80:2b9:64a5:5a0e:5435:bd4])
        by smtp.gmail.com with ESMTPSA id w185-20020a817bc2000000b005a7ab32d454sm2404120ywc.10.2023.10.16.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:55:01 -0700 (PDT)
Date:   Mon, 16 Oct 2023 10:54:58 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH v2 00/13] ip_tunnel: convert __be16 tunnel flags to
 bitmaps
Message-ID: <ZS148saIsG7WY8ul@yury-ThinkPad>
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016165247.14212-1-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 16, 2023 at 06:52:34PM +0200, Alexander Lobakin wrote:
> Based on top of "Implement MTE tag compression for swapped pages"[0]
> from Alexander Potapenko as it uses its bitmap_{read,write}() functions
> to not introduce another pair of similar ones.
> 
> Derived from the PFCP support series[1] as this grew bigger (2 -> 13
> commits) and involved more core bitmap changes. Only commits 10 and 11
> are from the mentioned tree, the rest is new. PFCP itself still depends
> on this series.
> 
> IP tunnels have their flags defined as `__be16`, including UAPI, and
> after GTP was accepted, there are no more free bits left. UAPI (incl.
> direct usage of one of the user structs) and explicit Endianness only
> complicate things.
> Since it would either way end up with hundreds of locs due to all that,
> pick bitmaps right from the start to store the flags in the most native
> and scalable format with rich API. I don't think it's worth trying to
> praise luck and pick smth like u32 only to redo everything in x years :)
> More details regarding the IP tunnel flags is in 11 and 13.
> 
> The rest is just a good bunch of prereqs and tests: a couple of new
> helpers and extensions to the old ones, a few optimizations to partially
> mitigate IP tunnel object code growth due to __be16 -> long, and
> decouping one UAPI struct used throughout the whole kernel into the
> userspace and the kernel space counterparts to eliminate the dependency.
> 
> [0] https://lore.kernel.org/lkml/20231011172836.2579017-1-glider@google.com
> [1] https://lore.kernel.org/netdev/20230721071532.613888-1-marcin.szycik@linux.intel.com
> 
> Alexander Lobakin (13):
>   bitops: add missing prototype check
>   bitops: make BYTES_TO_BITS() treewide-available
>   bitops: let the compiler optimize {__,}assign_bit()
>   linkmode: convert linkmode_{test,set,clear,mod}_bit() to macros
>   s390/cio: rename bitmap_size() -> idset_bitmap_size()
>   fs/ntfs3: add prefix to bitmap_size() and use BITS_TO_U64()
>   btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
>   bitmap: introduce generic optimized bitmap_size()
>   bitmap: make bitmap_{get,set}_value8() use bitmap_{read,write}()
>   ip_tunnel: use a separate struct to store tunnel params in the kernel
>   ip_tunnel: convert __be16 tunnel flags to bitmaps
>   lib/bitmap: add compile-time test for __assign_bit() optimization
>   lib/bitmap: add tests for IP tunnel flags conversion helpers
> 
>  drivers/md/dm-clone-metadata.c                |   5 -
>  drivers/net/bareudp.c                         |  19 ++-
>  .../ethernet/mellanox/mlx5/core/en/tc_tun.h   |   2 +-
>  .../mellanox/mlx5/core/en/tc_tun_encap.c      |   6 +-
>  .../mellanox/mlx5/core/en/tc_tun_geneve.c     |  12 +-
>  .../mellanox/mlx5/core/en/tc_tun_gre.c        |   8 +-
>  .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |   9 +-
>  .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  16 +-
>  .../ethernet/mellanox/mlxsw/spectrum_ipip.c   |  56 ++++---
>  .../ethernet/mellanox/mlxsw/spectrum_ipip.h   |   2 +-
>  .../ethernet/mellanox/mlxsw/spectrum_span.c   |  10 +-
>  .../ethernet/netronome/nfp/flower/action.c    |  27 +++-
>  drivers/net/geneve.c                          |  44 +++---
>  drivers/net/vxlan/vxlan_core.c                |  14 +-
>  drivers/s390/cio/idset.c                      |  12 +-
>  fs/btrfs/free-space-cache.c                   |   8 +-
>  fs/ntfs3/bitmap.c                             |   4 +-
>  fs/ntfs3/fsntfs.c                             |   2 +-
>  fs/ntfs3/index.c                              |  11 +-
>  fs/ntfs3/ntfs_fs.h                            |   4 +-
>  fs/ntfs3/super.c                              |   2 +-
>  include/linux/bitmap.h                        |  46 ++----
>  include/linux/bitops.h                        |  23 +--
>  include/linux/cpumask.h                       |   2 +-
>  include/linux/linkmode.h                      |  27 +---
>  include/linux/netdevice.h                     |   7 +-
>  include/net/dst_metadata.h                    |  10 +-
>  include/net/flow_dissector.h                  |   2 +-
>  include/net/gre.h                             |  70 +++++----
>  include/net/ip6_tunnel.h                      |   4 +-
>  include/net/ip_tunnels.h                      | 136 ++++++++++++++---
>  include/net/udp_tunnel.h                      |   4 +-
>  include/uapi/linux/if_tunnel.h                |  33 ++++
>  kernel/trace/trace_probe.c                    |   2 -
>  lib/math/prime_numbers.c                      |   2 -
>  lib/test_bitmap.c                             | 123 ++++++++++++++-
>  net/bridge/br_vlan_tunnel.c                   |   9 +-
>  net/core/filter.c                             |  26 ++--
>  net/core/flow_dissector.c                     |  20 ++-
>  net/ipv4/fou_bpf.c                            |   2 +-
>  net/ipv4/gre_demux.c                          |   2 +-
>  net/ipv4/ip_gre.c                             | 144 +++++++++++-------
>  net/ipv4/ip_tunnel.c                          | 109 ++++++++-----
>  net/ipv4/ip_tunnel_core.c                     |  82 ++++++----
>  net/ipv4/ip_vti.c                             |  41 +++--
>  net/ipv4/ipip.c                               |  33 ++--
>  net/ipv4/ipmr.c                               |   2 +-
>  net/ipv4/udp_tunnel_core.c                    |   5 +-
>  net/ipv6/addrconf.c                           |   3 +-
>  net/ipv6/ip6_gre.c                            |  85 ++++++-----
>  net/ipv6/ip6_tunnel.c                         |  14 +-
>  net/ipv6/sit.c                                |  38 ++---
>  net/netfilter/ipvs/ip_vs_core.c               |   6 +-
>  net/netfilter/ipvs/ip_vs_xmit.c               |  20 +--
>  net/netfilter/nft_tunnel.c                    |  44 +++---
>  net/openvswitch/flow_netlink.c                |  61 +++++---
>  net/psample/psample.c                         |  26 ++--
>  net/sched/act_tunnel_key.c                    |  36 ++---
>  net/sched/cls_flower.c                        |  27 ++--
>  tools/include/linux/bitmap.h                  |   8 +-
>  tools/include/linux/bitops.h                  |   2 +
>  tools/perf/util/probe-finder.c                |   2 -
>  62 files changed, 1011 insertions(+), 600 deletions(-)
> 
> ---
> Not sure whether it's fine to have that all in one series, but OTOH
> there's not much stuff I could split (like, 3 commits), it either
> depends directly (new helpers etc.) or will just generate suboptimal
> code w/o some of the commits.
> 
> I'm also thinking of which tree this would ideally be taken through.
> The main subject is networking, but most of the commits are generic.
> My idea is to push this via Yury / bitmaps and then ask the netdev
> maintainers to pull his tree before they take PFCP (dependent on this
> one).

Let's wait for more comments, but I'm generally OK with the generic
part, and have nothing against moving it, or the whole series, through
bitmap-for-next.

Thanks,
Yury
 
> >From v1[2]:
>  * 03: convert assign_bit() to a macro as well, saves some bytes and
>    looks more consistent (Yury);
>  * 03: enclose each argument into own pair of braces (Yury);
>  * 06: use generic BITS_TO_U64() while at it (Yury);
>  * 07: pick Acked-by (David);
>  * 08: Acked-by, use bitmap_size() in the code from 05 as well (Yury);
>  * 09: instead of introducing a new pair of functions, use generic
>    bitmap_{read,write}() from [0]. bloat-o-meter shows no regressions
>    from the switch (Yury, also Andy).
> 
> Old pfcp -> bitmap changelog:
> 
> As for former commits (now 10 and 11), almost all of the changes were
> suggested by Andy, notably: stop violating bitmap API, use
> __assign_bit() where appropriate, and add more tests to make sure
> everything works as expected. Apart from that, add simple wrappers for
> bitmap_*() used in the IP tunnel code to avoid manually specifying
> ``__IP_TUNNEL_FLAG_NUM`` each time.
> 
> [2] https://lore.kernel.org/lkml/20231009151026.66145-1-aleksander.lobakin@intel.com
> -- 
> 2.41.0
