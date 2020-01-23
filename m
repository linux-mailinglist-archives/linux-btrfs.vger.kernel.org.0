Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A7E146A07
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 14:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgAWN6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 08:58:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:57981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgAWN6H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 08:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579787878;
        bh=+uTmqEfbzugD/hMxXUPSzY3h90bf36rJGLArwFN1gVQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hy3sK4xozKUMfaDno6D9l7MWHAWxG2OiHVzLB4o1HScrNq8u6UVCsKPUbz5O/l0ql
         gXs94w+abJVQD1u73+Py9B2mXQy4e3W0m/2s6IWlONaFDwf2DsQvWjbzz1ohBCsMoI
         mbW4P1iBdodumab6rI37A4GUCg37M+J+pzNrz8YA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N79yG-1jfqMD3XVE-017SJD; Thu, 23
 Jan 2020 14:57:58 +0100
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
To:     fdmanana@gmail.com
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200123073759.23535-1-wqu@suse.com>
 <CAL3q7H4ed9PtALC_xjPeaiKDDhAN1oNzgM0yd=buF_C5r+x7wA@mail.gmail.com>
 <f32340f7-7e0c-e6fe-3122-4d8e8cab9257@gmx.com>
 <CAL3q7H5NudsNQZo+W1mJ26VxFTrowpqAH7soE0j3F2GTygae8w@mail.gmail.com>
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
Message-ID: <e2002d7e-daba-9fcb-0442-2feddfa7ec30@gmx.com>
Date:   Thu, 23 Jan 2020 21:57:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5NudsNQZo+W1mJ26VxFTrowpqAH7soE0j3F2GTygae8w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Pa16pgGaHGbOXqZxkXY2IfTPiDCUxcTgJ"
X-Provags-ID: V03:K1:+QZO0uTwsm13Deka9Yo0PR5uV5nx9quo/reuGS+wFWcl4MiCA0t
 qUCWKTR3mwTAzwk5nLO7E/4VISyBtvacTOxyBlXqNW2MVyvEqifGBH09yJJ5Kuiy1PV8RQy
 hzKlO6Fii3Hc9ygg6aZNjoX4ZZkm3FyjN+G6C5xfm4kHVTnqNsde013+J8uOFYav2vLBCCF
 lxnGimnqI6FShRKPQqwCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1EfoQ7g1fXM=:jZ4/YVp3UaNktT4IDjutx5
 ZUN7f0HBvp2Non/hmFOfQqg4Ql19Z7wt2Rn6PxsUE6Dwjy5C5c3PtnLAK7aFhtsarkuEqCegU
 WIfMedH24K4ZfCAecbLEUblH8syGpf4q7DDAaMMibuzc6Jnnq1657EdaHs1fbmAGmIUjCpHlF
 hQN8Al8lqEHCrs65fDAF/iQZcZgjzBg65wEyMbOpS2ry1K04j4a1SJRaVUJhs2bcgKUy0BtXA
 E9U21o/A5cwU0veVGIgRcnUzuKPKh8iRVX+xr4+md7DzyL3L0mC1XK1cs+fEGo1ikPX/6Wws8
 6vawrRUt807QufHXDGzPMzOUw8VuVWpvEQ8rgttaUrJpVLsO1651lWwXMIwpWL15A/aevgNBF
 BRIsQ+wlKoerCfXYkm+UwrW9SppkE5T2EageU1myH/31GrWZvz3PtIsOuxuSo31V8A79VZyqy
 7UmVFsaCFSi9VYuL0GklHPelcErNn5J0AEXpx+jzulPgVxtMW06u42Xl/gaLmSvGFl5piZo5H
 33C7HFXy+tYMjfSVnFa2AJBCxRLCkLTnySkITnrwLn7gp0Qdid5zI5axLsFNQY7p//r81iMgS
 /R2i0XNc0DH8l/rOQxl3x0LLkA1alsLMX+8yr4e5kcfe04c9Eg/IFEt6ZfBJBLoj10+V1UPXW
 ohYpob7W5e90wP6ecVSM9O6RccOMP+P5EGke/jPTenbqMpWdnJNdHf71S8YtQxZHCRSnm9TEO
 Q0C7Y+fVNk/vLxghHxL55BTI03GRqDcB7slDKM6XBeryx4cdCiko3haQY4Jx0uPo0xebfTPG4
 Vt60FSY+2/iCH/5BASIwBn9SJqs08HO8gp3uy9mmT9RDpwUozOwB+WcXXaWu238jX6z0blU4F
 yH55aVQqVFDAV12sEx4nFwmtVFsfe8tBKfVKUm+Uw16XxdGZbORoYWfXneOWed6yB331khYAd
 ABr6hw8DHG7sQbSa8Z64YmJuYC9whi07bx9ucZ3U/O6YQT309YelCpOHBTzZhIW3lwkK/90VF
 zwpHfhHh4+WEU7lHytTs8serCDfVbsbywKEltJm/acwfxygDAfxhrWqLRaIrDhcZh0FeRxK04
 g7VKQy1KXV+yd0r+dkco7CkY2zbYc3fPk6AP++Dh489KSDigepNS4VB7iLXkwfMD+kB+qn2j7
 E05Lg1qF7DWJqG6PUVVyrhIM+gQ5t19zCW+o/A5TV5NZnuKfuaSb24z/ksISCIim/XSkp2Ftp
 G2mk3QfBhNPs4X/QG
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pa16pgGaHGbOXqZxkXY2IfTPiDCUxcTgJ
Content-Type: multipart/mixed; boundary="XLwIrUb3kbIam3WBPxlD3yi9YkzDmzEjD"

--XLwIrUb3kbIam3WBPxlD3yi9YkzDmzEjD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/23 =E4=B8=8B=E5=8D=889:49, Filipe Manana wrote:
[...]
>> This btrfs_wait_nocow_writers() is not just triggering ordered extents=

>> for nocow.
>> It waits for the nocow_writers count decreased to 0 for that block gro=
up.
>>
>> Since we have already marked the block group RO, no new nocow writers
>> can happen, thus that counter can only decrease, no way to increase.
>>
>> There are several cases involved:
>> - NoCOW Write back happens before bg RO
>>   It will increase cache->nocow_writers counter, and decrease the
>>   counter after finish_oredered_io().
>=20
> Nop. nocow_writers is decremented after creating the ordered extent
> when starting writeback (at run_delalloc_nocow) - not when completing
> the ordered extent (at btrfs_finish_ordered_io()).

Oh, right. The dec part still happens in run_delalloc_nocow().
So the wait_ordered_roots() call is still needed.

Thanks,
Qu

> Same applies direct IO.
>=20
> Thanks
>=20

>>>
>>
>=20
>=20


--XLwIrUb3kbIam3WBPxlD3yi9YkzDmzEjD--

--Pa16pgGaHGbOXqZxkXY2IfTPiDCUxcTgJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4ppmEACgkQwj2R86El
/qiPPwgApDc7KEjoixOjHodPqoTuEabJbathvR1jAC5D8Lcilr8tvxN+q6xZfqvM
CnjsNTlN/98WmbIP7MjjKz0IVHJ5n3ZC/+pGpuI5CB5BGp7/dqaBW7eMHgSbKOFC
oG2L4pM6pIwZ7Z1J7X80u+M7IpvJN97CUIQTP1PWSpTkoYIVQqrqCLxA27/aseoa
JrLpeEl62YQF1KDy3pUY0h6JpivAYyCPTvvBjR9qXq7Bwj8Sojzyj5KwGDCk7U+X
OJir2mvGpc/pz2Xig5K0QN2gJw1nkcyAxC4/xPiobtQ6QZjuEIMo10nCsCrXrxga
UvY4pObHLUlUyrdnte4PWV0uVKF6Fg==
=bVDs
-----END PGP SIGNATURE-----

--Pa16pgGaHGbOXqZxkXY2IfTPiDCUxcTgJ--
