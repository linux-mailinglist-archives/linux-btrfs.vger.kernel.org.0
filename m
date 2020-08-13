Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CED2433BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 07:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHMF6k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 01:58:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:50179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgHMF6j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 01:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597298315;
        bh=Ce089gQZIkrOZH/bADbE5+d9PPIhIfTmsKTIyjxFEK8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Il+edpEoF6seKebXod5BnzwW0euWrvxgSU9+nEjaHI54zGmpaVcP12YwdXrfmB4QD
         V7oK/0RSrGNShUC7rXQBLqC7EZ/cyMozH1//FKE1UCGMQO15FwDMhlP/ghn8RiIUK6
         GZCoMTNU1gRI7znDrCA085SHWjKoCRYAVR+ZfjoE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdNcA-1kf9xa1J56-00ZPAf; Thu, 13
 Aug 2020 07:58:34 +0200
Subject: Re: Write time tree block corruption detected
To:     Spencer Collyer <spencer@lasermount.plus.com>,
        linux-btrfs@vger.kernel.org
References: <20200812144915.488db4c7@lasermount.plus.com>
 <b8fefd9f-3f95-1d81-95f6-f1424640052d@gmx.com>
 <20200813065329.117ef895@lasermount.plus.com>
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
Message-ID: <34523a5d-f96f-e5cd-8bb3-160247ca8f16@gmx.com>
Date:   Thu, 13 Aug 2020 13:58:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813065329.117ef895@lasermount.plus.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IkMqIXxMs5hpLW1sbZrV73qXFm9TPj3IA"
X-Provags-ID: V03:K1:RXm4PlOC7YB/Nc50+TWtmzAwYTKSBgNu/dpw+ulKGiLXSXwrKo7
 ZA9KHtMed82wE2pmLAbB4bKCkjnKsenNIjpwN4RJjT8CX7UuPSCt8mKbLn8Jxu9sFDUCJC7
 xLbpiYiiAYrbx4ZgqvSKoOyDGzAxES67YIW1ep+RWCuz3LRnrJ5TlZBPqCnIBdWBuHOcRHr
 UMAM93YnzmYiJ6RmePt4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:msZ0/xAgw3g=:KMg/YKSEye8iPNSEMWQgvl
 sNqTf20CIYfqLCeU9djS0IJaZh1LdhyGE5nVq7s5PZn/FVxGXSoAnzk6k/vTgIKfE+LFIFpQ4
 d7436kwnER4l7+pGCW1PiG4eKlm4SQL36Kjvvf1hzAfbX8wUoYpToM20tIn8Z8rAku+EPx6Us
 r+K++UOBX+z0EuC8iT4DzjsDahE7zBNcif0yF2ElDTGiX0Wox+wkG5gTsxKKQfIxCBCumv8yY
 qFFkiRwCrKUXDJ9JWgyHvFMhPgCHRf+Esz5D3f09rG0LHNyer+Gl8v2WrhkBdz/JrBSw3qd4N
 j4J4oD2kMoP3+YbZ1X5iDmYDB5C5aS7ECZrY5kA0z2l/2HEU/mBQpY7un4nRKAeg5cVm+1VT5
 jDcorL/IZr+mMkq53PoI7+oNIaky8lk5zH8JrnuQhb0aNboUNk1+OKY3uhdmL9sTKSilZ8fbs
 3+yUAp6/Oi7uYaHPeSaMfk5SgUfN/7ohLOUu6U/A9iw2ML6YesOJcZX3TOu2VGm9EiJZuul1O
 K7fj6kUCHnnY/lypdRVyvAoyj86SjZhUDtFtAMRpX+GmMHYL5JXKodXPye8apB0al6dlD/FSx
 GaygAIdZbTw9Kh7yBtARzBU3JuwRqcv3Noe/bzAXIbNXLChtqODgnDnTs1nNqSE2d89bOPy+8
 bsU1cddxPBA1rdrfGKZc0oyjluczVrzwFZOT8VPYKtpXXIt16ojVbi1EQ6OdXdwdIT/2XiCUa
 CtBYRz1Dh8qUVmS/mIkm7oHSYesWzEoibdWHS1FD0717/CQ3mXV6WshiuAG4haBeLXeEjoRFA
 36GBi0OMdtj85dprBiDeUc8vTnJPox34e/rhFMTHlwEaTK71Ty0aIGIlvkuMY9RcGhlGrrgeh
 miD49GNQVOJgjzJ8H3AimrxHGPxK3qlFs/dB8PS1Q3W6MIL7u8JUL20oHB6f85dlT5HiTdpbK
 7JgDoRlvYIDXKbBB3M9RXh6xLLL8wK12vW8kqmA+D+ufzHYuGgIvmOvGWzj3UuDPeQbwKiCdQ
 ECoWRKAuvjnpGDcAIQph6ca/15G23tXZI9ZPONc3PydmrwE4drDQOW8L3Z0+Pzy+Uzr+U56y2
 JbbOtE5Mn1XC9AiN/Px6nHvCjF+KQv18EHXXZaUpdxhHkOaL3OVhRrLa4P2Xv5QqTfs1DkvOR
 rbzBxa95yeskYKxdnCcNJD2Ke1vxYOv4HC4RRksKANmYTxuVvRNWR6ZVnpqlmtB5bX+HEVQk9
 ofGddVnq42OQCegQyhJMnqG8ORrrb8jrHr2AO9A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IkMqIXxMs5hpLW1sbZrV73qXFm9TPj3IA
Content-Type: multipart/mixed; boundary="P5JIBa4xZfMXTD7vGdUVPom3GPl2ra10Z"

--P5JIBa4xZfMXTD7vGdUVPom3GPl2ra10Z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/13 =E4=B8=8B=E5=8D=881:53, Spencer Collyer wrote:
> On Wed, 12 Aug 2020 22:15:23 +0800, Qu Wenruo wrote:
>> On 2020/8/12 =E4=B8=8B=E5=8D=889:49, Spencer Collyer wrote:
>>> I have just received a 'write time tree block corruption detected'
>>> message on a BTRFS fs I use. As per
>>> https://btrfs.wiki.kernel.org/index.php/Tree-checker it mentions
>>> sending a mail to this mailing list for this case.
>>>
>>> The dmesg output from the error onwards is as follows:
>>>
>>> [17434.620469] BTRFS error (device dm-1): block=3D13642806624256
>>> write time tree block corruption detected =20
>>
>> What's the line before this line?
>>
>> That's the most important line, and it's unfortunately not there...
>>
>> Thanks,
>> Qu
>=20
> Oh, didn't realise that. Unfortunately it has gone from the dmesg ring =
buffer, so I can't go back to it.  If it happens again I'll take a copy o=
f the full dmesg output so I can go back to it.
>=20
> The page I mentioned previously (https://btrfs.wiki.kernel.org/index.ph=
p/Tree-checker) just mentions to report the error to this mailing list. M=
ight be an idea to expand that line to explain what needs reporting.
>=20
> Rereading the linked page, I notice that it says that if it is a write =
error that is prevented then the fs should still be OK, and you can run '=
btrfs check --readonly' to check that. It is 'btrfs check --repair' that =
it says to not run unless told to by a developer. So I'm going to run the=
 '--readonly' check and if that looks good I'll try re-running the comman=
d that caused the failure - does that seem reasonable?

Running btrfs check is always a good idea to ensure nothing is wrong.

Write time tree checker mostly detects the following types of errors:
- Memory bit flip
  Then you'd better to at least run a memtest to ensure your memory is
  fine.

- Btrfs internal bug
  One example is the csum item overlap, which is a bug and soon get
  fixed.

Although you can definitely try the same command, I doubt if it can
reproduce the problem.

But anyway, if you can reproduce the bug, it would definitely be helpful
for us to look into.

Thanks,
Qu

>=20
> Thanks for your attention,
>=20
> Spencer
>=20


--P5JIBa4xZfMXTD7vGdUVPom3GPl2ra10Z--

--IkMqIXxMs5hpLW1sbZrV73qXFm9TPj3IA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl801oQACgkQwj2R86El
/qjc8wf+MH82CJ8sprn/k5uaVGHf+/4+dJWaAc2mPNOaj5z1ti/UUCFKpYv+aVd5
+Ya0vjGgqnk48xkl2Fqdc/KxFbrG0cEqOZNqoivcZZqV0pTNC9ypFul/KS7Hc8BI
SI8NGVkYl61wxEk+6DwwJINg3n57CFqRd/g7tcW5kQlD1jBOFCKou83I+eA5UAnE
ctPAhURABT/+EoE1nemuiMJlPO2ZwwuuIt3TGJe50moMVItS/KK4oKI5M1WZIFdL
mUlkpHzsZVBhtnJdR9E/XoO4b5pwAz/wfDRMoA7Wqm6qX79ETVP+oDgxDfp4Xclx
A+Po53b2SJAmCJR/CcVgfwvSRmxvkA==
=+OCS
-----END PGP SIGNATURE-----

--IkMqIXxMs5hpLW1sbZrV73qXFm9TPj3IA--
