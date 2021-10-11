Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83679428AC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhJKKdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:33:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33716 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbhJKKdm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:33:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7E34B21F22;
        Mon, 11 Oct 2021 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633948300;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/WFV38sNJRLakG0Zp+Ydmc4y8TRHX3jculxvzbBCaQ=;
        b=ut/IaNLorPKOOQB6mmwJSXdEwx/qh4E03PG1CFWBWsKdR9yilxQUrt83lygR5CJcigBVOx
        CyQX8YmYL/cLvfPY8iEwxNifXStONFfi0HEIH67Yi/brZalUKtEhtvRW7WV2oS8HhBvRGJ
        e7V9CVjThEPKDVqBQIJYUi9SkoySwXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633948300;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/WFV38sNJRLakG0Zp+Ydmc4y8TRHX3jculxvzbBCaQ=;
        b=GJX87CNnfFmAxYh2XRGOrLOfHSdRv8u4xPfZuMC75o+uE/bwe+Ov5bCAHO2ZpaRNiUF1l5
        OJevEacX7rtPjOAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 77D6BA3B87;
        Mon, 11 Oct 2021 10:31:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 956A0DA735; Mon, 11 Oct 2021 12:31:17 +0200 (CEST)
Date:   Mon, 11 Oct 2021 12:31:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: mkfs: make sure we can clean up all
 temporary chunks
Message-ID: <20211011103117.GE9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011094300.97504-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011094300.97504-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 05:42:57PM +0800, Qu Wenruo wrote:
> There is a bug report that with certain mkfs options, mkfs.btrfs may
> fail to cleanup some temporary chunks, leading to "btrfs filesystem df"
> warning about multiple profiles:
> 
>   WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
>   WARNING:   Metadata: single, raid1 
> 
> The easiest way to reproduce is "mkfs.btrfs -f -R free-space-tree -m dup
> -d dup".

Running with -R free-space-tree has revealed several bugs already, it's
going to be default in 5.15 so hopefully we'll catch them all.

> It turns out that, the old _recow_root() can not handle tree levels > 0,
> while with newer free space tree creation timing, the free space tree
> can reach level 1 or higher.
> 
> To fix the problem, Patch 2 will do the proper full tree re-CoW, with
> extra transaction commitment to make sure all free space tree get
> re-CoWed.
> 
> The 3rd patch will do the extra verification during mkfs-tests.
> 
> The first patch is just to fix a confusing parameter which also caused
> u64 -> int width reduction and can be problematic in the future.
> 
> Qu Wenruo (3):
>   btrfs-progs: rename @data parameter to @profile in extent allocation
>     path
>   btrfs-progs: mkfs: recow all tree blocks properly
>   btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans up temporary
>     chunks

Thanks, added to devel.
