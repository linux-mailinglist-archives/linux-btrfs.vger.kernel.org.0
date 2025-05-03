Return-Path: <linux-btrfs+bounces-13639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54FAA7E70
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 May 2025 06:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1027E7A7117
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 May 2025 04:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D47044C77;
	Sat,  3 May 2025 04:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asMt90GV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528618C031
	for <linux-btrfs@vger.kernel.org>; Sat,  3 May 2025 04:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746246873; cv=none; b=DUcwpucPcLqzPdPSZktgwC5OkkH6klXzPwDDO8QX/0cClwfroBoAigyPD9GXXAnD0jw+CUYaqFzHMM2zyn39YFTRe7XtLQK8PJHyQBAT1kfTYrnmFrDtXC7z5h3G0vV2jV/RBQ/RrPf8/xJRC+jGvdb6g5njLSoSnzQc6KeNvpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746246873; c=relaxed/simple;
	bh=3yenNUwEb1AYl/GKPXdQjmfTkt2Cd8M3auuHBESOxjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=O6jY1jONg42BtaU42Ms/uiGApFswU2vxMnSAwhuNyvyvvAyaRqkDyqRh8YxhRfKFmKbiZdnr9kQnbDn662xhwIoFssslNoTc2EqLhQvama6JiJBb+kz2jxpqMvJsGxC5dTC3RHNAblg5HrSp3Ytkb4THWfucKEESvyx/b9dzpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asMt90GV; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4c4cd68041dso1682048137.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 May 2025 21:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746246870; x=1746851670; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wENItxUwAjnz70HyMZQM8fwcqvXgPD0vAcYa3bKlCVY=;
        b=asMt90GVj7qaBL1+R4UjnSXVXuW9CCzUANi5NkyT/RzhMQwY2ijP6KRdsuFOzfn9uU
         o+aBTmgNfnAtnUU6whpO5t4i2g2McYCgtFYb8q5iSb6Emy2VkGScRgd2p7cDk0d+uWk/
         Y+LIPQNBppcdlaxr0gBnowlbW1OHOPU64rKaTRIr0jAS+5JtKLKkoNNk/WfoUJDDWwh/
         A9ifo5EtRMG2XZysZ/1ZdL9cEkGset+Vae1o43ZWJLcGEXPRCReeQ98ayBgoTax2OuPk
         sbi7j1cXHmGTmL+0wusD9mtzII6GqWhRQjsaLEJUgskOi3d3qlOHRDZx4wz+6DWr/Zvc
         D7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746246870; x=1746851670;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wENItxUwAjnz70HyMZQM8fwcqvXgPD0vAcYa3bKlCVY=;
        b=jzMeeuCjBheR82uzwyyk4k62T2P4/B8zxjqyuPBahdg4wkohrnVHak1qsCMcXCbm0u
         zGYSxQmRLfaT/+meWIiDIXCnKr3pP0DhaxLY3XC1YV0VGcfvpG8wog1CmjX3d255WEtp
         iRA6fT1I9py1MwOaD2V46sxLXSvIQLgAYiK9yzq5yRXS1eYmGkWfgSE2GHehAJlUKYsD
         TV2xO4LZ9VZtWEJXEZ7F2uPF7z27wPv8C2U1Fslc/uTNkH0P6nCkcTAzDB9FB14s9HBo
         gyLRxyEQpAe8rqP4OHyt/CjdVdxDMJXqKr2NdSnsNz2Tw29eWUkdb0yzwuMu1Zac6RKr
         ykGg==
X-Gm-Message-State: AOJu0Yygl0fzL8LtMt6a++qqza3WjXlWVpBuD731Bk1513GFDWl9tLTS
	5EKHVmskIUk3a8o6CCQFF7JgEk7PrTsXUw7YduVbOsQJnmckn+iRlO9YWq1+rXxp3TD8orhsDRv
	25TWrLNTCx5Eg4EOsfbbA8cDBSwtgXw==
X-Gm-Gg: ASbGncuzHUM+vRz3bK6UtYJjCeP9EkQMIB891PHCLnjRly1ukT19pYIeHrPDftw9SoO
	urtkZNqSRgoFj7L4x7RDxZn6K2kmV/Xn8fqG2Uqmsub6hI7oD2WEb+LfBZKbUB9PfzjsJhqkBnw
	JRxVzEbTCsEGbcwLKvXNLF+Khye8jjGpU=
X-Google-Smtp-Source: AGHT+IFOf+p9C1HbK/g0B3fYlEwy1o3bXqwz8rsqDQ/NcrOvTMfapyrCa+6lUZKOnNf5RgVhm9voM+1iWggPi+/IizA=
X-Received: by 2002:a05:6102:5615:b0:4da:d874:d2fa with SMTP id
 ada2fe7eead31-4db0c4009a9mr1009551137.24.1746246870038; Fri, 02 May 2025
 21:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1745893230-14268-mlmmj-729fb3af@vger.kernel.org>
 <CAC=1GgGRobZ7sMN6iBExMuYCRzNyei_mngkyRd=kvOX9rj90Lg@mail.gmail.com>
 <1be5f421-a36e-4a27-8c4b-73140f94a217@suse.com> <43dc4c77-cc8c-4c16-9fab-76833e2fc4dd@suse.com>
 <CAC=1GgEaY80tHuA1av-u8y43o_U-yF6-7b8kaDNLi=i5X-fGqw@mail.gmail.com>
In-Reply-To: <CAC=1GgEaY80tHuA1av-u8y43o_U-yF6-7b8kaDNLi=i5X-fGqw@mail.gmail.com>
From: Przemek Klosowski <przemek.klosowski@gmail.com>
Date: Sat, 3 May 2025 00:34:13 -0400
X-Gm-Features: ATxdqUGyqGVUbwxoGBg4BJinwTovkYr1m_YoS6uo1zR6YQoHbhEyrYB_7iMUVXk
Message-ID: <CAC=1GgFJ8oDYgpX3T5FFv3bvVyDwkA-ce9c1TEugE=j9NTmHvg@mail.gmail.com>
Subject: Fwd: Fwd: HTML message rejected: btrfs checksum error
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

   I guess the problem is you're still trying to scrub with that
rescue=3Didatacsums mount option?

No--it's my root fs so I mounted the individual device as
readonly/degraded, kind-of recursively in the same live fs. I just
wanted to see if I can recover more data, and thought it'd be safe
because of its readonly status.

Thank you for the suggestions---after deleting the problem file, all
is well (btrfs scrub shows no errors)

By the way, I was perplexed by the tooling, because it seems that I need to=
 run
 btrfs check --readonly --force --check-data-csum -p /dev/nvme0n1p2
on a live filesystem (it's my root fs) to get the error locations, and
it reports additional checksum errors due to the activity on the fs
(mozilla cache files, etc).

As you suggested, I extracted the offsets and piped to btrfs ins
logical, which gave multiple filenames. I knew which one was the real
one. I wonder if there's a way to avoid the fake ones? Of course I
could have booted from flash and mounted my real fs readonly under it,
got the filename, remounted rw and deleted the file.
Is there a simpler, recommended workflow for this case? Maybe making a snap=
shot?

BTW, btrfs dev stat keeps showing corruption_errs on both raid1
devices. Do you recommend 'btrfs dev stats -z' to zero them out?



On Tue, Apr 29, 2025 at 1:44=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/4/29 15:02, Qu Wenruo =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2025/4/29 11:55, Przemek Klosowski =E5=86=99=E9=81=93:
> >> I have a RAID1 btrfs root/home on Fedora 42 that developed what
> >> appears to be a single data checksum error. RAM tests fine, but it's a
> >> DELL system that had memory problems early on (years ago), that were
> >> fixed by Dell BIOS memory tests  (which changed the mem controller
> >> settings).
> >>
> >> The errors seem to have started right after a scrub (see btrfs
> >> messages from journal below)
> >>
> >> btrfs check --readonly --force --check-data-csum -p /dev/nvme0n1p2
> >>
> >> shows a cascade of errors (which seem to be increasing in number)
> >> ..
> >> [4/7] checking fs roots                        (0:00:04 elapsed, 60923
> >> items checked)
> >> mirror 1 bytenr 299511672832 csum 0x125beb3c expected csum
> >> 0xc8374bb569 items checked)
> >> mirror 1 bytenr 299511676928 csum 0x4c6adf72 expected csum 0xd82f54b8
> >> mirror 2 bytenr 299511672832 csum 0x125beb3c expected csum 0xc8374bb5
> >> mirror 2 bytenr 299511676928 csum 0x4c6adf72 expected csum 0xd82f54b8
> >> mirror 1 bytenr 306513821696 csum 0x8941f998 expected csum
> >> 0xa5fe1bfd94 items checked)
> >> mirror 1 bytenr 306513825792 csum 0x8941f998 expected csum 0x77c755d4
> >> .. and many more
> >>
> >> I can recover the file with only 1 4kB block zeroed out.
> >>
> >> Is there a way to read the bad sector? I thought that
> >> mount -o ro,degraded,rescue=3Dignoredatacsums/dev/sda5 /mnt
> >> would read data ignoring the bad checksum? as it is, it replicates the
> >> I/O error that is raised when reading the original file.
> >
> > It turns out to be a bug in the implementation, we expect to ignore bad
> > data csum error and return the data directly, but it's not implemented
> > if the csum tree is still valid...
> >
> > I'll send out a patch for that, but that will also mean with
> > rescue=3Didatacsums mount option, the data will only be the first one
> > btrfs read out.
>
> It is not a bug, it is already handled properly by completely ignoring
> the data csum tree.
>
> I guess the problem is you're still trying to scrub with that
> rescue=3Didatacsums mount option?
>
> That mount option is to be used with regular read, which will not do any
> verification now.
>
> Please verify if regular read on those files work.
>
> Thanks,
> Qu
>
> >
> > It'll be fine for your case, as both mirrors have the same csum.
> >
> >>
> >> Do you think that deleting the file with the bad checksum will solve
> >> this?
> >
> > Yes.
> >
> >> or should I move to rebuilding and restoring from backups?
> >
> > No need, "btrfs check --check-data-csum" is the most comprehensive chec=
k
> > we have and it only reports error of data checksum so far (better than
> > scrub because of the comprehensive metadata checks).
> >
> > Although you will need to find out all involved files, scrub is doing a
> > good job resolving the path, but the output may be ratelimited.
> >
> > I'd recommend to craft a small script, parsing all involved unique
> > bytenr into `btrfs ins logical` to get a full path to the affected file=
s.
> >
> > Thanks,
> > Qu
> >
> >>
> >>
> >> Apr 26 22:41:04 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
> >> started on devid 1
> >> Apr 26 22:41:04 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
> >> started on devid 2
> >> Apr 26 22:41:36 fedora kernel: BTRFS error (device nvme0n1p2): unable
> >> to fixup (regular) error at logical 452965761024 on dev /dev/nvme0n1p2
> >> physical 74303995904
> >> Apr 26 22:41:36 fedora kernel: BTRFS warning (device nvme0n1p2):
> >> checksum error at logical 452965761024 on dev /dev/nvme0n1p2, physical
> >> 74303995904, root 257, inode 35328, offset 26034176, length 4096,
> >> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
> >> Apr 26 22:42:52 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
> >> finished on devid 1 with status: 0
> >> Apr 26 22:45:46 fedora kernel: BTRFS error (device nvme0n1p2): unable
> >> to fixup (regular) error at logical 452965761024 on dev /dev/sda5
> >> physical 147297468416
> >> Apr 26 22:45:46 fedora kernel: BTRFS warning (device nvme0n1p2):
> >> checksum error at logical 452965761024 on dev /dev/sda5, physical
> >> 147297468416, root 257, inode 35328, offset 26034176, length 4096,
> >> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
> >> Apr 26 22:48:45 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
> >> finished on devid 2 with status: 0
> >> Apr 26 22:53:23 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
> >> started on devid 2
> >> Apr 26 22:53:23 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
> >> started on devid 1
> >> Apr 26 22:53:52 fedora kernel: BTRFS error (device nvme0n1p2): unable
> >> to fixup (regular) error at logical 452965761024 on dev /dev/nvme0n1p2
> >> physical 74303995904
> >> Apr 26 22:53:52 fedora kernel: BTRFS warning (device nvme0n1p2):
> >> checksum error at logical 452965761024 on dev /dev/nvme0n1p2, physical
> >> 74303995904, root 257, inode 35328, offset 26034176, length 4096,
> >> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
> >> Apr 26 22:55:07 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
> >> finished on devid 1 with status: 0
> >> Apr 26 22:58:04 fedora kernel: BTRFS error (device nvme0n1p2): unable
> >> to fixup (regular) error at logical 452965761024 on dev /dev/sda5
> >> physical 147297468416
> >> Apr 26 22:58:04 fedora kernel: BTRFS warning (device nvme0n1p2):
> >> checksum error at logical 452965761024 on dev /dev/sda5, physical
> >> 147297468416, root 257, inode 35328, offset 26034176, length 4096,
> >> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
> >> Apr 26 23:01:01 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
> >> finished on devid 2 with status: 0
> >> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
> >> 0xcf4a5572 mirror 1
> >> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> >> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
> >> 0xcf4a5572 mirror 2
> >> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> >> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
> >> 0xcf4a5572 mirror 1
> >> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> >> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
> >> 0xcf4a5572 mirror 2
> >> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> >> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
> >> 0xcf4a5572 mirror 1
> >> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
> >> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
> >> 0xcf4a5572 mirror 2
> >> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
> >> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
> >> 0xcf4a5572 mirror 1
> >> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> >> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
> >> 0xcf4a5572 mirror 2
> >> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> >> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
> >> 0xcf4a5572 mirror 1
> >> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
> >> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
> >> 0xcf4a5572 mirror 2
> >> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
> >> Apr 27 07:35:55 fedora kernel: btrfs_print_data_csum_error: 2
> >> callbacks suppressed
> >> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
> >> 0xcf4a5572 mirror 2
> >> Apr 27 07:35:55 fedora kernel: btrfs_dev_stat_inc_and_print: 2
> >> callbacks suppressed
> >> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
> >> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
> >> 0xcf4a5572 mirror 1
> >> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
> >> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
> >> 0xcf4a5572 mirror 2
> >> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
> >> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
> >> 0xcf4a5572 mirror 1
> >> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
> >> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
> >> 0xcf4a5572 mirror 2
> >> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
> >> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
> >> 0xcf4a5572 mirror 1
> >> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
> >> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
> >> 0xcf4a5572 mirror 2
> >> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
> >> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
> >> 0xcf4a5572 mirror 1
> >> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
> >> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
> >> 0xcf4a5572 mirror 2
> >> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
> >> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
> >> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
> >> 0xcf4a5572 mirror 1
> >> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
> >> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
> >>
> >
> >
>

