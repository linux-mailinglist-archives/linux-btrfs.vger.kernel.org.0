Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31ABB2331B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 13:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfETL6N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 07:58:13 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40756 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730612AbfETL6N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 07:58:13 -0400
Received: by mail-it1-f196.google.com with SMTP id h11so993813itf.5
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 04:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=27h2s+K9TXumde+eVCXsYFpRX8PDnlLL7kIORcCt0qg=;
        b=Pg/n4qfQnqTEKh4X7NBzlnKiybGewZvkSq9O46RMnlktDixZ4ohlaYxSnsU6mBtm8O
         yaCjX2s2Q8Dx4R/SNdDvJi7ELR3lh5PdAYbOR6aNFmld3qSCEoW5zR0/4hV1/ivlPdR2
         B/kcRqZwU36Y3NMZP3eoNMc0dHqGFXD0YZvdFEAsJs6jm+P27fdhTS47PaC6gs7kp3iq
         jKx69GCoF38nt1naUI48Yk7gHnH2qoQ3dtGEtbNmBg65l1lqwFKIVEm4VYx3VCx05BVl
         2dUaiLqoSW1sQncr4PoIhINuFYTa9F+YIq4RMG3VKzY7eaVQZVDQno5SnYnjXs6rPAvi
         nPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=27h2s+K9TXumde+eVCXsYFpRX8PDnlLL7kIORcCt0qg=;
        b=HDUvnHqhP22xW9nVm6qq2ErXuAagLCol5VCaJ3sbYj4OZqTRgRPN4IrbK12A+wT129
         mjVTzDXK8e0aqYd9wqBcfLlu3SSkXht6nZVzsIlXqk7FHVoIx73k/e/LX4fv3IOw4FBK
         dixkTuuty5+LJWw2BW/LtO6QXO/Qhl1Ljfs/xFGX7NWtriMuGDZR8QImvKe+PHAIVQPo
         zxzEru+Psc5XhL8TI+Ji24B7O0C+gZWSwW4OrcZTir6qa6Hmsx6rpNV0DiDtg0klW4XP
         X+3H52spHT6NYMiPq0FTmqC3CbzhdJw8FPmdHCmk+81dq+jv3zAcOZ3E2OB8So/2Df4i
         Hipw==
X-Gm-Message-State: APjAAAXxrdABXE4B1TRRxm79oYaXERi8mo9PbaY32OJlxOV8EQd56L12
        pY2gURV5PY7fiSjBUPDDyQg=
X-Google-Smtp-Source: APXvYqzN4WYc7HRcXxyAyD/mLr/yD1O6b9AO4/1ii9fYsgMPMPfC0TVeGYB0NI63FJmqGTZrAYTjMQ==
X-Received: by 2002:a05:660c:552:: with SMTP id w18mr26455368itk.26.1558353492458;
        Mon, 20 May 2019 04:58:12 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id a13sm5776208ioc.83.2019.05.20.04.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 04:58:12 -0700 (PDT)
Subject: Re: Btrfs send bloat
To:     Newbugreport <newbugreport@protonmail.com>,
        Patrik Lundquist <patrik.lundquist@gmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
References: <clzY4RoSOURzgBtua3TjQ4WXJzgY3EwTyiaYwt49zFAPIi_jO2nAQ8O2saTwpqHH9x0ISw9AVbWOvVR4hFDIx8_dzlWKAzHwcOtEuwaXzJ8=@protonmail.com>
 <275f7add-382c-bf6d-4cf8-f9823cf55daf@gmail.com>
 <CAA7pwKM_1uWbu9ECgkqAMXMWTOJm5xH1wvHKFwq+7w=JeQQ7xg@mail.gmail.com>
 <ZBp4TxX3BVubLSjbbtXjztW20HT6YFrXCMMV6IX3xamgZbnpU4KJvO5vs0tcF5po8Ay4KdgGyffZ2DHitm4X4Hm0CFMPCjC2g_HHS9CR51M=@protonmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <56ee6d38-d4a8-a62b-4e0d-7568030cdcad@gmail.com>
Date:   Mon, 20 May 2019 07:58:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ZBp4TxX3BVubLSjbbtXjztW20HT6YFrXCMMV6IX3xamgZbnpU4KJvO5vs0tcF5po8Ay4KdgGyffZ2DHitm4X4Hm0CFMPCjC2g_HHS9CR51M=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-05-20 07:15, Newbugreport wrote:
> Patrik, thank you. I've enabled the SAMBA module, which may help in the future. Does the GUI file manager (i.e. Nautilus) need special support?
It shouldn't (Windows' default file manager doesn't, and most stuff on 
Linux uses Samba so it shouldn't either, not sure about macOS though).

Keep in mind, however, that server-side copies only work in SMB within a 
single share.  If you're moving files between two independent shares, 
even if they're on the same server (or even the same filesystem on the 
same server) will always translate to a copy+delete because the client 
system has no other way to tell the server to move the file across shares.
> 
> Andrea, thank you for the link. bup is impressive but does it work well with btrfs snapshots? My live drive contains the main volume alongside many snapshots and the associated bloat from moved/deleted files. There's not room for another copy of everything, even if it's deduplicated. Perhaps I could switch one of the backup drives and the cloud to bup, but how well would bup work diffing all those snapshots when the backup drive is plugged in?
Deduplication will almost never increase the total amount of data, and 
it absolutely won't need a second copy of everything.  The initial pass 
will probably be very slow though, as the ioctl that gets used does a 
bytewise comparison of the ranges that get passed in to make sure they 
are actually identical before it merges them.  Once the data is mostly 
deduplicated, this shouldn't be an issue for most tools as they will see 
the existing deduplicated ranges and not try to re-merge them.
> 
> 
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Monday, May 20, 2019 10:34 AM, Patrik Lundquist <patrik.lundquist@gmail.com> wrote:
> 
>> On Mon, 20 May 2019 at 02:36, Andrei Borzenkov arvidjaar@gmail.com wrote:
>>
>>> 19.05.2019 11:11, Newbugreport пишет:
>>>
>>>> I have 3-4 years worth of snapshots I use for backup purposes. I keep
>>>> R-O live snapshots, two local backups, and AWS Glacier Deep Freeze. I
>>>> use both send | receive and send > file. This works well but I get
>>>> massive deltas when files are moved around in a GUI via samba.
>>>
>>> Did you analyze whether it is client or server problem? If client does
>>> file copy (instead of move as you imply) may be the simplest solution
>>> would be to use different tool on client. If problem is on server side,
>>> it is something to discuss with SAMBA folks.
>>
>> Also try the Btrfs module in Samba.
>> https://wiki.samba.org/index.php/Server-Side_Copy#Btrfs_Enhanced_Server-Side_Copy_Offload
> 
> 

