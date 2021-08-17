Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3EB3EED70
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhHQN3g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 09:29:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41172 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbhHQN3e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 09:29:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 12D6821EBD;
        Tue, 17 Aug 2021 13:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629206940;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/wU2Wsd3qol5Quj2uSDrl/q1yMlnHC3zR55PA35gas=;
        b=sZy7ZXW8bZELyu57zhhBwZFqJilYWvP2GLW3ixBvDVTNPVas2o0tc2syQJ6ALljweC/H/Y
        zv7yJSKm6bhjSQ4GF/dDL9olq1AqhzfjuvvtVNUQPG9uwDXzGot+8MaaaLpLlmE9398dF0
        anOC5426HbCcm1HZvuaw8mDeZhLujWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629206940;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/wU2Wsd3qol5Quj2uSDrl/q1yMlnHC3zR55PA35gas=;
        b=54XuBS3U3pRVIN8gcc8dOeJhhrpPQ8DVziyJN5ksNXnj2ZNvJszPYWcqVY1zWzfx9tmtSe
        FeQqAPCipfR8wiCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0A0E2A3B98;
        Tue, 17 Aug 2021 13:29:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9C94DA72C; Tue, 17 Aug 2021 15:26:03 +0200 (CEST)
Date:   Tue, 17 Aug 2021 15:26:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH] btrfs-progs: mkfs: set super_cache_generation to 0 if
 we're using free space tree
Message-ID: <20210817132603.GL5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>
References: <20210731074240.206263-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731074240.206263-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 31, 2021 at 03:42:40PM +0800, Qu Wenruo wrote:
> [HICCUP]
> There is a bug report that mkfs.btrfs -R free-space-tree still makes
> kernel to try to cleanup the v1 space cache:
> 
>   # mkfs.btrfs -R free-space-tree -f /dev/test/scratch1
>   # mount /dev/test/scratch1 /mnt/btrfs
>   # dmesg | grep cleaning
>   BTRFS info (device dm-6): cleaning free space cache v1
> 
> [CAUSE]
> By default, mkfs.btrfs will set super cache generation to (u64)-1, which
> will inform kernel that the v1 space cache is invalid, needs to
> regenerate it.
> 
> But for free space cache tree, kernel will set super cache generation to
> 0, to indicate v1 space cache is not in use.
> 
> This means, even we enabled free space tree with all the RO compatible
> bits and new tree, as long as super cache generation is not 0, kernel
> still consider the fs has some invalid v1 space cache, and will try to
> remove them.
> 
> [FIX]
> This is not a big deal, but to make the "-R free-space-tree" to really
> work as kernel, we also need to set super cache generation to 0.
> 
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Link: https://lore.kernel.org/linux-btrfs/CAJCQCtSvgzyOnxtrqQZZirSycEHp+g0eDH5c+Kw9mW=PgxuXmw@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
