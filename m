Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036D93DA97A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 18:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhG2Qy1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 12:54:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52264 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG2Qy1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 12:54:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 597A92242C
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627577663;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yZ+95lM2st4YGqoQwbO46sU3Ucv1A82jrRRuM6y1jkw=;
        b=f5+6Hyb2JH6YjuDtVJzNt3KvEyknlTXdJ5ozCxZcmO/XTStLvbqR08GM0aqWYSGN61MsWX
        rF5S62vz4Emx5kSGgvtb829+uv0a+QYcs2T4A28vpIB9MOhb/pNcaCxFFGcGwcLiLecqNF
        HZya12I6ut7/sE1Ylb86wl5vWWU/k7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627577663;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yZ+95lM2st4YGqoQwbO46sU3Ucv1A82jrRRuM6y1jkw=;
        b=4twMLJTazC7zZdxrINnpNiph4g8WWUqwPE+exgsfYlCGS5W3ooXmaYl+EcEEilOVADfP7u
        wZHHTThhIPf15MBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 533FDA3B83;
        Thu, 29 Jul 2021 16:54:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BB286DA882; Thu, 29 Jul 2021 18:51:36 +0200 (CEST)
Date:   Thu, 29 Jul 2021 18:51:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] Allocate structures on stack instead of kmalloc()
Message-ID: <20210729165134.GX5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
References: <20210727211731.23394-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727211731.23394-1-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 04:17:24PM -0500, Goldwyn Rodrigues wrote:
> Here are some structs which can be converted to allocation on stack in order
> to save on post-checks on kmalloc() and kfree() each of them.
> 
> Sizes of the structures are also in the commit message in case you feel they
> are too bit to be allocated on stack.

Reducing the potential error failures is good and may slightly increase
performance in case the system is low on memory and allocator would have
to do some work.

We must also try to reduce stack usage, but for the ioctls it should be
safe as it's run from the process context and not from a deep call
chain. Where it could be a problem, if the call chaing becomes deep
under btrfs, ie. in any other intermediate layer like NFS, DM, block
layer and drivers.

So, I'd limit the size of on-stack variables to something like 128, that
accounts for a few nested function calls with a few varaibles (eg. 4
functions with 4 pointers each).. This is a normal pattern anywhere
else.

> There are two more structs in ioctl.c which can be converted, but
> I was not sure of them:
> 
> 1. In create_snapshot(), pending_snapshot can be converted. pending_snapshot
>    is used in the transaction.

That one is 144 bytes, arguably still ok.

> 2. In btrfs_ioctl_set_received_subvol_32, args64 can be converted, but args32
>    cannot. All Pointers associated with memdup_user() can also be converted
>    by using copy_from_user() instead. This would include many more structs.

size of btrfs_ioctl_received_subvol_args_32 is 192,
and btrfs_ioctl_received_subvol_args is 200 bytes, both in the same
function.

I'd leave this one as is, it's not something critical where performance
matters.

So, overall I'll apply the series without the two commented.
