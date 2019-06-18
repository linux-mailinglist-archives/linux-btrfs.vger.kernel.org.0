Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12D74AA7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 20:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfFRS63 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 14:58:29 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:38233 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbfFRS63 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 14:58:29 -0400
Received: by mail-qt1-f181.google.com with SMTP id n11so16712705qtl.5
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=N/7H51uUfCHrpcga8A6GM6QUNxLASozuqeC+Mh6ZI+0=;
        b=pfM7dUdULiwmCKnBBgp4OvmwdSvfH/p2MrporhMu8VLlnrKdxb6XzBS1B1atdhd8JS
         3y7IuHrXuTzL9A1I8SPpG9x66OBudL4dVlyb+CpYdvmnBDSLiMCbV/egzyjjhBI0DO2J
         nG3X+oiGWkUGHXjfkLS3y+uGp+O6K5OQrXCAD0+rgpXdgiHygrUAars3dAn3kJYXQuqY
         MgSaIUiPvHMNNcDxsh63s7YPt/ACcc6y8KT0pbzCinhQ3T0oIFgiI3v1wLrpuqlrjWYB
         qbmsp1Hr35XTxrep6pk2v9n6Xh0ODVfMQ3Mx13vbY/N90DNL5UcqfqCp8dgA+2WcQSTh
         5zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N/7H51uUfCHrpcga8A6GM6QUNxLASozuqeC+Mh6ZI+0=;
        b=EKD2bjtnIXJIB65VvGVs+9x7ygvXjiKCMRzRjgtS0Q3Zphd6XqmQjZtcbCXyIEyqRI
         b20reYvYkfVUGe9/VXHA4WmU/RLmS/UY2wX1JT7XY+VhAl6V+XY6jHMybE4Gg95FbSQ9
         9CFr6vIXXdHN7NlfLGgxQOo9u8HJeuDwMihio+lCRkkfbtELE72+NCsahGCcRi16yMsi
         QSleR145lQVyVDndXTkVFqq6isJoGfuoLaKXuAS05UPyLxYoStPevK6cW7GWnZbbKGLG
         htAcfbMw+RL5EtnYbIY6c7g/M3eberNqucg/FMRgBqO9iiVZ6+8cRgZB+oDNRLpVAE6T
         W+bQ==
X-Gm-Message-State: APjAAAU7MWtYMLYFvTSMEQ8wzu7RwLwuVhGe8VKDu4QyApMW44fT8sNV
        rpx+NgAHsgZl+I5P6cZ6rrLDxG94avA=
X-Google-Smtp-Source: APXvYqwh/3L3V2ltrL7R3slYP8Yq9YLjaMPSKDnyCVcmC4ec3Pv3+ecppKgI3K7O06RB9uTufDNp1g==
X-Received: by 2002:a0c:99e9:: with SMTP id y41mr22131098qve.186.1560884308024;
        Tue, 18 Jun 2019 11:58:28 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id i22sm9380220qti.30.2019.06.18.11.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:58:27 -0700 (PDT)
Subject: Re: Rebalancing raid1 after adding a device
To:     Hugo Mills <hugo@carfax.org.uk>,
        =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs@lesimple.fr>,
        linux-btrfs@vger.kernel.org
References: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <20190618184501.GJ21016@carfax.org.uk>
 <51e41a52-cbec-dae8-afec-ec171ec36eaa@gmail.com>
 <20190618185701.GK21016@carfax.org.uk>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <cab8986b-aa52-0aa8-8f7e-cb5f5a3597b0@gmail.com>
Date:   Tue, 18 Jun 2019 14:58:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618185701.GK21016@carfax.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-06-18 14:57, Hugo Mills wrote:
> On Tue, Jun 18, 2019 at 02:50:34PM -0400, Austin S. Hemmelgarn wrote:
>> On 2019-06-18 14:45, Hugo Mills wrote:
>>> On Tue, Jun 18, 2019 at 08:26:32PM +0200, Stéphane Lesimple wrote:
>>>> I've been a btrfs user for quite a number of years now, but it seems
>>>> I need the wiseness of the btrfs gurus on this one!
>>>>
>>>> I have a 5-hdd btrfs raid1 setup with 4x3T+1x10T drives.
>>>> A few days ago, I replaced one of the 3T by a new 10T, running btrfs
>>>> replace and then resizing the FS to use all the available space of
>>>> the new device.
>>>>
>>>> The filesystem was 90% full before I expanded it so, as expected,
>>>> most of the space on the new device wasn't actually allocatable in
>>>> raid1, as very few available space was available on the 4 other
>>>> devs.
>>>>
>>>> Of course the solution is to run a balance, but as the filesystem is
>>>> now quite big, I'd like to avoid running a full rebalance. This
>>>> would be quite i/o intensive, would be running for several days, and
>>>> putting and unecessary stress on the drives. This also seems
>>>> excessive as in theory only some Tb would need to be moved: if I'm
>>>> correct, only one of two block groups of a sufficient amount of
>>>> chunks to be moved to the new device so that the sum of the amount
>>>> of available space on the 4 preexisting devices would at least equal
>>>> the available space on the new device, ~7Tb instead of moving ~22T.
>>>> I don't need to have a perfectly balanced FS, I just want all the
>>>> space to be allocatable.
>>>>
>>>> I tried using the -ddevid option but it only instructs btrfs to work
>>>> on the block groups allocated on said device, as it happens, it
>>>> tends to move data between the 4 preexisting devices and doesn't fix
>>>> my problem. A full balance with -dlimit=100 did no better.
>>>
>>>     -dlimit=100 will only move 100 GiB of data (i.e. 200 GiB), so it'll
>>> be a pretty limited change. You'll need to use a larger number than
>>> that if you want it to have a significant visible effect.
>> Last I checked, that's not how the limit filter works.  AFAIUI, it's
>> an upper limit on how full a chunk can be to be considered for the
>> balance operation.  So, balancing with only `-dlimit=100` should
>> actually balance all data chunks (but only data chunks, because you
>> haven't asked for metadata balancing).
> 
>     That's usage, not limit. limit is simply counting the number of
> block groups to move.

Realized that I got the two mixed up right after I hit send.

That said, given the size of the FS, it's not unlikely that it may move 
more than 100GB worth of data (pre-replication), as the FS itself is 
getting into the range where chunk sizes start to scale up.
