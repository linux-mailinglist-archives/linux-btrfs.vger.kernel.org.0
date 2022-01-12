Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3923048C6CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 16:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244394AbiALPJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 10:09:21 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33132 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354436AbiALPJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 10:09:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C7721F3C7;
        Wed, 12 Jan 2022 15:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642000156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d692RN1IrN9pBt7nMGQ7SLKPcFKscGnkAGxV9Cbq9Ac=;
        b=SArFSuN/+U9SHuDsWYBj56LtHz4qTb1HjMtWNl3wdXDtGE73ZPrqgS1lHgE6k64X7nrIMu
        ZzGlPZ4uUuHXnJn2/H03lcyiYVi7A6YMwI2s1VPstM6ZGlZ0+nfhNxAQk55i0ToLJSvCHj
        0cPmiZfeYprD/ydY7/bROmC4CAvrkk4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61A0513B70;
        Wed, 12 Jan 2022 15:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wyTBFBzv3mHqFwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 12 Jan 2022 15:09:16 +0000
Subject: Re: [PATCH v2 00/11] btrfs: extent tree v2, support for global roots
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1639600719.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <6ac1b7c7-b775-a48e-f84b-9feced206b77@suse.com>
Date:   Wed, 12 Jan 2022 17:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.12.21 г. 22:39, Josef Bacik wrote:
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
> 
>  fs/btrfs/block-group.c          |  25 ++++-
>  fs/btrfs/block-group.h          |   1 +
>  fs/btrfs/ctree.h                |  46 ++++++++-
>  fs/btrfs/disk-io.c              | 178 +++++++++++++++++++++++---------
>  fs/btrfs/disk-io.h              |   2 +
>  fs/btrfs/free-space-tree.c      |   2 +
>  fs/btrfs/inode.c                |  11 +-
>  fs/btrfs/ioctl.c                |  29 ++++++
>  fs/btrfs/print-tree.c           |   1 +
>  fs/btrfs/qgroup.c               |   6 ++
>  fs/btrfs/super.c                |  20 ++++
>  fs/btrfs/sysfs.c                |   5 +-
>  fs/btrfs/transaction.c          |  15 +++
>  fs/btrfs/tree-checker.c         |  35 ++++++-
>  fs/btrfs/volumes.c              |  11 ++
>  include/trace/events/btrfs.h    |   1 +
>  include/uapi/linux/btrfs.h      |   1 +
>  include/uapi/linux/btrfs_tree.h |   3 +
>  18 files changed, 333 insertions(+), 59 deletions(-)
> 

Overall this is a low-risk series and generally looks LGTM. I have a
couple of points which apply too all patches and I'm gonna list them here:

1. This is minor but might be a bit more informative - instead of
returning -EINVAL when an operation which is forbidden returning
-EOPNOTSUPP is closer to what is actually meant. ANd not that something
is invalid per-se. This is a minor point given for now this is purely a
developer feature.

2. The extent tree would be in development for quite some time, perhaps
at least 3-4 release if not more, during that time the code will be
sprinkled with the checks for the forbidden ops and even everyone will
be paying the (arguably small cost) of having them in the code. My point
is can't those compatibility checks be also gated behind
CONFIG_BTRFS_DEBUG? Eventually they will be removed but until this time
comes we'll have them in the respective call paths.
