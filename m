Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C49F212904
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 18:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgGBQIk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 12:08:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:55036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgGBQIk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 12:08:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6402AADE3;
        Thu,  2 Jul 2020 16:08:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CCA57DA732; Thu,  2 Jul 2020 18:08:21 +0200 (CEST)
Date:   Thu, 2 Jul 2020 18:08:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
Subject: Re: [PATCH 3/4] btrfs: preallocate anon_dev for subvolume and
 snapshot creation
Message-ID: <20200702160821.GT27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-4-wqu@suse.com>
 <20200616151004.GE27795@twin.jikos.cz>
 <f792151a-ebd5-2ac7-c9ac-0c274ea1ab8e@gmx.com>
 <20200701173928.GF27795@twin.jikos.cz>
 <0cfc15be-3a4a-c6d2-b294-eeb0a4506df4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cfc15be-3a4a-c6d2-b294-eeb0a4506df4@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 07:56:57AM +0800, Qu Wenruo wrote:
> On 2020/7/2 上午1:39, David Sterba wrote:
> > On Wed, Jul 01, 2020 at 11:25:27AM +0800, Qu Wenruo wrote:
> > Adding the anon_dev argument to btrfs_get_fs_root is wrong and I have
> > never suggested that. What I meant is to put the actual id allocation
> > to the callers where the subvolume is created, ie only 2 places.
> 
> You mean to extract btrfs_init_fs_root() out of btrfs_get_fs_root()?
> 
> That looks a little risky and I can't find any good solution to make it
> more elegant than the current one.

I spent more time reading through the get-fs-root functions and the main
problem is that btrfs_get_fs_root is doing several things, and it makes
a lot of code simple, I certainly want to keep it that way.

The idea was to pre-insert the new root (similar to the root item
insertion, btrfs_insert_root) and not letting btrfs_get_fs_root call to
btrfs_init_fs_info where the anon_bdev allocation happens for all the
other non-ioctl cases.

Which could be done by factoring out btrfs_init_fs_root from
btrfs_get_fs_root. This would allow to extend only btrfs_init_fs_root
arguments with the anon_bdev, and keep btrfs_get_fs_root intact.
So this is splitting the API from the end.

What you originally proposed is a split from the begnning, ie. add a
common implementation for existing and new and provide btrfs_get_fs_root
and btrfs_get_new_fs_root that would hide the additional parameters.

Both ways are IMO valid but I thought it would be easier to pass the
anon bdev inside ioctl callbacks. The problem that makes my proposal
less appealing is that btrfs_read_tree_root gets called earlier than
I'd like so factoring everything after btrfs_init_fs_root would not be
so straightforward.

In conclusion, your proposal is better and I'm going to merge it.

> Although I would definitely remove the "__" prefix as we shouldn't add
> such prefix anymore.

Yeah with the small naming fixups.
