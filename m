Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7FD242B20
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 16:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHLOPf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 10:15:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:56929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgHLOPe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 10:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597241729;
        bh=OSg1vFizsePTtzkunRjQJSkgWl06YZS1ky8v+3OGNGs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EdUdBSorwRzrHpY6XE//q/m3kplJJsXh6LcGz3rQfiGI035/7FfcJpG0bvQWH5GXM
         QM1/gigj4wWK94fcnioHcF5PmiOsrdMIUOCieKY+oUBuG6hoDlq0BxYYhkK0gijQUt
         WaNnql1xcIyPfKKNkCig6je+Vuo7UyP5zM+UYh+s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCbB-1k9rm523Un-00V6z7; Wed, 12
 Aug 2020 16:15:29 +0200
Subject: Re: Write time tree block corruption detected
To:     Spencer Collyer <spencer@lasermount.plus.com>,
        linux-btrfs@vger.kernel.org
References: <20200812144915.488db4c7@lasermount.plus.com>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <b8fefd9f-3f95-1d81-95f6-f1424640052d@gmx.com>
Date:   Wed, 12 Aug 2020 22:15:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812144915.488db4c7@lasermount.plus.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EuSGyY0hrpePdC20bidgjCmtWlGmSK0g0"
X-Provags-ID: V03:K1:kSjUR3xVe0ote67YYDV0XPVG/hNfLQgtaUiEfkp87LBW0ZbGYCs
 cT+otkiqZiz6Nth4lIrq+vzW3iQP0xWo8YHqSKAPq4gKUERy3EJCLBlITjQjFr+FJJd3eNp
 95FrGwYrbXn7FCD1AKlZibaWI12gMZK8Ost1SjtJB6IiQyYqwJ5b7c2SRfQYK0a59gvwPRa
 8DfMXDaPxJ9oQY6aRlA6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:66V0LcjL5oo=:j2e9cmY3y2U2JkAvdZXEqN
 dbM5B0zedWxSQ2Cko3vIVrhHEuNw2OK7hrlmfBAjlOtgtwSD4C5oMu7IpjqgJcbM3wFEYV7dJ
 MYZIs0+HeF6mxFN/U6xfJTK4x5qCJMOjjptf79jWHGFzzxsytrqheq0rbhmDRJgPzVW0N2fOO
 LnhqIFdXUI67+jHX3siiAc1E4SzAK6khatqtPqpnizBOl7eEAOQ+IXc3cw2BpmfooSWGFGf4C
 A0dmLoKTYp6jUcrSTTNppnO69xfi+pLP7pj835zWHcrcRhfe0K/HtJqcOCFdbTwldthG9a5zd
 dQM/SplJ6ljri9jUIobr+s8ZIfB6exbOauSzb0UID2TYgdIssOI+saklC6OjNscQSBY3yyH7d
 PooSL2dCQ2bC7WhtuSm+nzyla1B68O1kv23z0I4DBcBztE+Gv5XNyHz/hdiN3pyYX4D0hPL1/
 jZxOrFvZUTPtIQj9HMhDnWkr/NhKfy21SxgS46fExlrbCzHiWmpUzEsGvfCe0YkPWkPZpwOCL
 dS2BZKDe2C2UAe0THd3WfoCBZx7c/PbwBsNdktjUn9QGBrYIvcdfuDoCMd5njqs2HQuaZdMrr
 ELKVEKv45TV8U/rDK//PUUQcQsKBWDwHV8N4vTNaI8jZGS+h676esUILJ/s057cfPnC052mma
 z1+3lTKtl2PBgYNUOAbe7Lut2Lq4C19RcIB1ZEvWDpKG9nOrnQA3ndrHJkffUxYk17EfIwVkd
 zN1gf0JFpZx61LWgI7S2dBWwWqjNnPai2N2oMM/AzRnHf7m5vbpZ28SZWtAQZ31TsngyTJHS/
 XQDxDKO86tmR+V8Bhs+6nsIVTGLV1OWw6nsb1DV8Zr/9BWHQBlqh8A+wHrQ5mC0xjSI76kejh
 llefcI2x1bFJirFdahk1Saw1mbBV9o9/Xlu0DhTKfDOj4XJOWUynn/aYas9kowkfNvsy+ZAVu
 +0UsHjY+LSzs3QUE66lTTBTLvkDO3MvudSnujiTrNqus8uWnp5mTnONjZO4vUd4UpPXPcOD9s
 wlI9WDpKpbn/swFCdCGT9ivz0NjMy2uer85EEzpNHGhbLB8Nfs0yFUtA77AA1iq/itB9BOdfd
 ZxPP134R1x2zwaVcavWGsAnrROJ5/DoYZhXyXyxLacuEYV5vu4T2nsS4KO3yqMFIcCjkvCiW9
 ifVKF7ZMxTe1Ylz+QkHEzvpOZQbWdDEjEwnbhnXJuudilQcu0H74Avg3vMkvQVYmrsEkYsKoA
 aB+FAfCmAiVvhJJDKvc6jBiD6LQ/+ctWOqACUnA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EuSGyY0hrpePdC20bidgjCmtWlGmSK0g0
Content-Type: multipart/mixed; boundary="DYocTbUucq5rR8rjyht0hxJquWOqac0UR"

--DYocTbUucq5rR8rjyht0hxJquWOqac0UR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/12 =E4=B8=8B=E5=8D=889:49, Spencer Collyer wrote:
> I have just received a 'write time tree block corruption detected' mess=
age on a BTRFS fs I use. As per
> https://btrfs.wiki.kernel.org/index.php/Tree-checker it mentions sendin=
g a mail to this mailing list for this case.
>=20
> The dmesg output from the error onwards is as follows:
>=20
> [17434.620469] BTRFS error (device dm-1): block=3D13642806624256 write =
time tree block corruption detected

What's the line before this line?

That's the most important line, and it's unfortunately not there...

Thanks,
Qu

> [17435.048842] BTRFS: error (device dm-1) in btrfs_commit_transaction:2=
323: errno=3D-5 IO failure (Error while writing out transaction)
> [17435.048848] BTRFS info (device dm-1): forced readonly
> [17435.048851] BTRFS warning (device dm-1): Skipping commit of aborted =
transaction.
> [17435.048853] BTRFS: error (device dm-1) in cleanup_transaction:1894: =
errno=3D-5 IO failure
>=20
> As can be seen, the fs was forced into readonly mode. I restarted the b=
ox that the fs was mounted on and am able to write to the fs again (tried=
 'touch'ing a non-existent file and that worked), but I'm reluctant to do=
 any more with it until I know it is safe to do so.
>=20
> Is there anything I should do to ensure the fs is OK? The page I quoted=
 earlier said not to run 'btrfs check --repair' unless told to by a devel=
oper.
>=20
> Thanks for your attention.
>=20
> Spencer
>=20


--DYocTbUucq5rR8rjyht0hxJquWOqac0UR--

--EuSGyY0hrpePdC20bidgjCmtWlGmSK0g0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8z+XsACgkQwj2R86El
/qjd2ggAmiH8pXO6tLAyOU3CqOCuw/1VbY58e5/QVMwehDVugb60/Wd+9CIm+n9w
dvP9M3rf7mcM7Yr1YTVx8gLk428/oEZXKtU/Mn73+trGyqtFVXuIWtfGiW/BtCDd
ur/jeAUbvH4si++AhibMUvlFWR5zGPuceW0+dafOXNmWUz2dwD2M08oVif+TLOAb
eqGBIiNJvDvJ9Z6WlH+9+kzBMiElYjWaudtcpHkib+5QJsf5pphd2pSCsNmymZ47
GJoBMra8nDCxkiTlvtj9HHsSfbs+Bg9fbFS3mHiAs23Qq1ewHGTQJVYNa4cLiqSO
whbAYPbT6pFJB4Gi/1s1IteU30lr1A==
=NhGS
-----END PGP SIGNATURE-----

--EuSGyY0hrpePdC20bidgjCmtWlGmSK0g0--
