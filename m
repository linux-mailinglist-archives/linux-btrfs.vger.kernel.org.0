Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508FC1A5CDF
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Apr 2020 07:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDLFE7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Apr 2020 01:04:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:41501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgDLFE7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Apr 2020 01:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586667876;
        bh=rB3tUbQ0M2gM3foxNXYYIEyOnjZlq9lSpj55UJ6yr4g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a/Lrq3KZlmOYFSzy95X5l9IHgbGGRimI5cIJcyXFKvhoFKD/XG4d32E28GEB1JfKA
         z1d3rImFLpm7qarfGPbdJUwbcxqNPOtAxknim1sE20nlatFz44hh+WvsFw2fBUe6pM
         KuI14TG11uEOoC6YuZLYRN/LHxY2q+AC208nMgnM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxUs7-1j3vcA44zZ-00xrVQ; Sun, 12
 Apr 2020 07:04:36 +0200
Subject: Re: [PATCH] btrfs: Fix backref.c selftest compilation warning
To:     Tang Bin <tangbin@cmss.chinamobile.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200411154915.9408-1-tangbin@cmss.chinamobile.com>
 <ea85377e-4648-c174-2827-53173587777c@gmx.com>
 <4b1e57b3-ca0d-f3e0-f4c4-72cdfe943d7a@cmss.chinamobile.com>
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
Message-ID: <b1298579-8b24-344d-00cb-b922d6e4a398@gmx.com>
Date:   Sun, 12 Apr 2020 13:04:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4b1e57b3-ca0d-f3e0-f4c4-72cdfe943d7a@cmss.chinamobile.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MUDCRRcwo0eNNbk73S3sYUzPZTRiylwO1"
X-Provags-ID: V03:K1:l3mGqGvc98XzmVBfizvzQcXu6C/pkbGaaZchkPPy4C2eRBFqDSx
 nEu3EvgafTihJT/OXKni6XC2M4DCZLVGG2ikYI95qc37U7KkiViKyz8+qKLU9s4bb6060cD
 zzbgvcVaAAX1+jORU+Dm3LwTsRofWMwCeSH9xd2gVBx+MNqap/Y9/RGSdHJXP1LyNx9eoVk
 elraSOagUeKcaVEG6fbhA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FydJrNllGfA=:fT9DGcYdsBVQW00wCpviYe
 a/kxF5mewOfh7k76LJqqytc30HGuPCBhAbjWnZ1XhJXaEYBKSOxtr2dHgUE/vDyShBzKIa5+Q
 Ma4nC6qEvCHe/NhKb1KprUxQ6eACUErTdOD0a165mxwglnpnhf1Rit/rC1tLgavzBJ8R4oeX8
 2nk1ekPuAuSK/r2J31jVmRoF9fNVkdQGf6D0ZcqSKEpIdEIje7uQcx2I2z4Bss2AlarrFBiFz
 uqab/uz+LqcSqjtWk7YUWLJUvPHSiVX1j2oq4K2GSN9YoN50hjn2Jk1eoZLmHP/Spb7wwpvKh
 lnEKQk5bg4rWKQ5epTbssVgxA3z6l3q2nF2OinFUv4bhpH5eFmGY9VOl7sDrEga9zY11qnTDA
 rkWo9nHbTou99DrtLBF0CvvB7cvfFBlVhoP5bkRM1HL0VvyHfQtqLOG1UwDR7wtlVtLNkXK3k
 rvyykE84NtVunBd8N3KogMWx7mpSt18wLkJKwCK9BOGz6GG51TA4K6wxe0hKMRRwjA4aAzxyc
 SvpasTyCjOqEDF1/jI1fxztIZuCHKRv8BaE5ThXK30s9ocUeXGtI295Z6ZEXjRAc6Qio4KuqA
 Ju1G1jyN+Ydd6LfDYXVCZuQDnHkxrEGgVJoSX1SVDNv50RHxjJzsgIXGqpHMaCjyZcAOo/OPj
 WY+DFyqgpSGZAEBBXipDgpT2G4OK/UXOscGAKpeQ69i1KtzfmoLiIIsG8kkAD9kcv9QC5rMcE
 VIwEZFEgciuZAqmFVZjSeggSNotpHc4CE46vj8c2qh0XP2U55ByoNFyntvE7TdmiyvVztePg0
 15AQ+XyBRbNci3fCv++OZpnqfHQvPWDYzgTAd0smgfbY5YmoaA/oQYq9f5pkxLXmGXyAo1jfr
 fjzwPs/ZpK2HZYAo8V4uGzvBsVju6qRNxo+g7xEG7tn0dL49awBns0PP0BEtjCvKIVxpcmq9K
 afpProc07wuTZSM2v1GMS+G1ydxMou7Up9jVhggVXiYXzfx3eMV44wyStKvnBapFVBedQTHGW
 2XUO6NTcV9ErkbMrcSqEBQ0DWYMj9dlwul3UkVx8Djh8+cRDAi/wEjcVNOQfJnQo90ush7gkU
 2xrR//mlnH+yDS4aG9YgJrf+/bMdPRWZx2QF0Qd0yOhnvqah7t0DxOg17KETfMnOMxXaWYz08
 AG1dBu6sZoR8S9hH4ltz1yaBkeEHSphimAf6E+Mkp1pTysB5nhcglyQkHjvP8DQGE1W3K9fzu
 zFXYRB2UBUo2bXBLi
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MUDCRRcwo0eNNbk73S3sYUzPZTRiylwO1
Content-Type: multipart/mixed; boundary="dryZrHRxVOTPI2NxyibNxzHfHavl919QM"

--dryZrHRxVOTPI2NxyibNxzHfHavl919QM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/12 =E4=B8=8A=E5=8D=8811:21, Tang Bin wrote:
> Hi Qu:
>=20
> On 2020/4/12 8:52, Qu Wenruo wrote:
>>
>> On 2020/4/11 =E4=B8=8B=E5=8D=8811:49, Tang Bin wrote:
>>> Fix missing braces compilation warning in the ARM
>>> compiler environment:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 fs/btrfs/backref.c: In function =E2=80=98is_=
shared_data_backref=E2=80=99:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 fs/btrfs/backref.c:394:9: warning: missing b=
races around
>>> initializer [-Wmissing-braces]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct prelim_ref target =3D {0}=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 fs/btrfs/backref.c:394:9: warning: (near ini=
tialization for
>>> =E2=80=98target.rbnode=E2=80=99) [-Wmissing-braces]
>> GCC version please.
>>
>> It looks like you're using an older GCC, as it's pretty common certain=

>> prebuild tool chain is still using outdated GCC.
>>
>> In my environment with GCC 9.2.0 natively (on aarch64) it's completely=

>> fine.
>> Thus personally I recommend to build your own tool chain using
>> buildroot, or run it natively, other than rely on prebuilt one.
>=20
> My environment:
>=20
> =C2=A0 PC : Ubuntu 16.04
>=20
> =C2=A0 Hardware : I.MX6ULL
>=20
> =C2=A0 Tool Chain : arm-linux-gnueabihf-gcc (Linaro GCC 4.9-2017.01) 4.=
9.4

That's pretty old.

You'd better fetch the newer version, as newer kernel may require higher
version gcc.

Or even build your own using tools like buildroot.

Thanks,
Qu

>=20
>>
>> In fact your fix could cause problem, as the original code is
>> initializing all members to 0, but now it's uninitialized.
>>
>> You need to locate the root cause other than blindly follow the warnin=
g.
>=20
> In hardware experiment, this approach is feasible.
>=20
> Thanks.
>=20
> Tang Bin
>=20
>>
>>
>=20
>=20


--dryZrHRxVOTPI2NxyibNxzHfHavl919QM--

--MUDCRRcwo0eNNbk73S3sYUzPZTRiylwO1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6SoV0ACgkQwj2R86El
/qjTSggAg8hB2i+/2hO2cjJZwJF+WIrYOgLYco54Wm3L1YiHfAoRWZSo5Xu3bDLu
cxMdYFs1qXYhfMYEzo8sD6CUBi7qzSZgI89Jp2FtlQ3XM9W+thH9wT55fp76/dTZ
I1U5ip9eV59nF5Or6RZNTmI0ySbO4bnTw/JofDq7O3Os5oviEv8PJoo8j7gWRpMp
W0g5qkKYzFJnbyY2dIkc2FH5bAVCWSRUe91PteY0nTAOyQ3NDfxK+CkaxaSML4xa
OvBWbtIlakHZfshx32RgSoe5/cOT6NXGEKfgT46jlyjmk4nDl5tFvVfDNXx5J/+N
WTXr7BW7XUn37gBr5KsmKONtTkdOPw==
=K/Nc
-----END PGP SIGNATURE-----

--MUDCRRcwo0eNNbk73S3sYUzPZTRiylwO1--
