Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D35B4AA42
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 20:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfFRSuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 14:50:40 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:39047 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfFRSuk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 14:50:40 -0400
Received: by mail-io1-f46.google.com with SMTP id r185so26301753iod.6
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=feT8L4u91DAkjoR2pot89HveifuFYrMP4/btZYAWUqk=;
        b=ljsIBY6LXBdIsAd8Vlott752boCuPKts9ipv74Ta5t5cnHfIQQV3DZym0UaR5ErByL
         S4Kub0YzgT98LVx7QoA1Md+XF+8/GBOTR4ohiY0Ea+J0sVB17ScBaSYvWPzR4WdQvqbp
         9b3dnvzAecmAysxJ3OTHtxGagQUgllqFmlHEKW1R04IQBwTqiu7OY/Ii2Ma4zGOmOp3Q
         +/Ac2lv4YFQxjHSp1cH77xUG41DzhJruPlMwS58cbpMWY8J4vLSc2R+FEnaW6/8OKtp3
         4x1HvgrdmQzOvz/7ze+nXa6QQakOVHj3aKuAjgwu8/z1Jc0/dslZIZ9mRJJyaY7W7XSJ
         Kx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=feT8L4u91DAkjoR2pot89HveifuFYrMP4/btZYAWUqk=;
        b=JwoKhbrv6Af7P57f8awKnfcJfjKtdp0C+vxCBczE6XznuePs/ffsp2RgDuURWyaRcG
         6LKl2h9t/iZagzsZiO4fbcenh+JAJWJMONXfdevfCOu65M4Yhtlcedv+b5ltk92gZMca
         f/vrBRkW1fGPgEVyuXtItZXEofaNZhtgndIZPfPw+awzgDFI5G4nWE4vGGjsdTFg/gmL
         YNB/ngw2V1rvv70QpMC0JKJ8z64ULO9Acp71WH6kfN4KmQsO1JvKo0xNHS5S9nQaEXvd
         ifJpG3g9qMOLRCX59wykS1qsIhaNd1sYId4oDuyR1hJ7drhwie/LfCfU7WvoH09SnXmA
         6HHQ==
X-Gm-Message-State: APjAAAWK0KcLi0hWJezyTdiZR3JUjOGGCtlBwf8uK5CrPoegjgERcFiX
        r/uQX21D3tXUQ+xZyj6L43KZC6D4jaE=
X-Google-Smtp-Source: APXvYqwwMW3rMARN7Y607fRrvdAFudniNYCMZZvjNR9ccVI5MsCnSUx+0sq9MNZZAAsjBkjkvJQJew==
X-Received: by 2002:a5d:9ad6:: with SMTP id x22mr6984439ion.136.1560883839380;
        Tue, 18 Jun 2019 11:50:39 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id e22sm11919045iob.66.2019.06.18.11.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:50:38 -0700 (PDT)
Subject: Re: Rebalancing raid1 after adding a device
To:     Hugo Mills <hugo@carfax.org.uk>,
        =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs@lesimple.fr>,
        linux-btrfs@vger.kernel.org
References: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <20190618184501.GJ21016@carfax.org.uk>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <51e41a52-cbec-dae8-afec-ec171ec36eaa@gmail.com>
Date:   Tue, 18 Jun 2019 14:50:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618184501.GJ21016@carfax.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-06-18 14:45, Hugo Mills wrote:
> On Tue, Jun 18, 2019 at 08:26:32PM +0200, Stéphane Lesimple wrote:
>> I've been a btrfs user for quite a number of years now, but it seems
>> I need the wiseness of the btrfs gurus on this one!
>>
>> I have a 5-hdd btrfs raid1 setup with 4x3T+1x10T drives.
>> A few days ago, I replaced one of the 3T by a new 10T, running btrfs
>> replace and then resizing the FS to use all the available space of
>> the new device.
>>
>> The filesystem was 90% full before I expanded it so, as expected,
>> most of the space on the new device wasn't actually allocatable in
>> raid1, as very few available space was available on the 4 other
>> devs.
>>
>> Of course the solution is to run a balance, but as the filesystem is
>> now quite big, I'd like to avoid running a full rebalance. This
>> would be quite i/o intensive, would be running for several days, and
>> putting and unecessary stress on the drives. This also seems
>> excessive as in theory only some Tb would need to be moved: if I'm
>> correct, only one of two block groups of a sufficient amount of
>> chunks to be moved to the new device so that the sum of the amount
>> of available space on the 4 preexisting devices would at least equal
>> the available space on the new device, ~7Tb instead of moving ~22T.
>> I don't need to have a perfectly balanced FS, I just want all the
>> space to be allocatable.
>>
>> I tried using the -ddevid option but it only instructs btrfs to work
>> on the block groups allocated on said device, as it happens, it
>> tends to move data between the 4 preexisting devices and doesn't fix
>> my problem. A full balance with -dlimit=100 did no better.
> 
>     -dlimit=100 will only move 100 GiB of data (i.e. 200 GiB), so it'll
> be a pretty limited change. You'll need to use a larger number than
> that if you want it to have a significant visible effect.
Last I checked, that's not how the limit filter works.  AFAIUI, it's an 
upper limit on how full a chunk can be to be considered for the balance 
operation.  So, balancing with only `-dlimit=100` should actually 
balance all data chunks (but only data chunks, because you haven't asked 
for metadata balancing).
> 
>     The -ddevid=<old_10T> option would be my recommendation. It's got
> more chunks on it, so they're likely to have their copies spread
> across the other four devices. This should help with the
> balance.
> 
>     Alternatively, just do a full balance and then cancel it when the
> amount of unallocated space is reasonably well spread across the
> devices (specifically, the new device's unallocated space is less than
> the sum of the unallocated space on the other devices).
> 
>> Is there a way to ask the block group allocator to prefer writing to
>> a specific device during a balance? Something like -ddestdevid=N?
>> This would just be a hint to the allocator and the usual constraints
>> would always apply (and prevail over the hint when needed).
> 
>     No, there isn't. Having control over the allocator (or bypassing
> it) would be pretty difficult to implement, I think.
> 
>     It would be really great if there was an ioctl that allowed you to
> say things like "take the chunks of this block group and put them on
> devices 2, 4 and 5 in RAID-5", because you could do a load of
> optimisation with reshaping the FS in userspace with that. But I
> suspect it's a long way down the list of things to do.
> 
>> Or is there any obvious solution I'm completely missing?
> 
>     I don't think so.
> 
>     Hugo.
> 

