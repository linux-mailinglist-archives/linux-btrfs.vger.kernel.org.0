Return-Path: <linux-btrfs+bounces-17789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F8BDB8F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 00:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1DC18A78F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 22:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287D30DD26;
	Tue, 14 Oct 2025 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuXT4COZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9C306B39
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479467; cv=none; b=HXOHK8wXHzomvXhNYqOsomrNm4QnL7p3Re3pyUfvVWSoBApLYaQ7oAPiJsXauOvt8xW0XLwmdC4JT2fqTXaXwdhYq9xuawLY6O+8NKHY/XZDE9PtY+1elOfF/mHjD/35lu1Rqn4aAPIeUYinup45oskgbuM7f2VJKWBbZg+upJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479467; c=relaxed/simple;
	bh=pG515i7syHG3vED4MTNqB/DberSEKkguAtEkJvVagCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVV6DhKMM8Oz80/bIeao3BlOurwWaIGs2QFF5hsC7UKkDWMnX9Y0p8+5JGJ2blpfSpZvV2ZmGS3ITQTNO9lPamdzC0ZWAnhXNyCon0YERujKCWipBCZ80vhtsC1CALIPttr+wJ9nzCSc0MvGIk+i1Cu8mZEf51+JRF5JuFysn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuXT4COZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso6270173a91.0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 15:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760479465; x=1761084265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6XDsENWGoamE2lQfBoeAOTQv2/NbQK1cLV8RQTx+rU=;
        b=BuXT4COZt833j/MT8p8ax319LGdRXi0b/KO67c7Av6vdB9shb0wEtOhRxuuZN0iHrr
         J1bcKGTvyVVFMRuKd5Vy28WN1lebSZeI3E8/nKnN1WKAq/m1E4mF2qIY+2ZWRqcB5gsO
         9WLm0ODXxFQHclwoGz2JKNAeJ/b1hnONmz6nNHFH/t6Dc0gUX6C7blz9QA1NuyZWqYFw
         spZ/RqlVAD4fyQ5eIajKbWdkEC/EUpesN95yRprQoI5ZOgfVBBeHWA6FuITANN+pV1Mk
         2mJLz90hX+MJ2He1mWtIqxbGDsD1HRD4CC/c8RvD9aIAPKGScUyY7qMVoJ+OT40Rkhwz
         Dyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479465; x=1761084265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6XDsENWGoamE2lQfBoeAOTQv2/NbQK1cLV8RQTx+rU=;
        b=sr4tYlY8cuzgd/IpFbtnkMnUNFgHDQ8EOfiB1VrT50mhs9bjRbcy0XjCb1doDl6205
         exV71nutAZ8GRpY1xsSfi33Y1sgKMALscXXKGN++S8z4PT86NRwcHkdB8fA9ySyeBXcD
         wa1YQOK3Q6673Sxcq4S61ZrOVX7NXjY4wsAAb9xpEBLY52CNV7X+4vw56XPw+PQH9lze
         OKYzQpy4igUae6bz7VDnnLMXyG1gI7AuMoOe6szFd3P95vnQv7KwalfoGD6jOtIlOHTD
         9cii1CnQ15Ns+8SHuTQ5LDF7hi0jWDZpfvcvNC42iN4sRP1g95b77X39vcfHm3lqxGqF
         sOng==
X-Forwarded-Encrypted: i=1; AJvYcCXHeG+kJgXmoorp59Y2Lx+SDhgCzYNjt4Vk0Rtg7j2OVgqlHdUAQWxrNKxdO/JQ9c8W8Tdx+/HrQzVMRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YznmKCYG57w0YxAJg9c8A7iQYFKvZHdTM5PWqIdSxUhjsosErEG
	6ZQRZXfBDpM8qOe6gnSKujUler7ITQXzBN5E1tgqVzz52UAYdiz61AHj
X-Gm-Gg: ASbGncsTXXgIMI3oScyc8LVZDGMZWg1Vt1mBMSwT1XlEjkaE2nSpSfVeOxnOL4LoRWa
	txi0PNb4qq1bAiSvdVcCSI0fAdfQNH6HzPhE4HBJhQpYR6C2Dc2Wi6KX9Vejq2L3m4sdwGzdAoA
	oy1+Sc0yTcyJ2I0veHWbc1piSFIihWS2pB5ehhGOuMowbipHQUc4qX1TQIRXvQi8CetCsIsoazW
	0aDAuGxg+/GRa3yPGQ6uhOLx8olGmCspnLKvmOrgom07rR80IRfRYf21603WsxiWru3sGxasK/s
	XvpatESwcAXqCbCyK/v/Zh9QUwAwTKYhctw62BZhCNY9hZiuGVbRUcblKKV5LRERAoIlKmJSd4f
	gYgHjBP2B57057Z6E8JG5m3fdLo8uec3FXexPrpU1CAO+73/CmSD65JScHOjJ9LXd3+7OUNokRg
	2ru1bZcc1aSScuiPn7rKI6jKaZ
X-Google-Smtp-Source: AGHT+IHUB3rz/slBsn1LJeEC9+FO5BtqHcvv9o2+l1YGXAcHXI2KItjdeh1X4Zw/JN1lCdNJMeKK5A==
X-Received: by 2002:a17:90b:1b41:b0:32e:8c14:5cd2 with SMTP id 98e67ed59e1d1-33b513d0b37mr31894521a91.28.1760479464543;
        Tue, 14 Oct 2025 15:04:24 -0700 (PDT)
Received: from [192.168.50.102] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df7e1d1sm13042068a12.40.2025.10.14.15.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 15:04:24 -0700 (PDT)
Message-ID: <e890fbd0-7b05-47d2-a444-f61409e4bbf5@gmail.com>
Date: Wed, 15 Oct 2025 06:04:18 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl
 index=on
Content-Language: en-GB
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251014015707.129013-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14-Oct-25 9:57 AM, AndrÃ© Almeida wrote:
> Hi everyone,
> 
> When using overlayfs with the mount option index=on, the first time a directory is
> used as upper dir, overlayfs stores in a xattr "overlay.origin" the UUID of the
> filesystem being used in the layers. If the upper dir is reused, overlayfs
> refuses to mount for a different filesystem, by comparing the UUID with what's
> stored at overlay.origin, and it fails with "failed to verify upper root origin"
> on dmesg. Remounting with the very same fs is supported and works fine.
> 
> However, btrfs mounts may have volatiles UUIDs. When mounting the exact same
> disk image with btrfs, a random UUID is assigned for the following disks each
> time they are mounted, stored at temp_fsid and used across the kernel as the
> disk UUID. `btrfs filesystem show` presents that. Calling statfs() however shows
> the original (and duplicated) UUID for all disks.
> 
> This feature doesn't work well with overlayfs with index=on, as when the image
> is mounted a second time, will get a different UUID and ovl will refuse to
> mount, breaking the user expectation that using the same image should work. A
> small script can be find in the end of this cover letter that illustrates this.
> 
>  From this, I can think of some options:
> 
> - Use statfs() internally to always get the fsid, that is persistent. The patch
> here illustrates that approach, but doesn't fully implement it.
> - Create a new sb op, called get_uuid() so the filesystem returns what's
> appropriated.
> - Have a workaround in ovl for btrfs.
> - Document this as unsupported, and userland needs to erase overlay.origin each
> time it wants to remount.
> - If ovl detects that temp_fsid and index are being used at the same time,
> refuses to mount.
> 
> I'm not sure which one would be better here, so I would like to hear some ideas
> on this.
> 
> Thanks!
> 	André
> 
> ---
> 
> To reproduce:
> 
> mkdir -p dir1 dir2
> 
> fallocate -l 300m ./disk1.img
> mkfs.btrfs -q -f ./disk1.img
> 
> # cloning the disks
> cp disk1.img disk2.img
> sudo mount -o loop ./disk1.img dir1
> sudo mount -o loop ./disk2.img dir2
> 
> mkdir -p dir2/lower aux/upper aux/work
> 
> # this works
> sudo mount -t overlay -o lowerdir=dir2/lower,upperdir=aux/upper,workdir=aux/work,userxattr none dir2/lower
> 
> sudo umount dir2/lower
> sudo umount dir2
> 
> sudo mount -o loop ./disk2.img dir2

At this point, Btrfs assigns a new temporary FSID, but without it,
the test case fails.

Temp FSID support only came in with kernel v6.7, so wondering,
how is this test supposed to work on older kernels?

Thanks, Anand


> 
> # this doesn't works
> sudo mount -t overlay -o lowerdir=dir2/lower,upperdir=aux/upper,workdir=aux/work,userxattr none dir2/lower
> 
> André Almeida (1):
>    ovl: Use fsid as unique identifier for trusted origin
> 
>   fs/overlayfs/copy_up.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 


