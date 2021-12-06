Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84746A49C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 19:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhLFSdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 13:33:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37700 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhLFSdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 13:33:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 646B71FD2F;
        Mon,  6 Dec 2021 18:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638815378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ObTkltGFhrZfgwXXVrNSl/LVdwdutxCDSzVnf0vKNhg=;
        b=EQdKo7kiEwAdwzhxmHxmNW5I5lZejf+W1tAQ6JkFCn9pIGeNidpgvoZRcEgRy+s9c1H+9a
        hyxyODaNd/5SyIvIePZlvzvp4MTXH5cSSHNYQXWoOL+WTlc2rIvytA7V4b75SZV4tPHGEn
        puUCfn+AWql5CNijplA+w4xepILcCns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638815378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ObTkltGFhrZfgwXXVrNSl/LVdwdutxCDSzVnf0vKNhg=;
        b=nFgOfkbJ1InyBd2BtOMcra21MCNHa9EwwGlKJlLVvA+Rt0z9MIZeF2RJtplWVP+1UU3gds
        JXYkuXlbs01kuIBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5C8CDA3B85;
        Mon,  6 Dec 2021 18:29:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4218BDA799; Mon,  6 Dec 2021 19:29:24 +0100 (CET)
Date:   Mon, 6 Dec 2021 19:29:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: optimize btree insertions and some cleanups
Message-ID: <20211206182924.GR28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1638440535.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638440535.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 10:30:34AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset optimizes btree insertions to allow better parallelism, by
> having insertions unlocking upper level nodes sooner and avoid blocking
> other tasks, or reduce the time they are blocked, that want to use the
> same nodes. The optimization is in patch 2/6, patch 1/6 is preparation
> for it, and the rest are just cleanups or removing stale code and comments.
> 
> Filipe Manana (6):
>   btrfs: allow generic_bin_search() to take low boundary as an argument
>   btrfs: try to unlock parent nodes earlier when inserting a key
>   btrfs: remove useless condition check before splitting leaf
>   btrfs: move leaf search logic out of btrfs_search_slot()
>   btrfs: remove BUG_ON() after splitting leaf
>   btrfs: remove stale comment about locking at btrfs_search_slot()

Added to misc-next, thanks.
