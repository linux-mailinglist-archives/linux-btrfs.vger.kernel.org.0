Return-Path: <linux-btrfs+bounces-15652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD85DB0FEC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 04:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8717A43E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 02:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758121A08A3;
	Thu, 24 Jul 2025 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR8B5rMw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F563F9D2
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Jul 2025 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753323894; cv=none; b=ncZomW2kkTSJRcn68oooQWzz24/o25tnCJwHYlkpvB79Sdkz231oQ3LnfpiIM3HTaAu3DWzwi+JPNLzXP/iUCHTw+P6NKPiKKwUVg5jCuqT3lQR2XNmXqYZ7JIoxY7LnxUXgyQqS9v0Wt/skotrF1une+AO+ZYGQU/3PgDCm5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753323894; c=relaxed/simple;
	bh=8BEV+WTtJ8yzePM1xSNQZ0Et6+UV5LprhJM3Wx4sAfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoVodof45abkTIWZ2hHI6AeqVU8N+gAj6CP7yvUkALqViEFZaYpnWtagYC0Eo5IwHu+/AdFCBds7V84/6ID9PxOMNWKiXdxKaqNpPbhKa/LNzNG11n8U7JDSEJXFaiqM9devnHZgKyExBu9MEOaTYfzAVXSD0sZypEPcdgyVvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR8B5rMw; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2ea34731c5dso468676fac.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 19:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753323892; x=1753928692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHkLeMISlUUzeFK1jHYRGmYNBbAdnPtZhWK6VtRcwr4=;
        b=gR8B5rMwNjOEQG0JvCRuVdo6ruwZJnsECfmcdIa7xP+lKx9Xy+lXDCAy9KA2ApZDjT
         z1zNZEFCcH3hbNHuQ9WXidA4SUuuMZ0x/JjF4M9+GfwSTB8UwskWQDYOH1Vk5Jp8Kk+8
         3MLnpwdTBUPpcbIVBexgy6Yc3E7WWpdDVEPyZMbORLfAtCKQCR2DSGVn2uZ4AFTUiQvF
         uPToDgvgi7ZLK/NxCG9LS5LJLyaKMHuY0PFIHM7bgtL+sgHgJCO9IscNWP7kMoEH8OEi
         KxBC7IYnCNh2LIb20PpulnTKqibwPCs355TKCJeC8PRn8kA+7siIO2o5VaZ/dsthu2nH
         IXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753323892; x=1753928692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHkLeMISlUUzeFK1jHYRGmYNBbAdnPtZhWK6VtRcwr4=;
        b=LfurohIHqMDA1lNCZmParOrvecRGRQCTz5S0pzjI6jQOaj55xlONVTJCemgDLVONnM
         t56/3kXaHtY+gqdV19mJKFFf63haF6FU4Dbc/9+sex+OQTPgX7I3/j/+c9jRCWAUoyyD
         NuGcquD6CygXs922VsG3EcBCWtXD+zQP8uBw1R8dD4dAQ/fEF8XWGOe0a2y3ndbeM0tM
         cvGcrj/zmMyPJeSahez1BsTA2QhMIZViIvkD1AFvDRdDaQoO73wD+QOTbbZ1o+n5LYCc
         hbfgUhFCGR+jprr7d9Nx5p/N11t9Way3xm77QwjHXgqZVGCjQrVhMVZSlWFDLIplCdPe
         Uflw==
X-Forwarded-Encrypted: i=1; AJvYcCWD+Bk93xPe36NEPhAY6gRZLqKURTc/FuPLoCVaQQAAzDuV2wC1Bq8+iNcwtpQdvJ0Jrw7TokdmKFv5Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwuMlG+MtSyehd2KoU084L1afClvyPbovPlag07Xz4X4VAGZt
	yhQ7tT/7cduMPb/xe7adDE8S21tepui1smP7AmhWEXZJDTPcDMNKcaXR
X-Gm-Gg: ASbGnctmJ2xF6AAkHuSetZ7FVUOxkqN945/JcoHoAsk07egz4jsfjKWt7J/5oemNeci
	ZEYuav7zVL5ccojynODeGemsFAIKB2ahJ/xJifl0rSw0abKaywgt/lstUM84SssfdO5DmKr5PJj
	Xu7/q+yFIKTG5L3k4ug1odan6W4eaxwZofWeKyTLGPaRFW9QjSojxdavAIhlq4dOVvpYaEeS3DX
	jkABlsSeImqdfDJgGcfwMOi3NmDElVUVzLCnOEdOQgmkNGgRMUDJuS4NzUENfhKRmLuguDwt/H5
	+S/oq5YXQXAxITT1y1xhR/kf/HWvOny4ADMQCSqWaM5ZOFS4C3gsYT21h7xZXB0h+UenGEo01oG
	xVoZ4vT5AYNLneUK7P3H0tpvCHGe7Wcox7BIJtQ==
X-Google-Smtp-Source: AGHT+IFaFvnQYsSrI9NKVnf2X1szndCoP6n7LJBTCa9Vbo1PB0C2OELPfONm2ielVxzOqnlEwppWYA==
X-Received: by 2002:a05:6870:9a1e:b0:2e8:797b:bf23 with SMTP id 586e51a60fabf-306c726efc4mr3177091fac.21.1753323891914;
        Wed, 23 Jul 2025 19:24:51 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-306e1f19f1bsm191826fac.33.2025.07.23.19.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 19:24:51 -0700 (PDT)
Message-ID: <23b4beab-e33e-4a3b-93d6-8ebeb2a881b9@gmail.com>
Date: Wed, 23 Jul 2025 21:24:50 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Increased reports since 6.15.3 of corruption within the log tree
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Peter Jung <ptr1337@cachyos.org>,
 linux-btrfs@vger.kernel.org, dave@jikos.cz,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dnaim@cachyos.org
References: <fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org>
 <a6f03aff-c9fc-4e7f-b1fb-42d6a4cd770a@gmx.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <a6f03aff-c9fc-4e7f-b1fb-42d6a4cd770a@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/7/25 6:00 AM, Qu Wenruo wrote:
> 
> 
> 在 2025/7/7 20:16, Peter Jung 写道:
>> Hi all,
>>
>> There has been increased reports of users reporting that they could
>> not boot into their system anymore - sometimes after a needed force
>> shutdown, but also according the users after a normal shutdown/reboot
>> process.
>>
>> The filesystem can be accessible again, after running following
>> command in the chroot:
>>
>> ```
>> sudo btrfs rescue zero-log /dev/sdX
>> ```
>>
>> There is no way to reproduce this constantly.
>>
>> Following commits did land in 6.15.3:
>>
>> btrfs: exit after state insertion failure at btrfs_convert_extent_bit()
>> btrfs: exit after state split error at set_extent_bit()
>> btrfs: fix fsync of files with no hard links not persisting deletion
>> btrfs: fix invalid data space release when truncating block in NOCOW mode
>> btrfs: fix wrong start offset for delalloc space release during mmap
>> write
>> btrfs: scrub: fix a wrong error type when metadata bytenr mismatches
>> btrfs: scrub: update device stats when an error is detected
>>
>> Some reports:
>> https://discussion.fedoraproject.org/t/fedora-kde-no-longer-booting-
>> likely-filesystem-btrfs-corruption/157232/10
>> https://www.reddit.com/r/cachyos/comments/1lmzmm4/
>> failed_to_mount_on_real_rooted/
>> https://www.reddit.com/r/cachyos/comments/1llin1n/
>> error_failed_to_mount_uuid_on_real_root_cant_boot/
>> https://www.reddit.com/r/cachyos/comments/1llrpcb/
>> unable_to_boot_os_you_are_in_emergency_mode/
>> https://www.reddit.com/r/cachyos/comments/1lr5nro/my_cachyos_is_down/
> 
> Unfortunately none of those comment is helpful.
> 
> They do not provide the dmesg of the mount failure, and that's the most
> important info.
> 
> If you got any new reports, please ask for the dmesg of inside the
> emergency shell.

I think this is likely the same problem I ran into[1], and I collected
dmesg and a dump of TREE_LOG in the bad state.

[1]
https://lore.kernel.org/linux-btrfs/598ecc75-eb80-41b3-83c2-f2317fbb9864@gmail.com/

Thanks,

Russell


