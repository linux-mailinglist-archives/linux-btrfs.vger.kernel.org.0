Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379B9EF270
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 02:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfKEBGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 20:06:55 -0500
Received: from mout.gmx.net ([212.227.15.19]:44311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728602AbfKEBGz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 20:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572916010;
        bh=UQ7Bc/9e4fekTvNf7EU5BUMQXrba+2Dz9LccErz6Ijc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NKNxYhfWSCfdmbDEdArjbDy3O7rPfWkU1OG9IcddDrOoOOTGw9vSkAHzX8GY4/xMz
         aJxYHghChmEudi7Bw2BJXapnZgMYM/lRhj/yhFcHJmWLfKzU3b0jCnrBCYlrfIGEvF
         PZ9uQ/UJeg6UCMxMPzvKvj0CCjNPbAFKUK+CGKUU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRmfo-1iLhRK1gBW-00TD4R; Tue, 05
 Nov 2019 02:06:49 +0100
Subject: Re: CPU: 6 PID: 13386 at fs/btrfs/ctree.h:1593
 btrfs_update_device.cold+0x10/0x1b [btrfs]
To:     Tomasz Chmielewski <mangoo@wpkg.org>
Cc:     linux-btrfs@vger.kernel.org
References: <0a25bc52b9d3649d499b76d06e0d117b@wpkg.org>
 <d24256c7-4398-7627-4352-1878af1467e9@gmx.com>
 <94c49648ea714dcd1f087f24ee796115@wpkg.org>
 <c44c5868-6351-4d38-de12-c7903b64a441@gmx.com>
 <1e6ad65de01b6808bf9acf781e55dd47@wpkg.org>
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
Message-ID: <95982a1f-68dd-092a-3a47-3b8a6ffe67b3@gmx.com>
Date:   Tue, 5 Nov 2019 09:06:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1e6ad65de01b6808bf9acf781e55dd47@wpkg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1Q1Td1oUTvCumwZD0MldMsaMV9Tp8WeJN"
X-Provags-ID: V03:K1:bODs72/muO/+8xjfo5OlUnhCufFnqJT54Cj+Z+cLR/hz2OA+ys7
 Cc34j46q0zCNI4K23PJ4oeLkpsB7+UDQULBELPorMCIob7C0vEqG3HYGm1sDgFTPzVaXhMM
 DcX9QzXg4v0Gcb5KoONu9hmBPn+YWJhcbdPAfLVpV1dk6Dd9WmKx5FrEiwKjMCXWPa9Kp0Y
 YGNCfdKQQnMmF3R1qj/HA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PE5IFh24xNY=:3y7xFKw7C9b6EiT5yDie3/
 +PL+rPeXHUy+XKZMQlVx/a5QIRo104fwQ7OkEX4AwxhXf0AIKPUfVs/deL1ZUHPQKAg3YZmm1
 5sxlHdwjfkMfeOw71o8M2n1deiUH3LUxI/VF1IaQ+vtL9PBIgcM293Y5VjYkuD5JRn63nIDO8
 H5B4A9mZl9gUfoYA/rRB08xYWml42gi/UUGYgJlEjW5yeu1IGvkmnzzLlfjsfi0ROGZlFlIK0
 961LSysj1xjbDSu7svoes6cH53Vbplmjt0pawTfBZJXVwWns53ixKaRv7bvB3+KGxX29xC4xT
 +zLvwHW5UXSbBxM3BsMRN/ffFaEjc6DA0QQ0p+QJUOUd1OkxxW6JUukFnVhS4DKkbQinl5CSr
 c2drksGU6rteLF9o1ZCDHGEQL+ph2Mp9J6TnNoD5iILWiRdcUkR8DXYMzJ9N4YNadjmN9tIjZ
 XBBo37/yA7YMDHvswTMH9s2tyEEeBjE3yrW4OBO1sFvtiqWQp4UkEVfkNG0+IRcrf+lU3z7Za
 dwIIubrsf7MGi1t0eiHbPsVHXiupCyOp1z68RY6Bn2EozfC95GwyBeKK0Vr23eRe1dLyFl7Zi
 TPuZTc4pN/YcWRkAojpVid0+dAPCF2U4yZeaNeAuvPkiVCX+y3qcelJh/ycffV0Zkdn6zjIi6
 +ywHcFWoyRJdlt3IFdGHM1l+QoGeDewIcQTTfP/LMfpC/A9jE9VWCVloKaqftiyiAn5iYVGxn
 y1lVHzqO6Zc+SCWif/3Cbl8v0td8TeRTx67q0lsaW18KuoPFSLYuBEf/ADggXsNJeepoKRUwT
 SOQZ5ddUIsbr0pDagm3yKRJSnkZVWttnK8HzvtWAqDBlbeIKwRqFUL7JtwneWbcPqIP5ROuZh
 rC0gKrlfDZytztumQavzeS7KWC56/qL3UowsHWQSivC7mho9X9uGOpLMGUGYe8R633438GUj7
 Iwm+vFEobEyPI4tNYxSA8Jbm5hjWymUiSsY87KjkDEDGfmG3PSNtRSTKVZ2HWvlD0MfIoL8kR
 zGvFN67X3CUHQZYK7cTLL5b3910ieBRios4SNizFn9Wdr5SPOT1hI9SkX5c1nwsN+yb/WwV5k
 0Rr8Vrjzlulsu5cjf9LFnUpM3LWxDH3qUjSLDlDi4KP9MIusa/36r/6etvF40Y92mUS2omqS8
 PegF9wpm1El8mQ60ek0+w+nqrnkrOpnMVo4P3gZNQkA+xcRgup9EqZFsIDj3CK3WQuf5fWHYM
 NdHgS8BKabCZvDN53Blb9G6CbxPCxuP7v1N3OKR/bezxR8gti9eXxkJcMgYU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Q1Td1oUTvCumwZD0MldMsaMV9Tp8WeJN
Content-Type: multipart/mixed; boundary="M5t8EGyyZSMGaXEYsCGEqV1XimOSH5IjW"

--M5t8EGyyZSMGaXEYsCGEqV1XimOSH5IjW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/5 =E4=B8=8A=E5=8D=889:03, Tomasz Chmielewski wrote:
> On 2019-11-05 09:52, Qu Wenruo wrote:
>=20
>>> Now let's try to unmount and see what "btrfs rescue fix-device-size"
>>> shows again - I'd expect "No device size related problem found",
>>> correct?
>>>
>>>
>>> # umount /home
>>>
>>> # btrfs rescue fix-device-size /dev/sda4
>>> parent transid verify failed on 265344253952 wanted 42646 found 46119=

>>> parent transid verify failed on 265344253952 wanted 42646 found 46119=

>>> parent transid verify failed on 265344253952 wanted 42646 found 46119=

>>
>> This is not correct. What happened during your /home mount and unmount=
?
>>
>> The fs looks already screwed up.
>=20
> Nothing happened - it normally mounts/unmounts without errors.
>=20
> Also scrub works without issues (a few days ago):
>=20
> # btrfs scrub status /home
> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 c94ea4a9-6d10-4e78-9b4a-ffe664386af2
> Scrub started:=C2=A0=C2=A0=C2=A0 Sat Nov=C2=A0 2 01:14:17 2019
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fin=
ished
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:55:23
> Total to scrub:=C2=A0=C2=A0 1.17TiB
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 368.41MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 no errors found
>=20
>=20
> It also no longer shows "parent transid verify failed" after a few more=

> cycles like this:
>=20
> # umount /home
>=20
> # btrfs rescue fix-device-size /dev/sda4
> parent transid verify failed on 265344253952 wanted 42646 found 46119
> parent transid verify failed on 265344253952 wanted 42646 found 46119
> parent transid verify failed on 265344253952 wanted 42646 found 46119
> Ignoring transid failure
> Fixed super total bytes, old size: 7901711842304 new size: 790171183513=
6
> Fixed unaligned/mismatched total_bytes for super block and device items=


When this transid mismatch happens, it's highly recommended to do a
btrfs check on it.

I won't be surprised by some error.

>=20
> # btrfs rescue fix-device-size /dev/sda4
> No device size related problem found
>=20
> # mount /home ; sync ; umount /home
>=20
> # btrfs rescue fix-device-size /dev/sda4
> parent transid verify failed on 265344253952 wanted 42646 found 46119
> parent transid verify failed on 265344253952 wanted 42646 found 46119
> parent transid verify failed on 265344253952 wanted 42646 found 46119
> Ignoring transid failure
> Fixed super total bytes, old size: 7901711842304 new size: 790171183513=
6
> Fixed unaligned/mismatched total_bytes for super block and device items=

>=20
> # mount /home ; sync ; umount /home
>=20
> # btrfs rescue fix-device-size /dev/sda4
> No device size related problem found
>=20
> # btrfs rescue fix-device-size /dev/sda4
> No device size related problem found
>=20
> # mount /home ; sync ; umount /home
>=20
> # btrfs rescue fix-device-size /dev/sda4
> No device size related problem found
>=20
> # btrfs rescue fix-device-size /dev/sdb4
> No device size related problem found
>=20
> # mount /home
>=20
> # date > /home/date.txt
>=20
> # umount /home
>=20
> # btrfs rescue fix-device-size /dev/sdb4
> No device size related problem found

And that kernel warning still exists?

Thanks,
Qu
>=20
>=20
>=20
> Tomasz Chmielewski
> https://lxadm.com


--M5t8EGyyZSMGaXEYsCGEqV1XimOSH5IjW--

--1Q1Td1oUTvCumwZD0MldMsaMV9Tp8WeJN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3AyyUACgkQwj2R86El
/qifHggAk2rHi0OBdG1ZEq9iqJkuyTfd20Qs5Ffvb0q/N9JCkHa7SSQP/AtN7tMO
57WRI4Ga8pjN9KjfeUtlEKg/simOVgUPZr+XKh+imKjVmefkh7/BMa4WcmxoGhi8
z1jv0CSufHDn+JmS3NcSGH0qxmQUcd6MXL0rHQ3sIiHsfd7fpgp/zlZIuHxlNLFL
825OttxcenwsZLYp1mTJYNdiflUy+qxsmq3H5TRMUJ+h5yavT7g5rKYmSCOP7tVF
9LiNE+aqeWcFaRt8IkDVv1Mmqz9T4RUKjTISXzIuJhySHcdHpt2cAiUrrTE/0+Ki
kq863fgt4YUWw0znEiodfx/jqL6BhQ==
=xgbu
-----END PGP SIGNATURE-----

--1Q1Td1oUTvCumwZD0MldMsaMV9Tp8WeJN--
