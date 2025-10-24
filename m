Return-Path: <linux-btrfs+bounces-18276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D06C05948
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 12:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D7D3B5BA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D11C30F946;
	Fri, 24 Oct 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcU+Bzgy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821FA303A1A
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301615; cv=none; b=u9uWf3PfPvfyb9WdP09iCZKEMhGCEdgwVblEnjJt2LCiW92sXvRK/2g00ujRMJnm9K1qxvm1Mc3s+HSCVV59dgZwYh4p/+SRn8mFiDUK1kERcw4b0Wx5xp3rxA9T6f1EVdnlDxF0ydfoujQk3V4tvD1wz5t2TWjuenI23fgTrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301615; c=relaxed/simple;
	bh=sLwYSBwzPaFcuE8u2F9ERDg61Knx8NBoYcDmM8ViFUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hx6qZVvCXeJFg1iRVN5G/kTkgR0cRO/qxCNNobicPkv8coE23Ug9pkC1T0VZijupRFufuc4U9/kqGGYfeSReOTqrkMlAoeX5dwsf5bnmVOZ0FkgxYaNZLoAqXqaHRy5SFiOrAJQ/6hby5O5JW9lt1eE4/BtZOXUS226ydcOS7Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcU+Bzgy; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5db3ec75828so243314137.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761301612; x=1761906412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gZINGWw1rCyGt10HoKjJBRIgLyeQYiebVqJBQhN1g0=;
        b=OcU+BzgyD08EUyoAZx2hlSzu0kEcqDFRzuX/rYaGruIk82Z0jMlyxAxG1JOJEtlVyI
         OfXLRj1diLcVEbNaGFJx1cIHv7opp4XF3tPNdS/fAQJp32pFIQ6tX6iUK9TWGcQ5IhlJ
         dCY62QGseOyGK0pM7xEPPeYQp2haykLf6VzrQ56pK6k6pbK8NS233ACZJ0+KtP7U2iow
         cp4nV5cll+kW40tk0/zr73OqlVOmqsgthX4Qb4x0AydulevevEPcL2W0f15Iy6uLv2//
         hCLE+z+hy2N+oCgrKzN7IKINfiitypi5MDjKgqKn32Zfru2BHhY86Lx1/a2gR/DtOlHf
         PzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761301612; x=1761906412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gZINGWw1rCyGt10HoKjJBRIgLyeQYiebVqJBQhN1g0=;
        b=ptvROsaLZ+4pLEBLS5Dn0N+VtGpbd9hoR3rqGB88KrZydB1jWxGeEclA6lknzTwL6u
         7GR/Kt9mA6clBaFVNtIc1wqHG004AOvQsiAXofO74G5NHPu9pvYrZGOA4itDQgZ/7L30
         h/RDtdbi/6VlFhe+/v9IK+PznU/rSkjaR2xj2+/qiZ60vZ79088Q0woQxtCDOm+6fk/E
         92FQWANYiXPJFzKWtlkQYGSpA/EuEe6jO+YQn6VoVZlVD+ZY9YU4dij6MRU6j6qwj7H+
         1OZgWiHKBJri4cunhLeSlXAiTpoal/EsRAFI+ZfmGnQrdK0spBi3Uhz+ZqkOglnwR0T/
         Pf5Q==
X-Gm-Message-State: AOJu0Yxg4LZgdJjTU9IBxxix/rU+Ph7fmTm8PxyA6TKUKFvn9MUv2oGe
	mi1tILMN511tKRfYfnLGiFYt8iT/SsDUe9e1VPXEs6HLLsvZFYoNhfSjtl8QyBVL6FDiIo5+3WE
	YJW1QunvEHKfAcsuAWXnER8zky6JegKg7TC5amfw=
X-Gm-Gg: ASbGnctRn7OugDQfLDFtQAo3yQOAAWggVCFzM55j/iPNPzSCLwR1fdujOCTPRoxW8fU
	tcvjAISR/UWa0xHIL6xX3QmUGFf2TYNYliCYvU0tR6tynlka79oMUcjbpm/OvIASO7JYjhj0/zo
	61yt29SyQzTM0XrfDjgOrWJhH0NWjG1GdOGrQyKprARi3ROofePh7fVdL6Yws83B7v85IYiHNax
	jK2ToZoPS8l0VjRWlbe7u30ofGtLqwZW2gSKqCbj+O3pZLRVVLiby2n/NNvaco98qubjMirFOwZ
	Xlfe0Bx76UWPxhyGd51VJ4ExPa0FrEl//C2k
X-Google-Smtp-Source: AGHT+IHNbBvkomeIw0knSHAe7U8sCks/2tBcWfFcyyeqtPHBFzBTS+1iMGrksKC9dzEUXbumDp/UT9fABUsyB/ZMt1g=
X-Received: by 2002:a05:6102:c4a:b0:5db:3ce5:9010 with SMTP id
 ada2fe7eead31-5db3ce5a729mr745364137.37.1761301612322; Fri, 24 Oct 2025
 03:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOsCCbPNqUkFqn2W_GprROor+ExuturJxWz-kVL_W5QvqAENSg@mail.gmail.com>
 <cd684028-5a7c-47bc-8095-02917fe46d6b@app.fastmail.com> <CAOsCCbOH_PRiExWLKPymdrCeNYCtfLgZ6khuGty-_m94MpOuMA@mail.gmail.com>
 <1330fe29-78a9-4628-b295-e3dcf2de15a9@app.fastmail.com>
In-Reply-To: <1330fe29-78a9-4628-b295-e3dcf2de15a9@app.fastmail.com>
From: =?UTF-8?Q?Tobiasz_Karo=C5=84?= <unfa00@gmail.com>
Date: Fri, 24 Oct 2025 12:26:41 +0200
X-Gm-Features: AWmQ_bk-F73WM0gLB7bmwUT90ClqOv1v9wjeVq97SSxVDS7lTJKtd-xkNJFwDw4
Message-ID: <CAOsCCbOeNGTS+MK4ZMDkg+PfVC0D9DR7iRXr+Hy6qK9sHgYjJg@mail.gmail.com>
Subject: Re: Damaged filesystem - request for support
To: Chris Murphy <lists@colorremedies.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I couldn't wait, so I have went ahead and run the check with --repair,
but the system froze after undetermined amount of time.
I was unsure if the repair has finished or not, but I could not regain
any control over the system, so I attempted to gracefully shut it down
with SysRq commands.

I have now re-run the check on an even newer version of btrfs-progs on
an Arch Linux system, and it seemed to find no errors now...

=E2=9D=AF btrfs check -p /dev/sde
Opening filesystem to check...
Checking filesystem on /dev/sde
UUID: a11787a5-de1d-421c-ac2e-b669f948b1f0
[1/8] checking log skipped (none written)
[1/7] checking root items                      (0:00:24 elapsed,
2642123 items checked)
[2/7] checking extents                         (0:03:19 elapsed,
649741 items checked)
[3/7] checking free space tree                 (0:00:14 elapsed, 9306
items checked)
[4/7] checking fs roots                        (0:05:36 elapsed, 10289
items checked)
[5/7] checking csums (without verifying data)  (0:05:37 elapsed,
981538 items checked)
[6/7] checking root refs                       (0:00:00 elapsed, 3
items checked)
[8/8] checking quota groups skipped (not enabled on this FS)
found 9978824622080 bytes used, no error found
total csum bytes: 9734550208
total tree bytes: 10645209088
total fs tree bytes: 169132032
total extent tree bytes: 235716608
btree space waste bytes: 459278040
file data blocks allocated: 9968179412992
referenced 9978512461824

Now the low-memory mode:

=E2=9D=AF btrfs check -p --mode=3Dlowmem /dev/sde
Opening filesystem to check...
Checking filesystem on /dev/sde
UUID: a11787a5-de1d-421c-ac2e-b669f948b1f0
[1/8] checking log skipped (none written)
[1/7] checking root items                      (0:00:24 elapsed,
2642123 items checked)
[2/7] checking extents                         (0:45:28 elapsed,
647281 items checked)
[3/7] checking free space tree                 (0:00:08 elapsed, 9306
items checked)
[4/7] checking fs roots                        (0:04:18 elapsed, 2655
items checked)
[5/7] checking csums (without verifying data)  (0:01:17 elapsed,
981538 items checked)
[7/8] checking root refs done with fs roots in lowmem mode, skipping
[8/8] checking quota groups skipped (not enabled on this FS)
found 9978824622080 bytes used, no error found
total csum bytes: 9734550208
total tree bytes: 10645209088
total fs tree bytes: 169132032
total extent tree bytes: 235716608
btree space waste bytes: 459278040
file data blocks allocated: 9968179412992
referenced 9978512461824


The system I am running this on is:
=E2=9D=AF btrfs --version
btrfs-progs v6.17
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=3Dli=
bgcrypt
=E2=9D=AF uname -a
Linux unfa-desktop 6.12.53-1-lts #1 SMP PREEMPT_DYNAMIC Wed, 15 Oct
2025 11:05:48 +0000 x86_64 GNU/Linux


I have started a scrub, since check reported no errors, and it's
working now. Seems like the problem is resolved:

Every 10.0s: btrfs scrub status .

                                 pve: Fri Oct 24 12:04:19 2025

UUID:             a11787a5-de1d-421c-ac2e-b669f948b1f0
Scrub started:    Fri Oct 24 11:21:29 2025
Status:           running
Duration:         0:42:47
Time left:        10:43:39
ETA:              Fri Oct 24 22:47:58 2025
Total to scrub:   9.08TiB
Bytes scrubbed:   579.84GiB  (6.23%)
Rate:             231.30MiB/s
Error summary:    no errors found


On Thu, Oct 23, 2025 at 10:09=E2=80=AFPM Chris Murphy <lists@colorremedies.=
com> wrote:
>
>
>
> On Thu, Oct 23, 2025, at 4:53 AM, Tobiasz Karo=C5=84 wrote:
> > Chris, thank you for such a detailed breakdown of what happened.
> > I have disconnected the drives once or maybe even twice to try and rese=
t things. I don't recall exact reasoning, but them disconnecting was not du=
e to power loss. The enclosure is powered with it's own 12-V power adapter =
plugged into mains. The exact model is StarTech SDOCK2U33V.
>
> OK so if the problem isn't power related, it's just a quirk/incompatibili=
ty between the kernel and the enclosure firmware.
>
> If the new kernel doesn't resolve the problem, options are are to disable=
 uas or use a good USB hub which will "normalizes" the USB stream, i.e. the=
 USB stream is not merely rebroadcast to the host, and vice versa.
>
> But in any case, I advise disabling the write cache for both drives, that=
 should ensure write order is honored, and protect in case of crash or powe=
r failure or forced reboots. But especially for doing repair because if rep=
air writes aren't fully flushed to disk, and then there's a crash - I expec=
t there'd be a lot of confusion, possibly unrepairable.
>
> I can't tell from the dmesg if the out of order writes are due to the com=
mand queue errors. It's actually pretty common that the drive firmware will=
 silently ignore flush fua, and doesn't even always ignore. In which case y=
ou never know about it until there's a crash or power failure and then a pr=
oblem appears.
>
>
>
>
> >
> > I have another Linux system I want to use to fix the Btrfs errors, it's=
 running MX Linux. I have updated btrfs-progs from Debian backports reposit=
ory so the system is:
> >
> > unfa@mx-workstation ~> btrfs --version
> > btrfs-progs v6.14
> > -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=
=3Dbuiltin
> > unfa@mx-workstation ~> uname -a
> > Linux mx-workstation 6.15.11-1-liquorix-amd64 #1 ZEN SMP PREEMPT_DYNAMI=
C liquorix 6.15-12~mx23ahs (2025-08-23) x86_64 GNU/Linux
> > Is that configuration of kernel + btrfs-progs versions safe to run btrf=
s check --repari on my broken Btrfs FS?
>
> The versions are fine, but again the Btrfs probably isn't broken. The pro=
blem reported by the older btrfs check is a minor issue and unrelated to wh=
at's going on. It's a good idea to run the `btrfs check` (no repair) with t=
he new version and post that here and see if there are different problems.
>
> Also, `btrfs check --mode=3Dlowmem` might reveal different problems since=
 it's a different implementation of check. So it's worth seeing that output=
 as well.
>
>
> > Thank you once more for detailed write-up. I'll look into UDEV to disab=
le the write cache for them and the UAS driver. I was hoping UAS can give m=
e better performance over USB 3.2, but if it's buggy it might be not worth =
the risk.
>
> It's possible the newer kernel will resolve the problem. These sorts of q=
uirks are constantly being fixed in the kernel. But only if users report th=
e problem to kernel usb folks.
>
>
> --
> Chris Murphy



--=20
- Tobiasz 'unfa' Karo=C5=84

www.youtube.com/unfa000

