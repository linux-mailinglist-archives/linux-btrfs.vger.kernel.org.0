Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A644FFF4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 08:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfKRHIH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 02:08:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:37387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfKRHIG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 02:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574060884;
        bh=g0iM9AObDmoIthJCFlO/42UZDMwwZl4Z2mTXLIA84z8=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=AADh8O3jz4Vw5ErO+SJFLmqtf7aBjnDS8KEJ1NZ/fvBjHHUbm+KvT+Br9+Nc75lkJ
         q7I3XsZXICf8RatvgcYy6Gb1sSeujIJfuuHNmATGquV3zSv9pnm20JFIIkfrXBZZy9
         JDyEVPxXrbNR7TOg+4M+15A0KA357EakLQ8qfTfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oBx-1hcrkk3uKr-00wlp0; Mon, 18
 Nov 2019 08:08:04 +0100
Subject: Re: How to replace a missing device with a smaller one
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Nathan Dehnel <ncdehnel@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEEhgEt_hNzY7Y3oct767TGGOHpqvOn4V_xWoOOB0NfYi1cswg@mail.gmail.com>
 <58154d62-7f6e-76ee-94d5-00bfcd255e59@gmx.com>
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
Message-ID: <d9cc411e-804d-d1c4-f65f-60a9c383b690@gmx.com>
Date:   Mon, 18 Nov 2019 15:08:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <58154d62-7f6e-76ee-94d5-00bfcd255e59@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aB87JBLZDTcd4bnjWGHJ5BT1zghwfeSsT"
X-Provags-ID: V03:K1:hdTPhdp1Rcd6qMYAnW43A1dYQvAv4mzKMrEKmExN88sgmiuEGlT
 RI1iPSxcenAmdmFClIwuvquYdWb4wyUx8rgQVXZM5rCivfCI1fjthLrG+GZfwQRXnpx9Wpa
 vcon9n7393KKqOuefV6f3/UsJ1oD/exUNa5LKVngGVYd5GN8ZP3lTtlfDvmcL6qSTK6Ao9l
 88aL852WwV/6CorvPhMFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NEDWb5y9oHQ=:X5SDWULLxzLHIM3Gs6p5sc
 O9Bmu0V7q/UvqzsXOc4ZkX5dqn2i5lHO+C0wq2TE1IjDSTsrtQQLfpR7Ds4gNI2RSIDD2YuoC
 BW4dU96IZZLIWlQT+cZi/IlREj/KUsO7OiuJbWZNVaor7Toa606b8DUrLMJon89AF+Od+4OrL
 WP1ypx9jeilZRGPsJjtMzuIfZoQ4Lfq7L8k18Knwj2DCswbMlqKIed+EZldiZ0aOqNU/euXcW
 f8Z2UGa497mPWXw9+84QkfYKDWdP0Bfqxf7BuHACbf3cslcN1AetqIxPycOlaftOtQVau5tt5
 D0Xrirza8zJ5H95YD7n9zUK69tJh/lEMZiORHx+HDp8gTu5DWyJbz0PLX/n0GrhxdwKG2ME+O
 pbyBYpc3Cf6Jxd9fXk0/XhBV79WbHwE+9CNKPrUZfP7a21IIGMsd5SpWwyHoY0ss5ilil0wYS
 04Ny5hIhnM99j5g21VE/MSa/acyGmX48d3vSWC1DGYkrPvZoA/WTHPFmrqjo8VjwqZ5h8Lh7l
 jAPKALLvIBCoBV2QH0CBx+9BwLmvzUAPdtiNUFekOFoPQHspW6mSIpbnCCBQHjnonSlj5+upE
 NX4q4VqmbaveACg/3XAGDV2OTJlcxCsuEFMcLlwpxfpYvGunUtjrT/5qZF9SkKsUn6Z5NQtrw
 qykbowLHmROkRDxYX18R6HkFAuWkbAd/QLyS9UXUh1aqWaDf6DIFo32N+P2/4gSlA+EFtK30C
 kf9Go9T+MVs6Cn9JdAVl1nmw6Dkd2U6/431DPcbSlb0oqtslD/WDm/eOw/wrGroVsuGRcjNWX
 z64Tqa53l/cJL4+tveTQ2CYjMaQYJ9KZuRVhMp+TbXYVXipAYsJrUf28VzW67TMUGAXTaXeZA
 QsjD7iUu7fQ7vifpG3CJyrkOlxFLciDGf8oU7Ql9dxkBn1oa56hj0D1Je6Tb7iLVPrPdvo0dJ
 /A1elcozBZE5c5JL4LX4naVprTf+uLi+IieLegeaEHOEXktNKSKOOUX3l52QASIFi3m0UxdE2
 aU52hXkPptTMQQEBUTO2vEYLuq9KTYN+tILtYprgPReTdopBW78PUOE7e0u/dxaXJhKvlnMEp
 mzYbdX2KdnQ8GaqOx+6cah8k8TWbtYh3jtjuFtJNWdzrcxWscpa+rK1uvTmi7ia74mxKXNa5I
 1V0VB5dawG7OSGRSfJHWpwVH4mpJ1YjLR4oiGCQpQF8AY5YbzIvOO9XlaiOUD+V0HEcuvRGYh
 uB0Vif7uUqPaB5sve3Lr5RyQok2P9oOwifPekhC+oWh+IubsRKmEYQCBl0FE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aB87JBLZDTcd4bnjWGHJ5BT1zghwfeSsT
Content-Type: multipart/mixed; boundary="ptPruaFConY8LWpYnv9cMbpucs1KrL74b"

--ptPruaFConY8LWpYnv9cMbpucs1KrL74b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/18 =E4=B8=8B=E5=8D=881:32, Qu Wenruo wrote:
>=20
>=20
> On 2019/11/18 =E4=B8=8A=E5=8D=8810:09, Nathan Dehnel wrote:
>> I have a 10-disk raid10 with a missing device I'm trying to replace. I=

>> get this error when doing it though:
>>
>> btrfs replace start 1 /dev/bcache0 /mnt
>> ERROR: target device smaller than source device (required 100020309196=
8 bytes)
>>
>> I see that people recommend resizing a disk before replacing it, which=

>> isn't an option for me because it's gone.
>=20
> Oh, that's indeed a problem.
>=20
> We should allow to change missing device's size.

I have CCed you with a patch to allow user to *shrink* the missing device=
=2E

You can also get the patch from patchwork:
https://patchwork.kernel.org/patch/11249009/

Please give a try, since the device size is pretty small, I believe with
that patch, we can go quick shrink, that means "btrfs fi resize" command
should return immediately.

Then you can go regular replace, this should save you a lot of IO by
avoiding the IO/time consuming device removal.

Thanks,
Qu

>=20
>> I'm replacing the drive by
>> copying from its mirror, so can I resize the mirror and then replace?
>> How do I do that? Do I need to run "btrfs fi res" on each of the
>> remaining drives in the array?
>>
> As a workaround, you could remove that missing device (which would
> relocate all chunks using it, so it can be slow).
>=20
> Then add the new device to the fs.
>=20
> With that done, it's recommended to do a convert to take full use the
> two added devices.
>=20
> Thanks,
> Qu
>=20


--ptPruaFConY8LWpYnv9cMbpucs1KrL74b--

--aB87JBLZDTcd4bnjWGHJ5BT1zghwfeSsT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3SQ1AACgkQwj2R86El
/qg1ogf9HsG5FHwTItpHyVXM0AbOqwbxIqBG8OOrRyA8U+tIk52MyItTitPPbygl
d6MYq6O0StVC3bK1l/kRENsLkHL1SzpKCCv80A1qTtqpGW7nTX4kGBZhhne9ezns
DQu7UppkzAYvUgC02jpeXmUJi8zLYkZUjyxy30KwL1dJfeFInxZCRYBidmNfnyzh
gcDmP+NeoNw3vrpK+yHJmH59IiwBcV2o+1ZHuUbEBtS4C2nupMt2PHf8ofLEFJKX
j+KbW1G9a32GRIi46EBf4u0N56H2lFq01gKUrhaGGARYaCg1G8IQur7Ij8siPdDc
XXivSp2d9WpLtfiduBbbrqoRpTWgNg==
=Pa+U
-----END PGP SIGNATURE-----

--aB87JBLZDTcd4bnjWGHJ5BT1zghwfeSsT--
