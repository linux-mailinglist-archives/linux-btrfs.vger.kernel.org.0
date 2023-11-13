Return-Path: <linux-btrfs+bounces-96-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C706F7EA20C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 18:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2224CB209D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE8224EB;
	Mon, 13 Nov 2023 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRG9iMY/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D7224D7;
	Mon, 13 Nov 2023 17:37:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D16310D0;
	Mon, 13 Nov 2023 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699897045; x=1731433045;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DSacYvT1P2f6YUj8jbQzn2GhMgTBmy/U4Xnu4aI0x0g=;
  b=kRG9iMY/7yMVhTrgcK4xIrLsVI/mqv/ui6cQB30XWJjQS9dXrV4v1JjN
   L+6M4DnwA/OfbNcy3MSKZVrGkE2Fuv831udkE1knDPQp0RyiCBtnd5mxw
   ftGxsiN7XGnMpEedJS3xPRiZUwrvvyIq6Jr2Epxqrn1s9rdB5wsQQOb7h
   tymg8RdNH637jaEU+hDR2xkphuRCCggYUlLQ51bj+bXnPdlkMplzlUiDT
   gxSSVRVFO59CmCAUSNRKsYvF/VJoQsnAL1caZKXsGdNBmSrNzth8ib8bg
   KXwEwKsQktWo+3lBIslUkx6oTfONZMkccg6Oeg8Yij/PmD/Cb2Ah93qIz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370671493"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370671493"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:37:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095812617"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095812617"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2023 09:37:21 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com,
	ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/11] bitmap: prereqs for ip_tunnel flags conversion
Date: Mon, 13 Nov 2023 18:37:06 +0100
Message-ID: <20231113173717.927056-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on top of "lib/bitmap: add bitmap_{read,write}()"[0] from Alexander
Potapenko as it uses those new bitmap_{read,write}() functions to not
introduce another pair of similar ones.

Derived from the PFCP support series[1] as this grew bigger (2 -> 13
commits in v2) and involved more core bitmap changes, finally transforming
into a pure bitmap series. The actual mentioned ip_tunnel flags conversion
from `__be16` to bitmaps will be submitted bundled with the PFCP set after
this one lands.

Little breakdown:
 * #1, #8, #10: misc cleanups;
 * #2, #5, #6, #7: symbol scope, name collisions;
 * #3, #4, #9, #11: compile-time optimizations.

[0] https://lore.kernel.org/lkml/20231109151106.2385155-1-glider@google.com
[1] https://lore.kernel.org/netdev/20230721071532.613888-1-marcin.szycik@linux.intel.com

Alexander Lobakin (11):
  bitops: add missing prototype check
  bitops: make BYTES_TO_BITS() treewide-available
  bitops: let the compiler optimize {__,}assign_bit()
  linkmode: convert linkmode_{test,set,clear,mod}_bit() to macros
  s390/cio: rename bitmap_size() -> idset_bitmap_size()
  fs/ntfs3: add prefix to bitmap_size() and use BITS_TO_U64()
  btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
  tools: move alignment-related macros to new <linux/align.h>
  bitmap: introduce generic optimized bitmap_size()
  bitmap: make bitmap_{get,set}_value8() use bitmap_{read,write}()
  lib/bitmap: add compile-time test for __assign_bit() optimization

 drivers/md/dm-clone-metadata.c |  5 ----
 drivers/s390/cio/idset.c       | 12 +++++----
 fs/btrfs/free-space-cache.c    |  8 +++---
 fs/ntfs3/bitmap.c              |  4 +--
 fs/ntfs3/fsntfs.c              |  2 +-
 fs/ntfs3/index.c               | 11 ++++----
 fs/ntfs3/ntfs_fs.h             |  4 +--
 fs/ntfs3/super.c               |  2 +-
 include/linux/bitmap.h         | 46 ++++++++--------------------------
 include/linux/bitops.h         | 23 ++++++-----------
 include/linux/cpumask.h        |  2 +-
 include/linux/linkmode.h       | 27 +++-----------------
 kernel/trace/trace_probe.c     |  2 --
 lib/math/prime_numbers.c       |  2 --
 lib/test_bitmap.c              | 18 +++++++------
 tools/include/linux/align.h    | 11 ++++++++
 tools/include/linux/bitmap.h   |  9 ++++---
 tools/include/linux/bitops.h   |  2 ++
 tools/include/linux/mm.h       |  5 +---
 tools/perf/util/probe-finder.c |  4 +--
 20 files changed, 75 insertions(+), 124 deletions(-)
 create mode 100644 tools/include/linux/align.h

---
From v2[2]:
 * 00: drop ip_tunnel part: will be sent together with the PFCP part once
   this gets accepted (Jakub, Yury);
 * 02: fix format string literal build warning due to the new generic
   macro having different implicit type (Stephen);
 * 04: pick Acked-by (Jakub);
 * 08: new;
 * 09: pick Acked-by (Yury), fix including the header not existing under
   the tools/ tree (via #8) (Stephen);.

From v1[3]:
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

[2] https://lore.kernel.org/lkml/20231016165247.14212-1-aleksander.lobakin@intel.com
[3] https://lore.kernel.org/lkml/20231009151026.66145-1-aleksander.lobakin@intel.com
-- 
2.41.0


