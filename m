Return-Path: <linux-btrfs+bounces-6457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9E9930D9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 07:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6EA1C208D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 05:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1758248D;
	Mon, 15 Jul 2024 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqr9GRIV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AF228F7
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721021491; cv=none; b=WyTj8PEOyYKZCWD26mf96mgGNGkpkdz+Mq4CyNHbNYPfAdV68GD6PC5elzkk5N/JCW93YJQatIM5OUGYORmrYL1QKwlL+DlqTkY4YMl8orvESMHshMHFaqbREpAd5IMkZ34J3bhAuCQ+YLvs775FwaqBr8i/wWmqMAHMgZpDZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721021491; c=relaxed/simple;
	bh=+J50B+Gs2zzszw58O4tNb3c3MM6m/4E4GHJLAu0qe+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itbQgCwldUJAf55e/mHkCJib9IcBQj0BYmsjlVV/zyqqNqlwVfe6aw6gxTuV3Ioduaq0zPNjUK/6e7UWBCpB4ADRul6zspYZDtyrJxrEyoJgo2BtFlNCBBg4zHFFbujOrZRZp0h1jRtdFR4mhlj1moa5B1Rs0U8QApI2wcEWuro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqr9GRIV; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79efb4a46b6so266355385a.2
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721021488; x=1721626288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdirPL4AIRnqptrFCnuXeeltLOTejN86IN6qwc4FYDk=;
        b=eqr9GRIVboiXvD6CJqsgxgiqhYOm5ZDTCpWM5vkIvivVIvK1Y620yzZUkIBNeoOmSY
         2MJRUcDjKjuoyb+QwdrMmaqgM3mYMY066t5KCna0LWuxR3oroErQ7P7SP6gCX1WVsX0l
         haU5nQqBflBIoEi0rkBUFml9WDBjx4eFKmcJivgkSYmEIy3UvSoPU0pKsu96iAOaTkuz
         /V7xYx7aML9XukEjhJ8zSjQ4n6JqoUdUT/Gg3/YRwmZf1S0yHirPtQ9IoJSFGrKXJ3MA
         jOQ6HqktCz2OjioP8RT52dRi9DE13l4eWROVH+RCv+TniYf4SkiVcKwCMgcSdt8ylKbw
         5wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721021488; x=1721626288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdirPL4AIRnqptrFCnuXeeltLOTejN86IN6qwc4FYDk=;
        b=wXfCTr8phvr+/ueNJu4znXzaEYD5AE0b+eV49BaW0mpfu624mrUMg14y/AY03M0Pvl
         9m1+Qyxs9LXPwSbnnp8kZ0olgcUTeAJSoDLr5AhbiPBbQ37J5BmenhdVpp+1fQYvCskI
         UwA1rXlnrkMPUTAlBJaW1d34jLKm9tzEdlboR9Ws0KTH/IHtCxdDgUk1nCY/BkWvdhH7
         E2xyl6qxmfAlipUROW68kka7LlTWSiL4mN5rGDjB16+ZBgg1xXe6Vl7y69+P+qDXjnfD
         W7UDuXV0HXjf4vxM7pgG+n5vRlT6PSAF+f09wnQI4lQ8/NIYEwV5L48R5hAscykZcBIg
         zKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+hBJBNiBuDByszT/rU4Xn1igWccB9XYAJsJY8QnYXQ9P3tZn4R4Mrt77EkoaFXZZcWxiq++UPqmQLH7QkXxihG+FJpWd7s7I4DLA=
X-Gm-Message-State: AOJu0Ywk8lJoAvy4hTch7Y91QkGV1FoXUgibiWMKqzP8Ld9e8cHSJXIn
	k5s2iugWy8YApvvykJMgN/oFVer1X6hAg8T6ZTVRKsFL2EMVMp7mW+BiRk2YZCTn2mA5VBr9bSV
	GPvMd7HrzKqkLqGsOSjNIEpwslH8=
X-Google-Smtp-Source: AGHT+IHXJofZ71WHXhPHcynLcIiSzOERKYxdubKKEWONjmGaBoTLPD7QvMbx9TfgKOF5fAPVcSwwLQteMh+zaDSBsdo=
X-Received: by 2002:a37:ef17:0:b0:79f:197d:fe92 with SMTP id
 af79cd13be357-79f19a0f931mr1881610685a.2.1721021488110; Sun, 14 Jul 2024
 22:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com>
 <0bedfc5f-4658-4d01-98b3-34bc14f736f3@gmx.com> <CAMthOuNk273pZUSU1Npr-Zx7LscBxOsXeyWcQCgbYP=82TfreA@mail.gmail.com>
 <d30126ba-a9fc-44ea-bba8-1f42b242ca91@suse.com>
In-Reply-To: <d30126ba-a9fc-44ea-bba8-1f42b242ca91@suse.com>
From: Kai Krakow <hurikhan77@gmail.com>
Date: Mon, 15 Jul 2024 07:31:02 +0200
Message-ID: <CAMthOuMWvFWNEJkOWQiP2eNwWap8H4z7Gb6qzS8M-WkTUk2=Mw@mail.gmail.com>
Subject: Re: btrfs crashes during routine btrfs-balance-least-used
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	Oliver Wien <ow@netactive.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mo., 15. Juli 2024 um 07:00 Uhr schrieb Qu Wenruo <wqu@suse.com>:
> =E5=9C=A8 2024/7/15 13:59, Kai Krakow =E5=86=99=E9=81=93:
> > Hello Qu!
> >
> > Thanks for looking into this. We already started the restore, so we no
> > longer have any access to the corrupted disk images.
> >
> > Am So., 14. Juli 2024 um 23:54 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/7/15 01:43, Kai Krakow =E5=86=99=E9=81=93:
> >>> Hello btrfs list!
> >>>
> >>> (also reported in irc)
> >>>
> >>> Our btrfs pool crashed during a routine btrfs-balance-least-used.
> >>> Maybe of interest: bees is also running on this filesystem, snapper
> >>> takes hourly snapshots with retention policy.
> >>>
> >>> I'm currently still collecting diagnostics, "btrfs check" log is
> >>> already 3 GB and growing.
> >>>
> >>> The btrfs runs on three devices vd{c,e,f}1 with data=3Dsingle meta=3D=
raid1.
> >>>
> >>> Here's an excerpt from dmesg (full log https://gist.tnonline.net/TE):
> >>
> >> Unfortunately the full log is not really full.
> >>
> >> There should be extent leaf dump, and after that dump, showing the
> >> reason why we believe it's a problem.
> >>
> >> Is there any true full dmesg dump?
> >
> > Yes, sorry. The gist has been truncated - mea culpa. I repasted it:
> > https://gist.tnonline.net/6Q
>
> Thanks a lot!
>
> That contains (almost) all info we need to know.
>
> The offending bytenr is 402811572224, and in the dump we indeed have the
> item for it:
>
> [1143913.108184]        item 188 key (402811572224 168 4096) itemoff 1459=
8
> itemsize 79
> [1143913.108185]                extent refs 3 gen 3678544 flags 1
> [1143913.108186]                ref#0: extent data backref root 138350580=
55282163977
> objectid 281473384125923 offset 81432576 count 1
>
> The last line is the problem.
>
> Firstly we shouldn't even have a root with that high value.
> Secondly that root number 13835058055282163977 is a very weird hex value
> too (0xc000000000000109), the '0xc' part means it's definitely not a
> simple bitflip.

Oh wow, I didn't even notice that. I skimmed through the logs to
resolve the root numbers to subvolids, hoping for an idea where the
"corrupted extents" are - but they were all over the place in
seemingly unrelated subvols.

This host runs several systemd-nspawn containers with various
generations of PHP, MySQL containers (MySQL data itself is on a
different partition because btrfs and mysql don't play well), a huge
maildir storage, a huge web vhost storage, and some mail filter / mail
services containers. Just to give you an idea of what kind of data and
workload is used...

> Furthermore, the objectid value is also very weird (0xffffa11315e3).
> No wonder the extent tree is not going to handle it correctly.
>
> But I have no idea why this happens, it passes csum thus I'm assuming
> it's runtime corruption.

We had some crashes in the past due to OOM, sometimes btrfs has been
involved. This was largely solved by disabling huge pages, updating
from kernel 6.1 to 6.6, and running with a bees patch that reduces the
memory used for ref lookups:
https://github.com/Zygo/bees/issues/260

> [...]
> >
> >> The other thing is, does the server has ECC memory?
> >> It's not uncommon to see bitflips causing various problems (almost
> >> monthly reports).
> >
> > I don't know the exact hosting environment, we are inside of a QEMU
> > VM. But I'm pretty sure it is ECC.
>
> And considering it's some virtualization environment, you do not have
> any out-of-tree modules?

No, the system is running Gentoo, the kernel is manually configured
and runs without module support. Everything is baked in.

> > The disk images are hosted on DRBD, with two redundant remote block
> > devices on NVMe RAID. Our VM runs on KVM/QEMU. We are not seeing DRBD
> > from within the VM. Because the lower storage layer is redundant, we
> > are not running a data raid profile in btrfs but we use multiple block
> > devices because we are seeing better latency behavior that way.
> >
> >> If the machine doesn't have ECC memory, then a memtest would be prefer=
able.
> >
> > I'll ask our data center operators about ECC but I'm pretty sure the
> > answer will be: yes, it's ECC.
> >
> > We have been using their data centers for 20+ years and have never
> > seen a bit flip or storage failure.
>
> Yeah, I do not think it's the hardware corruption either now.

Yes, what you found above looks really messed up - that's not a bitflip.

> > I wonder if parallel use of snapper (hourly, with thinning after 24h),
> > bees (we are seeing dedup rates of 2:1 - 3:1 for some datasets in the
> > hosting services)
>
> Snapshotting is done in a very special timing (at the end of transaction
> commit), thus it should not be related to balance operations.
>
> > and btrfs-balance-least-used somehow triggered this.
> > I remember some old reports where bees could trigger corruption in
> > balance or scrub, and evading that by pausing if it detected it. I
> > don't know if this is an issue any longer (kernel 6.6.30 LTS).
>
> No recent bugs come up to me immediately, but even if we have, the
> corruption looks too special.
> It still matches the item size and ref count, but in the middle the data
> it got corrupted with seemingly garbage.

I think Zygo has some notes of it in the bees github:
https://github.com/Zygo/bees/blob/master/docs/btrfs-kernel.md

I think it was about btrfs-send and dedup at the same time... Memory
fades faster if one gets older... ;-)

> As the higher bits of u64 is store in higher address in x86_64 memory,
> the corruption looks to cover the following bits:
>
> 0                       8                       16
> |        le64 root      |      le64 objectid    |
> |09 01 00 00 00 00 00 0c|e3 15 13 a1 ff ff 00 00|
>                        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> 16                      24          28
> |        le64 offset    | le32 refs |
> |00 09 da 04 00 00 00 00|01 00 00 00|
>
> So far the corruption looks like starts from byte 7 ends at byte 14.
>
> In theory, if you have kept the image, we can spend enough time to find
> out the correct values, but so far it really looks like some garbage
> filling the range.
>
> For now what I can do is add extra checks (making sure the root number
> seems valid), but it won't really catch all randomly corrupted data.

This could be useful. Will this be in btrfs-check, or in the kernel?

> And as my final struggle, did this VM experienced any migration?

No. It has been sitting there for 4 or 5 years. But we are slowly
approaching the capacity of the hardware. What happens then: Our data
center operator would shut the VM down, rewire the DRBD to another
hardware, and boot it again. No hot migration, if you meant that.

I'm not sure how reliable DRBD is, but I researched it a little while
ago and it seems to prefer reliability over speed, so it looks very
solid. I don't think anything broke there, and even then 8 bytes of
garbage looks strange. Well, that's 64 bits of garbage - if that means
anything.

> As that's the only thing not btrfs I can think of, that would corrupt
> data at runtime.

I'm using btrfs in various workloads, and even with partially broken
hardware (raid1 on spinning rust with broken sectors). And while it
had its flaws like 10+ years ago, it has been rock solid for me during
the last 5 years at least - even if I handled the hardware very
impatiently (like hitting the reset button or cycling power). Of
course, this system we're talking about has been handled seriously.
;-)

Thanks,
Kai

