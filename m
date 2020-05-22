Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE221DE3A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 12:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgEVKCw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 06:02:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:46401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgEVKCv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 06:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590141767;
        bh=yp083r9ryTCQbfVyn0uYuX4fbK4mHHeY6DhGtu7T56I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IyOYlJB0VM4iU/Lp3QzUzY7W0uhoG5btC+X3vGnynBMPHKleZsVZilQ5hEFzjruDn
         Gi8OCI4iNKqVjRtrrhaeTzie5bG7l0nf/Ep6FfxXtlocYdhxNltyKgp5UUD26Bn9xf
         htN1QPdOYIUaxKQtXt30dtUeTT80YHKNzw9VgQp0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McY8d-1j3Zdr3YXV-00cvPh; Fri, 22
 May 2020 12:02:47 +0200
Subject: Re: Trying to mount hangs
To:     Pierre Abbat <phma@bezitopo.org>, linux-btrfs@vger.kernel.org
References: <2549429.Qys7a5ZjRC@puma> <7541432.rVhWMRgfCE@puma>
 <290f9ee7-1aed-2a92-bdba-063d238bd5bc@gmx.com> <2582603.WkyslYimHe@puma>
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
Message-ID: <f49ceced-fcbf-5be7-442d-25bbfbc75881@gmx.com>
Date:   Fri, 22 May 2020 18:02:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2582603.WkyslYimHe@puma>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3Uadx95tP2NYdcRmihcQQ1nFl9jaILScb"
X-Provags-ID: V03:K1:bFEi/cPsB+0fZ/ZdVnPeeaxfqdjARpleecZhHKIbp0C3PbNW3E5
 +ftcclvAsYxTy4goFHuu9ggRu6Q3FPgIFE40y/+fOLdmi9+chPwwAoaZKcKuWNsTSNHuXXz
 qCWQS0/B83aiEjvzoVezsjTZjSSs7r5JDgaDk3UR3vcjXcGlBOOFoY/tJmXHx/bZerx0sDU
 LysiUA88mFdzvSATV0YKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Txhmnwu9XJk=:miUVoLVnXuDKCOTK3/YJ/5
 AnbJo94VwT9CAAazOfLN0TUtt8qgIRZaubvSq7QvwWkxdyvTp47gdxUfYtZJGYmISjxb6iLWP
 gf8TMgVdLyMPi3LogKTGzZI4qH4WBqlSoLeOwR9y+1IG7u9YUOq7ENLL872nbetaYvCVJ9a+D
 n9JBV7go0eznxeoY08pNR5Zv5XkankGaYIVx5dA22Zvp45YlTMa5kq1JvkrJKqZsuFpJPVqJO
 xWv2fr1Wxd2P59SWZZf//WRh9lxsy+mXnSC5+dHlr1yn/I996zQ4LUc0Mpauf/c+M0XwDM2FI
 aILrX3iWjMgVlRHC849Qpf4UMnsKqa9kn8QHTgkz8SiEwpXGqy1ja+8k2dwCJ64pRTYagl5H7
 ZQ/lMfXFaVoF1HVU5EMaMRpYkg/qYwBrJs4vQEkaSIGx+vVAQeK0BE5PVAKywnUTNwr1GZpIC
 SS2fmA02jCQJFa0QGfgDHacKHxbbBxuAP3SbfqstFzU8T5XYPAdiN3lroy6gnxRAa4bbD/+KB
 v00XH3r6P4qeBEuphdsIMdlnlNxhxMNH+5StAV4xWl8mtwJ/sjBCU4Dj2c3/YZICLKDbQxpTQ
 G02K1g/abm60PYof/0c/8C8rlO06fn1lWylAHQ0YAGeN28awo7YFb0NvNoKunb5tBc3Jd0ODc
 oc9G8D1qPThR2l0/OIU9x7R+rekHJJ+VQ3d0FNtXNzGm1ZwcDKJO7i4VEgSHXZU9v3uM+6xNt
 CbAk8F2v5PuQXyr9lCFKgQ8T1F9n8U4mnqe3WK1dwDAOQDh2WqPtlkEq6Ipc5GtqY6bxnbNZs
 Mz+WcAbusp0gqqpbk9Z+i6ModPmUAOCtG03fe1byTXjZMLspyDhQhCLbOwAvW96mJlZaRFiGL
 XdbQZrOd8kSDzrV9pM18Ul89k/6sdKM9+xcnQNpXLIQG9rtfDX0inyUlXoPu4wW+rZRc1oHzf
 4mvmLf8Ee6L0ZvwQguL8qMxp3EU9AEPwQB7OlRvoGi5TqcP0jssZ3f9D4Z9FfZS6KRGux90CF
 uVYi1q5aSW63ScJh5x7/rycjbTr+wxJDkeZ9BzocGAVlcy5aBwMjQcJyAjtYAB2HunyPBlzu5
 NrHUx4fmvUGcEX1X6PsTnEZk572xY7k38PTVpd9VbjQagzD22KBUuV3Jhm/BDZjg6vUD9MUEV
 pMgNHfuMkpgNROoFi0/ENY5pzMOiwTSEnlPB/VkKDIOiJUzCuIH/W2zYE2q2qLP5EcPKHOXaM
 FHugrcr8EA1rlFqh7
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3Uadx95tP2NYdcRmihcQQ1nFl9jaILScb
Content-Type: multipart/mixed; boundary="Rau6OmBMVON5sGmPaTnciyxPUzw9Q9Oc6"

--Rau6OmBMVON5sGmPaTnciyxPUzw9Q9Oc6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/22 =E4=B8=8B=E5=8D=885:40, Pierre Abbat wrote:
> On Thursday, May 21, 2020 9:32:54 PM EDT Qu Wenruo wrote:
>> Considering your btrfs check reports no serious problem, the hang look=
s
>> strange.
>>
>> The remaining possibility is the log tree.
>>
>> You could try to boot using any liveCD with new enough kernel, then
>> btrfs ins dump-super <device> | grep log_root
>=20
> I can do that booted normally from the M.2. The output is
> log_root                862339072
> log_root_transid        0
> log_root_level          0
>=20

So indeed log tree is involved.

>> If the result is not 0, then try btrfs rescue zero-log, then try mount=

>> again.
>=20
> You seem to be misunderstanding me. I'm not trying to fix the broken fi=
lesystem;=20
> I already recovered the files to a new drive. I'm trying to give you en=
ough=20
> information to reproduce the hang in mount, so that you can fix the bug=
=2E If I=20
> have to copy the entire filesystem to an external drive and ship it, I'=
ll do=20
> that, but I'm hoping that some smaller amount of data that I can upload=
 in a=20
> few hours would be sufficient.

For that purpose, we have btrfs-image, which will only dump the
metadata, which is way smaller than the full disk, and can be further
compressed using -c9 option. (And you can compress it furthermore).

That btrfs-image dump even contains log tree, which is exactly what we
need to fix the hang.

Thanks,
Qu

>=20
> When I write a function that reads a file of a certain format, unless i=
t's a=20
> static file like a list of all primes less than 65536 with associated d=
ata, I=20
> fuzz it so that, if it's given a file that's not exactly in that format=
, it=20
> won't hang or crash.
>=20
> Pierre
>=20


--Rau6OmBMVON5sGmPaTnciyxPUzw9Q9Oc6--

--3Uadx95tP2NYdcRmihcQQ1nFl9jaILScb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7Ho0QACgkQwj2R86El
/qiCKgf/dgOkjf+xnNfueU8/JLurWplrhtFpPmorGx23mSEks+/1s1JVNfKEsU+4
naL57KGYxmRFHWLTS4Dog+LJc5B0vYAcpYAX1XVceijdeiWWhqX3pyCHb7MS0h7i
AvjVIWnLabFbKaxlkzxcAgGcmkHYbCfhx4sZbFuhTdm96LEYWBOZIynhGP3X8HsM
eGVRspPwcl7AQLX/G3bQM0Wi5n0dACcC1vBRaNV8MWjSHnAcpXPj24wd9Ri4AyKS
0hW6P9D8RASJjTsK9N7QdC+oOAkwSrgSf85dVSTcmcLFw77Q5tdaT3k/3vvu83sT
3TRgbAUlZr9XBXj7kj1r66BVMTkZ1g==
=LT/9
-----END PGP SIGNATURE-----

--3Uadx95tP2NYdcRmihcQQ1nFl9jaILScb--
