Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6207C1288EF
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 13:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfLUMAN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 07:00:13 -0500
Received: from mout.gmx.net ([212.227.17.21]:58457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfLUMAM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 07:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576929610;
        bh=mIb2hsHsHMVisoRTuuoW7heExGTPX0Xr9bSK6Qqc+UU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Qbnss1wzEGpaRGFpfuVSTjN1tjmWxpQtd/zoFps7vh52a451yrjtpNyVUCNOgDKpp
         NXXLCnV9CqI9cTeB8i1gMJcR49zH6ko4b4GNJp62lsl7tOhc4839ih2HFDpFFweWcp
         c6CKEovZ1j7LQ+hZo0IdpWnQtg40RVPrx7MmCnc4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZktj-1iCaUg1XfD-00Wq8c; Sat, 21
 Dec 2019 13:00:10 +0100
Subject: Re: Kernel 5.4 - BTRFS FS shows full with about 600 GB Free ?
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
References: <8bd55f28-2176-89f7-bd53-4992ccd53f42@petaramesh.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <81dec38b-ec8e-382e-7dfe-cb331f418ffa@gmx.com>
Date:   Sat, 21 Dec 2019 20:00:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <8bd55f28-2176-89f7-bd53-4992ccd53f42@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jWsMfWKT/d9Lzosg7TWw1ndtpXqDrj0QArYCnGrnkDNkYjc5LqG
 +Nr7dYmlw4ZEhakynJ47jgiZ0IgNzurmEz5V3GddG6YEb74oecFGX034b9+sJfyBpJd5iST
 NdQpZNSJtMNkECuPkahHuzo3tqygtLVEBGCW2G5GUtH3SbFzYj4fUz5i7/PKV9DwwAGpJjB
 6vtETXKtAv7UtyzSwqT1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yQDBXi3nE0A=:UwhpqLrIaV5Q/gNLVoY0gB
 9hZhPsIwU/IDzc/rv0QUwxnPf64UASGypcai/84EfQsRfUV9wwX+j1zz0GKzHtABnCBZUWxhl
 tcZs1nTozy3cyjRJiiGRoF9WbVBmr0TvhyPTiXrLOsagZ+qecqlUa/OgwiEvG8FaV7Qcgq9FY
 AQLIC+ua81QdGYIRaMs9jIsrdKl/EcCV6zSJyiUe7UnuTglmIzF9nu/NkKN4DPBefs755B6Q1
 aBpOigI8Gld/MPiSdKxHlHAdyKD0epvTJotH2aRCyWVVHHvBxfYIjD2zKe3MQad7QRX0DXgh6
 KyXCmqypFp1669cC6TfXDhzBnSbQIDm3CpELkupkS6LaKmbGyaHCNCYuPWcJPr67Q5bNexEeH
 AACBAqaA4cE810aJQXiXSOPFkI0TS/Qo72NcdNEPdkR+OSylt1aQUCcW4H8I9o/o0VqH6avjI
 uEuhGqtvFHPwTO1Mrn94cCdU/d+mUa7Slt7naSz16a0aS1jjJAvhnmj/56/CefRX5SGx3eA1G
 V8ZWyVIgSjc03uFMpzNM1nRZK/Bm5SJnJc5v6p9ro8whCkIwyFLtN93p1RxT1n+IYSrlYy+BO
 0iI2jN1OeJ+NNH6kFzcNPfMCUUGJqm1cZWuYceHum4+LeGMiG7UxCB0WIKHgMdwBFvwDKp8tB
 ms2nx+qsQssMuKZ3Mj9bdyP77CyzPIzgPHECWagMHId8KjnJYUu543/rRy/ubXQMnuCUnEf2Y
 XnEZvBStDSsN8rqJdKqyGtp0cUTSCkXnM6eQ3t7l8XqL1DFpVZnAlm1XMIedDk5f/uq/uRxPq
 alHkR6FJAjHVKkDmDG08e9jK15G0pzaHzopErD7HHkJbYYa0QDXb/3UKzzQ6NS2iALA3oDDBB
 Dm4d8WuqvHbN95fu5+llxmoYmPbYkmMzbYbwiqMVhG8xFeBlX2FlSti/arciWVErg05eXvvA7
 vWGCsbfwPnsuQb5idsbWMpfo2wCpX32lpp/6sHUrLjgwBcFgeQhHk2Ii8VSQQS3V64k1jVHr8
 dlLgV8P7eTqBE1/4ecCdhd/EX6j3PZqNlDeXdcHBFd0URb7ppzKGQLBHB63OvCzE2/87UKvYW
 BCkTcMnhg8LyaV0cgoka6f1kM6HT3gDVIPTDqhEHJu0b+Ne/pI0IOXZ+r2Z1TxQ97YHRq7Yqs
 VvPlSoj8u5COYq8Ju7enog8KA/eeuOwDhnWjNam516ukXBKygx2aVfpowMzV6n3pvxST2NUrU
 4zn1DFfkI95WUKz267uZNbqC++O32Jz3dQm3FpRUa/1x6L7jxORUKMpPt1To=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/21 =E4=B8=8B=E5=8D=886:59, Sw=C3=A2mi Petaramesh wrote:
> Hi list,
>
> After writing files and snapshots WITHOUT errors on an external BTRFS FS
> with 500+ GB of free space, using kernel 5.4.5-arch1-1, I dismount the
> FS then remount it normally, and then it says the FS has 0 space free
> left !
>
> Checking the disk on another machine with
>
> [moksha ~]# uname -r
> 5.4.2-1-MANJARO
>
> And... How can this be ?
>
> root@moksha:~# df -h /run/media/myself/MyVolume
> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S=
ize=C2=A0 Used Avail Use% Mounted on
> /dev/mapper/luks-xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww=C2=A0=C2=A0 1,9T 1,2T=
=C2=A0=C2=A0=C2=A0=C2=A0 0 100%
> /run/media/myself/MyVolume

A known regression introduced in v5.4.

The new metadata over-commit behavior conflicts with an existing check
in btrfs_statfs().
It is completely a runtime false behavior, and had *no* other bad effect.

If you feel like to address it with off-tree patch, there is a quick
patch to address it:
https://patchwork.kernel.org/patch/11293419/

>
> root@moksha:~# btrfs fi sh
> Label: 'MyVolume'=C2=A0 uuid: xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used=
 1.19TiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 siz=
e 1.82TiB used 1.20TiB path
> /dev/mapper/luks-xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww
>
> root@moksha:~# btrfs fi df /run/media/myself/MyVolume
> Data, single: total=3D1.18TiB, used=3D1.18TiB
> System, DUP: total=3D8.00MiB, used=3D160.00KiB
> Metadata, DUP: total=3D7.00GiB, used=3D6.88GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> root@moksha:~# umount /run/media/myself/MyVolume
>
> root@moksha:~# btrfs check
> /dev/mapper/luks-xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks-xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww
> UUID: xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
>
> (Still running since a while, no errors...)

Running a fsck is always a good behavior, although in this case, it
shouldn't cause any corruption.

Thanks,
Qu
>
> TIA for any help.
>
> Kind regards.
>
