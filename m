Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F379222323
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 12:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfERKVB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 May 2019 06:21:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:60075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfERKVB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 06:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558174858;
        bh=kClgX/z5S7KFtQ2sH3FHB/o/oj8BW4mQcGsLYD4A1N8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dL+hNTQDSZPhaDo9yNflaRg9SJT1VS6eHz+yAF+dnPqmEQbscKlf35/1hcvCXjGX2
         sbwMmHpDPw9SOrKb0uEhHoa8aXIBXg6OTeaHbSrm+aiVc3gjQq+OegH4MTCf1YlrXZ
         X9/EwpaHuDcPCkFg5HK8ub1+pPD8OtR+Bt0nqjRo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LcT2M-1gzmv83UkY-00jtQB; Sat, 18
 May 2019 12:20:58 +0200
Subject: Re: [Samba] Fw: Btrfs Samba and Quotas
To:     Hendrik Friedel <hendrik@friedels.name>,
        "samba@lists.samba.org" <samba@lists.samba.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <emee6c041c-adec-4106-b8f6-c4665299ea29@ryzen>
 <em20253d9b-ed68-47a7-946b-55c040417fd6@ryzen>
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
Message-ID: <35ddb243-0a2d-42b9-a367-431b5f8bf0e1@gmx.com>
Date:   Sat, 18 May 2019 18:20:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <em20253d9b-ed68-47a7-946b-55c040417fd6@ryzen>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IoaS6L7vbr6wA0KS9YWiDyZ9MJ7ZvxtSP"
X-Provags-ID: V03:K1:LZP8UZFJCEOtkBs2+A7jUU0Vy5+zQarI9XcuCKDr1WLMr2sIJgM
 U45lMwd48bofDEGKkignY9N3IPr4ab/xlDJ9Zz3V0MjssrhSr7b8xhuyW9ow1hbanWN1VbS
 lvGMz1OfnrjQnKUa0bJWpp5/xCClMfKF1DWqRE6G8wvXrF7yzpOM7Ga9N+z2rP93yF6o+1E
 8wyFAKFG53fCtONCrkS3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vkjw3zVhEyY=:VykSErdeU/qc/pK3L9t2xy
 UO/TLvyFOjb0DATJ/5nulqTkLiynY++E3rUmQTL5L4DsseK3hEdUgi0W0axRDAKIgBjl3rhTS
 Re/nLjK7yrB8iy4sa7BhnMyHEZe7RhwgzGY9e+IwgHfTeDNVpARHio6JO71OGqfwZcwLtQFSo
 VLhXGLPNy2yxOAwmbaHESr2puttntgBmZmfqUBps1Y90+pQYqFZnMuTOlYNKxo4WphUj0TQqJ
 mzd6RTcuUzMjy1uVnDNFRVHkob79phP63rAnqA55hChS3b446FoYUD6JId42tWa1xDMrwiX7Y
 2ya6xUuQcqFH2ARD6HeooWjoUfvjji3DDYveqS3O7JP1vgbDHS9QijRBkbgYmDsKbRI0SRkRq
 4iMMVOlHkeqwi+wzKarDH8GywfSCnm+kQAL8TWpgN2DlesmAI6pp/R8u1mvMNZ6fWHgQcKOBW
 Y4qP7QbpM7GGbxAqOw/DXpEZV1yqbSDI95bvjFzSyfhXSjKyQ+sWXv54rzvO+zLDGdPZrvy8I
 ap6O8QXd45yGYeC7hz3++uSZRvnVl0CFwLQxeOLk4Vl/uhaUpUv/wgUJ0Y9ZGhJNJQKVIH/8p
 v/azjfGhnmIbM9yIFsJtPIiMD6J1BP2PNagHHd3sQoQ2ktfuLzwQceOp3/UHr0wNAyR3kZHiz
 hyXVDnzQfbbUA/hMoXuWW9NVNCZBjxZmdtSnk1H06LFm76dRU5FWv/QTvJD9RIJu21sJFgYoy
 zQg0RyZXFhOSPg0K+c0ZOk+HeAsIdHyFA3nWd27QY9ErLgIG6WHNasBz+IohX5hH1mx5N04oB
 PxFL0emYgTz8gmOMgWOW/Ahrsnp1Cn4MfqCqjhYnCCPyH8Y1608jYtdYpFYqxe0cIMHU56UG5
 c03aAEDkJ9X9ikWqbZucQnh1I6P4c6MASqZ767uCjY8hXR8fIwYZVOxRPX2bd8llIpFUScm5S
 kgpz1Uli2xo0Eo+SCq3s5Jt8Jq2ZQLZ0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IoaS6L7vbr6wA0KS9YWiDyZ9MJ7ZvxtSP
Content-Type: multipart/mixed; boundary="2e8ETrFCwGCY3USXoPAa5CrflmvR0XT7T";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Hendrik Friedel <hendrik@friedels.name>,
 "samba@lists.samba.org" <samba@lists.samba.org>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <35ddb243-0a2d-42b9-a367-431b5f8bf0e1@gmx.com>
Subject: Re: [Samba] Fw: Btrfs Samba and Quotas
References: <emee6c041c-adec-4106-b8f6-c4665299ea29@ryzen>
 <em20253d9b-ed68-47a7-946b-55c040417fd6@ryzen>
In-Reply-To: <em20253d9b-ed68-47a7-946b-55c040417fd6@ryzen>

--2e8ETrFCwGCY3USXoPAa5CrflmvR0XT7T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/18 =E4=B8=8B=E5=8D=885:22, Hendrik Friedel wrote:
> Hello,
>=20
> I a bit surprised to get no replies at all...

Samba mail list needs subscription to send mail, so I'm afraid this mail
may not reach samba list if you're not subscribing.

For btrfs part, I think I have replied before, and it should not be a
problem for btrfs.

Thanks,
Qu

> How come? Lack of information? Lack of clarity?
>=20
> Greetings,
> Hendrik
>=20
>=20
> ------ Originalnachricht ------
> Von: "Hendrik Friedel via samba" <samba@lists.samba.org>
> An: "samba@lists.samba.org" <samba@lists.samba.org>
> Gesendet: 14.05.2019 20:01:41
> Betreff: [Samba] Fw: Btrfs Samba and Quotas
>=20
>> Hello,
>>
>> by suggestion from linux-btrfs I post this to samba@lists.samba.org.
>> I think, thiss is a bug in Samba. Can you confirm and suggest a
>> workaround?
>>
>> Regards,
>> Hendrik
>>
>> ------ Weitergeleitete Nachricht ------
>> Von: "Hendrik Friedel" <hendrik@friedels.name>
>> An: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
>> Gesendet: 12.05.2019 13:27:00
>> Betreff: Btrfs Samba and Quotas
>>
>> Hello,
>>
>> I was wondering, whether anyone of you has experience with this samba
>> in conjunction with BTRFS and quotas.
>>
>> I am using Openmediavault (debian based NAS distribution), which is
>> not actively supporting btrfs. It uses quotas by default, and I think,=

>> that me using btrfs is causing troubles...
>>
>> In the logs I find:
>> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() =
failed for
>> path [.]!
>> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879166,=C2=
=A0
>> 0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() =
failed for
>> path [.]!
>> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879356,=C2=
=A0
>> 0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() =
failed for
>> path [.]!
>> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879688,=C2=
=A0
>> 0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() =
failed for
>> path [Hendrik]!
>> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879888,=C2=
=A0
>> 0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() =
failed for
>> path [Hendrik]!
>> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.880093,=C2=
=A0
>> 0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() =
failed for
>> path [Hendrik]!
>> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.880287,=C2=
=A0
>> 0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() =
failed for
>> path [Hendrik]!
>>
>> As you can see, this is quite frequent.
>>
>> Searching for this, I find some bug-reports:
>> https://bugs.launchpad.net/ubuntu/+source/samba/+bug/1735953
>> https://bugzilla.samba.org/show_bug.cgi?id=3D10541
>>
>> Now, I am sure that I am not the first to use Samba with btrfs. What's=

>> special about me? How's your experience?
>>
>> Greetings,
>> Hendrik
>>
>>
>> -- To unsubscribe from this list go to the following URL and read the
>> instructions:=C2=A0 https://lists.samba.org/mailman/options/samba
>=20


--2e8ETrFCwGCY3USXoPAa5CrflmvR0XT7T--

--IoaS6L7vbr6wA0KS9YWiDyZ9MJ7ZvxtSP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzf3IQACgkQwj2R86El
/qhTAggArygmmHXJtdfj4BBg9h1PoqdtB0MWn4yursgvt3aFU81XR1NfVEgGaS23
Byzzahq6MxT/5yybQHXkZqhVEcK+OY/NNNJmMPN9hD4uuNZ/kqGK+hxRSppgn5NL
BBqToI2mQgkT/9r/WKdIIQDtNYr0+8gvfGXUveJybbUoLfjWlItpUL3NQEgNd0XW
XA8O3UL9VUFRfH6aEWHe01oKoPS4UwrTNjTwl62HanBwhUkXPJrzHGaZUjFZagnk
7hSxNhq6JvKrYUvYJ0t5JeaNO4WcPx8O9n6uzcfbAc018vjtFhzNUSRbytAZdwxR
E2mGN8w3gZg2JWStjbO+FqdePYXVbw==
=sv2A
-----END PGP SIGNATURE-----

--IoaS6L7vbr6wA0KS9YWiDyZ9MJ7ZvxtSP--
