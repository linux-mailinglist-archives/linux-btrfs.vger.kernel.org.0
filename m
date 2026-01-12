Return-Path: <linux-btrfs+bounces-20387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A52D3D10EC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 08:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E5530E5E9A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 07:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0D1331A5B;
	Mon, 12 Jan 2026 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3fhIIYa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3330CD82
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203449; cv=none; b=kj5u2+6IcZDp6RBCVEam+LwiFeNn9o4Lfdsp6Z645OSnXIF7yPTlWTXx3vLWX44yMH3EgTpZZEUWbatuGyCVkGexfnp+E+cGzG2xqkDc1IqNu9Q0Z4dwXYqTBNs1tEVO9HSmM1uXJjp14eL4P9afmGQqP5rklt6wcqwwvNXElBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203449; c=relaxed/simple;
	bh=igcvV5tveFM+IBfywoQrfitwEY7TeR/gNTAC8PNfH+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eyN6bepUmo/bYt0q+1a41lAR2LkvQteXLWnl351DK+F4gB0buQR2wk7CWXHq3bXwJ8RfcGEmBGQfBcBkf41Mnip5z97RjIBDxBmgQud9iQobh5eAfr8Wo+HTR3FhLPaJ/05k/+z8ayRKc5fiF7+vUhCtYqibvsDpwdOls/6W4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3fhIIYa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477770019e4so45885245e9.3
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 23:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768203446; x=1768808246; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs9j2ooXqTH4VLUvQnnEHJtLLQkcxsgYGgLDPvSGzVg=;
        b=J3fhIIYa1PkAA674QYFa+ixhV85JP5d5G+Rp0dZN0ls3jvoe9I5KvrbceZIRPMb9B4
         AL8PKSqp0yCEORsxKgwTCRmwM4HEUTou3Q4OcIm9Z9GICcraGDNS/HtecENKfP9a2kCG
         2Sa1KvFJ/0Rro3ErjXPjW/nwF33HttgVA629UsJMCAIgY+wMsUU8vqyTa2w4ecJP2oC/
         Bn3MQzrgXakjpV5OdALyikvNNMHK65C/B7DGfo6ayWi+B8PpN1oiQB7wW9/k3p/NIeiA
         /DXkdEsiw+bIoptHMjYTDNYdRWcxhcHSz1uZiG5AqMdQijJUGYy3Aohs7zMdX4KPQ03I
         4AGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203446; x=1768808246;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zs9j2ooXqTH4VLUvQnnEHJtLLQkcxsgYGgLDPvSGzVg=;
        b=jKa97BI6WOmZCFA4v6C7wPQwV+MWR198qmmRWwsuTFNxlX9PV5xa0NWPWAQcY4cTor
         PdlMoor0MKLfteU7BsrSw5QRkWINSLSlaKy/UvX+vpO3crbh11sunLi6ylLxtokIDkp6
         y02KJqVR3iEHe76WoMYMyMwh6SXvSU+FV1DDpp0ub0b50NAfYfQuWkk4bp2XnV5Slm+S
         MHN5wRJS5D9Ye4TMFxUi7Y7F5FX6EFplR7uIdSdLSJcb30pp7MmQG644i/xH/RrNN6C2
         6qHJrZUWQyAoFsl3yY69eOO4DJsqc+Z9mBt0gKZbHMCsqM5a5Kdh7CLW9y6wmO4MFj8E
         l2SQ==
X-Gm-Message-State: AOJu0Yw2c2DarCkreaLSJICr2IBWStJhKkju0/ZILdBwWrn52YZVWUGp
	v2Zoul13VNU94uWjQl1FClZ2u9jKA70Ru+t/oDCCpjnrYStxKtF3QTCcrUDLx+At7+ExyhwuaiH
	bYie6Af1FUDHGyjE+mblU4Nu6X2PYlpMGVfH4
X-Gm-Gg: AY/fxX6/X7xLCTB6xV6tlWQme3+TFfdqoiDuSM27/igw/x/6fKtoKk4aw/nDZ3cxfJT
	eabmBbY6+zKGozNnPoqrhfTsai3LnfCi0LrJsL9jJ/4EL7CrbHwbiWZaPSWUpCjOSl4ii2I/sR+
	XqrtCE4LWGHFwDHCJO83dHlX3fMa4A5+IttPlBjbpFN0RU5Y0UC/9nOnfytdSXqy9dwKU/g/F90
	832mziaqnxJ9sy93nw9gaeogRLx0pd0wD02rn0kJ+NyUV76eIYRjTHwfbUt/ArLQAIXy51JnClK
	J1J09BFBgnkpMeoKlnsfYP8S2CTkvZMmye8Qw/DMx2c16uygHNTzjrDrFj/s6knHmbnwwb0MLKv
	vM+ufkRjm0DxrEkAuCcYkv0BXubB0//+ovm4EK000WXQ=
X-Google-Smtp-Source: AGHT+IFY3nynGngJo9AJKTBTNGt0cQg+DFqTfeJ5BJvNsl643B+Fxlh6hXQDhuUpOcbwssLNfbXjxuzIrEuEkRgtvxk=
X-Received: by 2002:a05:600c:45ce:b0:47d:264e:b371 with SMTP id
 5b1f17b1804b1-47d84b30d79mr176655425e9.18.1768203445687; Sun, 11 Jan 2026
 23:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAYHqBbwwFUD5C7SyRYmrXKYtZfx=_=hQpXrSfk=oi5Dp=QUAA@mail.gmail.com>
 <81d852f0-80a5-423a-8882-c7553f0b4820@suse.com> <CAAYHqBaCqPSuu2Tyx7_VLhbb=z05mu1bP5iWMcxrjbUsqHZXtQ@mail.gmail.com>
 <097c661f-5e65-4802-8ac7-b6e0f740eb52@suse.com> <CAAYHqBZ48Yf5cd+nNzAnvE1_wHP-0sLyxe18wcdZ_pw3Nq8Ypg@mail.gmail.com>
 <2b2fc9bf-2976-4e33-8363-347f1beaf755@suse.com> <CAAYHqBZgrkB9N4_kqMoU+pW8nxvOpALTEmdAS3RtQf+Y2zJGJA@mail.gmail.com>
 <0a75c922-b1a4-46fd-909e-006c4022f8cf@suse.com> <CAAYHqBYU=cWgxms9qbFzyzeyLXGtF-1Rum=9keN7wLnRwq=4Xw@mail.gmail.com>
 <d9a1e5b0-be3d-42e2-a090-52e30a2e86f1@suse.com> <7d1841ed-fe58-45cc-a49e-59d67897752f@suse.com>
In-Reply-To: <7d1841ed-fe58-45cc-a49e-59d67897752f@suse.com>
From: Neil Parton <njparton@gmail.com>
Date: Mon, 12 Jan 2026 07:37:15 +0000
X-Gm-Features: AZwV_QguR029NU6xeff8N-bmB80X1B_JS7PVZ-yqeAQxI1D2SCYDK9yBhD_-ork
Message-ID: <CAAYHqBaGqw9YDy=5K50tzMe0zZpmTJ7x7P2cqtdVo+XecThGcQ@mail.gmail.com>
Subject: Re: After BTRFS replace, array can no longer be mounted even in
 degraded mode
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Qu I will heed your great advice

Kind regards

Neil

On Sun, 11 Jan 2026 at 22:19, Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2026/1/10 19:39, Qu Wenruo =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2026/1/10 19:29, Neil Parton =E5=86=99=E9=81=93:
> >> I guess you use 'btrfs dev scan --forget' to removed all devices
> >> before?  I may have done yes by mistake
> >>
> >> mount -o degraded,device=3D/dev/sda,device=3D/dev/sde,device=3D/dev/sd=
f \
> >>         /dev/sda /mnt/btrfs_raid2/
> >>
> >> This mounts now but I guess ro by default?
> >
> > No it's full RW, so you can do whatever you need to repair the array,
> > e.g. by replace devid 4 with another device.
> >
> > And in that case, I don't recommend to use the sdd again. Explained bel=
ow.
> >
> >> So now need to remove devid
> >> 4 somehow and then add /dev/sdd back in?
> >
> > Replace is always prefered than add-then-balance.
> >
> > But before all that, please run a memtest first if your system do not
> > have ECC memory just in case.
>
> This recommendation is strongly recommened, as now the situation looks
> like this can be a memory bitflip.
>
> The original devid is 0, meanwhile the should-be devid is 4, which is
> exactly one bit flipped.
>
> Furthermore, the bad super block has the correct generation as all other
> devices, so it means it's not the device missing a transaction.
>
> Finally since our super block writeback behavior is using page cache of
> the block device, we copy the common super block to that page cache.
> Thus if the physical page has a bitflip (in this case, maybe a bit
> sticking to 1), the error is only affecting a single device.
>
> So far this bitflip matches all the symptons, thus a memtest is very
> recommended.
> Or your fs (or the kernel) may experience all kind of weird behavior
> randomly.
>
> Thanks,
> Qu
>
> >
> >
> > I guess you're replacing sdc with sdd, but the super block of sdd shows
> > it has device id 0 instead of 4, and the device uuid doesn't match the
> > expected one.
> >
> > This may mean the device doesn't properly got its super block updated
> > when dev-replace finished.
> >
> > I don't know why and can only guess, but according to your original
> > dmesg it shows both the missing device (source device sdc), and the sdd
> > have a lot of read/write errors.
> >
> > Thus it may missed several important super block updates, causing the
> > current weird situation.
> >
> > It may be the device itself or not (e.g. bad cable?) but I won't trust
> > sdc nor sdd anymore.
> >
> > Thanks,
> > Qu
> >
> >>
> >> btrfs filesystem show
> >> Label: none  uuid: 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
> >>          Total devices 4 FS bytes used 14.80TiB
> >>          devid    3 size 18.19TiB used 7.53TiB path /dev/sdf
> >>          devid    4 size 0 used 0 path  MISSING
> >>          devid    5 size 18.19TiB used 7.53TiB path /dev/sda
> >>          devid    6 size 18.19TiB used 7.53TiB path /dev/sde
> >>
> >>
> >>
> >>
> >> On Sat, 10 Jan 2026 at 08:54, Qu Wenruo <wqu@suse.com> wrote:
> >>>
> >>>
> >>>
> >>> =E5=9C=A8 2026/1/10 19:18, Neil Parton =E5=86=99=E9=81=93:
> >>>> # btrfs device scan --forget /dev/sdd
> >>>> # mount -o degraded /dev/sda /mnt/btrfs_raid2/
> >>>> mount: /mnt/btrfs_raid2: can't read superblock on /dev/sda.
> >>>>          dmesg(1) may have more information after failed mount
> >>>> system call.
> >>>>
> >>>> dmesg | grep BTRFS
> >>>> [71195.807688] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3=
c9
> >>>> devid 5 transid 1394399 /dev/sda (8:0) scanned by mount (2344953)
> >>>> [71195.813380] BTRFS info (device sda): first mount of filesystem
> >>>> 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
> >>>> [71195.813393] BTRFS info (device sda): using crc32c (crc32c-intel)
> >>>> checksum algorithm
> >>>> [71195.814450] BTRFS warning (device sda): devid 3 uuid
> >>>> 0d596b69-fb0d-4031-b4af-a301d0868b8b is missing
> >>>> [71195.814453] BTRFS warning (device sda): devid 6 uuid
> >>>> 9edaf1d3-fab7-4dce-adfb-f7875fc02b48 is missing
> >>>> [71195.850708] BTRFS warning (device sda): devid 3 uuid
> >>>> 0d596b69-fb0d-4031-b4af-a301d0868b8b is missing
> >>>> [71195.850712] BTRFS warning (device sda): devid 4 uuid
> >>>> 01e2081c-9c2a-4071-b9f4-e1b27e571ff5 is missing
> >>>> [71195.850713] BTRFS warning (device sda): devid 6 uuid
> >>>> 9edaf1d3-fab7-4dce-adfb-f7875fc02b48 is missing
> >>>
> >>> This is the case where no device other than sda is scanned, thus fail=
ed
> >>> to mount.
> >>>
> >>> I guess you use 'btrfs dev scan --forget' to removed all devices befo=
re?
> >>>
> >>> Anyway, try this one instead:
> >>>
> >>> # btrfs device scan --forget
> >>> # mount -o degraded,device=3D/dev/sda,device=3D/dev/sde,device=3D/dev=
/sdf \
> >>>          /mnt/btrfs_raid2/
> >>>
> >>> This will manually scan that only 3 devices, thus should get sdd
> >>> excluded.
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>> [71195.961370] BTRFS error (device sda): failed to verify dev extent=
s
> >>>> against chunks: -5
> >>>> [71195.966084] BTRFS error (device sda): open_ctree failed: -5
> >>>>
> >>>> # btrfs ins dump-super -f /dev/sdc
> >>>> superblock: bytenr=3D65536, device=3D/dev/sdc
> >>>> ---------------------------------------------------------
> >>>> ERROR: bad magic on superblock on /dev/sdc at 65536 (use --force to
> >>>> dump it anyway)
> >>>>
> >>>> btrfs ins dump-super -f --force /dev/sdc
> >>>> https://www.dropbox.com/scl/fi/kq8bvpvt3tnaohiyzec3l/
> >>>> dump_super_sdc.txt?rlkey=3Dc1cqqsyulg15v9hlhqdh72dtb&dl=3D0
> >>>>
> >>>> On Sat, 10 Jan 2026 at 08:41, Qu Wenruo <wqu@suse.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> =E5=9C=A8 2026/1/10 18:57, Neil Parton =E5=86=99=E9=81=93:
> >>>>>> # btrfs ins dump-tree -t chunk /dev/sda
> >>>>>> https://www.dropbox.com/scl/fi/isn326on8423fxc3shwhe/
> >>>>>> dump_tree_sda.txt?rlkey=3D7h9nqjg53p1ad9x6f7498ewzd&dl=3D0
> >>>>>>
> >>>>>> # btrfs ins dump-super -f /dev/sda
> >>>>>> https://www.dropbox.com/scl/fi/pdhfwbcfn6rlgpg9ucb9d/
> >>>>>> dump_super_sda.txt?rlkey=3Diuc0n46vw7alx5rhbicwdagjz&dl=3D0
> >>>>>>
> >>>>>> # btrfs ins dump-super -f /dev/sdd
> >>>>>> https://www.dropbox.com/scl/fi/k5cu6t31hegt78lhp6qr3/
> >>>>>> dump_super_sdd.txt?rlkey=3D1p4f96ccshe03lr9jh0y3f5e9&dl=3D0
> >>>>>>
> >>>>>> # btrfs ins dump-super -f /dev/sde
> >>>>>> https://www.dropbox.com/scl/fi/tso5bi5nfyyy5x07yvkt9/
> >>>>>> dump_super_sde.txt?rlkey=3Dkwlbrldbaczc3fmpd3vu5osta&dl=3D0
> >>>>>>
> >>>>>> # btrfs ins dump-super -f /dev/sdf
> >>>>>> https://www.dropbox.com/scl/fi/bhqg8fsmrmuc8hmjqxm82/
> >>>>>> dump_super_sdf.txt?rlkey=3Dmb5xilui3t1l7hofge4osf3gu&dl=3D0
> >>>>>
> >>>>> Thanks a lot. This confirms a very weird situation.
> >>>>>
> >>>>> /dev/sdd is the causing of the problem. It has devid 0, resulting t=
he
> >>>>> mount to fail.
> >>>>>
> >>>>> Furthermore, there is a missing device (devid 4), but considering y=
our
> >>>>> profile is either RAID1C3 for metadata or RAID10, that missing devi=
ce
> >>>>> can be tolerated.
> >>>>>
> >>>>> For your current situation, you need to forget sdd, not sdc.
> >>>>>
> >>>>> # btrfs device scan --forget /dev/sdd
> >>>>>
> >>>>> Then try degraded mount.
> >>>>>
> >>>>> And if possible, also dump the super block of sdc, I assume that is
> >>>>> devid 4.
> >>>>>
> >>>>> # btrfs ins dump-super -f /dev/sdc
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>>
> >>>>>> On Sat, 10 Jan 2026 at 08:20, Qu Wenruo <wqu@suse.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> =E5=9C=A8 2026/1/10 17:40, Neil Parton =E5=86=99=E9=81=93:
> >>>>>>>> The replace had definitely finished some hours before I pulled
> >>>>>>>> the old
> >>>>>>>> drive after powering down/rebooting, the message was very clear =
and
> >>>>>>>> reported zero errors.  The old drive is no longer picked up by
> >>>>>>>> btrfs
> >>>>>>>> filesystem show or a scan (old drive is currently /dev/sdc)
> >>>>>>>>
> >>>>>>>> btrfs dev scan
> >>>>>>>> Scanning for Btrfs filesystems
> >>>>>>>> registered: /dev/sdf
> >>>>>>>> registered: /dev/sdd
> >>>>>>>> registered: /dev/sde
> >>>>>>>> registered: /dev/sda
> >>>>>>>>
> >>>>>>>> mount -o degraded /dev/sda /mnt/btrfs_raid2
> >>>>>>>> mount: /mnt/btrfs_raid2: fsconfig() failed: Structure needs
> >>>>>>>> cleaning.
> >>>>>>>>            dmesg(1) may have more information after failed mount
> >>>>>>>> system call.
> >>>>>>>>
> >>>>>>>> dmesg | grep BTRFS
> >>>>>>>> [64809.643840] BTRFS info (device sdd): first mount of filesyste=
m
> >>>>>>>> 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
> >>>>>>>> [64809.643876] BTRFS info (device sdd): using crc32c (crc32c-int=
el)
> >>>>>>>> checksum algorithm
> >>>>>>>> [64809.681807] BTRFS warning (device sdd): devid 4 uuid
> >>>>>>>> 01e2081c-9c2a-4071-b9f4-e1b27e571ff5 is missing
> >>>>>>>> [64810.765537] BTRFS info (device sdd): bdev <missing disk>
> >>>>>>>> errs: wr
> >>>>>>>> 84994544, rd 15567, flush 65872, corrupt 0, gen 0
> >>>>>>>> [64810.765560] BTRFS info (device sdd): bdev /dev/sdd errs: wr
> >>>>>>>> 71489901, rd 0, flush 30001, corrupt 0, gen 0
> >>>>>>>> [64810.765577] BTRFS error (device sdd): replace without active
> >>>>>>>> item,
> >>>>>>>> run 'device scan --forget' on the target device
> >>>>>>>> [64810.765591] BTRFS error (device sdd): failed to init
> >>>>>>>> dev_replace: -117
> >>>>>>>> [64810.782830] BTRFS error (device sdd): open_ctree failed: -117
> >>>>>>>>
> >>>>>>>> I've tried running ' btrfs device scan --forget' a few times but
> >>>>>>>> doesn't help.
> >>>>>>>>
> >>>>>>>> The output of btrfs ins dump-tree -t dev /dev/sda is saved to a
> >>>>>>>> text
> >>>>>>>> file you can access from here:
> >>>>>>>>
> >>>>>>>> https://www.dropbox.com/scl/fi/upsqo286j01t8y7pll111/dump.txt?
> >>>>>>>> rlkey=3D8burw4gottx35for7kaucvyh8&dl=3D0
> >>>>>>>
> >>>>>>> This indeed shows the dev replace is finished.
> >>>>>>>
> >>>>>>> But the kernel dmesg shows that there is still a device replaceme=
nt
> >>>>>>> source device there (devid 0), and there is also dev stats for
> >>>>>>> the devid 0.
> >>>>>>>
> >>>>>>> This means there is something wrong that prevents the dev-replace=
 to
> >>>>>>> delete that device.
> >>>>>>>
> >>>>>>> Just in case, please also dump the chunk tree and super block of
> >>>>>>> each
> >>>>>>> device:
> >>>>>>>
> >>>>>>> # btrfs ins dump-tree -t chunk /dev/sda
> >>>>>>>
> >>>>>>> # btrfs ins dump-super -f /dev/sda
> >>>>>>> # btrfs ins dump-super -f /dev/sdd
> >>>>>>> # btrfs ins dump-super -f /dev/sde
> >>>>>>> # btrfs ins dump-super -f /dev/sdf
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Qu
> >>>>>>>
> >>>>>>>>
> >>>>>>>> I really need to recover this array as it will take me weeks to
> >>>>>>>> re-establish it's contents and docker services.
> >>>>>>>>
> >>>>>>>> On Fri, 9 Jan 2026 at 22:47, Qu Wenruo <wqu@suse.com> wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> =E5=9C=A8 2026/1/9 21:22, Neil Parton =E5=86=99=E9=81=93:
> >>>>>>>>>> Running Arch 6.12.63-1-lts, btrfs-progs v6.17.1.  RAID10c3
> >>>>>>>>>> array of
> >>>>>>>>>> 4x20TB disks.
> >>>>>>>>>>
> >>>>>>>>>> Ran a replace command to replace a drive with errors with a
> >>>>>>>>>> new drive
> >>>>>>>>>> of equal size.  Replace appeared to finish after ~24 hours
> >>>>>>>>>> with zero
> >>>>>>>>>> errors but new array won't mount even with -o degraded and
> >>>>>>>>>> complains
> >>>>>>>>>> that it can't find devid 4 (the old drive which has been
> >>>>>>>>>> replaced but
> >>>>>>>>>> is still plugged in and recognised).
> >>>>>>>>>
> >>>>>>>>> This looks like the replace is not finished.
> >>>>>>>>>
> >>>>>>>>> As there is still a dev replace item.
> >>>>>>>>>
> >>>>>>>>> Have you tried to run "btrfs dev scan" so that btrfs can still
> >>>>>>>>> see the
> >>>>>>>>> old device, then try mount it again with dmesg pasted?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Also it would be better to dump the dev tree so that we can
> >>>>>>>>> check the
> >>>>>>>>> replace item:
> >>>>>>>>>
> >>>>>>>>>       # btrfs ins dump-tree -t dev /dev/sda
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>> Qu
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I've tried 'btrfs device scan --forget /dev/sdc' on the old dr=
ive
> >>>>>>>>>> which runs very quickly and doesn't return anything.
> >>>>>>>>>>
> >>>>>>>>>> mount -o degraded /dev/sda /mnt/btrfs_raid2
> >>>>>>>>>> mount: /mnt/btrfs_raid2: fsconfig() failed: Structure needs
> >>>>>>>>>> cleaning.
> >>>>>>>>>>             dmesg(1) may have more information after failed
> >>>>>>>>>> mount system call.
> >>>>>>>>>>
> >>>>>>>>>> dmesg | grep BTRFS
> >>>>>>>>>> [    2.677754] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-
> >>>>>>>>>> a7df525dc3c9
> >>>>>>>>>> devid 5 transid 1394395 /dev/sda (8:0) scanned by btrfs (261)
> >>>>>>>>>> [    2.677875] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-
> >>>>>>>>>> a7df525dc3c9
> >>>>>>>>>> devid 6 transid 1394395 /dev/sde (8:64) scanned by btrfs (261)
> >>>>>>>>>> [    2.678016] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-
> >>>>>>>>>> a7df525dc3c9
> >>>>>>>>>> devid 0 transid 1394395 /dev/sdd (8:48) scanned by btrfs (261)
> >>>>>>>>>> [    2.678129] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-
> >>>>>>>>>> a7df525dc3c9
> >>>>>>>>>> devid 3 transid 1394395 /dev/sdf (8:80) scanned by btrfs (261)
> >>>>>>>>>> [  118.096364] BTRFS info (device sdd): first mount of filesys=
tem
> >>>>>>>>>> 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
> >>>>>>>>>> [  118.096400] BTRFS info (device sdd): using crc32c (crc32c-
> >>>>>>>>>> intel)
> >>>>>>>>>> checksum algorithm
> >>>>>>>>>> [  118.160901] BTRFS warning (device sdd): devid 4 uuid
> >>>>>>>>>> 01e2081c-9c2a-4071-b9f4-e1b27e571ff5 is missing
> >>>>>>>>>> [  119.280530] BTRFS info (device sdd): bdev <missing disk>
> >>>>>>>>>> errs: wr
> >>>>>>>>>> 84994544, rd 15567, flush 65872, corrupt 0, gen 0
> >>>>>>>>>> [  119.280549] BTRFS info (device sdd): bdev /dev/sdd errs: wr
> >>>>>>>>>> 71489901, rd 0, flush 30001, corrupt 0, gen 0
> >>>>>>>>>> [  119.280562] BTRFS error (device sdd): replace without
> >>>>>>>>>> active item,
> >>>>>>>>>> run 'device scan --forget' on the target device
> >>>>>>>>>> [  119.280574] BTRFS error (device sdd): failed to init
> >>>>>>>>>> dev_replace: -117
> >>>>>>>>>> [  119.289808] BTRFS error (device sdd): open_ctree failed: -1=
17
> >>>>>>>>>>
> >>>>>>>>>> btrfs filesystem show
> >>>>>>>>>> Label: none  uuid: 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
> >>>>>>>>>>              Total devices 4 FS bytes used 14.80TiB
> >>>>>>>>>>              devid    0 size 18.19TiB used 7.54TiB path /dev/s=
dd
> >>>>>>>>>>              devid    3 size 18.19TiB used 7.53TiB path /dev/s=
df
> >>>>>>>>>>              devid    5 size 18.19TiB used 7.53TiB path /dev/s=
da
> >>>>>>>>>>              devid    6 size 18.19TiB used 7.53TiB path /dev/s=
de
> >>>>>>>>>>
> >>>>>>>>>> I've also tried btrfs check and btrfs check --repair on one of
> >>>>>>>>>> the
> >>>>>>>>>> disks still in the array but that's not helped and I still can=
not
> >>>>>>>>>> mount the array.
> >>>>>>>>>>
> >>>>>>>>>> Please can you help as although backed up I need to save this
> >>>>>>>>>> array.
> >>>>>>>>>>
> >>>>>>>>>> Many thanks
> >>>>>>>>>>
> >>>>>>>>>> Neil
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>
> >>>>>
> >>>
> >
>

