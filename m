Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D84336A8F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 05:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFFDxA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 23:53:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:44515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfFFDxA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 23:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559793171;
        bh=oJ80OiZNHFX2dDlbZiglR2eWUcxeGmCpC5Vq25Y5vPg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bOg9Bs1DB2PqrzysV9e73o7Vrtt7DmDs1V1FLOXPVtF5S7aRnq0vqijBH8ThBwUTE
         wSTFgcuZAx9ysPzLnIDDdl15yNz+w0YFhIgDydCkacujn7rbs2SioWv2HcIeLvSnmV
         zIm7d2ByK4G/Po1Da3EwJRwqKTA1UZ/bvnM6+1C0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M0gww-1ghIpI0OUg-00up1s; Thu, 06
 Jun 2019 05:52:51 +0200
Subject: Re: [PATCH] btrfs-progs: check/lowmem: Reset path in repair mode to
 avoid incorrect item from being passed to lowmem check.
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190517140003.32285-1-wqu@suse.com>
 <20190605160833.GC9896@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <42661024-8c85-99ac-5763-e9655a4d8c0d@gmx.com>
Date:   Thu, 6 Jun 2019 11:52:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605160833.GC9896@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w6UUqPbDEQk765ww8PmR5xZsfGlRCOWdX"
X-Provags-ID: V03:K1:GuKIO94DGJPNIJW+iv96GMJdNVniu9HI3mSjvbxz8ZKcUqc10yu
 ENEOW17L+taW5v01MlTwmKmfIKYNdca2CRyP+bYn4H8zTXftw4Mf/9FbaUrL2yj4e86BLpR
 BOkKRadlQ+8PPB+NEjMpGxBMOXJ28uu0dVdzkbctWzq2oUdczgwSSj/mSZql2W96edNkzOz
 MP7TqUgV7T1HE17QcOqiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XHvJqf6SROE=:du//hGnxh4cQEeVy3enaVo
 zPfEI3QMTv4frQ4yvLZT/VWBEG5AVEvZqtwga/OWbsmOLuGRowSE8PNj01PCu0+uyyJPBsS+f
 26oGQeGcFm6q/jYU3zuPRguOyH6Rp0i1ahoXrY1ffGx9L+XXfQGV1zLzG+cRh/wy8yFfeSBYm
 NYzuBmP3YKqEsQ416sL5HhYq/ROb9IB2dj9GpUTwqtSIx+iQvu3psgp0ZLqu3dMFHMTxRxcyU
 bJm4KIWljKRPEXN6vWcDp4F3L2mWXqYEyMfkN/DOst2VDFIkBMFBHCe43AAo7Ke/5NXdc0kzX
 IYEmVwSHde1gWhutROaHSGDZZbHYXkhR+Ell9p1UMofGGAsJ1OMp3eaWweZrXOr7fmBPFCwI0
 UeVDsvBmW1xkkI2U9ZXgQIwifuE1A+ueQXTTTOItb0mCqTZJpii+Z4y5rQIRwDzShFHTxRLWN
 VbAp9HmqeBWJCDkxwB6A0FwFljAnDs/ZSifmElAvdcup1p8QGqALVaKKWOd1DJ4KilA2sP5V1
 hcj0+rH5ui175p1xbI9WXuUKqquH0OLCI+y6GMHvMa9w1ulrdrzxLt7aUbQ4aYhjKvRTNZJlK
 sHQUBAmfVWjZZbm4TETY0JMWzSMzw+JV/0nv1zYfFwb1e/ZcNYzGhgBGsay90yih++JN3PASv
 vPA+MwAiHcJUj78NnmCoJnOIqGOu/WypoEGDK+gOKC8iA5+7+nLyDxhKIpfJjSDHk3DZOhGpX
 v00kGmqedZmBrmCHYfhNMQfXFjWy7E1UWYz0MpBQFeVLxkldLymmGIzam2vGaLdMB1v5LL3ZJ
 0w/rin4AhyJtUHSdrKA1eM1PL4WEEuIqMhUhhQslfabAm4rSW1u1U0nGN7Mq7EcoULz064Ic8
 YYk4DydVkbXuTaWu+PncL+dvZU00Hm2tJbwNOSJTLwlD/AFTo8MROaND8CBx+dBBjPIarEgso
 hUgfcPR4FJaG5Uyz5mdEukK7t6iD4Tuc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w6UUqPbDEQk765ww8PmR5xZsfGlRCOWdX
Content-Type: multipart/mixed; boundary="QPJhlEd3hOAvjK8DWhP3GYyt2kOm5eNOQ";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <42661024-8c85-99ac-5763-e9655a4d8c0d@gmx.com>
Subject: Re: [PATCH] btrfs-progs: check/lowmem: Reset path in repair mode to
 avoid incorrect item from being passed to lowmem check.
References: <20190517140003.32285-1-wqu@suse.com>
 <20190605160833.GC9896@twin.jikos.cz>
In-Reply-To: <20190605160833.GC9896@twin.jikos.cz>

--QPJhlEd3hOAvjK8DWhP3GYyt2kOm5eNOQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/6 =E4=B8=8A=E5=8D=8812:08, David Sterba wrote:
> On Fri, May 17, 2019 at 10:00:03PM +0800, Qu Wenruo wrote:
>> In lowmem mode, we check fs roots and free space cache by iterating
>> each root item and inode item, using btrfs_next_item() and a path
>> pointing to the root tree.
>>
>> However in repair mode, check_fs_root() can modify the fs root, thus
>> CoWs the tree root, and the old path in check_fs
>>
>> It could lead to strange behavior, e.g. after repairing a fs tree, the=

>> path can point to a fs tree.
>> Since no ROOT_ITEM exists in fs tree, all remaining trees are skipped =
in
>> repair mode.
>>
>> This bug exists from the early time of lowmem mode repair, and is only=

>> exposed by recent free space inode check code. (Fs tree inodes are
>> passed to free space inode check, causing false alerts and repair
>> failure).
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> I'll add it to devel, however the lowmem mode of test-check does not
> work now, so can't really test it.
>=20
With this patch applies, test-fsck runs well for lowmem mode, and that's
what this patch should do.

I just tried devel branch it works as expected.

Or did you hit some new bug?

Thanks,
Qu


--QPJhlEd3hOAvjK8DWhP3GYyt2kOm5eNOQ--

--w6UUqPbDEQk765ww8PmR5xZsfGlRCOWdX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlz4jg0ACgkQwj2R86El
/qjxKwf/WEvm6HmPdqe1MrqTl/EDpd56cIBwGiKdfiw6wvVXKWWTrlhvho+fW3jr
g6qj59KcjQwA1bvBV0h6gtflK2s00TS4T767MoYqBSzcYEInZcGlDwbhW6KAEzCV
G6z1A3oPQUDjYJejyirj7Oa0TGJ9qVhcl+f5GCUXeKucWF1NJWEBF2zImrcePBiF
32+MoD+RH5XVQNGmIR2Y09yUN5Byfyq3BzZvz/Kw7X3mlpprPpPDxM6VK9RRYEJl
LTsd0Nm6qldWQ9HumVwBRXOtgkJLbdvGWe8dzOp9bSNsulbpkwarm2FXvznssetm
VpLNoc+tK0lYl8hhvlnKjRxWoy+DQg==
=DPES
-----END PGP SIGNATURE-----

--w6UUqPbDEQk765ww8PmR5xZsfGlRCOWdX--
