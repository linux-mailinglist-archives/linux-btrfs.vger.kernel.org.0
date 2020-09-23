Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F6B275E56
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgIWRJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 13:09:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:55654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWRJc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 13:09:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CCA9BAAC7;
        Wed, 23 Sep 2020 17:10:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5E359DA6E3; Wed, 23 Sep 2020 19:08:14 +0200 (CEST)
Date:   Wed, 23 Sep 2020 19:08:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, kernel test robot <lkp@intel.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
Message-ID: <20200923170814.GR6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        Martin Steigerwald <martin@lichtvoll.de>
References: <20200922023701.32654-1-wqu@suse.com>
 <202009231428.5CFBSt9U%lkp@intel.com>
 <20200923093133.GJ6756@twin.jikos.cz>
 <ab9e6eb3-6aff-1ea3-62e0-4489fe73e066@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab9e6eb3-6aff-1ea3-62e0-4489fe73e066@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 23, 2020 at 06:28:41PM +0800, Qu Wenruo wrote:
> On 2020/9/23 下午5:31, David Sterba wrote:
> > On Wed, Sep 23, 2020 at 02:23:18PM +0800, kernel test robot wrote:
> >> Hi Qu,
> >>
> >> Thank you for the patch! Yet something to improve:
> >>
> >> [auto build test ERROR on kdave/for-next]
> >> [also build test ERROR on v5.9-rc6 next-20200922]
> >> [If your patch is applied to the wrong git tree, kindly drop us a note.
> >> And when submitting patch, we suggest to use '--base' as documented in
> >> https://git-scm.com/docs/git-format-patch]
> >>
> >> url:    https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-fix-false-alert-caused-by-legacy-btrfs-root-item/20200922-103827
> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> >> config: x86_64-randconfig-a014-20200920 (attached as .config)
> >> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 6a6b06f5262bb96523eceef4a42fe8e60ae2a630)
> >> reproduce (this is a W=1 build):
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         # install x86_64 cross compiling tool for clang build
> >>         # apt-get install binutils-x86-64-linux-gnu
> >>         # save the attached .config to linux build tree
> >>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>    In file included from <built-in>:1:
> >>>> ./usr/include/linux/btrfs_tree.h:651:19: error: unknown type name 'size_t'
> >>    static __inline__ size_t btrfs_legacy_root_item_size(void)
> >>                      ^
> > 
> > u32 should be fine here, we use it for all the other item helpers.
> > 
> Sure, but I'm a little interested in why it passes in gcc v10.20...

It depends on the config options. It passed for me too, but Josef
noticed it does not build and pointed to the CONFIG_UAPI_HEADER_TEST
and CONFIG_HEADERS_INSTALL options.

This is a valid report and needs to be fixed, I looked around to the
UAPI headers that use offset of how this is solved and it's enough to
include linux/stddef.h (or stddef.h for non-kernel build). Updated
misc-next pushed. Thanks.
