Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399F41CE366
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgEKS7D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 14:59:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:59796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729530AbgEKS7C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 14:59:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD95AACC5;
        Mon, 11 May 2020 18:59:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8AAE4DA82A; Mon, 11 May 2020 20:58:10 +0200 (CEST)
Date:   Mon, 11 May 2020 20:58:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 00/11] btrfs-progs: Support for SKINNY_BG_TREE feature
Message-ID: <20200511185810.GX18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200505000230.4454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505000230.4454-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 05, 2020 at 08:02:19AM +0800, Qu Wenruo wrote:
> This patchset can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/skinny_bg_tree
> Which is based on v5.6 tag, with extra cleanups (sent to mail list) applied.
> 
> This patchset provides the needed user space infrastructure for SKINNY_BG_TREE
> feature.
> 
> Since it's an new incompatible feature, unlike SKINNY_METADATA, btrfs-progs
> is needed to convert existing fs (unmounted) to new format, and
> vice-verse.
> 
> Now btrfstune can convert regular extent tree fs to bg tree fs to
> improve mount time.
> 
> For the performance improvement, please check the kernel patchset cover
> letter or the last patch.
> (SPOILER ALERT: It's super fast)
> 
> Changelog:
> v2:
> - Rebase to v5.2.2 tag
> - Add btrfstune ability to convert existing fs to BG_TREE feature
> 
> v3:
> - Fix a bug that temp chunks are not cleaned up properly
>   This is caused by wrong timing btrfs_convert_to_bg_tree() is called.
>   It should be called after temp chunks cleaned up.
> 
> - Fix a bug that an extent buffer get leaked
>   This is caused by newly created bg tree not added to dirty list.
> 
> v4:
> - Go with skinny bg tree other than regular block group item
>   We're introducing a new incompatible feature anyway, why not go
>   extreme?
> 
> - Use the same refactor as kernel.
>   To make code much cleaner and easier to read.
> 
> - Add the ability to rollback to regular extent tree.
>   So confident tester can try SKINNY_BG_TREE using their real world
>   data, and rollback if they still want to mount it using older kernels.
>
> Qu Wenruo (11):
>   btrfs-progs: check/lowmem: Lookup block group item in a seperate
>     function
>   btrfs-progs: block-group: Refactor how we read one block group item
>   btrfs-progs: Rename btrfs_remove_block_group() and
>     free_block_group_item()
>   btrfs-progs: block-group: Refactor how we insert a block group item
>   btrfs-progs: block-group: Rename write_one_cahce_group()

I'll add the above patches independently, for the rest I don't know. I
still think the separate tree is somehow wrong so have to convince
myself that it's not.
