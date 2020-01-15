Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9123E13BA13
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 08:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgAOHFf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 02:05:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:45333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAOHFf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 02:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579071928;
        bh=4FJseURqcpH4m9kUeWveSjTYy80VLBCEnu71rH3pU3w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CcJE5pFRUuEZI3wDL+3o0mHztKybbftp7qcGmVAdNXrglcvcDTk4CnkPa2xinND0R
         n7+9+St1MBU6hfXMSyrabbYg+LISByj60kXofrx0ZO9TjRjQdqJ/qMcFJOVQCYD+qP
         t/9zv3JOghK7fvY2F/SXFxXRPCNCNxiF9vGZpyek=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUGi9-1jHmax0BXv-00RLI5; Wed, 15
 Jan 2020 08:05:28 +0100
Subject: Re: [PATCH v5 1/4] btrfs: Reset device size when
 btrfs_update_device() failed in btrfs_grow_device()
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <20200109071634.32384-1-wqu@suse.com>
 <20200109071634.32384-2-wqu@suse.com>
 <69c68e8f-e2f0-0ad9-5c3c-3376246322cd@toxicpanda.com>
 <4bb19ef4-af6d-0c3e-2588-bbee5153aa0a@gmx.com>
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
Message-ID: <61a12790-3371-423a-6845-a5531be62a90@gmx.com>
Date:   Wed, 15 Jan 2020 15:05:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <4bb19ef4-af6d-0c3e-2588-bbee5153aa0a@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kVA5SFsRbwTnEqQsiHZVzTWCyNFAJZ6mA"
X-Provags-ID: V03:K1:k2mG2CYLud6fK07e+mdioM3zRu7ihb8ubJalvwLr+oMubVIJPOg
 0HI8bOwey1NnGI6F33e3HQNfXVrsjFTZ/WAZWJTxmOkb12XM6zstMEL81lAcFanIFj6qaLF
 EZhwP2zGIhAneZva9ItfHo9EaTY2OmP/ZD5DqvHYtu0hQcunA5mfyEp3+fuPRhYdaXYV+AM
 aYcRAXmN5uopjV958BUkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m3HEGqGCIq4=:Kx+G+VrYi6EHjvvIH8Ch7n
 AEGUAR9Pi3IMcmK/LpicWIBss1/Tr0/DN8QANpZw3rARFGErXzHD0qrvzgjwbS5T8NWgi1y0t
 AX1P8KvdecnlsQd5g53axTFI2Nc3XhSHZumBY0aWq3O90bDaCrZm1SUw8HG/flecKzRbHDJGz
 t99vpqJbszkI2vtWI6YdiRjKMpWOgIS69B+1W0bIycHsDmZXAi/o0iPPXm1EhACcqhDLn/q5d
 Vtb7BjOn2qprH/dDt17WEu57tlR1eEtAfW3ghYb0/2loSE38FhatTEK2EcbRQA0C39W5UguO3
 z8zagJZObBYtVsVUJ1y5yYQHPvkbKihPRJb5JyLtI96E5Zwm4YG1ot/mIEfHgZ2G2Jzr+eE/q
 VXZCrEBHl36q3XoEdvKRWwa86i2UEkCFU1zAeA+hZ2Al8GSe9e1q1zCdTZRE2qx+okz1TqkzF
 5WGM9WxPo8m+TOD7M1AnrYkL3Aw+N93LN/xlw/lQ7ftkxGGqD+vwjfgoM561jPHYtFCEfLALR
 e55j41ve8kcJ+ziaq0GBffE7htwUPSBctfA0Myh+gkISfR/RENjUOtOfzGgxGEp1MivCvG2RS
 /DRMUOLzMcmeYdBBa+G85ZDTlozYqrtMyAlkOwO/K9BQRr6v0rAqQ1/grTi71aq1YrAJMwO2P
 qhOKsxExxVlRhEtVmEDU4eiPDe5uVrJU1ovsIpH+O4QtwO5ytO5lUclxhFgB1kubBb3waRVX0
 JQeOM4f+iTCDW/cOr/tdVNf0kTVmNFUi+OLp2hRdLX3AcPOzD6EXZ+XJe6UwcyijcR/vAww1D
 XvsBTkhOv+vUaI4Od6xGRv7cZSj0/TBrCkRWKglllj44N2FyWevDR0Z4Gn8/o8YxdazvdOQ9d
 7y2laoKHoazpsrW96ETNMLli+zvkmxwA9yNk32AJ7cj7wR3AjJWIVFrlIwy3kXIqkk1Id+Nvc
 AvZlLUPOZAKiRrR7kjuX2jfYzxjv3uFw79B6SSYrXrRdCvTHG1ITQvFF/fjzsbB+WwxyO+JsT
 r51Q7S+e8CFyY5WEkAq57vcIgk89qZLOLLRQeDgI5v7heP6O/nxtzuzR4sqCAjvRWGIAy5ubx
 ZUoXNY/g2qDsIdZ+CrZfnbcbiTt0Y6feIMbi9pymsKfxNIQo2azZOqqvrsqdNQ5IXGuaQ+O83
 2ttaea2PNAJCjn+Bvvk6jdJQO3UlJNPwS16pUIaRuOBhvrKBn0y88/bdiw2wNFhAtjzM4G6lk
 jykuegPBId/yBsiVfANLR2yk4Psem6WPwvSATbwAuX3WBAxFwEct6n8Z1tt8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kVA5SFsRbwTnEqQsiHZVzTWCyNFAJZ6mA
Content-Type: multipart/mixed; boundary="orXYrovB0YrmZC89Z0Wnch2Sn1joDCpuX"

--orXYrovB0YrmZC89Z0Wnch2Sn1joDCpuX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/10 =E4=B8=8A=E5=8D=889:40, Qu Wenruo wrote:
>=20
>=20
> On 2020/1/9 =E4=B8=8B=E5=8D=8810:21, Josef Bacik wrote:
>> On 1/9/20 2:16 AM, Qu Wenruo wrote:
>>> When btrfs_update_device() failed due to ENOMEM, we didn't reset devi=
ce
>>> size back to its original size, causing the in-memory device size lar=
ger
>>> than original.
>>>
>>> If somehow the memory pressure get solved, and the fs committed, sinc=
e
>>> the device item is not updated, but super block total size get update=
d,
>>> it would cause mount failure due to size mismatch.
>>>
>>> So here revert device size and super size to its original size when
>>> btrfs_update_device() failed, just like what we did in shrink_device(=
).
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> Did you test this with error injection to make sure nothing else wonky=

>> came out of this?=C2=A0 If you are going to fix this I'd rather it be =
in a
>> different series because it's not necessarily related to what you are
>> doing, and isn't any more broken with your other patches.=C2=A0 The th=
ing you
>> are fixing in this series is important and I'd rather not hold it up o=
n
>> some error handling shenanigans.=C2=A0 Thanks,
>=20
> Yes, I have the same feeling.
>=20
> But sometimes I just can't stop addressing the comment that makes sense=
=2E
>=20
> And you're right, I forgot the error injection test, and it detects one=
 bug.
> In the error handling path, I forgot the re-update per-profile
> available, causing df showing the grown size, not the old size.
>=20
> To David, what's your idea on this?
> I guess the patchset can't be backported anyway due to new infrastructu=
re.
> I'm OK solving the problem by either removing this patch, or fix the bu=
g
> exposed by the error injection.

Gentle ping.

Any feedback, David?

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>>
>> Josef
>=20


--orXYrovB0YrmZC89Z0Wnch2Sn1joDCpuX--

--kVA5SFsRbwTnEqQsiHZVzTWCyNFAJZ6mA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4eubMACgkQwj2R86El
/qgyKQgAoVWMWRl3eupBbIZv6mRBJiG9RsXQOS7JIehYlxpDJGrpArNdFaGxHH4B
LqHi5OtbxHbW/GnUDQmI7hD016mXXTQwhfeXfmU32egFBhAqUHrFS0noGwLcQuQe
SouX2XX7tmCJ+4r1I20uPgw11h1I11C7/ZNHNj8VqhTGBxDJoZx7wn3NzBuceO2q
O5vFZzexWiU49FvDtmwsJM+ZxeIePUvevRvSZlS10K9GZbixrqDJA3l303jt/a2S
FduA/nQgVw8/az/AUhnTIS6GwwsYH17p7KJLa3xjl+TlL+caTbt5ihuijQydN4QK
zb04MiaYeitcmiGr6Luw4LO8Bkmpsg==
=druJ
-----END PGP SIGNATURE-----

--kVA5SFsRbwTnEqQsiHZVzTWCyNFAJZ6mA--
