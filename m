Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E573B026C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 13:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhFVLLL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 07:11:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46638 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhFVLLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 07:11:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0A6D41FD36;
        Tue, 22 Jun 2021 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624360134;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ayl6J6fsMmNtze/6AwuxEat0KAf2vT66a4VHfcMU/TE=;
        b=Wnmq3o23KDuGpOpyFjOv3nAcaq4VDZaz2pqT1eEUAq41lxri+IjLu4TGDvN1z/O/Koac7T
        YZY3MZ5yxyFQulZySbHM3tsFDUn/be+9h+Lpxfs2onlyRBDbnPbQbagxHI3TbT3xLkUx7Z
        BrhlQnAcwpLrj5pGJCczJThaYPkEyUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624360134;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ayl6J6fsMmNtze/6AwuxEat0KAf2vT66a4VHfcMU/TE=;
        b=UduDBUjG6ZCJjY83Uv8IP6L0wqv3Q1YxKyC6xkty6lPaHLLhVnBTrcpxQwvYOjNr+bMOvj
        WvTbk1DmQkpgWJDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 03DEBA3B85;
        Tue, 22 Jun 2021 11:08:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5A3DEDA7B4; Tue, 22 Jun 2021 13:06:03 +0200 (CEST)
Date:   Tue, 22 Jun 2021 13:06:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: ensure relocation never runs while we have
 send operations running
Message-ID: <20210622110603.GC28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1624269734.git.fdmanana@suse.com>
 <d4d0d24f945c868a46aab082e8d5809806cfeffb.1624269734.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d0d24f945c868a46aab082e8d5809806cfeffb.1624269734.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 21, 2021 at 11:10:38AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Relocation and send do not play well together because while send is
> running a block group can be relocated, a transaction committed and
> the respective disk extents get re-allocated and written to or discarded
> while send is about to do something with the extents.
> 
> This was explained in commit 9e967495e0e0ae ("Btrfs: prevent send failures
> and crashes due to concurrent relocation"), which prevented balance and
> send from running in parallel but it did not address one remaining case
> where chunk relocation can happen: shrinking a device (and device deletion
> which shrinks a device's size to 0 before deleting the device).
> 
> We also have now one more case where relocation is triggered: on zoned
> filesystems partially used block groups get relocated by a background
> thread, introduced in commit 18bb8bbf13c183 ("btrfs: zoned: automatically
> reclaim zones").
> 
> So make sure that instead of preventing balance from running when there
> are ongoing send operations, we prevent relocation from happening.
> This uses the infrastructure recently added by a patch that has the
> subject: "btrfs: add cancellable chunk relocation support".
> 
> Also it adds a spinlock used exclusively for the exclusivity between
> send and relocation, as before fs_info->balance_mutex was used, which
> would make an attempt to run send to block waiting for balance to
> finish, which can take a lot of time on large filesystems.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

> @@ -3818,7 +3829,9 @@ static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
>  	/* Requested after start, clear bit first so any waiters can continue */
>  	if (atomic_read(&fs_info->reloc_cancel_req) > 0)
>  		btrfs_info(fs_info, "chunk relocation canceled during operation");
> +	spin_lock(&fs_info->send_reloc_lock);
>  	clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
> +	spin_unlock(&fs_info->send_reloc_lock);
>  	atomic_set(&fs_info->reloc_cancel_req, 0);

This is an interesting pattern, the lock protects the first part in
start and the atomic bit changes and wakeup are for the rest.
