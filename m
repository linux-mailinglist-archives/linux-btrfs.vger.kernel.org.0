Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8D445A79
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 20:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhKDTNd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 15:13:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47462 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhKDTNd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 15:13:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E58761FD43;
        Thu,  4 Nov 2021 19:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636053053;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rL6W1gFvQNCxIWDUsleBK4rN+3BTYCsIoqERlBPmgP8=;
        b=K3IpWOe8ma+33bpgwXT6vVvg1twIC6FoTc6nl4EixWITpGBuXcJAsFIhrLH3KHriN9nnQV
        UvNvu8CAWrRgXcoBiOgn3pBX8hlferIQwyYjeLcFXXN/IWnHHTP0VrWkbl3OMv6s53X/P2
        neM9bvaT73Wl8t8TfoRMSrQhpf0bIB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636053053;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rL6W1gFvQNCxIWDUsleBK4rN+3BTYCsIoqERlBPmgP8=;
        b=z32CiH7pIYX17mHexXcM/6y/qoWjMHaLksOFKotlcBHAJU1Q7nELG1ObjKk9sajDREzWuE
        GVQ/daIrz1Tx5WBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DE8DE2C167;
        Thu,  4 Nov 2021 19:10:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75A76DA735; Thu,  4 Nov 2021 20:10:17 +0100 (CET)
Date:   Thu, 4 Nov 2021 20:10:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: cleanup related to btrfs super block
Message-ID: <20211104191017.GD28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211021014020.482242-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021014020.482242-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 09:40:17AM +0800, Qu Wenruo wrote:
> This patchset mostly cleans up the mismatch between
> BTRFS_SUPER_INFO_SIZE and sizeof(struct btrfs_super_block).
> 
> This cleanup itself is going to replace all the following snippets:
> 
> 	u8 super_block_data[BTRFS_SUPER_INFO_SIZE];
> 	struct btrfs_super_block *sb;
> 
> 	sb = (struct btrfs_super_block *)super_block_data;
> 
> With:
> 
> 	struct btrfs_super_block sb;
> 
> Also since we're here, also cache csum_type and csum_size in fs_info,
> just like what we did in the kernel.
> 
> Qu Wenruo (3):
>   btrfs-progs: unify sizeof(struct btrfs_super_block) and
>     BTRFS_SUPER_INFO_SIZE
>   btrfs-progs: remove temporary buffer for super block
>   btrfs-progs: cache csum_size and csum_type in btrfs_fs_info

Added to devel, thanks, the removal of temporary buffer for superblock
is nice.
