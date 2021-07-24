Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C343D4786
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 14:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhGXL10 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 07:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhGXL1Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 07:27:25 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D3CC061575
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sDsmeBSTknmGl7hzQ+vNFO3KkLP5PLCZUmxE29eD33s=; b=HPXad4f23+kdQzzXW8SUxWvp3X
        frgQCP9KaStEKwdVr1QzpqA3IVYfKgj+xi2pHi/fP3fs3DcIMEWoWx7QicMhcf61x0L8Weva80NAG
        6xzUD3xLfAAyqJakXoLoyFtn/5n03KAWOETp5qEDK7s5STW2FwznLLrwqhrtvetq92m3cNNwOV+43
        RA/k8Off9rENGW23GfzIy1ATi+47Yqx1M8QTsn9bkYlFsW1ofIfaGO7WFmNNOXE8PuMIBvfIO+cDe
        PFhAjXIk/2NZeIHINiMOVSlxijc1lnJnP3dhIT+RFc4dTF4nzOnYis4Sfm7qoTrTk7NvTP60S84Xi
        kiaWVCQw==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:47055 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1m7GRe-0006Sg-QA; Sat, 24 Jul 2021 14:07:54 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
To:     Hugo Mills <hugo@carfax.org.uk>, dsterba@suse.cz,
        Roman Mamedov <rm@romanrm.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210722192955.18709-1-dsterba@suse.com>
 <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
 <20210723140843.GE19710@twin.jikos.cz> <20210723222730.1d23f9b4@natsu>
 <20210723192145.GF19710@suse.cz>
 <18a1bdd5-321e-68d3-517f-84c8d9bacb9c@dirtcellar.net>
 <20210724112421.GB992@savella.carfax.org.uk>
 <374aeb6a-80ed-431c-46c8-79917c787cd4@dirtcellar.net>
 <20210724115514.GC992@savella.carfax.org.uk>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <981a60a9-d3ad-1b6d-4ca0-ff30cba06d11@dirtcellar.net>
Date:   Sat, 24 Jul 2021 14:07:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.8.1
MIME-Version: 1.0
In-Reply-To: <20210724115514.GC992@savella.carfax.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Hugo Mills wrote:
> On Sat, Jul 24, 2021 at 01:49:30PM +0200, waxhead wrote:
>>
>>
>> Hugo Mills wrote:
>>> On Sat, Jul 24, 2021 at 01:04:19PM +0200, waxhead wrote:
>>>> David Sterba wrote:
>>>>
>>>>> Maybe it's still too new so nobody is used to it and we've always had
>>>>> problems with the raid naming scheme anyway.
>>>>
>>>> Some years ago (2018) there was some talk about a new naming scheme
>>>> https://marc.info/?l=linux-btrfs&m=136286324417767
>>>>
>>>> While technically spot on I found Hugo's naming scheme difficult. It was
>>>> based on this idea:
>>>> numCOPIESnumSTRIPESnumPARITY
>>>>
>>>> 1CmS1P = Raid5 or 1 copy, max stripes, 1 parity.
>>>>
>>>> I also do not agree with the use of 'copy'. The Oxford dictionary defines
>>>> 'copy' as "a thing that is made to be the same as something else, especially
>>>> a document or a work of art"
>>>>
>>>> And while some might argue that copying something on disk from memory makes
>>>> it a copy, it ceases to be a copy once the memory contents is erased. I
>>>> therefore think that replicas is a far better terminology.
>>>>
>>>> I earlier suggested Rnum.Snum.Pnum as a naming scheme which I think is far
>>>> more readable so if I may dare to be as bold....
>>>>
>>>> SINGLE  = R0.S0.P0 (no replicas, no stripes (any device), no parity)
>>>> DUP     = R1.S1.P0 (1 replica, 1 stripe (one device), no parity)
>>>> RAID0   = R0.Sm.P0 (no replicas, max stripes, no parity)
>>>> RAID1   = R1.S0.P0 (1 replica, no stripes (any device), no parity)
>>>> RAID1c2 = R2.S0.P0 (2 replicas, no stripes (any device), no parity)
>>>> RAID1c3 = R3.S0.P0 (3 replicas, no stripes (any device), no parity)
>>>> RAID10  = R1.Sm.P0 (1 replica, max stripes, no parity)
>>>> RAID5   = R0.Sm.P1 (no replicas, max stripes, 1 parity)
>>>> RAID5   = R0.Sm.P2 (no replicas, max stripes, 2 parity)
>>>>
>>>> This (or Hugo's) type of naming scheme would also easily allow add more
>>>> exotic configuration such as S5 e.g. stripe over 5 devices in a 10 device
>>>> storage system which could increase throughput for certain workloads
>>>> (because it leaves half the storage devices "free" for other jobs)
>>>> A variant of RAID5 behaving like RAID10 would simply be R1.Sm.P1. Easy
>>>> peasy...  And just for the record , the old RAID terminology should of
>>>> course work for compatibility reasons, but ideally should not be advertised
>>>> at all.
>>>>
>>>> Sorry for completely derailing the topic, but I felt it was important to
>>>> bring up (and I admit to be overenthusiastic about it). :)
>>>
>>>      I'd go along with that scheme, with one minor modification -- make
>>> the leading letters lower-case. The choice of lower-case letters in my
>>> original scheme was deliberate, as it breaks up the sequence and is
>>> much easier to pick out the most important parts (the numbers) from
>>> the mere positional markers (the letters).
>>>
>>>      Also, the "M" (caps, because it's equivalent to the large numbers)
>>> in stripes wasn't for "max", but simply the conventional mathematical
>>> "m" -- some number acting as a limit to a counter (as in, "we have n
>>> copies with m stripes and p parity stripes").
>>>
>>>      Hugo.
>>>
>> Agree. Lowercase r0.s0.p0 / r1.sM.p2 is more readable indeed.
>> I insist on the dots between for separators as this would make possibly
>> future fantasy things such as rmin-max e.g. r2-4.sM.p0 more readable.
>>
>> (in my fantasy world: r2-6 would mean 6 replicas where all can automatically
>> be deleted except 2 if the filesystem runs low on space. Would make parallel
>> read potentially super fast as long as there is plenty of free space on the
>> filesystem plus increase redundancy. Free space is wasted space (just like
>> with memory so it might as well be used for something useful)
> 
>     I like the dots.
> 
>     Ranges I'm thinking would be of particular use with stripes --
> there have been discussions in the past about limiting the stripe
> width on large numbers of devices, so that you don't end up with a
> RAID-6 run across all 24 devices of an array for every strip. That
> might be a use-case for, for example, r1.s3-8.p2.
> 
>     Hugo.
> 
Not to mention the fact that ranges for stripes for example could 
potentially make parts of the filesystem survive what could otherwise be 
fatal. And if my wet dream of storage profiles per subvolume ever 
becomes possible the possibilities are endless....
