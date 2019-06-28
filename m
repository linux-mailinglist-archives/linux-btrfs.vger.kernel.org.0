Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F14659497
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 09:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfF1HJu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 03:09:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:44807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfF1HJu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 03:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561705755;
        bh=/n5f3I84qBWrYKaM5O/5yEhMbNcxDGancJiZ7g1rHbE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NVl43AOGreYPiIRPucJAlx3+wCvp7dn9KWbu+Qd+8RezGMMJqw/UVvaKC3vXnzV+G
         ABY7a5zRnfEwTkCGz5nY3t4DBmkMfgAThLHhZKscYkJ1ovAM9KwmZ5KYA4Bhpv9uOe
         IOwDcJnq2cXGpV6XLiW24w+3m0GabC41cADDB3ZI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Lt2BW-1iiziK2rsI-012W26; Fri, 28
 Jun 2019 09:09:15 +0200
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
 <fa804a25-b0a8-ad1d-760a-bf543418970a@oracle.com>
 <4581937c-cfa1-91e2-7a83-7c3f40f02857@gmx.com>
 <A47A32AA-1457-4B98-BEB4-A9209694842E@oracle.com>
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
Message-ID: <b83d32bc-3316-735b-d64d-73ac66ad03a2@gmx.com>
Date:   Fri, 28 Jun 2019 15:09:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <A47A32AA-1457-4B98-BEB4-A9209694842E@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tzxr7LbAIdq6AkjrH0g7T5ojagv2AeTxs"
X-Provags-ID: V03:K1:40bav4phMxUeN6NqwgmKhgSSgFId5+lRPkmeqSFj/tI4yFfd3GG
 508x8CkQcmLlwb5bDjVU7Fz8xNmxVb1ZuTzZ4dDNOG7i/S2Qr3hEzXwnY1SJ3mMcrP1cG/R
 Y5YW9DhAG8r179ecuOm3w5a/Kk9/iqTygfaWkMi/jZ1OdwzjfpSMz1NC6FjdQFL6h25/VNt
 pKreAXCYhPvLemE0nGIAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hlwn+iW3Tew=:1Tn9ushEOCpBWeIjkrgf/a
 l9qwG2hSoP8AathM2jE6OAJz3hNuSx1+1sT7Dn4UJzzWYw2JYzzvpT2+1eDCqJ1TVBkBYxEUp
 da8eyV9t6lFiE89jC8uRTSnTiM3ww4mND+8Jv4p6dh/0nSn9ByqteivbTrjs+aK6Xtb2zvSrm
 hAD7bN8s+KQ4vGdMX7b6L6bk4EhAo572q1Pr5W46M6QKYq4+om8wEm3ACMMDmAGgkqsBZPlEH
 Fu44i68XNJTb39ftF1hCMNqSh+zGyW9TPLE8ICZH0o0GJ41Mfg4TX0aFKU6wg34Epm/zN+Bnc
 +a8wy/EdWHYmUNdKGFnxyP5zqAGhBIPu79YOFQXSFQMDy3wJ+mBdDUX14jREc3EZA2RD+GNRU
 /oiqX+sDjY3/FDGgetV1rI6v5EP542421Yc5iPkSUWQz4tTEiWimtZuR0iR8r7ncuoaPxNhCK
 xxsy4WDjCQv8QzJw2co9gsXWHBWucMw+Bl77lyMgmn3sxBu6kNemEw8aMckPxtpHnxKhKTyqZ
 QJ1Ced2BTpZCKn+0yIbAQrR/9xhk/Nw+pjXxK+GNuWFTN3scOMdE8ihwJBUgR54sC0xCl36XC
 LXhxHmC6/b/QcQOQ5neFqM6OM7vR7sf7LQPW4JsyYGdelOA+kwF/zhdDldzJkDgWBw/P8XG/C
 aj9vqryUMKMMejnqX52jV3Q72eloRxsNv5708BYhF0FG0qHmS/rPIulZYuGB7o3NkBGjdQH/g
 Ayl4JMEMUa8YoxovR6XQ+cJjfliUoM7DPAnyDgtZN8xix18nXz9jbhwYkjPolEvIMuILUl1va
 M1z4yuNHBRyd1mYJiVQVGP/YBOfBLvg+0leqThm++WVketH4QtjvK1bPlPPqV569sfOHihjuH
 isVblV/YSUJHROUIh1CgBktIVsxV8b18K/dK5AEIm65sMjqj0azim/U49Z8PYlJHIud95NeNp
 eLpvHo2HT5syXw4eA0B6JCQFzsqsbzMAEfPbyZg1tqlFSw95enTsGhnQJBlg9F7WeVEUOc0Fr
 TBksqI02Gd6rz4ojPWCdJMEuqEBxfe5eSdFk3+AOHJstZ0BLZOY4uAuEpfnttaq23B7WFkJiP
 KpUEgWjgHUV6lQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tzxr7LbAIdq6AkjrH0g7T5ojagv2AeTxs
Content-Type: multipart/mixed; boundary="QpoKyAeJxSjSJWDeIALpSxy6COfXdiNzq";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
Message-ID: <b83d32bc-3316-735b-d64d-73ac66ad03a2@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
 <fa804a25-b0a8-ad1d-760a-bf543418970a@oracle.com>
 <4581937c-cfa1-91e2-7a83-7c3f40f02857@gmx.com>
 <A47A32AA-1457-4B98-BEB4-A9209694842E@oracle.com>
In-Reply-To: <A47A32AA-1457-4B98-BEB4-A9209694842E@oracle.com>

--QpoKyAeJxSjSJWDeIALpSxy6COfXdiNzq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/28 =E4=B8=8B=E5=8D=882:56, Anand Jain wrote:
>=20
>=20
>> On 28 Jun 2019, at 1:58 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2019/6/28 =E4=B8=8A=E5=8D=8810:47, Anand Jain wrote:
>>> On 27/6/19 10:58 PM, David Sterba wrote:
>>>> On Tue, Jun 25, 2019 at 04:24:57PM +0800, Qu Wenruo wrote:
>>>>> Ping?
>>>>>
>>>>> This patch should fix the problem of compressed extent even when
>>>>> nodatasum is set.
>>>>>
>>>>> It has been one year but we still didn't get a conclusion on where
>>>>> force_compress should behave.
>>>>
>>>> Note that pings to patches sent year ago will get lost, I noticed on=
ly
>>>> because you resent it and I remembered that we had some discussions,=

>>>> without conclusions.
>>>>
>>>>> But at least to me, NODATASUM is a strong exclusion for compress, n=
o
>>>>> matter whatever option we use, we should NEVER compress data withou=
t
>>>>> datasum/datacow.
>>>>
>>>> That's correct,=20
>>>
>>>  But I wonder what's the reason that datasum/datacow is prerequisite =
for
>>> the compression ?
>>
>> It's easy to understand the hard requirement for data COW.
>>
>> If you overwrite compressed extent, a powerloss before transaction
>> commit could easily screw up the data.
>=20
>  This scenario is even true for non compressed data, right?

Not exactly.

For non-compressed data, it's either:
1) NODATACOW (implies NODATASUM)
   Then we don't know if the new data is correct or not.
   But we still can READ it out, and let user space to determine.

2) DATACOW (no matter if it has data sum or not)
   The old data is not touched at all. So nothing but the uncommitted
   data is lost.

But for compressed NODATACOW data, it's more serious as:
We CANNOT read the data out, as the on-disk data must follow
compression schema, thus even we only overwrite the beginning 4K of a
16K compressed 128K uncompressed extent, the whole 128K extent can't be
read out.

So it's way more serious than non-compressed extent.

>=20
>> Furthermore, what will happen if you're overwriting a 16K data extent
>> while its original compressed size is only 4K, while the new data afte=
r
>> compression is 8K?
>=20
>  Sorry I can=E2=80=99t think of any limitation, any idea?

We don't know how the compressed extent size is until we compress it.

So how do you know whether we should CoW or not at the delalloc time if
we allow overwrite compressed extent?

>=20
>> For checksum, I'd say it's not as a hard requirement as data cow, but
>> still a very preferred one.
>>
>> Since compressed data corruption could cause more problem, e.g. one bi=
t
>> corruption can cause the whole extent to be corrupted, it's highly
>> recommended to have checksum to protect them.
>=20
>  Isn=E2=80=99t it true that compression boundary/granularity is an exte=
nt,
>  so the corrupted extent remains corrupted the same way after the
>  decompress,

For corrupted compressed extent, it may not pass decompress.

> and corruption won=E2=80=99t perpetuate to the other extents
>  in the file. But can a non-impending corruption due to external
>  factors be the reason for datasum perrequisite? it can=E2=80=99t be IM=
O.

The corruption boundary is the WHOLE extent, not just where the
corruption is.
That's the point, and that's why it's more serious than plaintext extent
corruption, and why checksum is highly recommended.

Thanks,
Qu

>=20
> Thanks, Anand
>=20
>> Thanks,
>> Qu
>>>
>>> Thanks, Anand
>>>
>>>> but the way you fix it is IMO not right. This was also
>>>> noticed by Nikolay, that there are 2 locations that call
>>>> inode_need_compress but with different semantics.
>>>>
>>>> One is the decision if compression applies at all, and the second on=
e
>>>> when that's certain it's compression, to do it or not based on the
>>>> status decision of eg. heuristics.
>>>>
>>>
>>
>=20


--QpoKyAeJxSjSJWDeIALpSxy6COfXdiNzq--

--tzxr7LbAIdq6AkjrH0g7T5ojagv2AeTxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0VvRUACgkQwj2R86El
/qiGhAf+NjqmHBD/qtniZ5f3IdAf7YVUaBaoJFnWkl3Yr13z80gV92MK8lk+UWSk
jNQoRhnGMcOkIWonDfe5NgNj64ATbtoQbD6TNwDbE2li/h46fYVDdkahXAXLpYSS
P4jBkC4/zwSOVDLMegW6AwuTOBj2i+d1FeMw+S+bojJT6+A9ZS1JH6qUvpnC6Hhh
2DaZGLaIa/8F5cr6BD5S5/x9PxSIr/u6Ww/NwnhKtAZcSkY9lRsRoh3x30aI/1Pv
4LJDvXNMkj/DZGRUMEZqRWJA6D5f03Lfe2dcRiqWsGuvTnNyxOUqbAjt4dTtzcq8
xedgFTmyuhGRaHx95ZdNcHJGmAcMgA==
=E02c
-----END PGP SIGNATURE-----

--tzxr7LbAIdq6AkjrH0g7T5ojagv2AeTxs--
