Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968984420C3
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Nov 2021 20:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhKAT0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 15:26:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57690 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhKAT0D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Nov 2021 15:26:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B0D731FD43;
        Mon,  1 Nov 2021 19:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635794607;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GWfQKDIlYY4XOfXyI96YDuhdLGGKS2oOXxOZ1ppuh30=;
        b=CSa3l2Al7lxXISZ3y9CELO8M5yPvWf2diOlAZjYr+jg/Xtzmi01I+oYX1nd8zuN7mmKK4J
        V44MkYYLPaNEb6a88R0TW5Yca+E/JE7LgXkJwzXaa5DAk7jW/Rr8MkfXxvQinwZCc0VdDN
        VnXxFgySYVhYCyZZa+F7aNhwGDJYddw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635794607;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GWfQKDIlYY4XOfXyI96YDuhdLGGKS2oOXxOZ1ppuh30=;
        b=F9R+lYF0xcDh2xCBeJzPE6O4AtKbDBNzYb8WpGWOxs7ON+82N6K3l0KoOPDPjKMT1mUUoe
        IgSGNK24R5hNewAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A8224A3B81;
        Mon,  1 Nov 2021 19:23:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B20C2DA781; Mon,  1 Nov 2021 20:22:52 +0100 (CET)
Date:   Mon, 1 Nov 2021 20:22:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH] btrfs-progs: fix a lowmem mode crash where fatal error
 is not properly handled
Message-ID: <20211101192252.GG20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>
References: <20211101113017.52665-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101113017.52665-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 01, 2021 at 07:30:17PM +0800, Qu Wenruo wrote:
> [BUG]
> When a special image (diverted from fsck/012) has its unused slots (slot
> number >= nritems) with garbage, lowmem mode btrfs check can crash:
> 
>   (gdb) run check --mode=lowmem ~/downloads/good.img.restored
>   Starting program: /home/adam/btrfs/btrfs-progs/btrfs check --mode=lowmem ~/downloads/good.img.restored
>   ...
>   ERROR: root 5 INODE[5044031582654955520] nlink(257228800) not equal to inode_refs(0)
>   ERROR: root 5 INODE[5044031582654955520] nbytes 474624 not equal to extent_size 0
> 
>   Program received signal SIGSEGV, Segmentation fault.
>   0x0000555555639b11 in btrfs_inode_size (eb=0x5555558a7540, s=0x642e6cd1) at ./kernel-shared/ctree.h:1703
>   1703	BTRFS_SETGET_FUNCS(inode_size, struct btrfs_inode_item, size, 64);
>   (gdb) bt
>   #0  0x0000555555639b11 in btrfs_inode_size (eb=0x5555558a7540, s=0x642e6cd1) at ./kernel-shared/ctree.h:1703
>   #1  0x0000555555641544 in check_inode_item (root=0x5555556c2290, path=0x7fffffffd960) at check/mode-lowmem.c:2628
> 
> [CAUSE]
> At check_inode_item() we have path->slot[0] at 29, while the tree block
> only has 26 items.
> 
> This happens because two reasons:
> 
> - btrfs_next_item() never reverts its slots
>   Even if we failed to read next leaf.
> 
> - check_inode_item() doesn't inform the caller that a fatal error
>   happened
>   In check_inode_item(), if btrfs_next_item() failed, it goes to out
>   label, which doesn't really set @err properly.
> 
> This means, when check_inode_item() fails at btrfs_next_item(), it will
> increase path->slots[0], while it's already beyond current tree block
> nritems.
> 
> When the slot increases furthermore, and if the unused item slots have
> some garbage, we will get invalid btrfs_item_ptr() result, and causing
> above segfault.
> 
> [FIX]
> Fix the problems by two ways:
> 
> - Make btrfs_next_item() to revert its path->slots[0] on failure
> 
> - Properly detect fatal error from check_inode_item()
> 
> By this, we will no longer crash on the crafted image.
> 
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Issue: #412
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks, added to devel and queued for 5.15.
