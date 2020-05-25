Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6F71E10D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390921AbgEYOoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 10:44:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388687AbgEYOoK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 10:44:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4DEF3B16D;
        Mon, 25 May 2020 14:44:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 92245DA72D; Mon, 25 May 2020 16:43:11 +0200 (CEST)
Date:   Mon, 25 May 2020 16:43:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v4 00/11] btrfs-progs: mkfs: Quota support through
 -Q|--quota
Message-ID: <20200525144311.GV18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        wqu@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200318202148.14828-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318202148.14828-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 18, 2020 at 05:21:37PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Hi guys,
> 
> This if the forth version of this patchset. The last submission of these patches
> was in 2018[1]. This version is based on top on the current devel branch, with
> minor cleanups, minor conflicts and only a real fix in patch 0008. I would like
> to ask you guys to review these patches, since v3 didn't receive any feedback at
> the time.
> 
> I only added my SoB in three patches, which were those were I needed a manual
> intervention, or a specific fix as I mentioned.
> 
> Thanks for your review,
>   Marcos
> 
> Original cover letter for Wenruo:
> This patchset adds quota support, which means the result fs will have
> quota enabled by default, and its accounting is already consistent, no
> manually rescan or quota enable is needed.
> 
> The overall design of such support is:
> 1) Create needed tree
>    Both btrfs_root and real root item and tree root leaf.
>    For this, a new infrastructure, btrfs_create_tree(), is added for
>    this.
> 
> 2) Fill quota root with basic skeleton
>    Only 3 items are really needed
>    a) global quota status item
>    b) quota info for specified qgroup
>    c) quota limit for specified qgroup
> 
>    Currently we insert all qgroup items for all existing file trees.
>    If we're going to support extra subvolume at mkfs time, just pass the
>    subvolume id into insert_qgroup_items().
> 
>    The content doesn't matter at all.
> 
> 3) Repair qgroups using infrastructure from qgroup-verify
>    In fact, qgroup repair is just offline rescan.
>    Although the original qgroup-verify infrastructure is mostly noisy,
>    modify it a little to make it silent to function as offline quota
>    rescan.
> 
> And such support is mainly designed for developers and QA guys.
> 
> As to enable quota, before we must normally mount the fs, enable quota
> (and rescan if needed).
> This ioctl based procedure is not common, and fstests doesn't provide
> such support.
> (Not to mention sometimes rescan itself can be buggy)
> 
> There are several attempts to make fstests to support it, but due to
> different reasons, all these attempts failed.
> 
> To make it easier to test all existing test cases with btrfs quota
> enabled, the current best method is to support quota at mkfs time, and
> here comes the patchset.
> 
> [1]: https://lore.kernel.org/linux-btrfs/20180807081938.21348-1-wqu@suse.com/T/#m107735cecbf4729b599e6e4eee0a54802909b30d
> 
> Qu Wenruo (11):
>   btrfs-progs: qgroup-verify: Avoid NULL pointer dereference for later
>     silent qgroup repair
>   btrfs-progs: qgroup-verify: Also repair qgroup status version
>   btrfs-progs: qgroup-verify: Use fs_info->readonly to check if we
>     should repair qgroups
>   btrfs-progs: qgroup-verify: Move qgroup classification out of
>     report_qgroups
>   btrfs-progs: qgroup-verify: Allow repair_qgroups function to do silent
>     repair
>   btrfs-progs: ctree: Introduce function to create an empty tree
>   btrfs-progs: mkfs: Introduce function to insert qgroup info and limit
>     items
>   btrfs-progs: mkfs: Introduce function to setup quota root and rescan

I've applied the above with some fixes to devel.

>   btrfs-progs: mkfs: Introduce mkfs time quota support
>   btrfs-progs: test/mkfs: Add test case for -Q|--quota option
>   btrfs-progs: test/mkfs: Add test case for --rootdir and --quota

The option name needs to be -R as used to be in V2 of Qu's original
patchset. I don't know why this got changed to the single purpose -Q but
-R will be used to specifiy runtime options, similar to what -O does
now.
