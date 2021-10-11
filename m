Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C884291F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbhJKOgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 10:36:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60788 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbhJKOgo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 10:36:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9C8F11FEBE;
        Mon, 11 Oct 2021 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633962883;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcQqBAdk+wl1s09NF25V5pmSTDMFHjP+89yRrCC82Gk=;
        b=AXwFDtvholzBCYKgJty8LG1rGkAKDlAoZQShmf2/T1eXS+3nKR8yBG4VsC3v1cxSul4GAE
        HWDmSNri2G2P6DhujWUzIXUHyy0RpbLl9YWOHsMS/ah5yXJlZguvO7dn4dF1sA+KZcxVh7
        ioPul2BH//r9qK2XSTeejVmFbGuIp6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633962883;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcQqBAdk+wl1s09NF25V5pmSTDMFHjP+89yRrCC82Gk=;
        b=NZGPBdUBy33sFTFTBJdMkR7hZe9r2zq7u9Hloht1EFmCXBjBrwuGgMLndN9hX+m6YQXIpN
        4uXjlu3wRQ+TM/AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9456EA3B81;
        Mon, 11 Oct 2021 14:34:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F5E1DA781; Mon, 11 Oct 2021 16:34:20 +0200 (CEST)
Date:   Mon, 11 Oct 2021 16:34:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, FireFish5000 <firefish5000@gmail.com>
Subject: Re: [PATCH v2 2/3] btrfs-progs: mkfs: recow all tree blocks properly
Message-ID: <20211011143419.GJ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, FireFish5000 <firefish5000@gmail.com>
References: <20211011120650.179017-1-wqu@suse.com>
 <20211011120650.179017-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011120650.179017-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 08:06:49PM +0800, Qu Wenruo wrote:
> [BUG]
> Since btrfs-progs v5.14, mkfs.btrfs no longer cleans up the temporary
> SINGLE metadata chunks if "-R free-space-tree" is specified:
> 
>  $ mkfs.btrfs  -f -R free-space-tree -m dup -d dup /dev/test/test
>  $ btrfs ins dump-tree -t chunk /dev/test/test | grep "type METADATA"
> 		length 8388608 owner 2 stripe_len 65536 type METADATA
> 		length 268435456 owner 2 stripe_len 65536 type METADATA|DUP
> 
> [CAUSE]
> Since commit 4b6cf2a3eb78 ("btrfs-progs: mkfs: generate free space tree
> at make_btrfs() time"), free space tree is created when the temporary
> btrfs image is created.
> 
> This behavior itself has no problem at all.
> 
> The problem happens when "-m DUP -d DUP" (or other profiles) is
> specified.
> 
> This makes btrfs to create extra chunks, enlarging free space tree so
> that it can be as high as level 1.
> 
> During mkfs, we rely on recow_roots() to re-CoW all tree blocks to the

Please spell it as COW (not CoW or cow) when it means copy-on-write.
