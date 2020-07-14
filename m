Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BFA21EF31
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 13:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGNLXk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 07:23:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:57360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgGNLXj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 07:23:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A590AAEFB;
        Tue, 14 Jul 2020 11:23:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 42DDCDA790; Tue, 14 Jul 2020 13:23:16 +0200 (CEST)
Date:   Tue, 14 Jul 2020 13:23:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, kernel test robot <lkp@intel.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] btrfs: assert sizes of ioctl structures
Message-ID: <20200714112316.GO3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kernel test robot <lkp@intel.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-btrfs@vger.kernel.org
References: <20200713122901.1773-5-johannes.thumshirn@wdc.com>
 <202007140414.27egNqJz%lkp@intel.com>
 <20200714112053.GN3703@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714112053.GN3703@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 14, 2020 at 01:20:53PM +0200, David Sterba wrote:
> On Tue, Jul 14, 2020 at 05:01:21AM +0800, kernel test robot wrote:
> > Hi Johannes,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on v5.8-rc5]
> > [cannot apply to kdave/for-next btrfs/next next-20200713]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use  as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Johannes-Thumshirn/Two-furhter-additions-for-fsinfo-ioctl/20200713-203321
> > base:    11ba468877bb23f28956a35e896356252d63c983
> > config: x86_64-randconfig-a016-20200713 (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 02946de3802d3bc65bc9f2eb9b8d4969b5a7add8)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >    In file included from <built-in>:1:
> >    In file included from ./usr/include/linux/btrfs_tree.h:5:
> > >> ./usr/include/linux/btrfs.h:35:15: error: expected parameter declarator
> >    static_assert(sizeof(struct btrfs_ioctl_vol_args) == 4096);
> >                  ^
> 
> Does that mean that clang (11.0) does not support static_assert? We
> aren't doing anything special here, include only the standard kernel
> headers and use macros as intended.

Never mind, Johanness fixed it in v2, the macro is not defined for
non-kernel build.
