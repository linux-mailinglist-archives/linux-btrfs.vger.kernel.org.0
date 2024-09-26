Return-Path: <linux-btrfs+bounces-8269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F13987765
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 18:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB2E1F24FC1
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70D71552E4;
	Thu, 26 Sep 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdFxe7Rz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409FC20323
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367349; cv=none; b=Q5m90he5U1zDKVP5TzN+/KwZUlRtl8Lk5RQ56jZPwEQaGC+ICd8Nk4Qs3eA7aFSMItE37YbN9odBRy/EWEKynbV5fNgbw4Op6emNHUwuOqexxW2KSYsAQFKIN4zTr4dtVT41RiwZiL7anisNjN/3YUoh54aSB/ba1kOHHw/rtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367349; c=relaxed/simple;
	bh=bVjomwh9KnEnfHzyUi1dupszm6HbrVAoo9gjKkuKDbU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Wu5ZYY6LoFb+Ws85E+0mNUOt1xFkSpDiXQWFlOcK7sjhyoXmk2el9kNH9FH12XilTq4PJMbw3hLGiMTn0JhUOZXo4vupcZ9ABqQoinl+bjK0MOld5hA+wc9k3xnk/rxS9EvHiX4kj8vyj7o+koSf+4pawtSi8/YZSdpRbVu3hXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdFxe7Rz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d7a9200947so820598a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727367346; x=1727972146; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i1J9YATDefwZZWWnkMlZwnOLnh/g+9VJTjFuPP9lu/k=;
        b=QdFxe7Rz/G5KRqdLvVtVQh1grXsXT4cmpCn78ihmUXHXQarFkcycFNybuzzog85MuY
         oobNrdTl+LAusfn5UbglpoY7RX/mBFa0aOTqRWNGnFeRL5LrmDGGfn3Izu4nH81BHjJ2
         83GeR1baPEK+jdI7LwmW1aXDDgphbXNhGQezRyBoe9rY8Tb+iuFU8VkLaZKyhOJmDdoN
         ua6FrwKyjPkp9n4cn9/94JylbWOCr26Wn+oV8CAO745TD+/N6C1AWFtl0+5GUX+VwTm0
         yxzi8P7oxF67ovMS/ssbtWVI6tlpm+gaPSxg2hsoRucP9ZLaAgW0rczV9p+3k+VgZk0S
         vM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367346; x=1727972146;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1J9YATDefwZZWWnkMlZwnOLnh/g+9VJTjFuPP9lu/k=;
        b=Hp7omGl9cEQxNF9tKwp+c6nfaVnnXJQD64stt7zbyOA+qZBIlx5HTcrBuSx9DuBYNf
         ThecFZy1E6uduC/mxs/rB4e78FOAl6etpCFoxoKx++d1e3634IOiAqR9Zo/QbFqA6l/h
         xmApvW7yvyDqwOxNR87Z6ctHog2xnvWUgFaPGs8Ew/1mrAkiP6hbfXboZI/kK9BRBz/z
         6fDtvLxpwNLmoCgfrhCR2GNn4OaFmyD+8PU8qOBKxDpfdKO9mc82FF39L8jBPbG7J5aA
         kp35IqYmkjsF2qsEvvzDaKRHB7IZeZgTCh7xiycVnvtdlwF3EcfFyxhPGIyQlEM9Esq2
         h7+A==
X-Gm-Message-State: AOJu0YynlS6q+ivMogqKfeOGIri1UE9s7eqo96JWpJuYNFrFIg7TVNg9
	C1OOMiWyC1FL5WAlRfvldN+OOW0TafEx2dzAWW+dgZELDivd/6sPZxnctv1gZ9KO4X2SXz4ByuU
	dKVyHBYnxDvb8b4KZeMB9qZGMbmgK4Jcj
X-Google-Smtp-Source: AGHT+IEu3Iz4lF2z5FnGs1V/PIq7chbM3wg54VTEsRcdtrbZ/W/Sr5ve4jr1GTWVQT/Hwcl4hUD9gmXafM/cl6IH7Jw=
X-Received: by 2002:a05:6a21:7101:b0:1cf:6c64:ee72 with SMTP id
 adf61e73a8af0-1d4fa7ae316mr322417637.34.1727367345757; Thu, 26 Sep 2024
 09:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ben Millwood <thebenmachine@gmail.com>
Date: Thu, 26 Sep 2024 17:15:34 +0100
Message-ID: <CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com>
Subject: ERROR: failed to clone extents to [...]: Invalid argument
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I got these mailing list details from
https://github.com/kdave/btrfs-wiki/blob/master/btrfs.wiki/Btrfs%20mailing%20list
, which sounds like it's deprecated as a source, so I hope the details
and etiquette guidelines are still current...

Anyway, I'm seeing an error with similar symptoms as this old thing:
https://lore.kernel.org/linux-btrfs/87blnsuv7m.fsf@gmail.com/T/ , but
likely with a different cause.

My setup is:
- My btrfs filesystem has two top-level subvolumes, /root and /snap,
which I mount into / and /snap respectively. (I don't remember exactly
why I did it this way, to be honest.)
- I have a regularly-triggered systemd unit that runs: btrfs subvolume
snapshot -r / "/snap/root/$(date -u --iso-8601=seconds)"
- I have two external USB disks, and I btrfs send -p
/snap/root/LASTSNAP /snap/root/NEWSNAP | btrfs receive
/mnt/USBDISK/root/YEAR for each one (I have scripts to do this for me,
but I've reproduced the issue without the scripts. If you still want
to read more about them for whatever reason, you can find them at
https://github.com/bmillwood/backups )
- Periodically I btrfs subvolume delete old snapshots from /snap/root.
The ones in the external USB disks stay there forever. (I don't have
crazy amounts of data, so this has been sustainable so far, but it
does mean I have over 3k snapshots on there, which is perhaps
unusual...)

This more-or-less works most of the time, but recently I have a
snapshot that won't co-operate, failing with "ERROR: failed to clone
extents to home/ben/code/nix/noether/etc-nixos/system-packages.nix:
Invalid argument". This happens with the same snapshot + erroneous
file path for both of my external disks.

I redid the send / receive pipeline with -vv on the receive:

btrfs send -p /snap/root/2024-09-12T16\:29\:16+00\:00
/snap/root/2024-09-12T17\:04\:17+00\:00 | btrfs receive -vv
/mnt/electricaltape/root/2024 &> /mnt/electricaltape/receive-vv.log

and here's tail receive-vv.log:

unlink o1209472-383-0/vmsish.3.gz
utimes nix/store/.links/0h84wh2xnnfqram84dsszzii4v2r497hvxsvbxfyppgfnwc3c4rk
unlink o1209472-383-0/warnings.3.gz
utimes nix/store/.links/0kh81sw0mh5sm7sgfb5g99rgb45qw85qs1s8qndjh4kchi0j1jq6
unlink o1209472-383-0/warnings::register.3.gz
rmdir o1209472-383-0
utimes nix/store/.links/02m8fllf71vlf6wwx2h72k2adfx015gq8sxmbb5b52xdv3rq012l
clone home/ben/code/nix/noether/etc-nixos/system-packages.nix -
source=etc/nixos/system-packages.nix source offset=0 offset=0
length=4985
ERROR: failed to clone extents to
home/ben/code/nix/noether/etc-nixos/system-packages.nix: Invalid
argument
At snapshot 2024-09-12T17:04:17+00:00

The two files mentioned are generally copies of each other. I'm not
sure if they're CoW shallow clones of each other or not. On its face
I'm not sure why the clone would fail, given that the file length
appears to be correct. Here's the file being written earlier in the
receive:

# grep -nF system-packages.nix receive-vv.log
133380:write etc/nixos/system-packages.nix - offset=0 length=4985
133381:truncate etc/nixos/system-packages.nix size=4985
133382:utimes etc/nixos/system-packages.nix
316933:clone home/ben/code/nix/noether/etc-nixos/system-packages.nix -
source=etc/nixos/system-packages.nix source offset=0 offset=0
length=4985
316934:ERROR: failed to clone extents to
home/ben/code/nix/noether/etc-nixos/system-packages.nix: Invalid
argument

Here's the local parent snapshot:

# btrfs subvolume show /snap/root/2024-09-12T16\:29\:16+00\:00
snap/root/2024-09-12T16:29:16+00:00
    Name:             2024-09-12T16:29:16+00:00
    UUID:             1640ca1d-94ca-f448-a89c-a3d83023744a
    Parent UUID:         a14d8622-5729-3543-8bba-62104d53e52a
    Received UUID:         -
    Creation time:         2024-09-12 17:29:16 +0100
    Subvolume ID:         348
    Generation:         63052
    Gen at creation:     63051
    Parent ID:         257
    Top level ID:         257
    Flags:             readonly
    Send transid:         0
    Send time:         2024-09-12 17:29:16 +0100
    Receive transid:     0
    Receive time:         -
    Snapshot(s):
    Quota group:        n/a

the local sent snapshot:

# btrfs subvolume show /snap/root/2024-09-12T17\:04\:17+00\:00/
snap/root/2024-09-12T17:04:17+00:00
    Name:             2024-09-12T17:04:17+00:00
    UUID:             f4190efb-ee53-0341-9613-93be3d2afbcb
    Parent UUID:         a14d8622-5729-3543-8bba-62104d53e52a
    Received UUID:         -
    Creation time:         2024-09-12 18:04:17 +0100
    Subvolume ID:         349
    Generation:         63122
    Gen at creation:     63121
    Parent ID:         257
    Top level ID:         257
    Flags:             readonly
    Send transid:         0
    Send time:         2024-09-12 18:04:17 +0100
    Receive transid:     0
    Receive time:         -
    Snapshot(s):
    Quota group:        n/a

and the remote parent snapshot:

# btrfs subvolume show
/mnt/electricaltape/root/2024/2024-09-12T16\:29\:16+00\:00/
root/2024/2024-09-12T16:29:16+00:00
    Name:             2024-09-12T16:29:16+00:00
    UUID:             cfa79865-0272-3845-b447-4d650c2f6d5a
    Parent UUID:         3d45fbdc-7e4e-f044-83c3-32ad05b70441
    Received UUID:         1640ca1d-94ca-f448-a89c-a3d83023744a
    Creation time:         2024-09-26 14:00:31 +0100
    Subvolume ID:         5842
    Generation:         14268
    Gen at creation:     14255
    Parent ID:         5
    Top level ID:         5
    Flags:             readonly
    Send transid:         63051
    Send time:         2024-09-26 14:00:31 +0100
    Receive transid:     14261
    Receive time:         2024-09-26 14:09:52 +0100
    Snapshot(s):
    Quota group:        n/a

I checked, and:
- the Parent UUID of both local snaps is the UUID of my root subvolume,
- the Parent UUID of the remote parent is the UUID of the previous
remote snapshot,
- as you can see, the Received UUID of the remote parent is the UUID
of the local parent (and neither local snapshots have a Received
UUID).

local parent files:

# stat /snap/root/2024-09-12T16\:29\:16+00\:00/home/ben/code/nix/noether/etc-nixos/system-packages.nix
  File: /snap/root/2024-09-12T16:29:16+00:00/home/ben/code/nix/noether/etc-nixos/system-packages.nix
  Size: 5026          Blocks: 16         IO Block: 4096   regular file
Device: 0,411    Inode: 1211367     Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/     ben)   Gid: (  100/   users)
Access: 2024-09-12 17:05:38.551355079 +0100
Modify: 2024-09-12 17:26:55.867672396 +0100
Change: 2024-09-12 17:26:55.867672396 +0100
 Birth: 2024-07-07 23:50:28.962175308 +0100

# stat /snap/root/2024-09-12T16\:29\:16+00\:00/etc/nixos/system-packages.nix
  File: /snap/root/2024-09-12T16:29:16+00:00/etc/nixos/system-packages.nix
  Size: 5026          Blocks: 16         IO Block: 4096   regular file
Device: 0,411    Inode: 597357      Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-09-12 17:27:05.736798471 +0100
Modify: 2024-09-12 17:27:04.700785230 +0100
Change: 2024-09-12 17:27:04.700785230 +0100
 Birth: 2024-07-07 22:27:35.003876023 +0100

local sent files:

  File: /snap/root/2024-09-12T17:04:17+00:00/home/ben/code/nix/noether/etc-nixos/system-packages.nix
  Size: 4985          Blocks: 16         IO Block: 4096   regular file
Device: 0,415    Inode: 1211367     Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/     ben)   Gid: (  100/   users)
Access: 2024-09-12 18:02:43.410125394 +0100
Modify: 2024-09-12 18:03:00.161350117 +0100
Change: 2024-09-12 18:03:00.161350117 +0100
 Birth: 2024-07-07 23:50:28.962175308 +0100

  File: /snap/root/2024-09-12T17:04:17+00:00/etc/nixos/system-packages.nix
  Size: 4985          Blocks: 16         IO Block: 4096   regular file
Device: 0,415    Inode: 597357      Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-09-12 18:03:10.051482821 +0100
Modify: 2024-09-12 18:03:09.142470623 +0100
Change: 2024-09-12 18:03:09.142470623 +0100
 Birth: 2024-07-07 22:27:35.003876023 +0100

remote parent files:

# stat /mnt/electricaltape/root/2024/2024-09-12T16\:29\:16+00\:00/home/ben/code/nix/noether/etc-nixos/system-packages.nix
  File: /mnt/electricaltape/root/2024/2024-09-12T16:29:16+00:00/home/ben/code/nix/noether/etc-nixos/system-packages.nix
  Size: 5026          Blocks: 16         IO Block: 4096   regular file
Device: 0,3211    Inode: 42099860    Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/     ben)   Gid: (  100/   users)
Access: 2024-09-12 17:05:38.551355079 +0100
Modify: 2024-09-12 17:26:55.867672396 +0100
Change: 2024-09-26 14:03:06.227153443 +0100
 Birth: 2024-03-02 17:39:41.804616575 +0000

# stat /mnt/electricaltape/root/2024/2024-09-12T16\:29\:16+00\:00/etc/nixos/system-packages.nix
  File: /mnt/electricaltape/root/2024/2024-09-12T16:29:16+00:00/etc/nixos/system-packages.nix
  Size: 5026          Blocks: 16         IO Block: 4096   regular file
Device: 0,3211    Inode: 33809348    Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-09-12 17:27:05.736798471 +0100
Modify: 2024-09-12 17:27:04.700785230 +0100
Change: 2024-09-26 14:01:42.081508624 +0100
 Birth: 2022-07-14 21:32:47.972957386 +0100

Here's various system and filesystem info:

$ uname -a
Linux noether 6.6.52 #1-NixOS SMP PREEMPT_DYNAMIC Wed Sep 18 17:24:10
UTC 2024 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v6.8.1

$ btrfs fi show
Label: 'noether-root'  uuid: b7ad9a05-8f7b-44af-8952-a7f717e897e0
    Total devices 1 FS bytes used 274.02GiB
    devid    1 size 390.62GiB used 303.07GiB path /dev/mapper/noether-lv

Label: none  uuid: 7f916f66-8afa-4de6-be52-a0f127c756e1
    Total devices 1 FS bytes used 2.17TiB
    devid    1 size 3.64TiB used 2.39TiB path /dev/mapper/electricaltape--vg-lv

$ btrfs fi df /
Data, single: total=251.01GiB, used=249.08GiB
System, DUP: total=32.00MiB, used=48.00KiB
Metadata, DUP: total=26.00GiB, used=24.94GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

I assume btrfs fi df /mnt/electricaltape is not relevant since it's
probably on the sending side, but here it is anyway:
Data, single: total=1.96TiB, used=1.95TiB
System, DUP: total=8.00MiB, used=256.00KiB
Metadata, DUP: total=225.00GiB, used=223.61GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

dmesg as a whole is pretty large, but here's me mounting my root disk
at boot time:

[   11.470686] stage-1-init: [Thu Sep 26 10:34:53 UTC 2024] Passphrase
for /dev/disk/by-uuid/bfb4d3ae-816a-48f5-a925-30acc0d7a3ef:
[   17.349037] Key type encrypted registered
[   17.387864] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] Verifying
passphrase for /dev/disk/by-uuid/bfb4d3ae-816a-48f5-a925-30acc0d7a3ef...
- success
[   17.390297] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] starting
device mapper and LVM...
[   17.412379] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] 1 logical
volume(s) in volume group "noether" now active
[   17.475310] BTRFS: device label noether-root devid 1 transid 75991
/dev/mapper/noether-lv scanned by btrfs (214)
[   17.477307] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] Scanning
for Btrfs filesystems
[   17.479005] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024]
registered: /dev/mapper/noether-lv
[   17.504504] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] mounting
/dev/disk/by-label/noether-root on /...
[   17.506407] BTRFS info (device dm-1): first mount of filesystem
b7ad9a05-8f7b-44af-8952-a7f717e897e0
[   17.506429] BTRFS info (device dm-1): using crc32c (crc32c-intel)
checksum algorithm
[   17.506441] BTRFS info (device dm-1): use zstd compression, level 3
[   17.506449] BTRFS info (device dm-1): using free space tree
[   17.595741] BTRFS info (device dm-1): enabling ssd optimizations

and here's everything since I plugged in electricaltape:

[ 4782.354412] usb 2-1: new SuperSpeed USB device number 3 using xhci_hcd
[ 4782.369977] usb 2-1: New USB device found, idVendor=0bc2,
idProduct=ab28, bcdDevice= 1.00
[ 4782.369984] usb 2-1: New USB device strings: Mfr=2, Product=3, SerialNumber=1
[ 4782.369986] usb 2-1: Product: BUP BL
[ 4782.369988] usb 2-1: Manufacturer: Seagate
[ 4782.369990] usb 2-1: SerialNumber: NA9FP1AT
[ 4782.374490] scsi host0: uas
[ 4782.375167] scsi 0:0:0:0: Direct-Access     Seagate  BUP BL
  0304 PQ: 0 ANSI: 6
[ 4782.376657] sd 0:0:0:0: [sda] Spinning up disk...
[ 4783.430402] ......ready
[ 4788.581955] sd 0:0:0:0: [sda] 7814037167 512-byte logical blocks:
(4.00 TB/3.64 TiB)
[ 4788.581960] sd 0:0:0:0: [sda] 2048-byte physical blocks
[ 4788.582079] sd 0:0:0:0: [sda] Write Protect is off
[ 4788.582082] sd 0:0:0:0: [sda] Mode Sense: 4f 00 00 00
[ 4788.582238] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[ 4788.608463] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
not a multiple of physical block size (2048 bytes)
[ 4788.608470] sd 0:0:0:0: [sda] Optimal transfer size 33553920 bytes
not a multiple of physical block size (2048 bytes)
[ 4788.703618]  sda: sda1
[ 4788.703776] sd 0:0:0:0: [sda] Attached SCSI disk
[ 4808.813728] BTRFS: device fsid 7f916f66-8afa-4de6-be52-a0f127c756e1
devid 1 transid 14201 /dev/dm-3 scanned by (udev-worker) (21792)
[ 4808.859452] BTRFS info (device dm-3): first mount of filesystem
7f916f66-8afa-4de6-be52-a0f127c756e1
[ 4808.859473] BTRFS info (device dm-3): using crc32c (crc32c-intel)
checksum algorithm
[ 4808.859483] BTRFS info (device dm-3): use zlib compression, level 3
[ 4808.859487] BTRFS info (device dm-3): disk space caching is enabled
[ 4895.650086] BTRFS warning (device dm-3): block group 1789991583744
has wrong amount of free space
[ 4895.650093] BTRFS warning (device dm-3): failed to load free space
cache for block group 1789991583744, rebuilding it now
[ 4896.313609] BTRFS warning (device dm-3): block group 2062722007040
has wrong amount of free space
[ 4896.313617] BTRFS warning (device dm-3): failed to load free space
cache for block group 2062722007040, rebuilding it now
[ 4896.315812] BTRFS warning (device dm-3): block group 2078828134400
has wrong amount of free space
[ 4896.315817] BTRFS warning (device dm-3): failed to load free space
cache for block group 2078828134400, rebuilding it now

Grateful for any help anyone can offer, happy to do more debugging
steps. I plan to keep all relevant snapshots around until this problem
is resolved.

In the absence of any other guidance, I'm going to try to figure out
how to upgrade my kernel and btrfs-progs to as new a version as
possible, and see if that makes any difference. I'll reply here if it
does.

Thanks!

