Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D233F506A
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 20:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhHWSfI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 14:35:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48526 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHWSfI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 14:35:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C2D682204E;
        Mon, 23 Aug 2021 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629743664;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CTNSMoPQ1ZBNPS/mHBXR19RYpvs/XfuaCBrnFMumBw0=;
        b=d8qv6L0Lqw/BhUqxqekYuXeLFZj0ncvne9MHqXuoaR3pA1FRqVnrpCDr4bxWPoCR0RJ/3h
        0Q8tdRK18QLRtJvXc95o2YLqvYRMeVvMOJynSgds6WPBexlgvxAh6fZmRbY44JXWbAYPhX
        Cud7L9S1eeIT2pd4hFCD9QRcRHuPafQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629743664;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CTNSMoPQ1ZBNPS/mHBXR19RYpvs/XfuaCBrnFMumBw0=;
        b=cYpuP0F6QHdTEzYNYgWLQ9xQavGESjk9EwPD46EgsAOzi2n+FL+3SvVGtL2MBfXIiYLqah
        jsA5KjD83OKFroAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BB2A7A3BBB;
        Mon, 23 Aug 2021 18:34:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A67ADDA725; Mon, 23 Aug 2021 20:31:24 +0200 (CEST)
Date:   Mon, 23 Aug 2021 20:31:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/12] btrfs-progs: make check handle invalid bg items
Message-ID: <20210823183123.GN5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629322156.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 05:33:12PM -0400, Josef Bacik wrote:
> v1->v2:
> - Discovered that we also don't check bytes_super in the superblock, add that
>   checking and repair ability since it's coupled with the block group used
>   repair.
> - Discovered that we haven't actually been setting --mode=lowmem for the initial
>   image check if we do make test-check-lowmem, we only do it after the repair.
>   Fixed this.
> - Now that we're properly testing error detection in all of the test cases, I
>   found 3 problems with the --mode=lowmem mode, one infinite loop and two places
>   we weren't properly propagating the error code up to the user.
> - My super repair thing tripped a case where we wouldn't clean up properly for
>   unaligned extent records, fixed this as well.
> - Add another test image for the corrupted super bytes.
> - Realize that you need a special .lowmem_repairable file in order for the
>   lowmem repair code to run against images, so did that for both testcases.
> 
> --- Original email ---
> Hello,
> 
> While writing code for extent tree v2 I noticed that I was generating a fs with
> an invalid block group ->used value.  However fsck wasn't catching this, because
> we don't actuall check the used value of the block group items in normal mode.
> lowmem mode does this properly thankfully, so this only needs to be added to the
> normal fsck mode.
> 
> I've added code to btrfs-corrupt-block to generate the corrupt image I need for
> the test case.  Then of course the actual patch to detect and fix the problem.
> Thanks,
> 
> Josef
> 
> Josef Bacik (12):
>   btrfs-progs: fix running lowmem check tests
>   btrfs-progs: do not infinite loop on corrupt keys with lowmem mode
>   btrfs-progs: propagate fs root errors in lowmem mode
>   btrfs-progs: propagate extent item errors in lowmem mode
>   btrfs-progs: do not double add unaligned extent records
>   btrfs-progs: add the ability to corrupt block group items
>   btrfs-progs: add the ability to corrupt fields of the super block
>   btrfs-progs: make check detect and fix invalid used for block groups
>   btrfs-progs: make check detect and fix problems with super_bytes_used
>   btrfs-progs: check btrfs_super_used in lowmem check
>   btrfs-progs: add a test image with a corrupt block group item
>   btrfs-progs: add a test image with an invalid super bytes_used

There are some comments or question so I haven't merged the patches yet
(not merged: 2, 5, 8, 9, 11, 12). Please have a look, rebase on top of
devel should cleanly drop the merged patches from the series.
