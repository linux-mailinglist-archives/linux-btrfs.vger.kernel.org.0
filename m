Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D62912AA33
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 06:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfLZFIX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 00:08:23 -0500
Received: from mout.gmx.net ([212.227.17.21]:46729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfLZFIX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 00:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577336896;
        bh=Q70vtsErD3ZHqGc/nwa2yM6nOq2uvC5ErKHrPPhgtRs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BEBy8vw7JMSqgp2R7SiDoBt800hmqZrXnQRSQCZryctTYqE80irA3+9cE1+HtgMpM
         x1yjf0GcVGpTOK3oYFNhoqBuGMOtAwCDcMrhQIYQkzd8qJCgtHk4gG8bwtpAqRJFfG
         /kYZDn0a/xnTfB3Rbjfgl3Vz80vVSGy+AArBnhZw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbivG-1jLLQ92HQE-00dJqE; Thu, 26
 Dec 2019 06:08:16 +0100
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Leszek Dubiel <leszek@dubiel.pl>, linux-btrfs@vger.kernel.org
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
Date:   Thu, 26 Dec 2019 13:08:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="G2zPmOnAD09tJy4d3qvznSngrjAg2eNhj"
X-Provags-ID: V03:K1:57SaitCBk525oYHrlrXZqY+c2MYLpDudTNtjAjTp/Ck2iI4roGX
 O4hwDnBFSPiiYMFF71hQgoeODBMM4B0z6G5nL1YYkOsfVCIXhtVUaGQQgXCPIVjKZA+59/R
 Vc6jl2uKT+bDbPXc3mCpg9iZ215BQ6DPTbJx/1+/J0EaEGo1cm/HKO/1yLzpZozOTL/hYki
 TfAWvt1xotF4Z+oaVHOMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HVuLOY1udDE=:NPnkr0i5SakpWXbGPYP4xZ
 KwlZ/MXBI0+T1U+ipa1fAwGj0Ibean08Mn4Mwa/vGb8m18Rx0yK9IdlGozZ9tiTbWc51fzaqj
 J67PQ3Uxnf10uXmyh/dQTWRYX2OO6VtOowDnLgvA+pasJZXnOh2cGDQBysTxLzBL5z1Q+LHt8
 1d4Ln9rKZ6JPiENTbJjFzHeEUvjpy7F3yCYWaFIoG+t990FiHNdL1VTrnUZNbbGxH5FZAxWxR
 bmt3emWp/hW36G58NR2kz72ihkcaXsK+bFNQhonDX56mfb2yMQlAKDS+eKsIwW/bYJrghubnP
 eImupyH3SxoRw4BA+2TuIG79fZzIrzYR5p3VJRjO3jpe7vXrLBzsgF1u/mPNC9eQ+t4FsmVAm
 IMlz4D4mjpzqhqMHhkQlbXT3uGYVXUIYC6jgL6O8Uk+6FDfb38VvzTTth6Tim6uz2Wlql3mMB
 Qt4XMXzOat8TT7CSU20phO9FjqrrrzqjyPlbUZjJUOhC15QblWU3ASRnxxGGXSD0qpnrlgLMD
 GQWbqUIbF+dfbcxjD3MAQvA1eZeF+ZKaTCtNiu42cLs+0534Dt2LDWvLoxfuDwnFmUCphQf0l
 paaLrCtKSVV1nC4sna5aUWdjFZ1NDHOSLXB6FB8SkwtsL3V4i7TdJNgt1ksPgN0kfTA37IEAs
 FLMJWyKghpDG7uWqjJCJL2Z2NmZqoAKBgecQvhYX0Mjul/N1N5f8coTgDu2yPgAogUOqlnmij
 A8FccsvRUPIrAq0kfilvBXxCqDBkNRcsUM8pSV9hIga89vFNUN8JTNC1F+t9iXpicf01ssekf
 XmWNl3Xd05f5vJhtpEheFXGIT6sNVDBzWPYAoGTqKwjzvsixd/sSxXtC2EyNOvRP5Z6TnP8nS
 T4feaJ4T7ubBnfhgPwX0cP3UjyDjgLt08LuvhZIYZGKyhTdtKN4h2ALBcppFePbXM9cvfCzBA
 fFkPMzvhhEJ4lkNjhT1LbaSUbwHChc/D5qLx1d7gR6WrSAx11ZXapY8k2hXvLZzO0AOENjOd1
 MANmI/CwovpMRvb6H22XeCcI8ks15kMEwuauawnWhXhYMI17PMGJ03scm9Pi/tcEwXd1WpDJx
 Khc2n4NDplWT3g4BxIlDwtmZKsNDp2rlx3er7UAUMoRsOCpsuON277HCCvl2wM3hfe5Olag8f
 BjUcply8kHZRL3o8xLLDtPbL7pOzT+7CpJL7CEn3FZ+YLjuTx/vHHxebeigw3uHsqZ1XU6nD0
 +nYQtkP82OLERM8tA21p0tv1NaPbLRSP7Ozh2Z3upymwgpHA4KQL/drJdsBo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G2zPmOnAD09tJy4d3qvznSngrjAg2eNhj
Content-Type: multipart/mixed; boundary="EhlZ5ePqYMLDq1HJ10PdZek03IOlAmQHl"

--EhlZ5ePqYMLDq1HJ10PdZek03IOlAmQHl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/26 =E4=B8=8A=E5=8D=886:35, Leszek Dubiel wrote:
>=20
> Hello!
>=20
> I have a server: 3 disks, 6TB each, total 17TB space, occupied with dat=
a
> 6TB.
>=20
>=20
> One of the disks got smart errors:
>=20
> =C2=A0=C2=A0=C2=A0 197 Current_Pending_Sector=C2=A0 0x0022=C2=A0=C2=A0 =
100=C2=A0=C2=A0 100=C2=A0=C2=A0 000 Old_age=C2=A0=C2=A0
> Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 16
> =C2=A0=C2=A0=C2=A0 198 Offline_Uncorrectable=C2=A0=C2=A0 0x0008=C2=A0=C2=
=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000 Old_age=C2=A0=C2=A0
> Offline=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 2
>=20
> And didn't pass tests:
>=20
> =C2=A0=C2=A0=C2=A0 Num=C2=A0 Test_Description=C2=A0=C2=A0=C2=A0 Status=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Remaining
> LifeTime(hours)=C2=A0 LBA_of_first_error
> =C2=A0=C2=A0=C2=A0 # 1=C2=A0 Extended offline=C2=A0=C2=A0=C2=A0 Complet=
ed: read failure 90%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 3575=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> =C2=A0=C2=A0=C2=A0 # 2=C2=A0 Short offline=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Completed without error 00%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 3574=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> =C2=A0=C2=A0=C2=A0 # 3=C2=A0 Extended offline=C2=A0=C2=A0=C2=A0 Complet=
ed: read failure 90%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 3574=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> =C2=A0=C2=A0=C2=A0 # 4=C2=A0 Extended offline=C2=A0=C2=A0=C2=A0 Complet=
ed: read failure 90%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 3560=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> =C2=A0=C2=A0=C2=A0 # 5=C2=A0 Extended offline=C2=A0=C2=A0=C2=A0 Complet=
ed: read failure 50%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 3559=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
>=20
> I decided to remove that drive from BTRFS system:
>=20
> =C2=A0=C2=A0=C2=A0 btrfs dev delete /dev/sda2 /
>=20
>=20
> At the beginning iostat showed that system is reading from /dev/sda
> 100Mb/sec, then writing to /dev/sdb + /dev/sdc 100Mb/sek. It looked
> correct, and during a few hours it moved aobut 1.5 TB of data out of th=
e
> failing disk. But then it stuck... Iostat no longer showed reading or
> writing, "btrfs dev usage" didn't change. Couldn't stop "btrfs dev
> delete" command -- nor Ctrl+C nor "kill -9". I have rebooted system,
> started "btrfs dev delete" again.
>=20
> But this is extremely slow. Disks can read/write 100-150Mb/sek. But
> "process btrfs dev delete" moved 53Gb during 6 hours, that is only abou=
t
> 2Mb/sek.
>=20
> Why this is so slow? Below are some logs. Some other people also have
> had this problem...

Are you using qgroups?

You can verify it by "btrfs qgroup show -pcre <mount>" to verify.
Qgroup can hugely impact performance for balance, if using kernel older
than v5.2.

You can either disable qgroup, losing the ability to trace how many
bytes are exclusively used by each subvolume, or upgrade to v5.2 kernel
to solve it.

Thanks,
Qu

>=20
> What is my problem? I am testing btrfs for many years, I have had some
> issues few years ago, recently I considered btrfs to be stable... but I=

> cannot put btrfs into production when I have such problems when disk
> fails... to move 3Tb with 2mb/sec speed it would take many, many days.
> Server does almost nothing... it just deletes one drive. Cpu is not
> intensive, iostat looks lazy...
>=20
>=20
>=20
>=20
> #################################################
>=20
> root@wawel:~# uname -a
> Linux wawel 4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11)=

> x86_64 GNU/Linux
>=20
> root@wawel:~# btrfs --version
> btrfs-progs v4.20.1
>=20
> root@wawel:~# dpkg -l | egrep btrfs
> ii=C2=A0 btrfs-progs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.20.1-2 amd64=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Checksumming
> Copy on Write Filesystem utilities
>=20
> #################################################
>=20
> root@wawel:~# btrfs sub list /=C2=A0 | wc -l
> 21
>=20
> #################################################
>=20
> root@wawel:~# btrfs dev usage /
> /dev/sda2, ID: 1
> =C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 5.45TiB
> =C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 5.45TiB
> =C2=A0=C2=A0 Data,single:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 1.08TiB
> =C2=A0=C2=A0 Metadata,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 11.00GiB
> =C2=A0=C2=A0 System,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 32.00MiB
> =C2=A0=C2=A0 Unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -1.09TiB
>=20
> /dev/sdb2, ID: 2
> =C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 5.45TiB
> =C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
> =C2=A0=C2=A0 Data,single:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 3.22TiB
> =C2=A0=C2=A0 Metadata,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 87.00GiB
> =C2=A0=C2=A0 Unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2.15TiB
>=20
> /dev/sdc2, ID: 3
> =C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 5.45TiB
> =C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
> =C2=A0=C2=A0 Data,single:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 3.21TiB
> =C2=A0=C2=A0 Metadata,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 96.00GiB
> =C2=A0=C2=A0 System,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 32.00MiB
> =C2=A0=C2=A0 Unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2.15TiB
>=20
> #################################################
>=20
> root@wawel:~# iostat -m -d 30
> Linux 4.19.0-6-amd64 (wawel)=C2=A0=C2=A0=C2=A0=C2=A0 25.12.2019=C2=A0=C2=
=A0=C2=A0=C2=A0 _x86_64_=C2=A0=C2=A0=C2=A0 (4 CPU)
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 29,52=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2,77=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,90=C2=A0=C2=A0=C2=A0=C2=A0 1=
58467 51287
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 532,93=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,77=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16,80=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 44046 =
962107
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 532,03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,59=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16,79=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 34017 =
961406
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0,70=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,00=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,01 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 624,20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,05=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14,17=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1 424
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 628,47=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,06=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14,79=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1 443
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 17,90=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,23=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,59 7=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 17
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 760,63=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,15=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15,39=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 4 461
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 761,13=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,09=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16,75=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 2 502
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 65,80=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1,00=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,26 30=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
085,93=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,18=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 26,14=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 5 784
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
081,03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,09=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 27,03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2 810
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 101,53=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1,57=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,10 47=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 3
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 609,63=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,34=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19,29=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 10 578
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 612,67=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,33=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19,73=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 9 591
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 114,30=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1,76=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,28 52=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 8
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 355,90=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,39=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19,60=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 11 587
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 368,50=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,35=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20,17=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 10 605
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 63,70=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,55=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,54 16=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 16
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 438,40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,13=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7,83=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 3 234
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 463,97=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,09=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8,93=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 2 267
>=20
> root@wawel:~# iostat -m -d 30
> Linux 4.19.0-6-amd64 (wawel) =C2=A0=C2=A0=C2=A0 25.12.2019 =C2=A0=C2=A0=
=C2=A0 _x86_64_=C2=A0=C2=A0=C2=A0 (4 CPU)
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 30,18=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2,51=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1,01=C2=A0=C2=A0=C2=A0=C2=A0 2=
26710 91462
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 531,30=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,69=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15,36=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 62022 =
1384919
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 535,25=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,59=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15,53=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 53092 =
1400122
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 2,80=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,01=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,49 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 154,77=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,53=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3,05 15=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 91
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 161,40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,64=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3,02 19=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 90
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 124,87=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,01=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3,02 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 90
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 799,33=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,13=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19,40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 3 581
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 930,63=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,23=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 22,21=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 6 666
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 5,97=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,00=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,69 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 730,10=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,05=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14,62=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1 438
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 739,23=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,13=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14,86=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 3 445
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 6,53=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,01=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1,39 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 41
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 800,63=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,13=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15,63=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 4 468
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 801,83=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,02=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16,12=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0 483
>=20
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tps=C2=A0=C2=A0=C2=A0 MB_read/s=C2=A0=C2=A0=C2=A0 MB_wrtn/s=C2=A0=C2=
=A0=C2=A0 MB_read MB_wrtn
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 4,83=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,00=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1,13 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 33
> sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 756,30=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,14=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15,08=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 4 452
> sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 759,03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,15=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15,33=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 4 459
>=20
>=20
>=20
> #################################################
>=20
> root@wawel:~# btrfs dev usage -b / | sed -r "s/^/$(date +'%F %T')\t/" >=
>
> btrfsdevusage
> root@wawel:~# btrfs dev usage -b / | sed -r "s/^/$(date +'%F %T')\t/" >=
>
> btrfsdevusage
> root@wawel:~# btrfs dev usage -b / | sed -r "s/^/$(date +'%F %T')\t/" >=
>
> btrfsdevusage
> root@wawel:~# btrfs dev usage -b / | sed -r "s/^/$(date +'%F %T')\t/" >=
>
> btrfsdevusage
>=20
> root@wawel:~# cat btrfsdevusage=C2=A0 | egrep sda -A5 | egrep single
> 2019-12-25 17:03:04=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data,single:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1188632199168
> 2019-12-25 18:31:27=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data,single:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1184337231872
> 2019-12-25 19:00:56=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data,single:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1177894780928
> 2019-12-25 20:25:46=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data,single:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1158567428096
> 2019-12-25 21:06:00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data,single:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1147830009856
> 2019-12-25 23:01:34=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data,single:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1132797624320
> 2019-12-25 23:16:27=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data,single:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1130650140672
>=20
> root@wawel:~# echo "speed is $(( ( 1188632199168=C2=A0 - 1130650140672 =
) /
> 1024 / 1024 / ((23 - 17) * 3600)=C2=A0 )) MB/sec"
> speed is 2 MB/sec
>=20
> #################################################
>=20
> root@wawel:~# iotop -d12
>=20
> Total DISK READ:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00 B=
/s | Total DISK WRITE:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.=
00 B/s
> Current DISK READ:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00 B/s | Curre=
nt DISK WRITE:=C2=A0=C2=A0=C2=A0=C2=A0 183.48 M/s
> =C2=A0 TID=C2=A0 PRIO=C2=A0 USER=C2=A0=C2=A0=C2=A0=C2=A0 DISK READ=C2=A0=
 DISK WRITE=C2=A0 SWAPIN=C2=A0=C2=A0=C2=A0=C2=A0 IO> COMMAND
> =C2=A08138 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00 B/s=
=C2=A0=C2=A0=C2=A0 0.00 B/s=C2=A0 0.00 % 99.99 % btrfs dev
> delete /dev/sda2 /
> =C2=A0=C2=A0=C2=A0 1 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0.00 B/s=C2=A0=C2=A0=C2=A0 0.00 B/s=C2=A0 0.00 %=C2=A0 0.00 % init
> =C2=A0=C2=A0=C2=A0 2 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0.00 B/s=C2=A0=C2=A0=C2=A0 0.00 B/s=C2=A0 0.00 %=C2=A0 0.00 % [kthreadd]=

> =C2=A0=C2=A0=C2=A0 3 be/0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0.00 B/s=C2=A0=C2=A0=C2=A0 0.00 B/s=C2=A0 0.00 %=C2=A0 0.00 % [rcu_gp]
> =C2=A0=C2=A0=C2=A0 4 be/0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0.00 B/s=C2=A0=C2=A0=C2=A0 0.00 B/s=C2=A0 0.00 %=C2=A0 0.00 % [rcu_par_g=
p]
> =C2=A0=C2=A0=C2=A0 6 be/0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0.00 B/s=C2=A0=C2=A0=C2=A0 0.00 B/s=C2=A0 0.00 %=C2=A0 0.00 %
> [kworker/0:0H-kblockd]
> =C2=A0=C2=A0=C2=A0 8 be/0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0.00 B/s=C2=A0=C2=A0=C2=A0 0.00 B/s=C2=A0 0.00 %=C2=A0 0.00 % [mm_percpu=
_wq]
>=20
> Total DISK READ:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11.23 M/s | =
Total DISK WRITE:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28.77 M/s
> Current DISK READ:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11.23 M/s | Current DI=
SK WRITE:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 56.51 M/s
> =C2=A0 TID=C2=A0 PRIO=C2=A0 USER=C2=A0=C2=A0=C2=A0=C2=A0 DISK READ=C2=A0=
 DISK WRITE=C2=A0 SWAPIN=C2=A0=C2=A0=C2=A0=C2=A0 IO> COMMAND
> 10349 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 29.26 K/s=C2=A0 168=
=2E89 K/s=C2=A0 0.00 % 75.29 %
> [kworker/u8:3-btrfs-endio-meta]
> =C2=A08138 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11.03 M/s=C2=A0=
=C2=A0 23.61 M/s=C2=A0 0.00 % 74.65 % btrfs dev
> delete /dev/sda2 /
> 10351 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 45.21 K/s 1365.76 K=
/s=C2=A0 0.00 % 11.50 %
> [kworker/u8:8-btrfs-endio-write]
> 10350 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 63.83 K/s 1542.63 K=
/s=C2=A0 0.00 % 10.22 %
> [kworker/u8:7-btrfs-freespace-write]
> =C2=A07879 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 42.56 K/s 1186=
=2E23 K/s=C2=A0 0.00 %=C2=A0 7.07 %
> [kworker/u8:1-btrfs-freespace-write]
> 23032 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25.27 K/s=C2=A0 972=
=2E12 K/s=C2=A0 0.00 %=C2=A0 5.04 %
> [kworker/u8:12-btrfs-extent-refs]
> =C2=A08035 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00 B/s=
=C2=A0=C2=A0 25.27 K/s=C2=A0 0.00 %=C2=A0 0.00 %
> [kworker/u8:4-btrfs-endio-meta]
> =C2=A08036 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00 B/s=
=C2=A0=C2=A0 11.97 K/s=C2=A0 0.00 %=C2=A0 0.00 %
> [kworker/u8:5-btrfs-extent-refs]
> 31253 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00 B/s=C2=A0=
=C2=A0=C2=A0 5.32 K/s=C2=A0 0.00 %=C2=A0 0.00 %
> [kworker/u8:9-btrfs-extent-refs]
>=20
> Total DISK READ:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 674.25 K/s | Total=
 DISK WRITE:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13.57 M/s
> Current DISK READ:=C2=A0=C2=A0=C2=A0=C2=A0 674.25 K/s | Current DISK WR=
ITE:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 39.97 M/s
> =C2=A0 TID=C2=A0 PRIO=C2=A0 USER=C2=A0=C2=A0=C2=A0=C2=A0 DISK READ=C2=A0=
 DISK WRITE=C2=A0 SWAPIN=C2=A0=C2=A0=C2=A0=C2=A0 IO> COMMAND
> =C2=A08138 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 147.62 K/s=C2=A0=C2=A0=
=C2=A0 7.72 M/s=C2=A0 0.00 % 79.89 % btrfs dev
> delete /dev/sda2 /
> 10274 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 484.08 K/s=C2=A0=C2=A0=C2=
=A0 4.91 M/s=C2=A0 0.00 % 56.93 %
> [kworker/u8:2+btrfs-extent-refs]
> 10351 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 27.93 K/s=C2=A0 492=
=2E06 K/s=C2=A0 0.00 %=C2=A0 3.03 %
> [kworker/u8:8-btrfs-endio-meta]
> 10350 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.99 K/s=C2=A0=
 115.70 K/s=C2=A0 0.00 %=C2=A0 0.59 %
> [kworker/u8:7-btrfs-endio-write]
> =C2=A08037 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.32 K/s=
=C2=A0=C2=A0 79.79 K/s=C2=A0 0.00 %=C2=A0 0.40 %
> [kworker/u8:6-btrfs-endio-write]
> 23032 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.99 K/s=C2=A0=
=C2=A0 79.79 K/s=C2=A0 0.00 %=C2=A0 0.20 %
> [kworker/u8:12-btrfs-endio-write]
> =C2=A07879 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0 1361.80 B/s=C2=A0 105.06 K=
/s=C2=A0 0.00 %=C2=A0 0.10 %
> [kworker/u8:1-btrfs-endio-write]
> =C2=A0 538 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00 B/s=
 1021.35 B/s=C2=A0 0.00 %=C2=A0 0.00 % rsyslogd -n
> -iNONE [rs:main Q:Reg]
> 10349 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00 B/s=C2=A0=
=C2=A0 86.44 K/s=C2=A0 0.00 %=C2=A0 0.00 %
> [kworker/u8:3-btrfs-endio-meta]
> =C2=A0=C2=A0=C2=A0 1 be/4 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0.00 B/s=C2=A0=C2=A0=C2=A0 0.00 B/s=C2=A0 0.00 %=C2=A0 0.00 % init
>=20
>=20
>=20
> #################################################
>=20
> root@wawel:~# top -d12
> top - 23:23:01 up 1 day, 56 min,=C2=A0 1 user,=C2=A0 load average: 3,05=
, 3,28, 3,47
> Tasks: 137 total,=C2=A0=C2=A0 1 running, 136 sleeping,=C2=A0=C2=A0 0 st=
opped,=C2=A0=C2=A0 0 zombie
> %Cpu(s):=C2=A0 0,0 us,=C2=A0 4,5 sy,=C2=A0 0,0 ni, 92,1 id,=C2=A0 3,3 w=
a,=C2=A0 0,0 hi, 0,1 si,=C2=A0
> 0,0 st
> MiB Mem :=C2=A0=C2=A0 7841,1 total,=C2=A0=C2=A0=C2=A0 797,0 free,=C2=A0=
=C2=A0=C2=A0 259,7 used,=C2=A0=C2=A0 6784,4 buff/cache
> MiB Swap:=C2=A0=C2=A0 8053,0 total,=C2=A0=C2=A0 7962,2 free,=C2=A0=C2=A0=
=C2=A0=C2=A0 90,8 used.=C2=A0=C2=A0 7265,2 avail Mem
> =C2=A0 PID USER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PR=C2=A0 NI=C2=A0=C2=A0=C2=
=A0 VIRT=C2=A0=C2=A0=C2=A0 RES=C2=A0=C2=A0=C2=A0 SHR S=C2=A0 %CPU=C2=A0 %=
MEM TIME+ COMMAND
> =C2=A08138 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0 8540=C2=A0=C2=A0=C2=A0 104=C2=A0=C2=A0=C2=A0 104 D=C2=A0 11,6=C2=
=A0=C2=A0 0,0 23:25.88 btrfs
> 23032 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0 I=C2=A0=C2=A0 4,8=C2=A0=C2=A0 0,0 0:51.20
> kworker/u8:12-btrfs-extent-refs
> 10350 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0 I=C2=A0=C2=A0 0,9=C2=A0=C2=A0 0,0 0:01.79
> kworker/u8:7-btrfs-endio-meta
> 10349 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0 I=C2=A0=C2=A0 0,8=C2=A0=C2=A0 0,0 0:02.12
> kworker/u8:3-btrfs-freespace-write
> =C2=A0 242 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 -20=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0 I=C2=A0=C2=A0 0,2=C2=A0=C2=A0 0,0 0:59.66
> kworker/2:1H-kblockd
>=20
>=20
> #################################################
>=20
> root@wawel:~# tail /var/log/kern.log -n50
> Dec 25 21:50:35 wawel kernel: [84258.634360] BTRFS info (device sda2):
> found 1752 extents
> Dec 25 21:50:41 wawel kernel: [84264.771079] BTRFS info (device sda2):
> relocating block group 3434964058112 flags data
> Dec 25 21:51:09 wawel kernel: [84291.864553] BTRFS info (device sda2):
> found 584 extents
> Dec 25 21:55:51 wawel kernel: [84574.383303] BTRFS info (device sda2):
> found 584 extents
> Dec 25 21:55:56 wawel kernel: [84579.359349] BTRFS info (device sda2):
> relocating block group 3431742832640 flags data
> Dec 25 21:56:17 wawel kernel: [84600.668237] BTRFS info (device sda2):
> found 635 extents
> Dec 25 22:00:36 wawel kernel: [84859.766366] BTRFS info (device sda2):
> found 635 extents
> Dec 25 22:00:47 wawel kernel: [84870.367399] BTRFS info (device sda2):
> relocating block group 3428521607168 flags data
> Dec 25 22:01:14 wawel kernel: [84897.313282] BTRFS info (device sda2):
> found 1170 extents
> Dec 25 22:05:38 wawel kernel: [85161.264397] BTRFS info (device sda2):
> found 1170 extents
> Dec 25 22:05:46 wawel kernel: [85169.216425] BTRFS info (device sda2):
> relocating block group 3425300381696 flags data
> Dec 25 22:06:20 wawel kernel: [85202.963222] BTRFS info (device sda2):
> found 1336 extents
> Dec 25 22:13:00 wawel kernel: [85603.648327] BTRFS info (device sda2):
> found 1336 extents
> Dec 25 22:13:02 wawel kernel: [85604.878785] BTRFS info (device sda2):
> relocating block group 3422079156224 flags data
> Dec 25 22:14:57 wawel kernel: [85720.394945] BTRFS info (device sda2):
> found 1771 extents
> Dec 25 22:23:03 wawel kernel: [86206.582245] BTRFS info (device sda2):
> found 1771 extents
> Dec 25 22:23:04 wawel kernel: [86207.671814] BTRFS info (device sda2):
> relocating block group 3418857930752 flags data
> Dec 25 22:23:19 wawel kernel: [86222.138761] BTRFS info (device sda2):
> found 199 extents
> Dec 25 22:26:26 wawel kernel: [86408.991487] BTRFS info (device sda2):
> found 199 extents
> Dec 25 22:26:29 wawel kernel: [86412.181922] BTRFS info (device sda2):
> relocating block group 3415636705280 flags data
> Dec 25 22:26:48 wawel kernel: [86431.726268] BTRFS info (device sda2):
> found 50 extents
> Dec 25 22:27:32 wawel kernel: [86475.800606] BTRFS info (device sda2):
> found 50 extents
> Dec 25 22:27:39 wawel kernel: [86482.222298] BTRFS info (device sda2):
> found 20 extents
> Dec 25 22:27:44 wawel kernel: [86487.168278] BTRFS info (device sda2):
> relocating block group 3412415479808 flags data
> Dec 25 22:28:27 wawel kernel: [86530.525657] BTRFS info (device sda2):
> found 6748 extents
> Dec 25 22:34:07 wawel kernel: [86870.618140] BTRFS info (device sda2):
> found 6748 extents
> Dec 25 22:34:35 wawel kernel: [86898.498949] BTRFS info (device sda2):
> relocating block group 3409194254336 flags data
> Dec 25 22:36:06 wawel kernel: [86989.589309] BTRFS info (device sda2):
> found 1175 extents
> Dec 25 22:40:12 wawel kernel: [87234.881523] perf: interrupt took too
> long (3943 > 3930), lowering kernel.perf_event_max_sample_rate to 50500=

> Dec 25 22:44:44 wawel kernel: [87507.870507] BTRFS info (device sda2):
> found 1175 extents
> Dec 25 22:44:52 wawel kernel: [87515.563744] BTRFS info (device sda2):
> relocating block group 3405973028864 flags data
> Dec 25 22:45:14 wawel kernel: [87537.128352] BTRFS info (device sda2):
> found 372 extents
> Dec 25 22:46:11 wawel kernel: [87594.569709] BTRFS info (device sda2):
> found 372 extents
> Dec 25 22:46:17 wawel kernel: [87600.772681] BTRFS info (device sda2):
> relocating block group 3402751803392 flags data
> Dec 25 22:47:27 wawel kernel: [87670.663043] BTRFS info (device sda2):
> found 3483 extents
> Dec 25 23:04:57 wawel kernel: [88720.068885] BTRFS info (device sda2):
> found 3479 extents
> Dec 25 23:05:03 wawel kernel: [88726.864461] BTRFS info (device sda2):
> relocating block group 3399530577920 flags data
> Dec 25 23:06:36 wawel kernel: [88819.464525] BTRFS info (device sda2):
> found 1871 extents
> Dec 25 23:16:11 wawel kernel: [89393.997406] BTRFS info (device sda2):
> found 1868 extents
> Dec 25 23:16:13 wawel kernel: [89396.825305] BTRFS info (device sda2):
> relocating block group 3396309352448 flags data
> Dec 25 23:16:41 wawel kernel: [89424.310916] BTRFS info (device sda2):
> found 1946 extents
> Dec 25 23:22:12 wawel kernel: [89755.068457] BTRFS info (device sda2):
> found 1946 extents
> Dec 25 23:22:15 wawel kernel: [89758.601122] BTRFS info (device sda2):
> relocating block group 3393088126976 flags data
> Dec 25 23:22:35 wawel kernel: [89778.172631] BTRFS info (device sda2):
> found 647 extents
> Dec 25 23:23:06 wawel kernel: [89809.153016] BTRFS info (device sda2):
> found 647 extents
> Dec 25 23:23:07 wawel kernel: [89810.017006] BTRFS info (device sda2):
> relocating block group 3389866901504 flags data
> Dec 25 23:23:24 wawel kernel: [89827.351203] BTRFS info (device sda2):
> found 745 extents
> Dec 25 23:24:38 wawel kernel: [89901.176493] BTRFS info (device sda2):
> found 745 extents
> Dec 25 23:24:51 wawel kernel: [89914.840850] BTRFS info (device sda2):
> relocating block group 3386645676032 flags data
> Dec 25 23:25:40 wawel kernel: [89963.641062] BTRFS info (device sda2):
> found 3114 extents
>=20
>=20
>=20
>=20
> ################################################
>=20
> More on this topic:
>=20
> https://strugglers.net/~andy/blog/2018/06/15/another-disappointing-btrf=
s-experience/
>=20
>=20
> https://www.spinics.net/lists/linux-btrfs/msg50771.html
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1294531
>=20
>=20
>=20
>=20
>=20


--EhlZ5ePqYMLDq1HJ10PdZek03IOlAmQHl--

--G2zPmOnAD09tJy4d3qvznSngrjAg2eNhj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4EQDsXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjrYgf8CshQZbfnQFTadhx3l8pX22lr
bYBgr7023ku+JIE4Ejvjk/U2nfuXgQnvsw9CUon+MefSLKB+MjZfIwWSySP976WC
WuszFKLrbJ/fj8u6QQwwxdPUZd3Fc5myUltxOH9qxSy2zRRPhYO6Jw/rdWV9cCPa
rJ0LMAWl6IeDJDgV1D6UgAL41ch90h+l6W6oh3xKb3+TQBnx3eewQ3fzkPg3CE5e
Lq6QANPABm1IrMYu7zq61CfXJHZxyoU40jzzqDjee7RdTVMn7082j4pvvc8Sww90
XsWGArCWY8I+ZGxGiU8V3lNcFOGxMZg1yNWLYxH6pznIHmRuZkerYEueGequ9Q==
=aY9u
-----END PGP SIGNATURE-----

--G2zPmOnAD09tJy4d3qvznSngrjAg2eNhj--
