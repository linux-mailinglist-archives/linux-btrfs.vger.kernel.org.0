Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E18340F3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 21:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhCRUgk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 16:36:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:47436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhCRUgS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 16:36:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 542C1AD4A;
        Thu, 18 Mar 2021 20:36:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A9A0CDA6E2; Thu, 18 Mar 2021 21:34:14 +0100 (CET)
Date:   Thu, 18 Mar 2021 21:34:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs-progs: common: make sure that qgroup id is in
 range
Message-ID: <20210318203414.GB7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20210316132746.19979-1-realwakka@gmail.com>
 <20210317183647.GW7604@twin.jikos.cz>
 <20210318022208.GA34562@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318022208.GA34562@realwakka>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 18, 2021 at 02:22:20AM +0000, Sidong Yang wrote:
> On Wed, Mar 17, 2021 at 07:36:47PM +0100, David Sterba wrote:
> > On Tue, Mar 16, 2021 at 01:27:46PM +0000, Sidong Yang wrote:
> > > When user assign qgroup with qgroup id that is too big to exceeds
> > > range and invade level value, and it works without any error. but
> > > this action would be make undefined error. this code make sure that
> > > qgroup id doesn't exceed range(0 ~ 2^48-1).
> > 
> > Should the level be also validate? The function parse_qgroupid does not
> > do full validation, so eg 0//0 would be parsed as a path and not as a
> > typo, level larger than 64K will be silently clamped.
> 
> I agree. 0//0 would be parsed as path but it failed in
> btrfs_util_is_subvolume() and goes to err. I understand that upper 16
> bits of qgroupid is for level. so, The valid llevel range is [0~2^16-1].
> But I can't get it that level larger than 64K will be clampled. 

The way the level gets stored into the final qgroup id is level << 48.
For example invalid values 70000/281474976710779 would be stored
as subvol id 123 and level 4465, where the u64 is 0x117100000000007b

> one more question about that, I see that the ioctl calls just store the
> qgroupid without any opeartion with level. is the level meaningless in
> kernel?

The quota groups are hierarchical and the level denotes the level, where
0/subvolid is the lowest always attached to a subvolume and the higher
levels are artificial and may contain any qgroups and do the whole
accounting on the subtree. The original design doc .pdf can be found in
https://git.kernel.org/pub/scm/linux/kernel/git/arne/qgroups-doc.git/tree/
