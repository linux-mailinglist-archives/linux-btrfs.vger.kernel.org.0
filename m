Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF2924D764
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgHUOe1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 10:34:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:51466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgHUOe0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 10:34:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8B9EAC82;
        Fri, 21 Aug 2020 14:34:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C3379DA730; Fri, 21 Aug 2020 16:33:18 +0200 (CEST)
Date:   Fri, 21 Aug 2020 16:33:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Convert seed devices to proper list API
Message-ID: <20200821143318.GF2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200722142607.GX3703@twin.jikos.cz>
 <dc2379cf-9e8f-031e-4214-d68f6e4d41b1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc2379cf-9e8f-031e-4214-d68f6e4d41b1@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 23, 2020 at 11:02:14AM +0300, Nikolay Borisov wrote:
> Regarding patch 5 - I don't know what made you think there is a
> tree-like structure involved. Simply looking at the old way seeds are
> iterated:
> 
> 	while (seed_devices) {
> 		fs_devices = seed_devices;
> 		seed_devices = fs_devices->seed;
>  		close_fs_devices(fs_devices);
>  		free_fs_devices(fs_devices);
>  	}
> 
> There's no conditional deciding if we should go left/right of the tree.

A tree structure that has only one direction arrows, from leaves to the
root. Where the root is the seed fs and the leaves are the sprouts.

	 fs1 ---> seed
		  ^ ^
	 fs2 -----| |
                    |
	 fs3 -------|

The while loop in each fs goes by the pointers up to the seeding device
and always removes it's references.

I'm not sure about a deeper tree structure here, so the fs3 -> fs2 would
be possible.

> Or let's take for example deleting from a list of seed devices:
> 
> 		tmp_fs_devices = fs_info->fs_devices;
> 		while (tmp_fs_devices) {
> 			if (tmp_fs_devices->seed == fs_devices) {
> 				tmp_fs_devices->seed = fs_devices->seed;
> 				break;
> 			}
> 			tmp_fs_devices = tmp_fs_devices->seed;
> 		}
> 
> Here a simple linear search is performed and when a member of the seed
> list matches our fs_devices it simply pointed 1 past our fs_devices
> 
> When the if inside the loop matches we get the following situation:
> 
> [tmp_fs_devices]->[fs_devices]->[fs_devices->seeds]
> 
> Then we perform [tmp_fs_devices] -> [fs_devices->seed]
> 
> So a simple deletion, just the fact you were confused shows the old code
> is rather wonky.

Well, I still am after reading the above, the missing part is about the
device cloning and that each fs has it's own copy. The tree structure
implies sharing and would need reference counting, but this does not
seem to be so.

I'll add the series to for-next so we have a base for the other seeding
patches but I haven't reviewed it to the point where I'm convinced it's
correct.
