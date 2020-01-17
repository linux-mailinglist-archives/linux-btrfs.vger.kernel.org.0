Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26798140127
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 01:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbgAQAzV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 19:55:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:49519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgAQAzV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 19:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579222479;
        bh=xWcTmAGfzCHz+RUpUX4C/48feR/KEoiQ+sTBsQHt0iY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lcaGjNfNUUSH3DS8hcCYEgvYiEad5osKgfWUGWnN51gecMISS8KuRN35khG/HX1m7
         ZmQj2TOhp93EOtWehbsOU5boEEqNOgKRlaFII3m44po9vyvwC8g4YTgWxpGa2Tie4A
         kYNWzGjjPEpxWqO0Hcp2cEssBXGFUjVGxxH6sQo4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MK3Rm-1jDmMa20kw-00LTUb; Fri, 17
 Jan 2020 01:54:39 +0100
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <20200116142928.GX3929@twin.jikos.cz>
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
Message-ID: <40ff2d8d-eb3b-1c90-ea19-618e5c058bcc@gmx.com>
Date:   Fri, 17 Jan 2020 08:54:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116142928.GX3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bg91HYZVPi71zMB9O2zV5RcobGF7bSb6J"
X-Provags-ID: V03:K1:VQ0sso73BSzlDwcLdu9jBC1n3IaMXPld4co0ETras3hAV3cNMZZ
 30CKnaeYaq5iysQfj5Ucz216/hVnnFsQDk1P36vjtlK4QCJbE8bSwR+1MZyiftzRT5V7MAm
 yAph+etwgpM/fva7VpCesvH6tZ0hSlKBKof+y3xPBP+wmLXF0izHzjiOLdIVZ/O3KJkWKPM
 fE/r7aGMq1vjeJeG2wuwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zi6z7jMzTwc=:CraBHhn0Q5are/gIeXUScJ
 Ck4p3BADNtViypC21pEi0hvXwzR832CSctSAVexahWsY8pmBgJy20gi+sZCNtYFOMMcVBul2a
 7kAkD5W1k9EVkC8PeRhdNCYWQOfUnt44P2JQVK7Rj2MQKqkyQukwrjbp7WMy4itr6wKSW+RNB
 IwawgtWxtO/O/NeQ4o2pdtTbV9ZTm5oVg6UlkqwcesHF7YzihMxS2r3HVGd6lxydNB7sLAtlN
 KnwMTzB9wq3tq7m8PWlpzbovfjv9Z8ORfDIJo7VNVoTg8nhkZFa9ZHSAzwD/G/0E199oNiDGU
 bKMeb+hKuIGtjWcSqUaQzJcZIszHMHzPgljduJoCFPbrqTtbNZkV+Gw4nxMsKC+T5gU+4i2o+
 zp5df6zpnyOw73Upjvg7wqTW9t7H+Tmvi0tSa6fIXK+8nqsve7r5lCPeAOlFkJEpscGYB82C9
 MWaFdSlDUj6Kv8CZzVxRAxSXWjxhDHB8ZOemOnBECWn/YmdUXbsZ4MpGekZAAuyh2JBqs+3T0
 Tb1n8ZV7ROt6aEPwdQ88RqzFNQxzmmxes+u07/Dvj7XlCosyGMoaUMnHXUNlzU+Ffyr/b6XFo
 Bse63KwRPTHzzooVgUgwtxQOtt+FhIBVtLc+FGEZ531xO9Ez1qJtvAj5w3PxMJ1vUx7gFCpXh
 aSno9yRMxF7rVy7Mdq44nl6YPwXFNVRo2qyboPYZiz2UfDakl3C/o7f3Tw3vqb7W64p60UH4u
 4fJR4QhlFlT/9+REi1EtUP+f0E1pQ7519Tjo8XWIA85LGb/NvnAfR2UhPwIIFPsQukAaCOrra
 AtDjtFnk03/kqIfPR0j1Tr7+5O/mvp2ihTZ6MkIvw0MEcfGY6ojWfsaZhIBZOa5oeCRU5BoOP
 HR8UZTb2WTXE7xoNjE4xxST/eHCBSUz0A/tozOYjwmW+5olTBSjNoBESBQF5SkiNFYxcTzChs
 XlAK7dFrMopy2ciszZOJqqFl1Y5uDMn0+hBCJ0Lr1rpnPuQcbsUV2yz+J1gFehI3gmf1UUEq8
 /bFB7RXlf03ugJXa36q2KvviNSgJNETHx2NWptthRPde9d0L3u6SLQXQ1W5zUHmqKeyO4did6
 xSYzCf9XGI8Wwtv3aOKaxsQoK5Gn39P/LgDMMZDf3PfZX0OO4BsmfyLMUhdRkDanl3cRJ14PR
 d/JxvGz83gcAzs3OkYoC7ksRvmpFKnINR17B5Qjou3TWuh7keGkjSSYt1h0U+RbEVLR6qCelr
 PEflyfUIsA3wHTyUlWj0z7k1Wp20YIZzBH4WGOitkuLWeOnSJnOFFy9J11as=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bg91HYZVPi71zMB9O2zV5RcobGF7bSb6J
Content-Type: multipart/mixed; boundary="E0b9c1YkVGQqEte1rkYRTgciBAoRayNoU"

--E0b9c1YkVGQqEte1rkYRTgciBAoRayNoU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/16 =E4=B8=8B=E5=8D=8810:29, David Sterba wrote:
> On Wed, Jan 15, 2020 at 11:41:28AM +0800, Qu Wenruo wrote:
>> [BUG]
>> When there are a lot of metadata space reserved, e.g. after balancing =
a
>> data block with many extents, vanilla df would report 0 available spac=
e.
>>
>> [CAUSE]
>> btrfs_statfs() would report 0 available space if its metadata space is=

>> exhausted.
>> And the calculation is based on currently reserved space vs on-disk
>> available space, with a small headroom as buffer.
>> When there is not enough headroom, btrfs_statfs() will report 0
>> available space.
>>
>> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
>> reservations if we have pending tickets"), we allow btrfs to over comm=
it
>> metadata space, as long as we have enough space to allocate new metada=
ta
>> chunks.
>>
>> This makes old calculation unreliable and report false 0 available spa=
ce.
>>
>> [FIX]
>> Don't do such naive check anymore for btrfs_statfs().
>> Also remove the comment about "0 available space when metadata is
>> exhausted".
>=20
> This is intentional and was added to prevent a situation where 'df'
> reports available space but exhausted metadata don't allow to create ne=
w
> inode.

But this behavior itself is not accurate.

We have global reservation, which is normally always larger than the
immediate number 4M.

So that check will never really be triggered.

Thus invalidating most of your argument.

Thanks,
Qu

>=20
> If it gets removed you are trading one bug for another. With the change=
d
> logic in the referenced commit, the metadata exhaustion is more likely
> but it's also temporary.
>=20
> The overcommit and overestimated reservations make it hard if not
> impossible to do any accurate calculation in statfs/df. From the
> usability side, there are 2 options:
>=20
> a) return 0 free, while it's still possible to eg. create files
> b) return >0 free, but no new file can be created
>=20
> The user report I got was for b) so that's what the guesswork fixes and=

> does a). The idea behind that is that there's really low space, but wit=
h
> the overreservation caused by balance it's not.
>=20
> I don't see a good way out of that which could be solved inside statfs,=

> it only interprets the numbers in the best way under circumstances. We
> don't have exact reservation, don't have a delta of the
> reserved-requested (to check how much the reservation is off).
>=20


--E0b9c1YkVGQqEte1rkYRTgciBAoRayNoU--

--bg91HYZVPi71zMB9O2zV5RcobGF7bSb6J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4hBcsACgkQwj2R86El
/qh2Ogf/QczGWsDkl/LoxY6aLi2cfmi+uzogbtweC4UdLYPVFcHFyyw26M88eGb3
HTmRg1FS6TLqun9A1YmSDhd7mb341twBfAVAJ98PeKCJZ6hPcwBLQAXpeWqe0myn
uY9Sg41V6AgQOLPwXwmBBI9QU53cQkjWLF7E1/PyqZcCbdzwdqpfFSdP3TlcIi8I
+NVoe68xjnBz4+sFzRhXAAn8F8KnmSYr/NcKJ3bG4sbw/vl7/5COoMJV6qCr+xOZ
yPP1JNDfzC68xNEP14RRZbx6XC55Ifq+GgBg0vVFWkJCD6vIB753FKxceBAiLPbn
X5WmQX7fxIdFwoOhcvwK4hWtrRtF6A==
=WAcR
-----END PGP SIGNATURE-----

--bg91HYZVPi71zMB9O2zV5RcobGF7bSb6J--
