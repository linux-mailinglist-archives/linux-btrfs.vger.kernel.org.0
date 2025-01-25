Return-Path: <linux-btrfs+bounces-11063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C7A1C413
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2025 16:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82083164D1F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2025 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C2D282F0;
	Sat, 25 Jan 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hexagon.cx header.i=@hexagon.cx header.b="1ePB1a5C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956E3232
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Jan 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737819951; cv=none; b=GyyMRZnxDajEYoDXZHAhO2PKIhg7koRUGzrD80G95Qs4xZ5eC5oe2UhdHd7zzdAb7NSReiKwDMHJhJpqLy2sL+3drTOh/hWNEQVCBCXfug3Rgi4UL7ybhdpgBIU0WC1v1SxGNpwwKf/M+RbzXOKT2347LgRx6L5tCuqbgB7nVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737819951; c=relaxed/simple;
	bh=uZWBSQyDwtXpNjRuj+i2atWJlgLr9pT19pSv1jb9VC0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BosjskcN4xv+iRxVX7DFPDa7/TpfcT8ffiaBbcEmMkCKdfrF2nlUd5kmYD5MTuk1R/9ArhSPv4CbN6F2MQGpMCokeTLGWMOvULQquw988GVwJVgcl1BHPBrzd7whpKj7mhlQyl98Stg913L5KHV5Ae0dL51AdRC9JyKxusYFxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexagon.cx; spf=pass smtp.mailfrom=hexagon.cx; dkim=pass (2048-bit key) header.d=hexagon.cx header.i=@hexagon.cx header.b=1ePB1a5C; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexagon.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexagon.cx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hexagon.cx;
	s=protonmail2; t=1737819945; x=1738079145;
	bh=LJeTyuyOEiUpJOXJ6eSxtS4hRfg4lYIQlnxeydOORio=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=1ePB1a5CDhh2QisqKEA90VLq3FuYbwgIj0YwUw1lNSQb62dMqOUR7WMbH2rhqLBEO
	 /opd1/KRaXc7ho2n9v/F0D/hD+035xScbVhMTZaXqwCe1pRRVBi2SbCvOJZ5qeQx46
	 hdTIfxiQmAgngLX0fmKf7u/Mge0SpBeUUtRBLH8j/S23tF525aB2/IsnbKH8cBblVR
	 Rpb8cQ7yNWhAEF+TACqyStiIflpCtlVRivsg0GFx/dKVJxH4NYHlL8bC23V801KNVc
	 m3cTHgpPR5bWzpwYhYd32zUXKl2GJbgDpVEHrWzbuqVLhEIiCD5sd4LVyn3fjI+SFe
	 emFhy5lezBbBg==
Date: Sat, 25 Jan 2025 15:45:42 +0000
To: Qu Wenruo <wqu@suse.com>
From: =?utf-8?Q?T=C3=A9o_Adams?= <ta@hexagon.cx>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Tree checker pre-write check finds corrupt leaf. drives now empty
Message-ID: <8BcBPWap4Bs8JbS5H2wIiW1havhhthxTYzlzlhM1ZAaf20YlyOCJa1d4jSWu0rE_HEpR2KLZXy4PE4sBmmDWCiAg-CxRQre_dHdCi0Y714g=@hexagon.cx>
In-Reply-To: <d6142943-8db9-4569-8228-f0c09b65298f@suse.com>
References: <rvOGZGZ2KKMe7x59is0hpo4PXWgjMZ9wuj4H3byWhiAZnJfWC2OHOQ4b7LYuvlBKVz9giNM_qjh9TZaq0Aa7mcqa9uNF6fxdEeqnbLQ_tP0=@hexagon.cx> <d6142943-8db9-4569-8228-f0c09b65298f@suse.com>
Feedback-ID: 12181862:user:proton
X-Pm-Message-ID: f3ca80813c80c14aa1d6b886bfeca3f35befff3b
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------9c2f1847e995df9459cd8c7b30d88129db084f4c4949987156b0084fcd4916f5"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------9c2f1847e995df9459cd8c7b30d88129db084f4c4949987156b0084fcd4916f5
Content-Type: multipart/mixed;boundary=---------------------05df93422490d4377aac59bea5aeb19e

-----------------------05df93422490d4377aac59bea5aeb19e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi Qu,

Thanks for your reply, unfortunately I wasn't thinking when I ran dmesg an=
d journnalctl earlier and didn't write the output to a file so the history=
 is no longer there :( Ironically, one of the next projects I have on my l=
ist is a log aggregation tool specifically to deal with this.

Disk space check, shows that /dev/dm-1 and /dev/dm-2/ are both empty:
```
=E2=9D=AF df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/dm-0       931G  673G  255G  73% /
tmpfs            16G  8.7M   16G   1% /run
/dev/dm-0       931G  673G  255G  73% /nix
devtmpfs        3.2G     0  3.2G   0% /dev
tmpfs            32G  601M   31G   2% /dev/shm
efivarfs        128K   35K   89K  28% /sys/firmware/efi/efivars
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-journald.se=
rvice
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-tmpfiles-se=
tup-dev-early.service
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-sysctl.serv=
ice
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-tmpfiles-se=
tup-dev.service
tmpfs            32G  1.4M   32G   1% /run/wrappers
/dev/dm-0       931G  673G  255G  73% /persist
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-cryptsetup@=
cryptextra.service
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-cryptsetup@=
cryptvms.service
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-vconsole-se=
tup.service
/dev/nvme1n1p1  511M   64M  448M  13% /boot
/dev/dm-1       233G  5.9M  231G   1% /mnt/extra
/dev/dm-2       466G  5.9M  464G   1% /mnt/vms
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-tmpfiles-se=
tup.service
tmpfs           6.3G   77M  6.2G   2% /run/user/1000
```

I ran memtester and all the checks passed:

```
=E2=9D=AF sudo memtester 56G 1
Please touch the device.
memtester version 4.6.0 (64-bit)
Copyright (C) 2001-2020 Charles Cazabon.
Licensed under the GNU General Public License version 2 (only).

pagesize is 4096
pagesizemask is 0xfffffffffffff000
want 57344MB (60129542144 bytes)
got  57344MB (60129542144 bytes), trying mlock ...locked.
Loop 1/1:
  Stuck Address       : testok
  Random Value        : ok
  Compare XOR         : ok
  Compare SUB         : ok
  Compare MUL         : ok
  Compare DIV         : ok
  Compare OR          : ok
  Compare AND         : ok
  Sequential Increment: ok
  Solid Bits          : ok
  Block Sequential    : ok
  Checkerboard        : ok
  Bit Spread          : ok
  Bit Flip            : ok
  Walking Ones        : ok
  Walking Zeroes      : ok

Done.
```

I understand that at this point there's likely very little I can do to get=
 you any useful information.
I suppose for now I will restore from back up and should the issue happen =
again, I'll be sure to write the full log output.

Thanks for your kind assistance
Teo



Sent with Proton Mail secure email.

On Thursday, January 23rd, 2025 at 11:57 PM, Qu Wenruo <wqu@suse.com> wrot=
e:

>
> =E5=9C=A8 2025/1/24 12:56, T=C3=A9o Adams =E5=86=99=E9=81=93:
>
> > Hello,
> >
> > I just read on your https://btrfs.readthedocs.io/en/latest/Tree-checke=
r.html page that you'd benefit from reports of corruption caught by tree c=
hecker. Obviously it would be great if you have advice on how to recover f=
rom my current situation, or avoid it in the future but regardless I hope =
the data I can provide will be helpful too you.
> >
> > For context, possibly too much, I am running NixOS on a system with 3 =
different drives, all of which use BTRFS.
> > Drive 1 (nvme) has two partitions: ESP for boot and a luks partition w=
ith 3 subvolumes that house /root, /nix (where the OS lives) and /home
> > Drive 2 (nvme) has a single luks partition and subvol used for storing=
 large media. It is not used very often.
> > Drive 3 (ssd) has a single luks partition and subvol that houses my qe=
mu vm images.
> >
> > When the incident occurred I had a single VM running via libvirt and h=
ad the usual assortment of multiple terminals, neovim instances (all files=
 being edited are on Drive 1), and browser windows. The only thing "using"=
 Drive 3 was the libvirt and nothing was using Drive 2.
> >
> > While attempting to write a neovim buffer I got an error about a datab=
ase I don't recognize being read-only, my system began to stutter, and I n=
oticed in a btop monitor that my RAM was pinned. While closing anything I =
didn't need and trying to save my work, my WM (hyprland/wayland) froze for=
 about 20 seconds but recovered. from there the system was very unresponsi=
ve, I could change windows but couldn't kill anything. Eventually I had to=
 reboot.
> >
> > Later on I went to spin up the VM but it complained that the VM didn't=
 exist. on further investigation I discovered that both Drive 2 and Drive =
3 are completely empty. They are both unlocked (which is automated using a=
 secondary unlock key used shortly after Drive 1 is unlocked), mounted, an=
d I can cd into them but there is no content at all.
>
>
> If it's write time tree-checker as described by the title, please run a
> memtest first, as that's the most common reason.
>
> I do not think the incident is directly linked to the lost of files.
> Unless the fs is already corrupted.
>
> Especially for drive 2, since you're not touching it frequently, it
> needs a lot of work to delete those many files.
>
> The same for drive 3.
>
> Mind to check if the free/available space for drive 2/3?
> Are they really empty or it's still taking space?
>
> > I'm completely at a loss to how this may have happened. The clue that =
led me to this email came from the following kernel message in logs that o=
ccurred around the same time.
> >
> > Jan 22 19:03:10 ghost kernel: BTRFS critical (device dm-0): corrupt le=
af: root=3D258 block=3D67236839424 slot=3D43, bad key order, prev (1844674=
4073709551611 48 42564423) current (184467440737095>
> > Jan 22 19:03:10 ghost kernel: BTRFS info (device dm-0): leaf 672368394=
24 gen 313844 total ptrs 77 free space 11791 owner 258
> > Jan 22 19:03:10 ghost kernel: item 0 key (42725548 108 0) itemoff 1525=
1 itemsize 1032
> > Jan 22 19:03:10 ghost kernel: inline extent data size 1011
> > Jan 22 19:03:10 ghost kernel: item 1 key (42725554 1 0) itemoff 15091 =
itemsize 160
> > Jan 22 19:03:10 ghost kernel: inode generation 313844 size 23509 mode =
100600
> > Jan 22 19:03:10 ghost kernel: item 2 key (42725554 12 75511) itemoff 1=
5041 itemsize 50
> > Jan 22 19:03:10 ghost kernel: item 3 key (42725554 108 0) itemoff 1498=
8 itemsize 53
> > Jan 22 19:03:10 ghost kernel: extent data disk bytenr 5280100352 nr 81=
92
> > Jan 22 19:03:10 ghost kernel: extent data offset 0 nr 24576 ram 24576
>
>
> Full dmesg please.
>
> The important leaf dump is long, and the digest is definitely not enough
> for us to figure out what's going wrong.
>
> Thanks,
> Qu
>
> > Fortunately I do have backups of most of the content that is missing f=
rom the drives.
> > If there's any additional info I can provide, please let me know.|
> >
> > Kind regards,
> > Teo
> >
> > Sent with Proton Mail secure email.


-----------------------05df93422490d4377aac59bea5aeb19e
Content-Type: application/pgp-keys; filename="publickey - ta@hexagon.cx - 0xF41BB5E4.asc"; name="publickey - ta@hexagon.cx - 0xF41BB5E4.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - ta@hexagon.cx - 0xF41BB5E4.asc"; name="publickey - ta@hexagon.cx - 0xF41BB5E4.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWEtwL0lSWUpLd1lCQkFI
YVJ3OEJBUWRBVUVNVDBndmxIUEtRdFliWkFya2NMUGZoQmhrNDRMVVIKV21hdXFFR0xTNWJOSHlK
MFlVQm9aWGhoWjI5dUxtTjRJaUE4ZEdGQWFHVjRZV2R2Ymk1amVEN0Nkd1FRCkZnb0FId1VDWEtw
L0lRWUxDUWNJQXdJRUZRZ0tBZ01XQWdFQ0dRRUNHd01DSGdFQUNna1Ezc3BkUkpCVAo2QzRsOXdE
L2V4cENycEt5QnFCMEs3WkVteXJiTjBybVJ1SGFkNUtUZEkzM2NmcGFZY0VCQUtUT2UxL0kKcU14
N1VmenhPMnA2RE1IOVNjTkFTQ0lHVmNrM2lGdzlBeTBKempnRVhLcC9JUklLS3dZQkJBR1hWUUVG
CkFRRUhRTTQwU2hFeTNDR2RVR1NVdGZTNlcxaWZOcmVxcEVRcEJUek1QbWV4eGM4T0F3RUlCOEpo
QkJnVwpDQUFKQlFKY3FuOGhBaHNNQUFvSkVON0tYVVNRVStndW1Mb0EvaWFBM0xJL0hPUlVDYlRF
K1NmUWZmVjYKOWw0U1dlNDJZQkpFdlZ4cURkandBUUNUa2w5V1QxOFpnUndkaTlBeW5SOEpEQ0F1
Y1EvRWZOMkVXemlXCmNkdnBBUT09Cj1TSS9FCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NL
LS0tLS0K
-----------------------05df93422490d4377aac59bea5aeb19e--

--------9c2f1847e995df9459cd8c7b30d88129db084f4c4949987156b0084fcd4916f5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmeVBxYJkN7KXUSQU+guRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdkx5yssp/8dT1wj3f9voZytqAq1QkdU8GOT3uB
aunFThYhBPQbteQsSdyHIw9Ue97KXUSQU+guAACdNQD/X4bvHywdamopq9Mb
7OttHNwU7QSOisd9rVMOy9369XQBAIFm0vIl7F1CsiLgRIqZtZL8vGyY/JR6
yunj9HTS0UAK
=dSHk
-----END PGP SIGNATURE-----


--------9c2f1847e995df9459cd8c7b30d88129db084f4c4949987156b0084fcd4916f5--


