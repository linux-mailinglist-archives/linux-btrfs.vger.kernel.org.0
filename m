Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5E720777
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfEPNAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 09:00:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:33033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfEPNAx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 09:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558011644;
        bh=thkIS7/Wk8UaY/vWXwQOQUPbtfWxOhd6iUcJTUQQenU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UIMX+7YhDu7FxdxSAMOv7rxWRa0ggEKuw5F5MdBMqQGxQsjz/Ox5RQfGV+qkFzn/A
         PJ0UEM7jwbcIRxG6C4bJ6IhiNCTi6lCZi9iZybLTYloR1wnMiCdudcP9zSVgIKbpFA
         /YURkJ9ND3OyOPr7tsQumDbeWM98wMchnXbXa2vQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MQMBU-1hF6tL0RKe-00Thoi; Thu, 16
 May 2019 15:00:44 +0200
Subject: Re: [PATCH] btrfs: tree-checker: Check if the file extent end
 overflow
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190503003054.9346-1-wqu@suse.com>
 <20190516125746.GZ3138@twin.jikos.cz>
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
Message-ID: <96732254-c551-0613-ed10-42b25da1a0db@gmx.com>
Date:   Thu, 16 May 2019 21:00:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516125746.GZ3138@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WAN21CjJN2ARqnHeIBAZwNrdtkPgzttNY"
X-Provags-ID: V03:K1:shEgZnJzYFaM0LRivz/QVrkrQeeL4g9oc+GpVw5Chp52msim1w8
 yl6ptTaCl0xI+0+t2yHUScINhNA+AY3YXbGbYs6+Chy/chZDkygF9lTVcBXCkXG6y2owTd9
 zN0nWbx7E4BnHwUxAkQOYTm3Dz8j0ULWLhjD+zqyrWC6UFuo6ptowbs6caf01yXZPSLvs8O
 r0OFcI35+u5VCiLks8prA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gubls4NUS5s=:wcZ8i7quROkjrHtYI+I16b
 leTBJErA0n68+28aHEmbLN+gPpz3XadyqTFrHs5E8H8pg81GQ/K3gHg47+gO9JegRtOcHW3Fv
 Kzialp8+9xtgP21AoVi8ugHyXAmeiBmbeqIVR79bT9KsfgSNQb97xnSXtlBqnYBkw3eWBKeqY
 An1boKawI1updOgr3mSupXnNoeP0YRFNwz2N/S8+vtYVnvd4pgvBrEprWdthezsCYhsPZroAG
 aRLuQ+1sYB1j2Z/wuc4U4nQtORTXh6hTHNmziTyJIaoMX1UgLFkQ2ibMb64sXLOc4TDbZjlpO
 fWrUJq1EduclJqPlsxHicrvdsUUKiBIA85XoeCJApQ3/XJT2fT4PacgDyxXYNR5VLqBLZrW9X
 8pIKxysBoIooB4QaQJEwcKwbBlk9rwouHOsBynl4385BmRj/Gbt9MnC+kU2uc0k9NNVTWL/0Y
 jYViIGub8P9cXMnY1SWl8KQ8KgPvC06w8CE5lOzgGk7Sa078/+D9Epn0+UZl4Hy9YzJ40IztQ
 s/UZRsjS3IvcinrCUBJfhkZ7EV+9r+h1K1DHiIAtoaEyKz0+xZtc+VC0wIphM+ADwdQ61nBll
 vP9ri1Udijbl4suzGNuZIEQMc/iuyFtaOTk62PIysc+i6BBtRaV579ly1MfjfM3ncMxgqCz8O
 0FD7ckuy05ejSByXQTOw3fAeZFvu4BO7hfWIpMVOq1EJ/pRs+j4iBa8yY1dTFCBBcZqV1LXbD
 9J7bpcUnt7BaiGQBFU2RVr2cMBRzklnLmq14iexZ2VYXzUa8vu8NBE8LY7+2XYH50Of1IlMZ2
 GVeSs7vJ7G+2Aj4RSKg0sZj9jQi/iuyRGxtmneMioncKf4FCXMyE8CWZBjMT2du6OicVXj9Sf
 YtctG037zLaJm8b18VFPK9U9oAEjYxi4RKNC5Lv6ZOoa7fcPuON92HMR/RwDRTzyTKZdsXXm5
 GBMp/paoy1wU5CkPgD9IsHs+Mh35k2CQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WAN21CjJN2ARqnHeIBAZwNrdtkPgzttNY
Content-Type: multipart/mixed; boundary="9FVvhzyokevfn36A0UwmmL1p4IDV3AEEC";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <96732254-c551-0613-ed10-42b25da1a0db@gmx.com>
Subject: Re: [PATCH] btrfs: tree-checker: Check if the file extent end
 overflow
References: <20190503003054.9346-1-wqu@suse.com>
 <20190516125746.GZ3138@twin.jikos.cz>
In-Reply-To: <20190516125746.GZ3138@twin.jikos.cz>

--9FVvhzyokevfn36A0UwmmL1p4IDV3AEEC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/16 =E4=B8=8B=E5=8D=888:57, David Sterba wrote:
> On Fri, May 03, 2019 at 08:30:54AM +0800, Qu Wenruo wrote:
>> Under certain condition, we could have strange file extent item in log=

>> tree like:
>>
>>   item 18 key (69599 108 397312) itemoff 15208 itemsize 53
>> 	extent data disk bytenr 0 nr 0
>> 	extent data offset 0 nr 18446744073709547520 ram 18446744073709547520=

>>
>> The num_bytes and ram_bytes part overflow.
>>
>> For num_bytes part, we can detect such overflow along with file offset=

>> (key->offset), as file_offset + num_bytes should never go beyond u64
>> max.
>>
>> For ram_bytes part, it's about the decompressed size of the extent, no=
t
>> directly related to the size.
>> In theory is OK to have super large value, and put extra
>> limitation on ram bytes may cause unexpected false alert.
>>
>> So in tree-checker, we only check if the file offset and num bytes
>> overflow.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> So this patch can be dropped because of "Btrfs: tree-checker: detect
> file extent items with overlapping ranges", right?
>=20
Nope, there is still a case can be detected by this patch only.

If the last file extent overflow, that patch can not detect it.

Although that patch has a much better coverage than this one.

Thanks,
Qu


--9FVvhzyokevfn36A0UwmmL1p4IDV3AEEC--

--WAN21CjJN2ARqnHeIBAZwNrdtkPgzttNY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzdXvMACgkQwj2R86El
/qjLaggAqylEFndjQ8La86yWHsY+K/HRom4CrPCwRWtEr6AL3Kir0bsBeZ5OQsOb
WD9v+GopWCikhUNpgpZe0RGWiGQer8apmfcTShcOtSyxmhad6kHRXHf0yR74HIx7
a8q6qub1of23TUqu2OR9oSfdqyKhnTMACkLhjFe6kSLBRmlD+6iFWtUj53VlqtYr
DN8GV2vIhHn6AG09EnCfFRe216e5whknOhUcnIe3EWwCh8Zitx0PyRL4Qo9dTy17
t62ItJGLxGz6dDp68bTUOUtBtW4E15Lf9pLHs9b6C490vCInRqTqk9KZ0CcJ9nkl
HOg64PnkJJ2B0KnhlRvHAdbPSwq9Fw==
=fv8B
-----END PGP SIGNATURE-----

--WAN21CjJN2ARqnHeIBAZwNrdtkPgzttNY--
