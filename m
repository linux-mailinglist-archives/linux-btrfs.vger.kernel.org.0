Return-Path: <linux-btrfs+bounces-18326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 31751C08E25
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 10:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AFBD34D89E
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3A22C3757;
	Sat, 25 Oct 2025 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0+Bj5H+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C22C3256
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761382737; cv=none; b=coPuO4jCgtY4bbG4E3SaVamGwTr4IZZV/qT2uwdP4Hvh4nbzOXvBqaos8mYHGhDmw+xc/RXQgrtxTyUgusRO+GNfOD8sNB3m2cdSfQLIWp2apPogCDnjoR00ycARczfcB6+di/cXecIxIjwyPH0OD4kZczCbGsAb+BWqiaImkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761382737; c=relaxed/simple;
	bh=9rvsqP5Xq3+GjeU2CPNMHDshWJSgEbMACsrHedNvfpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCq1WxgAgzb0kEmvcep556Rpxo1LGEr2KItBRYZ2vsifoMaUDS0dJ4kdIKNnRpDTKl+Ym82FHeDsmij/fVN4szrpsIDE5q302cmMFRPRC2OiW1mxtv5OCKVDIw55fhZum5BMgo8b/lw5inCJXqADwD7qxwAoNWIIrnRSqCsBDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0+Bj5H+; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5db3b074f58so2380793137.2
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 01:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761382734; x=1761987534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGd7V0/Cq36wvleHqktRrJw8X/RXTEChSaSliirK5KY=;
        b=j0+Bj5H+vpQ40vWLexyWhfOtYSfwQyOeJ+mCL+4pWLXUpIFcUxOKdpDUajtaZ9v8e3
         xPPRR9gJrWHua5FyxG7fgDD8f1pewfEHPMxAPRrCBUGjsUR3OAxDYSn4dM+ROnxiLHA4
         km9Uzzi7nzI0H2yRveZE0o+Kp7O2pGUZTPsPswAyjchwGMhbzmaQXhSVlqmSlULtXA/0
         1lGu7AR4hRR59RT2uA2qAR8btQ9QyDyN+IKbvCjF+XJFKf9ctQMN5kHXDoJmQQMYsWDp
         c6RPcDDWc1wLEv2dyIKNpSzAvKhN/TvVrovs+P55xu9nElfjKy7A7zJYW7psHvxHGXj8
         u9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761382734; x=1761987534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGd7V0/Cq36wvleHqktRrJw8X/RXTEChSaSliirK5KY=;
        b=QiiefmNCQnF7b5UGhLK4HHhjCDhRSykViZKq/53XOtmmwsQ81gOlHwYriGkvJ/C9MP
         gh9JtsDOcl/+19py9VHf0nCQxljrlqMjaMnYOCastA7NVgXfSQ2jZ7Wn5rGUjeNA6+qW
         +fyfVc0/K4ltzS0c6fO4NnDL7GABxorAc0+nD9Fu5k3WT/ePfcVjO9jyCUjfdCL/lqJM
         D7ZiWbvw8aWUfczm8PCnZTfovxr0IQC75Wm2Fpi1K/5Z05VMqVjWIRF97euagsvyRHyL
         ZobGpKJ7xOvucSwZ33bzz+DW7gKJxN7UEliyrgwHhLLZAVA1HDFnuUWu0aHuYwGs8yx9
         aboQ==
X-Gm-Message-State: AOJu0YwkJ7i7hJ7Ewq1IaEWRk830nRVb1GTdRCpYU7VVriLcOpii5mT6
	JBveRWBL7ACDF3tfISWjn13d+VA6tRhQAwHVs/D29xVSz6Umf1JqevUhfv0/xCZpzBeEqXCpXJy
	sQnwFs/JdK7uHDEZ6I76HpyFfePZiBvN+shugCj4=
X-Gm-Gg: ASbGncueJqK18xoAaol6Va6Ey1/aGc4bkJKJ2NCBd/zAkI0OzLTjU8Sp+qnuCDBsfYR
	A++BOEGFDMSGjTRR6cFG1snkDSHgjuZ0QoMIk96tBgfyjaooJHQyGCHdZ9ey6RUJcNPUqSOaod1
	Pfn65vuNqpYukeaVxa5wtgzbKRhCIBcz0cA0gfbinb2Jp3be01wcgHhduNRDNGDGWu+GuIhC1aB
	t4GKoLr5UL5bHgCBr9GaEeK9C8klKabcL8hpEcP2VNK4U4UiTbH726ADC0RrfZB3v8YloOt1Z2O
	PiJ6rgGHChWgKMxtwzwjMMRamA==
X-Google-Smtp-Source: AGHT+IEK2/wQAzBIz2JNcBDi+v04jnvzm9OYs0FUpb8+rHqup+/x4dc3VUMW1rsFOVcIrR83Ob9w3zvzgsvbxeOvc04=
X-Received: by 2002:a05:6102:3f04:b0:5d6:27c7:e6b2 with SMTP id
 ada2fe7eead31-5d7dd502043mr4560396137.3.1761382734074; Sat, 25 Oct 2025
 01:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOsCCbPNqUkFqn2W_GprROor+ExuturJxWz-kVL_W5QvqAENSg@mail.gmail.com>
 <cd684028-5a7c-47bc-8095-02917fe46d6b@app.fastmail.com> <CAOsCCbOH_PRiExWLKPymdrCeNYCtfLgZ6khuGty-_m94MpOuMA@mail.gmail.com>
 <1330fe29-78a9-4628-b295-e3dcf2de15a9@app.fastmail.com> <CAOsCCbOeNGTS+MK4ZMDkg+PfVC0D9DR7iRXr+Hy6qK9sHgYjJg@mail.gmail.com>
In-Reply-To: <CAOsCCbOeNGTS+MK4ZMDkg+PfVC0D9DR7iRXr+Hy6qK9sHgYjJg@mail.gmail.com>
From: =?UTF-8?Q?Tobiasz_Karo=C5=84?= <unfa00@gmail.com>
Date: Sat, 25 Oct 2025 10:58:42 +0200
X-Gm-Features: AWmQ_blCC9Exz5KHltBQmtCvwKg-eVBCuKPqAuw6yZQmTq2vvtB6s0LrXZnE8vI
Message-ID: <CAOsCCbPRE-kXtBXHLxu179q63_HoRby0a4fZukziMUxjzYRhuQ@mail.gmail.com>
Subject: Re: Damaged filesystem - request for support
To: Chris Murphy <lists@colorremedies.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here's scrub status:


UUID:             a11787a5-de1d-421c-ac2e-b669f948b1f0
Scrub started:    Fri Oct 24 11:21:29 2025
Status:           finished
Duration:         15:49:35
Total to scrub:   9.09TiB
Rate:             167.21MiB/s
Error summary:    csum=3D1068
 Corrected:      172
 Uncorrectable:  896
 Unverified:     0

I assume this means I can continue to use the filesystem, accepting
that a number of files will be inaccessible and result in i/o errors
when accessed?
Since the data is replacable (assuming I don't need to go back to an
older backup, which I don't currently have a need for), I can destroy
this filesystem and start anew with a clean borg backup.
I am not sure what would be better.
I don't want the FS to constantly remount in ro mode due to i/o errors.

On Fri, Oct 24, 2025 at 12:26=E2=80=AFPM Tobiasz Karo=C5=84 <unfa00@gmail.c=
om> wrote:
>
> I couldn't wait, so I have went ahead and run the check with --repair,
> but the system froze after undetermined amount of time.
> I was unsure if the repair has finished or not, but I could not regain
> any control over the system, so I attempted to gracefully shut it down
> with SysRq commands.
>
> I have now re-run the check on an even newer version of btrfs-progs on
> an Arch Linux system, and it seemed to find no errors now...
>
> =E2=9D=AF btrfs check -p /dev/sde
> Opening filesystem to check...
> Checking filesystem on /dev/sde
> UUID: a11787a5-de1d-421c-ac2e-b669f948b1f0
> [1/8] checking log skipped (none written)
> [1/7] checking root items                      (0:00:24 elapsed,
> 2642123 items checked)
> [2/7] checking extents                         (0:03:19 elapsed,
> 649741 items checked)
> [3/7] checking free space tree                 (0:00:14 elapsed, 9306
> items checked)
> [4/7] checking fs roots                        (0:05:36 elapsed, 10289
> items checked)
> [5/7] checking csums (without verifying data)  (0:05:37 elapsed,
> 981538 items checked)
> [6/7] checking root refs                       (0:00:00 elapsed, 3
> items checked)
> [8/8] checking quota groups skipped (not enabled on this FS)
> found 9978824622080 bytes used, no error found
> total csum bytes: 9734550208
> total tree bytes: 10645209088
> total fs tree bytes: 169132032
> total extent tree bytes: 235716608
> btree space waste bytes: 459278040
> file data blocks allocated: 9968179412992
> referenced 9978512461824
>
> Now the low-memory mode:
>
> =E2=9D=AF btrfs check -p --mode=3Dlowmem /dev/sde
> Opening filesystem to check...
> Checking filesystem on /dev/sde
> UUID: a11787a5-de1d-421c-ac2e-b669f948b1f0
> [1/8] checking log skipped (none written)
> [1/7] checking root items                      (0:00:24 elapsed,
> 2642123 items checked)
> [2/7] checking extents                         (0:45:28 elapsed,
> 647281 items checked)
> [3/7] checking free space tree                 (0:00:08 elapsed, 9306
> items checked)
> [4/7] checking fs roots                        (0:04:18 elapsed, 2655
> items checked)
> [5/7] checking csums (without verifying data)  (0:01:17 elapsed,
> 981538 items checked)
> [7/8] checking root refs done with fs roots in lowmem mode, skipping
> [8/8] checking quota groups skipped (not enabled on this FS)
> found 9978824622080 bytes used, no error found
> total csum bytes: 9734550208
> total tree bytes: 10645209088
> total fs tree bytes: 169132032
> total extent tree bytes: 235716608
> btree space waste bytes: 459278040
> file data blocks allocated: 9968179412992
> referenced 9978512461824
>
>
> The system I am running this on is:
> =E2=9D=AF btrfs --version
> btrfs-progs v6.17
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=3D=
libgcrypt
> =E2=9D=AF uname -a
> Linux unfa-desktop 6.12.53-1-lts #1 SMP PREEMPT_DYNAMIC Wed, 15 Oct
> 2025 11:05:48 +0000 x86_64 GNU/Linux
>
>
> I have started a scrub, since check reported no errors, and it's
> working now. Seems like the problem is resolved:
>
> Every 10.0s: btrfs scrub status .
>
>                                  pve: Fri Oct 24 12:04:19 2025
>
> UUID:             a11787a5-de1d-421c-ac2e-b669f948b1f0
> Scrub started:    Fri Oct 24 11:21:29 2025
> Status:           running
> Duration:         0:42:47
> Time left:        10:43:39
> ETA:              Fri Oct 24 22:47:58 2025
> Total to scrub:   9.08TiB
> Bytes scrubbed:   579.84GiB  (6.23%)
> Rate:             231.30MiB/s
> Error summary:    no errors found
>
>
> On Thu, Oct 23, 2025 at 10:09=E2=80=AFPM Chris Murphy <lists@colorremedie=
s.com> wrote:
> >
> >
> >
> > On Thu, Oct 23, 2025, at 4:53 AM, Tobiasz Karo=C5=84 wrote:
> > > Chris, thank you for such a detailed breakdown of what happened.
> > > I have disconnected the drives once or maybe even twice to try and re=
set things. I don't recall exact reasoning, but them disconnecting was not =
due to power loss. The enclosure is powered with it's own 12-V power adapte=
r plugged into mains. The exact model is StarTech SDOCK2U33V.
> >
> > OK so if the problem isn't power related, it's just a quirk/incompatibi=
lity between the kernel and the enclosure firmware.
> >
> > If the new kernel doesn't resolve the problem, options are are to disab=
le uas or use a good USB hub which will "normalizes" the USB stream, i.e. t=
he USB stream is not merely rebroadcast to the host, and vice versa.
> >
> > But in any case, I advise disabling the write cache for both drives, th=
at should ensure write order is honored, and protect in case of crash or po=
wer failure or forced reboots. But especially for doing repair because if r=
epair writes aren't fully flushed to disk, and then there's a crash - I exp=
ect there'd be a lot of confusion, possibly unrepairable.
> >
> > I can't tell from the dmesg if the out of order writes are due to the c=
ommand queue errors. It's actually pretty common that the drive firmware wi=
ll silently ignore flush fua, and doesn't even always ignore. In which case=
 you never know about it until there's a crash or power failure and then a =
problem appears.
> >
> >
> >
> >
> > >
> > > I have another Linux system I want to use to fix the Btrfs errors, it=
's running MX Linux. I have updated btrfs-progs from Debian backports repos=
itory so the system is:
> > >
> > > unfa@mx-workstation ~> btrfs --version
> > > btrfs-progs v6.14
> > > -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPT=
O=3Dbuiltin
> > > unfa@mx-workstation ~> uname -a
> > > Linux mx-workstation 6.15.11-1-liquorix-amd64 #1 ZEN SMP PREEMPT_DYNA=
MIC liquorix 6.15-12~mx23ahs (2025-08-23) x86_64 GNU/Linux
> > > Is that configuration of kernel + btrfs-progs versions safe to run bt=
rfs check --repari on my broken Btrfs FS?
> >
> > The versions are fine, but again the Btrfs probably isn't broken. The p=
roblem reported by the older btrfs check is a minor issue and unrelated to =
what's going on. It's a good idea to run the `btrfs check` (no repair) with=
 the new version and post that here and see if there are different problems=
.
> >
> > Also, `btrfs check --mode=3Dlowmem` might reveal different problems sin=
ce it's a different implementation of check. So it's worth seeing that outp=
ut as well.
> >
> >
> > > Thank you once more for detailed write-up. I'll look into UDEV to dis=
able the write cache for them and the UAS driver. I was hoping UAS can give=
 me better performance over USB 3.2, but if it's buggy it might be not wort=
h the risk.
> >
> > It's possible the newer kernel will resolve the problem. These sorts of=
 quirks are constantly being fixed in the kernel. But only if users report =
the problem to kernel usb folks.
> >
> >
> > --
> > Chris Murphy
>
>
>
> --
> - Tobiasz 'unfa' Karo=C5=84
>
> www.youtube.com/unfa000



--=20
- Tobiasz 'unfa' Karo=C5=84

www.youtube.com/unfa000

