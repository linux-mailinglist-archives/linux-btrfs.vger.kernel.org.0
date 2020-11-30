Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9132C9298
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Dec 2020 00:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbgK3Xc4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 18:32:56 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43605 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388510AbgK3Xc4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 18:32:56 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 221475C0036;
        Mon, 30 Nov 2020 18:31:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 30 Nov 2020 18:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm2; bh=YwpqwQBtzNTbCvuUB6knReZ71mkva0wtAQBDz73B
        iT0=; b=ThULZl3JvyB5nV74+5CrJYNKSM3gRmWA3E85k9OnWyH3Uh67sSfzFx5A
        j8rue7+JhE34QBxpA5i1QAvhoMA1pUcCe7Qj/H11MbcDA8COkMcxiUMA3DFxi9+6
        lQO7QEQGJmURS9JNSaaCwm4XgulccPIEfF/3ZOzTtXXyVrWr5XD7VI+K2R/hMXk0
        HBZqxiteDAZoenjFAcUoDcKKAfwtdoPosM8+6wW8x1pTCGUM1RiBj0XVF9+5R1f7
        jYdzZumsDgOqZjMMe+5yRaaDjUFlqbDwP+pyuCqunmaPKhWNRbm3ADIBrtgS8HKf
        CMj/4wVBEoAF/vYe0e9gD3XFWFv8Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YwpqwQ
        BtzNTbCvuUB6knReZ71mkva0wtAQBDz73BiT0=; b=Vi1Y66mKEfK9r+VxuICgGR
        xO0f6fHJ46q34vlalumcqKofrwi0WMOh38txLsv3fY6uaKrqm/QyjIGzQD2GopZS
        /2QFxJnuBW1g5/jJaGnk+WQpKPebGtCUXSf3e0EbRJVrW7kH8qTv+55REUeIyrdA
        v4D1y7NvdFcgcZ/YwoYE2bZxtAxHu9IsBvMUl/8rBVY9w55KPnt/Eajzzq4czRv/
        p/yFqNj8mX+zToE90H2vOl7R3HFjoB1Ry4oomg2I49WP8kkAD/vCA3T5A8IR7wYc
        y3GlE40ieZYB2RpHRam1eyP0UZXIjlXrxYZMo8hp4WOZ1PaNGLVyOB6Nc19Y5znA
        ==
X-ME-Sender: <xms:5YDFX-UneyKs710mIFiL6esfuZ7T17NBhXqlm9acvk7Gg22CJhnlbg>
    <xme:5YDFX6nWWfnQplZUM2XEK73HQkhK-5ezFgmG0_FWwElP71m0soyawXeoBxLDcD4M9
    MPvtMr4YdhuBVq3YcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeiuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepvdfhgffhteeugefgtdegudevudegkeeguedvvd
    fhudegudfhteekvedtiedtgeeunecukfhppeduieefrdduudegrddufedvrdefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:5YDFXyaUSEsu8s3Atf1ydz456xnLu1fQ7ezByAJT7a36toOnonajiw>
    <xmx:5YDFX1Wk7A4fcxXgqtEq-bKRQKk_bseYG36cvsvafzISJrKt01hAXQ>
    <xmx:5YDFX4kaBmfAAKi6Lsq4CVsS5zs89oocK0sUZ3PtgxytUEG3Iy1s2w>
    <xmx:5oDFX_vPKfQU3oPuHY8oGwyi_ZYoM0yU1tvIlsuEOq943Uwywl4Byg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3AD063064AAA;
        Mon, 30 Nov 2020 18:31:49 -0500 (EST)
Date:   Mon, 30 Nov 2020 15:31:42 -0800
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 01/12] btrfs: lift rw mount setup from mount and
 remount
Message-ID: <20201130233142.GA3661143@devbig008.ftw2.facebook.com>
References: <cover.1605736355.git.boris@bur.io>
 <ac259f3ceafae5a8bb9b6c554375588705aa55b2.1605736355.git.boris@bur.io>
 <20201123165040.GF8669@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123165040.GF8669@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 23, 2020 at 05:50:40PM +0100, David Sterba wrote:
> On Wed, Nov 18, 2020 at 03:06:16PM -0800, Boris Burkov wrote:
> > Mounting rw and remounting from ro to rw naturally share invariants and
> > functionality which result in a correctly setup rw filesystem. Luckily,
> > there is even a strong unity in the code which implements them. In
> > mount's open_ctree, these operations mostly happen after an early return
> > for ro file systems, and in remount, they happen in a section devoted to
> > remounting ro->rw, after some remount specific validation passes.
> > 
> > However, there are unfortunately a few differences. There are small
> > deviations in the order of some of the operations, remount does not
> > cleanup orphan inodes in root_tree or fs_tree, remount does not create
> > the free space tree, and remount does not handle "one-shot" mount
> > options like clear_cache and uuid tree rescan.
> > 
> > Since we want to add building the free space tree to remount, and since
> > it is possible to leak orphans on a filesystem mounted as ro then
> > remounted rw
> 
> The statement is not specific if the orphans are files or roots. But I
> don't agree that a leak is possible, or need a proof of the claim above.
> 
> The mount-time orphan cleanup will start early, but otherwise orphan
> cleanup is checked and started on dentry lookups (btrfs_lookup_dentry).
> Deleted but not clened tree roorts are all found and removed, regardless
> of rw or ro->rw mount.
> 
> So I wonder if you claim there's a leak just by lack of an explicit call
> on the remount path.

For what it's worth, the example I had in mind is the free space inode
orphans after a block_group delete or the new "clear v1 space cache"
code in this stack.

I hadn't considered btrfs_lookup_dentry because I was focused on those
specific inodes, but it's possible that gets called in a way that would
clean them too.

However, another thing I think I overlooked is that it doesn't look
like remount would affect the set of delayed_iputs, so that mechanism for
removing the orphans should still work. Further, the new function only
runs when going from ro->rw, but any ro mount would run delayed iputs
before completing as part of btrfs_commit_super.

So with all that, I agree with you that there isn't a leak. Going
forward with this, I can certainly fix the commit messages, or even get
rid of the patch that does the orphan cleanup in remount. I can't think
of a reason that the cleanup would be bad, but on the other hand, just
"unity" is a flimsy justification for adding it. Let me know what you
prefer.

Thanks for the review,
Boris
