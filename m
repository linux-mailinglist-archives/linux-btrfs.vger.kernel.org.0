Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E48155165
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 05:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgBGEAN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 23:00:13 -0500
Received: from mout.gmx.net ([212.227.17.21]:44977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGEAM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 23:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581048009;
        bh=sfoetY5msp3asyYy6InsgQ6h/CMXX6IVWntgDrIPpSs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M9xvGoia7HSbjHh2psYmznNXxOxYvNoGlHfwg0ieCIW47TOxcEtq9ffB8bA2/kyc/
         CjZvvULyqV6gjiCq8E9gdUWYD8B4VmNSSA7nKCTvcemcjLt45ItvAmb3FTloipplf6
         c4hXtNmLyzEuTQDwydSBQgmt1WeGsbZSWJX8BHC0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRTNF-1jCF8X485V-00NT8V; Fri, 07
 Feb 2020 05:00:09 +0100
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Chiung-Ming Huang <photon3108@gmail.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com>
 <CAEOGEKHf9F0VM=au-42MwD63_V8RwtqiskV0LsGpq-c=J_qyPg@mail.gmail.com>
 <f2ad6b4f-b011-8954-77e1-5162c84f7c1f@gmx.com>
 <CAEOGEKHEeENOdmxgxCZ+76yc2zjaJLdsbQD9ywLTC-OcgMBpBA@mail.gmail.com>
 <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com>
 <CAEOGEKGsMgT5EAdU74GG=0WbzJx81oAXM0p_0rFhZ4vFmbM3Zg@mail.gmail.com>
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
Message-ID: <efb830f0-9990-efba-aead-60cef00ab3cb@gmx.com>
Date:   Fri, 7 Feb 2020 12:00:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAEOGEKGsMgT5EAdU74GG=0WbzJx81oAXM0p_0rFhZ4vFmbM3Zg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xb1sCwyQ4SyLmOBgCyrZsWnwjQcF6Rkww"
X-Provags-ID: V03:K1:VE1DWL9h8RFl00kDJPZF17EJA2LVci8Y3WXoU4Q25xmPWGP6rB2
 SOpoaiOOhLeLow1IIPjcvFr3R8UL9+//GtOs4h0UviG1d9tpoHpKm604GGJLnfo7h7PD5IE
 OvM1T3l1XzoSZUVGOOxbyL8IjguL0C6gdk/wpj2Wui/tPcEkzVApj8gp/lPEMco2xw9Cf40
 tS6z2gKB+/ZJfqvRoU92Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wHALGAeRLyg=:CJOLZouHLNJVEm41ajsqvt
 T4ebDtLNQ4pLxyGz4/iBpKSCwNvSdO7FeMuQy5MAw9Uxnc2DNZRM45upO8qAqW4kcQlGINnk9
 iktCi8zSrgQsUHCiKQHEfmYU2nmGFYcj9LTWDNEIiM6F7jnsuG15zgnrAlntuSw1j1g6z2alD
 ce0GH0ipYY1uI1zSgWYL2xQEck7YtEFBXlBVBvvfwes4I6D7QYNsa8DC+uRhGinVENuULnBF1
 sd7a/UmKYZzHTr3vAtgUgATl+jkF2+miSq938A4be7nkaIoK0kmoX1OXTezB7W4HdjJQOXhN5
 WgH4ohTkLnqSgIu4hPR4yl9UoZBlKPfCZE03kFYbCMksWQrTyXJ3JEzbcBLlqjgxr1Jl8zbJb
 rYQ7JcGEyl0D8c7vtbVDm3QJVgod0k89p0DOYPZekNgMf/YewOsaP07K+hUiC+HMVDBGZjFfh
 Hzuf8QyOEEwujahZuaTiZcFWqbY3LUO/W8fI2D2qpcBPI9Io2r9ft1Ssm8Pq7ddnlfPeVrrNe
 d82lMb1ctvQZLuPJHvOBAWsz8Y1LJ3r5PJUkyja3UrJH5EXbnUJeUcIDWwTQmuIemN19O8V6y
 hdku1dmbxfcTlo5cqJNLkkNPnCTI6YnC2/jCLdnJLMJXTJRjED8WxczjueUt6mbfLjcpqxPte
 997EFDjgnW0BtXfYSWcAOlld2bEmZraZYc5+4WqY6HN9w9OKQ41/iFhyVGx8yWGOn44hDJHe6
 E8bbSkVe7oV0bHvTnkinBNvKhZGfIlTCqY7Ls+JrWZoqP5Pay/ABiOCIwkABQIyNyXMvBFLDV
 Hwl7ilR5almfmZ9RfPDwvolJAcGHXkO5e1kor3Ifa0UAzCcUWqAwJiTgXu7tpNW+m1OqRC45w
 T24VsQFRyePOp28pXjVGrRAD3C+0Y8fEjv/27Vn8MYgsbzV+9oYLHJu92VaXVV9g3x86aTopV
 gVYNRNBVQI0vMy0H4mOhjXguOAE7SVF6hsL9y6GQvCbOGnHxQwEw9r+1E2n4NIuvwv703UAWF
 18+k2T/fHZXzxP/9EqZOYSMCO/1YV3jD63OHDQNWsK3ho9LgqzpmFfznXxKaYXLl7HFnVYaZJ
 /WoTIXPCOw/X3MGN4nwmxvUlB8xaDNjHGUUpjYBg8jJs2eWEzhtz0t49Qqwpc6mRR8Bpa1eDW
 51U2cKXIdeFmeRotfeEMIQqdkV8jWzTzCuZwgGthZIY1xvsudPgCtLBW2qQjospjdK6daQFso
 cgu1qX1GgUrPR/jFE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xb1sCwyQ4SyLmOBgCyrZsWnwjQcF6Rkww
Content-Type: multipart/mixed; boundary="iCdQywH36hxrUuxuUVVh1QyuGWXCdxjZo"

--iCdQywH36hxrUuxuUVVh1QyuGWXCdxjZo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/7 =E4=B8=8A=E5=8D=8811:49, Chiung-Ming Huang wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=886=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8812:35=E5=AF=AB=E9=81=93=EF=BC=
=9A
>>
>> Here is the diff, should be pretty safe:
>> diff --git a/check/main.c b/check/main.c
>> index 7db65150048b..bcde157c415d 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -10373,7 +10373,8 @@ static int cmd_check(const struct cmd_struct
>> *cmd, int argc, char **argv)
>>                         ctx.tp =3D TASK_ROOT_ITEMS;
>>                         task_start(ctx.info, &ctx.start_time,
>> &ctx.item_count);
>>                 }
>> -               ret =3D repair_root_items(info);
>> +               if (repair)
>> +                       ret =3D repair_root_items(info);
>>                 task_stop(ctx.info);
>>                 if (ret < 0) {
>>                         err =3D !!ret;
>>
>=20
> I applied this patch and executed `btrfs check /dev/bcache4`. It showed=
 these.
> Opening filesystem to check...
> Checking filesystem on /dev/bcache4
> UUID: 0b79cf54-c424-40ed-adca-bd66b38ad57a
> [1/7] checking root items
> [2/7] checking extents
> parent transid verify failed on 7153357357056 wanted 1382980 found 1452=
673
> parent transid verify failed on 7153357357056 wanted 1382980 found 1452=
673
> parent transid verify failed on 7153357357056 wanted 1382980 found 1452=
673

Extent tree corrupted by transid. Already a bad news.

> Ignoring transid failure
> leaf parent key incorrect 7153357357056
> bad block 7153357357056
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated=

> [4/7] checking fs roots
> root 5 root dir 256 not found
> root 257 root dir 256 not found
> root 258 root dir 256 not found
> root 277 root dir 256 not found
> root 278 root dir 256 not found
> root 279 root dir 256 not found
> root 280 root dir 256 not found
> root 283 root dir 256 not found
> root 286 root dir 256 not found
> root 289 root dir 256 not found
> root 292 root dir 256 not found
> root 295 root dir 256 not found
> root 298 root dir 256 not found
> root 304 root dir 256 not found
> root 307 root dir 256 not found
> root 310 root dir 256 not found
> root 313 root dir 256 not found
> root 316 root dir 256 not found
> root 319 root dir 256 not found
> root 322 root dir 256 not found
> root 325 root dir 256 not found
> root 360 root dir 256 not found
> root 367 root dir 256 not found
> root 370 root dir 256 not found
> root 373 root dir 256 not found
> root 376 root dir 256 not found
> root 380 root dir 256 not found
> root 383 root dir 256 not found
> root 386 root dir 256 not found
> root 389 root dir 256 not found
> root 392 root dir 256 not found
> root 399 root dir 256 not found
> root 402 root dir 256 not found
> root 405 root dir 256 not found
> root 408 root dir 256 not found
> root 411 root dir 256 not found
> root 414 root dir 256 not found
> root 417 root dir 256 not found
> root 420 root dir 256 not found
> root 423 root dir 256 not found
> root 426 root dir 256 not found
> root 429 root dir 256 not found
> root 439 root dir 256 not found
> root 442 root dir 256 not found
> root 445 root dir 256 not found
> root 448 root dir 256 not found
> root 451 root dir 256 not found
> root 513 root dir 256 not found
> root 4613 root dir 256 not found
> root 4616 root dir 256 not found
> root 4619 root dir 256 not found
> root 4622 root dir 256 not found
> root 4625 root dir 256 not found
> root 4628 root dir 256 not found
> root 4631 root dir 256 not found
> root 4640 root dir 256 not found
> root 4643 root dir 256 not found
> root 4646 root dir 256 not found
> root 4649 root dir 256 not found
> root 4652 root dir 256 not found
> root 4673 root dir 256 not found
> root 18871 root dir 256 not found
> root 19354 root dir 256 not found
> root 19355 root dir 256 not found
> root 19356 root dir 256 not found
> root 19375 root dir 256 not found
> root 19416 root dir 256 not found
> root 19419 root dir 256 not found
> root 19422 root dir 256 not found
> root 19425 root dir 256 not found
> root 19428 root dir 256 not found
> root 19432 root dir 256 not found
> root 19435 root dir 256 not found
> root 19438 root dir 256 not found
> root 19441 root dir 256 not found
> root 19450 root dir 256 not found
> root 19453 root dir 256 not found
> root 19456 root dir 256 not found
> root 19459 root dir 256 not found
> root 19462 root dir 256 not found
> root 19465 root dir 256 not found
> root 19468 root dir 256 not found
> root 19472 root dir 256 not found
> root 19473 root dir 256 not found
> root 19613 root dir 256 not found
> root 19784 root dir 256 not found
> root 19812 root dir 256 not found
> root 20572 root dir 256 not found
> root 20768 root dir 256 not found
> root 20771 root dir 256 not found
> root 20834 root dir 256 not found
> root 20837 root dir 256 not found
> root 21438 root dir 256 not found
> root 21447 root dir 256 not found
> root 21469 root dir 256 not found
> root 21470 root dir 256 not found
> root 23144 root dir 256 not found
> root 23146 root dir 256 not found
> root 23147 root dir 256 not found
> root 23440 root dir 256 not found
> root 23452 root dir 256 not found
> root 23460 root dir 256 not found
> root 23471 root dir 256 not found
> root 23520 root dir 256 not found
> root 23521 root dir 256 not found
> root 23833 root dir 256 not found
> root 23834 root dir 256 not found
> root 23854 root dir 256 not found
> root 23855 root dir 256 not found

All these subvolumes had a missing root dir. That's not good either.
I guess btrfs-restore is your last chance, or RO mount with my
rescue=3Dskipbg patchset:
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D170715

Thanks,
Qu

> ERROR: errors found in fs roots
> found 1902526464 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 6275072
> total fs tree bytes: 1032192
> total extent tree bytes: 409600
> btree space waste bytes: 974245
> file data blocks allocated: 1628962816
>  referenced 1628962816
>=20
> Regards,
> Chiung-Ming Huang
>=20


--iCdQywH36hxrUuxuUVVh1QyuGWXCdxjZo--

--xb1sCwyQ4SyLmOBgCyrZsWnwjQcF6Rkww
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl484MYACgkQwj2R86El
/qjn9Af/S83IYhx5kscFrRZ6H+OnVdAwCNoWqB7y4rooV/mbIYUO4VMCjKSORBBL
jrxjJa2QC4BnG013mObPqC0iO3Id4xc0b1fRquz/zM23WZkJfO7JE+FCyoyYF5uU
3IWCJbajQ7yaEH+WN/9AWEPW441MgpEhIIqpZ+UGWS7egXz283e5yOJ5kq6odEXZ
UzHEbELxRW0nNDJAqSWYQq4Pvv02PWaQWhePb9qA211/pj0b3hahuNlX1E1AsloA
TIWv2qgEaCSszoAfkxYxS1bRHOSj1W9bEUa8f55TQ8a5LyjDnLwANTv5VbxIm1Fs
/Qekym6Aa0NOzUms1FRUDjDNLxwmcw==
=ZzR+
-----END PGP SIGNATURE-----

--xb1sCwyQ4SyLmOBgCyrZsWnwjQcF6Rkww--
