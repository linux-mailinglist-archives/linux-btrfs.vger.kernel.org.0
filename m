Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E99CC1D90
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbfI3I7N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 04:59:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:42299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbfI3I7N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 04:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569833951;
        bh=2yDJslQkNWdGHqQ46HH+Y8T42rj6knREvYDm5Dfs0Dg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Rari+QDMhVYIKir2M+xmSkLiEub/e/PO6UxGl4V4jgNnznP6PtBzPi2F9LMFoGaqM
         bQMXZzCiEsKCRqRJzqcfL4gs0ZhNEsJHSBmMRoNFIPmhbORb7VTOtENn1mXf9+mlVm
         iWoz9pnmHz0vd3Lw6xyAd4its16PFHM2SPyxKLG0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGRK-1iY2nY315a-00JL5a; Mon, 30
 Sep 2019 10:59:11 +0200
Subject: Re: Btrfs partition mount error
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <31560d49-0d03-1e26-bb55-755a4365dce7@yandex.ru>
 <70eaf85f-751a-f540-7fde-bb489a0bb528@gmx.com>
 <e5383397-3556-1c9c-7483-79ad6d74de49@yandex.ru>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <c9d71bdd-7fe2-faaf-23c0-ede163c1d04a@gmx.com>
Date:   Mon, 30 Sep 2019 16:59:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e5383397-3556-1c9c-7483-79ad6d74de49@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IoUTHpDvT5TbgynptemSAN4WtIkXFIkNq"
X-Provags-ID: V03:K1:98ZlC+MRwIBCQYszoUoT8ObN83a41pVd4jTzv80L8iB7xSrI0+n
 kdVkWE1YNke/0VKTF6beoRZ8DOxntN1yLoarUgRPk3lItoU1VuA+kl1McqvPnGo8+YRZYWL
 iOiDewEZsbwIdFXJEFk4kLARmTFfUKcBgpkcjv0OnZSjQCCFiartIdU6pIABXhFWnjSYt+K
 geW9sPDZRtJvT/QL1Z3Kg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0HGPt/mIrUE=:xQ9R+1IQ3r0ilBxlY5hwi2
 1PzlrKGXFDewV3CBf99UYdIAkH/JMxcFMNhojn8zOX9FFwFTlVN+RCTesIEfjqRqzIKFgNc9X
 RaXemhjF57QSGjBlN7GFSrvz2UtCQu7pqOX4YG3Mn/sdIyFdQMv8Ir2pj3aDMRS1WoVyB+NWV
 ePVOvr1AvZQ4Bm94dsPVT2l8HFVvbXPA/wxfjmZxYi4zIvSf0ZQq84agZ+SKvipziauRZB+K9
 j8Xj5TUrMMfT6RImkdNaWmHV0DcM6dqwnxdl8MIBobLoAB8dxuaTqtmecLP+01N0K4ixJMD89
 b/FctmrNUTMAaQ3Ibt0eySBouJov8uuaj0mk/pbucxQ/3D+2UiMYVyx2KVDBEKZfVGo7Q1pvA
 OeqhZA0RZ0sALKyE3n7R8wIsFgvTNuMFMw1v4yBLg2iKahrcThszX1vMEkahoe00ospb/x2kL
 Z+aosGbLdwQF9HB79jwvITfzc8RrzY1Wc5GR0gJyBpU1WjTD3HCD/q/mccGlNFNWy+K2uRjnG
 koaOpuxYnmaj+vgZ7wo5KtZqxScHqx763ykt2SmeIbIrubP/U3blAPcEcGLm4tYl0C7obN3FL
 q/+mY9jNaU6nn/uI1YRxUY6eLu48g6Ik+aypvpFr+QH2bJm1xcvYgZFuhht+Lni1+y+RgOzUN
 jRZYOvQwhBdZPL/zhDYZxJh1DLnqfvHNXbrHlyDojv50CMFDRL6XF0ENFplGgXa7CZ6Z0ZErl
 /euAYrNsgWkpC2C9ykcaevJp81EejKpeYGE9i6trdW8TAMCFH8WWTjzHa4d/8T6DXLDcnDdAf
 +0PILu4/Fgm5zQDHDzwx7R6oSvY1O0dufNfdyVMkLFlT0zYJhZuzNhEuXkbzSB2tQgWm9o7Zy
 nXmpVS1ALFhtev/ZoTXS7bbeSJl2r9Tunsj63wfRwOInPJPnRqGNZRlFGl7tsyah7Yq7JaBDN
 +stj+VVkWz1zYGC/87WvmTcGdNupmYwvZuzM7QN82hQJRzkwLhfPKwf12M80bn1UtVKBt9zwb
 89wIR+6V9g3/Q/d6tsV8ZHSrbVEn6XwUQqhIXI/cDLEFspliQVoZxRfooihbg4/Gqqj0Ni2QD
 UHVhmezGBLpn63BPtPlpWEKUDDvj4hQm5jaX3RZFSoR5LLK21pV3v1rbhqDf/pTeP7e52Qsjg
 cmMNeKqot+vIoPgyofkF7ZR1wNRKEuoXFKl1FA1+rt2Pr4EsoOCO6gsyFzBprF4WIImXJZqgy
 Z2/yhU9zX8cGzXoNxSyxuqEHD7lWW/AxtjAjkRPuEsHWu2kAvLmkEL+2PIbk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IoUTHpDvT5TbgynptemSAN4WtIkXFIkNq
Content-Type: multipart/mixed; boundary="7ujBdW20ca3YbBzrq6ifDZN4tmDjwhWyM"

--7ujBdW20ca3YbBzrq6ifDZN4tmDjwhWyM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8B=E5=8D=884:00, Andrey Ivanov wrote:
> On 30.09.2019 10:31, Qu Wenruo wrote:
>> For this one, I could help you by just reverting that bit, and then yo=
u
>> may be able to continue mounting the fs or at least run btrfs check on=

>> it.
>>
>> Please prepare an environment to compile btrfs-progs (at least
>> btrfs-corrupt-block) if you want to try.
>=20
> Great, I'm ready to do it. Environment is ready.

Here it is.

https://github.com/adam900710/btrfs-progs/tree/dirty_fix

To use it:

$ ./btrfs-corrupt-block -X /dev/sdc1

But please keep in mind that, the offending tree block has more problems
than I originally thought:
- Bad item size at slot 20
  The original one reported by kernel.

- Bad key offset at slot 9
- Bad item size at slot 41
  All bitflips.

So all 3 bit flips happened in one leaf, it's really too rare.

I really don't have any clue how this could happen.

Anyway, I don't think the dirty fix is enough considering how many
strange things I have found just in one leaf.

Thanks,
Qu
>=20
>=20
>>> I did a memtest earlier. All had passed without errors. I can do a
>>> memtest again,
>>> but it seems to me that if the memory was faulty, the system would no=
t
>>> be stable
>>> and often hung, but the system works fine.
>>
>> Indeed, especially considering that there are already two bitflips in
>> one leaf, which should be pretty rare.
>>
>> Any out-of-tree kernel modules?=20
>=20
> I only have vmware out-of-tree kernel modules.
>=20
>=20
>> Or would you like to try v5.2.15 kernel,
>> which has a self detection for such problem.
>=20
> If I understand correctly, if I install v5.2.15 or later kernel
> then I'll fix my /dev/sda4?


--7ujBdW20ca3YbBzrq6ifDZN4tmDjwhWyM--

--IoUTHpDvT5TbgynptemSAN4WtIkXFIkNq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2Rw9sACgkQwj2R86El
/qj0AggAgPXEALwghc6oXDVqrx2RGVSol+C+E1hQXI6XTthVsInlOB7s4G69E1KY
7tHD2bw/wfGZpkGXj0owIde81hwOcZ0eXuT9Unjo8rvmKvTrM9XaVtfFTQOpcRbN
c5dAtpO85cxuMINkUW815B4CalTkOMN5HwLfEM92ee/SAf3meSBDWywesm49MaOo
UWaEFXfN8ln0g1jlDYcszPF0hcYpHhdGKNBUTjKrRbXxasaQ9dKVbSIlxMvkttrT
vpZV4fWsrrpFuZ/cMSQBSJE3aVcdw64xJLNd5idh9awPMPEl+KK2b0Dgrpk19ZPU
+HtDAAn6xLI50uULG7z+ZlLlL18Q4w==
=mcmN
-----END PGP SIGNATURE-----

--IoUTHpDvT5TbgynptemSAN4WtIkXFIkNq--
