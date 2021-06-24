Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80C53B2C1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 12:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhFXKJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 06:09:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:35011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231501AbhFXKJh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 06:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624529232;
        bh=+gjp9v5nS8Jns393gYE/hS2nnpq2+6bNzbWhqfzkqyQ=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=RgZeGua4IjFq4ySpe35SSHcgUhTi9AV5FpSDf5WhNW7W1KN7sOYq3nljs0cCOH5Rn
         hGfjsw4YV2jIc+PB+ZJByJu7I1sPfjN+YOgxgVdwAEhYCOGGwD1CiR/Re0MdtAf/qc
         h4YdcAaYInJ7E7UpaHwuOBZoctSdLInaogsFcbAY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1wlv-1lGvh82Cqn-012HPs; Thu, 24
 Jun 2021 12:07:12 +0200
To:     Zhenyu Wu <wuzy001@gmail.com>, Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <bl7yotou.fsf@damenly.su>
 <CAJ9tZB9M=KOWVLH_azagtBnxDzpV2=ssnBcYsJx6Ao8cQOELhg@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su>
 <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
 <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com>
 <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
 <CAJ9tZB8Y+yNoTQmEjuV3f9QL05+=abJ-Ue4m7iRkxAC0NDhTFw@mail.gmail.com>
 <3670289c-19fb-482f-d2ca-3c84eb5decbe@cobb.uk.net>
 <CAJ9tZB-7ogKcPCF=r72jJ3pvZLD3h6VfQbks-pfkB5N_yhJzTg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
Message-ID: <93bc4428-467f-9a08-0dbf-1fae8cec42dd@gmx.com>
Date:   Thu, 24 Jun 2021 18:07:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB-7ogKcPCF=r72jJ3pvZLD3h6VfQbks-pfkB5N_yhJzTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:61doMZM/OXUd+KDyWULg02fB4PEmHasmQv+fif8uc0Y1ypFYzdU
 ZQ92QUUwCCh5TI4z9AZt6MKlYO76Q40eFDQ0gs0Wy1YofYDiyviyohrjP7WfX7slMaVVcmb
 FJQKIkmRdsP0rx3qS9Okc7/XGjAYMlxft/rhDwIX99hm35NJeHz15hK4F043/1IRe1rkLGV
 C4mUYrwyexqOLXpNCbuxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gTl8/rJv9Ow=:pifPl+v4O/uTj8u3iStatO
 KNAskv8hBBXiYKe6lSsIzEUNDnDnVAWT7Ke/VocQnwiYRi3zdJwRq6rERskrTQbIkPoG/sXjr
 tcTFlpghyjJQi0Aa5PT01wsRSn7guWPpTQcH4m0KiOw/nAtsELytjy+ubp2KTE8iJkXNOS6Cw
 BnBvjZpHiTcdkBRPZ35dNIHwwbseZi08WgmyCWJ5qX8cKJRxFRGQa1DNejY5MGFQI87xoONio
 l0ErPN1/iCYlM/AnbOFXSvL6RVacJt3MYSf5rnVa2RakjJlWKWQs/HCOXTCiYW/pPTxdb3BaU
 ILqn5194BXqILu+XhCDmnsEEQA4JHy90EftuzNX6NYYFGrka6DNYq1WXpwHe1KBum+aMNoK7V
 jyTyoIUPdXtZtJKY4ylTCKFHthymu9jvAW2arm6PbkpCLviI17Wt6QRdGvd42xFXKqyno4GkG
 aKrfreELdshcgWkcFkOjFkZ1eqwd9JPrKkVcqFzfemRQMes2GJ9XjZAcjq2NV+Dtg8pP3ik/9
 GxZc36DZksdk+odYkHt0sAaDO/horma6jugWhJkVWlsj9DhRkIU1LCEgrrV7E5lAKKWttEAik
 rtkP1kKYlTPKChY6T0mi1EBp4e9B/GEZntCnOTSKK+q0RHDV1fe11glxNLN2f62T0UpbEw9F2
 U0bfcNcFFWfwQoR+YtKxgeoXEAe5KT0uarfotAWdjglZwsD9DelPWiB1ZPPP5UjkQ9GW2aX7a
 xLmXFUC8EE0smckxvugT+pnRvg5TJqHAA4b6uEaDIESeEav8IVR5bCsAwhDdaiYrnJH1ozAuz
 ZR3kwqC9RUEsSuMNnVP/O7At0orwkEo1lasw9Mp6rYvSIK3VsSPrsHt72HmzY+ZL+2nvtbsdZ
 OPe/kLx2XF7mOGjNRaeL8ltNMCfFlE4qn8kbzPCkE0owK6h60pVzWcSCKzV1wCyly9t4lwf6q
 FO7FpPBxiUeZxnQuDVmGfHb3Qnn4Axz6UaYbfT9nKxg/L1z7BkuXpLMFVu/q2I1K166puaRcS
 9HnInSlrPB1INcJ1hVMtXbt2MKonkQOTHLF8R6F+hvWlJpQ5z8tTrZPJ8nnBjKmkRBGmhM3Kf
 pacybHXaxJyNTkCebU7vUd6v6Pf45nZZrYze/t77zXgqNMnOkwQQOn3CA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/24 =E4=B8=8B=E5=8D=885:52, Zhenyu Wu wrote:
> i have rescan quota but it looks like nothing change...
> ```
> $ sudo btrfs quota rescan -w /
> quota rescan started
> # after 8m39s
> $ sudo btrfs qgroup show -pcre /
> qgroupid         rfer         excl     max_rfer     max_excl parent   ch=
ild
> --------         ----         ----     --------     -------- ------   --=
---
> 0/5          81.23GiB      6.89GiB         none         none ---      --=
-
> 0/265           0.00B        0.00B         none         none ---      --=
-
> 0/266           0.00B        0.00B         none         none ---      --=
-
> 0/267           0.00B        0.00B         none         none ---      --=
-
> 0/6482          0.00B        0.00B         none         none ---      --=
-
> 0/7501       16.00KiB     16.00KiB         none         none ---      --=
-
> 0/7502       16.00KiB     16.00KiB         none         none 255/7502 --=
-
> 0/7503       16.00KiB     16.00KiB         none         none 255/7503 --=
-

This is now getting super weird now.

Firstly, if there are some snapshots of subvolume 5, it should show up
here, with size over several GiB.

Thus there seems to be some ghost/hidden subvolumes that even don't show
up in qgroup.

It's possible that some qgroup is intentionally deleted, thus not being
properly updated.

For that case, you may want to disable qgroup, re-enable, then do a
rescan: (Can all be done on the running system)

# btrfs quota disable <mnt>
# btrfs quota enable <mnt>
# btrfs quota rescan -w <mnt>

Then provide the output of 'btrfs qgroup show -prce <mnt>"

If the output doesn't change at all, after the full 10min rescan, then I
guess you have to dump the root tree, along with the data_reloc tree.

# btrfs ins dump-tree -t root <device>
# btrfs ins dump-tree -t data_reloc <device>

Thanks,
Qu
> 1/0             0.00B        0.00B         none         none ---      --=
-
> 255/7502     16.00KiB     16.00KiB         none         none ---      0/=
7502
> 255/7503     16.00KiB     16.00KiB         none         none ---      0/=
7503
> ```
>
> and i try to mount with option subvolid:
> ```
> $ mkdir /tmp/fulldisk
> $ sudo mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
> $ ls -lA /tmp/fulldisk
> total 4
> drwxr-xr-x 1 root   root   1936 May  3 21:34 bin
> drwxr-xr-x 1 root   root      0 Jan 25  2020 boot
> drwxr-xr-x 1 root   root   1686 Jan 20  2020 dev
> drwxr-xr-x 1 wzy    wzy    5756 Jun 24 13:51 etc
> drwxr-xr-x 1 root   root     22 Oct 17  2020 home
> drwxr-xr-x 1 root   root   1332 May 18 14:13 lib
> drwxr-xr-x 1 root   root   6606 May 18 14:13 lib64
> lrwxrwxrwx 1 root   root     10 Jan 24 20:23 media -> /run/media
> drwxr-xr-x 1 wzy    wzy      38 Jan 27 16:51 mnt
> drwxr-xr-x 1 root   root    234 Jun 18 14:29 opt
> drwxr-xr-x 1 root   root      0 Jan 20  2020 proc
> drwx------ 1 wzy    wzy     536 Jun 15 20:26 root
> drwxr-xr-x 1 root   root     48 May 30 14:14 run
> drwxr-xr-x 1 root   root   4926 May 18 14:12 sbin
> drwxr-xr-x 1 root   root     10 Jan 20  2020 sys
> drwxrwxrwx 1 nobody nobody    0 Jun 18 14:34 tftproot
> drwxrwxrwt 1 root   root      0 May 30 14:25 tmp
> drwxr-xr-x 1 root   root    198 Mar 31 19:32 usr
> drwxr-xr-x 1 root   root    150 Apr  1 18:21 var
> $ sudo btrfs fi du -s /tmp/fulldisk/*
>       Total   Exclusive  Set shared  Filename
>    10.66MiB       0.00B    10.66MiB  /tmp/fulldisk/bin
>       0.00B       0.00B       0.00B  /tmp/fulldisk/boot
>       0.00B       0.00B       0.00B  /tmp/fulldisk/dev
>    33.34MiB    36.00KiB    33.30MiB  /tmp/fulldisk/etc
>    13.79GiB   784.05MiB    12.96GiB  /tmp/fulldisk/home
>   922.28MiB       0.00B   922.28MiB  /tmp/fulldisk/lib
>    23.11MiB       0.00B    23.11MiB  /tmp/fulldisk/lib64
> ERROR: cannot check space of '/tmp/fulldisk/media': Inappropriate
> ioctl for device
>       0.00B       0.00B       0.00B  /tmp/fulldisk/mnt
>    11.08GiB       0.00B    11.08GiB  /tmp/fulldisk/opt
>       0.00B       0.00B       0.00B  /tmp/fulldisk/proc
>    40.38MiB     4.35MiB    36.03MiB  /tmp/fulldisk/root
>       0.00B       0.00B       0.00B  /tmp/fulldisk/run
>    26.62MiB       0.00B    26.62MiB  /tmp/fulldisk/sbin
>       0.00B       0.00B       0.00B  /tmp/fulldisk/sys
>       0.00B       0.00B       0.00B  /tmp/fulldisk/tftproot
>       0.00B       0.00B       0.00B  /tmp/fulldisk/tmp
>    47.22GiB     1.03GiB    46.15GiB  /tmp/fulldisk/usr
>     5.80GiB     4.35GiB     1.45GiB  /tmp/fulldisk/var
> ```
>
> because media is a symbolic link so the ERROR should be normal.
> according to `btrfs fi du` it looks like i only use about 80GiB. it is
> too weird.
> thanks!
>
> On Thu, Jun 24, 2021 at 4:32 PM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>>
>> On 24/06/2021 08:45, Zhenyu Wu wrote:
>>> Thanks! this is some information of some programs.
>>> ```
>>> # boot from liveUSB
>>> $ btrfs check /dev/sda2
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> [4/7] checking fs roots
>>> [5/7] checking only csums items (without verifying data)
>>> [6/7] checking root refs
>>> [7/7] checking quota groups
>>> # after mount /dev/sda2 to /mnt/gentoo
>>
>> Did you do 'mount -o subvolid=3D5 /dev/sda2 /mnt/gentoo' to make sure y=
ou
>> can see all subvolumes, not just the default subvolume? I guess it
>> doesn't matter for quota, but it matters if you are using tools like du=
.
>>
>> You don't even need to use a liveUSB. On your normal mounted system you
>> can do...
>>
>> mkdir /tmp/fulldisk
>> mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>> ls -lA /tmp/fulldisk
>>
>> to see if there are other subvolumes which are not visible in /
