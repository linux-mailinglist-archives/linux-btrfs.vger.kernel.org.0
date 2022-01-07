Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749C04878AD
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 15:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347436AbiAGOKF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 09:10:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52668 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbiAGOKF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jan 2022 09:10:05 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6527E21126;
        Fri,  7 Jan 2022 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641564604;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hnDEslrnlxRt6YrhewUuPpcS9OZDi2eB0/ZaYAFWYPw=;
        b=H0JanqmQLltK0KiOZJwj1Sgohs1NfxqsqATIFjj+0BGbqtGh2VDQNQFv6QD/qSyiG/Iyfa
        YAYmpZNuUps2Nl3WpnhA/KpP0x0t3dIPfjz40yW58SiXgUqPi7kGVPYPfa17R4w5sOmb36
        RfJA5no6ItDqeD15M3c4ExWEduAwRaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641564604;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hnDEslrnlxRt6YrhewUuPpcS9OZDi2eB0/ZaYAFWYPw=;
        b=zXHzeMBH75pjdhhNriQ82R+8AnmGqhsLUynfc4c6OrZTfWaCyTW58JIwV4oJYMTUrwcM51
        S2tA6r5PWEM9pCBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5BD0CA3B81;
        Fri,  7 Jan 2022 14:10:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4FB79DA7A9; Fri,  7 Jan 2022 15:09:33 +0100 (CET)
Date:   Fri, 7 Jan 2022 15:09:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, dan.carpenter@oracle.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: send: fix double and unpaired semaphore unlocks
 on -ENOMEM
Message-ID: <20220107140932.GI14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, dan.carpenter@oracle.com,
        Filipe Manana <fdmanana@suse.com>
References: <a7b1b2094bb0697dda72bdd9bf1ed789cb0b9b08.1641550850.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b1b2094bb0697dda72bdd9bf1ed789cb0b9b08.1641550850.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 07, 2022 at 10:24:18AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing an incremental send, at btrfs_compare_trees(), if we fail to
> allocate the paths or clone extent buffers due to -ENOMEM:
> 
> 1) We can end unlocking the commit root semaphore without having it
>    locked before, when we fail to allocate the paths, because we
>    jump to the 'out' label that always unlocks the semaphore;
> 
> 2) When we fail to clone the extent buffers of the root nodes, we
>    end up doing a double unlock of the commit root semaphore, once
>    before jumping to the 'out' label and then once again under that
>    label.
> 
> So fix those two issues.
> 
> This happens only after my previous patch that has the subject:
> 
>    "btrfs: make send work with concurrent block group relocation"
> 
> And it's not yet in Linus' tree.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> Note: as the patch that introduced the issue is not yet in Linus' tree,
> this can probably still be squashed into the original patch.

Thanks.  It's close to sending the pull request and the patch is in the
middle of the branch but I think the fixup is worth it.
