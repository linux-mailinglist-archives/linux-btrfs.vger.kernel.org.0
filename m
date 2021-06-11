Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36643A49FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 22:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFKUOJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 16:14:09 -0400
Received: from ciao.gmane.io ([116.202.254.214]:44496 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhFKUOI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 16:14:08 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jun 2021 16:14:08 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1lrnQq-0009Xp-19
        for linux-btrfs@vger.kernel.org; Fri, 11 Jun 2021 22:07:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
Date:   Fri, 11 Jun 2021 10:06:58 -1000
Message-ID: <sa0fp3$12s9$1@ciao.gmane.io>
References: <20210430013157.747152-1-nickrterrell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210430013157.747152-1-nickrterrell@gmail.com>
Content-Language: fr
Cc:     linux-crypto@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi list,

Le 29/04/2021 à 15:31, Nick Terrell a écrit :
> From: Nick Terrell <terrelln@fb.com>
> 
> Please pull from
> 
>    git@github.com:terrelln/linux.git tags/v11-zstd-1.4.10
> 
> to get these changes. Alternatively the patchset is included.
> 
> This patchset lists me as the maintainer for zstd and upgrades the zstd library
> to the latest upstream release. The current zstd version in the kernel is a
> modified version of upstream zstd-1.3.1. At the time it was integrated, zstd
> wasn't ready to be used in the kernel as-is. But, it is now possible to use
> upstream zstd directly in the kernel.
> 
> I have not yet released zstd-1.4.10 upstream. I want the zstd version in the
> kernel to match up with a known upstream release, so we know exactly what code
> is running. Whenever this patchset is ready for merge, I will cut a release at
> the upstream commit that gets merged. This should not be necessary for future
> releases.
> 
> The kernel zstd library is automatically generated from upstream zstd. A script
> makes the necessary changes and imports it into the kernel. The changes are:
> 
> 1. Replace all libc dependencies with kernel replacements and rewrite includes.
> 2. Remove unncessary portability macros like: #if defined(_MSC_VER).
> 3. Use the kernel xxhash instead of bundling it.
> 
> This automation gets tested every commit by upstream's continuous integration.
> When we cut a new zstd release, we will submit a patch to the kernel to update
> the zstd version in the kernel.
> 
> I've updated zstd to upstream with one big patch because every commit must build,
> so that precludes partial updates. Since the commit is 100% generated, I hope the
> review burden is lightened. I considered replaying upstream commits, but that is
> not possible because there have been ~3500 upstream commits since the last zstd
> import, and the commits don't all build individually. The bulk update preserves
> bisectablity because bugs can be bisected to the zstd version update. At that
> point the update can be reverted, and we can work with upstream to find and fix
> the bug. After this big switch in how the kernel consumes zstd, future patches
> will be smaller, because they will only have one upstream release worth of
> changes each.
> 
> This patchset adds a new kernel-style wrapper around zstd. This wrapper API is
> functionally equivalent to the subset of the current zstd API that is currently
> used. The wrapper API changes to be kernel style so that the symbols don't
> collide with zstd's symbols. The update to zstd-1.4.6 maintains the same API
> and preserves the semantics, so that none of the callers need to be updated.
> 
> This patchset comes in 2 parts:
> 1. The first 2 patches prepare for the zstd upgrade. The first patch adds the
>     new kernel style API so zstd can be upgraded without modifying any callers.
>     The second patch adds an indirection for the lib/decompress_unzstd.c
>     including of all decompression source files.
> 2. Import zstd-1.4.10. This patch is completely generated from upstream using
>     automated tooling.
> 
> I tested every caller of zstd on x86_64. I tested both after the 1.4.10 upgrade
> using the compatibility wrapper, and after the final patch in this series.
> 
> I tested kernel and initramfs decompression in i386 and arm.
> 
> I ran benchmarks to compare the current zstd in the kernel with zstd-1.4.6.
> I benchmarked on x86_64 using QEMU with KVM enabled on an Intel i9-9900k.
> I found:
> * BtrFS zstd compression at levels 1 and 3 is 5% faster
> * BtrFS zstd decompression+read is 15% faster
> * SquashFS zstd decompression+read is 15% faster
> * F2FS zstd compression+write at level 3 is 8% faster
> * F2FS zstd decompression+read is 20% faster
> * ZRAM decompression+read is 30% faster
> * Kernel zstd decompression is 35% faster
> * Initramfs zstd decompression+build is 5% faster
> 
> The latest zstd also offers bug fixes. For example the problem with large kernel
> decompression has been fixed upstream for over 2 years
> https://lkml.org/lkml/2020/9/29/27.
> 
> Please let me know if there is anything that I can do to ease the way for these
> patches. I think it is important because it gets large performance improvements,
> contains bug fixes, and is switching to a more maintainable model of consuming
> upstream zstd directly, making it easy to keep up to date.
> 
> Best,
> Nick Terrell


I've been using this series on stable kernel since 5.12.3 (now on 
5.12.10) on my main system without issues.

Tested-by: Jean-Denis Girard <jd.girard@sysnux.pf>


Thanks,
-- 
Jean-Denis Girard

SysNux                   Systèmes   Linux   en   Polynésie  française
https://www.sysnux.pf/   Tél: +689 40.50.10.40 / GSM: +689 87.797.527

