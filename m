Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE912E921
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 18:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgABRLH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 12:11:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:37382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgABRLH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 12:11:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AD509AC52;
        Thu,  2 Jan 2020 17:11:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8122DA790; Thu,  2 Jan 2020 18:10:57 +0100 (CET)
Date:   Thu, 2 Jan 2020 18:10:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs-progs: Fixes for github issues
Message-ID: <20200102171056.GM3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191218011942.9830-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218011942.9830-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 18, 2019 at 09:19:36AM +0800, Qu Wenruo wrote:
> There are a new batch of fuzzed images for btrfs-progs. They are all
> reported by Ruud van Asseldonk from github.
> 
> Patch 1 will make QA life easier by remove the extra 300s wait time.
> Patch 2~5 are all the meat for the fuzzed images.
> 
> Just a kind reminder, mkfs/020 test will fail due to tons of problems:
> - Undefined $csum variable
> - Undefined $dev1 variable

These are fixed in devel now.

> - Bad kernel probe for support csum
>   E.g. if Blake2 not compiled, it still shows up in supported csum algo,
>   but will fail to mount.

The list of supported is from the point of view of the filesystem.
Providing the module is up to the user.

> All other tests pass.
> 
> Qu Wenruo (6):
>   btrfs-progs: tests: Add --force for repair command
>   btrfs-progs: check/original: Do extra verification on file extent item
>   btrfs-progs: disk-io: Verify the bytenr passed in is mapped for
>     read_tree_block()
>   btrfs-progs: Add extra chunk item size check
>   btrfs-progs: extent-tree: Kill the BUG_ON() in btrfs_chunk_readonly()
>   btrfs-progs: extent-tree: Fix a by-one error in
>     exclude_super_stripes()

All added to devel, thanks.
