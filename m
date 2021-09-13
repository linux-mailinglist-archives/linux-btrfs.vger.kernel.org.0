Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD164097DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbhIMPwh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 11:52:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49016 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbhIMPwc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 11:52:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CB3EF20001;
        Mon, 13 Sep 2021 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631548274;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQXIwdXFxbVJLELsOcjAqwY0kZMkp6QY0dyUJpWF8JE=;
        b=uegSpDBY7jb2+aSN6cr/a32ha3bfzQy7xd+KdGRk6rxQeGMRnvaVNcC/wB98hK2V0Ominz
        GDS9xv7n4cnyC/LYGrqFSrjUCvPGm0S+TCuSRlP4KVc99wlLOMP3N1zor0Y31qjh3pFbg1
        sqCeW7aulSvz6UcFvcan2RBkvgjUfu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631548274;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQXIwdXFxbVJLELsOcjAqwY0kZMkp6QY0dyUJpWF8JE=;
        b=10D+r6185y/QErPIP3DeHf66k7PsAJgb/2D0COI0XoMEqyWYG3vj9sqB+L1V6oieG3d/Wm
        IvtMCJGukY6nNEDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9706DA3B8E;
        Mon, 13 Sep 2021 15:51:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2A76DA781; Mon, 13 Sep 2021 17:51:06 +0200 (CEST)
Date:   Mon, 13 Sep 2021 17:51:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 0/8] btrfs: zoned: unify relocation on a zoned and
 regular FS
Message-ID: <20210913155105.GC15306@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1631117101.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1631117101.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 09, 2021 at 01:19:24AM +0900, Johannes Thumshirn wrote:
> A while ago David reported a bug in zoned btrfs' relocation code. The bug is
> triggered because relocation on a zoned filesystem does not preallocate the
> extents it copies and a writeback process running in parallel can cause a
> split of the written extent. But splitting extents is currently not allowed on
> relocation as it assumes a one to one copy of the relocated extents.
> 
> This causes transaction aborts and the filessytem switching to read-only in
> order to prevent further damage.
> 
> The first patch in this series is just a preparation to avoid overly long
> lines in follow up patches. Patch number two adds a dedicated block group for
> relocation on a zoned filesystem. Number three excludes multiple processes
> from adding pages to a relocation inode in a zoned filesystem. Patch four
> switches relocation from REQ_OP_ZONE_APPEND to regular REQ_OP_WRITE, five
> prepares an ASSERT()ion that we can enter the nocow path on a zoned filesystem
> under very special circumstances and the sixth patch then switches the
> relocation code for a zoned filesystem to using the same code path as we use
> on a non zoned filesystem. As the changes before have made the prerequisites
> to do so. The last two patches in this series are just a simple rename of a
> function whose name we have twice in the btrfs codebase but with a different
> purpose in different files and a cleanup of a complicated boolean comparison
> into an if to make it stand out.
> 
> Changes to v1:
> - Added patches 3 and 8
> - Added comments to patches 4 and 5 (Naohiro)
> - Move btrfs_clear_data_reloc_bg() out of line (David)
> - Untangle the 'skip' assing into an if (David)
> - Commented new fs_info members (David)
> 
> Johannes Thumshirn (8):
>   btrfs: introduce btrfs_is_data_reloc_root
>   btrfs: zoned: add a dedicated data relocation block group
>   btrfs: zoned: only allow one process to add pages to a relocation
>     inode
>   btrfs: zoned: use regular writes for relocation
>   btrfs: check for relocation inodes on zoned btrfs in should_nocow
>   btrfs: zoned: allow preallocation for relocation inodes
>   btrfs: rename setup_extent_mapping in relocation code
>   btrfs: zoned: let the for_treelog test in the allocator stand out

I did a few minor fixups, patches moved from topic branch to misc-next.
Thanks.
