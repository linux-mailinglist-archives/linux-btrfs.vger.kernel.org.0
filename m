Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB6C310549
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 07:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhBEG7J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 01:59:09 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47669 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230525AbhBEG7I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 01:59:08 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A6925C017D;
        Fri,  5 Feb 2021 01:58:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 Feb 2021 01:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=1QFQ4r2IEzqwUNfZ7z0OEstKT2u
        PxCUG/ZcEkPuTpSQ=; b=GXVcDuRpxdefCBfTaSC7uYdBPxyw7Z3Znj4Srnqamy7
        fAdNX2JOAzuXDEzr9Tv16Bs2nlOwUXed7vs6c0Twfv5Ok+ELDBRgI5nzcO5deaPT
        2wbKiETzrCasDmMGI7DrQHkLvJlxanCGeAnW8cThTdpBA9sgW27g1/TvPItLx9oR
        GEBL3iZp0V0FqUVn9+TGVyEVU+NBGOu3EWZbx76cZJwAB4D0mZ9AGaXimc/X4Bpi
        gW9hWxThK6RMyROFIuK4mpJbMXTABTe6v1Q8sbYXEJV4LgvQbhJLM0NeZnPBR9Z3
        NaILLf5Jby5T2p0XHj9vkfMrhm1K5+vvcI8/GaWonuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1QFQ4r
        2IEzqwUNfZ7z0OEstKT2uPxCUG/ZcEkPuTpSQ=; b=MV7UxJjuLetZyQR8d1eqoN
        IGrgYqGsgMKIzUt4Tk4pp0tK8InsPCzQr6jYle6w/oFJRstpvkyoUzOAtfYSaRTB
        16UFlt9ph46+kuOTSlMz4HMM03sw46FezDGMWyFOTNdis7rp+vJs02FYYTt1A7bh
        qcrya+fyQDLMfXP76rzW+sLSG7yDhoW/9CHPh6Dq6zU8XT6jx4ObjxBMyhesQy8N
        T2yEmWH1G+5mwS9zrKxfXaz8/zvZvu+0dW4dyKdHjPtvgThL+D/RZicm4Cmlg+lM
        VQXsF2zNIONaIXNHhPmpQKHcGx5nUQTsIDaDHpfEoILmDz7e3zTxIyYwi6ivu16Q
        ==
X-ME-Sender: <xms:juwcYGDIRmpnHC5bskHpmT96TPzvgLHxGd5Gm2HAm1YOzXJla8lIXw>
    <xme:juwcYAitnxhGKV93QFb1Qoz3duyGAlTyfLzFd4x7ZoyVZ1v9mdSdLfe1tupiB3TY8
    fZPVVHjns9kQetvSik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeehgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    dvhffghfetueeggfdtgeduvedugeekgeeuvddvhfdugeduhfetkeevtdeitdegueenucfk
    phepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:juwcYJk0MlyiBYMaip1luOnuEpq7kV6kF1FNOdHIT0jKq4ZGvGiXkw>
    <xmx:juwcYExHkcz1Oy7BuqH54Tek7T2DuFGcmyD8KSiQb8FZm-lDOEon1A>
    <xmx:juwcYLRnPX6GZaNNLhHCOXe-2GiO03mMoiSXd0Z8hHjRCpDXp4FDow>
    <xmx:juwcYM7rjdq3wsl07hGijjmzKk5aRlolyMosqsyP3oyjs-MovCoGAw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF56C240062;
        Fri,  5 Feb 2021 01:58:21 -0500 (EST)
Date:   Thu, 4 Feb 2021 22:58:19 -0800
From:   Boris Burkov <boris@bur.io>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/5] btrfs: support fsverity
Message-ID: <20210205065819.GB2428856@devbig008.ftw2.facebook.com>
References: <cover.1612475783.git.boris@bur.io>
 <YBziIn5FhtekZ7ZP@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBziIn5FhtekZ7ZP@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 04, 2021 at 10:13:54PM -0800, Eric Biggers wrote:
> On Thu, Feb 04, 2021 at 03:21:36PM -0800, Boris Burkov wrote:
> > This patchset provides support for fsverity in btrfs.
> 
> Very interested to see this!  It generally looks good, but I have some comments.
> 
> Also, when you send this out next, can you include
> linux-fscrypt@vger.kernel.org, as per 'get_maintainer.pl fs/verity/'?
> 

Sorry for missing that, definitely will do for v2.

> > At a high level, we store the verity descriptor and Merkle tree data
> > in the file system btree with the file's inode as the objectid, and
> > direct reads/writes to those items to implement the generic fsverity
> > interface required by fs/verity/.
> > 
> > The first patch is a preparatory patch which adds a notion of
> > compat_flags to the btrfs_inode and inode_item in order to allow
> > enabling verity on a file without making the file system unmountable for
> > older kernels. (It runs afoul of the leaf corruption check otherwise)
> 
> In ext4, verity is a ro_compat filesystem feature rather than a compat feature.
> That's because we wanted to prevent old kernels from writing to verity files,
> which would corrupt them (get them out of sync with their Merkle trees).
> 
> Are you sure you want to make this a "compat" flag?
> 

I wasn't sure, so I'm glad you brought it up. That's a pretty compelling
argument for making it ro_comnpat, in my opinion. I was also worried
about the old kernel deleting the file and leaking the Merkle items.

On the other hand, it feels a shame to make the whole file system read
only over "just one file".

Do you have any good strategies for getting back a file system after
creating some verity files but then running a kernel without verity?

I could write some utilities to list/delete verity files before doing
that transition?

> > 
> > The second patch is the bulk of the fsverity implementation. It
> > implements the fsverity interface and adds verity checks for the typical
> > file reading case.
> > 
> > The third patch cleans up the corner cases in readpage, covering inline
> > extents, preallocated extents, and holes.
> > 
> > The fourth patch handles direct io of a veritied file by falling back to
> > buffered io.
> > 
> > The fifth patch adds a feature file in sysfs for verity.
> 
> I'm also wondering if you've tested using this in combination with btrfs
> compression.  f2fs also supports compression and verity in combination, and
> there have been some problems caused by that combination not being properly
> tested.  It should just work though.
> 

I hadn't tested it with compression yet, but I'll definitely do so,
especially since it was a pain point before. Thanks for the tip.

> - Eric
