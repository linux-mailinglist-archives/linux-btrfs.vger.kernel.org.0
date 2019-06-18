Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681EA4AAD6
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 21:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfFRTGp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 15:06:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41731 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730530AbfFRTGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 15:06:41 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so32307184ioc.8
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 12:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8PXwtKNyKu6g8MaqFCSzPU9aMEfSVJwPYohY3RKfm0g=;
        b=Gqt9zuKFGv00+X8g7ZUPvHna9STmJI0qw2jjoP/bNBYXoyVBqeyLAr7Cm39XU5EarB
         HyU9NHBMa5XHnSu6WEY5GLxgdBEaQVJCh4LOHUkI0MenZ7WyQbp3u7id1lxUF2Gde4Hq
         emsnKq5ym1i/rTKonxzklnjFhJJqA19Hhs1xE2tMHFqKnPlA1HIUMI7ebH+RJJiehyMP
         q4QPUA9fcA3F+A+SDLy9AxSWkI3D1YT/6CFRVY+oRtIfq+5oJSnevboYoDVWpWFBpLfz
         YRHWotvmxl9i4yucldQABrQ2yjHD+5fx8ABs5Zz46U8veGAvpJsr9LggO6LncSYnPxJk
         uNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8PXwtKNyKu6g8MaqFCSzPU9aMEfSVJwPYohY3RKfm0g=;
        b=K7rW7a8yiLJ3YhR8aEz2JTKrJL46Sy7/4lWjTB+1TIfoiqOnW1RMCD5hspj7/G1lu1
         jEtgUfX+5Vp6jS4URcIIiV34nP4U/tecOEO5BUSLLk0H5z/7IgyWs5WG0DQJclsFEH6S
         TEBCpKrygoqi85eUEblCnSlb524OTCrdjZhmHfSKyeca+n4FCIx9wMzVkFUAYX3/ocnr
         RZy5A/D0Cmz4l/XtKEe1iZ3Tv2/DngGSOsyiJmo+NdK3e4idRTs1g+3tf0toAi6YU10d
         7M1KLovArezyael2G6RaTWs2FfG9O+luS2jSnZd52zu9A6NxjJZ7WdhD/6zsA4o8xVwc
         G+Nw==
X-Gm-Message-State: APjAAAU3/lb1t/nJwx9WVlRfxpeWlWCssvNDe5sEUKiBs/Cs0gJy4ew3
        9uciVhctcaPoagU9+OVLtxV9yL7+3bI=
X-Google-Smtp-Source: APXvYqy53719SZ+mYsJYOT9vQ3PD/aeoD8jp+eo8E2FA7ggN3EzMbVxg/pTLjit/DwQXc703dJuFTg==
X-Received: by 2002:a5d:87da:: with SMTP id q26mr6580714ios.193.1560884800182;
        Tue, 18 Jun 2019 12:06:40 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id b14sm18477841iod.33.2019.06.18.12.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 12:06:39 -0700 (PDT)
Subject: Re: Rebalancing raid1 after adding a device
To:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs@lesimple.fr>,
        linux-btrfs@vger.kernel.org
References: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <1e1f90ed-80ce-96dc-e3d8-1e406121833d@gmail.com>
Date:   Tue, 18 Jun 2019 15:06:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-06-18 14:26, Stéphane Lesimple wrote:
> Hello,
> 
> I've been a btrfs user for quite a number of years now, but it seems I 
> need the wiseness of the btrfs gurus on this one!
> 
> I have a 5-hdd btrfs raid1 setup with 4x3T+1x10T drives.
> A few days ago, I replaced one of the 3T by a new 10T, running btrfs 
> replace and then resizing the FS to use all the available space of the 
> new device.
> 
> The filesystem was 90% full before I expanded it so, as expected, most 
> of the space on the new device wasn't actually allocatable in raid1, as 
> very few available space was available on the 4 other devs.
> 
> Of course the solution is to run a balance, but as the filesystem is now 
> quite big, I'd like to avoid running a full rebalance. This would be 
> quite i/o intensive, would be running for several days, and putting and 
> unecessary stress on the drives. This also seems excessive as in theory 
> only some Tb would need to be moved: if I'm correct, only one of two 
> block groups of a sufficient amount of chunks to be moved to the new 
> device so that the sum of the amount of available space on the 4 
> preexisting devices would at least equal the available space on the new 
> device, ~7Tb instead of moving ~22T.
> I don't need to have a perfectly balanced FS, I just want all the space 
> to be allocatable.
> 
> I tried using the -ddevid option but it only instructs btrfs to work on 
> the block groups allocated on said device, as it happens, it tends to 
> move data between the 4 preexisting devices and doesn't fix my problem. 
> A full balance with -dlimit=100 did no better.
> 
> Is there a way to ask the block group allocator to prefer writing to a 
> specific device during a balance? Something like -ddestdevid=N? This 
> would just be a hint to the allocator and the usual constraints would 
> always apply (and prevail over the hint when needed).
> 
> Or is there any obvious solution I'm completely missing?

Based on what you've said, you may actually not have enough free space 
that can be allocated to balance things properly.

When a chunk gets balanced, you need to have enough space to create a 
new instance of that type of chunk before the old one is removed.  As 
such, if you can't allocate new chunks at all, you can't balance those 
chunks either.

So, that brings up the question of how to deal with your situation.

The first thing I would do is multiple compaction passes using the 
`usage` filter.  Start with:

     btrfs balance -dusage=0 -musage=0 /wherever

That will clear out any empty chunks which haven't been removed (there 
shouldn't be any if you're on a recent kernel, but it's good practice 
anyway).  After that, repeat the same command, but with a value of 10 
instead of 0, and then keep repeating in increments of 10 up until 50. 
Doing this will clean up chunks that are more than half empty (making 
multiple passes like this is a bit more reliable, and in some cases also 
more efficient), which should free up enough space for balance to work 
with (as well as probably moving most of the block groups it touches to 
use the new disk).
