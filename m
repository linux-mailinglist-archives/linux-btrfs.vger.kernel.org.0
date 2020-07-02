Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8336E2127F6
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgGBPfE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbgGBPfD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 11:35:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E45C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 08:35:03 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id j10so21534978qtq.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RvK4tqFxhoxKRO0f6HpL/4BY2LRgeVLCj7UeuhhyOZw=;
        b=BHidX+B8RPra04QRaUb3uVPO77/Qz37G8fNaPlvZQz7tK7G+wMAbY1l0vUVlAC2+EC
         jKmUx/M0Jm8wotXeJaN8neApR2kVyYz36FqpefIkpSAxzmCHbcw7ZlxcJ6H/8O8DTetn
         UnOjXs/QRCwbo061BTMI9R1AaDmA0PS1yyMux2p4wV7ds0nt6KP3tCG6pY652Yvu9HRh
         zsU9iLwRK37/OF9nFElBuyS/b4Wt4kGPjLi5PnCDC7B//6zsPY+OQU9rMjiR7YtYib0i
         Nx2bZbN52POSBKkSYKx4T10vAfqf8PdzcCrhouPIyKAP1vbA7AA8sQCf2C7Fa3MRkmgt
         UaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RvK4tqFxhoxKRO0f6HpL/4BY2LRgeVLCj7UeuhhyOZw=;
        b=B5+kV3ulzAovJ9UvhDcs7iY2acvx93FqHUk/KXxmI214HftbeH+71K/MH7B7iz/5fF
         VHl9WTp1mJ1lW4SDT7XKZaIoeng4S6mHb6oWXjNgm/pgeLtoPjJCgRDx0uNeUgGJd3BA
         qfDaFx82ff0Np324A4PN/HLjbdJXljy9s1Q1M5QnCUbrAVhZjEmceDJdQfjs7f6dmYHK
         nlcn3TJXGajf4cU1+gAEenDthcVngbqqPAiuBQHcBK7eh+I9CA5/pN2WYGO81sCWewar
         jj3aR9kpjgkz0zfLUqedVf8L0oWkFeIrh6P7EJvhOlJ39ywWilc5e2kvEaDERuxyZEKy
         Ywhw==
X-Gm-Message-State: AOAM532RjXiqxBIN7PmR57fyNxZYlpS38n8gW+vvLiNotoij6Rh89yB9
        vQ6yd/W9GRuRASF9/xVmQeM3lQ==
X-Google-Smtp-Source: ABdhPJwbWMoOYy76bFVfefuBHYh2PDlvXDX0uDOUns8dNBixLMpnVEXwTYD369OyEE5deQpud4NRDg==
X-Received: by 2002:ac8:27c9:: with SMTP id x9mr11929898qtx.172.1593704102519;
        Thu, 02 Jul 2020 08:35:02 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n64sm8440015qke.77.2020.07.02.08.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 08:35:01 -0700 (PDT)
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     waxhead@dirtcellar.net, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
 <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
 <20200702033016.GA10769@hungrycats.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <de43532c-10eb-4d4b-da6c-1110666d3a08@toxicpanda.com>
Date:   Thu, 2 Jul 2020 11:35:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702033016.GA10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/1/20 11:30 PM, Zygo Blaxell wrote:
> On Wed, Jul 01, 2020 at 03:53:40PM -0400, Josef Bacik wrote:
>> On 7/1/20 3:43 PM, waxhead wrote:
>>>
>>>
>>> Josef Bacik wrote:
>>>> One of the things that came up consistently in talking with Fedora about
>>>> switching to btrfs as default is that btrfs is particularly vulnerable
>>>> to metadata corruption.  If any of the core global roots are corrupted,
>>>> the fs is unmountable and fsck can't usually do anything for you without
>>>> some special options.
>>>>
>>>> Qu addressed this sort of with rescue=skipbg, but that's poorly named as
>>>> what it really does is just allow you to operate without an extent root.
>>>> However there are a lot of other roots, and I'd rather not have to do
>>>>
>>>> mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
>>>>
>>>> Instead take his original idea and modify it so it just works for
>>>> everything.  Turn it into rescue=onlyfs, and then any major root we fail
>>>> to read just gets left empty and we carry on.
>>>>
>>>> Obviously if the fs roots are screwed then the user is in trouble, but
>>>> otherwise this makes it much easier to pull stuff off the disk without
>>>> needing our special rescue tools.  I tested this with my TEST_DEV that
>>>> had a bunch of data on it by corrupting the csum tree and then reading
>>>> files off the disk.
>>>>
>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>> ---
>>>
>>> Just an idea inspired from RAID1c3 and RAID1c3, how about introducing
>>> DUP2 and/or even DUP3 making multiple copies of the metadata to increase
>>> the chance to recover metadata on even a single storage device?
> 
> I don't think extra dup copies are very useful.  The disk firmware
> behavior that breaks 2-copy dup will break 3-copy and 4-copy too.
> 
>> Because this only works on HDD.  On SSD's concurrent writes will often be
>> shunted to the same erase block, and if the whole erase block goes, so do
>> all of your copies.  This is why we default to 'single' for SSD's.
> 
> That's true on higher end SSDs that have "data reduction" feature sets
> (compress and dedupe).  In theory these drives could dedupe metadata
> pages even if they are slightly different, so schemes like labelling the
> two dup copies won't work.  A sufficiently broken flash page will wipe
> out both metadata copies, possibly even if you arrange a delay buffer
> to write both copies several minutes apart.
> 
> On low-end SSD, though, there's not only no dedupe, there's also plenty of
> single-bit (or sector) errors that don't destroy both copies of metadata.
> It's one of the reasons why low-end drives have the write endurance of
> mayflies compared to their high-end counterparts--even with the same
> flash technology underneath, the high-end drives do clever things behind
> the scenes, while the low-end drives just write every sector they're told
> to, and the resulting TBW lifespan is very different.  I've had Kingston
> SSDs recover from several single-sector csum failure events in btrfs
> metadata blocks thanks to dup metadata.  Those would have been 'mkfs &
> start over' events had I used default mkfs options with single metadata.
> 
> Dup metadata should be the default on all single-drive filesystems.
> Single metadata should be reserved for extreme performance/robustness
> tradeoffs, like the nobarrier mount option, where the filesystem is not
> intended to survive a crash.  Dup metadata won't affect write endurance
> or robustness on drives that dedupe writes, but it can save a filesystem
> from destruction on drives that don't.
> 
> I think we might want to look into having some kind of delayed write
> buffer to spread out writes to the same disk over a sufficiently long
> period of time to defeat various firmware bugs.  e.g. I had a filesystem
> killed by WD Black (HDD) firmware when it mishandled a UNC sector and
> dropped the write cache during error handling.  If the two metadata copies
> had been written on either side of the UNC error, the filesystem would
> have survived, but since both metadata copies were destroyed by the
> firmware bug, the filesystem was lost.
> 
>> The one thing I _do_ want to do is make better use of the backup roots.
>> Right now we always free the pinned extents once the transaction commits,
>> which makes the backup roots useless as we're likely to re-use those blocks.
>> With Nikolay's patches we can now async drop pinned extents, which I've
>> implemented here for an unrelated issue.  We could take that work and simply
>> hold pinned extents for several transactions so that old backup roots and
>> all of their nodes don't get over-written until they cycle out.  This would
>> go a long way towards making us more resilient under metadata corruption
>> conditions.  Thanks,
> 
> I have questions about this:  That would probably increase the size
> required for global reserve?  RAM requirements for the pinned list?
> What impact does this have when space is low, e.g. deleting a snapshot
> on a full filesystem?  There are probably answers to these, but it
> might mean spending some time making sure all the ENOSPC cases are
> still recoverable.

There's RAM requirements but they're low, its just a range tree with the bits 
set that need to be unpinned.  We wouldn't have to increase the size required 
for global reserve.

Right now the way we deal with pinned extents is to commit the transaction, 
because once the transaction is committed all pinned extents are unpinned. 
Nikolay made it so we have a per-transaction pinned tree now instead of two that 
we flip flop on.

That enables us to async off the unpinning.  I've been doing that internally 
with WhatsApp because they see a huge amount of latency with unpinning.  My 
version of this still works fine with the transaction part, because we wait for 
the transaction to "complete", which only gets set once the unpin mechanism is 
done.  So although it's asynchronous, we still get the same behavior from an 
enospc perspective.

What I would do for this case is delay 4 transactions worth of pinned extents. 
Once we commit the 5th transaction, we unpin the oldest guy because we no longer 
need him.

But this creates ENOSPC issues, because now we have decoupled the transaction 
commit from the pinned extent thing.  But that's ok, we know where our pinned 
space is now.  So we just add a new flushing state that we start walking through 
the unpin list and unpinning stuff until our reservations are satisfied.

Now this does mean that under a space crunch we're going to not be saving our 
old roots as well because we'll be re-using them, but that's the same situation 
that we have currently.  Most normal users will have plenty of space and thus 
will get the benefit of being able to recovery from the backup roots.  It's not 
a perfect solution, but it's muuuuch better than what we have currently.

> What we really need is a usable fsck (possibly online or an interactive
> tool) that can put a filesystem back together quickly when only a few
> hundred metadata pages are broken.  The vast majority of btrfs filesystems
> I've seen killed were due btrfs and Linux kernel bugs, e.g. that delayed
> reloc_roots bug in 5.1.  Second place is RAM failure leading to memory
> corruption (a favorite in #btrfs IRC).  Third is disk failure beyond
> array limits (mostly on SD cards, nothing btrfs can do when the whole
> disk fails).  Firmware bugs in the disk eating the metadata is #4 (it
> happens, but not often).  Keeping backup trees on the disk longer will
> only help in the 4th case.  All of the other cases involve damage to trees
> that were committed long ago, where none of the backup roots will work.
> 
Yeah I think we need to be smarter about detecting these cases with btrfsck. 
Like there's good reason to not default to --init-extent-tree or 
--init-csum-tree.  But if you can't read those roots at all?  Why make the user 
have to figure that stuff out?  --repair should be able to say "oh well these 
trees are just completely fucked, --init-extent-tree is getting turned on", 
without the user needing to know how to do it.  Thanks,

Josef
