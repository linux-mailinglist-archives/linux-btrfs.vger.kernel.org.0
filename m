Return-Path: <linux-btrfs+bounces-7794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E4196A53E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 19:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282A42862B7
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A93518890A;
	Tue,  3 Sep 2024 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrhvLR63"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341818DF91
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383803; cv=none; b=hr7mSPd40mulJgiUcRjUdQs0CZ6qngaJQX1TXGpgLFdqdOOpEOwbN648jSYc6j8dqUjjtyYrKooSPeNUcy5fywoX2HAtZXFup6bulsDziwJxmmYfHF7qq3pz5SISj+XHJE/7pttDGGQnLAGJmxNYUVrmO8htAD8nkPNj2FYnA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383803; c=relaxed/simple;
	bh=Pc2WgHICZ1AqeBVgRGBbJP1LoO8KjjYbBUD1uoixRX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xh3pSvDgm01pVsnq8RsaYN+034znmafaFLwoFU+I3+KvnmHl8xlXcRtSFJ5XGzvlUGfEwt02uKBejZVQopkrEkfjCOAzzej5dt9fTRs+CXKmR+nDwoNgP/vreGXQ3unDhZxFXxXFxVas8QzxPCrkrq3hhbZr6NxbTPGkfmTHzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrhvLR63; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53438aa64a4so6812126e87.3
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725383799; x=1725988599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0nK7hl/Y2/gKNrwI3qb2pwJBGY11PXu4h1Fw3L5pzH0=;
        b=mrhvLR63B+RkVv9gPgJJoM+eV/xKTOiJUX9IQASzJmsy1DqcXgpnHuj2R3WL8KlrvH
         FzB0srNWgQ/yZ5nAulG1HVS3yWbltmtKOWziAO9F/6C5wns5nYBsosUqoDbxGAkVI3Hc
         6SQ6LFa4snAlhGxnRbdiZ9NazEx0tD0XHtLGZNN5BZVm7aFzHgHjfHOoCxOT0vvRVaQl
         Qvwwr+wenSOLp9NgIhN4maynkFhlk0LYIwS6DGMF431T23bDOrbh9o2ATINrvtOGhzON
         PDFT8vvs7gDr1Pk74Ntd1MOiZ6kRhFN3deNbk63Y5C9Iw4r+0GLQ7TbDxjvyBTscKl8l
         i2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725383799; x=1725988599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nK7hl/Y2/gKNrwI3qb2pwJBGY11PXu4h1Fw3L5pzH0=;
        b=U/C7MmbObLMolZ4RrCAgUd3Nr6/Gp4yeD2PUjYUgtFRUq+CGlyA7FyjZRToWzeAzSz
         aWnuKkzmrzeAz8GfBteTnpkO5ruLawJfeHfCLT6jM1TGh4DdDU602FmyvdUsTBZqzM14
         EVINgxJdn37+9X4uF5dHppuEBJPr69T51kqM9eO20rih+mkWPYOkAFvYeIJBzLvb3FOf
         mNllioHItXRdsHFrW1KF7WyXLFnu+Ww6ZEQPqJqrq+tfsDkDIria855xFoGKYuijnNhA
         flQpTphrBi0plQkdIYz2wr/kCUUSjRs1nlKBE7F8T7aYQg7WSVzEyc/1nxXtKxoYpOp9
         mQyg==
X-Gm-Message-State: AOJu0Yzsk7Er3EUl33qQHYQM1EFHsg6UznqIc3eTAY6qasscOZO2SKKd
	0eKdwPeooktxEscB9/iEUzifAq6PsOfhoig+2/dvkz39zlzQVQH4KrVbPw==
X-Google-Smtp-Source: AGHT+IGlSGXfdXymMF6cvids38iQ3dnOAEiskv7LpdHdPF7E+azAQNxXrfwUKsLQLhUjPlkDSgyt9A==
X-Received: by 2002:a05:6512:1313:b0:532:c197:393e with SMTP id 2adb3069b0e04-53546af510fmr10368991e87.11.1725383798379;
        Tue, 03 Sep 2024 10:16:38 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:371b:e6d6:beb5:5b76:a255? ([2a00:1370:8180:371b:e6d6:beb5:5b76:a255])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079ba89sm2144693e87.13.2024.09.03.10.16.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 10:16:37 -0700 (PDT)
Message-ID: <02068ec1-efaf-494b-8b05-fe1ccd83924a@gmail.com>
Date: Tue, 3 Sep 2024 20:16:33 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: how to delete a (hidden) snapshot from timeshift?
To: linux-btrfs@vger.kernel.org
References: <20240903132316.GA20488@tik.uni-stuttgart.de>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <20240903132316.GA20488@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.2024 16:23, Ulli Horlacher wrote:
> 
> I have upgraded Mint 21 to Mint 22 with "mintupgrade" (Ubuntu 22 based).
> This calls timeshift and creates a btrfs snapshot which I wanted to delete
> afterwards:
> 
> root@mux21:~# btrfs subvolume list /
> ID 256 gen 102469 top level 5 path @
> ID 257 gen 102467 top level 5 path @home
> ID 367 gen 102260 top level 256 path local/home
> ID 667 gen 102466 top level 256 path tmp
> ID 682 gen 102445 top level 5 path timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
> 
> root@mux21:~# btrfs subvolume del timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
> ERROR: Could not statfs: No such file or directory
> 
> root@mux21:~# btrfs subvolume del -i 682 timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
> ERROR: Could not open: No such file or directory
> 

The path should be path to the filesystem mount point (probably any 
visible path), not path to the subvolume you are going to delete. The 
latter is given by -i option.

> 
> I have had to mount the / filesystem directly (no subvol) to remove this
> timeshift snapshot:
> 
> root@mux21:~# lshd
> Device    Size Type      Label           Mountpoint
> sda        30G ATA:GPT   "VBOX_HARDDISK"
>   sda1       0G vfat                      /boot/efi
>   sda2       0G BIOS boot
>   sda3      29G btrfs                     /
> 
> root@mux21:~# mount /dev/sda3 /mnt/tmp
> 
> root@mux21:~# l /mnt/tmp/
> dRWX - 2024-06-21 11:45 /mnt/tmp/@
> dRWX - 2024-03-07 13:00 /mnt/tmp/@home
> dRWX - 2024-09-03 13:00 /mnt/tmp/timeshift-btrfs
> 
> root@mux21:~# btrfs subvolume list /mnt/tmp
> ID 256 gen 102473 top level 5 path @
> ID 257 gen 102471 top level 5 path @home
> ID 367 gen 102260 top level 256 path @/local/home
> ID 667 gen 102471 top level 256 path @/tmp
> ID 682 gen 102445 top level 5 path timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
> ID 684 gen 102470 top level 257 path @home/.snapshot/2024-09-03_1500.hourly
> 
> root@mux21:~# btrfs subvolume del /mnt/tmp/timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
> Delete subvolume 682 (no-commit): '/mnt/tmp/timeshift-btrfs/snapshots/2024-09-03_13-00-02/@'
> 
> 
> Is there an easier way to remove hidden snapshots/subvolumes?
> 

What so hard with it? But yes, "btrfs subvolume delete -i" will work 
when used correctly.

