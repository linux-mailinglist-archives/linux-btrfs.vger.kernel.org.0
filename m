Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE01CCF3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 03:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgEKBlQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 21:41:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:41041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbgEKBlP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 21:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589161273;
        bh=lLVcDGrGU6tsQcjDI5TzafxIY0JMfUWp50fMNARsvQQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kufUUY906HpfcgJz70cVYrMoaPhzgcZcA+LdzJxd+inCBDb48HPbEylFzkdPueFwX
         zgIE/Ou/UGqlF836/cILjlmqgByqhVXzpTkJAVZT5NfhrcLunozFHa4vR+vnaNn+BU
         ohNbP+A+LRs5ICbYbA5Y6n5EmYWq6Sozi1N2M+Kk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRQq-1jfg9M1o6u-00Tkp3; Mon, 11
 May 2020 03:41:13 +0200
Subject: Re: unmountable filesystem: open_ctree failed
To:     Christoph Heinrich <chheinml@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <fbf7d9e2-f64c-4598-2ce4-e1a05a6ede33@gmail.com>
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
Message-ID: <12c889a7-57d2-af96-cc27-5d75398db1d4@gmx.com>
Date:   Mon, 11 May 2020 09:41:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fbf7d9e2-f64c-4598-2ce4-e1a05a6ede33@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IByAywet2KEmi4v3LGBwDYOhqOukEVWit"
X-Provags-ID: V03:K1:eKf4n+YtNYIC7IkFvpkIHmh7N+TK2DKFSDQEv0QdtBUJoBG9MgH
 mnkt88Trx4bSpK21paGBcvTd4/lSr3ylgMXeNrGOcFU8vCybXJqA/KpgSfvPbWm2H4N4p0t
 wdaRcL96Orzrc7LupBsDyBi4pfDH/6Nj87WkKC7KNM67dV3hMY6QodTYJGLjxz2HLu+kcDV
 UTczkjLNSctx9dDTg4zQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:39aiaEEQ7hY=:2PPHccapB36fn9N9Tg7qC6
 PW7Na7y06EeEvmveljM1LxIy7dgF/MG87pstHjfE3Cs2j9pIJIRwCOfIuud4awPreCWbZunmD
 1TzJVYrepdZZb9f7VMUlnx+SZoghOlwifyVHzfQMHcvwQy07uZmreaHn6kA4AOumn+1jZx5mj
 UWFPiFdHCHmd3ESlWjSGObz2aCL/uiSJ6a1eCRokyr07vjkIqMRBvkIHYUpUUI0YFFIBSvaes
 0oFVWDKzkMB4EcCkDiIrxiwWlmSpgldonG9oTGFkzCf2EcCwhq5Ht2OBpPIFNYLWCGiKfYLNZ
 p9ydCx0vn4kWN2ZdEs6e6qtDUdHPlWKlJ0/IFTlXK/xmau+jxYQSivo93+1bowhtIfdl4UeSO
 UNCDcSNdfLEWfnxZ9EhBwtE1egKedwylQrWUPN5ooB+G+kyBaN5MCS4ZhrRergRV1PEiGh3qL
 Jtdbx6D2qVIk5+8JcF4vuX2Fv+0io9qxzgQgLKxrp49i6fdndsjjsyA359Ki0h4u3/EMsK6ga
 WWPwnnB4kX0LRY57wnr6cXFWy66mleORSuu3n4WY4An+YRiL77Pt1QhXWkKqP7vSEh3fPYjno
 BjtxJpTTo29PGsfrXPeaqYru4Q3wfXLSTlmPUuFXGZuZ1F7yxNIiuKEOdJ9EdVnEvaPfsocEp
 wk89aDoT8XOQ5Z9izmRNOHK1si8LgtIezSR6nrVxI42QNlJupzEItNd5QsjNEtaydVSjs/1AI
 myDn9VCdfM1pdNrkfsOUYoQx30irs7UchXCGK3HBVlQUI6hIMyUY9gX72MHd3FEsURSUxcj2P
 AGvke2tTT4/qGiJ6iWXr/CLIm1W1bD+qsxYG4d4rsYNGZoyPB+WdSwVyRI8pOHd6EZj0agdHb
 I+D1MYPuWzt+Gj8lrseimRC9lQxpSq2x5A0aTd8/MpCW7Wekv0tnRYaFOBu02I+KOlfCyO9aK
 QDDxEvrEhd2OY6Lpexn4HJjIdPhwJf5vpUhVDpYPU0Z4DrZSIkpkLX0uQk1rAuNvebW+U1/GO
 QVyhbpge58XqZvj6wp0fYGEBHiBnEZatLCJ0FuQ2fBR0c8hq4QA0UecTwfAQeqcV/2WfhUDqr
 du5gtpiGxOf5AWZta0e9SHm+yO2QqluFsHWiEqD/uH41wz2hvF0Sh154Re/Vn1zO38YkgePoe
 GeolQYMGg5XLzGKjlHgTSi1tMdldDwSVnvBk2lJrhbBiGZK7vxwaN8zR8QbosKij0Z5j3+3xO
 a2qi8nbmN+E2W0lXA
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IByAywet2KEmi4v3LGBwDYOhqOukEVWit
Content-Type: multipart/mixed; boundary="gPuewIq4TJOEtyN3E135jqQaAWimsgeyd"

--gPuewIq4TJOEtyN3E135jqQaAWimsgeyd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/11 =E4=B8=8A=E5=8D=8812:51, Christoph Heinrich wrote:
> Hello,
>=20
>=20
>=20
> my hard drive can't be mounted anymore.
>=20
> Two days ago the drive was very slow (<1kb/s read and write, but I
> didn't find any errors anywhere).

Something looks tricky, and SMART reports no error?

>=20
> However after unplugging and plugging in again, everything seemed norma=
l
> again, so I don't know if that's related.
>=20
>=20
>=20
> When trying to mount it today I get that error:
>=20
>=20
>=20
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdb,
> missing codepage or helper program, or other error.
>=20
>=20
>=20
> Mounting without -o results in dmesg:
>=20
>=20
>=20
> [14479.650956] BTRFS info (device sdb): disk space caching is enabled
>=20
> [14479.650963] BTRFS info (device sdb): has skinny extents
>=20
> [14499.742007] BTRFS error (device sdb): parent transid verify failed o=
n
> 3437913341952 wanted 7041 found 6628
>=20
> [14499.753076] BTRFS error (device sdb): parent transid verify failed o=
n
> 3437913341952 wanted 7041 found 6628

Either btrfs or the disk failed to write certain data onto disk.
This breaks the COW requirement and corrupted the extent tree.

There is a pending patch to skip extent tree read, allow user to do RO
mount and salvage data, but that's not merged for a long long time.

>=20
> [14499.753089] BTRFS error (device sdb): failed to read block groups: -=
5
>=20
> [14499.816157] BTRFS error (device sdb): open_ctree failed
>=20
>=20
>=20
> I already tried mounting with usebackuproot,nospace_cache,clear_cache,
> but that resulted in the same error messages as before.

Existing rescue options won't help.

In this case, your only hope would be salvaging data.
Other than that pending patch, btrfs-restore is here.

>=20
>=20
>=20
> When running btrfs check I get the output:
>=20
> parent transid verify failed on 3437913341952 wanted 7041 found 6628
>=20
> parent transid verify failed on 3437913341952 wanted 7041 found 6628
>=20
> parent transid verify failed on 3437913341952 wanted 7041 found 6628
>=20
> Ignoring transid failure
>=20
> ERROR: child eb corrupted: parent bytenr=3D3437941538816 item=3D123 par=
ent
> level=3D2 child level=3D0

Yeah, some write didn't reach disk.
This means either the disk is reporting false FLUSH/FUA result (return
before all data reach disk), or btrfs has something wrong.

If you have run btrfs kernel between 5.2.15~5.3.0, it's possible that
one kernel regression caused such problem.

>=20
> ERROR: failed to read block groups: Input/output error
>=20
> ERROR: cannot open file system
>=20
>=20
>=20
> From what I've read so far, running btrfs-zero-log or btrfs check
> --repair may help,

--repair won't help afaik.
But --init-exten-tree may help.

The problem is, normally we use btrfs check to do a basic evaluation on
how damaged the fs is (mostly to ensure fs trees are all OK).

But in your case, btrfs check failed to continue, thus we don't now if
that transid error is the only error.

So if you want to salvage data, either go btrfs-restore or compile that
out-of-tree patch.
If you don't care the data, but want to take an adventure, try btrfs
check --init-extent-tree, which can screw up the fs even more, or may
save your fs to completely fine status.

Thanks,
Qu

> but it may also do more damage then good, so I'd rather ask then make
> the situation worse then it already is.
>=20
>=20
>=20
> kernel 5.6.11
>=20
> btrfs-progs 5.6
>=20
>=20
>=20
> Regards,
>=20
> Christoph


--gPuewIq4TJOEtyN3E135jqQaAWimsgeyd--

--IByAywet2KEmi4v3LGBwDYOhqOukEVWit
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl64rTUACgkQwj2R86El
/qi5wAf/ST+ea2jGVp/VkrT7sk3uK2I+9OuGeLjIokEcA+krR62mxM9A8PDuQfkx
V0W1Z/MkCEcHCkbCfFjH6Zed62RBtsGxvEqZBEi12r5r/pKKEvIsoTzett4oYT8K
EVNdq13LpH6ZxJne/mvTmuaqAxQUP/7z3/Q9aPzFwnkLeCZvXN8OFS6GdSM8bzLT
Y/Y0fgmPFA+wuro0ISYT56h+lHhCXmUtHbWb+G62qf+Rdpu6l1f5rBMcta4/tX7v
WrX72JSeby+KHv6sPBb7oy4tUf7QAPcgDkHNHmaWQ/+RkvrB8ueez8iZFD53USV9
9LCWrfUwqMXmePOASKoNx8MNfsNcXQ==
=HM20
-----END PGP SIGNATURE-----

--IByAywet2KEmi4v3LGBwDYOhqOukEVWit--
