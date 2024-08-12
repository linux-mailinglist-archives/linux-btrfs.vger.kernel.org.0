Return-Path: <linux-btrfs+bounces-7111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FE194E753
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 09:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA821C20C36
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70B165F12;
	Mon, 12 Aug 2024 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPGEm42Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097E165EF0
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723446065; cv=none; b=GP0Qba5WyXqJCQPw8RN2CFw3yYgO80jk4/wXGcUyJqd5mJrFGW7xQ8E2jlOQk/xJrZ2tO7qdt+9sZGyqiUoo3jNSCDqZeJm3jCstim2veSH2UdFW6C5p40tHTe07uG0fePpfN7sqN9J9p1sjma9tXte5e3EIxWNtdYDY9Et5/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723446065; c=relaxed/simple;
	bh=YxY/2cyGRA1mhm9cDczXfZ4ByzUOQafTmCy32Li+Xjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4KZURY3heyW2/gP90RQ+xZYyJP7BENLxTJPzSru2V+W+ldSaIIEPTz1JH0k24XFbSgEn2mcCg2qgPTql7GwETyas8PTCspR2+YTbaJbgXRPWsvzSJJ9c+jpUS5AyQpVSounyy5L1b3IENU+ZStw4WSlDywnuP/vIzrSQCLpvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPGEm42Z; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d80752933bso2846990eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 00:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723446063; x=1724050863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCsJawL7nuEaHymd/Zv9cZ0Ncllnx3thMC+PbtZc+7g=;
        b=bPGEm42ZMv0rexmDe+/xzxdz4uWV1bqqVd04uTFmwasgtU+UmAi3+cPy8P0+s5e4YP
         2Kp8eSQ9A+99CMu0w/Q8E/ELDoS03q7cPlp/QZ5j7HSguZqnL18VblJisffkcza/un6K
         omwcRPhXrrHbs8Awt2hG9o2C0ykjtsrHlNpx0XIYWMnxB0ejA9CwpsIEqz9/X5lY/PCu
         xH0/P+GOkg6m2plOR51iLP+yMqq94k3TW12qLwTCZp+pi3hjtY/BxfLtf6NEcjVf3Df2
         bl/U1xnAIVKx1pB1jAZ2h9j5J4cAI+ZFOijw84ngDnIJmuc0UFd6yC7MlAt1hzeps7MM
         hfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723446063; x=1724050863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCsJawL7nuEaHymd/Zv9cZ0Ncllnx3thMC+PbtZc+7g=;
        b=RbeCLVrChsbBB/MZ2jR/cgApVkNDWYxLXqB4ZlLl3oHSY8EunsgseftnT9OyOgQTZ6
         iiB9Ase19W73BMll8vTL3DfA2HHTb3nx8w+iaE2gDj41gbwW358yEW4XgRD5qc2RIs9Q
         0UFjwZXI1cuFg69at2beH/uYcDTmJyTtYM4rVz0I7Vt0XDLcMH2MbBy2s+g69/spstkS
         uL9WQoEUpTkmrOKrjVsSA4LOWPcJzDWgV0wDvWd93Fi+1JukqXVQDIfUkUBbYuTBe3lr
         eh4H2BADl8YAcvXXh0wun/j8Vw421pRJg7ZvODtIvNLkCB4sjQ5EhLhAVtWC3YV+zTBy
         EMaw==
X-Gm-Message-State: AOJu0Yz6VE6BDz7A8D81WCiB3OtI5psxA70GRSJNBS2QEHpqGlahpOnV
	h5t/+eU/qwYOAR2fSgrN3whw4qGzjnje3tOfMyOE3WSIT3d+yKihIPVRD5NuJAcCIN6UYBVG5Jb
	O82DSkzrfMi8nYntmZNdZyFnMallDILKs
X-Google-Smtp-Source: AGHT+IHtCFvU50sMrMrnLFQpGRpsVUUlDqVhFaTtuzDO1QsYi2r4EoSuI5sT4dOXFIC69QmyAhhYy0I6pXpMZx9wH3s=
X-Received: by 2002:a05:6820:60e:b0:5c4:2497:c92d with SMTP id
 006d021491bc7-5d867c96139mr10475160eaf.2.1723446062608; Mon, 12 Aug 2024
 00:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com>
 <ac2ff9ae-b2fa-49df-9ce3-fc32ddd3c222@gmx.com>
In-Reply-To: <ac2ff9ae-b2fa-49df-9ce3-fc32ddd3c222@gmx.com>
From: Stefan N <stefannnau@gmail.com>
Date: Mon, 12 Aug 2024 16:30:51 +0930
Message-ID: <CA+W5K0qUAXYSZFxJv+vVM+knFkXm+VK61zOb2qF6TXmW156LOA@mail.gmail.com>
Subject: Re: Help! Unmountable due to dev extent overlap
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qu,

Thanks for the informative response as always!

Responses inline below

On Sun, 11 Aug 2024 at 11:51, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2024/8/11 10:57, Stefan N =E5=86=99=E9=81=93:
> > Hi,
> >
> > I've got a currently unmountable RAID6 array with no particularly
> > obvious trigger that I'm attempting to repair. As it's unmountable
> > I've not been able to include btrfs fi usage but it's RAID6 data,
> > RAID1c3 metadata, and afaik is not out of space.
> >
> > Background:
> > Having previously scrubbed all disks by devid successfully
>
> Unfortunately scrub doesn't do the full verification of metadata (yet),
> a successful scrub can only ensure all the checksums (for both data nad
> metadata) matche the content.
>
> > I had a
> > complete hardware failure on one disk, which I resolved with btrfs
> > replace -r and did not notice any errors immediately after. The new
> > disk is /dev/sdh devid 5, and the last disk replaced/added roughly 3
> > months prior was /dev/sdf devid 12.
> > Roughly a week after the replace completed I began a scrub on /dev/sdc
> > devid 1, and roughly 36 hours later without anything logged, this
> > triggered a kernel panic (btrfs_create_pending_block_groups:2716:
> > errno=3D-17 Object already exists) resulting in read only, and
> > unmountable since. Several days later, this scrub then finished
> > successfully and reported no errors.
>
> That "panic" (to be more accurate, just kernel warning, not a panic)
> shows the first hit.
>
> Do you still have that dmesg? Or it matches the one you posted here?

I split the several days of dmesg into the output in-line, I just
trimmed it and deduped the relevant btrfs lines as it was a lot!

> > While the data is all replaceable, due to the amount of data involved
> > I'm keen to retain the filesystem and identify specific files/folders
> > to replace, provided this is achievable and can maintain the future
> > integrity of the filesystem!
>
> It's a little hard, especially when we do not have a clear clue on what
> is causing that warning yet.
>
> >
> > Any help or direction would be greatly appreciated
> >
> > Command output and relevant logs included inline below
> >
> > Cheers,
> >
> > Stefan
> >
> > # btrfs check /dev/sdb
> > [1/7] checking root items
> > [2/7] checking extents
> > Device extent[13, 2257707008000, 6488064] existed.
> > Device extent[13, 2258112544768, 6488064] existed.
> > Device extent[13, 2260271366144, 6488064] existed.
> > Device extent[13, 7812682350592, 6488064] existed.
> > Device extent[13, 7813260705792, 6488064] existed.
> > Device extent[13, 7814399262720, 6488064] existed.
> > Device extent[13, 7815832010752, 6488064] existed.
> > Device extent[13, 7819053236224, 6488064] existed.
> > Device extent[13, 7821200719872, 6488064] existed.
> > Device extent[4, 15746057961472, 6488064] existed.
> > Device extent[4, 15977630334976, 6488064] existed.
> > Device extent[4, 14263979671552, 6488064] existed.
> > Device extent[4, 14367058886656, 6488064] existed.
> > Device extent[4, 14369206370304, 6488064] existed.
> > Device extent[4, 14624786284544, 6488064] existed.
> > Device extent[4, 15141140627456, 6488064] existed.
> > Device extent[4, 15194827784192, 6488064] existed.
> > Device extent[4, 15486894211072, 6488064] existed.
> > ERROR: dev extent devid 4 physical offset 14263979671552 overlap with
> > previous dev extent end 14263980982272
>
> Please provide the following dump:
>
> # btrfs ins dump-tree -t dev <device>
> # btrfs ins dump-tree -t chunk <device>

dumptrees stdout is 50mb bzipped for all devices (no output to
stderr), so have uploaded to https://filebin.net/92cnqpr9xx9565oe
From this output, sda (devid 4) and sdm (devid 13) are the two that
btrfs check is complaining about

> > ERROR: errors found in extent allocation tree or chunk allocation
> > [3/7] checking free space tree
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > Opening filesystem to check...
> > Checking filesystem on /dev/sdb
> > UUID: guid-x-y-z
> > found 104052224266240 bytes used, error(s) found
> > total csum bytes: 101533362472
> > total tree bytes: 117929181184
> > total fs tree bytes: 1742323712
> > total extent tree bytes: 1548320768
> > btree space waste bytes: 11865883351
> > file data blocks allocated: 139229426343936
> >   referenced 139218099167232
> >
> > # btrfs check -b /dev/sdb
>
> This just provides extra noise. The regular "btrfs check" is the most
> important one.
> If possible, "btrfs check --mode=3Dlowmem" provides a more developer
> friendly output (but much slower).

# btrfs check --mode lowmem /dev/sdb
[1/7] checking root items
[2/7] checking extents
ERROR: dev extent devid 4 offset 14263979671552 len 6488064 overlap
with previous dev extent end 14263980982272
ERROR: dev extent devid 13 offset 2257707008000 len 6488064 overlap
with previous dev extent end 2257707270144
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs done with fs roots in lowmem mode, skipping
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/sdb
UUID: 3cde0d85-f53e-4db6-ac2c-a0e6528c5ced
found 104088092352512 bytes used, error(s) found
total csum bytes: 101533362472
total tree bytes: 117929181184
total fs tree bytes: 1742323712
total extent tree bytes: 1548320768
btree space waste bytes: 11865883351
file data blocks allocated: 139229426343936
 referenced 139218099167232

> > # uname -a
> > Linux mynas.x.y.z 6.8.0-39-generic #39-Ubuntu SMP PREEMPT_DYNAMIC Fri
> > Jul  5 21:49:14 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
>
> I guess your NAS is running this newer kernel even before the first
> warning? Or is there any older kernel involved?

last reports that this 6.8.0-39 kernel (Ubuntu noble) was active from
30 Jul, I recall I did a release upgrade a few days after the replace,
so yes the errors all occurred while running this kernel. Prior to
this, it appears to have been running 6.5.0-44-generic and earlier 6.5
releases for 9 months (Ubuntu mantic).

> A quick glance into the tree-checker shows that we do not have any
> checks on dev extent items.
> And I guess that's why we didn't detect the corruption in the first and
> let the corruption sneak in and written the corrupted one onto disk.
>
> But my current guess is, it looks possible some kind of bitflip sneaks in=
.
>
> Just to be sure, after taking the dumps, please run a memtest just in cas=
e.

I've got memtest86+ running now to confirm, will confirm the output
next response

> Thanks,
> Qu

