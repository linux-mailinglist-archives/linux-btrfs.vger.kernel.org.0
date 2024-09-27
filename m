Return-Path: <linux-btrfs+bounces-8295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D493A988291
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0302E1C21C26
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E57185956;
	Fri, 27 Sep 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DavGP6qN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC413698F
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433211; cv=none; b=q5zuPMn9DRseFlSi9YzUocI+t6GDufC0BXrMJGPbE4Za8k3bGc1EtAiHX9/rSk3ewiOBB2oxRd3o6/IytbsKS+d1l2HMOKTIX9lxqYgA6S3cNiYU1ilSygBPI4E2IPZGL0vn2h7yJPN/7TJtF+6/rxPriBwI9xl6TmLOnmsHsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433211; c=relaxed/simple;
	bh=vfL7g/j0AUdTKrhIf/K41olD/2wr4bnjVKsHT0wnyiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9eVotDPMxbjJ2deslk0UjwxSieRpk7inVzA/PUPDzuGFmSf5c9BkPDnzDV/gm/Y5XZ6qS3fjfxNVLnGdgdGJuNZhxa6H0QYCFCOPoyZmYjAp+6LHJdqJYVqYYr5MWYAqL/ed6/gjarrOD0rhXPv/sEEXg2Vb5i0E3HFHYZjNM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DavGP6qN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA0CC4CEC4
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727433211;
	bh=vfL7g/j0AUdTKrhIf/K41olD/2wr4bnjVKsHT0wnyiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DavGP6qNfSVjxpSboro5iOcfJPfQqHuSwvjNo0obeJxZQoPU45rhhj8IozOyE8/U3
	 KoTit/mfIZrQRROATFcVLxfsoNrZtPHsRdTsiKaJi8N6SdRbgGLwHCaFK9Nasefg2S
	 dQjh8Wa+cPL6+C7XcKyEy6YB+mBFGeZRdUgTggezhd5y8EMnOJQpc08KmlXL7m0GIe
	 L8d0FAKFiyKLqs3GOaa4saxRodj9ALcl0UACZKfGW436xmL0Lp94TmlsdKGAdhfVyR
	 V0GVlhXkUcdORQeUzk1BkBPDCIyUV4AXTlMfwXGw5gyA6OsbFjqB9T2UCZ4FY2UufR
	 g9Xj+0ZStp09g==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c87853df28so2048813a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 03:33:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YzOC3HNPSBeHJ0PpDB/W6EaeGMd8/2QbByURcWxnLFnBOAZ3hiY
	oWPMfPbH98doOMbkUu9bvb1NJYdlyptLr0qGRi2zVISqLzqls3v8AvicjPvnfVGQKBiAdVCKnSJ
	CFecTJzSb5wV7ZxNTtpwHKOwX/JI=
X-Google-Smtp-Source: AGHT+IEWa0y8FIJSgKwqOUKdDU9yVzY2KAY5Epw7QmED6vSJYzb/msIkEU46CXsr25MP2fczSJJjVvb76Fk3uRVX3pI=
X-Received: by 2002:a17:907:98d:b0:a8d:250a:52a8 with SMTP id
 a640c23a62f3a-a93c48e8e52mr259961766b.3.1727433209183; Fri, 27 Sep 2024
 03:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com>
In-Reply-To: <CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Sep 2024 11:32:52 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7RfafuRir1Cdjh7YQ2fhas_NyK5orf4QYutzPC+TKycw@mail.gmail.com>
Message-ID: <CAL3q7H7RfafuRir1Cdjh7YQ2fhas_NyK5orf4QYutzPC+TKycw@mail.gmail.com>
Subject: Re: ERROR: failed to clone extents to [...]: Invalid argument
To: Ben Millwood <thebenmachine@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 5:16=E2=80=AFPM Ben Millwood <thebenmachine@gmail.c=
om> wrote:
>
> Hi folks,
>
> I got these mailing list details from
> https://github.com/kdave/btrfs-wiki/blob/master/btrfs.wiki/Btrfs%20mailin=
g%20list
> , which sounds like it's deprecated as a source, so I hope the details
> and etiquette guidelines are still current...
>
> Anyway, I'm seeing an error with similar symptoms as this old thing:
> https://lore.kernel.org/linux-btrfs/87blnsuv7m.fsf@gmail.com/T/ , but
> likely with a different cause.
>
> My setup is:
> - My btrfs filesystem has two top-level subvolumes, /root and /snap,
> which I mount into / and /snap respectively. (I don't remember exactly
> why I did it this way, to be honest.)
> - I have a regularly-triggered systemd unit that runs: btrfs subvolume
> snapshot -r / "/snap/root/$(date -u --iso-8601=3Dseconds)"
> - I have two external USB disks, and I btrfs send -p
> /snap/root/LASTSNAP /snap/root/NEWSNAP | btrfs receive
> /mnt/USBDISK/root/YEAR for each one (I have scripts to do this for me,
> but I've reproduced the issue without the scripts. If you still want
> to read more about them for whatever reason, you can find them at
> https://github.com/bmillwood/backups )
> - Periodically I btrfs subvolume delete old snapshots from /snap/root.
> The ones in the external USB disks stay there forever. (I don't have
> crazy amounts of data, so this has been sustainable so far, but it
> does mean I have over 3k snapshots on there, which is perhaps
> unusual...)
>
> This more-or-less works most of the time, but recently I have a
> snapshot that won't co-operate, failing with "ERROR: failed to clone
> extents to home/ben/code/nix/noether/etc-nixos/system-packages.nix:
> Invalid argument". This happens with the same snapshot + erroneous
> file path for both of my external disks.
>
> I redid the send / receive pipeline with -vv on the receive:
>
> btrfs send -p /snap/root/2024-09-12T16\:29\:16+00\:00
> /snap/root/2024-09-12T17\:04\:17+00\:00 | btrfs receive -vv
> /mnt/electricaltape/root/2024 &> /mnt/electricaltape/receive-vv.log
>
> and here's tail receive-vv.log:
>
> unlink o1209472-383-0/vmsish.3.gz
> utimes nix/store/.links/0h84wh2xnnfqram84dsszzii4v2r497hvxsvbxfyppgfnwc3c=
4rk
> unlink o1209472-383-0/warnings.3.gz
> utimes nix/store/.links/0kh81sw0mh5sm7sgfb5g99rgb45qw85qs1s8qndjh4kchi0j1=
jq6
> unlink o1209472-383-0/warnings::register.3.gz
> rmdir o1209472-383-0
> utimes nix/store/.links/02m8fllf71vlf6wwx2h72k2adfx015gq8sxmbb5b52xdv3rq0=
12l
> clone home/ben/code/nix/noether/etc-nixos/system-packages.nix -
> source=3Detc/nixos/system-packages.nix source offset=3D0 offset=3D0
> length=3D4985
> ERROR: failed to clone extents to
> home/ben/code/nix/noether/etc-nixos/system-packages.nix: Invalid
> argument

It's a kernel bug and here's the fix for it which I've just sent a few
minutes ago to the list:

https://lore.kernel.org/linux-btrfs/5a406a607fcccec01684056ab011ff0742f0643=
9.1727432566.git.fdmanana@suse.com/

Thanks for the report.

> At snapshot 2024-09-12T17:04:17+00:00
>
> The two files mentioned are generally copies of each other. I'm not
> sure if they're CoW shallow clones of each other or not. On its face
> I'm not sure why the clone would fail, given that the file length
> appears to be correct. Here's the file being written earlier in the
> receive:
>
> # grep -nF system-packages.nix receive-vv.log
> 133380:write etc/nixos/system-packages.nix - offset=3D0 length=3D4985
> 133381:truncate etc/nixos/system-packages.nix size=3D4985
> 133382:utimes etc/nixos/system-packages.nix
> 316933:clone home/ben/code/nix/noether/etc-nixos/system-packages.nix -
> source=3Detc/nixos/system-packages.nix source offset=3D0 offset=3D0
> length=3D4985
> 316934:ERROR: failed to clone extents to
> home/ben/code/nix/noether/etc-nixos/system-packages.nix: Invalid
> argument
>
> Here's the local parent snapshot:
>
> # btrfs subvolume show /snap/root/2024-09-12T16\:29\:16+00\:00
> snap/root/2024-09-12T16:29:16+00:00
>     Name:             2024-09-12T16:29:16+00:00
>     UUID:             1640ca1d-94ca-f448-a89c-a3d83023744a
>     Parent UUID:         a14d8622-5729-3543-8bba-62104d53e52a
>     Received UUID:         -
>     Creation time:         2024-09-12 17:29:16 +0100
>     Subvolume ID:         348
>     Generation:         63052
>     Gen at creation:     63051
>     Parent ID:         257
>     Top level ID:         257
>     Flags:             readonly
>     Send transid:         0
>     Send time:         2024-09-12 17:29:16 +0100
>     Receive transid:     0
>     Receive time:         -
>     Snapshot(s):
>     Quota group:        n/a
>
> the local sent snapshot:
>
> # btrfs subvolume show /snap/root/2024-09-12T17\:04\:17+00\:00/
> snap/root/2024-09-12T17:04:17+00:00
>     Name:             2024-09-12T17:04:17+00:00
>     UUID:             f4190efb-ee53-0341-9613-93be3d2afbcb
>     Parent UUID:         a14d8622-5729-3543-8bba-62104d53e52a
>     Received UUID:         -
>     Creation time:         2024-09-12 18:04:17 +0100
>     Subvolume ID:         349
>     Generation:         63122
>     Gen at creation:     63121
>     Parent ID:         257
>     Top level ID:         257
>     Flags:             readonly
>     Send transid:         0
>     Send time:         2024-09-12 18:04:17 +0100
>     Receive transid:     0
>     Receive time:         -
>     Snapshot(s):
>     Quota group:        n/a
>
> and the remote parent snapshot:
>
> # btrfs subvolume show
> /mnt/electricaltape/root/2024/2024-09-12T16\:29\:16+00\:00/
> root/2024/2024-09-12T16:29:16+00:00
>     Name:             2024-09-12T16:29:16+00:00
>     UUID:             cfa79865-0272-3845-b447-4d650c2f6d5a
>     Parent UUID:         3d45fbdc-7e4e-f044-83c3-32ad05b70441
>     Received UUID:         1640ca1d-94ca-f448-a89c-a3d83023744a
>     Creation time:         2024-09-26 14:00:31 +0100
>     Subvolume ID:         5842
>     Generation:         14268
>     Gen at creation:     14255
>     Parent ID:         5
>     Top level ID:         5
>     Flags:             readonly
>     Send transid:         63051
>     Send time:         2024-09-26 14:00:31 +0100
>     Receive transid:     14261
>     Receive time:         2024-09-26 14:09:52 +0100
>     Snapshot(s):
>     Quota group:        n/a
>
> I checked, and:
> - the Parent UUID of both local snaps is the UUID of my root subvolume,
> - the Parent UUID of the remote parent is the UUID of the previous
> remote snapshot,
> - as you can see, the Received UUID of the remote parent is the UUID
> of the local parent (and neither local snapshots have a Received
> UUID).
>
> local parent files:
>
> # stat /snap/root/2024-09-12T16\:29\:16+00\:00/home/ben/code/nix/noether/=
etc-nixos/system-packages.nix
>   File: /snap/root/2024-09-12T16:29:16+00:00/home/ben/code/nix/noether/et=
c-nixos/system-packages.nix
>   Size: 5026          Blocks: 16         IO Block: 4096   regular file
> Device: 0,411    Inode: 1211367     Links: 1
> Access: (0644/-rw-r--r--)  Uid: ( 1000/     ben)   Gid: (  100/   users)
> Access: 2024-09-12 17:05:38.551355079 +0100
> Modify: 2024-09-12 17:26:55.867672396 +0100
> Change: 2024-09-12 17:26:55.867672396 +0100
>  Birth: 2024-07-07 23:50:28.962175308 +0100
>
> # stat /snap/root/2024-09-12T16\:29\:16+00\:00/etc/nixos/system-packages.=
nix
>   File: /snap/root/2024-09-12T16:29:16+00:00/etc/nixos/system-packages.ni=
x
>   Size: 5026          Blocks: 16         IO Block: 4096   regular file
> Device: 0,411    Inode: 597357      Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2024-09-12 17:27:05.736798471 +0100
> Modify: 2024-09-12 17:27:04.700785230 +0100
> Change: 2024-09-12 17:27:04.700785230 +0100
>  Birth: 2024-07-07 22:27:35.003876023 +0100
>
> local sent files:
>
>   File: /snap/root/2024-09-12T17:04:17+00:00/home/ben/code/nix/noether/et=
c-nixos/system-packages.nix
>   Size: 4985          Blocks: 16         IO Block: 4096   regular file
> Device: 0,415    Inode: 1211367     Links: 1
> Access: (0644/-rw-r--r--)  Uid: ( 1000/     ben)   Gid: (  100/   users)
> Access: 2024-09-12 18:02:43.410125394 +0100
> Modify: 2024-09-12 18:03:00.161350117 +0100
> Change: 2024-09-12 18:03:00.161350117 +0100
>  Birth: 2024-07-07 23:50:28.962175308 +0100
>
>   File: /snap/root/2024-09-12T17:04:17+00:00/etc/nixos/system-packages.ni=
x
>   Size: 4985          Blocks: 16         IO Block: 4096   regular file
> Device: 0,415    Inode: 597357      Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2024-09-12 18:03:10.051482821 +0100
> Modify: 2024-09-12 18:03:09.142470623 +0100
> Change: 2024-09-12 18:03:09.142470623 +0100
>  Birth: 2024-07-07 22:27:35.003876023 +0100
>
> remote parent files:
>
> # stat /mnt/electricaltape/root/2024/2024-09-12T16\:29\:16+00\:00/home/be=
n/code/nix/noether/etc-nixos/system-packages.nix
>   File: /mnt/electricaltape/root/2024/2024-09-12T16:29:16+00:00/home/ben/=
code/nix/noether/etc-nixos/system-packages.nix
>   Size: 5026          Blocks: 16         IO Block: 4096   regular file
> Device: 0,3211    Inode: 42099860    Links: 1
> Access: (0644/-rw-r--r--)  Uid: ( 1000/     ben)   Gid: (  100/   users)
> Access: 2024-09-12 17:05:38.551355079 +0100
> Modify: 2024-09-12 17:26:55.867672396 +0100
> Change: 2024-09-26 14:03:06.227153443 +0100
>  Birth: 2024-03-02 17:39:41.804616575 +0000
>
> # stat /mnt/electricaltape/root/2024/2024-09-12T16\:29\:16+00\:00/etc/nix=
os/system-packages.nix
>   File: /mnt/electricaltape/root/2024/2024-09-12T16:29:16+00:00/etc/nixos=
/system-packages.nix
>   Size: 5026          Blocks: 16         IO Block: 4096   regular file
> Device: 0,3211    Inode: 33809348    Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2024-09-12 17:27:05.736798471 +0100
> Modify: 2024-09-12 17:27:04.700785230 +0100
> Change: 2024-09-26 14:01:42.081508624 +0100
>  Birth: 2022-07-14 21:32:47.972957386 +0100
>
> Here's various system and filesystem info:
>
> $ uname -a
> Linux noether 6.6.52 #1-NixOS SMP PREEMPT_DYNAMIC Wed Sep 18 17:24:10
> UTC 2024 x86_64 GNU/Linux
>
> $ btrfs --version
> btrfs-progs v6.8.1
>
> $ btrfs fi show
> Label: 'noether-root'  uuid: b7ad9a05-8f7b-44af-8952-a7f717e897e0
>     Total devices 1 FS bytes used 274.02GiB
>     devid    1 size 390.62GiB used 303.07GiB path /dev/mapper/noether-lv
>
> Label: none  uuid: 7f916f66-8afa-4de6-be52-a0f127c756e1
>     Total devices 1 FS bytes used 2.17TiB
>     devid    1 size 3.64TiB used 2.39TiB path /dev/mapper/electricaltape-=
-vg-lv
>
> $ btrfs fi df /
> Data, single: total=3D251.01GiB, used=3D249.08GiB
> System, DUP: total=3D32.00MiB, used=3D48.00KiB
> Metadata, DUP: total=3D26.00GiB, used=3D24.94GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> I assume btrfs fi df /mnt/electricaltape is not relevant since it's
> probably on the sending side, but here it is anyway:
> Data, single: total=3D1.96TiB, used=3D1.95TiB
> System, DUP: total=3D8.00MiB, used=3D256.00KiB
> Metadata, DUP: total=3D225.00GiB, used=3D223.61GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> dmesg as a whole is pretty large, but here's me mounting my root disk
> at boot time:
>
> [   11.470686] stage-1-init: [Thu Sep 26 10:34:53 UTC 2024] Passphrase
> for /dev/disk/by-uuid/bfb4d3ae-816a-48f5-a925-30acc0d7a3ef:
> [   17.349037] Key type encrypted registered
> [   17.387864] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] Verifying
> passphrase for /dev/disk/by-uuid/bfb4d3ae-816a-48f5-a925-30acc0d7a3ef...
> - success
> [   17.390297] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] starting
> device mapper and LVM...
> [   17.412379] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] 1 logical
> volume(s) in volume group "noether" now active
> [   17.475310] BTRFS: device label noether-root devid 1 transid 75991
> /dev/mapper/noether-lv scanned by btrfs (214)
> [   17.477307] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] Scanning
> for Btrfs filesystems
> [   17.479005] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024]
> registered: /dev/mapper/noether-lv
> [   17.504504] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] mounting
> /dev/disk/by-label/noether-root on /...
> [   17.506407] BTRFS info (device dm-1): first mount of filesystem
> b7ad9a05-8f7b-44af-8952-a7f717e897e0
> [   17.506429] BTRFS info (device dm-1): using crc32c (crc32c-intel)
> checksum algorithm
> [   17.506441] BTRFS info (device dm-1): use zstd compression, level 3
> [   17.506449] BTRFS info (device dm-1): using free space tree
> [   17.595741] BTRFS info (device dm-1): enabling ssd optimizations
>
> and here's everything since I plugged in electricaltape:
>
> [ 4782.354412] usb 2-1: new SuperSpeed USB device number 3 using xhci_hcd
> [ 4782.369977] usb 2-1: New USB device found, idVendor=3D0bc2,
> idProduct=3Dab28, bcdDevice=3D 1.00
> [ 4782.369984] usb 2-1: New USB device strings: Mfr=3D2, Product=3D3, Ser=
ialNumber=3D1
> [ 4782.369986] usb 2-1: Product: BUP BL
> [ 4782.369988] usb 2-1: Manufacturer: Seagate
> [ 4782.369990] usb 2-1: SerialNumber: NA9FP1AT
> [ 4782.374490] scsi host0: uas
> [ 4782.375167] scsi 0:0:0:0: Direct-Access     Seagate  BUP BL
>   0304 PQ: 0 ANSI: 6
> [ 4782.376657] sd 0:0:0:0: [sda] Spinning up disk...
> [ 4783.430402] ......ready
> [ 4788.581955] sd 0:0:0:0: [sda] 7814037167 512-byte logical blocks:
> (4.00 TB/3.64 TiB)
> [ 4788.581960] sd 0:0:0:0: [sda] 2048-byte physical blocks
> [ 4788.582079] sd 0:0:0:0: [sda] Write Protect is off
> [ 4788.582082] sd 0:0:0:0: [sda] Mode Sense: 4f 00 00 00
> [ 4788.582238] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 4788.608463] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> not a multiple of physical block size (2048 bytes)
> [ 4788.608470] sd 0:0:0:0: [sda] Optimal transfer size 33553920 bytes
> not a multiple of physical block size (2048 bytes)
> [ 4788.703618]  sda: sda1
> [ 4788.703776] sd 0:0:0:0: [sda] Attached SCSI disk
> [ 4808.813728] BTRFS: device fsid 7f916f66-8afa-4de6-be52-a0f127c756e1
> devid 1 transid 14201 /dev/dm-3 scanned by (udev-worker) (21792)
> [ 4808.859452] BTRFS info (device dm-3): first mount of filesystem
> 7f916f66-8afa-4de6-be52-a0f127c756e1
> [ 4808.859473] BTRFS info (device dm-3): using crc32c (crc32c-intel)
> checksum algorithm
> [ 4808.859483] BTRFS info (device dm-3): use zlib compression, level 3
> [ 4808.859487] BTRFS info (device dm-3): disk space caching is enabled
> [ 4895.650086] BTRFS warning (device dm-3): block group 1789991583744
> has wrong amount of free space
> [ 4895.650093] BTRFS warning (device dm-3): failed to load free space
> cache for block group 1789991583744, rebuilding it now
> [ 4896.313609] BTRFS warning (device dm-3): block group 2062722007040
> has wrong amount of free space
> [ 4896.313617] BTRFS warning (device dm-3): failed to load free space
> cache for block group 2062722007040, rebuilding it now
> [ 4896.315812] BTRFS warning (device dm-3): block group 2078828134400
> has wrong amount of free space
> [ 4896.315817] BTRFS warning (device dm-3): failed to load free space
> cache for block group 2078828134400, rebuilding it now
>
> Grateful for any help anyone can offer, happy to do more debugging
> steps. I plan to keep all relevant snapshots around until this problem
> is resolved.
>
> In the absence of any other guidance, I'm going to try to figure out
> how to upgrade my kernel and btrfs-progs to as new a version as
> possible, and see if that makes any difference. I'll reply here if it
> does.
>
> Thanks!
>

