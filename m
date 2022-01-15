Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B155B48F98D
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jan 2022 22:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiAOVir (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jan 2022 16:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiAOViq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jan 2022 16:38:46 -0500
Received: from ravenhurst.kallisti.us (ravenhurst-smtp-tx.kallisti.us [IPv6:2600:3c03:e000:2e0::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B75EC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 13:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kallisti.us
        ; s=20220106; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8FBfXJAYvFoj0KTDMXWkKLqUL/98ys8jvA3aXBbgsPg=; b=c7U7XNvkwnnjkIYh7rCZJHbhal
        NZ2BsLHg2xrEv5KGGRjIM5iNOm0wGmh/oME0yIOkSV5zju2Tp6yySbWSxlWDPfKvW5iTLNey0hmZn
        cBf+n2TlL4gHUl/G1xs4xpZ8dsfZwXwyfYEIN2XflMkrC5roTPakBRaufjrgs+FuiSgVzf9gA9Cxm
        /eylRjggzf77UwYAVK/eaDclSsL1pEjyx2TxwSP9ciLjXXkVkI3GawMMYv/rFVQMbXvzURbtyl7bP
        Ykirtxo55fHdjE/5pm7+b+2u0HA46qDZerm+62weh2f93GqGFye6XDTIDEP2DMcXklEh54fWaShPC
        UhQIyM2g==;
Received: from [50.46.16.53] (helo=stgulik)
        by ravenhurst.kallisti.us with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ross@kallisti.us>)
        id 1n8ql2-00FdII-NP
        for linux-btrfs@vger.kernel.org; Sat, 15 Jan 2022 16:38:44 -0500
Date:   Sat, 15 Jan 2022 13:38:40 -0800
From:   Ross Vandegrift <ross@kallisti.us>
To:     linux-btrfs@vger.kernel.org
Subject: Re: unable to remove device due to enospc
Message-ID: <20220115213840.pzwu3y3czh64afrt@stgulik>
References: <20220111072058.2qehmc7qip2mtkr4@stgulik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111072058.2qehmc7qip2mtkr4@stgulik>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 10, 2022 at 11:22:10PM -0800, Ross Vandegrift wrote:
> Hoping someone can help with an enospc issue.  I'm converting a single 8TB fs
> -> 2*10TB raid1.  So far I:
>   1. added the two new devices
>   2. rebalanced single -> raid1
>   3. tried to remove the 8TB device.
> 
> The balance in #2 failed with enospc and left 35G of data in the single
> profile.  The remove in #3 sucessfully moved everything but 35G off.  There is
> 2.5TB unallocated on the new devices:
> 
> Overall:
>     Device size:	          25.34TiB
>     Device allocated:	          13.00TiB
>     Device unallocated:		  12.34TiB
>     Device missing:	             0.00B
>     Used:		          12.94TiB
>     Free (estimated):	           6.21TiB	(min: 6.20TiB)
>     Free (statfs, df):	           5.15TiB
>     Data ratio:	             	      1.99
>     Metadata ratio:	              2.00
>     Global reserve:	         512.00MiB	(used: 0.00B)
>     Multiple profiles:	               yes	(data)
> 
> Data,single: Size:35.00GiB, Used:34.98GiB (99.94%)
>    /dev/mapper/backup	  35.00GiB
> 
> Data,RAID1: Size:6.46TiB, Used:6.44TiB (99.60%)
>    /dev/mapper/backup_a    6.46TiB
>    /dev/mapper/backup_b    6.46TiB
> 
> Metadata,RAID1: Size:19.00GiB, Used:17.71GiB (93.22%)
>    /dev/mapper/backup_a   19.00GiB
>    /dev/mapper/backup_b   19.00GiB
> 
> System,RAID1: Size:32.00MiB, Used:936.00KiB (2.86%)
>    /dev/mapper/backup	  32.00MiB
>    /dev/mapper/backup_a   32.00MiB
> 
> Unallocated:
>    /dev/mapper/backup	   7.24TiB
>    /dev/mapper/backup_a    2.55TiB
>    /dev/mapper/backup_b    2.55TiB

Still having this issue.  Did some more reading, found similar cases.

There's the "when you're not in the 'usual' case" problem from the wiki.
That's me.  It refers to [1].  But I'm not out of space for file writes, only
on balance/dev remove.

There's a reddit thread at [2] where someone has a similar issue at [2].  It
mentions a bug mention in 5.4, but I was on 5.10, and now 5.14.  It also
mentions issues related to balances on both data & metadata.  `btrfs bal start
-dprofiles=single` fails with enospc too.

I tried shrinking /dev/mapper/backup.  Shrinking to 750G worked, but even with
just has 35G of data, trying to shrink to 700G fails with enospc.  

btrfs check passes without errors.

Thanks,
Ross

[1] - https://bugzilla.kernel.org/show_bug.cgi?id=74101
[2] - https://www.reddit.com/r/btrfs/comments/k17v4z/no_space_left_during_rebalance/
