Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8896E2808CC
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 22:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgJAUvM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 16:51:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:1488 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgJAUvM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 16:51:12 -0400
IronPort-SDR: Q208sxbvBpfAdVKY5VgZAZn8BAo0sL178rB78gaUo4R+D0Nfhu7jg8/K3fqlDQ8haANqhv/L62
 0+oV+A58XNFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160247674"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160247674"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:51:10 -0700
IronPort-SDR: 1WoWD3tSYbFzQBWeDTTaPfvEOu+7ixNbKFfbkUjqGno6QjTOAq4jaTjd3jXSQ7+Ly60CB5l7FW
 2VRpEozO+XCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="339703561"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 01 Oct 2020 13:51:08 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kO5Xf-0000kE-FY; Thu, 01 Oct 2020 20:51:07 +0000
Date:   Fri, 2 Oct 2020 04:50:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Petr Malat <oss@malat.biz>
Subject: [PATCH] lib: zstd: fix semicolon.cocci warnings
Message-ID: <20201001205049.GA6920@f58d09cd8e1e>
References: <20200930065318.3326526-4-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930065318.3326526-4-nickrterrell@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: kernel test robot <lkp@intel.com>

lib/zstd/compress/zstd_compress.c:3248:24-25: Unneeded semicolon


 Remove unneeded semicolon.

Generated by: scripts/coccinelle/misc/semicolon.cocci

CC: Nick Terrell <terrelln@fb.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---

url:    https://github.com/0day-ci/linux/commits/Nick-Terrell/Update-to-zstd-1-4-6/20200930-145157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next

 zstd_compress.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/zstd/compress/zstd_compress.c
+++ b/lib/zstd/compress/zstd_compress.c
@@ -3245,7 +3245,7 @@ size_t ZSTD_compress(void* dst, size_t d
     ZSTD_CCtx* cctx = ZSTD_createCCtx();
     RETURN_ERROR_IF(!cctx, memory_allocation, "ZSTD_createCCtx failed");
     result = ZSTD_compressCCtx(cctx, dst, dstCapacity, src, srcSize, compressionLevel);
-    ZSTD_freeCCtx(cctx);;
+    ZSTD_freeCCtx(cctx);
     return result;
 }
 
