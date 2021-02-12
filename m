Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B6A31A3F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Feb 2021 18:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhBLRpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Feb 2021 12:45:04 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54533 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231796AbhBLRog (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Feb 2021 12:44:36 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 78E245C019F;
        Fri, 12 Feb 2021 12:43:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 12 Feb 2021 12:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=lxs70DnQ6Bbc1fWR6iewCAq4h9Z
        r6OGK1/RlWKTZbpU=; b=VFUHX/AUxSE0aAik8gIvxYdPLyJPq0H2GAJthFX8muH
        RV17d6dOcrvEoWyLfHhJbDRd9kBMY4IjOt4lU8O1M5/SLy+Ni9UEwnfNPQVtDHPg
        NRjOC33hqUkDi/p4wxsOkXMVcGB52w8ies0Kj0IrONAkLtbUnFGv3TsOtuQHwlvc
        eaLSiVOXMsqZ+tOtU3kcXI1ZSM8QAfT+CG7NHK2GMBL49oig6dDZbpP9dqx/5a7K
        4+eu3Ryw3ro+ZNt70zrj6UJmmQh8/4z3opvJi32pTcnvg3IhzAtu1aMwdCvIu0ME
        9O3U6icRvYt3kmIeBqHLhNKy/Pynx/uRy+IBTEk32+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lxs70D
        nQ6Bbc1fWR6iewCAq4h9Zr6OGK1/RlWKTZbpU=; b=Xvg219i47Ruq5GmfKLzG7/
        KqLSjN6y4LfmapTLlHfIPBGryHMpUOIxbV+GpQzfJMFy0Gy1d73a+htGyxzxIZXg
        A7CFF3GKQYz9ZBFRfCYoXhmJ0oIoH15SA8Ylh/8pFtt2Qh25cakbDYU6Fceu6iJ7
        rL9MUV1TkFevSoTFhqeehKxYqL9+YHYjUrULGm+yACfUEnhMeIAEfYntWibnZo3d
        3fOKEpc9/C9pbYq5cLCo7W3pYzYstGAdo+ZTQQciZJQyvnhYVvIYXpo7hXFK3OOX
        4fn/507mWMumpA9nipYj+kfDEfFP4/y7IZgRJmvj9CR/kJ1cdCb8uaSHjQOlmTWA
        ==
X-ME-Sender: <xms:QL4mYNIZqgDIPS2oZn9i2LTt434cBfIZVSIhF9PE4TRvtLj9PwswMA>
    <xme:QL4mYJLGLU3K0I8pzLIyZjiXQNbb9UZ8lpdW9SDwywO86EWdrIBXwbi3mAbl70vEI
    6VJD-e1BcXP5KlD1m8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledriedugddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    dvhffghfetueeggfdtgeduvedugeekgeeuvddvhfdugeduhfetkeevtdeitdegueenucfk
    phepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:QL4mYFsQ3Z7AMwsZvKDPEGxILJATdV2ycs5NsnfGKcQHYNci85rfFQ>
    <xmx:QL4mYOYkmYN-tPCVa1l1pNc7ubAlrVJR6fWs3AEsGx0WfXA62amOiA>
    <xmx:QL4mYEYep1MAwXQv0E_-SkBEUl--lKnJGul2CafeLrPkmYzIL_u6yA>
    <xmx:Qb4mYPymPV-PbprzARa2fsvtp2otFEz-OXkohHIJd32GHJLbwgQwRA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 251031080057;
        Fri, 12 Feb 2021 12:43:28 -0500 (EST)
Date:   Fri, 12 Feb 2021 09:43:25 -0800
From:   Boris Burkov <boris@bur.io>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/5] btrfs: support fsverity
Message-ID: <20210212174325.GA914800@devbig008.ftw2.facebook.com>
References: <cover.1612475783.git.boris@bur.io>
 <YBziIn5FhtekZ7ZP@sol.localdomain>
 <20210205065819.GB2428856@devbig008.ftw2.facebook.com>
 <20210212011944.GG32440@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212011944.GG32440@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 11, 2021 at 08:19:45PM -0500, Zygo Blaxell wrote:
> On Thu, Feb 04, 2021 at 10:58:19PM -0800, Boris Burkov wrote:
> > On Thu, Feb 04, 2021 at 10:13:54PM -0800, Eric Biggers wrote:
> > > On Thu, Feb 04, 2021 at 03:21:36PM -0800, Boris Burkov wrote:
> > > > This patchset provides support for fsverity in btrfs.
> > > 
> > > Very interested to see this!  It generally looks good, but I have some comments.
> > > 
> > > Also, when you send this out next, can you include
> > > linux-fscrypt@vger.kernel.org, as per 'get_maintainer.pl fs/verity/'?
> > > 
> > 
> > Sorry for missing that, definitely will do for v2.
> > 
> > > > At a high level, we store the verity descriptor and Merkle tree data
> > > > in the file system btree with the file's inode as the objectid, and
> > > > direct reads/writes to those items to implement the generic fsverity
> > > > interface required by fs/verity/.
> > > > 
> > > > The first patch is a preparatory patch which adds a notion of
> > > > compat_flags to the btrfs_inode and inode_item in order to allow
> > > > enabling verity on a file without making the file system unmountable for
> > > > older kernels. (It runs afoul of the leaf corruption check otherwise)
> 
> > > In ext4, verity is a ro_compat filesystem feature rather than a compat feature.
> > > That's because we wanted to prevent old kernels from writing to verity files,
> > > which would corrupt them (get them out of sync with their Merkle trees).
> > > 
> > > Are you sure you want to make this a "compat" flag?
> > > 
> > 
> > I wasn't sure, so I'm glad you brought it up. That's a pretty compelling
> > argument for making it ro_comnpat, in my opinion. I was also worried
> > about the old kernel deleting the file and leaking the Merkle items.
> > 
> > On the other hand, it feels a shame to make the whole file system read
> > only over "just one file".
> 
> Read only over "just one file" isn't new in btrfs.  More shameful things
> have already been implemented.  ;)
> 
> Any random user can run 'setfattr -n btrfs.compression -v zstd .' and
> flip the COMPRESS_ZSTD incompat bit on the filesystem.  After that,
> the filesystem can't be mounted on kernel 4.13 or earlier ever again,
> not even ro.  Same thing with LZO on earlier kernels.  [1]
> 
> > Do you have any good strategies for getting back a file system after
> > creating some verity files but then running a kernel without verity?
> 
> There are a few btrfs incompat bits that can be turned off, but they
> require expunging any incompat metadata from the filesystem, so they are
> only possible as offline (like btrfs check or btrfstune) or mount-time
> changes (like -o space_cache=v2), or as part of operations that can
> iterate over the whole filesystem while online (like balance with convert
> to remove new RAID profiles).  Generally anything that operates on scales
> smaller than a block group (like inodes or extents) can't be turned off.
> 
> > I could write some utilities to list/delete verity files before doing
> > that transition?
> > 
> > > > 
> > > > The second patch is the bulk of the fsverity implementation. It
> > > > implements the fsverity interface and adds verity checks for the typical
> > > > file reading case.
> > > > 
> > > > The third patch cleans up the corner cases in readpage, covering inline
> > > > extents, preallocated extents, and holes.
> > > > 
> > > > The fourth patch handles direct io of a veritied file by falling back to
> > > > buffered io.
> > > > 
> > > > The fifth patch adds a feature file in sysfs for verity.
> > > 
> > > I'm also wondering if you've tested using this in combination with btrfs
> > > compression.  f2fs also supports compression and verity in combination, and
> > > there have been some problems caused by that combination not being properly
> > > tested.  It should just work though.
> > > 
> > 
> > I hadn't tested it with compression yet, but I'll definitely do so,
> > especially since it was a pain point before. Thanks for the tip.
> > 
> > > - Eric
> 
> [1] It could have been possible to avoid using incompat bits for
> compression algorithms:  return ENOTSUPP on reads of data with unknown
> algorithms, fall back to uncompressed on writes, use the raw encoded
> data in send/receive, and even dedupe sometimes, if the encoded data
> and algorithm ID matches.  Balance and scrub already use only the
> encoded form and don't need to decompress to move the data around or
> verify it against csums.  If the filesystem is mounted with a new kernel
> again, then everything the old kernel did to the filesystem would be OK:
> overwrites and deletes would work, old and new data would all be readable.
> Users might be alarmed by getting unexpected read errors on old kernels
> (hence the incompat bit) but technically the filesystem could have been
> mountable.  This is an unusual "wo_compat" bit's use case--writing is
> possible with an old kernel, reading is not.
> 
> Verity doesn't fit this model.  There's no way to fall back to naively not
> updating Merkle trees that is distinguishable from corrupting the data.

Appreciate the context, thanks for taking the time to explain it.

Based on the precedents both in btrfs and for verity on ext4/f2fs,
I'll change the logic to mark an ro_compat bit on the file system
when verity is enabled on a file.
