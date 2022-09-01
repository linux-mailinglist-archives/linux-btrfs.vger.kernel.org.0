Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993185A98CF
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiIAN3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 09:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiIAN2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 09:28:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201AC255B5;
        Thu,  1 Sep 2022 06:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1D3B61F31;
        Thu,  1 Sep 2022 13:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8C3C433D6;
        Thu,  1 Sep 2022 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662038715;
        bh=o+gESKCyp6BOzssE5SHXNurnulPGnj+RGy7w7QkJKFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrF2e3bx8FDObSD6wo56HL5lR4sq3nnC2cehNuPyxupCAsCuM0fOxENu5hInLes+L
         bQ2oYym/0noccCZQSVhzX2uWw/wGolUeooVWmG5WsD32wS1JF7sbFshjzOhmMBbTLR
         eaRVAQHIofaCFGXclMk9YGqqfmif4ptylC9TDNOudnDKMCThGKWppnhnd0LXFEq4x0
         PFWe4VasZhP/jaQea/MTqQkXMbKrNzM6JkZ6sWPeUWuaFtIzy9GlMxE8oq0LIs6vQH
         0vCzsSTcCc3Sx7Ysmx0U3JrWDhvgqdyyl+b9xzhS3QLGldj0xCYaX6Ku/ZVcQvA6LN
         QISBm/x9MQIcg==
Date:   Thu, 1 Sep 2022 14:25:12 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Chen Liang-Chun <featherclc@gmail.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        kernel@openvz.org, Yu Kuai <yukuai3@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: fiemap is slow on btrfs on files with multiple extents
Message-ID: <20220901132512.GA3946576@falcondesktop>
References: <YuwUw2JLKtIa9X+S@localhost.localdomain>
 <21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com>
 <YuzI7Tqi3n+d+V+P@atmark-techno.com>
 <20220805095407.GA1876904@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805095407.GA1876904@falcondesktop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 05, 2022 at 10:54:07AM +0100, Filipe Manana wrote:
> On Fri, Aug 05, 2022 at 04:38:21PM +0900, Dominique MARTINET wrote:
> > Pavel Tikhomirov wrote on Thu, Aug 04, 2022 at 07:30:52PM +0300:
> > > I see a similar problem here
> > > https://lore.kernel.org/linux-btrfs/Yr4nEoNLkXPKcOBi@atmark-techno.com/#r ,
> > > but in my case I have "5.18.6-200.fc36.x86_64" fedora kernel which does not
> > > have 5ccc944dce3d ("filemap: Correct the conditions for marking a folio as
> > > accessed") commit, so it should be something else.
> > 
> > The root cause might be different but I guess they're related enough: if
> > fiemap gets faster enough even when the whole file is in cache I guess
> > that works for me :)
> > 
> > Josef Bacik wrote on Thu, Aug 04, 2022 at 02:49:39PM -0400:
> > > On Thu, Aug 04, 2022 at 07:30:52PM +0300, Pavel Tikhomirov wrote:
> > > > I ran the below test on Fedora 36 (the test basically creates "very" sparse
> > > > file, with 4k data followed by 4k hole again and again for the specified
> > > > length and uses fiemap to count extents in this file) and face the problem
> > > > that fiemap hangs for too long (for instance comparing to ext4 version).
> > > > Fiemap with 32768 extents takes ~37264 us and with 65536 extents it takes
> > > > ~34123954 us, which is x1000 times more when file only increased twice the
> > > > size:
> > > >
> > > 
> > > Ah that was helpful, thank you.  I think I've spotted the problem, please give
> > > this a whirl to make sure we're seeing the same thing.  Thanks,
> > 
> > FWIW this patch does help a tiny bit, but I'm still seeing a huge
> > slowdown: with patch cp goes from ~600MB/s (55s) to 136MB/s (3m55s) on
> > the second run; and without the patch I'm getting 47s and 5m35
> > respectively so this has gotten a bit better but these must still be
> > cases running through the whole list (e.g. when not hitting a hole?)
> > 
> > 
> > My reproducer is just running 'cp file /dev/null' twice on a file with
> > 194955 extents (same file with mixed compressed & non-compressed extents
> > as last time), so should be close enough to what Pavel was describing in
> > just much worse.
> 
> I remember your original report Dominique, it came along with the short
> reads issue when using using io_uring with qemu.
> 
> I had a quick look before going on vacations. In your post at:
> 
> https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
> 
> you mentioned a lot of time spent on count_range_bits(), and I quickly
> came with a testing patch for that specific area:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/commit/?h=fiemap_speedup&id=6bdc02edbb52786df2d8c2405d790390d9a9443c
> 
> Basically whenever we call that, we start searching from the root of the
> extent states rbtree - if the rbtree is large, that takes a lot of time.
> The idea is to start the search from the last record instead.
> 
> I haven't actually made any performance tests, as vacations came in and
> I noticed that such change will very likely make little or no difference
> because algorithmically btrfs' fiemap implementation is very ineficient
> for several reasons. It basically works like this:
> 
> 1) We start the search for the first extent. First we go search the inode's
>    extent map rbtree - if we can't find it, then we will search in the
>    fs b+tree - after this we create an extent map based on the file extent
>    item we found in the b+tree and add it to the extent map rbtree.
> 
>    We then pass to fiemap extent information based on the extent map
>    (there's a few extra minor details, like merging, etc);
> 
> 2) Then we search for the next extent, with a start offset based on the
>    end offset of the previous one +1.
> 
>    Again, if we can't find it in the extent map rbtree, we go search the
>    fs b+tree, then create an extent map based on the file extent item we
>    found there and add it to extent map rbtree.
> 
>    This is silly. On each iteration the extent maps rbtree gets bigger and
>    bigger, and we always search from the root node. We are spending time
>    searching there and then allocating memory for the extent map and adding
>    it to the rbtree, which is yet more cpu time spent.
> 
>    We should only create extent maps when we are doing IO against, for a
>    data write or read operation, we are just spending a lot of time on
>    this and consuming memory too.
> 
>    Then it's silly again because we will search the fs b+tree again, starting
>    from the root. So we end up visting the same leaves over and over;
> 
> 3) Whenever we find a hole, or a prealloc/unwritten extent, we have to check
>    if there's pending dealloc for that region. That's where count_range_bits()
>    is used - everytime it's called it starts from the root node of the extent
>    states rbtree.
> 
> My idea to address this is to basically rewrite fiemap so that it works like
> this:
> 
> 1) Go over each leaf in the fs b+tree and for each file extent item emit the
>    extent information for fiemap - like this we don't do many repeated b+tree
>    searches to end up in the same leaf;
> 
> 2) Never create extent maps, so that we don't grow the extent maps rbtree
>    unnecessarily, saving cpu time and avoiding memory allocations;
> 
> 3) Whenever we find a hole or prealloc/unwritten extent, then check if there's
>    pending delalloc in the range by using count_range_bits() like we currently
>    do (and maybe add that patch to avoid always starting the search from the
>    root).
> 
>    If there's delalloc, then lookup for the correspond extent maps and use
>    their info to emit extent information for fiemap. And keep using rb_next()
>    while an extent map ends before the hole/unwritten range;
> 
> 4) Because emitting all the extent information for fiemap and doing other things
>    like checking if an extent is shared, calling count_range_bits(), etc can
>    take some time, to avoid holding a read lock for too long on the fs b+tree
>    leaf and block other tasks, clone the leaf, release the lock on the leaf and
>    use the private clone. This is fine since we start fiemap we lock the file
>    range, so no one else can go and create or drop extents in the range before
>    fiemap finishes.
> 
> That's the high level idea.
> 
> There's another factor that can slowdown fiemap a lot, which is figuring out if
> an extent is shared or not (reflinks, snapshots), but in your case you don't
> have shared extents IIRC. I would have to look at that separetely, we probably
> have some room for improvement there as well.
> 
> I haven't had the time to work on that, as I've been working on other stuff
> unrelated to fiemap, but maybe in a week or two I may start it.

It took me a bit more than I expected, but here is the patchset to make fiemap
(and lseek) much more efficient on btrfs:

https://lore.kernel.org/linux-btrfs/cover.1662022922.git.fdmanana@suse.com/

And also available in this git branch:

https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=lseek_fiemap_scalability

Running Pavel's test before applying the patchset:

    *********** 256M ***********

    size: 268435456
    actual size: 134217728
    fiemap: fm_mapped_extents = 32768
    time = 4003133 us

    size: 268435456
    actual size: 134217728
    fiemap: fm_mapped_extents = 32768
    time = 4895330 us

    *********** 512M ***********

    size: 536870912
    actual size: 268435456
    fiemap: fm_mapped_extents = 65536
    time = 30123675 us

    size: 536870912
    actual size: 268435456
    fiemap: fm_mapped_extents = 65536
    time = 33450934 us

    *********** 1G ***********

    size: 1073741824
    actual size: 536870912
    fiemap: fm_mapped_extents = 131072
    time = 224924074 us

    size: 1073741824
    actual size: 536870912
    fiemap: fm_mapped_extents = 131072
    time = 217239242 us

And running it after applying the patchset:

    *********** 256M ***********

    size: 268435456
    actual size: 134217728
    fiemap: fm_mapped_extents = 32768
    time = 29475 us

    size: 268435456
    actual size: 134217728
    fiemap: fm_mapped_extents = 32768
    time = 29307 us

    *********** 512M ***********

    size: 536870912
    actual size: 268435456
    fiemap: fm_mapped_extents = 65536
    time = 58996 us

    size: 536870912
    actual size: 268435456
    fiemap: fm_mapped_extents = 65536
    time = 59115 us

    *********** 1G ***********

    size: 1073741824
    actual size: 536870912
    fiemap: fm_mapped_extents = 116251
    time = 124141 us

    size: 1073741824
    actual size: 536870912
    fiemap: fm_mapped_extents = 131072
    time = 119387 us

There's a huge difference, so after it fiemap is a lot more usable on
btrfs.

It's still not as fast as ext4, but it's getting close to. On ext4 I
get:

    *********** 256M ***********

    size: 268435456
    actual size: 134217728
    fiemap: fm_mapped_extents = 32768
    time = 16877 us

    size: 268435456
    actual size: 134217728
    fiemap: fm_mapped_extents = 32768
    time = 17014 us

    *********** 512M ***********

    size: 536870912
    actual size: 268435456
    fiemap: fm_mapped_extents = 65536
    time = 33764 us

    size: 536870912
    actual size: 268435456
    fiemap: fm_mapped_extents = 65536
    time = 33849 us

    *********** 1G ***********

    size: 1073741824
    actual size: 536870912
    fiemap: fm_mapped_extents = 131072
    time = 69085 us

    size: 1073741824
    actual size: 536870912
    fiemap: fm_mapped_extents = 131072
    time = 68101 us

However we do have extra work to do on btrfs because we have reflinks
and snapshots, so it needs to check if extents are shared, while ext4
does not have those features, thus less work to do for fiemap.

Thanks for the report.

> 
> > 
> > -- 
> > Dominique
