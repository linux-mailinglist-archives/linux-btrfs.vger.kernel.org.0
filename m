Return-Path: <linux-btrfs+bounces-2095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0C848FE9
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 19:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436B9B212D1
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9E424B21;
	Sun,  4 Feb 2024 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IioVwJxt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332624A03;
	Sun,  4 Feb 2024 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707071382; cv=none; b=SmnUtN9Ofe16OhRg7UrpXJXuBCEJBFlVAOPhLQDFmXdOZH70Ho5njCpRmkXTUaveQhxBn1JTJhKWOnh1/5O93urFTJJ7WNeIvf38h1ftZ4pCKWgwN0A16Eu1nZ2Z16eo47uRjRT+JGdQc2ewoKI+XfB4LiRb9W/FML9FdVjm4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707071382; c=relaxed/simple;
	bh=hSrMj/wKl5jffrFRZdmR/3NGB6Wc3DAA5zwdOPruqes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qybli+cETLf9Rjx3rFWWfHM35RoTrBw+nQmgsJfk1OX7BmS+nNjwJqmEPBs0ehyIi4LIVrruZ8oxaTJlhj8dKWbuOMtvDXbe2yRgYZ7N3ra1j5HEGYH7VB+Ihn8iWPJRdLM7tvOqBp1MJ28Sk+M4lbRcpdWVnUPo197fK2yqR8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IioVwJxt; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6d54def6fso3400742276.3;
        Sun, 04 Feb 2024 10:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707071380; x=1707676180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m96LY0uzgcQpdT6g6uTesfbb0UhPXpBOxu8i3g30yqk=;
        b=IioVwJxtjNZOWsfP39gnimUdRZl042hNY0wkR5Eml/4IuTIvW2X2g7jAjZMQDdQhWR
         sHtDc9DpgjgOQmTLLlJSKkrwCwLI+pIvZq5ROn26TJ5eRHuW6bL1UFPvdniiwv8/SJMK
         E26M7r69D8PXL3IfYKxYCLE8wXgT8BZ7dVq1Z7eMcdDcCZU3SBhP4IzD7RcRMxtFh42v
         eAYzGlSeVa1RBzRHZ2Ir4kEIZNwkChwBWvK8nEweSwG7X4EmjlIuo8miCJ2yMTk2NNyt
         kPDKwwQ1FHRJtz1ccd7bnquQs0Ud1nXglTuOx6B/f/ZlWVUfE3mgVcMFlg8Acyi3RfBK
         IUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707071380; x=1707676180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m96LY0uzgcQpdT6g6uTesfbb0UhPXpBOxu8i3g30yqk=;
        b=WOBVGo2R8gVcnoYPDfzpNtfKxK+yEpvDHwA3FG+MHeEStxB7jxAWdd9AIBCzy/4Qnn
         Z9/ZALkaFa0YNcvDSbSbttnATOPKFlfeDy5yXfADQs/9crSQ0pIuwc1RERdKejNz/pKh
         KnhkJOuvw7ZcR/ngZ0BQHb17ZmCrKHKcAuv4BJk/tBWjl7mRAFlI3Hr0ZKiyodshoKth
         ASWJsh0pXUmTe6kLgCo7mLiUP+67MEId4aEMunZG9qXo2ndqHshLmSQxI4g4xUPCddd3
         ehctDoLj6FUd7cRipVV83sDXqfSDA943lAV6s9vHlEpp8pdgXgTr8lGTDibGfEbgYDeq
         QxHA==
X-Gm-Message-State: AOJu0Yzd6nJQwvsOsY8y8Id/YULc1jUZiF5up5g2RO+6y8kGUxD3Lab9
	foUpNVqR0J2FIzlw0mjjRmiI1h3FhA2kRGXC/g6SCP6grRZ8R0Jok3gnOm0l4tpVeY+3GkA3BoB
	VpxrOHRX6UEy9Nx0D482OiSU3EL1yh+K/TLBomg==
X-Google-Smtp-Source: AGHT+IEXCbTvDA0iJAaac8Y5USeXLLy6UhROXRNUCWy/ZNfRAzqhs20pk+lfcfQI+I7p7pEEZBzKucHWWpofhOhAZk4=
X-Received: by 2002:a25:d389:0:b0:dc2:4450:92f2 with SMTP id
 e131-20020a25d389000000b00dc2445092f2mr10449381ybf.22.1707071380099; Sun, 04
 Feb 2024 10:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
 <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info> <20240111155056.GG31555@twin.jikos.cz>
 <20240111170644.GK31555@twin.jikos.cz> <f45e5b7c-4354-87d3-c7f1-d8dd5f4d2abd@oracle.com>
 <7d3cee75-ee74-4348-947a-7e4bce5484b2@leemhuis.info> <CAKLYgeLhcE5+Td9eGKAi0xeXSsom381RxuJgKiQ0+oHDNS_DJA@mail.gmail.com>
In-Reply-To: <CAKLYgeLhcE5+Td9eGKAi0xeXSsom381RxuJgKiQ0+oHDNS_DJA@mail.gmail.com>
From: Alex Romosan <aromosan@gmail.com>
Date: Sun, 4 Feb 2024 19:29:29 +0100
Message-ID: <CAKLYgeKCuDmnuGHuQYPdZZA1_H3s9_9oh+vT_FMpFZqxKSvjzw@mail.gmail.com>
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks update-grub
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Anand Jain <anand.jain@oracle.com>, CHECK_1234543212345@protonmail.com, 
	brauner@kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, dsterba@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sorry about the html post (in case somebody actually got it). as i was
saying, just for the record it's still not fixed in 6.8-rc3. thanks.


On Sun, Feb 4, 2024 at 7:27=E2=80=AFPM Alex Romosan <aromosan@gmail.com> wr=
ote:
>
> just for the record it's still not fixed in 6.8-rc3 (obviously, since i'v=
e been looking at the btrfs patches being applied).
>
> On Thu, Feb 1, 2024 at 11:25=E2=80=AFAM Linux regression tracking (Thorst=
en Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>> for once, to make this easily accessible to everyone.
>>
>> Anand, what's the status wrt to below issue (which afaics seems to
>> affect quite a few people)? Things look stalled, but I might be missing
>> something, that's why I ask for a quick update.
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>> #regzbot poke
>>
>> On 12.01.24 00:24, Anand Jain wrote:
>> > On 11/01/2024 22:36, David Sterba wrote:
>> >> On Thu, Jan 11, 2024 at 04:50:56PM +0100, David Sterba wrote:
>> >>> On Thu, Jan 11, 2024 at 12:45:50PM +0100, Thorsten Leemhuis wrote:
>> >>>>
>> >>>> On 08.01.24 15:11, Alex Romosan wrote:
>> >>>>>
>> >>>>> Running my own compiled kernel without initramfs on a lenovo think=
pad
>> >>>>> x1 carbon gen 7.
>> >>>>>
>> >>>>> Since version 6.7-rc1 i haven't been able to to a grub-update,
>> >>>>>
>> >>>>> instead i get this error:
>> >>>>>
>> >>>>> grub-probe: error: cannot find a device for / (is /dev mounted?) s=
olid
>> >>>>> state drive
>> >>>>>
>> >>>>> 6.6 was the last version that worked.
>> >>>>>
>> >>>>> Today I did a git-bisect between these two versions which identifi=
ed
>> >>>>> commit bc27d6f0aa0e4de184b617aceeaf25818cc646de btrfs: scan but do=
n't
>> >>>>> register device on single device filesystem as the culprit. revert=
ing
>> >>>>> this commit from 6.7 final allowed me to run update-grub again.
>> >>>>>
>> >>>>> not sure if this is the intended behavior or if i'm missing some o=
ther
>> >>>>> kernel options. any help/fixes would be appreciated.
>> >>>>
>> >>>> Thanks for the report. To be sure the issue doesn't fall through th=
e
>> >>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regres=
sion
>> >>>> tracking bot:
>> >>>>
>> >>>> #regzbot ^introduced bc27d6f0aa0e4de184b617aceeaf25818cc646de
>> >>>> #regzbot title btrfs: update-grub broken (cannot find a device for =
/
>> >>>> (is
>> >>>> /dev mounted?))
>> >>>> #regzbot ignore-activity
>> >>>
>> >>> The bug is also tracked at
>> >>> https://bugzilla.kernel.org/show_bug.cgi?id=3D218353 .
>> >>
>> >> About the fix: we can't simply revert the patch because the temp_fsid
>> >> depends on that. A workaround could be to check if the device path is
>> >> "/dev/root" and still register the device. But I'm not sure if this d=
oes
>> >> not break the use case that Steamdeck needs, as it's for the root
>> >> partition.
>> >
>> >
>> > Thank you for the report.
>> >
>> > The issue seems more complex than a simple scenario, as the following
>> > test-case works well:
>> >
>> >   $ mount /dev/sdb1 /btrfs
>> >   $ cat /proc/self/mountinfo | grep btrfs
>> > 345 63 0:34 / /btrfs rw,relatime shared:179 - btrfs /dev/sdb1
>> > rw,space_cache=3Dv2,subvolid=3D5,subvol=3D/
>> >
>> > However, the relevant part of the commit
>> > bc27d6f0aa0e4de184b617aceeaf25818cc646de that may be failing could
>> > be in identifying a device, whether it is the same or different
>> > For this, we use:
>> >
>> >      lookup_bdev(path, &path_devt);
>> >
>> > and match with the devt(MAJ:MIN) saved in the btrfs_device;
>> > would this work during initrd? I need to dig more. Trying
>> > to figure out how can I reproduce this.
>> >
>> > Thanks, Anand
>> >
>> >

