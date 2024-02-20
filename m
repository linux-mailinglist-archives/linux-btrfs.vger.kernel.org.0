Return-Path: <linux-btrfs+bounces-2587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED87985BE3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 15:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1EB1C231F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B500745C6;
	Tue, 20 Feb 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGNnMTc8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090F6FBB7;
	Tue, 20 Feb 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438119; cv=none; b=MVRb7reNtJdeVqGwG+TW+mShIUFCJsuG3HWyeox4gAGbd0M63F5llyodE12b4kCpsJAKhQ5NeRa+ERsgJqDPMRzsgshALO3QK8gKIKSBs9Z3lWRM7pR/Uegydj3RheVmjFVRJJLsuUW+ma9BcMOV6un2FJf931mJrjn5FZNNaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438119; c=relaxed/simple;
	bh=iryEdB8KKt72kqwSR8MKw1iHOdULvo5hMcSIaQj7SRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5qS/pbX1vHnd7+Sn+HL6j1XQXclzcBPnDnszRcFjA+TtJxAYo4oiiTdpZAfIISHXPhsyWnbbu0n86PaSAmMjgrpbS7giMzZuk9vNvnfZDaeQcPgGKV7sghfJr0eHtDyROaqvJaTXAxpa1lfARV0QKiH5NImrwyGLHyKfXBum+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGNnMTc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD68C43399;
	Tue, 20 Feb 2024 14:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708438119;
	bh=iryEdB8KKt72kqwSR8MKw1iHOdULvo5hMcSIaQj7SRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eGNnMTc8JBW0aWAx5Yc6gcV2jJZfCpbbbq0WHjBb34bm2aayaofRtIV7DAJwX2LBg
	 ispeUEZzkswZPoMVYspX/YW+pYkyldPAMCgiWMfNQpEurz/1S70vUsJy3+11WHVzWX
	 G17Be7wjQOEhIYOACIpfZk4FPacxN53Ut6txGVVsS/nrNDqsKfKMqW1KrlgrxV63cb
	 n+VOaa6ZPOY9625FQQobgOWyODEBbt1K4Kk6WgcJX7E6bU84LIwvQK1EUcbZ5GQH4G
	 EoQMUw/gOUKoX0AfZq8rB45AGJpUXlANR4dLzuetGHPOd0fUqACjLxZ3qBU6+uCXy0
	 92WTuXnmxueig==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3d01a9a9a2so526170366b.1;
        Tue, 20 Feb 2024 06:08:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4jDlkPdy4aFc0KUm6sVGreahy3qpLC2wj1QrOw4Vrd0o2LHUCGCWHoeUffcILsC4Gu2WxdhPsKSASpKyATx343Msr5gBVO9g4PSL5Hqaair9eCUPfMawQRrZ9W90A/Xa5iN0=
X-Gm-Message-State: AOJu0YxRFQrT+5qEOcpG9VoBGuH2ISrSCfTw+969+3nZLe0IbBpAqbGq
	2np2ZgckuS2fbrmdB6JCYwumemkF89t5mX1crbXLFGPNnYPEISrsVczrLC20QBRRhYt39Gt6bWt
	aU0GSWAevNwkBcW3pZGQRZ8uPMg8=
X-Google-Smtp-Source: AGHT+IFh1S5EGj/RmTSdYzKlQnt4pu9mCF7R/WBVcJY0yfBhPCFuPMidE2cW4xtRkuephpeXwqxUaRg+pI0QTi6/KhY=
X-Received: by 2002:a17:906:2e8b:b0:a38:8575:2333 with SMTP id
 o11-20020a1709062e8b00b00a3885752333mr10650939eji.46.1708438117556; Tue, 20
 Feb 2024 06:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com>
 <20240214071620.GL355@twin.jikos.cz>
In-Reply-To: <20240214071620.GL355@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 Feb 2024 14:08:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com>
Message-ID: <CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: do not skip re-registration for the mounted device
To: dsterba@suse.cz
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org, dsterba@suse.com, 
	aromosan@gmail.com, bernd.feige@gmx.net, CHECK_1234543212345@protonmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 7:17=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Feb 13, 2024 at 09:13:56AM +0800, Anand Jain wrote:
> > There are reports that since version 6.7 update-grub fails to find the
> > device of the root on systems without initrd and on a single device.
> >
> > This looks like the device name changed in the output of
> > /proc/self/mountinfo:
> >
> > 6.5-rc5 working
> >
> >   18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> >
> > 6.7 not working:
> >
> >   17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> >
> > and "update-grub" shows this error:
> >
> >   /usr/sbin/grub-probe: error: cannot find a device for / (is /dev moun=
ted?)
> >
> > This looks like it's related to the device name, but grub-probe
> > recognizes the "/dev/root" path and tries to find the underlying device=
.
> > However there's a special case for some filesystems, for btrfs in
> > particular.
> >
> > The generic root device detection heuristic is not done and it all
> > relies on reading the device infos by a btrfs specific ioctl. This ioct=
l
> > returns the device name as it was saved at the time of device scan (in
> > this case it's /dev/root).
> >
> > The change in 6.7 for temp_fsid to allow several single device
> > filesystem to exist with the same fsid (and transparently generate a ne=
w
> > UUID at mount time) was to skip caching/registering such devices.
> >
> > This also skipped mounted device. One step of scanning is to check if
> > the device name hasn't changed, and if yes then update the cached value=
.
> >
> > This broke the grub-probe as it always read the device /dev/root and
> > couldn't find it in the system. A temporary workaround is to create a
> > symlink but this does not survive reboot.
> >
> > The right fix is to allow updating the device path of a mounted
> > filesystem even if this is a single device one.
> >
> > In the fix, check if the device's major:minor number matches with the
> > cached device. If they do, then we can allow the scan to happen so that
> > device_list_add() can take care of updating the device path. The file
> > descriptor remains unchanged.
> >
> > This does not affect the temp_fsid feature, the UUID of the mounted
> > filesystem remains the same and the matching is based on device major:m=
inor
> > which is unique per mounted filesystem.
> >
> > This covers the path when the device (that exists for all mounted
> > devices) name changes, updating /dev/root to /dev/sdx. Any other single
> > device with filesystem and is not mounted is still skipped.
> >
> > Note that if a system is booted and initial mount is done on the
> > /dev/root device, this will be the cached name of the device. Only afte=
r
> > the command "btrfs device scan" it will change as it triggers the
> > rename.
> >
> > The fix was verified by users whose systems were affected.
> >
> > CC: stable@vger.kernel.org # 6.7+
> > Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single d=
evice filesystem")
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D218353
> > Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK=
2gisPKDZLs8Y2TQ@mail.gmail.com/
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > Tested-by: Alex Romosan <aromosan@gmail.com>
> > Tested-by: CHECK_1234543212345@protonmail.com
>
> Reviewed-by: David Sterba <dsterba@suse.com>
>
> When you commit the patch, please reorder the tags according to
> https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#ordering

So this introduces a regression.

Running fstests:

(...)
btrfs/156 11s ...  16s
btrfs/157 3s ...  0s
btrfs/158 0s ...  2s
btrfs/159 16s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/159.out.bad)
    --- tests/btrfs/159.out     2020-10-26 15:31:57.061207266 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/159.out.bad
 2024-02-20 12:54:43.386131546 +0000
    @@ -1,8 +1,11 @@
     QA output created by 159
    +mount: /home/fdmanana/btrfs-tests/scratch_1: wrong fs type, bad
option, bad superblock on /dev/mapper/flakey-test, missing codepage or
helper program, or other error.
    +       dmesg(1) may have more information after failed mount system ca=
ll.
     File digest before power failure:
    -f049865ed45b1991dc9a299b47d51dbf  SCRATCH_MNT/foobar
    +b2e8facfb4795185fadd85707fe78973  SCRATCH_MNT/foobar
    +umount: /home/fdmanana/btrfs-tests/scratch_1: not mounted.
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/159.out
/home/fdmanana/git/hub/xfstests/results//btrfs/159.out.bad'  to see
the entire diff)
btrfs/160 4s ...  4s
(...)

The weird thing is it doesn't happen when running btrfs/159 standalone
(even if doing a rmmod btrfs before).

Instead of running all tests, I managed to reproduce it with only:

$ ./check btrfs/14[6-9] btrfs/15[8-9]
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.8.0-rc5-btrfs-next-151+ #1 SMP
PREEMPT_DYNAMIC Mon Feb 19 13:38:37 WET 2024
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/146 1s ...  2s
btrfs/147 0s ...  1s
btrfs/148 2s ...  2s
btrfs/149 1s ...  1s
btrfs/158 1s ...  0s
btrfs/159 20s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/159.out.bad)
    --- tests/btrfs/159.out 2020-10-26 15:31:57.061207266 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/159.out.bad
2024-02-20 13:51:25.707220763 +0000
    @@ -1,8 +1,11 @@
     QA output created by 159
    +mount: /home/fdmanana/btrfs-tests/scratch_1: wrong fs type, bad
option, bad superblock on /dev/mapper/flakey-test, missing codepage or
helper program, or other error.
    +       dmesg(1) may have more information after failed mount system ca=
ll.
     File digest before power failure:
    -f049865ed45b1991dc9a299b47d51dbf  SCRATCH_MNT/foobar
    +b2e8facfb4795185fadd85707fe78973  SCRATCH_MNT/foobar
    +umount: /home/fdmanana/btrfs-tests/scratch_1: not mounted.
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/159.out
/home/fdmanana/git/hub/xfstests/results//btrfs/159.out.bad'  to see
the entire diff)
Ran: btrfs/146 btrfs/147 btrfs/148 btrfs/149 btrfs/158 btrfs/159

dmesg shows:

[79195.239769] run fstests btrfs/159 at 2024-02-20 14:06:02
[79195.418917] BTRFS: device fsid 45ac9151-7e2d-4dd7-bf75-99967f869f2a
devid 1 transid 3747 /dev/sdb scanned by mount (3413231)
[79195.419515] BTRFS info (device sdb): first mount of filesystem
45ac9151-7e2d-4dd7-bf75-99967f869f2a
[79195.419525] BTRFS info (device sdb): using crc32c (crc32c-intel)
checksum algorithm
[79195.419529] BTRFS info (device sdb): using free-space-tree
[79195.612719] BTRFS: device fsid 10184d7d-3ca9-43c1-a6f8-70b134cff828
devid 1 transid 6 /dev/sdc scanned by mkfs.btrfs (3413318)
[79195.666279] BTRFS: device fsid 10184d7d-3ca9-43c1-a6f8-70b134cff828
devid 1 transid 6 /dev/dm-0 scanned by systemd-udevd (3410982)
[79195.695774] BTRFS info (device dm-0): first mount of filesystem
10184d7d-3ca9-43c1-a6f8-70b134cff828
[79195.695786] BTRFS info (device dm-0): using crc32c (crc32c-intel)
checksum algorithm
[79195.695789] BTRFS error (device dm-0): superblock fsid doesn't
match fsid of fs_devices: 10184d7d-3ca9-43c1-a6f8-70b134cff828 !=3D
628aff33-4122-4d77-b2a9-2e9a90f27520
[79195.696098] BTRFS error (device dm-0): superblock metadata_uuid
doesn't match metadata uuid of fs_devices:
10184d7d-3ca9-43c1-a6f8-70b134cff828 !=3D
628aff33-4122-4d77-b2a9-2e9a90f27520
[79195.696419] BTRFS error (device dm-0): dev_item UUID does not match
metadata fsid: 628aff33-4122-4d77-b2a9-2e9a90f27520 !=3D
10184d7d-3ca9-43c1-a6f8-70b134cff828
[79195.696765] BTRFS error (device dm-0): superblock contains fatal errors
[79195.697447] BTRFS error (device dm-0): open_ctree failed

It always happens with this patch applied in for-next, and never
happens with it reverted.

>

