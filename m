Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2BF2A30C9
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 18:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgKBRDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 12:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgKBRDo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Nov 2020 12:03:44 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C616C0617A6
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Nov 2020 09:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kygsC3u1vslN1C5jhdKKYVsr6eeo6Qa+nRqPFm4Qdnk=; b=kSoXbdEITfO1XJeo6nTAY44XC+
        0RWLmATRoZjmgUOpi/KIF1/v6wdU5Y7u5OWxaYGYqmaVLnxALetU9J8e6nI4bI8Tt+y2hBoxccCtf
        wYjM5ZHW4vpU7/dog4gUMGVsWkIWJp4yTrLpin7MevSwBRu1El6T9Nhqw3FJh+SUAWGjugDn8IaO2
        7OQQf7wN1UIDmBQTFxMkFfl5RirpqkdwU8YycCTagufDgJC4myX50JiHs970x27/dAqJtXyqd37PX
        KaodYTJtap/18R0r1xUDpwGRxCDGXgXpXPYWtZCePWK/+SfzNMfneHMFVwOFKGk5esToaM3w3ZbRZ
        Bep95OYg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:30699 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1kZdF6-0003SS-Bq; Mon, 02 Nov 2020 18:03:40 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Switching from spacecache v1 to v2
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <fc45b21c-d24e-641c-efab-e1544aa98071@dirtcellar.net>
 <20201101174902.GU5890@hungrycats.org>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <b54df3c2-681b-816d-153f-1d6c265917b2@dirtcellar.net>
Date:   Mon, 2 Nov 2020 18:03:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.4
MIME-Version: 1.0
In-Reply-To: <20201101174902.GU5890@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo Blaxell wrote:
> On Sat, Oct 31, 2020 at 01:27:57AM +0100, waxhead wrote:
>> A couple of months ago I asked on IRC how to properly switch from version 1
>> to version 2 of the space cache. I also asked if the space cache v2 was
>> considered stable.
>> I only remember what we talked about, and from what I understood it was not
>> as easy to switch as the wiki may seem to indicate.
>>
>> We run a box with a btrfs filesystem at 19TB, 9 disks, 11 subvolumes that
>> contains about 6.5 million files (and this number is growing).
>>
>> The filesystem has always been mounted with just the default options.
>>
>> Performance is slow, and it improved when I moved the bulk of the files to
>> various subvolumes for some reason. The wiki states that performance on very
>> large filesystems (what is considered large?) may degrade drastically.
> 
> The important number for space_cache=v1 performance is the number of block
> groups in which some space was allocated or deallocated per transaction
> (i.e. the number of block groups that have to be updated on disk),
> divided by the speed of the drives (i.e. the number of seeks they can
> perform per second).
> 
> "Large" could be 100GB if it was on a slow disk with a highly fragmented
> workload and low latency requirement.
> 
> A 19TB filesystem has up to 19000 block groups and a spinning disk can do
> maybe 150 seeks per second, so a worst-case commit could take a couple of
> minutes.  Delete a few old snapshots, and you'll add enough fragmentation
> to touch a significant portion of the block groups, and thus see a lot
> of additional latency.
> 
>> I would like to try v2 of the space cache to see if that improves speed a
>> bit.
>>
>> So is space cache v2 safe to use?!
> 
> AFAIK it has been 663 days since the last bug fix specific to free space
> tree (a6d8654d885d "Btrfs: fix deadlock when using free space tree due
> to block group creation" from 5.0).  That fix was backported to earlier
> LTS kernels.
> 
> We switched to space_cache=v2 for all new filesystems back in 2016, and
> upgraded our last legacy machine still running space_cache=v1 in 2019.
> 
> I have never considered going back to v1:  we have no machines running
> v1, I don't run regression tests on new kernels with v1, and I've never
> seen a filesystem fail in the field due to v2 (even with the bugs we
> now know it had).
> 
> IMHO the real question is "is v1 safe to use", given that its design is
> based on letting errors happen, then detecting and recovering from them
> after they occur (this is the mechanism behind the ubiquitous "failed to
> load free space cache for block group %llu, rebuilding it now" message).
> v2 prevents the errors from happening in the first place by using the
> same btrfs metadata update mechanisms that are used for everything else
> in the filesystem.
> 
> The problems in v1 may be mostly theoretical.  I've never cared enough
> about v1 to try a practical experiment to see if btrfs recovers from
> these problems correctly (or not).  v2 doesn't have those problems even
> in theory, and it works, so I use v2 instead.
> 
>> And
>> How do I make the switch properly?
> 
> Unmount the filesystem, mount it once with -o clear_cache,space_cache=v2.
> It will take some time to create the tree.  After that, no mount option
> is needed.
> 
> With current kernels it is not possible to upgrade while the filesystem is
> online, i.e. to upgrade "/" you have to set rootflags in the bootloader
> or boot from external media.  That and the long mount time to do the
> conversion (which offends systemd's default mount timeout parameters)
> are the two major gotchas.
> 
> There are some patches for future kernels that will take care of details
> like deleting the v1 space cache inodes and other inert parts of the
> space_cache=v1 infrastructure.  I would not bother with these
> now, and instead let future kernels clean up automatically.
> 

Well I did exactly as you said. I mounted the filesystem from a live CD 
with -o clear_cache,space_cache=v2 and rebooted back into the system 
(yes, the rootfs is btrfs).

Everything I am about to say is of course subjective, but the system is 
significantly more snappy now - quite a lot too. So unless the live cd 
with kernel 5.9 tuned something magnificent that has a nice effect on 
5.8 as well the change to V2 space cache was significant on our box.

So if I may summarize... COW-ABUNGA! WOW!
Not sure why it had such a profound impact on performance, but perhaps 
V2 should be the default?!
