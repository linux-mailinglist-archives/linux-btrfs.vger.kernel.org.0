Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABDFC2094
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfI3M2N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 08:28:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:45429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfI3M2M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 08:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569846490;
        bh=674NZGtWpW/UI5jBhKtTbf6lK7q3LDB5JWfy3tT/gKY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SdxG1PmVAAPVceXeM/Do3T2aqjIw4HDoSXgb2Xv1Eip8BA6Tmx6QtZuHV7Gg45MAJ
         ixXkzPBzRt+tgRCbpZUtaqFFu3XkkXvpJaVB5dyqi0IuTtjF3VJ8RR00p3k2PthTmc
         /726KeEMemjTSXKiNO/HYWyHfyCwC/JJ4Cq3p1BU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkYXm-1hsCUh1kOk-00m7DL; Mon, 30
 Sep 2019 14:28:10 +0200
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
 <c9d71bdd-7fe2-faaf-23c0-ede163c1d04a@gmx.com>
 <c3ecfeb9-2900-3406-4d92-e40021753310@yandex.ru>
 <1ca0434b-3ae6-bbbe-efd3-06cab9089782@gmx.com>
 <fb259ee2-c9e2-f44d-ce5b-b3f688565c28@yandex.ru>
 <bf5265b7-96a1-5f98-07f8-947b981ac364@gmx.com>
 <245b13f7-20c9-3ab4-6e9f-0ed32f4d1c79@gmx.com>
 <27515deb-5225-4349-2406-132b5190f7cb@yandex.ru>
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
Message-ID: <84e7ff9e-9c47-41c5-8457-bba4d9ec1f86@gmx.com>
Date:   Mon, 30 Sep 2019 20:27:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <27515deb-5225-4349-2406-132b5190f7cb@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oor3YwBQ4Ai41L6RcRSI1fhtYDRCvCua8"
X-Provags-ID: V03:K1:UKUTTkyFE77FY1VF+hE73ToUF76nxkdQVt9sJee3ZqMMoChn9IQ
 5PZBjcRemsX6NeoQoHnVHIzyee7SnV00S1bVSFuHmPymd6SoSPPie9Vjre05naINNXGDay4
 MtrvgS76gWd26Uuye1SyYS1CgMsYSKEnRJvP+ouNMECni9HWIzdbSXDXy9AX//9tnOro+uI
 niNZsq0VcWj0eg+3SIyVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fwn7MpAC7+k=:ho2wsyrI33WPxhw3gPyG67
 qBkWYxm5ULgaHx46s5AoI41WQ22UgxBbnhXMsGuQPr4eh8Iu6j/A1TbQEppHfF2CwXUnLRQ6i
 45zFDiiSFE8qNruky5IThz3lrgupHgmdIAHCGWvJxQGt1DKAssP7yF7izfvMp62hi2xudmuq1
 K9DIGlVozTn8VefhOr3fOKfpBjsiYPryYbLm+nS7+cYaHhK3GCskB2dP328FIKcH9Xhu1M868
 iNpGCuRpI8LzhL4TkDior/t3gPq+lKkAiJz23KwH78MY8rVGAY31IXsmW74zd15nwmNqR9pTy
 GzksFaUB/q9P0WcohQGLm/62QJj2DQ7BbH+vw6OnUUzpVNVoSWp+S0yLWdP2FnW13/nqj2KOD
 M7ViDJO2E4XE+AzFwSAa2b7IXy7w3j/j5g7O+Y0eTPXoyHp3hVq7g2XvWF6O/BI/lkxOl5O1L
 DRQ+uJcDE7TSqDIQQQqFVyamxlL2pJi3q0aHUJdUo1TYCOqm94XLiguli8wvkQLr2/iDleS3u
 6Pk4ADww9H23VsmlmH82CFmgBe00nL/S3Xm122BhetaoIo6gfaoWwL/fJWumzAL1zs5Q4WRLl
 FC7LYqq5SNvCWuzcjDMhQWL2Pgxwcgf4e867o4Y9ClV2Kyoubqp6SpvYPKz3T14Y5ftYQcrjs
 RY5iUAMDukMoX2BFJSpXUIWWpqOqNnQBQBOtUvBtwhQl+DzCmKnFtqjYSLc6ep9SYXw+yxepd
 AFejQUYjkglzkJ4gTl3G7pq4Uhsez+KfvvBF7hlYHD5Avd8iWjVH4O9AFIVpqVUrCKglkdJRI
 swCHcK6a5PvrhqS2bWGk6hB0+/sBj0MrVmkpo36BVVMHi4AQBVzm4dqnqDfN8TotDoTvyp5B3
 MB87sXLuBKcJEox63Rz5C3Z/1jFlllnW96s7msR0QaShhqcTzbG+4Pn0Ee32CgH2PpYKs5TkI
 igUNpehA1emQRmvy8n2skLXxnbPlwWVY1PbXUALDtNYReo0R/z26yGPUFbdROxKIdjk7Tt63s
 8CbQ3/Jd4Wf+R/3IuRTylUumN2xX4KIwIWV2m0EyhuJWS61rMldsfu0Gusl8DbhMeGIOXFpWL
 n+h9mTUw/L3fMVsXwHbW6fPlxvimfA/X/xam2uB4hQN/KbGTpp2Pag8sUHXOaken5BRn3ftz7
 OHvkh4jIV++o8BUoD38iMayAFNNZ2tTIOGr1bt0OW+HF5B9lHDA0UeDXzOUYpRBP5JZavHYXs
 etXCVH5egXS/xMiha/PbjkQxcjrSDkyCFBhyO9mg0qYsJKLthUiaE3IzXLJA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oor3YwBQ4Ai41L6RcRSI1fhtYDRCvCua8
Content-Type: multipart/mixed; boundary="fkHKEKGNfYNprjFgZC520XBuNeDvd2NJt"

--fkHKEKGNfYNprjFgZC520XBuNeDvd2NJt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8B=E5=8D=888:10, Andrey Ivanov wrote:
>>
>> We have another report internally about a similar corruption (multiple=

>> bit flips in a single fs), and they are also using VMware, along with
>> VMware guest kernel modules.
>>
>> Would you mind to migrate to KVM based hypervisor to see if the
>> corruption happens again?
>=20
> I had this problem with btrfs after more than a year of using btrfs and=

> vmware.

So it looks like some regression, although still not sure who is to blame=
=2E

But anyway, I'll add more asserts for those obvious members which should
never exceed 64K, to either to make sure it's not btrfs, or to confirm
it's us to be blamed.

Thanks,
Qu

> If I switch to KVM based hypervisor, then I am not sure that this
> problem will occur again
> in a short period of time.
> I used virtualbox earlier, but switched to vmware because virtualbox ha=
s
> slow graphics.


--fkHKEKGNfYNprjFgZC520XBuNeDvd2NJt--

--oor3YwBQ4Ai41L6RcRSI1fhtYDRCvCua8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2R9McACgkQwj2R86El
/qiMDggAkyBSs26XEKHRrFds3mI4JFe7b8ZsHdlXPlveTr22G51Id4XD14MaK4KR
ty7ZWmjRbpkgsLKtnf9sD88cNR1kIoSTIcBHNPc0MufqfzwyAqnFAU/z5hr4oWmB
UHrk9+l9CQ7eq9nEVBEg3jmn01oI12APVJc47RegRQImRpvfal64YdK52cgfEbtQ
9uRnW/kSPT6K7mmcl39S1p/hGDss6v6Pxp3I6XgYOz8pDRADcO6ZfxIF7YZCDpp8
kG4M+b0qPGJRVzkrsRkxgPbIlQOa1ddVKbl7TfhGrPhpXkkWfR0qoIqgk+4imD9d
BDasCKZW7z7mQlO95PC3DKyiJUzuVA==
=x7qL
-----END PGP SIGNATURE-----

--oor3YwBQ4Ai41L6RcRSI1fhtYDRCvCua8--
