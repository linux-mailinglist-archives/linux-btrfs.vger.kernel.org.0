Return-Path: <linux-btrfs+bounces-7294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BA09553B7
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 01:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6593E1F22C70
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 23:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D81145FE8;
	Fri, 16 Aug 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VZSGOCA8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EBE76F17
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723850142; cv=none; b=V90mYBpb60i6cgL3iIc1EhGRqkUtssBTcJTOahnc1h2GrOMbqs3SKJsCTFokwLk+CaCWQhTL7oaxzvpuOu+WUcbKsIZLNiaGGBY7UuBkI7hHd82UCFDenGImRyD85uxn6MLoOFRGhqrpjg9ibP/EJEiq7pJ/xVtFmbntHjLkAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723850142; c=relaxed/simple;
	bh=XirWQ2zMi8GU/hJF8ntM3xFheFqQzYY++NvAGm8g3E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cv3t8j08ZlSzj7QiVFJ2JaMafn4ViP5lacEMBTiAwP6u+z76VzJDnrF1uG9JDQxkm1+J5WYHcH3QxHBYJv6uJL2dDHDBeTsJ692iZgRSDnET5rTibqc3XoYk7n7DGpck9fkhOVFyiPoSxjodN5Z+EPgAkTxyUKLD5re+kUG+TjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VZSGOCA8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723850137; x=1724454937; i=quwenruo.btrfs@gmx.com;
	bh=FwUjY+nexyFDbyhD3QTMATFCxBkbD+TgybyGQRJHfSg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VZSGOCA8tJjyoSip5wagJfggfDkKIhGIswJsA65P0RjC2tzvXSDUa/n7tvhVpxah
	 c9t+Uc94g5lNtIAcOtKkkDqFy9Cl4PkwY2xWgaYo7qJuwFK3wEtOFEL4Fr7XvgvN0
	 NZvxVGBzACBlMgxUGbw4NBAC0HFMl+MPdfiZWRgZX8B+BtNqFNzonJBF0/ouCkKUC
	 MLQkRUyH3c1ISuh3uHZjzBulKgpRdJqGGmE3wc7rmN9dUSI63Z987bYhl45udrpm5
	 n+OTxT3AZyXiYCyR+Xvak+3dBVIPuehr4TvsoFMWtv8kKhof4pK4Zej/wFnP7MMNj
	 hy/fNjxpedv69afj3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiaYJ-1rzPxP3a4d-00c78c; Sat, 17
 Aug 2024 01:15:37 +0200
Message-ID: <b2fa9121-5af3-45d8-a31a-787acef0979a@gmx.com>
Date: Sat, 17 Aug 2024 08:45:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-transaction generates high disk write
To: Cody <codeology.lab@gmail.com>, linux-btrfs@vger.kernel.org
References: <CA+Zc76WnsF2jZn35tAhtdqapem5W3bJeHd17SZ4dsRHCf1bxHw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CA+Zc76WnsF2jZn35tAhtdqapem5W3bJeHd17SZ4dsRHCf1bxHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e+IWFmnW3LWlEECXGIwQXf+xO4OE9aNdYGFdazyxS4NjkYYROc5
 PCTS5Oa8VcCsjXkFOYN60UwQTnuWhuOuKq4EToQybt4L7kmjF1hkdSxiKEoTzZtieGlj7CT
 xkHSdqqETodm5QXvmtX8JEJTMIK0Och85+iCAH79XHsRBh0GMIYncAR+NXuxGuaHv8gsbDa
 WNz7JLSrCRNLnXSJH4ATQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ujm6NmVLoU4=;AfoCpsIbpVwkNr6jo0NPe0UUOmW
 6HOyRxdfwB83ec9zzJUzdBoMtgrPbiyRbfBIYx+kcoQeJahSSA37oWeJzWoleWiz0exTzgLFm
 /d+/Ef86/tFyvu1C9mgauIBf/+7MfFK4Pu1wL5H+y6DhhgwMyA2GwlhHP3vaQ2gEe+fpRfjF9
 sSlv5FrZsswGh5PB6FsSYsRBf1I90bKQZ4LmH/OWQ4I7uJF9ookeUZMeLQ3wlitcm8I4OcBrr
 iwEeo5rneZML10WpGorQ9HoB/bPfjOaUCuPfKDGxfV7t/Fys5Gi+551grkUm3HCNmhA5TVK2h
 XpS2L69D2wrOlXn92oa7DoUkwsHvZDXg8ZWz/U2LLA1yrFAKGL8outpMgnh60rOMfApuXUJHc
 mWqTg8nMBh2xXyy5+7UwTj4PyRE37pjb5k+tkr+ii9xaTXtnPPilw63ywdjws2fsOGwrLB6Kk
 T+BcAEWxQ0QmLEYbCdTePEtC5qNSPYOdmZ/Uee3lOepwwPNIuENNBKY60MhPMuo9rWoDM4XQX
 6Aeb8bFWVzGuE/OvT4vb9MFJg41nnmtMrhw/KTTr6CTrFYTHadorFnuTpOgU2YVixwn3p04to
 SJaFcrj16IMczOD26Qos1/eN2qAGAE7ThOg2jKsi140PvjItZGxCst4Gv/I8uPZxrxIv4K/fm
 tLpnzZT2qieY/tnuq2zQAwuLAExAViO/YdNLJIjZuWgJ+PyIe88ERRCtz0tc/0H58uymlG8Wb
 NtGovDkov6HHes+HcaCNy/OxrvvPGSCkkB1w2U2Zf3do2AN+EvoFrcqr2pCGntuJ+StiXQbty
 4pn+1rOgFr//lZlcQNnAwRqAvRikFWs5miitvtzsgz8i8=



=E5=9C=A8 2024/8/17 08:19, Cody =E5=86=99=E9=81=93:
> Hi folks,
>
> The process btrfs-transaction generated 440MB writes within 3 hours on
> an idle machine running only the "iotop -a" command in a Bash shell.
> On another occasion, it generated 4.86GB (gigabytes) a day. Is this
> level of writing beyond normal? Does that hurt NVMe lifespan?

Btrfs-transaction is doing periodical metadata writebacks, thus it may
be the usual btrfs write amiplication.
(A small amount of data writes can lead to large amount of data writes)

Another thing is, btrfs' metadata is by default DUP, causing double the
amount of writes.

But the situation here is too complex (since you're running firefox,
it's really depending on all the websites you're accessing) to properly
reproduce.

If this behavior bothers you, I would recommend to make the firefox user
directory $HOME/.mozilla and the systemd-journal directory to have NOCOW
flag set, or even set systemd-journald to run in volatile mode.

With NOCOW flag set, data writes will only generate the minimal amount
of metadata change, unlike the COW which can easily cause very bad write
amplication.


For the wearing part, not familiar with the wear leveling of the
firmware, but since you have discard and ssd mode enabled, btrfs almost
does no metadata overwrite, it may be a better write pattern to nand
based devices.

Thanks,
Qu

>
> * Specifications
> OS: Fedora 40
> Kernel: 6.10.4-200.fc40.x86_64
> Storage Device: WD BLACK SN750 NVMe SSD, 1TB
>
> * Disk layouts and mounting options
> iotop screenshot: https://postimg.cc/nCyQdY97
> lsbk screenshot: https://postimg.cc/FfmkvrZH
> findmnt screenshot: https://postimg.cc/2qwb8scF
>
> Text-based output below:
>
> [root@fedora ~]# lsblk /dev/nvme0n1
> NAME              MAJ:MIN   RM    SIZE      RO   TYPE     MOUNTPOINTS
> nvme0n1          259:0            0    931.5G     0      disk
> =E2=94=9C=E2=94=80nvme0n1p1 259:1            0      600M      0      par=
t     /boot/efi
> =E2=94=9C=E2=94=80nvme0n1p2 259:2            0          1G      0      p=
art     /boot
> =E2=94=94=E2=94=80nvme0n1p3 259:3            0   929.9G      0      part=
     /home
>
>                   /
> [root@fedora ~]# findmnt
> TARGET                                        SOURCE
>              FSTYPE                      OPTIONS
> /
> /dev/nvme0n1p3[/root]           btrfs
> rw,relatime,seclabel,ssd,discard=3Dasync,space_cache,subvolid=3D257,subv=
ol=3D/root
> =E2=94=9C=E2=94=80/dev                                          devtmpfs
>                   devtmpfs
> rw,nosuid,seclabel,size=3D4096k,nr_inodes=3D4079012,mode=3D755,inode64
> =E2=94=82 =E2=94=9C=E2=94=80/dev/hugepages                    hugetlbfs
>          hugetlbfs
> rw,nosuid,nodev,relatime,seclabel,pagesize=3D2M
> =E2=94=82 =E2=94=9C=E2=94=80/dev/mqueue                         mqueue
>          mqueue
> rw,nosuid,nodev,noexec,relatime,seclabel
> =E2=94=82 =E2=94=9C=E2=94=80/dev/shm                               tmpfs
>                tmpfs
> rw,nosuid,nodev,seclabel,inode64
> =E2=94=82 =E2=94=94=E2=94=80/dev/pts                                 dev=
pts
>                 devpts
> rw,nosuid,noexec,relatime,seclabel,gid=3D5,mode=3D620,ptmxmode=3D000
> =E2=94=9C=E2=94=80/sys                                          sysfs
>                      sysfs
> rw,nosuid,nodev,noexec,relatime,seclabel
> =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/selinux                       selinu=
xfs
>              selinuxfs                      rw,nosuid,noexec,relatime
> =E2=94=82 =E2=94=9C=E2=94=80/sys/kernel/debug                 none
>           debugfs
> rw,nosuid,nodev,noexec,relatime,seclabel
> =E2=94=82 =E2=94=9C=E2=94=80/sys/kernel/tracing                tracefs
>             tracefs
> rw,nosuid,nodev,noexec,relatime,seclabel
> =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/fuse/connections       fusectl
>         fusectl                         rw,nosuid,nodev,noexec,relatime
> =E2=94=82 =E2=94=9C=E2=94=80/sys/kernel/security               securityf=
s
>           securityfs                    rw,nosuid,nodev,noexec,relatime
> =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup                       cgroup2
>            cgroup2
> rw,nosuid,nodev,noexec,relatime,seclabel,nsdelegate,memory_recursiveprot
> =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/pstore                        pstore
>               pstore
> rw,nosuid,nodev,noexec,relatime,seclabel
> =E2=94=82 =E2=94=9C=E2=94=80/sys/firmware/efi/efivars       efivarfs
>          efivarfs                       rw,nosuid,nodev,noexec,relatime
> =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/bpf                            bpf
>                   bpf
> rw,nosuid,nodev,noexec,relatime,mode=3D700
> =E2=94=82 =E2=94=94=E2=94=80/sys/kernel/config                configfs
>            configfs
> rw,nosuid,nodev,noexec,relatime
> =E2=94=9C=E2=94=80/proc                                       proc
>                      proc
> rw,nosuid,nodev,noexec,relatime
> =E2=94=82 =E2=94=94=E2=94=80/proc/sys/fs/binfmt_misc     systemd-1
>     autofs
> rw,relatime,fd=3D37,pgrp=3D1,timeout=3D0,minproto=3D5,maxproto=3D5,direc=
t,pipe_ino=3D18546
> =E2=94=82   =E2=94=94=E2=94=80/proc/sys/fs/binfmt_misc   binfmt_misc
>    binfmt_misc               rw,nosuid,nodev,noexec,relatime
> =E2=94=9C=E2=94=80/run                                        tmpfs
>                      tmpfs
> rw,nosuid,nodev,seclabel,size=3D6535660k,nr_inodes=3D819200,mode=3D755,i=
node64
> =E2=94=82 =E2=94=94=E2=94=80/run/user/1000                    tmpfs
>              tmpfs
> rw,nosuid,nodev,relatime,seclabel,size=3D3267828k,nr_inodes=3D816957,mod=
e=3D700,uid=3D1000,gid=3D1000,inode64
> =E2=94=82   =E2=94=9C=E2=94=80/run/user/1000/gvfs          gvfsd-fuse
>        fuse.gvfsd-fuse
> rw,nosuid,nodev,relatime,user_id=3D1000,group_id=3D1000
> =E2=94=82   =E2=94=94=E2=94=80/run/user/1000/doc           portal
>           fuse.portal
> rw,nosuid,nodev,relatime,user_id=3D1000,group_id=3D1000
> =E2=94=9C=E2=94=80/home                                    /dev/nvme0n1p=
3[/home]
>     btrfs
> rw,relatime,seclabel,ssd,discard=3Dasync,space_cache,subvolid=3D256,subv=
ol=3D/home
> =E2=94=9C=E2=94=80/boot                                      /dev/nvme0n=
1p2
>            ext4                           rw,relatime,seclabel
> =E2=94=82 =E2=94=94=E2=94=80/boot/efi                              /dev/=
nvme0n1p1
>          vfat
> rw,relatime,fmask=3D0077,dmask=3D0077,codepage=3D437,iocharset=3Dascii,s=
hortname=3Dwinnt,errors=3Dremount-ro
> =E2=94=9C=E2=94=80/tmp                                       tmpfs
>                     tmpfs
> rw,nosuid,nodev,seclabel,size=3D16339152k,nr_inodes=3D1048576,inode64
> =E2=94=9C=E2=94=80/var/lib/nfs/rpc_pipefs            sunrpc
>           rpc_pipefs                  rw,relatime
>

