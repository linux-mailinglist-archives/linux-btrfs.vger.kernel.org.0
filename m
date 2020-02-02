Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3B014FD5B
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 14:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgBBNgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 08:36:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:35401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgBBNgy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 Feb 2020 08:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580650612;
        bh=O3yYGivRyGbgjQxxeaAKUIj0MVYKl5dMQO5vwUlyQRQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZhBtOrTxjGsIBjll5CH/t2OhKrrfCQKsPC6yY2bl5jXH5Q6l1X559FbW0bvk7wy/Q
         ORgSrcVDz3mvN+EMdXUYa4V+A5FXk45DFKhyCpgjnm3A0l9hjhrchcN+7MYPIyb2gT
         Lq1U/K5tdA/f5mIwx/sQcspZjmUhjqZHwjSIvzqM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MplXz-1jLW190Ocf-00q8a6; Sun, 02
 Feb 2020 14:36:52 +0100
Subject: Re: My first attempt to use btrfs failed miserably
To:     Martin Raiber <martin@urbackup.org>, Skibbi <skibbi@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <cd628b1f-25b7-0f3b-0b31-2122acdfcd36@gmx.com>
 <010201700617f6d3-a19297d3-8722-4745-acde-7a740c5ee33f-000000@eu-west-1.amazonses.com>
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
Message-ID: <a05e919d-ef3d-57ce-4d28-e4c543e60e40@gmx.com>
Date:   Sun, 2 Feb 2020 21:36:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <010201700617f6d3-a19297d3-8722-4745-acde-7a740c5ee33f-000000@eu-west-1.amazonses.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RqSxsdhrDnVmMz8Pqvnyqd0OLtGYbRWvu"
X-Provags-ID: V03:K1:FjirrU6dg2qa3D3tJfBwRLNji3wU47yDdwj7wG0AVCGulg/08RH
 wvuhI5QO9sWp8mQEviz60IiVfuyrG00Vh2LLDT0KfAsg0KMAvpTUu2ZcPituux6K8ti6DDC
 TMWp7xZgIdy65wp26036D14LMT3UbUyir3GXPEEWXVXiHR9bMGbzPqGet+aHvWGUZNTijDE
 9B05CqHDx6E70ArRwdobw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6zdfESNq3Zo=:bkpebmejliP/GTvS8XhreY
 QnZ2Ln3cC/uGtM77Aup15TYeNJ+0NxUT5Zju+xrKCrO0c2eTq35tonViMT0iFrfmilHtHetwt
 RDpkBq3eEByJ7NWvJ8dyvpGVp3o5UA8HSnkG5SkompZMW7DO3GnRFhfA5onEynZJnKZvnKip7
 hgZK0zSbNhHtvajyu0pDbUzVGo8DncYWg4s/ZE0P4faEGA1BM4wReazBS156a3CJO6W2KCoC/
 t89mwayPT9XSaE/sJwgbJKs7EAP2XHVjbmRs1sQ5gMyuTXXlRnGJJZIkzSqGzrm9ZebwZ+H2j
 tJiP8RRsqzExb6nk5u8SdnzpNbfwlhjj+2uixdVpt4+pfmFqDFO1N4rynO/Bqbs2GbPe/X1vf
 +yRwQGi8kVIfe67ZrTQd6G30SHd3fgA5Maz2IFRH5pac/esZf4dqMWj1BbOaoVrXOgP8SyrfJ
 rFAgnbF1dZHfCl7VMpSL4QeXiACAsMlhlAjjBW7S8INDozGZ7Pdpnu1ys6t7v3qBsmetg+m2G
 rWBumDFVSBShlXWDNJGEvnricGlWVFG45X+ceA5M1qsiOpbZg6CM4L20XAASr7b8vsTt4kaeb
 5AXZiPDts2L8TC5ffUX6eyLqv0ihRZyNir5ltZpnC9tE1oMVyyOmDXoOTpgABnks2IsI1SQ/q
 l3U99aetE0ucHFVgAb/VU/pmS0yJqGBeXwzCR4t57ntsW4G53fBoWdJxtT/wjNgHIZm6f10DR
 UVuPdiJ2EHxqnuk0Pj2NxyM008VYACctV6Cm9h9M5Cn83Mk0LEHGSa1n2odDFp6/78b84bLRC
 zxXV/d+MdFm+VQDS1HHj7xXrt79kak6Mb6GdXFN+JsFABnQsSP1QgkER2EYMJe2TeEeWHsFVp
 M7bj/C1EUZmx0WWojbfsAfN0I/1U1n5kpHBT7TdBztlxDPic73xc6jlRhAadzj1V+KBAbeY27
 kp5QsqLk3nZzTeLxLSEcndKZKwS03s61lYBYHwVkIa6vJr2+UDbt19rwXNMqPEq591hV5n1f4
 JBOa5XEcbh26hMorFjb7UnhnlpCCNHFejd3LCxS8gVqMofimX6gGuA8CVDUz3HMKtKjvhICTX
 U5bJ3Pw8aInPdR63CkFNc5soykcRIFu3AhC7e1Tb74TjUuloD9kYzEYbdD6JfpPs9ZhckXpbj
 S/z2NoOG8MAw3xS8rWSUAdjcX7+qQFx/AmceOqd9CEhDxvMONrjol98XzA1C2MXCHEJKF9/aJ
 iOKr6vXYmjpNE90hv
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RqSxsdhrDnVmMz8Pqvnyqd0OLtGYbRWvu
Content-Type: multipart/mixed; boundary="p55U0CUKgQYTrt2tYdZoU292YAaQSFCwq"

--p55U0CUKgQYTrt2tYdZoU292YAaQSFCwq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/2 =E4=B8=8B=E5=8D=889:29, Martin Raiber wrote:
> On 02.02.2020 13:56 Qu Wenruo wrote:
>>
>> On 2020/2/2 =E4=B8=8B=E5=8D=888:45, Skibbi wrote:
>>> Hello,
>>> So I decided to try btrfs on my new portable WD Password Drive
>>> attached to Raspberry Pi 4. I created GPT partition, created luks2
>>> volume and formatted it with btrfs. Then I created 3 subvolumes and
>>> started copying data from other disks to one of the subvolumes. After=

>>> writing around 40GB of data my filesystem crashed. That was super fas=
t
>>> and totally discouraged me from next attempts to use btrfs :(
>>> But I would like to help with development so before I reformat my
>>> drive I can help you identifying potential issues with this filesyste=
m
>>> by providing some debugging info.
>>>
>>> Here are some details:
>>>
>>> root@rpi4b:~# uname -a
>>> Linux rpi4b 4.19.93-v7l+ #1290 SMP Fri Jan 10 16:45:11 GMT 2020 armv7=
l GNU/Linux
>> Pretty old kernel, nor recently enough backports.
>>
>> And since you're already using rpi4, no reason to use armv7 kernel.
>> You can go aarch64, Archlinux ARM has latest kernel for it.
>>
>>> root@rpi4b:~# btrfs --version
>>> btrfs-progs v4.20.1
>> Old progs too.
>>
>>> root@rpi4b:~# btrfs fi show
>>> Label: 'NAS'  uuid: b16b5b3f-ce5e-42e6-bccd-b48cc641bf96
>>>         Total devices 1 FS bytes used 42.48GiB
>>>         devid    1 size 4.55TiB used 45.02GiB path /dev/mapper/NAS
>>>
>>> root@rpi4b:~# dmesg |grep btrfs
>>> [223167.290255] BTRFS: error (device dm-0) in
>>> btrfs_run_delayed_refs:2935: errno=3D-5 IO failure
>>> [223167.389690] BTRFS: error (device dm-0) in
>>> btrfs_run_delayed_refs:2935: errno=3D-5 IO failure
>>> root@rpi4b:~# dmesg |grep BTRFS
>>> [201688.941552] BTRFS: device label NAS devid 1 transid 5 /dev/sda1
>>> [201729.894774] BTRFS info (device sda1): disk space caching is enabl=
ed
>>> [201729.894789] BTRFS info (device sda1): has skinny extents
>>> [201729.894801] BTRFS info (device sda1): flagging fs with big metada=
ta feature
>>> [201729.902120] BTRFS info (device sda1): checking UUID tree
>>> [202297.695253] BTRFS info (device sda1): disk space caching is enabl=
ed
>>> [202297.695271] BTRFS info (device sda1): has skinny extents
>>> [202439.515956] BTRFS info (device sda1): disk space caching is enabl=
ed
>>> [202439.515976] BTRFS info (device sda1): has skinny extents
>>> [202928.275644] BTRFS error (device sda1): open_ctree failed
>>> [202934.389346] BTRFS info (device sda1): disk space caching is enabl=
ed
>>> [202934.389361] BTRFS info (device sda1): has skinny extents
>>> [203040.718845] BTRFS info (device sda1): disk space caching is enabl=
ed
>>> [203040.718863] BTRFS info (device sda1): has skinny extents
>>> [203285.351377] BTRFS error (device sda1): bad tree block start, want=

>>> 31457280 have 0
>> This means some tree read failed miserably.
>> It looks like btrfs is trying to read something from trimmed range.
>>
>>> [203285.383180] BTRFS error (device sda1): bad tree block start, want=

>>> 31506432 have 0
>>> [203285.466743] BTRFS info (device sda1): read error corrected: ino 0=

>>> off 32735232 (dev /dev/sda1 sector 80320)
>> This means btrfs still can get one good copy.
>>
>> Something is not working properly, either from btrfs or the lower stac=
k.
>>
>> Have you tried to do the same thing without LUKS? Just btrfs over raw
>> partition.
>>
>> And it's recommended to use newer kernel anyway.
>=20
> I disagree. 4.19.y is an okay kernel to use w.r.t. btrfs, especially
> since all the newer stable versions currently have the statfs() is zero=

> bug. The btrfs-tools version doesn't matter much, unless one has to use=

> "btrfs check", which is (hopefully) not usually necessary. As you can
> see the kernel is also ~20 days old and 4.19.y is a LTS kernel, so it
> still gets (btrfs) updates/bugfixes.
>=20
> I would suspect a hardware issue with the WD disk (run badblocks for a
> while to check). The USB can also cause problems (the USB 3.0 DMA was a=

> hack in RPI4 that wasn't merged upstream last I looked), but you didn't=

> list the whole dmesg...

You see, the support for RPI4 is not in LTS kernel branch either...

Thus I recommend to go latest or even latest rc just like archlinuxarm
is providing.

Thanks,
Qu

>=20
>>
>> Thanks,
>> Qu
>>> --
>>> Best regards
>>>
>=20


--p55U0CUKgQYTrt2tYdZoU292YAaQSFCwq--

--RqSxsdhrDnVmMz8Pqvnyqd0OLtGYbRWvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl420G4ACgkQwj2R86El
/qibNQf/eRoD9xjnX9I+TH/qK85rvNfefHgHTBxPIjobmGipwBUhOxa4xoTaMtJr
HNPrne3r1evhzu5sYzlPHW0jJh4jNb9/PqsQIewdPzUWj/cxRA28dvs0yjQyGDGs
DP5QuilCbCwP3yiQuzjwU649Eu4VHf1mOd9Tw9qoyCjCsGbKKx4sViCDXFYMU1Rj
4Hp2JEvhQaWrQqkJzyriUykpGSt5i9ZTe+cuvQKS5YNpKbxvBdDaz1YkPNraj9zj
2tJqXA1qsbM7pe4F4hw1doyCMjapXp8EEv4XsGAiyfPVR+zDVCVT3xJxLAfIjM9M
SdZomClju/VUtKsC6fvyFBmaAXV86g==
=7aBL
-----END PGP SIGNATURE-----

--RqSxsdhrDnVmMz8Pqvnyqd0OLtGYbRWvu--
