Return-Path: <linux-btrfs+bounces-1286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F22B826343
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 08:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D399A1F21C42
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326FC12B70;
	Sun,  7 Jan 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghgalnf/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB56812B61
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Jan 2024 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e6c0c0c6bso150801e87.0
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Jan 2024 23:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704611997; x=1705216797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kCmQg8UQqoBSiGsRF19ZeLjz8kWJA2QnkhoYGGzhRM=;
        b=ghgalnf/hIXajnsbTkAnH83q1St5qVuFxHQM9OfMQuFFxvfFUicF56fb1gTScjvZy9
         dV0euLSoFOLkmzX3wbGkgMiFc/IRq/82FlFy1euSiPFxTMPiaPZON34Vup4R6lVJoRj3
         9qKUfua1HUAv1uatg2NTccxuvrujzUFR3H/1gVch6Afa5GBsGIqPpQjA8DAGAk3k6mAN
         J+u5xwu7CnRsbIk81Eys+fkP//VJtoJx702LjSqvkR2cskopJYMGxQnX3BVNi2Ls+0JT
         nN6o+gpZPGM1XpxvKPGBWulZoo2koCt1MMH0HecOb8UTaPt9ueY9iHWZrOAd0Q5pj7aA
         Nj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704611997; x=1705216797;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kCmQg8UQqoBSiGsRF19ZeLjz8kWJA2QnkhoYGGzhRM=;
        b=wPFgaFaBeL6weNFQgfrGUqNQ8qb3Wn79i5AysnqC7QnY13/rITKzbKxEwzEtUmWIMQ
         yRBKncs+/Tq/u3LeeMKA3B1w7K+YRs6wcEoU9McAz4/eZOcXFbm4coHr2u1+gFyqr2u+
         SSIC3vsnrUmMo/3XxvIlupqkD48emhkl9asQSW4ciCojF63MaMSDRWE+lvTqse7/T0lT
         Vg1tdQyJN4zD5Cgtwa9N1zCV7+ebmlTBK9vbc/hIsbj9knvXP0DVT4bai+cUt5lonuzo
         otFyGfWoUMfUxeYpKqMvAGzpXE8/U50JptEcNPuNfG6Q/tZEnOVgcaZ/QH0Xwtfymr5m
         ePBw==
X-Gm-Message-State: AOJu0YxMap0b9gIeo+DUrz6LaC3k6sPmVvC/CToIX5V2JtgUil1sWXCz
	0fpzFIrFpiFFwLgHdTZTxIDt+iZDhYs=
X-Google-Smtp-Source: AGHT+IHoZbMwiMb1sCJkccpvoi0dd6XZvnCKjNgGnD7QhjWo2pFMRqvA/jxuyrg8vo14F8BEM1fL5A==
X-Received: by 2002:a05:6512:3ba1:b0:50e:b2ba:15d with SMTP id g33-20020a0565123ba100b0050eb2ba015dmr1803621lfv.1.1704611996522;
        Sat, 06 Jan 2024 23:19:56 -0800 (PST)
Received: from [192.168.1.109] ([176.124.146.164])
        by smtp.gmail.com with ESMTPSA id j10-20020a2e824a000000b002ccc6f06e2dsm957155ljh.128.2024.01.06.23.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 23:19:56 -0800 (PST)
Message-ID: <de1e4749-c265-496b-956d-6ab8e56af7d0@gmail.com>
Date: Sun, 7 Jan 2024 10:19:53 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using send/receive to keep two rootfs-partitions in sync fails
 with "ERROR: snapshot: cannot find parent subvolume"
Content-Language: en-US, ru-RU
To: Clemens Eisserer <linuxhippy@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.01.2024 10:06, Clemens Eisserer wrote:
> Hi,
> 
> I would like to use send/receive to keep two root-filesystems in sync,
> as I've been using it for years now for backups where it really does
> wonders (thanks a lot!).
> 
> Both disks contain a read-only snapshot which is kept in-sync between
> the filesystems (int and ext are the mountpoints of the two disks,
> original_disk is just used for initial data):
>     btrfs send original_disk/root-ro | btrfs receive int/ #send
> snapshot of the original disk to the first of the two filesystens
> (disk "int")
>     btrfs send int/root-ro | btrfs receive ext/ #now replicate the same
> to disk "ext"
> so both disks start with a snapshot "root-ro" with equal content.
> 
> in case I would like to work with one of the two disks, I create a rw
> snapshot based no root-ro:
>    btrfs sub snap ext/root-ro ext/root-rw
> 
>    touch ext/root-wr/create-a-new-file # perform some modifications
> 

There was no "root-wr" before.

> once modifications in root-rw are done, the following steps are
> performed to sync the filesystems:
>    btrfs sub snap -r ext/root-rw ext/root-ro-new #create a root-ro-new
> read-only snapshot based on the rw-snapshot with modfications (so it
> can be used with btrfs send)
>    btrfs send -p ext/root-ro extern/root-ro-new | btrfs receive int/
> #send root-ro-new to "int" filesystem

There was no "extern" before.

Never describe computer commands. Copy and paste them in full with 
complete output.

>    btrfs sub del ext/root-ro # delete the original root-ro snapshot, as
> it is no longer needed for differential btrfs send
>    mv ext/root-ro-new ext/root-ro #rename root-ro-new to root-ro, as
> this is the current state of the other (int) filesystem
>    btrfs sub del int/root-ro # delete root-ro in "int" too, as it is no
> longer needed for differential btrfs receive
>    mv int/root-ro-new int/root-ro #rename root-ro-new to root-ro
>    btrfs sub snap int/root-ro int/root-rw # create a working copy of
> root-ro which is writeable
> 
> this works great - i can add/modify files in one root-rw folder, call
> the synchronization script and everything is found on the other
> filesystem.
> When exchanging int and ext in the script above it actually works in
> both directions, so this is exactly what I was hoping to achieve.
> Even when executing the script multiple times int->ext, ext->int,
> int->ext ... with modifications in between, everything works as
> expected.
> Awesome :)
> 
> However, when actually using the file-systems as rootfs, this seem to
> break when performing the following steps:
> - create rw snapshot of root-ro on disk "ext": btrfs sub snap
> ext/root-ro ext/root-rw
> - boot the system with rootfs=ext-uuid and rootflags=subvol=/root-rw
> (etc/fstab was adapted accordingly)
> - use the system, modify file system etc and shutdown again
> - start separate system to synchronize disks (not based on int or ext
> rootfs) and call sync script ext->int (shown above)
> 

It is absolutely unclear what it means. As mentioned, provide full 
transcript of your actions as well as the output of

btrfs subvolume list -pqu /mount-point

for all filesystems involved in these commands.

> it now suddenly fails at btrfs receive with:
> btrfs send -p ext/root-ro ext/root-ro-new | btrfs receive intern/
> ERROR: snapshot: cannot find parent subvolume
> 4ed11491-7563-fb49-99e7-86cb47cfb510
> 
> which I, to be honest, don't understand.
> Exactly the same sequence of commands worked multiple times when the
> root-rw snapshot was not booted from but modified directly on the sync
> system, even with umounts between modification & send/receive.
> Does it make a difference for btrfs if it is used as rootfs vs normal
> writeable mount?
> Or does it just work in the non-boot case because of some side-effects?
> 
> Thanks & best regards, Clemens
> 


