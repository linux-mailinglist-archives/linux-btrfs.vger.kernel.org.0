Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E763D2D05
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhGVTPL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 15:15:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40276 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGVTPL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 15:15:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0DA201FD61;
        Thu, 22 Jul 2021 19:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626983745;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJb0Eyq/1swlG0BMXGFeJmwFfZwiUy6nYky2fChw8d4=;
        b=T12Pq1ckMXc+7mkdRj7COJikzoFR8/D4VyyYhozV/4tLq71IqVlnwGvTCZVlgVNPTLpDy3
        41S2ejka0bN06R+hpN3jrFe/PcQDjzSb33tIp2/zxC3vitWjOVW93tAiZYFh9rbkIVjnVB
        MFNOZXm8Fy2Aydl9jIjLBxq1MuLGuZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626983745;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJb0Eyq/1swlG0BMXGFeJmwFfZwiUy6nYky2fChw8d4=;
        b=ErgzlAaU4iAVjsCZ6OivCDtG4949o6MwKEM8g13wqxoYr6GLqVHYue9ARcQW4wP28gsNbU
        3OmG7G0vVT1To6Bg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 066DBA3B87;
        Thu, 22 Jul 2021 19:55:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 40E3FDB225; Thu, 22 Jul 2021 21:53:03 +0200 (CEST)
Date:   Thu, 22 Jul 2021 21:53:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: Use next_leaf instead of next_item when slots >
 nritems
Message-ID: <20210722195303.GB19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20210713135803.4469-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713135803.4469-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 13, 2021 at 10:58:03AM -0300, Marcos Paulo de Souza wrote:
> After calling btrfs_search_slot is a common pratice to check if the
> slot found isn't bigger than number of slots in the current leaf, and if
> so, search for the same key in the next leaf by calling btrfs_next_leaf,
> which calls btrfs_next_old_leaf to do the job.
> 
> Calling btrfs_next_item in the same situation would end up in the same
> code flow, since
> 
> * btrfs_next_item
>   * btrfs_next_old_item
>     * if slot >= nritems(curr_leaf)
>       btrfs_next_old_leaf
> 
> Change btrfs_verify_dev_extents and calculate_emulated_zone_size
> functions to use btrfs_next_leaf in the same situation.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  Please let me know if I'm missing something obvious here, but all other places
>  who check for slot >= nritems are calling next_leaf...

Yeah it should be next_leaf, the next_item increments the slot but at
that time it is already above nritems and it gets reset to 0 once the
pointer is moved to the next leaf.

Added to misc-next, thanks.
