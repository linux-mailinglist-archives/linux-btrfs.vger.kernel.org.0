Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0873849CF01
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 16:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiAZPza (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 10:55:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiAZPz0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 10:55:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E9BA521110;
        Wed, 26 Jan 2022 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643212525;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRlHzifgmAdWoJS05tIlb2Nv6Q4xuqc50/8K7MkvfuE=;
        b=xghQp7Oioi5WPwh1Fl9quDuDH1CyyDgu2JTowa/xTGJBeeRHNjbUOjfclF2NQxLMvkt+xF
        V+i5OavuSqPykTNWd8CoxkxsU4Rr9p5e/UO/MRd9EKJn6N+rqlBgv9uVUkaqW6j/rtx0hQ
        rlpeIhHYtThk1qX06hE4VVrb9pCKIpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643212525;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRlHzifgmAdWoJS05tIlb2Nv6Q4xuqc50/8K7MkvfuE=;
        b=fUHLDdZZ/y3dMT7IrXBEUOFtc/CH4xPG13hjPgYY6OqRBgoPjKbgaxlhgN1esD/zjuD22V
        BWaCu8NLVPmgZiDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E21F4A3B85;
        Wed, 26 Jan 2022 15:55:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1B432DA7A9; Wed, 26 Jan 2022 16:54:44 +0100 (CET)
Date:   Wed, 26 Jan 2022 16:54:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/11] btrfs: extent tree v2, support for global roots
Message-ID: <20220126155444.GA14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1639600719.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 15, 2021 at 03:39:57PM -0500, Josef Bacik wrote:
> v1->v2:
> - Disabled some more operations for extent tree v2 that I found were problematic
>   in testing.
> - Rebased onto a recent misc-next
> 
> --- Original email ---
> Hello,
> 
> This is the kernel side of the global roots and block group root support.  The
> motivation for this change is described in the progs patches.  The important
> part here is I've disabled qgroups and balance for now, this support will be
> added back later.  I've also changed global block rsv size calculation, but it's
> exactly the same result for !EXTENT_TREE_V2.  And finally there's the support
> for loading the roots.  This doesn't panic and doesn't introduce any performance
> regressions.  I've also hidden the support behind CONFIG_BTRFS_DEBUG so it
> doesn't get used accidentally.  Thanks,
> 
> Josef
> 
> Josef Bacik (11):
>   btrfs: add definition for EXTENT_TREE_V2
>   btrfs: disable balance for extent tree v2 for now
>   btrfs: disable device manipulation ioctl's EXTENT_TREE_V2
>   btrfs: disable qgroups in extent tree v2
>   btrfs: disable scrub for extent-tree-v2
>   btrfs: disable snapshot creation/deletion for extent tree v2
>   btrfs: disable space cache related mount options for extent tree v2
>   btrfs: tree-checker: don't fail on empty extent roots for extent tree
>     v2
>   btrfs: abstract out loading the tree root
>   btrfs: add code to support the block group root
>   btrfs: add support for multiple global roots

Added to misc-next. I did only a few tweaks, some messages updates,
added comments. As this is is going to be a long series I'd like to
suggest do do development and cleanup stages. The development so that
you can drop new functional changes but the cleanup seems to be
necessary as there's a lot of repeated code and otherwise it needs to be
kept at sane level regarding the other code.
