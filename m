Return-Path: <linux-btrfs+bounces-6489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 814BD9320C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 08:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79A0B21A4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 06:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF228DD2;
	Tue, 16 Jul 2024 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMQZZ8SG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6D25761
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112744; cv=none; b=u1MI3+oOv2muNzXTU+TGqRVXp48q0tpApMeWzqJ1dPdvYZUf7TXHkjyhH5ly9GvvRCmZXTYjLLhPSl81uaeDSk52TQbYCvj5MVe7x+IyriLg3Q0kGJrFgS7Q3FHaNF32VgBdRMG4Jt0kq2ErKkQVm1rC6FvSKXFAzkWi/kwjWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112744; c=relaxed/simple;
	bh=KfI94G3hXGp5a5pxJ+yrqMio/IgqDKPyWwDjwCS2NfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srOepNDYYLKbGD/yh5nZ5gp1FVcdg1wpw4frHwjQdo9vJDUrrpRLEtO7KNM1kKRsUS6AK2n/oRocCliJnQcdbTXnjShvFiRtij2FGH9GJGaBWGz86/P4Oe3WEgofhukisiE04qVLypY7W+8OXlzbz0wdkYDPqErsPLRL+QU7gg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMQZZ8SG; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f15e7c879so367600585a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721112741; x=1721717541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjP5V0w4S1Zw/f+eGN5Kkyy1MPS5PE5GUoTfPgE/hCY=;
        b=YMQZZ8SG7oDHQoLAy4rvdaFE/hml8cOme97hiCse4DBkyVqFnsWoMliPLKUyrh6VOs
         jNcaYNfpPx/k3dQUJyM8a7vxvMqLtNeHINmpWWwQIU1XFyMJ+l+k47V/HzeLQ0xbZZI/
         bz1g9NTBUyoqhxHsET6Q+HLq3k/AieNwOmVrakpKOYmW5IpPitvupEZQTzS+LZspWoAZ
         9AcKq+JTmkdryDaCF9sy83BC3qZOQbIJY/L5H6Brr1AniVflPL1eExdWGzwre0VogMg0
         kzTmhrgb4ngubHxKnxfFZt/esMsp/8Mt9azUOT4nORX3EXghvRjBTwZ45SQWnolchtnh
         2rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721112741; x=1721717541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjP5V0w4S1Zw/f+eGN5Kkyy1MPS5PE5GUoTfPgE/hCY=;
        b=dzoZF4iv8lWw+GaexzhOS3v4ZfA/tbv5gxTxa7m20RC5fukOPylJWgp2t3qZvXxhyD
         7jOjRUQlZe1pfNlm3POBKi/NRhbCmolfBAlBdRAzlvqGXXn1s83jHyxj2sBACND1YUoE
         x0uCzWEYjvetBrA+8OQjCjpAIekqLJSUuGcSSDWNx5Ut75/XFe5MnrHL1IbfBRECP1Uf
         cmEp8pvLuJNx2Cqx+FGJuczpZSGYQIZTa6SrOmPGnpyhKCtSMetjYa8OOsilnbFOH7WR
         z2uPBliTvtkzG8xg3wYigXhP7441hyX9g1fQy9g8IsyepE/mNGN/X9pTYEeR0xVMBfIb
         J6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVVzypLVpe0eYlqJwCVmyFdXlioQ37glrk3C33LkKB9ggxssa957Pp0jTKrTS8WVZykEMOpy4+9a7gwEHKraCe8QZwdlo6btG6GBrw=
X-Gm-Message-State: AOJu0YxTIysqj8Jb1XTCXc3B9zI1UxiqrFtdElh5pf3ztPYizlkyX60m
	ML96ipxZyK1CHjKcMmkSkKA18zXDlmLB2RUUrafBHI3ipkTnVp5L5vm+X5/qWAxpYKjHHrdjS3u
	68XymUxGMX5DYSTeOthJ3fDf9BN8=
X-Google-Smtp-Source: AGHT+IG2U+qY3ywvc9lzujlPfPO+57/UU9A8uMWVxtzXiSmoczrCaLkFayLfZPBd/eK+7lbr4/szUd+aVrJb5+aGH7E=
X-Received: by 2002:a05:620a:394c:b0:79f:d0f:2b19 with SMTP id
 af79cd13be357-7a17b6fb80bmr170252785a.68.1721112741121; Mon, 15 Jul 2024
 23:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com>
 <0bedfc5f-4658-4d01-98b3-34bc14f736f3@gmx.com> <CAMthOuNk273pZUSU1Npr-Zx7LscBxOsXeyWcQCgbYP=82TfreA@mail.gmail.com>
 <d30126ba-a9fc-44ea-bba8-1f42b242ca91@suse.com> <CAMthOuMWvFWNEJkOWQiP2eNwWap8H4z7Gb6qzS8M-WkTUk2=Mw@mail.gmail.com>
 <1728bb6e-9dd0-4a2c-be16-41cd01231484@gmx.com>
In-Reply-To: <1728bb6e-9dd0-4a2c-be16-41cd01231484@gmx.com>
From: Kai Krakow <hurikhan77@gmail.com>
Date: Tue, 16 Jul 2024 08:51:55 +0200
Message-ID: <CAMthOuNqaKoJGYWNDdV33hWkG1oa77vuEt0gxxYVbW+KNrtnaw@mail.gmail.com>
Subject: Re: btrfs crashes during routine btrfs-balance-least-used
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Qu!

Am Mo., 15. Juli 2024 um 07:50 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.co=
m>:
>
>
>
> =E5=9C=A8 2024/7/15 15:01, Kai Krakow =E5=86=99=E9=81=93:
> > Am Mo., 15. Juli 2024 um 07:00 Uhr schrieb Qu Wenruo <wqu@suse.com>:
> [...]
> >> The last line is the problem.
> >>
> >> Firstly we shouldn't even have a root with that high value.
> >> Secondly that root number 13835058055282163977 is a very weird hex val=
ue
> >> too (0xc000000000000109), the '0xc' part means it's definitely not a
> >> simple bitflip.
> >
> > Oh wow, I didn't even notice that. I skimmed through the logs to
> > resolve the root numbers to subvolids, hoping for an idea where the
> > "corrupted extents" are - but they were all over the place in
> > seemingly unrelated subvols.
> >
> > This host runs several systemd-nspawn containers with various
> > generations of PHP, MySQL containers (MySQL data itself is on a
> > different partition because btrfs and mysql don't play well), a huge
> > maildir storage, a huge web vhost storage, and some mail filter / mail
> > services containers. Just to give you an idea of what kind of data and
> > workload is used...
>
> That shouldn't be a problem, as the only thing can access btrfs metadata
> is, btrfs itself.
>
> Although in theory, anything can access the host memory can also access
> the kernel memory of the guest...
>
> >
> >> Furthermore, the objectid value is also very weird (0xffffa11315e3).
> >> No wonder the extent tree is not going to handle it correctly.
> >>
> >> But I have no idea why this happens, it passes csum thus I'm assuming
> >> it's runtime corruption.
> >
> > We had some crashes in the past due to OOM, sometimes btrfs has been
> > involved. This was largely solved by disabling huge pages, updating
> > from kernel 6.1 to 6.6, and running with a bees patch that reduces the
> > memory used for ref lookups:
> > https://github.com/Zygo/bees/issues/260
> >
> >> [...]
> >>>
> >>>> The other thing is, does the server has ECC memory?
> >>>> It's not uncommon to see bitflips causing various problems (almost
> >>>> monthly reports).
> >>>
> >>> I don't know the exact hosting environment, we are inside of a QEMU
> >>> VM. But I'm pretty sure it is ECC.
> >>
> >> And considering it's some virtualization environment, you do not have
> >> any out-of-tree modules?
> >
> > No, the system is running Gentoo, the kernel is manually configured
> > and runs without module support. Everything is baked in.
> >
> >>> The disk images are hosted on DRBD, with two redundant remote block
> >>> devices on NVMe RAID. Our VM runs on KVM/QEMU. We are not seeing DRBD
> >>> from within the VM. Because the lower storage layer is redundant, we
> >>> are not running a data raid profile in btrfs but we use multiple bloc=
k
> >>> devices because we are seeing better latency behavior that way.
> >>>
> >>>> If the machine doesn't have ECC memory, then a memtest would be pref=
erable.
> >>>
> >>> I'll ask our data center operators about ECC but I'm pretty sure the
> >>> answer will be: yes, it's ECC.
> >>>
> >>> We have been using their data centers for 20+ years and have never
> >>> seen a bit flip or storage failure.
> >>
> >> Yeah, I do not think it's the hardware corruption either now.
> >
> > Yes, what you found above looks really messed up - that's not a bitflip=
.
> >
> >>> I wonder if parallel use of snapper (hourly, with thinning after 24h)=
,
> >>> bees (we are seeing dedup rates of 2:1 - 3:1 for some datasets in the
> >>> hosting services)
> >>
> >> Snapshotting is done in a very special timing (at the end of transacti=
on
> >> commit), thus it should not be related to balance operations.
> >>
> >>> and btrfs-balance-least-used somehow triggered this.
> >>> I remember some old reports where bees could trigger corruption in
> >>> balance or scrub, and evading that by pausing if it detected it. I
> >>> don't know if this is an issue any longer (kernel 6.6.30 LTS).
> >>
> >> No recent bugs come up to me immediately, but even if we have, the
> >> corruption looks too special.
> >> It still matches the item size and ref count, but in the middle the da=
ta
> >> it got corrupted with seemingly garbage.
> >
> > I think Zygo has some notes of it in the bees github:
> > https://github.com/Zygo/bees/blob/master/docs/btrfs-kernel.md
>
> Wow, the first time I know there is such a well maintained matrix on
> various problems.
>
> >
> > I think it was about btrfs-send and dedup at the same time... Memory
> > fades faster if one gets older... ;-)
>
> Nope, this is completely a different one.
>
> >
> >> As the higher bits of u64 is store in higher address in x86_64 memory,
> >> the corruption looks to cover the following bits:
> >>
> >> 0                       8                       16
> >> |        le64 root      |      le64 objectid    |
> >> |09 01 00 00 00 00 00 0c|e3 15 13 a1 ff ff 00 00|
> >>                         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> 16                      24          28
> >> |        le64 offset    | le32 refs |
> >> |00 09 da 04 00 00 00 00|01 00 00 00|
> >>
> >> So far the corruption looks like starts from byte 7 ends at byte 14.
> >>
> >> In theory, if you have kept the image, we can spend enough time to fin=
d
> >> out the correct values, but so far it really looks like some garbage
> >> filling the range.
> >>
> >> For now what I can do is add extra checks (making sure the root number
> >> seems valid), but it won't really catch all randomly corrupted data.
> >
> > This could be useful. Will this be in btrfs-check, or in the kernel?
>
> Kernel, and it would catch the error at write time, so that such obvious
> corruption would not even reach disks.
> Although it would still make the fs RO, it will not cause any corruption
> on-disk.
>
> For btrfs-progs, it's already detecting such mismatch, but that's
> already too late, isn't it?
>
> >
> >> And as my final struggle, did this VM experienced any migration?
> >
> > No. It has been sitting there for 4 or 5 years. But we are slowly
> > approaching the capacity of the hardware. What happens then: Our data
> > center operator would shut the VM down, rewire the DRBD to another
> > hardware, and boot it again. No hot migration, if you meant that.
>
> OK, then definitely something weird happened inside btrfs code.
> But I'm out of any clue...
>
> >
> > I'm not sure how reliable DRBD is, but I researched it a little while
> > ago and it seems to prefer reliability over speed, so it looks very
> > solid. I don't think anything broke there, and even then 8 bytes of
> > garbage looks strange. Well, that's 64 bits of garbage - if that means
> > anything.
>
> Even if it's really some lower level storage corruption, it has to pass
> the btrfs metadata csum first.
> You really need a super lucky random corruption that still matches the cs=
um.
>
> Then you still need to pass tree-checker, which doesn't sounds
> reasonable to me at all.
>
> >
> >> As that's the only thing not btrfs I can think of, that would corrupt
> >> data at runtime.
> >
> > I'm using btrfs in various workloads, and even with partially broken
> > hardware (raid1 on spinning rust with broken sectors). And while it
> > had its flaws like 10+ years ago, it has been rock solid for me during
> > the last 5 years at least - even if I handled the hardware very
> > impatiently (like hitting the reset button or cycling power). Of
> > course, this system we're talking about has been handled seriously.
> > ;-)
>
> And we're also enhancing our handling on bad hardwares (except when they
> cheat on FLUSH), the biggest example is tree-checker.
>
> But I really run out of ideas for such a huge corruption.
> Your setup really rules out almost everything, from out-of-tree (Nv*dia
> drivers) to bad hot memory migration implementation.
>
> I'll let you know when the new tree-checker patch come out, and
> hopefully it can catch the root cause.

I've got your patch from linux-btrfs git (which you've sent to the
list yesterday). It looks like this cannot be applied to 6.6 LTS. Is
it part of a larger patch series and will be backported?

Is it safe to just cherry pick all patches saying "tree-checker" to
the 6.6 tree?

Thanks,
Kai

