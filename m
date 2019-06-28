Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF76593EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 07:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfF1F7G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 01:59:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:51131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbfF1F7G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 01:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561701529;
        bh=n61k3Fy/VELxsF6Vga5C6E4qLmagMAHuXzYJFllqy5g=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EIoQkHaSN2R/4n/E9Vt1tytkAShVjGPRnN8VPszJeKsxX2LGUZqg4dr16py6Xevk2
         PanJuVsE4DwxRUN0HfY3zppsXKUTETJE/MWmOENo1Z+GwIfRvmpiRILZenXlMb575M
         GQw0yO3bZJ6rx5R5IVYh3ayZ8IlJt+XUEGhDqafE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MC4R6-1hpVLk22D2-008tHz; Fri, 28
 Jun 2019 07:58:49 +0200
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
 <fa804a25-b0a8-ad1d-760a-bf543418970a@oracle.com>
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
Message-ID: <4581937c-cfa1-91e2-7a83-7c3f40f02857@gmx.com>
Date:   Fri, 28 Jun 2019 13:58:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <fa804a25-b0a8-ad1d-760a-bf543418970a@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ghf8KsuXcH0cAtM4GCJivwDV5yFmSFwBd"
X-Provags-ID: V03:K1:gd4adLCcJtGVgeG7clFHnwE1iRxePQCboBWLT6Y/WdjHwa7NyT9
 0qy816dZOdxzQ1hcXtCFHNL+jqOuxoepj2vo9A96lC+Xn9xTVXNl+bXFV0G+j/yQ/8wA913
 A8yYlI/QsPV27gntZuvMwD1SzqfRYVdo1GseKkAFHcOGXruLpHa2p0i/IbjrmKah3jXj6xR
 SD2Uetgvfy7sjuiPzmuVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9zdrFzqYRZ8=:GZvDmckGyhYX9/wCf3rnEE
 RHxyDPg0DcJounR7Rc+9WXQbUkTLLRfRR/FCsefw69E4NKAAt/MtdNq9vSX7FSGaG+KvyjTk+
 2/ciHUOY8uz487JHry1ZXXhqnA1h4r+d8QXAQ4hI9YF5PpNS5Y2+NQgnHpIpy9Ucvrqfllqqp
 049LEb0W2pkFx77z0etbf8g1pndKKG5qv80eOna24xOS6nzs5KMH3BKjhqw44E4SRQwUXoFCs
 I83qqjDxdC0CbEi4tn31am4IguzZpUtWEU4TAE4pUp9o3b5hE29TBWlY9QpN76mweCc5OWcL6
 33dgzAsoZgpkULgIkZwzunErzbPNW7bWRG3l/lXVYaMaMPVAomV+A+pGbDkV8T3hKHUsmwi1n
 8Er7747FJVbdk4JrYdrt9T9yRWDB8rVcu2e8ZwI6nBNhd4bYk1u04LZRsHBBs4Odweh5bWdP+
 GJvlPNB8u8Z8/PcTdf491OGuQXA+lVoubTxn4nWvazVCfB9ZVEUhtwr42Mey9MGMrkQgZ/9Rd
 ZsYz2EPB7DcLLGkdwu2H0O/ZWHa1JiTpg87dpx3KQYO438j7ibMb5EDrQegV5cRTHRSj+riKW
 sz87+jJLQgg7sosutJ5oMwopAtrT0rERmFOQ3w6p9Ik/6jk1Q6l+cnmhqbAaqdpEqK6LvAofn
 XoIAZVtSID52BDlKuEUWRH2CwUSsHZC9zm00oQNQ/OBmrOMuTpTK6l+AlyziNNiCpzi4ODfbR
 wIe3jaZnEF/u2es4iq1bsDQJaSQqUp76sboIOoN7dgP5lO8WDgkVLu5ME9pacAmUVZIvJWy5A
 OcrXi3K/vWlwi6HXWILI285L+fvXk3x/XJyLR9LutyVnzGBRsN9o2eFDNmeVs7Hi7gWqCyO+t
 TSiWcjdssK0YIDxl1+NOw5bIMn+5P+iQYTt8AQba4+JKZSp4FYD9DOhTogDPogaFEZW1rv0HY
 qBwZTVTRJ10N6Wqb3tm2vN8fjN9Agn/vyFI7fbZQci7eBCZNATgw059JhoClEUq4MIP8tXEOA
 buvG/xXoxm8xSrnyFH4h1eG8Gr02kmMVqB0DhNhFkzAfHc5kz3Q6IHWSV+PSASalW62e0DPKG
 HO52ZYYYwZn8p8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ghf8KsuXcH0cAtM4GCJivwDV5yFmSFwBd
Content-Type: multipart/mixed; boundary="5gWHDM7oivLJK1K9GmFXq9t3tNeqzPhmV";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <4581937c-cfa1-91e2-7a83-7c3f40f02857@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
 <fa804a25-b0a8-ad1d-760a-bf543418970a@oracle.com>
In-Reply-To: <fa804a25-b0a8-ad1d-760a-bf543418970a@oracle.com>

--5gWHDM7oivLJK1K9GmFXq9t3tNeqzPhmV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/28 =E4=B8=8A=E5=8D=8810:47, Anand Jain wrote:
> On 27/6/19 10:58 PM, David Sterba wrote:
>> On Tue, Jun 25, 2019 at 04:24:57PM +0800, Qu Wenruo wrote:
>>> Ping?
>>>
>>> This patch should fix the problem of compressed extent even when
>>> nodatasum is set.
>>>
>>> It has been one year but we still didn't get a conclusion on where
>>> force_compress should behave.
>>
>> Note that pings to patches sent year ago will get lost, I noticed only=

>> because you resent it and I remembered that we had some discussions,
>> without conclusions.
>>
>>> But at least to me, NODATASUM is a strong exclusion for compress, no
>>> matter whatever option we use, we should NEVER compress data without
>>> datasum/datacow.
>>
>> That's correct,=20
>=20
> =C2=A0But I wonder what's the reason that datasum/datacow is prerequisi=
te for
> the compression ?

It's easy to understand the hard requirement for data COW.

If you overwrite compressed extent, a powerloss before transaction
commit could easily screw up the data.

Furthermore, what will happen if you're overwriting a 16K data extent
while its original compressed size is only 4K, while the new data after
compression is 8K?

For checksum, I'd say it's not as a hard requirement as data cow, but
still a very preferred one.

Since compressed data corruption could cause more problem, e.g. one bit
corruption can cause the whole extent to be corrupted, it's highly
recommended to have checksum to protect them.

Thanks,
Qu
>=20
> Thanks, Anand
>=20
>> but the way you fix it is IMO not right. This was also
>> noticed by Nikolay, that there are 2 locations that call
>> inode_need_compress but with different semantics.
>>
>> One is the decision if compression applies at all, and the second one
>> when that's certain it's compression, to do it or not based on the
>> status decision of eg. heuristics.
>>
>=20


--5gWHDM7oivLJK1K9GmFXq9t3tNeqzPhmV--

--ghf8KsuXcH0cAtM4GCJivwDV5yFmSFwBd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0VrI0ACgkQwj2R86El
/qh8jgf/WHclQbzCfGWbaA1ToGK0hlCvIqCIaVi6Of9U/nFwMhS8UzhkWKATQMTG
LOgYfQ/d1rvbmcdWTbEEkIUu1CKiHt0BZKMpCypvcGAehl2CZN7shmypxljhkJCC
E+8edLnAc+DNCFGUs+qLPCRWFc6LHk/iZB6UU8FWNmHYYBr077QT+rxXyR3i1fWr
KvgOx8gP04VZvXP6zT1FLTcCIhZ7JHFJQGOpzGYaVihX0O6jfdLPWhpLmR7W815j
rt4wgTqcBBecmiM9Lt4/3lywSZxavNDdpiQasqquJ1NCrFe5rMC4b6CRuVd3GD11
+OJxuN8efiJAENc3sNuEPHxu8p4JjA==
=E692
-----END PGP SIGNATURE-----

--ghf8KsuXcH0cAtM4GCJivwDV5yFmSFwBd--
