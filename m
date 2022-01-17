Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADDE490FC4
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 18:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiAQRkD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 12:40:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43824 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiAQRkC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 12:40:02 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CB7B9212C6;
        Mon, 17 Jan 2022 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642441201;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1xBp5SR1bDeMGBwBzudGjSZgf6I2RX45xkN1gyPnHs=;
        b=rZ/3rRZYYS8iq4NPwVO34BkAloWAKhRepb83Az0/gKlu1lWFLfBr7qBstQ4yrHcT2BZkX/
        Yo7LYXR+uf/97+wsYVQUsWV15jgz/lyM9aX0gaMlbWW1mhq/C29sJTmT7BrY4Dl2VUftDP
        rexSFW+CrSNIsJZvfUBKRJsTXea9DQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642441201;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1xBp5SR1bDeMGBwBzudGjSZgf6I2RX45xkN1gyPnHs=;
        b=noAhGBS+pMlqYNuC6JHMgdt7QegmLVENNauWxv37hP+lk5ZNc+S/Y5svghDPU3KQNSJcWn
        XvinApjRU5yqi/AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C5744A3B89;
        Mon, 17 Jan 2022 17:40:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 97DEBDA7A3; Mon, 17 Jan 2022 18:39:25 +0100 (CET)
Date:   Mon, 17 Jan 2022 18:39:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix too long loop when defragging a 1 byte file
Message-ID: <20220117173925.GL14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <bcbfce0ff7e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcbfce0ff7e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 17, 2022 at 04:28:29PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When attempting to defrag a file with a single byte, we can end up in a
> too long loop, which is nearly infinite because at btrfs_defrag_file()
> we end up with the variable last_byte assigned with a value of
> 18446744073709551615 (which is (u64)-1). The problem comes from the fact
> we end up doing:
> 
>     last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
> 
> So if last_byte was assigned 0, which is i_size - 1, we underflow and
> end up with the value 18446744073709551615.
> 
> This is trivial to reproduce and the following script triggers it:
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdj
>   MNT=/mnt/sdj
> 
>   mkfs.btrfs -f $DEV
>   mount $DEV $MNT
> 
>   echo -n "X" > $MNT/foobar
> 
>   btrfs filesystem defragment $MNT/foobar
> 
>   umount $MNT
> 
> So fix this by not decrementing last_byte by 1 before doing the sector
> size round up. Also, to make it easier to follow, make the round up right
> after computing last_byte.
> 
> Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
> Reported-by: Anthony Ruhier <aruhier@mailbox.org>
> Link: https://lore.kernel.org/linux-btrfs/0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thank you very much, I'll try to get it to out ASAP so it could get
released in the next week stable update.
