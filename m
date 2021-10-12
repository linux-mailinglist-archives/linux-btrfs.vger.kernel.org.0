Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBA42A1C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 12:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhJLKTy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 06:19:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42748 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhJLKTy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 06:19:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EF20F1FF4D;
        Tue, 12 Oct 2021 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634033871;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bDgoQ7qABSGxFX4vXXPLGi3wbmlwT3bFXv48VTBP7w=;
        b=2nt+MVg8yBJXAkKwwHgURk0wc7qTbmo4ZRGJmMxIo16jgAW2IPFvUQKOX7424mBMivORuA
        r/cFeMp9yC+u6ZKBv8sUA+GJky6o+gX9etBSkz+B3UBTh74TGuEb84fuck4mTXh4oE146U
        w6ZkT7aho4zgVFyD0cl5LzN4MvvSxWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634033871;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bDgoQ7qABSGxFX4vXXPLGi3wbmlwT3bFXv48VTBP7w=;
        b=itJqgPa8zW3pkGAvS8JhT3lIclgP28YsA4NHqIh8Ju44XO/l6EhQ50XBq5ej5CuEv9Zwc/
        e3VlPAOY2GEebgCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E8C37A3B91;
        Tue, 12 Oct 2021 10:17:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 74FECDA781; Tue, 12 Oct 2021 12:17:28 +0200 (CEST)
Date:   Tue, 12 Oct 2021 12:17:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: print-tree: fix chunk/block group flags
 output
Message-ID: <20211012101728.GW9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211012021719.18496-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012021719.18496-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 12, 2021 at 10:17:19AM +0800, Qu Wenruo wrote:
> [BUG]
> Commit ("btrfs-progs: use raid table for profile names in
> print-tree.c") introduced one bug in block group and chunk flags output
> and changed the behavior:
> 
> 	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 itemsize 80
> 		length 8388608 owner 2 stripe_len 65536 type SINGLE
> 		...
> 	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15993 itemsize 112
> 		length 8388608 owner 2 stripe_len 65536 type DUP
> 		...
> 	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15881 itemsize 112
> 		length 268435456 owner 2 stripe_len 65536 type DUP
> 		...
> 
> Note that, the flag string only contains the profile (SINGLE/DUP/etc...)
> no type (DATA/METADATA/SYSTEM).
> 
> And we have new "SINGLE" string, even that profile has no extra bit to
> indicate that.
> 
> [CAUSE]
> The "SINGLE" part is caused by the raid array which has a name for
> SINGLE profile, even it doesn't have corresponding bit.
> 
> The missing type string is caused by a code bug:
> 
> 		strcpy(buf, name);
> 		while (*tmp) {
> 			*tmp = toupper(*tmp);
> 			tmp++;
> 		}
> 		strcpy(ret, buf);
> 
> The last strcpy() call overrides the existing string in @ret.
> 
> [FIX]
> - Enhance string handling using strn*()/snprintf()
> 
> - Add extra "UKNOWN.0x%llx" output for unknown profiles
> 
> - Call proper strncat() to merge type and profile
> 
> - Add extra handling for "SINGLE" to keep the old output
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
