Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207225BC45
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfGAM7C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 08:59:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:37517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbfGAM7B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 08:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561985902;
        bh=y5EQ8Knwa4Z6JBRC6epoeFAxYLXtxjIrDwkz6hYWIQw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IyT9Dcdigh9N6KE23cCJhcWWQ4NQd1IwqLUpNI0QISeMIGg6mIELjECufJKxSaE4D
         oHa7DJjj/ammtorVszY1e9IRaJqYJYosgv+ItDjOkThBtogjldKQ5Do5CTWxiVWvhW
         z9+t73RpH7kMlK6BnZtePdf9lS2RORYFo82J2LNU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9Mtg-1ieUW118ei-015KZs; Mon, 01
 Jul 2019 14:58:22 +0200
Subject: Re: What are the maintenance recommendation ?
To:     Pierre Couderc <pierre@couderc.eu>, linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <f9ceb3c8-b557-16d6-3f21-f2de34dfae9c@couderc.eu>
 <2798e32e-92cb-529e-e0bc-8e79a3a5ff69@gmx.com>
 <eb1cf0e4-4e63-5e8d-4040-2f3e42cac774@couderc.eu>
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
Message-ID: <bf988ea6-9031-3f4c-c6e2-9d9f5a8dcee1@gmx.com>
Date:   Mon, 1 Jul 2019 20:58:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <eb1cf0e4-4e63-5e8d-4040-2f3e42cac774@couderc.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fTJYlSb3gUgljb7HyZ9hTpgU3OG8PFdlv"
X-Provags-ID: V03:K1:Jnh05o/5p7poTL0yOet+JIgid8cFouyQDJ7xBM+M83wp6FDscyn
 6EKG4LzwaotE/0lxRpUSCUnAM69ZPXt/vPfhBbxbCcXWZm6NYgG8HPiqC1RHi89LHwCffbJ
 Ue5zVvNlvLL8VzM4FdyhPuNLibuoL+7aGFYmzuL5fTy2egDMKXSstyL8Zs+QVnPmqo7Gan+
 CxmkcUwBs4IO+jYDZhQBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f4tMBmq0PRQ=:nnYFCnSpcTsPUecU7fNJqJ
 tSneQGeWIr6Aq+A7DcHEy3bgcA8DT3G1U98EHJlN8CqYTZULEQIFFqMRcaOWISmirzn9g5utM
 sq1Cf3bNKT+tKpRmUmwEPyLlxU1iRFwfLzyNxP65XhJKdX+Q1J/MhwvaJdv5Ry8IMVBpnHgCA
 yBtoqB0lvUEZBWyfHNbwhrM57TiAMbpFENH2jdHgGhgkFhdYtiLmzPeYJIBxUWdMOCots31Nc
 5Vsutyi8kcUjz3I34RnohP4FZuhujjHxuNNeCQDN8d00AB2YrdgWLxORVWgHIEbvfr1jI7ckj
 ocb8+QSJCYlwHosVEFz3y5wEgjWNLYorl/N+NIa18pWiLCnzwLpjG6S1JfFi7bgDRAfnz7agH
 R+kibZgPfur9WlApWWCwGL/d8Tr6Mz3T8rFInLPlInVpZvdBkclKAGdRjrtrEvELgX6WJMydf
 NF0ITc0gKd4l32fR1KBxrdzahNMPzDQ2c+iWZBs3r6mAWISdHAb0jFpzAS/CsdKpDu49C0kR7
 HkLsvAP5v1oOwElhhy32CKbJwdTn/Ha2ZrQ9/sguxOMCkwwGfJNgFQ0iNp1LyMc+HzqVsIy9r
 yYkT9cXlh/+e6V6URrFw9DVFNCyghTYzlxtj3C+3JMJLRBbIO7NexTSIuuuiDzZ9koIqUlp06
 jR/fmVNotfjT5byJySM698vHuoX0ehFtDKwR3osDi179BzpaXrkBAnwA+8mmECTFpkkEk1UFf
 yTVJwRDAuVkijUugZSFN6Xm1Cvaqrzw3XD7+AD81ysVoQz5KsF1Uc/gvv/Fic5Ldx3+svTNpn
 /px5sn3HkO1bPT4QMvtnLt08HJUsI64FuHPA46v6SU+/MTX+EQwXshd/ATYU24Wf+Uj/eO5yL
 sOncEnvLpq7mfAs9LncnsyQ1Uh6KBzjXOyt5CCR3PEHVRc6XpAzb1f8KFws84PX7aZUnZpAZR
 9xB/47CEf/ryumAMRIWpysrLgxZrA6S1x+EB2vgkfwu/iAfQV8yFGhr3GzXoJXmSWrJYFwd+r
 rL6uA14vZ0n/6h6UBPOr5g6ZYk6zIWn3BCqWH7DowXNzjoiLXtxEU0+QTVqFYncloPqyJqO5a
 wPSDVQLxPXogcw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fTJYlSb3gUgljb7HyZ9hTpgU3OG8PFdlv
Content-Type: multipart/mixed; boundary="EYvKFbce5tUUjsgXIgy2olVYwfVNuSDm1";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Pierre Couderc <pierre@couderc.eu>, linux-btrfs@vger.kernel.org,
 Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Message-ID: <bf988ea6-9031-3f4c-c6e2-9d9f5a8dcee1@gmx.com>
Subject: Re: What are the maintenance recommendation ?
References: <f9ceb3c8-b557-16d6-3f21-f2de34dfae9c@couderc.eu>
 <2798e32e-92cb-529e-e0bc-8e79a3a5ff69@gmx.com>
 <eb1cf0e4-4e63-5e8d-4040-2f3e42cac774@couderc.eu>
In-Reply-To: <eb1cf0e4-4e63-5e8d-4040-2f3e42cac774@couderc.eu>

--EYvKFbce5tUUjsgXIgy2olVYwfVNuSDm1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/1 =E4=B8=8B=E5=8D=887:11, Pierre Couderc wrote:
>=20
> On 6/30/19 9:20 AM, Qu Wenruo wrote:
>>
>> On 2019/6/30 =E4=B8=8A=E5=8D=882:50, Pierre Couderc wrote:
>>> 1- Is there a summary of btrfs recommendations for maintenance ?
>>>
>>> I have read somewhere that=C2=A0 a monthly=C2=A0 btrfs scrub is recom=
mended. Is
>>> there somewhere a reference,=C2=A0 an "official" (or not...) guide of=
 all
>>> that=C2=A0 is recommended ?
>> I'd say scrub can tell you how bad your disks are.
>> But at least, I'd recommend to do an offline check (btrfs check) and a=

>> scrub after every unclean shutdown.
> OK, thank you !
>>
>> For the maintenance recommends, Zygo Blaxell should has a pretty good
>> ideas on this topic.
> Is there some link to these "ideas"...?
>>> I am lost in the wiki...
>>>
>>> 2- Is there a repair guide ? I see all these commands restore, scrub,=

>>> rescue. Is there a guide of what to do when a disk has some errors ? =
The
>>> man does not say when use some command...
>> If you're doing scrub routinely, it should give your a more reliable
>> early warning than SMART.
>>
>> Normally for bad disk(s), you could replace them in advance. E.g when
>> the disk begins to have unrecoverable errors suddenly, it is a good ti=
me
                           ^^^ recoverable

>> to replace it.
>>
>> If it's too late that the fs can't be mounted any more, my recommends
>> are:
>> 1. btrfs check --readonly and save the output
>> =C2=A0=C2=A0=C2=A0 Sent the output to the mail list for help. The mail=
 list will provide
>> =C2=A0=C2=A0=C2=A0 much detailed solution to recover.
>>
>> 2. try to mount the fs RO and save the output
>> =C2=A0=C2=A0=C2=A0 Just like step 1.
>>
>> 3. Btrfs-restore if you have enough space
>> =C2=A0=C2=A0=C2=A0 The only generic and easy to use way to salvage dat=
a.
>>
>> The following methods are only for guys with some btrfs internal
>> knowledge:
>> - mount with usebackroot option
>> - btrfs-find-root paired with btrfs check --chunk-root/--tree-root
>> =C2=A0=C2=A0 Both methods are mostly the same, trying to use old roots=
=2E
>> =C2=A0=C2=A0 Not reliable.
>> - experimental kernel patches to skip extent tree at mount time
>> =C2=A0=C2=A0 Kernel equivalent for btrfs-restore. Needs to recompile a=
t least btrfs
>> =C2=A0=C2=A0 kernel module. Only works for extent tree related corrupt=
ion.
>>
> Thank you, I note that

Although I hope you never need any of these recovery steps.

Thanks,
Qu


--EYvKFbce5tUUjsgXIgy2olVYwfVNuSDm1--

--fTJYlSb3gUgljb7HyZ9hTpgU3OG8PFdlv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0aA2gACgkQwj2R86El
/qjnBgf9FWpKQY3EOwd3LIO2UMt2GIlKMnKiliolJJiC20tlCLZ0Gd5uP+YknFw7
ZzOWjf/s6+QoQe4H7xi+Jpf0SgX2rP2ZX/d+1VAtmBFw6pW/To0/PGd12wUX20/c
m+u/3F+uD17Mt0lZwR3fs6NYponUG03W88GUIxe/lKg9RWhfI7rRCsg/UxW8N1jP
wFqyMXgHUiB/Op8Aenw4+LdF7g5t+wuMPEzjD2nQqJjfnNKtmVieeMiIS4MB+gmC
tFUu2Zv9k12Dg5+6BADRQR5EnkUyrHFzt3YRAwvdXc1rYda2Lh5q6pYXK60HjUEy
7ayG8Tqq29mCTDWUlXtJR+qr9rpVYw==
=dO1a
-----END PGP SIGNATURE-----

--fTJYlSb3gUgljb7HyZ9hTpgU3OG8PFdlv--
