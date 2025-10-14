Return-Path: <linux-btrfs+bounces-17764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 170D3BD76A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 07:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9362B3ACEA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 05:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B029AAFA;
	Tue, 14 Oct 2025 05:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TMa9tT67"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5EA264A8D
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419573; cv=none; b=XjcnONU5xRm+KN0quk9sjJVmUbw25U0+5e7gJkFcUsexlcsRox89F7EVUGanYnBGgR9ahyZa8+1zrNnQ8LJp3Yu/u8TgHeJT/NSA5OZTD21cue9g0KoB92l9TXlquRnjlJpIJBKWK0F1bqMk3ZlLzpAzLd1vILSEVodmH2/UTCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419573; c=relaxed/simple;
	bh=RzZ2rpgYX4TU7MT3Xglqz4bP41cT5Oh6ggAKNbiU4Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPaABEJ5vvCZTI/04pnQZdQIt/cMZ03h1f3HX+72B2nAg4Hpe8bkOUp3aGaqsUE/MwbQ7pMJx5yFNNilRk4bRjW+dNCgSkQga7sNDvfIR0vs46Mpy6UBINr+IdlE7mFWfzeKBWZFCmnp2g59o9NNEOhrFjpFToGej26FbLBvNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TMa9tT67; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4060b4b1200so3648522f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760419568; x=1761024368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PJeA08PmXO0Rt+J6zqTRksSe9Q2LhvStVnJgFH8knlE=;
        b=TMa9tT67BZUz1dqoyEp7c7boJbzouJq/CFRT9LOK/U9xCWA5vMvOBkUMWgn1smAdp2
         Brts+rKceBUpEtfxGyevkKllE57ptajVK/Eu+A8iHkucCdATPSb7WIDXOtz6HOW+wi8c
         b1G1G1SGA/0IJoBMYoH4XBtKaYKWhWcsl9aYGRNKlerxCDvmJYHTMEreFgZEsBR8Pczy
         DqEx2WUacQh4R5Seu9dNoTTBFl7ELoBSytZUQrIisqCRVSA365p2yHsi0zsaQBMQuVbb
         E3kJOKe+LmCfVnqJnKd7m34sLRZxcDWH0bJ10MP4uqwq0ZluEixXFBM1cuY/BJQNMCc+
         o85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419568; x=1761024368;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJeA08PmXO0Rt+J6zqTRksSe9Q2LhvStVnJgFH8knlE=;
        b=puBryvqSjaW60ZgGF6S7z1orTfjcE6vGHLgWRB9rTNFYCSMPqDEUQr75nQqy2FRJW8
         Nd2jWw/AtzvWnE+orrEo5hneidoPzlUVc8njif/wAkrvoI8fm+F70sFbk6XMZh6ioPWs
         dU/M5CHU7TeW94EW6R5/9TjCHo4xubAtXlerUIpmLpf1b2JO1WOKk8zo3gHlbrbZyPgp
         MNM12qgwKw36tF3cbTUFh04VsqHCesRmh1wlo3rZ3VC7uPTZxie+4/1Yp8JlCrTbfba8
         BaH3FM8uT2K3o+zcZX1bnqOqNP80aF9YJhvTqVSE9VvU35TUOB6ITMc7KXRLEiklscK7
         sgfg==
X-Forwarded-Encrypted: i=1; AJvYcCXe9Jn8Wo2QziupdHusZj3HvqD0GDgpUe6Pjej/ooyfhliN0LEGga40twIA0tBulqeCmd2kpBM/o2o3RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytETUWoCCnV2zt6F5WHWuG/diPn9sv8mGcqCcYf7iHDKFsADB2
	kXreaP9TVSavNlnE7jGNkfylqFc6S4llsnyRhy1hOVUUzbA4ch5cLw1zsPM6a7um4/g=
X-Gm-Gg: ASbGnctn7bzn4O8TfPj+ezW2+tC7OILsBNABSAYpDZJwbteJECbAt6wZ05ZgPzVkoMr
	BsvKO64KNpt8sidYEwoFmDE+3DInlWE/S9rIp7eBqygo/lLCwA6rB0LUHU520lAaX8WVAkDvjd+
	8X1Ev0gYMsJMCP5heciAHtZgVx/CVcACMo3jNXoaLvW5Hzv+zz/VP2+7ZhB3hoi2hUV4MFGnF1S
	aWyZOcYBo3U/I/paZWwm3w3Y+GVjEfHyCyICJ0oRR3X3GG/tcPEHjZ1Y6tw9PhiqGmKfzAjkcOC
	c66LA5EkN0PmTWHB0cACPXJ5/BJW4bnD0HnjgU4M1C66gKCty5TVXlAyPz5NDIZ5D5vHu5UfgKd
	/u61h7OB9Dm3EzPEMPun70d8sdtOGWmpH5FFQaGnVsLwNmoAgdR5EASbtQ5lFbJ4jkQUB/FBbFD
	51utgt
X-Google-Smtp-Source: AGHT+IGrGpGhcI95c5DMP672QlHISusRMmNdSZjfnjcUd//Uku5n9Mpyuwa8gnooQRqjnAoP2rIKaA==
X-Received: by 2002:a05:6000:2505:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-42672425b82mr14532469f8f.47.1760419567943;
        Mon, 13 Oct 2025 22:26:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c14sm151516595ad.6.2025.10.13.22.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 22:26:07 -0700 (PDT)
Message-ID: <f6d30bb5-8e0e-4351-a11f-4a78f7a541e7@suse.com>
Date: Tue, 14 Oct 2025 15:56:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl
 index=on
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20251014015707.129013-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/14 12:27, André Almeida 写道:
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

Yep, that's the btrfs' hack to allowing mounting cloned devices (as long 
as they are all single-device only btrfs)

Although I'm not a huge fan for that, without that you can not even 
mount any cloned btrfs in the first place.

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

Or, let btrfs to reject the cloned device in the first place.

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

If you really want to use the same copied fs, at least you can use
`btrfstune -m disk2.img` to change it to a new metadata uuid (without 
re-writing all metadata).

Then everything should work.

Thanks,
Qu
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


