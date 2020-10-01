Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3983327FC11
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 10:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbgJAI4z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 04:56:55 -0400
Received: from ns13.heimat.it ([46.4.214.66]:48084 "EHLO ns13.heimat.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731861AbgJAI4l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 04:56:41 -0400
Received: from localhost (ip6-localhost [127.0.0.1])
        by ns13.heimat.it (Postfix) with ESMTP id 2BBB73021B8;
        Thu,  1 Oct 2020 08:56:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at ns13.heimat.it
Received: from ns13.heimat.it ([127.0.0.1])
        by localhost (ns13.heimat.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0qbbZ0HqYNud; Thu,  1 Oct 2020 08:56:19 +0000 (UTC)
Received: from bourrache.mug.xelera.it (unknown [93.56.169.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by ns13.heimat.it (Postfix) with ESMTPSA id 3901E3021B5;
        Thu,  1 Oct 2020 08:56:19 +0000 (UTC)
Received: from roquette.mug.biscuolo.net (roquette [10.38.2.14])
        by bourrache.mug.xelera.it (Postfix) with SMTP id 7D31076EF9A;
        Thu,  1 Oct 2020 10:56:18 +0200 (CEST)
Received: (nullmailer pid 28204 invoked by uid 1000);
        Thu, 01 Oct 2020 08:56:16 -0000
From:   Giovanni Biscuolo <g@xelera.eu>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: how to recover from "enospc errors during balance"
In-Reply-To: <20200930000417.GH5890@hungrycats.org>
Organization: Xelera.eu
References: <87r1qk4q4d.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
 <20200930000417.GH5890@hungrycats.org>
Date:   Thu, 01 Oct 2020 10:56:15 +0200
Message-ID: <878scq1g0g.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello Zygo,

thank you for your help!

...but I still cannot mount the filesystem RW, see below.

Zygo Blaxell <ce3g8jdj@umail.furryterror.org> writes:

> On Tue, Sep 29, 2020 at 04:25:06PM +0200, Giovanni Biscuolo wrote:

[...]

>> [6928066.755704] BTRFS info (device sda3): balance: start -dusage=3D50 -=
musage=3D70 -susage=3D70
>
> Never balance metadata on a schedule.  If it is done too often, and the
> disk fills up, it will eventually lead to ENOSPC errors that are hard
> to get out of...

OK I got it: I'll fix it as soon as I'll get to remount the (root)
filesystem.

I was using an option I did not fully understand and I was not able to
find such a warning in the documentation.

[...]

>> I tried to add a new device (I have 2 spare disks) but it does not work
>> with a read-only filesystem.
>>=20
>> Please how can I remount the filesystem read-write and free some space
>> deleting some files?
>
> Add 'skip_balance' to mount options so that the next mount will not
> attempt to resume balancing metadata.  Keep mounting and umounting
> (not remounting) until it completes orphan and relocation cleanup (it
> may take more than one attempt, probably fewer than 20 attempts).

I try to mount with this command:

=2D-8<---------------cut here---------------start------------->8---

~$ mount -o skip_balance,relatime,ssd,subvol=3D/ /dev/sda3 /
mount: /: wrong fs type, bad option, bad superblock on /dev/sda3, missing c=
odepage or helper program, or other error.

=2D-8<---------------cut here---------------end--------------->8---

dmesg says:

=2D-8<---------------cut here---------------start------------->8---

[7484575.970136] BTRFS info (device sda3): disk space caching is enabled
[7484576.001375] BTRFS error (device sda3): Remounting read-write after err=
or is not allowed

=2D-8<---------------cut here---------------end--------------->8---

Am I doing something wrong?

It seems that the filesystem is not allowed to be remounted RW after the
error.

I don't think rebooting is a good option since it will be unbootable
(and it's a remote machine).

I fear the only option is to reboot from USB and revover :(

Do you have any other option in mind please?

> Once you have the filesystem mounted, run 'btrfs balance cancel' on
> the mount point.  Then edit your maintenance scripts and remove the
> metadata balance (-m flag to 'btrfs balance start').

OK clear thanks.

>> Additional data:
>>=20
>> --8<---------------cut here---------------start------------->8---

[...]

>> ~$ sudo btrfs fi usage /
>> Overall:
>>     Device size:                 899.07GiB
>>     Device allocated:            899.07GiB
>>     Device unallocated:            2.01MiB
>>     Device missing:                  0.00B
>>     Used:                        897.05GiB
>>     Free (estimated):             85.87MiB      (min: 85.87MiB)
>>     Data ratio:                       2.00
>>     Metadata ratio:                   2.00
>>     Global reserve:              512.00MiB      (used: 5.53MiB)
>>=20
>> Data,RAID1: Size:446.50GiB, Used:446.42GiB (99.98%)
>>    /dev/sda3     446.50GiB
>>    /dev/sdb3     446.50GiB
>>=20
>> Metadata,RAID1: Size:3.00GiB, Used:2.11GiB (70.22%)
>>    /dev/sda3       3.00GiB
>>    /dev/sdb3       3.00GiB
>>=20
>> System,RAID1: Size:32.00MiB, Used:80.00KiB (0.24%)
>>    /dev/sda3      32.00MiB
>>    /dev/sdb3      32.00MiB
>>=20
>> Unallocated:
>>    /dev/sda3       1.00MiB
>>    /dev/sdb3       1.00MiB

[...]

> To avoid this, never run metadata balances from a scheduled job (or for
> any reason other than working around a kernel bug or adding disks to a
> RAID array) so that an appropriate number of metadata block groups is
> allocated and _stay_ allocated.

[...]

> Scheduled data balances (-d) are OK.  They defragment free space and
> improve allocator performance, and make unallocated space available so
> that additional metadata block groups can be allocated when necessary.

OK got it: thank you for the clear and complete explanation.

No doubt I made a bad mistake with that scheduled job :-(

[...]

Thanks, Giovanni.

=2D-=20
Giovanni Biscuolo

Xelera IT Infrastructures

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCgAqFiEERcxjuFJYydVfNLI5030Op87MORIFAl91mbAMHGdAeGVsZXJh
LmV1AAoJENN9DqfOzDkSdWsP/1ItL8PyDvcmzYtG/qCjom+IsiP6Y8jn/NUOP44e
lrx6dqFd4GcoSkV/yZSHI9ZOvpHcGiFmU8+lruu45UEB51LpKReJNS7xwgysArs0
57vsBDzfUVCX0dSBFO4psvheVwINcVK7Ja77ZZYOgDcpY/tuSKSKrvctsI1hjUHv
DxVmkwUsYC5+mxqjqk+cGU85PBlR5+xId3WmPYdExXA/EIvvyT64K/T1ikk3T6xn
DAy/4BUS3C3qRHpYG6jRJPNcrt5em+WwQBvpWCBBG0bjF0N2Y5yuDuVFB2g7X2oD
7O7rQ4kOwcRLodlysVFqoedX9jKs+OEibejV5EBKhTRgYamT5ZH9+b5nHsTu4G1X
pvuePQtumEHAQeITwDNvIpXatUgfiQiHGUZZipyGJQSJJv4hOgRtMMSYa4yHqKoy
83XadY/5KhmoiIfJNXnZsiIoTlGtVtmSm7+npKPL/UhPWEZpg9TDGEpLyrXzhVVu
OpEbo1NMzVBpkkUqaaiFF2GZIInM7PlkBERKddXZP+FN1R5TJXzN7apNQ8jnmfib
MHGMkAapdPvf3mDxgQA9KbfTsrvZ2WV8UmsLmKLs9z/ZB3Ivgxi/IzJf1HrJDF0i
DxX5GYlqYTGAB6kJw+BeU5uPG9i4zLDo/GGOjtLu9RcOw7Mm0Q1OzyjTYIuM8Vz8
agrb
=eBSB
-----END PGP SIGNATURE-----
--=-=-=--
