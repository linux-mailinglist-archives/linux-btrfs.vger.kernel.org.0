Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30742CEF5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 15:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgLDOFa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 09:05:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:46334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgLDOFa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 09:05:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04381AC75;
        Fri,  4 Dec 2020 14:04:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DBFD1DA7E3; Fri,  4 Dec 2020 15:03:14 +0100 (CET)
Date:   Fri, 4 Dec 2020 15:03:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <lkp@intel.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kbuild-all@lists.01.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Petr Malat <oss@malat.biz>
Subject: Re: [PATCH v6 3/3] lib: zstd: Upgrade to latest upstream zstd
 version 1.4.6
Message-ID: <20201204140314.GS6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kernel test robot <lkp@intel.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, kbuild-all@lists.01.org,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Chris Mason <chris.mason@fusionio.com>, Petr Malat <oss@malat.biz>
References: <20201202203242.1187898-4-nickrterrell@gmail.com>
 <202012030743.Xg5AJ7Ms-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012030743.Xg5AJ7Ms-lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 03, 2020 at 07:58:16AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
>    lib/zstd/compress/zstd_double_fast.c: In function 'ZSTD_compressBlock_doubleFast_extDict_generic':
> >> lib/zstd/compress/zstd_double_fast.c:501:1: warning: the frame size of 3724 bytes is larger than 1280 bytes [-Wframe-larger-than=]

Frame size 3724?

>    lib/zstd/compress/zstd_double_fast.c: In function 'ZSTD_compressBlock_doubleFast':
>    lib/zstd/compress/zstd_double_fast.c:336:1: warning: the frame size of 3792 bytes is larger than 1280 bytes [-Wframe-larger-than=]

3792

>    lib/zstd/compress/zstd_double_fast.c: In function 'ZSTD_compressBlock_doubleFast_dictMatchState':
>    lib/zstd/compress/zstd_double_fast.c:356:1: warning: the frame size of 3808 bytes is larger than 1280 bytes [-Wframe-larger-than=]

3808

>    lib/zstd/compress/zstd_fast.c: In function 'ZSTD_compressBlock_fast_extDict_generic':
> >> lib/zstd/compress/zstd_fast.c:476:1: warning: the frame size of 2736 bytes is larger than 1280 bytes [-Wframe-larger-than=]

2736

>    lib/zstd/compress/zstd_fast.c: In function 'ZSTD_compressBlock_fast':
>    lib/zstd/compress/zstd_fast.c:204:1: warning: the frame size of 1508 bytes is larger than 1280 bytes [-Wframe-larger-than=]

1508

>    lib/zstd/compress/zstd_fast.c: In function 'ZSTD_compressBlock_fast_dictMatchState':
>    lib/zstd/compress/zstd_fast.c:372:1: warning: the frame size of 1540 bytes is larger than 1280 bytes [-Wframe-larger-than=]

1540

For userspace code it's nothing but in kernel it's a lot for a single
function. The largest number is almost one page, there were days where
this would be one half of the whole stack space. We can't waste precious
resources like that. Taking the userspace code as-is does not seem to
work.
