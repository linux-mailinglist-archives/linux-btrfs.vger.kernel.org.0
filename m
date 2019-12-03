Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDEB1105EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 21:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfLCUcB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 15:32:01 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:33743 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfLCUcB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Dec 2019 15:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201810; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7ahRoGMfh/50UZeAu97nE+KoGH1Td/8adwpQ4bC6rzA=; b=YNAl1kcajuSuT+4+EPrisa2AyB
        PVrZkwhPRACuhZg16BzqjJjTz9Xxo+hXX+Gi2TYEZqP1b4zENLDX6RC71leBys9KGLywms0oQ5jFj
        I5uyqxETT6m2nM+iAhxRIwl9AX/GK/NaIz3V6ZDxnnOhOQ1znu0ADNgHXhNez/XKUjqO99ZnrP64G
        K/+Y/6O5QibPjrOFqhNoZ3HD/wIDgqftTMCVAU/prIBlMNrzEu74HwikrqoIvkG7/Lnc3AzZdWv5y
        vNQwjcmlgzZG5H+MnWlvympSqCYK9vawPI2Avuqd5cYgTPd/Gq/pQOhQ1dkfbbPwCmwo1IJN0OeSV
        5S9cwKcg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:31326 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1icEpy-0005MF-TM; Tue, 03 Dec 2019 21:31:58 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: BTRFS subvolume RAID level
To:     Anand Jain <anand.jain@oracle.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <494b0df1-2aab-5169-836d-e381498f64db@dirtcellar.net>
 <ed65c577-3971-8c4f-c690-83e85dd8188e@oracle.com>
 <fcbe2d91-a6ad-5b9b-fa66-aebb2edd14f1@dirtcellar.net>
 <422a04ba-2e63-f951-7097-19ecc7a88c53@oracle.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <5297ba43-366f-241c-1934-783686a058c8@dirtcellar.net>
Date:   Tue, 3 Dec 2019 21:31:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <422a04ba-2e63-f951-7097-19ecc7a88c53@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Anand Jain wrote:
> 
> 
> On 12/3/19 7:27 AM, waxhead wrote:
>>
>>
>> Anand Jain wrote:
>>>
>>>> I imagine that RAIDc4 for example could potentially give a grotesque 
>>>> speed increase for parallel read operations once BTRFS learns to 
>>>> distribute reads to the device with the least waitqueue / fastest 
>>>> devices.
>>>
>>>   That exactly was the objective of the Readmirror patch in the ML.
>>>   It proposed a framework to change the readmirror policy as needed.
>>>
>>> Thanks, Anand
>>
>> Indeed. If I remember correctly your patch allowed for deterministic 
>> reading from certain devices.
>   It provides a framework to configure the readmirror policies. And the
>   policies can be based on io-depth, pid, or manual for heterogeneous
>   devices with different latency.
> 
>> As just a regular btrfs user the problem I see with this is that you 
>> loose a "potential free scrub" that *might* otherwise happen from 
>> often read data. On the other hand that is what manual scrubbing is 
>> for anyway.
> 
>   Ha ha.
> 
>   When it comes to data and its reliability and availability we need
>   guarantee and only deterministic approach can provide it.
> 
Uhm , what I meant was that if someone sets a readmirror policy to read 
from the fastest devices in for example RAID1 and a copy exists on both 
a harddrive, and a SSD device and reads are served from the fastest 
drive (SSD) then you will never get a "accidental" read on the harddrive 
and therefore making scrubbing absolutely necessary (which it actually 
is anyway).

In other words for sloppy sysadmins, if you read data often then the 
hottest data is likely to have both copies read. If you set a policy 
that prefer to always read from SSD's it could happen that the poor 
harddrive is never "checked".

>   What you are asking for is to route the particular block to
>   the device which was not read before so to avoid scrubbing or to
>   make scrubbing more intelligent to scrub only old never read blocks
>   - this will be challenging we need to keep history of block and the
>   device it used for read - most likely a scope for the bpf based
>   external tools but definitely not with in kernel. With in kernel
>   we can create readmirror like framework so that external tool can
>   achieve it.

 From what I remember from my prevous post (I am too lazy to look it up) 
I was hoping that subvolumes could be assigned or "prioritized" to 
certain devices e.g. device groups. Which means that you could put all 
SSD's of a certain speed in one group, all harddrives in another group 
and NVMe storage devices in yet another group. Or you could put all 
devices on a certain JBOD controller board on it's own group. That way 
BTRFS could have prioritized to store certain subvolumes on a certain 
group and/or even allowing to migrate (balance) to antoher group. If you 
run out of space you can always distribute across other groups and to 
magic things there ;)

Not that I have anything against the readmirror policy , but I think 
this approach would be a lot more ideal.

> 
> 
> Thanks, Anand
