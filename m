Return-Path: <linux-btrfs+bounces-2879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E045F86B868
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 20:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465A4B21F22
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 19:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EECA15E5C3;
	Wed, 28 Feb 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4DXfilV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5712CA8;
	Wed, 28 Feb 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149080; cv=none; b=NT8TbNMVHYM/vfJWnJCbl3bNQLIN2ZKv2fBtH8cGp3fDwZ/KjwN4mMfhxqIy7aSCh0rmFbWVNeOBWst0xbCaSQWSIvRb/vIoCZML29QLb3k/ayg2AeeEEsWNUcNeAEf4swm8mT+fqig3MWwnQC5kEFL6ZPcDY3Isw4t7iPzjGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149080; c=relaxed/simple;
	bh=EFmB4lWDphV8+EpOjlrT5HS+VlJ+NqK1Vzka+3xudRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJBJbLpAhsd49PQbIrD//UtsCbaNTQXMirO62mYfIh/4rUPqZCf93epUI4z1lo/rOzIawQTDPzCLtkYyAgQugJgfw7sETA9LX0nODtk+hZTmhh5sXm3nYLPUR/RJ3wq484vYmh/sLIM2q/4ugb3M9mdGWIykGqq9tzJlF+EH3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4DXfilV; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d220e39907so1330011fa.1;
        Wed, 28 Feb 2024 11:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709149077; x=1709753877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyl4cRu1qlUcGFJZjiydTaxtRFK5CrOEvpLgHrcgqZA=;
        b=X4DXfilV0PhI7TAOGQo0dS8kf6kB+PaKk/R/xcT/DvlZgxG/4F4SlTBVm3AM5cp/6M
         T6TgST5HcdagWIAMI77d1kuhxXAkIzq6Y1s39ppF4P+GB1fS8nwQ83Sv7QC1wRelp9Yr
         qM+ZKzuYqtVVIyGVlQsc4mO1FiB0mb57qQKEvGRq76lhpHMXTutC5k55ICcaRR9eLJMe
         iURWyzK5x7LO64aNFzHXbG9KX+y7zndTeMJ1Y6IwDZW1/vWfnlPKfJxxpb2QIVKSrMZA
         cY6CSI4HqTVyohbUmzQiY/qGmYHZG0r51vLI7R/R2EmpPEqQ3Ru5s2UOOqmQ9t8e43k0
         /kiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709149077; x=1709753877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyl4cRu1qlUcGFJZjiydTaxtRFK5CrOEvpLgHrcgqZA=;
        b=YKLVEQkfdFBPNWjb04lYHeRCd6bB2w+we5bU5XhruMSU4zFNFgpldJXByO+zTcAnUW
         H6rW/Gs5Dt/bwsStLwBtc0jLs8HmLwGUHNNpohFCxDjyrtCKViZkNaHHsijLn9A9iimc
         iBVNXE1DYGpV4TcdvkpIb7Ylm1AQiUY7Ig0sm7OD9zTDFssiHpBhY7swFzojx4OGLUDo
         nqku3rRTdm+WybqCf4GYo/Dj+7sK/LYUYn+JD3nTZ6RPVee00zmukMNR+gFWqNo9k6qK
         y443bAcTudT2ikknDH+KedI+dWxx+KfgtQiqkHHxCtfDIzvkvLGJV1zruKI05WvyeaDf
         M03w==
X-Forwarded-Encrypted: i=1; AJvYcCWIrjUcq4k+ap8X7PkkLJZab0WHsXIRphTTYviOKLiLjEwex4l1ljdH9m8gVfaI8qHQ7TBG/HWBp2BJ7nzhpEjdadP8yvhG4dBq4PNoCDT34bVEa1DGxUp8lx9pkTonbNQMpX5pHfiB+Ok=
X-Gm-Message-State: AOJu0YwlJQo59OyTpNGcl1ZBDeaK7iitMWySO5T7FRiJA08noOsyaxs4
	ykj/fAsvwzAfM4KR9tDPP5vfhkEv17N3jlxxiEBQeMjvWaGH51C17NrnDUCzMOr6GhgdVXGi+M0
	c76og/d1939qeuqrNVHKyaRs4Na8=
X-Google-Smtp-Source: AGHT+IFr8Dy0vd+CWwPk6/6vxQc4Lc0pIfgo9F4ScipgWNlM+NiqFebxiO0hpCqIsRTpWsBoy5CcS04jzTzjwy6WBdE=
X-Received: by 2002:a2e:92c9:0:b0:2d2:393d:91b7 with SMTP id
 k9-20020a2e92c9000000b002d2393d91b7mr8098184ljh.52.1709149076723; Wed, 28 Feb
 2024 11:37:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOCpoWc_HQy4UJzTi9pqtJdO740Wx5Yd702O-mwXBE6RVBX1Eg@mail.gmail.com>
 <CAOCpoWf3TSQkUUo-qsj0LVEOm-kY0hXdmttLE82Ytc0hjpTSPw@mail.gmail.com>
 <CAOCpoWeNYsMfzh8TSnFqwAG1BhAYnNt_J+AcUNqRLF7zmJGEFA@mail.gmail.com> <672e88f2-8ac3-45fe-a2e9-730800017f53@libero.it>
In-Reply-To: <672e88f2-8ac3-45fe-a2e9-730800017f53@libero.it>
From: Patrick Plenefisch <simonpatp@gmail.com>
Date: Wed, 28 Feb 2024 14:37:45 -0500
Message-ID: <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
Subject: Re: [REGRESSION] LVM-on-LVM: error while submitting device barriers
To: kreijack@inwind.it
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, regressions@lists.linux.dev, dm-devel@lists.linux.dev, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 2:19=E2=80=AFPM Goffredo Baroncelli <kreijack@liber=
o.it> wrote:
>
> On 28/02/2024 18.25, Patrick Plenefisch wrote:
> > I'm unsure if this is just an LVM bug, or a BTRFS+LVM interaction bug,
> > but LVM is definitely involved somehow.
> > Upgrading from 5.10 to 6.1, I noticed one of my filesystems was
> > read-only. In dmesg, I found:
> >
> > BTRFS error (device dm-75): bdev /dev/mapper/lvm-brokenDisk errs: wr
> > 0, rd 0, flush 1, corrupt 0, gen 0
> > BTRFS warning (device dm-75): chunk 13631488 missing 1 devices, max
> > tolerance is 0 for writable mount
> > BTRFS: error (device dm-75) in write_all_supers:4379: errno=3D-5 IO
> > failure (errors while submitting device barriers.)
> > BTRFS info (device dm-75: state E): forced readonly
> > BTRFS warning (device dm-75: state E): Skipping commit of aborted trans=
action.
> > BTRFS: error (device dm-75: state EA) in cleanup_transaction:1992:
> > errno=3D-5 IO failure
> >
> > At first I suspected a btrfs error, but a scrub found no errors, and
> > it continued to be read-write on 5.10 kernels.
> >
> > Here is my setup:
> >
> > /dev/lvm/brokenDisk is a lvm-on-lvm volume. I have /dev/sd{a,b,c,d}
> > (of varying sizes) in a lower VG, which has three LVs, all raid1
> > volumes. Two of the volumes are further used as PV's for an upper VGs.
> > One of the upper VGs has no issues. The non-PV LV has no issue. The
> > remaining one, /dev/lowerVG/lvmPool, hosting nested LVM, is used as a
> > PV for VG "lvm", and has 3 volumes inside. Two of those volumes have
> > no issues (and are btrfs), but the last one is /dev/lvm/brokenDisk.
> > This volume is the only one that exhibits this behavior, so something
> > is special.
> >
> > Or described as layers:
> > /dev/sd{a,b,c,d} =3D> PV =3D> VG "lowerVG"
> > /dev/lowerVG/single (RAID1 LV) =3D> BTRFS, works fine
> > /dev/lowerVG/works (RAID1 LV) =3D> PV =3D> VG "workingUpper"
> > /dev/workingUpper/{a,b,c} =3D> BTRFS, works fine
> > /dev/lowerVG/lvmPool (RAID1 LV) =3D> PV =3D> VG "lvm"
> > /dev/lvm/{a,b} =3D> BTRFS, works fine
> > /dev/lvm/brokenDisk =3D> BTRFS, Exhibits errors
>
> I am a bit curious about the reasons of this setup.

The lowerVG is supposed to be a pool of storage for several VM's &
containers. [workingUpper] is for one VM, and [lvm] is for another VM.
However right now I'm still trying to organize the files directly
because I don't have all the VM's fully setup yet

> However I understood that:
>
> /dev/sda -+                +-- single (RAID1) -> ok             +-> a   o=
k
> /dev/sdb  |                |                                    |-> b   o=
k
> /dev/sdc  +--> [lowerVG]>--+-- works (RAID1) -> [workingUpper] -+-> c   o=
k
> /dev/sdd -+                |
>                             |                       +-> a          -> ok
>                             +-- lvmPool -> [lvm] ->-|
>                                                     +-> b          -> ok
>                                                     |
>                                                     +->brokenDisk  -> fai=
l
>
> [xxx] means VG, the others are LVs that may act also as PV in
> an upper VG

Note that lvmPool is also RAID1, but yes

>
> So, it seems that
>
> 1) lowerVG/lvmPool/lvm/a
> 2) lowerVG/lvmPool/lvm/a
> 3) lowerVG/lvmPool/lvm/brokenDisk
>
> are equivalent ... so I don't understand how 1) and 2) are fine but 3) is
> problematic.

I assume you meant  lvm/b for 2?

>
> Is my understanding of the LVM layouts correct ?

Your understanding is correct. The only thing that comes to my mind to
cause the problem is asymmetry of the SATA devices. I have one 8TB
device, plus a 1.5TB, 3TB, and 3TB drives. Doing math on the actual
extents, lowerVG/single spans (3TB+3TB), and
lowerVG/lvmPool/lvm/brokenDisk spans (3TB+1.5TB). Both obviously have
the other leg of raid1 on the 8TB drive, but my thought was that the
jump across the 1.5+3TB drive gap was at least "interesting"

>
>
> >
> > After some investigation, here is what I've found:
> >
> > 1. This regression was introduced in 5.19. 5.18 and earlier kernels I
> > can keep this filesystem rw and everything works as expected, while
> > 5.19.0 and later the filesystem is immediately ro on any write
> > attempt. I couldn't build rc1, but I did confirm rc2 already has this
> > regression.
> > 2. Passing /dev/lvm/brokenDisk to a KVM VM as /dev/vdb with an
> > unaffected kernel inside the vm exhibits the ro barrier problem on
> > unaffected kernels.
>
> Is /dev/lvm/brokenDisk *always* problematic with affected ( >=3D 5.19 ) a=
nd
> UNaffected ( < 5.19 ) kernel ?

Yes, I didn't test it in as much depth, but 5.15 and 6.1 in the VM
(and 6.1 on the host) are identically problematic

>
> > 3. Passing /dev/lowerVG/lvmPool to a KVM VM as /dev/vdb with an
> > affected kernel inside the VM and using LVM inside the VM exhibits
> > correct behavior (I can keep the filesystem rw, no barrier errors on
> > host or guest)
>
> Is /dev/lowerVG/lvmPool problematic with only "affected" kernel ?

Uh, passing lvmPool directly to the VM is never problematic. I tested
5.10 and 6.1 in the VM (and 6.1 on the host), and neither setup throws
barrier errors.

> [...]
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>

