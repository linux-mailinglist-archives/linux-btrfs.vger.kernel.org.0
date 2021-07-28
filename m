Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71123D8EB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhG1NND (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 09:13:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55156 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhG1NND (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 09:13:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8441222D7;
        Wed, 28 Jul 2021 13:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627477980;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKoV1krvyhIRu7/06MEq9OW+5Bxnj1RcNG8eObanFZc=;
        b=uPaHioeFwITMwDUMD0p3rOLMFde+MnN3L6zBi8vPSu71f64YqaZHGJnHkpmA41C8LFRjHS
        oXjQI0TtXZDIFlOc0P1b4RdRqkKqE7/cfgaxs98lCYy2hRihtcbBUTjqygPez6HUP1FqtZ
        lWoENi0i7HSkd2A1T+MJLG9J794Grzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627477980;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKoV1krvyhIRu7/06MEq9OW+5Bxnj1RcNG8eObanFZc=;
        b=CeTrXBNtlCGRfN+EV14fA+hySimJnTqEOUacRNrAercuXNAMKRMl5hgzhxnjQCrBnxPZav
        5CYNYYDBxPUubvAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D0E6AA3B83;
        Wed, 28 Jul 2021 13:13:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0086DDA8A7; Wed, 28 Jul 2021 15:10:15 +0200 (CEST)
Date:   Wed, 28 Jul 2021 15:10:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
Subject: Re: [PATCH] btrfs: Introduce btrfs_search_backwards function
Message-ID: <20210728131015.GF5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210726140317.4907-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726140317.4907-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 11:03:17AM -0300, Marcos Paulo de Souza wrote:
> It's a common practice to start a search using offset (u64)-1, which is
> the u64 maximum value, meaning that we want the search_slot function to
> be set in the last item with the same objectid and type.
> 
> Once we are in this position, it's a matter to start a search backwards
> by calling btrfs_previous_item, which will check if we'll need to go to
> a previous leaf and other necessary checks, only to be sure that we are
> in last offset of the same object and type. If the item is found,
> convert the ondisk structure to the current endianness of the machine
> running the code.
> 
> The new btrfs_search_backwards function does the all these procedures when
> necessary, and can be used to avoid code duplication.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/ctree.c   | 23 +++++++++++++++++++++++
>  fs/btrfs/ctree.h   |  6 ++++++
>  fs/btrfs/ioctl.c   | 30 ++++++++----------------------
>  fs/btrfs/super.c   | 26 ++++++--------------------
>  fs/btrfs/volumes.c |  7 +------
>  5 files changed, 44 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 394fec1d3fd9..2991ee845813 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2100,6 +2100,29 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
>  	return 0;
>  }
>  
> +/*
> + * Execute search and call btrfs_previous_item to traverse backwards if the item
> + * was not found. If found, convert the stored item to the correct endianness.
> + *
> + * Return 0 if found, 1 if not found and < 0 if error.
> + */
> +int btrfs_search_backwards(struct btrfs_root *root,
> +				struct btrfs_key *key,
> +				struct btrfs_key *found_key,

Is it necessary to have 2 keys? All calls pass the same one, so either
this should be just one or you have other patches that make use of two
distinct keys?

> -		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +		ret = btrfs_search_backwards(root, &key, &key, path);

						   &key, &key
