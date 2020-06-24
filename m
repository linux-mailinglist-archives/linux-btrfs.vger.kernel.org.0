Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4679C2077BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 17:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404341AbgFXPkU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 11:40:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:46196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404146AbgFXPkU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 11:40:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B7D5AD76;
        Wed, 24 Jun 2020 15:40:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C00A2DA79B; Wed, 24 Jun 2020 17:40:06 +0200 (CEST)
Date:   Wed, 24 Jun 2020 17:40:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <lkp@intel.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>, kbuild-all@lists.01.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Message-ID: <20200624154006.GS27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kernel test robot <lkp@intel.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        kbuild-all@lists.01.org, linux-btrfs@vger.kernel.org
References: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
 <202006242200.sloaHMOL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006242200.sloaHMOL%lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 24, 2020 at 10:15:20PM +0800, kernel test robot wrote:
>    fs/btrfs/ioctl.c:1715:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    fs/btrfs/ioctl.c:1715:17: sparse:    struct rcu_string [noderef] <asn:4> *
>    fs/btrfs/ioctl.c:1715:17: sparse:    struct rcu_string *
> >> fs/btrfs/ioctl.c:3221:25: sparse: sparse: cast to restricted __le16
>    fs/btrfs/ioctl.c:3260:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    fs/btrfs/ioctl.c:3260:40: sparse:    struct rcu_string [noderef] <asn:4> *
>    fs/btrfs/ioctl.c:3260:40: sparse:    struct rcu_string *
> 
>   3220		fi_args->csum_type =
> > 3221				le16_to_cpu(btrfs_super_csum_type(fs_info->super_copy));

The report is valid, btrfs_super_csum_type returns the data in CPU byte
order.
