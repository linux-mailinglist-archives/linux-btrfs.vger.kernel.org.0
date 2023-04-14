Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EE16E1BA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Apr 2023 07:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDNFZE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Apr 2023 01:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNFZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Apr 2023 01:25:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352D11B3;
        Thu, 13 Apr 2023 22:25:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C1D2368AA6; Fri, 14 Apr 2023 07:24:58 +0200 (CEST)
Date:   Fri, 14 Apr 2023 07:24:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [btrfs] 4ae2edf12d: fio.write_iops -11.9%
 regression
Message-ID: <20230414052458.GA11616@lst.de>
References: <202304140917.9e9f5c1-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304140917.9e9f5c1-yujie.liu@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 14, 2023 at 10:01:51AM +0800, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed a -11.9% regression of fio.write_iops on:
> 
> commit: 4ae2edf12d49fdbaea2dfda0bb2ec06501bd3493 ("btrfs: simplify parameters of btrfs_lookup_bio_sums")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Can you revalidate this?  The patch is purely a parameter passing
cleanup, so a large reduction in IOPS looks very suspicious.

