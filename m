Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188BA1A3604
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgDIOej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 10:34:39 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:39846 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgDIOei (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Apr 2020 10:34:38 -0400
Received: by mail-ed1-f45.google.com with SMTP id a43so13555826edf.6
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Apr 2020 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IxNBayIOKJX6+q7dr9bav3myRIO6JFNxDzIUsk+fPVE=;
        b=S2rROVYe9CIzie/40uE/r3GNWCfZGUdsfH5SjS8hjbqG31ECx5Xq/mUjViavIx7sCc
         4ZWwrrwcCNQRvd3ewPP1jpSRJ4w41TzERxQ8rxjM30Yt2tAe4iLBtkZJFEm+ZK48k541
         YbpRh5DtGvYJD9NrylaKay1xE7/kWuuG8vCUNHdXimHfbaLAhYVuzGXwAb4dMqz/j/9b
         jicm3v6s/dS+Cewesvv21TStkzgq3KIXOKJtadREI17+bqAh1O2tbfGwPIGpGMmQcaXp
         fc7scuKNjC5oEJw4G8c1O5qVtoQDC0DPojGaMAEO2bN4Jusms1vpp8VdHC0lb5u4c8LS
         ufZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=IxNBayIOKJX6+q7dr9bav3myRIO6JFNxDzIUsk+fPVE=;
        b=VVhJnUwsUhiyr0uOocuhi1x4aTbMJhYBOtEHiTB/xTVz0r79wBolXL/M0kZEROSgQT
         ePH/KGOzrIyHPe94uYmqIY4t3m3nwivaZjWx/zWaHfhRjNwBSjkgh/2bEW9S02AwuYcg
         eMjnV48Vsjz5i7MwrXhXf43a8ldBt5N1Wn5Q7S7lyhUUVnHhpwDWvpvprOCmqqCrxvJG
         m9gQOAHzttzpjX0EL9KPXzwbZ00/Q6eM1476TSSj42FatHLq7zmMYzbSomRjr1xAjYWi
         apfJlvbUIaEEJqIcy+4Lpj+KF5fySohPEDYlFuK42y0+Urnu6ikeF/QEw/0U0p9UhUtQ
         Z58g==
X-Gm-Message-State: AGi0Pua6F5PuPIm7wfdmrXLLWNeymzKLeT6pXV4QVbTR7SK/Yk7vEnSu
        AOKoO9PZQYB0vpgEIhiIVUy/4Ypa1CIhzc1YhWNxv8EU
X-Google-Smtp-Source: APiQypJMOSaGFWz387+dziyS6IEGpYHL2rvbC+ohZGEr0nupk9PWm0ZREqccQPR9EthtuQC6XpA6xYkTNUsLQchGQHo=
X-Received: by 2002:a50:cfc6:: with SMTP id i6mr294423edk.314.1586442874710;
 Thu, 09 Apr 2020 07:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAG_uc2NkAOAnZtW=+cAR3YfH4frfqooJugjzCDZX161wnKDnqg@mail.gmail.com>
In-Reply-To: <CAG_uc2NkAOAnZtW=+cAR3YfH4frfqooJugjzCDZX161wnKDnqg@mail.gmail.com>
From:   Zak Lantz <zakodewald@gmail.com>
Date:   Thu, 9 Apr 2020 10:34:24 -0400
Message-ID: <CAG_uc2ORzb0uessFHTBLiMcdEtGxVtEZEJw_UXEX2EOSMq-quw@mail.gmail.com>
Subject: Re: btrfs pool failure - bad superblock
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I recently had a drive fail in my btrfs pool. I rebooted to pull the
bad drive. Upon boot, I can no longer mount the remaining drive's
partition. I have tried btrfs restore as well and both complain about
a bad superblock as well as the backup superblock.
If I try and run a super-recover, all supers display as being good.
Any help would be appreciated.

Thanks

root@stylophora:~# mount -o degraded,usebackuproot,ro /dev/sdc1
/mnt/user/btrfsbackup
mount: /mnt/user/btrfsbackup: wrong fs type, bad option, bad
superblock on /dev/sdc1, missing codepage or helper program, or other
error.
root@stylophora:~# btrfs restore -v -u 1 /dev/sdc1 /mnt/user/Backup/cachebc=
k
warning, device 2 is missing
bad tree block 578836021248, bytenr mismatch, want=3D578836021248, have=3D0
ERROR: cannot read chunk root
Could not open root, trying backup super
warning, device 2 is missing
bad tree block 578836021248, bytenr mismatch, want=3D578836021248, have=3D0
ERROR: cannot read chunk root
Could not open root, trying backup super
root@stylophora:~# btrfs rescue super-recover -v /dev/sdc1
All Devices:
        Device: id =3D 3, name =3D /dev/sdc1

Before Recovering:
        [All good supers]:
                device name =3D /dev/sdc1
                superblock bytenr =3D 65536

                device name =3D /dev/sdc1
                superblock bytenr =3D 67108864

                device name =3D /dev/sdc1
                superblock bytenr =3D 274877906944

        [All bad supers]:

All supers are valid, no need to recover
root@stylophora:~# uname -a
  btrfs --version
Linux stylophora 4.19.98-Unraid #1 SMP Sun Feb 2 20:47:34 GMT 2020
x86_64 Intel(R) Xeon(R) CPU           X5680  @ 3.33GHz GenuineIntel
GNU/Linux
root@stylophora:~#   btrfs --version
btrfs-progs v5.4
root@stylophora:~#   btrfs fi show
Label: none  uuid: fe361bb0-4606-4eb0-a18f-f741b163c052
        Total devices 1 FS bytes used 376.00KiB
        devid    1 size 50.00GiB used 536.00MiB path /dev/loop2

Label: none  uuid: aea70e3c-11b6-43f9-b08d-c4c38dda2887
        Total devices 1 FS bytes used 332.00KiB
        devid    1 size 1.00GiB used 126.38MiB path /dev/loop3

warning, device 2 is missing
bad tree block 578836021248, bytenr mismatch, want=3D578836021248, have=3D0
ERROR: cannot read chunk root
Label: none  uuid: eccae6e7-e489-4019-9e4d-501445eff3d8
        Total devices 2 FS bytes used 507.73GiB
        devid    3 size 931.51GiB used 523.00GiB path /dev/sdc1
        *** Some devices missing


On Thu, Apr 9, 2020 at 10:16 AM Zak Lantz <zakodewald@gmail.com> wrote:
>
> Hello,
>
> I recently had a drive fail in my btrfs pool. I rebooted to pull the bad =
drive. Upon boot, I can no longer mount the remaining drive's partition. I =
have tried btrfs restore as well and both complain about a bad superblock a=
s well as the backup superblock.
> If I try and run a super-recover, all supers display as being good.
> Any help would be appreciated.
>
> Thanks
>
> root@stylophora:~# mount -o degraded,usebackuproot,ro /dev/sdc1 /mnt/user=
/btrfsbackup
> mount: /mnt/user/btrfsbackup: wrong fs type, bad option, bad superblock o=
n /dev/sdc1, missing codepage or helper program, or other error.
> root@stylophora:~# btrfs restore -v -u 1 /dev/sdc1 /mnt/user/Backup/cache=
bck
> warning, device 2 is missing
> bad tree block 578836021248, bytenr mismatch, want=3D578836021248, have=
=3D0
> ERROR: cannot read chunk root
> Could not open root, trying backup super
> warning, device 2 is missing
> bad tree block 578836021248, bytenr mismatch, want=3D578836021248, have=
=3D0
> ERROR: cannot read chunk root
> Could not open root, trying backup super
> root@stylophora:~# btrfs rescue super-recover -v /dev/sdc1
> All Devices:
>         Device: id =3D 3, name =3D /dev/sdc1
>
> Before Recovering:
>         [All good supers]:
>                 device name =3D /dev/sdc1
>                 superblock bytenr =3D 65536
>
>                 device name =3D /dev/sdc1
>                 superblock bytenr =3D 67108864
>
>                 device name =3D /dev/sdc1
>                 superblock bytenr =3D 274877906944
>
>         [All bad supers]:
>
> All supers are valid, no need to recover
> root@stylophora:~# uname -a
>   btrfs --version
> Linux stylophora 4.19.98-Unraid #1 SMP Sun Feb 2 20:47:34 GMT 2020 x86_64=
 Intel(R) Xeon(R) CPU           X5680  @ 3.33GHz GenuineIntel GNU/Linux
> root@stylophora:~#   btrfs --version
> btrfs-progs v5.4
> root@stylophora:~#   btrfs fi show
> Label: none  uuid: fe361bb0-4606-4eb0-a18f-f741b163c052
>         Total devices 1 FS bytes used 376.00KiB
>         devid    1 size 50.00GiB used 536.00MiB path /dev/loop2
>
> Label: none  uuid: aea70e3c-11b6-43f9-b08d-c4c38dda2887
>         Total devices 1 FS bytes used 332.00KiB
>         devid    1 size 1.00GiB used 126.38MiB path /dev/loop3
>
> warning, device 2 is missing
> bad tree block 578836021248, bytenr mismatch, want=3D578836021248, have=
=3D0
> ERROR: cannot read chunk root
> Label: none  uuid: eccae6e7-e489-4019-9e4d-501445eff3d8
>         Total devices 2 FS bytes used 507.73GiB
>         devid    3 size 931.51GiB used 523.00GiB path /dev/sdc1
>         *** Some devices missing
