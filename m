Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E543D4A7A
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 00:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhGXVpA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 17:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGXVpA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 17:45:00 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59924C061575
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ay4wSjpLPspEAlbGolFvfkRoDFyFUhjMuap9Lj6xkhA=; b=GDwnVCt2AquHJeouE+JAMwBQLN
        +Izj/mLKnWCaDzr137QvOV4NVX/Xdp9ZZoKzuZZ3inQ7xYHsVg9cz87JhHfmECwJ028Z0xFnyxa//
        RbB4DDqrizfEgOWRN1VfmW2kqx1UmUpyLI8QD3OAGgUO5LP6fGJRlzqNePP6ZhT0AJWQKMjI9oFPs
        Jmvga2URLWZua0z/cJlB5/yBkmC4MZ0io7YHEvMw0THqEjIjuUEz5rY9vR42ojIUzalD/qcyUNr9R
        cc3qOpQCFL68lfM1zLhTt24Q8ka02C1b4u7MDDI+NYmAlqM3euIRQrQJEGkJv8t5hbH2caS/oDB/Y
        +X9rynLg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:11554 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1m7Q5I-0001fk-4R; Sun, 25 Jul 2021 00:25:28 +0200
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
 <20210724123050.GD992@savella.carfax.org.uk>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <5c56924d-8391-a796-a331-0ac837b8435d@dirtcellar.net>
Date:   Sun, 25 Jul 2021 00:25:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.8.1
MIME-Version: 1.0
In-Reply-To: <20210724123050.GD992@savella.carfax.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Hugo Mills wrote:
> On Sat, Jul 24, 2021 at 01:04:19PM +0200, waxhead wrote:
>> David Sterba wrote:
>>
>>> Maybe it's still too new so nobody is used to it and we've always had
>>> problems with the raid naming scheme anyway.
>>
>> Perhaps slightly off topic , but I see constantly that people do not
>> understand how BTRFS "RAID" implementation works. They tend to confuse it
>> with regular RAID and get angry because they run into "issues" simply
>> because they do not understand the differences.
>>
>> I have been an enthusiastic BTRFS user for years, and I actually caught
>> myself incorrectly explaining how regular RAID works to a guy a while ago.
>> This happened simply because my mind was so used to how BTRFS uses this
>> terminology that I did not think about it.
>>
>> As BTRFS is getting used more and more it may be increasingly difficult (if
>> not impossible) to get rid of the "RAID" terminology, but in my opinion also
>> increasingly more important as well.
>>
>> Some years ago (2018) there was some talk about a new naming scheme
>> https://marc.info/?l=linux-btrfs&m=136286324417767
>>
>> While technically spot on I found Hugo's naming scheme difficult. It was
>> based on this idea:
>> numCOPIESnumSTRIPESnumPARITY
>>
>> 1CmS1P = Raid5 or 1 copy, max stripes, 1 parity.
>>
>> I also do not agree with the use of 'copy'. The Oxford dictionary defines
>> 'copy' as "a thing that is made to be the same as something else, especially
>> a document or a work of art"
>>
>> And while some might argue that copying something on disk from memory makes
>> it a copy, it ceases to be a copy once the memory contents is erased. I
>> therefore think that replicas is a far better terminology.
>>
>> I earlier suggested Rnum.Snum.Pnum as a naming scheme which I think is far
>> more readable so if I may dare to be as bold....
>>
>> SINGLE  = R0.S0.P0 (no replicas, no stripes (any device), no parity)
>> DUP     = R1.S1.P0 (1 replica, 1 stripe (one device), no parity)
>> RAID0   = R0.Sm.P0 (no replicas, max stripes, no parity)
>> RAID1   = R1.S0.P0 (1 replica, no stripes (any device), no parity)
>> RAID1c2 = R2.S0.P0 (2 replicas, no stripes (any device), no parity)
>> RAID1c3 = R3.S0.P0 (3 replicas, no stripes (any device), no parity)
>> RAID10  = R1.Sm.P0 (1 replica, max stripes, no parity)
>> RAID5   = R0.Sm.P1 (no replicas, max stripes, 1 parity)
>> RAID5   = R0.Sm.P2 (no replicas, max stripes, 2 parity)
> 
>     Sorry, I missed a detail here that someone pointed out on IRC.
> 
>     "r0" makes no sense to me, as that says there's no data. I would
> argue strongly to add one to all of your r values. (Note that

I disagree. R0 means no replicas of stored data. All filesystems have 
stored data so adding one seems rather pointless to me.

R0 would easily be interpreted as you can loose NO device.
Rn would also easily be interpreted as you can loose n device(s).

> "RAID1c2" isn't one of the current btrfs RAID levels, and by extension
> from the others, it's equivalent to the current RAID1, and we have
> RAID1c4 which is four complete instances of any item of data).
> 
>     My proposal counted *instances* of the data, not the redundancy.
> 
>     Hugo.
> 
You are correct that RAID1c2 does not exist, my mistake- it should have 
been RAID1c3 which is r2.s0.p0 which is 3 instances of data.

I am not directly against using instances of data, but since all 
filesystems have at least one instance to be meaningful I personally 
prefer using replicas as this would also clearer indicate how many 
devices you can loose. (for instances you have to subtract one anyway).


