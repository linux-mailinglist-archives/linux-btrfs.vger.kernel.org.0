Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1035C179F4B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 06:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgCEF2R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 00:28:17 -0500
Received: from mout.gmx.net ([212.227.15.15]:34641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCEF2R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 00:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583386091;
        bh=hBDUiAHsk7ucbN7mhNGZUON3lkMqppaEOKSFqSnsXko=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MWeUvRJKDPgSUmkTy+3NYyNabVVbRFYH++1PQBp/3vlNZ4fOB6MtSnomzOv8Fa5bJ
         KM2vCfA+x+imVEA9vf0+fBx3rdiJ6I2IQlQIH5mILAjy59Jixgvo/IBewRvAy8IMID
         NOlBkvub/DngvsQale2ZtPzrFPQbQC3V4MqMV/3o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbAcs-1jkyby1ydk-00bexC; Thu, 05
 Mar 2020 06:28:11 +0100
Subject: Re: [PATCH 00/19] btrfs: Move generic backref cache build functions
 to backref.c
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200303071409.57982-1-wqu@suse.com>
 <20200303163041.GH2902@twin.jikos.cz>
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
Message-ID: <301211c5-9917-d032-3852-c8504f6d3e66@gmx.com>
Date:   Thu, 5 Mar 2020 13:28:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303163041.GH2902@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EfRlyPz3bbX2k64MdiJzCltmfeXIf7wHD"
X-Provags-ID: V03:K1:tKjJD09vxfbFGVYQ1on3tv3hd69UpXudaKvztl7dehRH03KFMOf
 DVKD6g8gZmJFG3QywQZO/PbgnJgSL0drVB+u61CJurRJ+9m+CTQbqWzWjVCYrLdHw14xbTp
 alNy1bp61yfnnPCd9wGaKV1VL2XOuV8ZCUiN4sAYbWoB4jMDWhSx/vcSziZ5/bh1jrCgHFH
 fA3cTY0BInw4ZqKEZcFlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QZ7SdVlmYo8=:5bAJ7iiHtjXiKL1tTjEKMZ
 HYf/cusZ+2aJRt2sNAZDKFNN5e/mkVq11N1PIrAzp+jvzr1NMOPvXq951aAJtokLHzv5pp0DS
 ZRny2dyz8EiNQkUxA37TsbDMH0gKHFfSjMAUNX0z/tBNUEv4c4mRck9Z8wNmMXFcA6dvOKn71
 1On9nBjMxgpy4Y5yJvqDARtjc8iadWsGYooOB6kmXApTqLTX5TaIWKhyaAS1l+XtJzUEZ66OH
 LwUQ9rn2YNIFD5SYtSlGkoGVRg/u5hUNUta/WIaFP91EaflIxvZYq9uh2gj8PObMcr0jP3dpf
 TuEEUcR6kmepTBeg3yu9a5wpnvuEodDACylyvq38hFfiv1EuplE7+hkLq/URbGN38K0sa40gO
 QxFaI9B3MbD106l4XAm/MfviLdggypRcxV4ioiMM8bS6zYig+TZwzmed95kYGBBOmdzUHz+d/
 WHBAOVBZ74aZc2DflEz6uXOq3xeFzjxSuQn1wEHmKAyzARXYINd1pWE6AcxrMxL3e+DL1nSMZ
 98J6OuwSeeTmF84Gtpa7m9TaLsFae/JGUDVVHyqWBv6cqjJjnV15cwJRktGDiW3E/f1eRgmf7
 tuAcbMCrWvhkfSDSy3PHUhS+YRc5sAbt1JW/wu6dx9AGf4teM6Ssy+UGpLoEQ7C7JRTQ616Y0
 73NvSMqh/Gc8+oqig83XGl8+HKVt1qPSzfK2LG7bqQdAXcUTKWxqP/dhoO22K26urADBhjhNv
 DFB+1jEhnhsbxRaGNhMj+WEHsK3PqNiSR8eF2NSb+k2bgrpz1csyTYZQU9346uPkZD6UM8mRf
 jh6mnz3MCoK9ghI6tsHoWzXSMDROekDTMAiSJ+9FucSgVByd5p2CKZvcT+x//OC66TWG2ZQRI
 szLm2r0WoeCBxHP8fYqNvQG7sNdkTX5PSz/v4kiRA9uugkMrdne3+HFAviYfH0beHr03mtUze
 wvQCdWYXWE3nE+eYBO/TVPinvdeKNpHW0G9fTjttYcQpHiXrh8tpfmdrB9Bn1Ao/IrD4SNzyD
 nAiYyZamOi7jiXKAYQlGueARgVqv1+BXZNi3ghPF5ISVndcykXKlfRTWVgH4b9NRc2+2u0GQ4
 dW+44cSk1YZC0wnCnWaIBlzDI0L7Q+32TEZmq5FdcJaNIk4dwze0GLhBhMrz0AV80LG9Vczgt
 ZmqnBLcHQOTzrsZCq5UWIMbNLutumB2V2YgEBkBiwn0eno91gHJKR1BAM7CGp7byZR/4SMss7
 c6kr5XoYeeF7HcGYw
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EfRlyPz3bbX2k64MdiJzCltmfeXIf7wHD
Content-Type: multipart/mixed; boundary="In8sXymnpq3dqmnqF3tqOjeY0uBOXHLR1"

--In8sXymnpq3dqmnqF3tqOjeY0uBOXHLR1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/4 =E4=B8=8A=E5=8D=8812:30, David Sterba wrote:
> On Tue, Mar 03, 2020 at 03:13:50PM +0800, Qu Wenruo wrote:
>> The patchset is based on previous backref_cache_refactor branch, which=

>> is further based on misc-next.
>>
>> The whole series can be fetched from github:
>> https://github.com/adam900710/linux/tree/backref_cache_code_move
>>
>> All the patches in previous branch is not touched at all, thus they ar=
e
>> not re-sent in this patchset.
>=20
> The patches are cleanups and code moving, please fix the coding style
> issues you find.
>=20
> * missing lines between declarations and statements
> * exported functions need btrfs_ prefix

I have some question about this.
Sometimes the "btrfs_" prefix requirement looks too mechanical.

Some functions, like backref_cache_init() is very obvious related to
backref cache.
I can't see any special benefit from adding a "btrfs_" prefix.

Thanks,
Qu

> * comments should start with an upper case letter unless it's an
>   identifier, formatted to 80 columns
>=20
> As this patchset depends on another one I'm not sure if it's right time=

> to update it now, before the other one is merged as I think the same
> code is touched and this would cause extra work.
>=20
> Overall it makes sensed to add more to backref.[hc] and export that as
> an internal API.
>=20


--In8sXymnpq3dqmnqF3tqOjeY0uBOXHLR1--

--EfRlyPz3bbX2k64MdiJzCltmfeXIf7wHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5gjeYACgkQwj2R86El
/qjGHgf/UoK04ta8vkmGg/VqUcaZC0fNUtQZXidJUnxfv+G0w/qqA2U1jBejMTz5
A3A43jVXW/9ZYFf4jnbZ4/sFYbjYf/ghJQ23Pq6RRf1+5JY2tieJ4WNWHrmF/xEK
ND8pWk6yyfM8GU/tFLbc8/KnZojiPOPf+Prt4EK8kUF1Gu9ADAwngKKyCyZAp5HX
/GbNsH41VMSqoGQcQE46OyRsri9qRWIRjlFeHZqhHdsIm3HjAPgsj1VvvTRxeqGw
9NXSrTnhq0NPb3z7TQD4KsUCP2dlJAM8bocjgQQVLpQADNkSNaMBR0WewZl9eLkN
dJD/alfQPlwmA3edY7zTVwFDdgtcaA==
=0o+Q
-----END PGP SIGNATURE-----

--EfRlyPz3bbX2k64MdiJzCltmfeXIf7wHD--
