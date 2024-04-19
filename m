Return-Path: <linux-btrfs+bounces-4432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C6A8AB1BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C941C2189F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1642112F582;
	Fri, 19 Apr 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFj3WBfa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99558184E
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540446; cv=none; b=cIUNwc9+xhqkw/tbzDsvVYuGEa9Zv8I4YPvp9hTDtuoaCKiuF/FjNyg1726MMhp2o0tQ3KNc8sbpoMIyl+osEQ3v/RFiKDK9oMIgZaFq7uMoyqZ1cb13ZDgxtw/pKOQtNW2dYtEBhsuNZLivYw0NYfbDu+hgmsvmVIxkcAGf1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540446; c=relaxed/simple;
	bh=rAVY71hohbuBigBfS3zL3wrkyROLpCy047K8e1iabnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akEZLhm3hA13gijKLP46trurJkvxMiRbhIvSOA44IPiGtfCeU2uLAAcefXtalSbr243M5uOrhisACmaXYOhDS6ms4Y08182OgCJG+DUu23BwM7xLZUs7hdaU8joAC2iwQG4oGOSToOS00hH8tVKpX4gq4oiUMEZ6gOX4saufMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFj3WBfa; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5176f217b7bso3680592e87.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713540443; x=1714145243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUbUgVG6F7hkzEi3FpMf3Up9tYb8+MaVuUWKdjFrSSc=;
        b=cFj3WBfaCpovX4w5mxgur7pRWDnT5YTmGeAVPw/Sq7EziDjrp7kbxspGybvVRqOClq
         2yobT9LH+cjV3mwt3HXPKLrCcz3vIavWjTz3K8LN1AAMeOmeQ8v+O22LCT/nYw0t/3Ev
         nFC8S082F18f+h8Q4rSEvsatb1P4xDjXN4IEWDzR6KqUMWMEhXFfxfV0b4vEb9XNzCT8
         1WLFz1xDtW4wlwiX46m15psT5/EI00pZZZurdjOzNsLFOBKMsS/wx4Cn6TK48/G7K9XT
         28l2tZ0ZKNkwhPzAcdMaCc5iIXqodz6BdrcSRorQm2z63wwZLLUtMbvv5YO1cmePMJNK
         Sqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540443; x=1714145243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUbUgVG6F7hkzEi3FpMf3Up9tYb8+MaVuUWKdjFrSSc=;
        b=o9wcfPU/sW6IeRhwMtVvOob3700QCpxTs3S781amplwQ9d/Avm6rJgOQTVzx2df5Dz
         TFLXHSWxWZMkay7AfPmXm4wgUfDJ+nyMrtt5VVQdNj3i0MPKBd98y4R7Viaglp276sly
         qcSdZ/pz7LXryHtafXU3MAKLP9aH01wfXcjiXX77YU6nzJlxDd6FRJOPJBc3rg4Ceri4
         beZNJUTnL+KHGbdhTuvHm7AvDEmVBy+wEZqcPilJ5uyO58vMX7n95IvoJuFc344pMu2J
         wHokDANqPj+0+1f7QQZfyTBcxklD+seqDi8Y4n/RBJpgVhLWgMYoseNNrLXDqbfv1X8I
         ViIQ==
X-Gm-Message-State: AOJu0YzuIswGcuocpJXuORltNsZEr5Rb976GkHZ9YVxnyRtIVdJ/pTqv
	3wZkdB1cKotXLOrdaNXSDqEsiOwYPZay3DkNBMh+iIc3j3KCUfCg8NPN4/ORUeo=
X-Google-Smtp-Source: AGHT+IEM8Rr653o2wp736eGETtzrUx5KrTxqopp1jPyrkDPE0qiU6QW7Cs/z9nhFaFc1HUVwCa350w==
X-Received: by 2002:ac2:4e4f:0:b0:519:7041:d18a with SMTP id f15-20020ac24e4f000000b005197041d18amr1778474lfr.4.1713540442207;
        Fri, 19 Apr 2024 08:27:22 -0700 (PDT)
Received: from [192.168.5.235] ([109.195.103.195])
        by smtp.gmail.com with ESMTPSA id y6-20020ac255a6000000b00518e2db591asm753318lfg.286.2024.04.19.08.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 08:27:21 -0700 (PDT)
Message-ID: <da77921d-37eb-4116-91d3-80aa592e76da@gmail.com>
Date: Fri, 19 Apr 2024 20:27:20 +0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: support request: btrfs df reports drive is out of space, cannot
 find what occupies it
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <b996820e-efa5-4fb5-ba4e-57cc295c1b64@gmail.com>
 <CAA91j0VmxAE=XmCPJwT9m6YXKJzDKtP-+vpcTXbp=_=fROyqnA@mail.gmail.com>
 <0d65236f-184c-48fe-8789-32c41732eae7@gmail.com>
 <CAA91j0WFKw_TZMLN=3NhdtnjNx5g6rcbM+gGVF+BGOKhG6-SxQ@mail.gmail.com>
Content-Language: en-GB
From: Skirnir Torvaldsson <skirnir.torvaldsson@gmail.com>
In-Reply-To: <CAA91j0WFKw_TZMLN=3NhdtnjNx5g6rcbM+gGVF+BGOKhG6-SxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> On Fri, Apr 19, 2024 at 4:18 PM Skirnir Torvaldsson
> <skirnir.torvaldsson@gmail.com> wrote:
>> With all due respect, 38G is a grand total, so it is 38G out of 78G
>> reported data.
>> There is one thing I've noticed that troubles me:
>>
>> root@next:/home/support/btrfs-list-2.3# ./btrfs-list
>> NAME                      TYPE    REFER     EXCL  MOUNTPOINT
>> NEXT_ROOTFS                 fs       -    78.37G (single/dup,
>> 15.03G/95.46G free, 15.74%)
>>      [main]              mainvol   16.00k   16.00k /
>>      @System              subvol   16.00k   16.00k /.snapshots
>>      @Logs                subvol   16.00k   16.00k /next/logs/.snapshots
>>      @Logs/current        subvol    4.70G    4.70G /next/logs
>>      @AppData             subvol   16.00k   16.00k /next/appdata/.snapshots
>>      @AppData/current     subvol  370.14M  370.14M /next/appdata
>>      @AppData/var         subvol   16.00k   16.00k
>>      @Databases           subvol   16.00k   16.00k /next/databases/.snapshots
>>      @Databases/current   subvol  754.95M  754.95M /next/databases
>>      @MessageBus          subvol   16.00k   16.00k /next/mbus/.snapshots
>>      @MessageBus/current  subvol   67.70G   67.70G /next/mbus
>>      @Updates             subvol   16.00k   16.00k /next/updates/.snapshots
>>      @Updates/current     subvol    1.81G    1.81G /next/updates
>>      @SystemData          subvol   16.00k   16.00k
>> /next/systemdata/.snapshots
>>      @SystemData/current  subvol    1.21G    1.21G /next/systemdata
>>      @System/prev         subvol    1.48G    1.48G
>>      @System/current      subvol  443.27M  443.27M /
>> root@next:/home/support/btrfs-list-2.3# du -hd1 /next/mbus
>> 0       /next/mbus/.snapshots
>> 1.4G    /next/mbus/redpanda
>> 1.4G    /next/mbus
>>
>> So, the MessageBus subvolume is occupying 67Gb (?), however I fail to
>> understand how come this space is not accounted for by du and how I can
>> clean it and limit it in future.
>>
> Could be variation of
>
> https://lore.kernel.org/linux-btrfs/0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org/

Thank you so much, this seems to be my case:

root@next:/next/mbus/redpanda/data# compsize .
Processed 3490 files, 3489 regular extents (3489 refs), 1 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       99%       67G          67G         209M
none       100%       67G          67G         177M
zstd         8%           4.0K          48K          48K
prealloc   100%       32M          32M          31M

And these 67Gb of data are reported as "unreachable" by btdu. However, 
manual defragmentation has no effect.  Is there anything else I could 
try short of deleting these files completely?

>
>
>>> On Fri, Apr 19, 2024 at 11:40 AM Skirnir Torvaldsson
>>> <skirnir.torvaldsson@gmail.com> wrote:
>>>> Dear btrfs experts,
>>>>
>>>> Could you please help me sort out the following situation:
>>>>
>>>> btrfs df reports my 100Gb device is almost out of space (which agrees with the results produced by the standard "df"):
>>>>
>>>> root@next:/home/support# btrfs fi df /
>>>> Data, single: total=82.00GiB, used=78.23GiB
>>>> System, DUP: total=32.00MiB, used=16.00KiB
>>>> Metadata, DUP: total=1.00GiB, used=153.70MiB
>>>> GlobalReserve, single: total=68.45MiB, used=0.00B
>>>> root@next:/home/support# df -h /
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/sda3        96G   79G   16G  84% /
>>>>
>>>> However  when I try to locate files to delete with du that's what I get:
>>>>
>>>> root@next:/home/support# du -hd1 /
>>>> 70M     /boot
>>>> 0       /dev
>>>> 2.2G    /.snapshots
>>>> 14M     /bin
>>>> 4.5M    /etc
>>>> 2.5M    /home
>>>> 348M    /lib
>>>> 4.0K    /lib64
>>>> 0       /media
>>>> 0       /mnt
>>>> 0       /opt
>>>> 0       /proc
>>>> 40K     /root
>>>> 2.7M    /run
>>>> 12M     /sbin
>>>> 0       /srv
>>>> 0       /sys
>>>> 0       /tmp
>>>> 566M    /usr
>>>> 5.0G    /var
>>>> 29G     /next
>>>> 38G     /
>>>>
>>>> I.e. almost 40Gb just gone somewhere.
>>> Huh?
>>>
>>> 2.2G + 5.0G + 29G + 38G == 75.2G out of 78G reported for DATA. What
>>> 40G are you talking about?
>>>
>>> If you have some other mount points, you could start with explaining
>>> your storage layout first.
>>>
>>>> Am I doing something wrong? Is there a problem or a piece of theory I'm missing? Kindly advice.
>>>>
>>>> +++++++++++++++++++++++++++++++++++++
>>>> root@next:~#  uname -a
>>>> Linux next 5.10.0-28-amd64 #1 SMP Debian 5.10.209-2 (2024-01-31) x86_64 GNU/Linux
>>>> root@next:~#  btrfs --version
>>>> btrfs-progs v5.10.1
>>>> root@next:~#  btrfs fi show
>>>> Label: 'NEXT_ROOTFS'  uuid: abc71bdb-c570-461d-a28a-54294a646089
>>>>           Total devices 1 FS bytes used 78.37GiB
>>>>           devid    1 size 95.46GiB used 84.06GiB path /dev/sda3
>>>>
>>>> root@next:~#  btrfs fi df /
>>>> Data, single: total=82.00GiB, used=78.22GiB
>>>> System, DUP: total=32.00MiB, used=16.00KiB
>>>> Metadata, DUP: total=1.00GiB, used=153.64MiB
>>>> GlobalReserve, single: total=68.45MiB, used=0.00B
>>>>


