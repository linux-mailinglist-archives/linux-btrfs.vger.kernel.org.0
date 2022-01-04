Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232734845B8
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 17:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiADQBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 11:01:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47632 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiADQBD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 11:01:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 85D2621108;
        Tue,  4 Jan 2022 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641312062;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIMgX3lfonrt5sr3BooXe0uu5YVXZGNFWTVqLtgp6/w=;
        b=phaSq5MYgJhkilTjJJbH5ajFX4DgqQ0fFTXFVRTlERD1Iw7k8xJc1s+lTHtSWhQ3pWrfYP
        LNr0vIR1FokcXRrFT+V0WyCduvNu4J695FhbHSThEHs/bdBom1UcN1AJNwDQjWDlmRhp2n
        eNUap/p0LguKYImqIYHXkJrIWSeEpoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641312062;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIMgX3lfonrt5sr3BooXe0uu5YVXZGNFWTVqLtgp6/w=;
        b=XKCEvk/5dvT5Lk8boT1W0Sjvrw0u7oKcFM7/rXECy8JUVfD09bqYh5uvu7g5l8Cmtql5Ah
        XNwrEEgd5M951yDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6BDEAA3B87;
        Tue,  4 Jan 2022 16:01:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 38AE0DA729; Tue,  4 Jan 2022 17:00:33 +0100 (CET)
Date:   Tue, 4 Jan 2022 17:00:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stijn Tintel <stijn@linux-ipv6.be>
Cc:     linux-btrfs@vger.kernel.org,
        Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: Re: [PATCH] btrfs-progs: include linux/const.h to fix build with
 5.12+ headers
Message-ID: <20220104160033.GU28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stijn Tintel <stijn@linux-ipv6.be>,
        linux-btrfs@vger.kernel.org,
        Bruce Ashfield <bruce.ashfield@gmail.com>
References: <20211230132359.2554027-1-stijn@linux-ipv6.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230132359.2554027-1-stijn@linux-ipv6.be>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 30, 2021 at 03:23:59PM +0200, Stijn Tintel wrote:
> From: Bruce Ashfield <bruce.ashfield@gmail.com>
> 
> btrfs-tools compile fails with mips, musl and 5.12+ headers.
> 
> The definition of __ALIGN_KERNEL has moved in 5.12+ kernels, so we
> add an explicit include of const.h to pickup the macro:
> 
>   | make: *** [Makefile:595: mkfs.btrfs] Error 1
>   | make: *** Waiting for unfinished jobs....
>   | libbtrfs.a(volumes.o): in function `dev_extent_search_start':
>   | /usr/src/debug/btrfs-tools/5.12.1-r0/git/kernel-shared/volumes.c:464: undefined reference to `__ALIGN_KERNEL'
>   | collect2: error: ld returned 1 exit status
> 
> This is safe for older kernel's as well, since the header still
> exists, and is valid to include.
> 
> Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
> [remove invalid OE Upstream-status]
> Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>

Thanks, added to devel.
