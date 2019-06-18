Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6BD4AB16
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 21:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfFRTmP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 15:42:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40196 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfFRTmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 15:42:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so16909949qtn.7
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=93fQkbDcjgpsCYDFz1O6rLpmqhya6rqY3deDLEYJkUc=;
        b=PgX7Lt9t+4sdtVKU2+OcdU4759BhjJFgMxArrCb/RCxipOYwdETAjXuaHycgC8wpZn
         SawjU6MtNuuKmi/7g8j54u3i+J8PtVN/C0LDE18VSG/CoBcDmskZBMUnGVcr6ZhPr2Be
         7fbJeXAxyKXaxXeGkJILkmGbCXCM3lZNvlL1HteEPvszqVMmQ2LB1vZzdkoWLBj3SDrv
         WngzAXXi23IdgrbnUJyqLSGgPXI7Z86TIbctgPj+6vA+Kya6heEH1bvdhnYeHuqed6I3
         sT6COdAl1DmtYhXT0S1Z5w56/07cNTpkdQ6NbJQTKD1wS3c5AeOTPX+smPuKJAnp9pBX
         LPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=93fQkbDcjgpsCYDFz1O6rLpmqhya6rqY3deDLEYJkUc=;
        b=N1KSyhIrWIRtJRBTBRXo96tEjABEICtF3++fhelNghmDsIQlFepQHC288Gbf0g9Jze
         8yb5USg2YXomSCmoMEtNOmqOiRyTRsMTBJlFt5TirpN8U8oM6kLtinBLvKGqi/FOcii5
         C4MifOjxTvHBDRkjYMkpWloFtJtnnnXUr+dJr//SQ7RzfN46aRlLFHH4qCRb4uQsnmn7
         2i1G8OU2PqIRtWermmwjWQGGDsQMQMjrDv1M4C6OK7xcFhRQVJ/BYXnPlwhXH5bHbLF3
         QrOpf955SCtFfnrdaAJOQh4nw27IbkNjMNAWFatfEJQQ3IxoCooSZmpI/zZ68woIm2Di
         7FBQ==
X-Gm-Message-State: APjAAAXqrmQt+dSC40GKCmZn5Q309bYEnKR7Hk3Bio/pCqZfbCLwPJRu
        Za0VFNcEkrNG+1tfTbNPi0ClW/YSJF4=
X-Google-Smtp-Source: APXvYqxydFdCvpUcOcnldsnROUvlONgZQgPdjB0QT4fmg4wCV9xwJz5ywFi2Y8DIEITlvP+YO4i/og==
X-Received: by 2002:a0c:bd9a:: with SMTP id n26mr29217343qvg.25.1560886933784;
        Tue, 18 Jun 2019 12:42:13 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id k33sm9058104qte.69.2019.06.18.12.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 12:42:13 -0700 (PDT)
Subject: Re: Rebalancing raid1 after adding a device
To:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs@lesimple.fr>
Cc:     linux-btrfs@vger.kernel.org
References: <1e1f90ed-80ce-96dc-e3d8-1e406121833d@gmail.com>
 <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <3cf139f51a2bc9324797a13831f99507@lesimple.fr>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <958d79f1-ed9c-eca3-9d7a-03a846de8f2f@gmail.com>
Date:   Tue, 18 Jun 2019 15:42:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <3cf139f51a2bc9324797a13831f99507@lesimple.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-06-18 15:37, Stéphane Lesimple wrote:
> June 18, 2019 9:06 PM, "Austin S. Hemmelgarn" <ahferroin7@gmail.com> wrote:
> 
>> On 2019-06-18 14:26, Stéphane Lesimple wrote:
>>
>> [...]
>>
>>> I don't need to have a perfectly balanced FS, I just want all the space > to be allocatable.
>>> I tried using the -ddevid option but it only instructs btrfs to work on > the block groups
>>> allocated on said device, as it happens, it tends to > move data between the 4 preexisting devices
>>> and doesn't fix my problem. > A full balance with -dlimit=100 did no better.
>>> Is there a way to ask the block group allocator to prefer writing to a > specific device during a
>>> balance? Something like -ddestdevid=N? This > would just be a hint to the allocator and the usual
>>> constraints would > always apply (and prevail over the hint when needed).
>>> Or is there any obvious solution I'm completely missing?
>>
>> Based on what you've said, you may actually not have enough free space that can be allocated to
>> balance things properly.
>>
>> When a chunk gets balanced, you need to have enough space to create a new instance of that type of
>> chunk before the old one is removed. As such, if you can't allocate new chunks at all, you can't
>> balance those chunks either.
>>
>> So, that brings up the question of how to deal with your situation.
>>
>> The first thing I would do is multiple compaction passes using the `usage` filter. Start with:
>>
>> btrfs balance -dusage=0 -musage=0 /wherever
>>
>> That will clear out any empty chunks which haven't been removed (there shouldn't be any if you're
>> on a recent kernel, but it's good practice anyway). After that, repeat the same command, but with a
>> value of 10 instead of 0, and then keep repeating in increments of 10 up until 50. Doing this will
>> clean up chunks that are more than half empty (making multiple passes like this is a bit more
>> reliable, and in some cases also more efficient), which should free up enough space for balance to
>> work with (as well as probably moving most of the block groups it touches to use the new disk).
> 
> Fair point, I do run some balances with -dusage=20 from time to time, the current state of the FS
> is actually as follows:
> 
> btrfs d u /tank | grep Unallocated:
>     Unallocated:            57.45GiB
>     Unallocated:             4.58TiB <= new 10T
>     Unallocated:            16.03GiB
>     Unallocated:            63.49GiB
>     Unallocated:            69.52GiB
> 
> As you can see I was able to move some data to the new 10T drive in the last few days, mainly by
> trial/error with several -ddevid and -dlimit parameters. As of now I still have 4.38T that are
> unallocatable, out of the 4.58T that are unallocated on the new drive. I was looking for a better
> solution that just running a full balance (with or without -devid=old10T) by asking btrfs to
> balance data to the new drive, but it seems there's no way to instruct btrfs to do that.
> 
> I think I'll still run a -dusage pass before doing the full balance indeed, can't hurt.
> 
I would specifically make a point to go all the way up to `-dusage=50` 
on that pass though.  It will, of course, take longer than a run with 
`-dusage=20` would, but it will also do a much better job.

That said, it looks like you should have more than enough space for 
balance to be doing it's job correctly here, so I suspect you may have a 
lot of partially full chunks around and the balance is repacking into 
those instead of allocating new chunks.

Regardless though, I suspect that just doing a balance pass with the 
devid filter and only balancing chunks that are on the old 10TB disk as 
Hugo suggested is probably going to get you the best results 
proportionate to the time it takes.
