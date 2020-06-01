Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CAE1EA74D
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgFAPsw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:48:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:38712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgFAPsw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:48:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68F99ABCE;
        Mon,  1 Jun 2020 15:48:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E250ADA79B; Mon,  1 Jun 2020 17:48:48 +0200 (CEST)
Date:   Mon, 1 Jun 2020 17:48:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] 3 small cleanups for find_first_block_group
Message-ID: <20200601154847.GZ18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
 <SN4PR0401MB3598731CEEA486E8601766999B8F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598731CEEA486E8601766999B8F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 29, 2020 at 02:25:32PM +0000, Johannes Thumshirn wrote:
> On 27/05/2020 10:12, Johannes Thumshirn wrote:
> > While trying to learn the Block Group code I've found some cleanup
> > possibilities for find_first_block_group().
> > 
> > Here's a proposal to make $ffbg a bit more easier to read by untangling the
> > gotos and if statements.
> > 
> > The patch set is based on misc-next from May 26 morning with 
> > HEAD 3f4a266717ed ("btrfs: split btrfs_direct_IO to read and write part")
> > and xfstests showed no regressions to the base misc-next in my test setup.
> > 
> > Changes to v1:
> > - Pass btrfs_path instead of leaf & slot to read_bg_from_eb (Nikolay)
> > - Don't comment about the size change (Nikolay)
> > - Add Nikolay's Reviewed-by's
> > 
> > Johannes Thumshirn (3):
> >   btrfs: remove pointless out label in find_first_block_group
> >   btrfs: get mapping tree directly from fsinfo in find_first_block_group
> >   btrfs: factor out reading of bg from find_frist_block_group
> > 
> >  fs/btrfs/block-group.c | 108 ++++++++++++++++++++++-------------------
> >  1 file changed, 58 insertions(+), 50 deletions(-)
> 
> David, any comment if you will consider this series? Patch 2/3 actually makes 
> the function more complainant to the kernel's coding style.

2/3 and 3/3 are good cleanups, please resend, thanks.
