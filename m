Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8C1503F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 11:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBCKLH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 05:11:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:48653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgBCKLG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 05:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580724663;
        bh=fWe/iTIpuPdMMZwHfR6MuhZQXhFecbl58Ci0hZbEbHM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QbyqMdk/coRDZVzviOx1PpB4iAPBizbODRr+ngW0o2iu/Jv1OZm1PJMj+sTJWUSo4
         XJUu/pgew4tTIs7TGrdB2t0gqksKwGHw8V9hPI7e44IiisWzAK5l+sqlu38Hj5WZJa
         Lx1ujd8/1tss3tIFvHrtKDUObwdVvNjW4geXqgnk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLQxX-1jFGUv2Of5-00IT9n; Mon, 03
 Feb 2020 11:11:03 +0100
Subject: Re: My first attempt to use btrfs failed miserably
To:     Skibbi <skibbi@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <CAJCQCtR0hzV+9S7cggGUUTtp4R1WdnSwzsOp=9fTnxvzn3Stmw@mail.gmail.com>
 <CACN+yT-FrVi71HKANj7NRinyPoDG5Aowma9NT=UB2WGvqoLSVA@mail.gmail.com>
 <94fb7bb4-53a5-f2e8-a214-2d12cf49664c@gmx.com>
 <CACN+yT8OD1jFFgbdrNuqrfsfYZMpPfJaTQ+7cGUSuWaaeH9g9w@mail.gmail.com>
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
Message-ID: <8944f055-6693-01a9-5b29-23d78c309274@gmx.com>
Date:   Mon, 3 Feb 2020 18:10:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CACN+yT8OD1jFFgbdrNuqrfsfYZMpPfJaTQ+7cGUSuWaaeH9g9w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Pwj1S1p2qv40WU2oGOukBfvkpiJD3YWVE"
X-Provags-ID: V03:K1:DLkEWGEW64Ex1jv8xUtaLxjlZdeUxBQwnBHr4zgcyBXZqnIDAzg
 VfRUZEgVlQ55XQ4giT+YnPkL9viGJBjnLLd5vJeZ58QIChrMFB73+LIPpRce+S+5kq8jhZP
 8lFelxClVXToHsxnzwl5pPmovQ7KkGnb/TDIOTTXYe25rgIiUocSPcAIMqyWe2lm0Xe4qV4
 kuVKMpBYNGyACmvasHBzA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:htR643j54hk=:b/7Phks7giN2rhudAuWloP
 A87vqmjozbi29PQWpm2usHJWp3I4kbczZmAggaJhsGUkY+2JhdNXQxwFX/X0zJEah5bIJtHL7
 FP6L8ultS1BbzuhFJrLd0l96dgrmGtNZ5UVwnovO0Zi6Pmh0Ag8UdGREZ4/rDYHE+cqNODBBY
 hV6DYe4CQKizzACTFPlN+7XgCRRZH6zI2eGzv82QKpYxCf+FwBpi/fJXMlU6uMneiXjvGACvh
 t0s7cZx9lMfNK2u/DWEehXxmwKgDnHsVP46w4LZ2tXyJYen+WYvsua+MJ5NOKU02qLNPuFTxZ
 VM4JIOy/IDNAwaEANA7rpB7mDC4jQ1sJRysPuNma8Wr1/TWYegI4kIFYj0RPEJOGpzPVDpGo7
 RuXREVn88SnFxjcUsoTB6Mh7z2Zq/SAw+JvOLx25qbcPXQorD8BG8pOpXHaAidJSCITKbov9x
 ubSZxO7KKN0lb7T38GdTS9+YnkuDwU7fE7V70Uv0hnaaaN5RR8BRcb4rb7ZDsk3M6hc4eVekM
 wAVlz7e8Y5uMSDqN8tjlUdS8NbxoHKSwOGxqN+wT4qXQtievdn8H6dXLFQq8yfmHH+9Bd++/h
 nB5/cosKWRsqrfu3l8a/Oh7Z8lGvSjlm64GE4aS7Xt8zQuI8b1Ww8WyhQTm1CeNrNh7eCLi5+
 vNs3HqbU8T6LYRVGaa8ch4hrMvMNBoy2ZYLU1g6f6BtRwFfiEf1osJhxvsbWM9MNfg9KW2/Ai
 8czTU7T+W2bRGgthIpWbfwdiBTtJIvuCmebTAqR8QpcutCuW8plgCwMOpuwios0hgRbH3m/el
 7R0mxG1i1AMgJuiGiX33CM3xg5hgE90Kyz5faQ/B8yE17Ou+HIENDJ8IUP7dCOmnvlGNrD5je
 +HK9nJ+4j5Y/P8WDBKlh41GrpnLd51wbcwt3239g6H2k3U87RDoWNO0AAfouVd+lM/jbDKy3c
 vR1k3gHxEIOxp7VEz00a6XyL1VkUkI+249pqkCsgLRiXKEWieeXDuKGw8x+RQEcf0fscAJwn4
 XDhzZihT6bLcEA6Hcqpyr86AqdQSNrEFRpG54gaZFnstLpxcqjXQqoAvuzfmXmtIxhPVVYaTz
 POsQGTcXmKk+7V+6T2pBsiu05Eo9sRMqKw4xbQCORg9esLgEkHLw0IJgMFh8Iet5I9gSdXpCB
 vkiJOZYHpn0M1UYBOAfj5LaqCDKTFAFOxrvehNmm8TOMrS4L+rGW12AVLSmBDH1S2Q+9E70FY
 ke+t0U5LkwaDoSln1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pwj1S1p2qv40WU2oGOukBfvkpiJD3YWVE
Content-Type: multipart/mixed; boundary="guvcReh0NUcgVgUoFCGIL4OmtpohNHG7W"

--guvcReh0NUcgVgUoFCGIL4OmtpohNHG7W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/3 =E4=B8=8B=E5=8D=884:42, Skibbi wrote:
> pon., 3 lut 2020 o 07:51 Qu Wenruo <quwenruo.btrfs@gmx.com> napisa=C5=82=
(a):
>>
>>> I'm beginning to think that my Pi draws more power when used with
>>> external drive (I used only pendrives so far) so I need to investigat=
e
>>> for power issues.
>>
>> That also looks promising.
>> But since it's a USB hdd, what about try it with regular PC?
>=20
> I tried on widows and disk worked fine. I replaced Pi power supply and
> surprise-surprise my disk is working fine! Btrfs + luks encryption. So
> it seems power was the culprit.

That's great to know!

> However I'm a bit concerned about stability of the filesystem. I would
> expect some data loss when drive is disconnected, but why the whole
> filesystem is broken?

It depends on the timing.

In fact, as your initial report said, btrfs even succeeded to read some
tree copy from the disk when we lost the device for a while.
And finally goes RO if btrfs fails to write any tree blocks.

In all cases, btrfs shouldn't fail if all disks follows FUA/FLUSH
behavior (aka, if FUA/FLUSH returns, all related write should reach disk)=
=2E

> I can't ensure that power failures will not happen in the future, so
> I'm still not sure if I should go with btrfs?
>=20
IIRC, either other fses just ignore any write error (and cause more
serious problem later, not only data corruption but also metadata
corruption) or just fail like btrfs when disks suddenly disappear.

If the disk is not reliable, then it depends on what really you want.

A kinda paranoid fs which refuses to further screw up the fs, or a fs
ignoring most errors until the whole thing experience a rapid
unscheduled disassembly.

Thanks,
Qu


--guvcReh0NUcgVgUoFCGIL4OmtpohNHG7W--

--Pwj1S1p2qv40WU2oGOukBfvkpiJD3YWVE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl438bMACgkQwj2R86El
/qg31Qf+IC42L1g/zrHSTwQi/leycyl0LqkeJQl4/Ihxi2pEia05rnu03L7YDCPP
j8kkFZv6hxzMcKS5WhXgUJDh3R3SJAdDuF9l8clshtxxY960Wd394zJbLMVeal8E
oenUw1oce8ghlF87RLiXWz7XhC4O+ZAgKJTMZmA4tyA/bby7DuYCei1Mlkyw4vl0
nnC4oHyBI3Uz0zKcmB58+IEaknmyjNKc7+13RWLgIsTe7RQ/uYpv3EgeZKZUlYfH
L6YfBzCtxNO/UVVIuTU2vKVzpX7qidH3d6BVWmYs33t7RPlPzAyaeTVfT+2v6Rus
xsKw3m2bvskb3/KpslafNZCzPXrA5g==
=KRMb
-----END PGP SIGNATURE-----

--Pwj1S1p2qv40WU2oGOukBfvkpiJD3YWVE--
