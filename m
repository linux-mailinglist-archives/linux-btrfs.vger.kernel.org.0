Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7858A90A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 11:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiHEJyP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiHEJyO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 05:54:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDBC24950;
        Fri,  5 Aug 2022 02:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2791B82857;
        Fri,  5 Aug 2022 09:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0ABC433C1;
        Fri,  5 Aug 2022 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659693250;
        bh=Y7bpRxh677nvBHpDr/YdwyVa10B2W0VbLa853su/mTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ke+UyKDoZZ0MZO6c4ecLCwlICMB57BcYFC3UiOS80uxKrx9RrvWrZUHK0CqL+3KfO
         6NYDwNauYXcJqgPZ6JMoyivFM2fMzwj/IQvTyyJxf2C6tv7PVjNxgrdISefDBqbI9B
         OAmv9LSu/fJLctsFf940FFUf5EaX4iDdHOJFhcWkuFh2vJkAwotGWhsw2v5coyb+5e
         eJgz3uB/gWB3h+iibeb8kTR8DVh0OwQM+JVKfdMCB1ABvoU2VCn8ZY4cvzC4R+6orP
         N5ql+D5UE3l53WC+W+PZIaUHv5ljhr+VDeZfZmyiHnwz4xBFOsuOiqWn5kdhFn2Qag
         wq9FxsPHdLzsw==
Date:   Fri, 5 Aug 2022 10:54:07 +0100
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
Message-ID: <20220805095407.GA1876904@falcondesktop>
References: <YuwUw2JLKtIa9X+S@localhost.localdomain>
 <21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com>
 <YuzI7Tqi3n+d+V+P@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuzI7Tqi3n+d+V+P@atmark-techno.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 05, 2022 at 04:38:21PM +0900, Dominique MARTINET wrote:
> Pavel Tikhomirov wrote on Thu, Aug 04, 2022 at 07:30:52PM +0300:
> > I see a similar problem here
> > https://lore.kernel.org/linux-btrfs/Yr4nEoNLkXPKcOBi@atmark-techno.com/#r ,
> > but in my case I have "5.18.6-200.fc36.x86_64" fedora kernel which does not
> > have 5ccc944dce3d ("filemap: Correct the conditions for marking a folio as
> > accessed") commit, so it should be something else.
> 
> The root cause might be different but I guess they're related enough: if
> fiemap gets faster enough even when the whole file is in cache I guess
> that works for me :)
> 
> Josef Bacik wrote on Thu, Aug 04, 2022 at 02:49:39PM -0400:
> > On Thu, Aug 04, 2022 at 07:30:52PM +0300, Pavel Tikhomirov wrote:
> > > I ran the below test on Fedora 36 (the test basically creates "very" sparse
> > > file, with 4k data followed by 4k hole again and again for the specified
> > > length and uses fiemap to count extents in this file) and face the problem
> > > that fiemap hangs for too long (for instance comparing to ext4 version).
> > > Fiemap with 32768 extents takes ~37264 us and with 65536 extents it takes
> > > ~34123954 us, which is x1000 times more when file only increased twice the
> > > size:
> > >
> > 
> > Ah that was helpful, thank you.  I think I've spotted the problem, please give
> > this a whirl to make sure we're seeing the same thing.  Thanks,
> 
> FWIW this patch does help a tiny bit, but I'm still seeing a huge
> slowdown: with patch cp goes from ~600MB/s (55s) to 136MB/s (3m55s) on
> the second run; and without the patch I'm getting 47s and 5m35
> respectively so this has gotten a bit better but these must still be
> cases running through the whole list (e.g. when not hitting a hole?)
> 
> 
> My reproducer is just running 'cp file /dev/null' twice on a file with
> 194955 extents (same file with mixed compressed & non-compressed extents
> as last time), so should be close enough to what Pavel was describing in
> just much worse.

I remember your original report Dominique, it came along with the short
reads issue when using using io_uring with qemu.

I had a quick look before going on vacations. In your post at:

https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/

you mentioned a lot of time spent on count_range_bits(), and I quickly
came with a testing patch for that specific area:

https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/commit/?h=fiemap_speedup&id=6bdc02edbb52786df2d8c2405d790390d9a9443c

Basically whenever we call that, we start searching from the root of the
extent states rbtree - if the rbtree is large, that takes a lot of time.
The idea is to start the search from the last record instead.

I haven't actually made any performance tests, as vacations came in and
I noticed that such change will very likely make little or no difference
because algorithmically btrfs' fiemap implementation is very ineficient
for several reasons. It basically works like this:

1) We start the search for the first extent. First we go search the inode's
   extent map rbtree - if we can't find it, then we will search in the
   fs b+tree - after this we create an extent map based on the file extent
   item we found in the b+tree and add it to the extent map rbtree.

   We then pass to fiemap extent information based on the extent map
   (there's a few extra minor details, like merging, etc);

2) Then we search for the next extent, with a start offset based on the
   end offset of the previous one +1.

   Again, if we can't find it in the extent map rbtree, we go search the
   fs b+tree, then create an extent map based on the file extent item we
   found there and add it to extent map rbtree.

   This is silly. On each iteration the extent maps rbtree gets bigger and
   bigger, and we always search from the root node. We are spending time
   searching there and then allocating memory for the extent map and adding
   it to the rbtree, which is yet more cpu time spent.

   We should only create extent maps when we are doing IO against, for a
   data write or read operation, we are just spending a lot of time on
   this and consuming memory too.

   Then it's silly again because we will search the fs b+tree again, starting
   from the root. So we end up visting the same leaves over and over;

3) Whenever we find a hole, or a prealloc/unwritten extent, we have to check
   if there's pending dealloc for that region. That's where count_range_bits()
   is used - everytime it's called it starts from the root node of the extent
   states rbtree.

My idea to address this is to basically rewrite fiemap so that it works like
this:

1) Go over each leaf in the fs b+tree and for each file extent item emit the
   extent information for fiemap - like this we don't do many repeated b+tree
   searches to end up in the same leaf;

2) Never create extent maps, so that we don't grow the extent maps rbtree
   unnecessarily, saving cpu time and avoiding memory allocations;

3) Whenever we find a hole or prealloc/unwritten extent, then check if there's
   pending delalloc in the range by using count_range_bits() like we currently
   do (and maybe add that patch to avoid always starting the search from the
   root).

   If there's delalloc, then lookup for the correspond extent maps and use
   their info to emit extent information for fiemap. And keep using rb_next()
   while an extent map ends before the hole/unwritten range;

4) Because emitting all the extent information for fiemap and doing other things
   like checking if an extent is shared, calling count_range_bits(), etc can
   take some time, to avoid holding a read lock for too long on the fs b+tree
   leaf and block other tasks, clone the leaf, release the lock on the leaf and
   use the private clone. This is fine since we start fiemap we lock the file
   range, so no one else can go and create or drop extents in the range before
   fiemap finishes.

That's the high level idea.

There's another factor that can slowdown fiemap a lot, which is figuring out if
an extent is shared or not (reflinks, snapshots), but in your case you don't
have shared extents IIRC. I would have to look at that separetely, we probably
have some room for improvement there as well.

I haven't had the time to work on that, as I've been working on other stuff
unrelated to fiemap, but maybe in a week or two I may start it.

> 
> -- 
> Dominique
