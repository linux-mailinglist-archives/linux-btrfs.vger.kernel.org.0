Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FBB1DFEEB
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 May 2020 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgEXMcm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 May 2020 08:32:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:44075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgEXMcl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 May 2020 08:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590323551;
        bh=gX7WBZuN0hWUqwyuA/7cyMaKNRH9Hl0+0ZN/w+PcdLg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LGzZVu/u97gX3biA6JpFOX7o9k76ibjt9HL+wdDHlAA2ZQ/OD7MuNYpHi9MztwCZL
         3OJTHCValL3BfI/nRM2KUY8LQbW8/FvJuNP1To9/9vW61xECMPLVdlBmK9tqCUIhtC
         +RdaFJw9epAaCW2SIdiDm9BbzGjjOvq7Kv5CY9oc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJE2D-1jIgU928gF-00Kh6Y; Sun, 24
 May 2020 14:32:31 +0200
Subject: Re: Trying to mount hangs
To:     Pierre Abbat <phma@bezitopo.org>, linux-btrfs@vger.kernel.org
References: <2549429.Qys7a5ZjRC@puma> <19884168.u0ROftlITR@puma>
 <76e60f34-9831-3bda-4b71-fcc5f9b46a7c@gmx.com> <12830569.d4mHp5BhJh@puma>
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
Message-ID: <cf88e4ad-c2da-d5e7-5388-2434f39dd81b@gmx.com>
Date:   Sun, 24 May 2020 20:32:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <12830569.d4mHp5BhJh@puma>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3P8t7GhHwFtOx5gatGVsnOxG64oMwOVSb"
X-Provags-ID: V03:K1:618AMUXf3mf7p0M5XN+6IgKNcUWzHRJE7seJ7gUQUnaXuxdti2b
 Kije9s6uQz59csY/Xeb/zafpvbM4IXYscEeWVT14HowsPa5dylbhXi9vPOq/XstsLzY7vTQ
 zSsiRhzhPha4Qywix7xOEKBxgGzexguu3rQE/DTZ9zyDxZCp5b0jbw/X4ub+PA4gavLR+mO
 02BkbL3tl/unwWU2kAVSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lDtG/KMk6Bw=:29lR94J+FSJ6E5F02KHt8H
 YMhe8C+VsRizAey37KuGNJ4SzC1dQpce9zbQC6Ozd5fsEvlk35NG6ISUdJjULGiZZpSq+C9md
 G1yYEpdIJNPNON6SC7tA2nBTHw8Bfdk8ZxyDtNhfznZVTz89i9inDy1ECUSvL/wXL2mbbXuOa
 fmwCrvuCwsuVG3L7C4RYlpiegdKrzKBXUB7OZq42cN/r86TBZKDmIhr0Ob2xKK7/s3B06NzL8
 ppOlsXxNor1gYZNOcbKusfXkODVRI+9cpVDE2hSaM/r38mx9THGUHgIqgQTjT31kSC51ZnFhO
 tRPDs54dEhYVXfW61wkv/MFOfKVWSbD2UpBDOLUABYx5PZ5KioErzMo59Sv+wmPgk1/wWxHC/
 NJRce8ENcpGcLzHUL0cXv0GsjAlq7ZPHsGeXo6n/tOT7ZJ7zl/2b9LXQRxua9Iq+XntU2BpuS
 9H98bfsBxWoT/8zP+WBvt5pnshCLAMNsMLBjTwmZjeLtWv1kQkiFxi4zOvUYMlTJAuai27bpo
 Kq2VdUlkiPf6Oi+8WnpUvNMLfd/g83c/bmaLxqDBz6LXCMAXN7/nA2vtiewN7jroXXMrrlKWU
 6qKJ0aLrR2BJjHBJIexlcOObNBfXd+2++rRPKwioY212tILPGvGqu9Hvqx5j+4jLqPMHGJ4a1
 imSsoTYA+ZUUK4Od9fSud/iMlgMZYcxjhYY22WLzlt8+LGsmo/GPffXRqiPQkI2zfeoeo/7uf
 BHcwf3zctkNj2XYpF0USG63EQ06BN4ge45kNGwQQLbESZrtmKTEewIN7sIndIRcuPUUk3HQ/d
 G7ro8PZqv/WW+gM2J69CMmS0PrQS6ygb2nSfTnm+PIISrV0j5LcpYnqsFNOJxcoJtTIwhLRM2
 zR09krgb/wvVNE+CRk1kQEMPlIKGakL2fVnizmVrbtuegxobHUSbiQJSDLZFOWXXLMEkobkqS
 jqzbCamqYqk5g+QjKP6m2L4ILTy6cbbsqZLrz+HRuDyJVcJB+RoTBXtjN2vgdqqr+sKwY+Fv3
 7BEoBXYrBDM2w4SVVYg6nK+eKD98QuA25/fVT7z1/TlpV+cSbxTNxbYjfzfN3fPjFeFKLIXsU
 +f7AHf2Zq1WIppLVCK4Gy52BsKbL5BqG7F+RYqdMiaqYahjZqoG5tT80knkSFtEvl/DyI4Zo1
 8UwoQIIU0KqaEgsxC5Ek9dmABL6sGLzYiWcggpxLMLfsgVjoY4RiaPrwE9HV15zfunZh5OdIZ
 ll2fEYENuh4jtLPqw
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3P8t7GhHwFtOx5gatGVsnOxG64oMwOVSb
Content-Type: multipart/mixed; boundary="EHvios2tIeUwFhDpuvIoxBJojqeJUVEDU"

--EHvios2tIeUwFhDpuvIoxBJojqeJUVEDU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/24 =E4=B8=8B=E5=8D=888:10, Pierre Abbat wrote:
> On Sunday, May 24, 2020 5:24:19 AM EDT Qu Wenruo wrote:
>>
>> Didn't get the image.
>>
>> Maybe it's blocked by the mail list filter?
>=20
> You (not the list) should have gotten an email from wetransfer.com at 6=
:43=20
> UTC. The file is 165 megabytes, which is too big to send by email.

I guess the gmx, nor may wqu@suse.com/wqu@suse.cz is able to receive
such large attachment.

Would you mind to submit it locations like google drive with password
protection?

Thanks,
Qu
>=20
> Pierre
>=20


--EHvios2tIeUwFhDpuvIoxBJojqeJUVEDU--

--3P8t7GhHwFtOx5gatGVsnOxG64oMwOVSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7KaVsACgkQwj2R86El
/qho/Qf/akXsKn2zJ7UPF8xHlq/TYeLBZlJI7jKyBj80VjWpuVkSCgji3yewOv01
tUO5UFFinbLkdqq2aySa1ea/UwyrxGJBI7voBXW2C5lS0dt27cdYt3QOX1LV1acb
K5MBDQBloJSNY4Yx4bHZIi05Y7Lub/O4lcUxPNcQfdD0NWBlLciVzEsM3Cb6/pWS
XKsoCB6f4S9j526t8oghUt5G9i1YgmqmRMr9fQhhJjbFuYlKcNNQkFOAlBqQeGo2
dqddr6hsZD97UeyKv4GTpl52jvN9nwWXR4TxxCQBxaHGB28Bd2BbE4+fK+hK2kDv
2Z5pH9QZoHJP2aaaleGnwaC6eNVUrQ==
=3laM
-----END PGP SIGNATURE-----

--3P8t7GhHwFtOx5gatGVsnOxG64oMwOVSb--
