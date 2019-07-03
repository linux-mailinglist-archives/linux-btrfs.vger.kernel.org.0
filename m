Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF385DDAF
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 07:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfGCFJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 01:09:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:41023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfGCFJp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jul 2019 01:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562130580;
        bh=6E7g09QwMLIGpOMEUPHvXTo+pr4s2iVXIlQKPQTXWYQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=b6I7RLI/MjwgvMerlQc/aeJVSS43hv2dvIn889aBqmhsr0WWzMyQISYGp3pOlxAKg
         EzH20N9FnsDm3StzshrYwbRRnWMAc26ZH/n0KN4XNHWqbcOppSsaKbVnVfjcENnzX7
         dwmmJa+bNg2FnBJNTVByt4FS8uTkRVMo5fjpx9JU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Lt1eU-1igeQz2e5a-012V3f; Wed, 03
 Jul 2019 07:09:40 +0200
Subject: Re: Spurious "ghost" "parent transid verify failed" messages on
 5.0.21 - with call traces
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20190312040024.GI9995@hungrycats.org>
 <20190403144716.GA15312@hungrycats.org>
 <20190701033925.GH11831@hungrycats.org>
 <eb60e397-6e33-b73c-e845-a4498952601d@gmx.com>
 <20190703043253.GI11831@hungrycats.org>
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
Message-ID: <02f9e8b8-0ff9-6dc1-712f-68afdc33d74a@gmx.com>
Date:   Wed, 3 Jul 2019 13:09:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703043253.GI11831@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="prEipx6Dfdss9VcE38rCR2KitAWiudSNt"
X-Provags-ID: V03:K1:+OflnFEdxaYipcnpFY7SU5DVzBaDWqgGCD77OkUY1rgkb3H1Cm1
 XlimDWFtdg0iMH0eq1nuWwbhFtuEFcNl2nvEMn6JEGGFtbMusiwqFcDI4gRwPsMSEdk8wC3
 Fpg9qzl1rCViggT2mFY5ad26t4kCsjm4jj8DsMVzZWQ9NRFxtmCoSI4h7GLR+f9A2109f8z
 6TzI1V1JRmpw9Sk6UlksQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1jt9XpuOveg=:5Qk0vXlwvWx9/eUQcxLxnI
 kOO0C5Md7/4XpWvgnOz9Tk2sljug0ILjIgfbWJDcjyy2sVvCbza5yHvNHK/EhmzTR33q7JROR
 oOP0NjcBOKfBJZ7+s8NJn9+gnT+vPRu6gyNYU0YaDJT2Y0ffMwbHHj9KenuCeojFpL59pwvFe
 8UlABG4fD5fx/zxSS5T+JthPsGvcLYAKNKqOZu9Y+6rCVzqizocR/eBHQ1doqDRuhbF9AbIq+
 bwErFOXxuLY3ZuNpqHgv0hroVom3KlPV4tqhasygGWEMZKevU0lMPCZbMKr/15+O9mygFjczz
 9f+NpS64ToUCrs6syqmhcFjt0oM1RXW7bXh7g9O9XHvmeXa26K5YaCkK8qoeSoR5BNUHFmVrU
 rWBYuhJLasgsmtzNs3i3ArwPERjpC/U9VIBK+8kiPengRN43dMHnlcYNS4e55dSQ2xSthT/Bt
 4iouysXOi1JHJzbu5qZ2u+bUjWKcuzEMyR93tWrQGFt9M0hr36saabkEjXZq5pBlnE1Zi3HvI
 6PSnuhjfMBfI+Ld3+coYU33skNH7qzEKKXzYn/P+WD7ZlPf7IWye9uFoQ89cOBVDqyI/6pfWQ
 18I4fldciOzJP9lsKHgp3ef7oPvWs75SFEZhtt+odnbCwJXBDJrQW5OelcLIbuKMP5bSMm3kt
 pxXiBIA+jGfHAgjeRgICTyr9my4P02gbrapb+MKzyrICH5Ft5c1J72uRvwXtg6UPnJU4k9T9A
 32Tcf6+QTSPhQN4iQQlQpoYZbXxFsQxFFG5ro1btf7VMlehhBp0GDgYobFQwmOhsHvNfrWHcs
 9wkJCFgpAQ8o01tXTAeEKby/szyxgDGlufDZSNeyUjvt8hKWML6akfjk3q/wdC2xmCpMJJt3J
 PnGDtH6tiw+yIk0Nwd49k/jFj3vjITdw214eJo13ovAA7tIGDKD2vMMZUeRYdcnN1/EYS7G3P
 SvvWunRiWC/sAycFbexVj/2XL++NGSyDjpVr75OyKb1rPuTqOAMbYlHMYJSNqKZ1GehkYjx71
 9Q8w8uacjgp7PEkUggnipUM/SFnNcnbi/ircey22bKOyX0G2S0tZjRbbGPR2+J+APPgHX3puW
 OZX6TwxAwEpxgc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--prEipx6Dfdss9VcE38rCR2KitAWiudSNt
Content-Type: multipart/mixed; boundary="Yad6e1jJblO54H14CD1HL37iDVsbQxwWL";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <02f9e8b8-0ff9-6dc1-712f-68afdc33d74a@gmx.com>
Subject: Re: Spurious "ghost" "parent transid verify failed" messages on
 5.0.21 - with call traces
References: <20190312040024.GI9995@hungrycats.org>
 <20190403144716.GA15312@hungrycats.org>
 <20190701033925.GH11831@hungrycats.org>
 <eb60e397-6e33-b73c-e845-a4498952601d@gmx.com>
 <20190703043253.GI11831@hungrycats.org>
In-Reply-To: <20190703043253.GI11831@hungrycats.org>

--Yad6e1jJblO54H14CD1HL37iDVsbQxwWL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/3 =E4=B8=8B=E5=8D=8812:32, Zygo Blaxell wrote:
> On Mon, Jul 01, 2019 at 01:56:08PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/7/1 =E4=B8=8A=E5=8D=8811:39, Zygo Blaxell wrote:
>>> On Wed, Apr 03, 2019 at 10:47:16AM -0400, Zygo Blaxell wrote:
>>>> On Tue, Mar 12, 2019 at 12:00:25AM -0400, Zygo Blaxell wrote:
>>>>> On 4.14.x and 4.20.14 kernels (probably all the ones in between too=
,
>>>>> but I haven't tested those), I get what I call "ghost parent transi=
d
>>>>> verify failed" errors.  Here's an unedited recent example from dmes=
g:
>>>>>
>>>>> 	[16180.649285] BTRFS error (device dm-3): parent transid verify fa=
iled on 1218181971968 wanted 9698 found 9744
>>>>
>>>> These happen much less often on 5.0.x, but they still happen from ti=
me
>>>> to time.
>>>
>>> I put this patch in 5.0.21:
>>>
>>> 	commit 5abbed1af5570f1317f31736e3862e8b7df1ca8b
>>> 	Author: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
>>> 	Date:   Sat May 18 17:48:59 2019 -0400
>>>
>>> 	    btrfs: get a call trace when we hit ghost parent transid verify =
failures
>>>
>>> 	diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> 	index 6fe9197f6ee4..ed961d2915a1 100644
>>> 	--- a/fs/btrfs/disk-io.c
>>> 	+++ b/fs/btrfs/disk-io.c
>>> 	@@ -356,6 +356,7 @@ static int verify_parent_transid(struct extent_i=
o_tree *io_tree,
>>> 			"parent transid verify failed on %llu wanted %llu found %llu",
>>> 				eb->start,
>>> 				parent_transid, btrfs_header_generation(eb));
>>> 	+               WARN_ON(1);
>>> 		ret =3D 1;
>>> 	=20
>>> 		/*
>>>
>>> and eventually (six weeks later!) got another reproduction of this bu=
g
>>> on 5.0.21:
>>>
>> [snip]
>>>
>>> which confirms the event comes from the LOGICAL_INO ioctl, at least.
>>> I had suspected that before based on timing and event log correlation=
s,
>>> but now I have stack traces.
>>>
>>> It looks like insufficient locking, i.e. the eb got modified while
>>> LOGICAL_INO was looking at it.
>>
>> For this case, a quick dirty fix would be try to joining a transaction=

>> (if the fs is not RO) and hold the trans handler to block current
>> transaction from being committed.
>=20
> Do you mean, revert "bfc61c36260c Btrfs: do not start a transaction at
> iterate_extent_inodes()"?  Or something else?
>=20
> I've had the spurious parent transid verify failures since at least 4.1=
4,
> years before that patch.

I mean even longer trans protection.

E.g. start a trans just before calling iterate_inodes_from_logical(),
and end it after iterate_inodes_from_logical() call.

Thanks,
Qu
>=20
>> This is definitely going to impact performance but at least should avo=
id
>> such transid mismatch call.
>>
>> In theory it should also affect any backref lookup not protected, like=

>> subvolume aware defrag.
>>
>> Thanks,
>> Qu
>>
>>>
>>> As usual for the "ghost" parent transid verify failure, there's no
>>> persistent failure, no error reported to applications, and error coun=
ts
>>> in 'btrfs dev stats' are not incremented.
>>>
>>
>=20
>=20
>=20


--Yad6e1jJblO54H14CD1HL37iDVsbQxwWL--

--prEipx6Dfdss9VcE38rCR2KitAWiudSNt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0cOI8ACgkQwj2R86El
/qh7qgf6Am+oReGCLRnApXpDmkoRxIK/hw/rGiNsxBKYbzx79+SzGquBJmK9udA0
sToXEbZf+EB9DYrUP08jOfxuYGB8WXNR9Nepf/yqKE5pi0gt63OSGDqM52jBzNsp
GEqyDv+c3r2C1SGy+orlHdvwy2qJgMQHcmMlLp+awEAuh+8qNDM2E1zXXvQy4X0k
sAkiDb0pAyMY5mCwbm3bSsFfQrr2Zf2jP/5kTbjnkjt3CgACrfECZvO8rC6VfC1F
hwmtmB0BooB9f+XAij4b0fuJzWWuNVvkI+VCRRz0blZyNDWsttHKfzdRRkWUZYXi
5qlxM385zlAwTSsBQa54PefQGtfHFw==
=Oda0
-----END PGP SIGNATURE-----

--prEipx6Dfdss9VcE38rCR2KitAWiudSNt--
