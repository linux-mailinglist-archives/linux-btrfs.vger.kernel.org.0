Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68EE013B824
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 04:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAOD1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 22:27:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:47815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbgAOD1H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 22:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579058819;
        bh=aUTCyIA2Mpp73c2GxI0pEQpJKnGKY7ZXV5dmIS9WTsg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FYdB9nX7Xd2t2HNhWzGxNSyGI+aMSyGQSiKjFBshx4SpqmdMNVEF7AH89XEvOerc0
         ne031fWh15xAUunJCx0pTUwndtgXQeYWhFeGyCcH7kxYJ9j5Y3mjs1BII2xdCTld7n
         j9tepjWaJ9Qoq47fGwGMnJ5jtpVGizgZxxTSUjKU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXdC-1j4InQ3ldy-00MYh0; Wed, 15
 Jan 2020 04:26:59 +0100
Subject: Re: slow single -> raid1 conversion (heavy write to original LVM
 volume)
To:     jn <jn@forever.cz>, linux-btrfs@vger.kernel.org
References: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
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
Message-ID: <424ffd2a-2a9b-1cef-c3ac-ad2814f037a1@gmx.com>
Date:   Wed, 15 Jan 2020 11:26:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="J1tUJ72LM5Nw278GU20S0wA8YtFjgDHqv"
X-Provags-ID: V03:K1:vnWsY5BqKHNRUhqzRJzA6uM5XtxAfC+ONoXSOy9aCAg4q6jj2B4
 KEzD7xwG9SrahfquxXi8AOojT9IFFaYWZMqE9AloBxxEAFUckPObZg3FYAsRr5njkjUxgR7
 ef8H+YScq3S6lYkZAfOXydkozoHb4mxE96eYt1G/ybILKcU6WU5iprokS7gj1RdNCnuLnnp
 Qw+d7I2VR3PnDd5x1Uvlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/9tDTDd0uUk=:yEzo/W7DuYdj0XQ068Ke3h
 odSShBdCl5ZSaORYdM7pfq9WBMYE/2Bu1msaXyCW6/MXvLrGsFPrkCq8HMxxtvAm4KDy6JNG6
 ynwLAVoR9rVJc3k6f9f96ZAjLZygD1vDkIC9eJlPLWq/V1fGKPHJ3cwxVp6uRmOfC3DIXSs3e
 i3+PDIpEINw7TFvlL5iKsy8+u7rw57k8zjZjKEKf9YfQ3VG8Bre8IFL2hzs2xzsJWzCh2H5Sq
 Xl+h/TmZhNClKtpmb752lGgqQFmhUhQjFN7zCaA2CtHEQyA8gODJeV0+MWYhhWbKHEsQc5/BY
 K5RGgnsrdmhlkz0F9+XKaqalvgnQxa6hipzgxQDpuhb+fmQi2tZO4jh5+Xtb6kkskSp8CmtV7
 EIF8n+ZbaAWX/NyDtOKO0hJXJGcxlSnTYypzaP9cZuw69QG9MLfdkcforfFoprCZZIyHsTx1O
 cnRpvvi7TWULlqG6MKg0T53rPnSJHOzO8A6jqzW8iDdzewhp0br93SUOLnRz6bSQ/I1MQzPF4
 gbQBGQsRG9eTd0vq2UPE1Nwb4YA7/ERYKyoHWdy8NJ8qL3dQrOD+ZWMRWrI9OSohxXF/EE4KL
 UM5GZHqMKXb5yUGxwFhyNs/yI5BJbAPtJPQrU/RYus7e5x0VUp4gAaiSs1n9TAkDjPZXfrhGz
 uSslPN2Jfa/wOWwqdhtgugZ1Sbp7QosOqtdCDcSAonXYaQehHPpEdjp5fEXB6dhSSOT5ic5Zj
 WKRmwDstrQWHbW4jqVrfDjSwbM8Gzaz9fkUGx1pI8ZBgJJ9Yj1/Y4ebzhkMS16GVMJY4z1U4E
 LIf2aX7g5ttJGxe8NhEFOIIqt7pZC2BMztfrc9AYe13laRwoWgFOyaQU16MLFXCfqWEo74ACr
 GQQ7HooPMeDuTj7fVbYuLsIukwLhk6fw6IJj9VGoCEy4kglPf8L1/auGcfb+eUyJzU/Hcl1Ht
 1ajXyVsuptI4i5Xd9gqIgQt44+nei6YcjGUa1KrfjkgfpvPzAzTSQTtKSYl2PTnOq+MdjUbst
 3FZudjCw0nCvF6yWoPfB0ATDmJF53IObuvbkj2KRQJFPD18ttayO0yll79bdDpD5bhmsPuglr
 gGETl+3vGBnf93svbfAaXR0+hnskzyY48DsDsGtDglJfroreBJ1ePxd1btcRmZxoYud+XHAXJ
 +T979PcfxH/WlgdCcvauwU/Q9se0AHniUsGShoM3ab6Hp5M1FFoaSJsUb1vBcfbluXq3mUCvj
 FxrppbFVZyv8UVikH+C4uHluGhbqH706Z4ENpgM3lVdqbYmCwMI84097jWik=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J1tUJ72LM5Nw278GU20S0wA8YtFjgDHqv
Content-Type: multipart/mixed; boundary="XLryvEfRHD2JUkBzRSGa0Z9iahxey9c3J"

--XLryvEfRHD2JUkBzRSGa0Z9iahxey9c3J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/14 =E4=B8=8B=E5=8D=889:16, jn wrote:
> Hello,
>=20
> I am experiencing very slow conversion from single disk BTRFS to raid1
> balanced (new disk was added):
>=20
> what I have done:
>=20
> I have added new disk to nearly full (cca 85%) BTRFS filesystem on LVM
> volume with intention to convert it into raid1:
>=20
> btrfs balance start -dconvert raid1 -mconvert raid1 /data/
>=20
>> Jan 10 08:14:04 sopa kernel: [155893.485617] BTRFS info (device dm-0):=

>> disk added /dev/sdb3
>> Jan 10 08:15:06 sopa kernel: [155955.958561] BTRFS info (device dm-0):=

>> relocating block group 2078923554816 flags data
>> Jan 10 08:15:07 sopa kernel: [155956.991293] BTRFS info (device dm-0):=

>> relocating block group 2077849812992 flags data
>> Jan 10 08:15:10 sopa kernel: [155960.357846] BTRFS info (device dm-0):=

>> relocating block group 2076776071168 flags data
>> Jan 10 08:15:13 sopa kernel: [155962.772534] BTRFS info (device dm-0):=

>> relocating block group 2075702329344 flags data
>> Jan 10 08:15:14 sopa kernel: [155964.195237] BTRFS info (device dm-0):=

>> relocating block group 2074628587520 flags data
>> Jan 10 08:15:45 sopa kernel: [155994.546695] BTRFS info (device dm-0):=

>> relocating block group 2062817427456 flags data
>> Jan 10 08:15:52 sopa kernel: [156001.952247] BTRFS info (device dm-0):=

>> relocating block group 2059596201984 flags data
>> Jan 10 08:15:58 sopa kernel: [156007.787071] BTRFS info (device dm-0):=

>> relocating block group 2057448718336 flags data
>> Jan 10 08:16:00 sopa kernel: [156010.094565] BTRFS info (device dm-0):=

>> relocating block group 2056374976512 flags data
>> Jan 10 08:16:06 sopa kernel: [156015.585343] BTRFS info (device dm-0):=

>> relocating block group 2054227492864 flags data
>> Jan 10 08:16:12 sopa kernel: [156022.305629] BTRFS info (device dm-0):=

>> relocating block group 2051006267392 flags data
>> Jan 10 08:16:23 sopa kernel: [156033.373144] BTRFS info (device dm-0):=

>> found 75 extents
>> Jan 10 08:16:29 sopa kernel: [156038.666672] BTRFS info (device dm-0):=

>> found 75 extents
>> Jan 10 08:16:36 sopa kernel: [156045.909270] BTRFS info (device dm-0):=

>> found 75 extents
>> Jan 10 08:16:42 sopa kernel: [156052.292789] BTRFS info (device dm-0):=

>> found 75 extents
>> Jan 10 08:16:46 sopa kernel: [156055.643452] BTRFS info (device dm-0):=

>> found 75 extents
>> Jan 10 08:16:54 sopa kernel: [156063.608344] BTRFS info (device dm-0):=

>> found 75 extents

This repeating result looks like a bug in recent kernels.

And due to another bug in balance canceling, we can't cancel it.

For the unable to cancel part, there are patches to address it, and
would get upstream in v5.6 release.


For the repeating line bug, I am still investigating. The ETA would be
5.7 if we're lucky enough.

Thanks,
Qu

> after 6hours of processing with 0% progress reported by balance status,=

> I decided to cancel it to empty more space and rerun balance with some
> filters:
>=20
> btrfs balance cancel /data
>=20
>> Jan 10 14:38:11 sopa kernel: [178941.189217] BTRFS info (device dm-0):=

>> found 68 extents
>> Jan 10 14:38:14 sopa kernel: [178943.619787] BTRFS info (device dm-0):=

>> found 68 extents
>> Jan 10 14:38:20 sopa kernel: [178950.275334] BTRFS info (device dm-0):=

>> found 68 extents
>> Jan 10 14:38:24 sopa kernel: [178954.018770] INFO: task btrfs:30196
>> blocked for more than 845 seconds.
>> Jan 10 14:38:24 sopa kernel: [178954.018844]=C2=A0
>> btrfs_cancel_balance+0xf8/0x170 [btrfs]
>> Jan 10 14:38:24 sopa kernel: [178954.018878]=C2=A0
>> btrfs_ioctl+0x13af/0x20d0 [btrfs]
>> Jan 10 14:38:28 sopa kernel: [178957.999108] BTRFS info (device dm-0):=

>> found 68 extents
>> Jan 10 14:38:29 sopa kernel: [178958.837674] BTRFS info (device dm-0):=

>> found 68 extents
>> Jan 10 14:38:30 sopa kernel: [178959.835118] BTRFS info (device dm-0):=

>> found 68 extents
>> Jan 10 14:38:31 sopa kernel: [178960.915305] BTRFS info (device dm-0):=

>> found 68 extents
>> Jan 10 14:40:25 sopa kernel: [179074.851376]=C2=A0
>> btrfs_cancel_balance+0xf8/0x170 [btrfs]
>> Jan 10 14:40:25 sopa kernel: [179074.851408]=C2=A0
>> btrfs_ioctl+0x13af/0x20d0 [btrfs]
>=20
> now nearly 4 days later (and after some data deleted) both balance star=
t
> and balance cancel processes are still running and system reports:
>=20
>> root@sopa:/var/log# btrfs balance status /data/
>> Balance on '/data/' is running, cancel requested
>> 0 out of about 1900 chunks balanced (29 considered), 100% left
>=20
>> root@sopa:~# uname -a
>> Linux sopa 5.4.8-050408-generic #202001041436 SMP Sat Jan 4 19:40:55
>> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>>
>> root@sopa:~#=C2=A0=C2=A0 btrfs --version
>> btrfs-progs v4.15.1
>>
>> root@sopa:~#=C2=A0=C2=A0 btrfs fi show
>> Label: 'SOPADATA'=C2=A0 uuid: 37b8a62c-68e8-44e4-a3b2-eb572385c3e8
>> =C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes used 1.04TiB
>> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 1.86TiB used 1.86TiB=
 path /dev/mapper/sopa-data
>> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 size 1.86TiB used 0.00B p=
ath /dev/sdb3
>>
>> root@sopa:~# btrfs subvolume list /data
>> ID 1021 gen 7564583 top level 5 path nfs
>> ID 1022 gen 7564590 top level 5 path motion
>=20
>> root@sopa:~#=C2=A0=C2=A0 btrfs fi df /data
>> Data, single: total=3D1.84TiB, used=3D1.04TiB
>> System, DUP: total=3D8.00MiB, used=3D224.00KiB
>> System, single: total=3D4.00MiB, used=3D0.00B
>> Metadata, DUP: total=3D6.50GiB, used=3D2.99GiB
>> Metadata, single: total=3D8.00MiB, used=3D0.00B
>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>
> is it normal that=C2=A0 it have written nearly 5TB of data to the origi=
nal
> disk ??:
>=20
>> root@sopa:/var/log# ps ax | grep balance
>> 16014 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=C2=A0=C2=A0=C2=A0 =
21114928:30 btrfs balance start -dconvert raid1
>> -mconvert raid1 /data/
>> 30196 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0:00 btrfs balance cancel /data
>=20
>> root@sopa:/var/log# cat /proc/16014/io | grep bytes
>> read_bytes: 1150357504
>> write_bytes: 5812039966720
>> root@sopa:/sys/block# cat=C2=A0 /sys/block/sdb/sdb3/stat
>> =C2=A0=C2=A0=C2=A0=C2=A0 404=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0=C2=A0=C2=A0=C2=A0 39352=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 956=C2=A0 499919=
9=C2=A0=C2=A0=C2=A0=C2=A0 1016 40001720
>> 71701953=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 14622628 67496136=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>=20
>> [520398.089952] btrfs(16014): WRITE block 131072 on sdb3 (8 sectors)
>> [520398.089975] btrfs(16014): WRITE block 536870912 on sdb3 (8 sectors=
)
>> [520398.089995] btrfs(16014): WRITE block 128 on dm-0 (8 sectors)
>> [520398.090021] btrfs(16014): WRITE block 131072 on dm-0 (8 sectors)
>> [520398.090040] btrfs(16014): WRITE block 536870912 on dm-0 (8 sectors=
)
>> [520398.154382] btrfs(16014): WRITE block 14629168 on dm-0 (512 sector=
s)
>> [520398.155017] btrfs(16014): WRITE block 17748832 on dm-0 (512 sector=
s)
>> [520398.155545] btrfs(16014): WRITE block 17909352 on dm-0 (512 sector=
s)
>> [520398.156091] btrfs(16014): WRITE block 20534680 on dm-0 (512 sector=
s)
>>
> regards
>=20
> jn
>=20
>=20


--XLryvEfRHD2JUkBzRSGa0Z9iahxey9c3J--

--J1tUJ72LM5Nw278GU20S0wA8YtFjgDHqv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4ehn8ACgkQwj2R86El
/qjJHggAqVtPC/QW5F1qYMe4Wz0XJQ2FYzGH2qpZ4zGooW3HI3GI/5ThOkdJb2dT
gUSN8yiadiII2P6cixyhtUhWUVItb7XuNjklpy0s7V7/+WlWVnZsxE+dO2kR8vCy
RjYCCgvQJg+B0rE/uWxJ/y3hN4T5XJKgFPEAF9UIRtskrWZpQwG1YYWPj/yqs6XM
UXymMW/e8X7JsGT8l98aVG+kXlpO2Tz1Hz+cFumeqUgZeWv/8YOQXsic77ep6e2a
dB9rWoS0U4RLrfV1PuKB6773+9ewN3fZ4irfISWkNFJVWVAWtOrmezfhW7m+Gz/b
ANQOPi9AcQHWSFIPgAIrvKdIdhiReA==
=DPqA
-----END PGP SIGNATURE-----

--J1tUJ72LM5Nw278GU20S0wA8YtFjgDHqv--
