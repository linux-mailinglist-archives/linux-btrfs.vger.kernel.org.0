Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438DF117D16
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 02:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfLJBTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 20:19:46 -0500
Received: from mout.gmx.net ([212.227.17.21]:58493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfLJBTp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 20:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575940783;
        bh=uUeBZ3M+b7WpVUOQp5Cz5HWO9KB+oLP9j0li9hrURfg=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=lou1VNOeGUiD4uAvUogEwyNR0sJ8Sp9kcHFdusSClZIXjgrQRz+OjIUKe9/fqErJ+
         dmKVZD69u6AJsV2adDOSsPYv3Gp859N3amXCmkVMB36ux4BUQZX69oqzM2AdVdhFtt
         B/JIoYn/oR5pFxmNiq/WqG7EbDGBXJGnyggr0YmY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS9C-1htZZc37Va-00l0GF; Tue, 10
 Dec 2019 02:19:43 +0100
Subject: Re: df shows no available space in 5.4.1
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
 <784074e1-667a-a2c7-5b47-7cbe36f5fdf5@gmx.com>
 <0102016eec056406-8dc0180d-5a2d-44e8-9ae2-f02573e62203-000000@eu-west-1.amazonses.com>
 <b0501a9b-34da-e69b-a06b-1946f7917269@gmx.com>
Message-ID: <2ae7f7c6-37a6-9133-6f97-e245812b005e@gmx.com>
Date:   Tue, 10 Dec 2019 09:19:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b0501a9b-34da-e69b-a06b-1946f7917269@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cjK6zWdO1VAtZohpKK9WS0eWIRe4fUW4w"
X-Provags-ID: V03:K1:0+gGczak5uC1FAaARzLYdQ5CGMOucbL4es/xZKp/Qzin86negbF
 LCWJVFIKfrLEus/pWA4hyoldslF4jsVk1iHci7nGguSJ4FsXEVPrBlJHiSxCXJCR1dSIanV
 YIr/wUDpgt8/oZahJ7NxjPraA//owov1dvZ+aGl54soIP4z52a84pxznx2Up6EWbEUGD67e
 bzJK4618aaNcxl0AunDFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dDrB8m3FW94=:Xw5kxipM4HNJQ9Ywdax7w5
 ItsZXbthpttN48/MWg9rXrUJXxdc1fV7gc4gPCnp6HsOEo1iZBBs48MP+8HJ/JQnAC1t5nT5T
 yX2JGctu7kwkn/bJDhCMGFshub3udBm3vuV54E0l6TtCc85ipgtVDpBN/m4+gRX3ABeTh2tnd
 6FYtR8IYUErhQbMywwThK80U/0V2RDIstHDrwC6tc5KslrCyzFFkZgUTVRTT4QDje1aCXNwog
 IKUqqaraxnUMWU/9LWKCsf4qPacFxltZvFAlJh5b0VfdlY7ZUDM7svgsxLssdVI8NUasxeOUm
 rrLGS+jmifMWBbFkRroBMacHzkKx+uMr7eBI6k8QyZpJrv/XZweKwwP3mvJOorUSIWARg7FTl
 iRh/ya6zqUBipJJZZAzmpTq+fugF2YOP5K1ELS2r8rjz4jxNAzJ2jV28ZmOo9oTE1zuIeK2gm
 npjRhHtuF7U8BkZTR1tgW0XbMA6f8gX5OBN466Hs8ggL1fcFmx5gsySrTlgpsL46l5LkqQVcv
 9dLPDLsGjxC0k5JhZuEezBtGdugF4ZKFQqD4Ts+P0r0enJK191ssqgmAJJy6wSxtfiigSHYkr
 kxCzSfDnV6AwJGvtEqyYlne/gKHUFc5UWWLb/W35d4qnEkDNzpSHYWzO9RAgqnk49dHJTrOYu
 iQdkEupp6srRJKV7EyKA1Sn/PwwkDU5ut6h4jI3i+PoWepspNvZARq9YtJ+vUrFU6EDGUKEFi
 7vLAsVn+xg7u50Bk+ZnmnSZnlMl3XR1k0HmJLl9g3OcgSfGgU/fz4rCw2ZmI/hPgQR4LjtuB2
 i7fGMOqBEO9wggrFIHsHbYZB6RedGWnD10D3POV2hpdpY8p/RMFzMPq34C5fwpVELN5VfQJua
 35aBiLYIQpF5rtzAzTyoFe/mPggKmE9ZTQR8lrvEFMIJVq1412i1w/Wle0JD9fFba+Wvp9byI
 0rTu1L6PY1NuzMClgiu7V0YmR5HWaiKgNXVP6eoq5uPBNWLHE4jghGqiBjogIanIuHDerSYQf
 n+6ROXgji/Yy1u/XIREopoJ8YbVSkGGwFB82hgNvopgR8y8ZdNrDbvFinvhCw14EWAWQExZox
 xrvQkPAfO89JuLcad+6nTkrKKcpy/tcWXm5M5FVANEd0LS6Jcr5f73ryyIXplXGPdSFrVgFNw
 gsqs9BV7hS/iryc2C5eFKlgMkyhBofBHUGRLe/VEuJZK6c/pFcrX8Cne8Cuz3m/xIZc8fS0B1
 cPP/4UALbkcGx6m+aStga66ioGds1N5ZTo0Y1I+WrGpljufZ7YLv4F+Rx1Mw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cjK6zWdO1VAtZohpKK9WS0eWIRe4fUW4w
Content-Type: multipart/mixed; boundary="b5TR3CFSatYcp5bQvKEzPinplikXQutdW"

--b5TR3CFSatYcp5bQvKEzPinplikXQutdW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/10 =E4=B8=8A=E5=8D=888:52, Qu Wenruo wrote:
>=20
>=20
> On 2019/12/10 =E4=B8=8A=E5=8D=882:56, Martin Raiber wrote:
>> On 07.12.2019 08:28 Qu Wenruo wrote:
>>>
>>> On 2019/12/7 =E4=B8=8A=E5=8D=885:26, Martin Raiber wrote:
>>>> Hi,
>>>>
>>>> with kernel 5.4.1 I have the problem that df shows 100% space used. =
I
>>>> can still write to the btrfs volume, but my software looks at the
>>>> available space and starts deleting stuff if statfs() says there is =
a
>>>> low amount of available space.
>>> If the bug still happens, mind to try the snippet to see why this hap=
pened?
>>>
>>> You will need to:
>>> - Apply the patch to your kernel code
>>> - Recompile the kernel or btrfs module
>>>   So this needs some experience in kernel compile.
>>> - Reboot to newly compiled kernel or load the debug btrfs module
>>>
>>> Thanks,
>>> Qu
>>>
>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>> index 23aa630f04c9..cf34c05b16d7 100644
>>> --- a/fs/btrfs/relocation.c
>>> +++ b/fs/btrfs/relocation.c
>>> @@ -523,7 +523,8 @@ static int should_ignore_root(struct btrfs_root *=
root)
>>>  {
>>>         struct btrfs_root *reloc_root;
>>>
>>> -       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>>> +       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
>>> +           test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>>>                 return 0;
>>>
>>>         reloc_root =3D root->reloc_root;
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index f452a94abdc3..c2b70d97a63b 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -2064,6 +2064,8 @@ static int btrfs_statfs(struct dentry *dentry,
>>> struct kstatfs *buf)
>>>                                         found->disk_used;
>>>                 }
>>>
>>> +               pr_info("%s: found type=3D0x%llx disk_used=3D%llu fac=
tor=3D%d\n",
>>> +                       __func__, found->flags, found->disk_used, fac=
tor);
>>>                 total_used +=3D found->disk_used;
>>>         }
>>>
>>> @@ -2071,6 +2073,8 @@ static int btrfs_statfs(struct dentry *dentry,
>>> struct kstatfs *buf)
>>>
>>>         buf->f_blocks =3D div_u64(btrfs_super_total_bytes(disk_super)=
,
>>> factor);
>>>         buf->f_blocks >>=3D bits;
>>> +       pr_info("%s: super_total_bytes=3D%llu total_used=3D%llu
>>> factor=3D%d\n", __func__,
>>> +               btrfs_super_total_bytes(disk_super), total_used, fact=
or);
>>>         buf->f_bfree =3D buf->f_blocks - (div_u64(total_used, factor)=
 >>
>>> bits);
>>>
>>>         /* Account global block reserve as used, it's in logical size=

>>> already */
>>>
>> Applied. It's currently 100% used directly after reboot, and I am
>> getting this log output:
>=20
> Thank you a lot for the debug output!
>=20
>>
>> [...]
>> [=C2=A0 241.245150] btrfs_statfs: super_total_bytes=3D128835387392
>> total_used=3D93778841600 factor=3D1
>> [=C2=A0 241.904824] btrfs_statfs: found type=3D0x1 disk_used=3D9346400=
6656 factor=3D1
>> [=C2=A0 241.904824] btrfs_statfs: found type=3D0x4 disk_used=3D3148185=
60 factor=3D1
>> [=C2=A0 241.904824] btrfs_statfs: found type=3D0x2 disk_used=3D16384 f=
actor=3D1
>> [=C2=A0 241.904824] btrfs_statfs: super_total_bytes=3D128835387392
>> total_used=3D93778841600 factor=3D1
>=20
> This proves the on-disk numbers are all correct, so far so good.
>=20
> The remaining problem is the block_rsv part. Which matches with the new=

> ticket system introduced in v5.4.
>=20
> Mind to test the new debug snippet?
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f452a94abdc3..516969534095 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2076,6 +2076,8 @@ static int btrfs_statfs(struct dentry *dentry,
> struct kstatfs *buf)
>         /* Account global block reserve as used, it's in logical size
> already */
>         spin_lock(&block_rsv->lock);
>         /* Mixed block groups accounting is not byte-accurate, avoid
> overflow */
> +       pr_info("%s: block_rsv->size=3D%llu block_rsv->reserved=3D%llu\=
n",
> __func__,
> +               block_rsv->size, block_rsv->reserved);
>         if (buf->f_bfree >=3D block_rsv->size >> bits)
>                 buf->f_bfree -=3D block_rsv->size >> bits;
>         else
>=20

And this extra snippet for available space.

Thanks,
Qu

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f452a94abdc3..f1a3e01a0ef5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1911,6 +1911,7 @@ static inline int
btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
         * We aren't under the device list lock, so this is racy-ish,
but good
         * enough for our purposes.
         */
+       pr_info("%s: original_free_bytes=3D%llu\n", __func__, *free_bytes=
);
        nr_devices =3D fs_info->fs_devices->open_devices;
        if (!nr_devices) {
                smp_mb();
@@ -2005,6 +2006,7 @@ static inline int
btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,

        kfree(devices_info);
        *free_bytes =3D avail_space;
+       pr_info("%s: calculated_bytes=3D%llu\n", __func__, avail_space);
        return 0;
 }



--b5TR3CFSatYcp5bQvKEzPinplikXQutdW--

--cjK6zWdO1VAtZohpKK9WS0eWIRe4fUW4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3u8qoXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgjHQf/VxkIoWw6l8ffaJ+HlDUrLjYu
KrLWlIZkZVpN/OyqZdP1joKWN2Fc+mF6Qf4/vuh/oj1hW7HBKs5k243Ekf8bedpd
p2Fnx61hko3vGOi3FaSHtPeJfpqoiPapyoBNQ0A/xBLZdlXbcSSM0jRQd5gR96to
wARg2c6FNo5lE+16tuUa66zGIq0q3vryTW1MnmnRvR1fG2020+D68AfSIEaRTBCY
o86q/XROo5CRp0S/Iv1uH+UosauE6pIMKBBniw6IEAbX8AfEj4ZN3JHbOKY3vLFG
f8V2boCjvg7cMiZmYlFW/bbBb4LbooOX8NA5UL3FbQQ2YgcQ8fGu9ZK2i8rqdA==
=iQme
-----END PGP SIGNATURE-----

--cjK6zWdO1VAtZohpKK9WS0eWIRe4fUW4w--
