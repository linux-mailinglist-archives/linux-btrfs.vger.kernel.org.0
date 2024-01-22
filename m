Return-Path: <linux-btrfs+bounces-1585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 032AE8358DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 01:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA2E282296
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2161237B;
	Mon, 22 Jan 2024 00:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCSjQ5i9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79E195;
	Mon, 22 Jan 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705882034; cv=none; b=BGT9zmVnP0CUI8IrCM+iWyMFGDLEmQl8ABxM/jOWxXrJMzFSM3TBtkpoblCGreAlrw9+/zh5YStJb92ZBtsVSGYbNyWGWuUdSpEn178vVySrsFR2VfC90yUc+MeWkhZKzihXYoRyvnbZ5yty+sQg5iLYKqfjpU2B63RjwW3AEPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705882034; c=relaxed/simple;
	bh=v0w0LJ3uf4foFHSK8n0QTLvlcutBJjyEkJg91UgDdkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak/JiOzrTkjjQOW0eSU+4gUSRFQ+5X2a5nBpqELRYFJr1NQMAkqg7nt1FYzFm0oOyPCf5yPkNv4aDcKC6HFG2XK/M/lzH0sakqzYHrFE4TVSMnmVoZGlkmrEYWSD+mwcmuNqkHtRuKOo569sDaQk51qG/QhZQXHDHoupOrLkn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCSjQ5i9; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc256e97e0aso1433189276.2;
        Sun, 21 Jan 2024 16:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705882032; x=1706486832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXaDrO6PrF2cmqEQPuS3YomJWnmAlkY/6Wq6iuyjQCw=;
        b=ZCSjQ5i9Hmx/cFlAwa4+aJlnNKnUK4L/ZotpHOx+O0bQRzGeHCooeTRmxcuacYnSzq
         QEUAfq/ZYhP685CguvR9Yzr7FWyfX6PfasLhAiJe77Hxnrg2ynzzHoK+YpWJyYwe2C0q
         4QaDhK6ReMNveVOyMdSHB/xH1wUcHhSSvJ8ptG3wQZ7D5f+dP3rmSPxQs59EwH/giht2
         woZ0plLQrtyUA/jv6vmihiuA8hSOyAH8gDzellFwVTZ1CofKyLst2bjBVIki+/xXIiO5
         MBBP2AMFEHFfnVRqD8v4CuW6LQdhEla7QffBwk3hFaiwxMTNscZB1p+aQlnW8TpU4PYb
         5V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705882032; x=1706486832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXaDrO6PrF2cmqEQPuS3YomJWnmAlkY/6Wq6iuyjQCw=;
        b=XSS393rWdBglsjDKKQ3nRNNBPr4SUA+05DD9R/UCx/OSJOu5UCzHgrt5ctTCFhUuq4
         28eut9V5tLl/wyX81z3QOxMUbjz0kC541PDahGlTpe387D//KXhPosxUgJ9woB++Xjs0
         9WHIxwTyFZE+r+jb9CwZi4E/p3MwpWRGHbiN2v61Av+qv5LNpU6Um+yRGIsAEcUOIRBa
         g8bL41iilvNAiStU1YgNwcQ9S8X9a4iU3ERWw6Q+wma2QMdwFWyuIUUOo5yL0pK4qYcm
         eJEk+zg1u36yJBXVaj9x2Bewu/pbcWv7Uqe+jfUdbsAlEhnAlx8Mbup151VxZq6EjGPA
         XDmg==
X-Gm-Message-State: AOJu0YxdUAtknssjTDPhtVDLUWhT4oVqeqcp2XlGljDd67l2rEVBZ/vO
	CZ+t/H8NDHQ/Mk1kUHiYkbhs2h8CTrIIpFBAyvtdCwXkTkMB5NpzVfs2jQigB9y7yK1jMTzpVvn
	8yIvffj3d//md9PBTwGJRBiA1d68=
X-Google-Smtp-Source: AGHT+IGfIyZs2JIgn0r3Ml/E3UHsh7sPDcPhsDbKTC7E6gcGm2WrFhJcxFItNZ+lNdG5XLiux+DMqyIIdu1HWiJUbcg=
X-Received: by 2002:a25:ea11:0:b0:dbe:6596:4813 with SMTP id
 p17-20020a25ea11000000b00dbe65964813mr1304993ybd.24.1705882031736; Sun, 21
 Jan 2024 16:07:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
 <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info> <20240111155056.GG31555@twin.jikos.cz>
 <20240111170644.GK31555@twin.jikos.cz> <f45e5b7c-4354-87d3-c7f1-d8dd5f4d2abd@oracle.com>
In-Reply-To: <f45e5b7c-4354-87d3-c7f1-d8dd5f4d2abd@oracle.com>
From: Alex Romosan <aromosan@gmail.com>
Date: Mon, 22 Jan 2024 01:07:01 +0100
Message-ID: <CAKLYge+x9kxLBaJGyk_gTMK2kQ=+Lhg00jgXe=P=jmBUq=cmfA@mail.gmail.com>
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks update-grub
To: Anand Jain <anand.jain@oracle.com>
Cc: CHECK_1234543212345@protonmail.com, brauner@kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-kernel@vger.kernel.org, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, dsterba@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

update-grub still doesn't work 6.8-rc1

so i did:

# cat /proc/self/mountinfo | grep btrfs
21 1 0:19 / / rw,relatime shared:1 - btrfs /dev/root
rw,ssd,discard=3Dasync,space_cache,subvolid=3D5,subvol=3D/

the difference from your test case is that it doesn't reference
the disk device but /dev/root which on my system doesn't exist. could this
be the problem?

--alex--


On Fri, Jan 12, 2024 at 12:24=E2=80=AFAM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
>
>
> On 11/01/2024 22:36, David Sterba wrote:
> > On Thu, Jan 11, 2024 at 04:50:56PM +0100, David Sterba wrote:
> >> On Thu, Jan 11, 2024 at 12:45:50PM +0100, Thorsten Leemhuis wrote:
> >>> [Adding Anand Jain, the author of the culprit to the list of recipien=
ts;
> >>> furthermore CCing the the Btrfs maintainers and the btrfs list; also
> >>> CCing regression list, as it should be in the loop for regressions:
> >>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> >>>
> >>> On 08.01.24 15:11, Alex Romosan wrote:
> >>>> Please Cc me as I am not subscribed to the list.
> >>>>
> >>>> Running my own compiled kernel without initramfs on a lenovo thinkpa=
d
> >>>> x1 carbon gen 7.
> >>>>
> >>>> Since version 6.7-rc1 i haven't been able to to a grub-update,
> >>>>
> >>>> instead i get this error:
> >>>>
> >>>> grub-probe: error: cannot find a device for / (is /dev mounted?) sol=
id
> >>>> state drive
> >>>>
> >>>> 6.6 was the last version that worked.
> >>>>
> >>>> Today I did a git-bisect between these two versions which identified
> >>>> commit bc27d6f0aa0e4de184b617aceeaf25818cc646de btrfs: scan but don'=
t
> >>>> register device on single device filesystem as the culprit. revertin=
g
> >>>> this commit from 6.7 final allowed me to run update-grub again.
> >>>>
> >>>> not sure if this is the intended behavior or if i'm missing some oth=
er
> >>>> kernel options. any help/fixes would be appreciated.
> >>>>
> >>>> thank you.
> >>>
> >>> Thanks for the report. To be sure the issue doesn't fall through the
> >>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regressi=
on
> >>> tracking bot:
> >>>
> >>> #regzbot ^introduced bc27d6f0aa0e4de184b617aceeaf25818cc646de
> >>> #regzbot title btrfs: update-grub broken (cannot find a device for / =
(is
> >>> /dev mounted?))
> >>> #regzbot ignore-activity
> >>
> >> The bug is also tracked at https://bugzilla.kernel.org/show_bug.cgi?id=
=3D218353 .
> >
> > About the fix: we can't simply revert the patch because the temp_fsid
> > depends on that. A workaround could be to check if the device path is
> > "/dev/root" and still register the device. But I'm not sure if this doe=
s
> > not break the use case that Steamdeck needs, as it's for the root
> > partition.
>
>
> Thank you for the report.
>
> The issue seems more complex than a simple scenario, as the following
> test-case works well:
>
>    $ mount /dev/sdb1 /btrfs
>    $ cat /proc/self/mountinfo | grep btrfs
> 345 63 0:34 / /btrfs rw,relatime shared:179 - btrfs /dev/sdb1
> rw,space_cache=3Dv2,subvolid=3D5,subvol=3D/
>
> However, the relevant part of the commit
> bc27d6f0aa0e4de184b617aceeaf25818cc646de that may be failing could
> be in identifying a device, whether it is the same or different
> For this, we use:
>
>       lookup_bdev(path, &path_devt);
>
> and match with the devt(MAJ:MIN) saved in the btrfs_device;
> would this work during initrd? I need to dig more. Trying
> to figure out how can I reproduce this.
>
> Thanks, Anand

