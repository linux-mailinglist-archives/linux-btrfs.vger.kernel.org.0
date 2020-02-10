Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 069E7156D29
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 01:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgBJA3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 19:29:17 -0500
Received: from mout.gmx.net ([212.227.15.18]:39131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgBJA3Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Feb 2020 19:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581294550;
        bh=cggfV9LbpJQBPUOmcHm3Sufx6z56Ueks81V1fPYbPU8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IUxEJPUvS+7v9VThQYAVHZ2Hnzmy581BNmXIYH1GftqC+bJlSLrsDOCVtBGJYNJRn
         YTBA/dz4ZZHFdqUqEEuz/CbJSae1RJ1hc+c5zK/9J4+oF1B3dc53NYHl1/VwmPRZjW
         btwMsygkcGKRvf4vpV8ZTKNGzxLwfLttZVfJLV08=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuUj2-1jJ1jL33aM-00rZBB; Mon, 10
 Feb 2020 01:29:10 +0100
Subject: Re: [PATCH 1/2] fstests: Always dump dmesg for failed test cases
To:     Eryu Guan <guaneryu@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20200120070938.30247-1-wqu@suse.com>
 <20200209154840.GF2697@desktop>
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
Message-ID: <f6243f1d-3df5-3eb1-35eb-6e7aeb2a568f@gmx.com>
Date:   Mon, 10 Feb 2020 08:29:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200209154840.GF2697@desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mSBrKArHbciMTXK5PKKoqb26D5ybtpkM6"
X-Provags-ID: V03:K1:awnA9H0YnlOHosgJLb7FiJ6wrMwTGhhjjKZX+RtAjXG2fgJ4OqL
 PKMPqWc0arIpQgsiDmGb/RNmr/TDK+UZjX1OgSmEEFIq5j4yg9J+aNOUeiC7WQOFnvOz7RK
 uOBjnMQ7/YZQf/IeHOJlxGJsSK5Eg3I/XE8Zvw7i1YpS6Oa1f9lfQb7u2dn7/gRBxBmSHgE
 hYjzi+Z8ig7jxOW6Z/Fhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mQCGT0GzaZs=:dEO2gLvmI1fhHb7/d8Q2dQ
 D0gnwC5jlUV+OnBUIodiLVbnYqRnQI+0KmqQPer7yAwxL6hiV7DZKVzGMp1wHLQJHV4ycBbZ/
 ZQCMc7dSEKndAMhuDoA2ZWcb8+pc2tAGVKKhIBVR6h5F3AlL4GaP2OYwsV5Ov/X01EZEgFvN9
 twHkhxGRKCca43xRakYzkVLXRENjHbsyPBye3pv/wTKtv1oMs+yao2yg3qW+bgsHlWGu0D46N
 u32UM4RwIk9mFFi0DUxAcz2uv7KQNc50LTDHQSNWuaLYNI2MYPPU2TnrmGcXe9hgyHuKtlBEg
 nWCijMcBcHd5DYCOg3kom8Cwb72pvMwsf0zz8yLQ5+fwp5LLikAu6x5X1pi7+x/GWDY41H3jp
 H3zNNafl49HhrNSaC1HMIiwTrOKUfc/VbhabW3NB4t4DZtrMhyc5dSaE+goI0du+zTfDFfG41
 rH+P4cQ/iws1E0IiqPHGzTG8+dNXqonQgGgqBnWRKfUJws+AHzgILWkTFTPUELMh9yOOTOTkD
 kujMvv4cunCH4c9Mp9NROYeTI4YnrJghv2H3DCdNyVSGhVK965k9QBVjhhDI8WtQkaKjUSltU
 ZWapDyg4ywUavF66CAjpxKkAtc3oTXg137xE/aqqQ+AgXs+D0cXLen9WPoPWDHOuttvyIbXBy
 qlXLwxTyeryzN4UrY4GnWnByoJBSGgRgmK7+F0k41B74ZOwpWgpsg4A+1XADSJD3FAoJo53Pw
 GjhF3a9DfFFmbqXeBQYnqNHCIfO8A4csm2sLDgfcL0TnYsItv8EP+1ixxVEeKe7IAHLOTuzAz
 KmPjjsj+x2o/2nEJtObyqFU6cQwt2PXZjNQ+vRRNbs5xC73IYS2o9O05k6HcN/lTZYoGPkLX1
 4cY91DG0YCzdFuoAzDMpoaUYQPImDQcG3hoZ1EePuVRwrKRsZQ6tkycMfzdGBg267D6RVN5CI
 zzlG/E/gJKbEkSCRcKCi1opGJpgn4mkW/MmPidQX76FC1l7cm/U5eg/58v1iZS/MYux8ZrFDw
 lMsvgRgJ8IMfxmm8M6S5oTcwTBl2sa+bErRWCI9jKvZW9DSFBZ4QnUPTxYdw020Zu0NyyLIaC
 3rBibmffeaSsisgPwhgsEoTnv8wHxrSY7Vm/D9wYt+ZcMcq+9jLksllQlOUodMzoKMfvN0/9b
 pWfFkGWeyN9B9qASJSDdvBWkK1n4bj60s4I6+C8l4yrgeWUrv0srY8LlYAriA7ZaSNevkQ6ca
 yFX9dxsaWMuUIA8Ri
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mSBrKArHbciMTXK5PKKoqb26D5ybtpkM6
Content-Type: multipart/mixed; boundary="IL0Cnch6ZeCJzmKO1COFp0WImLcl7z4gA"

--IL0Cnch6ZeCJzmKO1COFp0WImLcl7z4gA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/9 =E4=B8=8B=E5=8D=8811:48, Eryu Guan wrote:
> On Mon, Jan 20, 2020 at 03:09:37PM +0800, Qu Wenruo wrote:
>> When hard-to-hit bugs happened, we really want every piece of info to
>> help us debugging.
>>
>> Although we already have KEEP_DMESG config, not everyone is utilizing
>> it, thus when hard-to-hit bugs happened, one could only set it and ret=
ry
>> until next hit.
>>
>> This patch will change the behavior by always dumping the dmesg for
>> failed tests, so that developers can always get extra info from any
>> failure.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  check | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/check b/check
>> index 2e148e5776e5..e580b2249f06 100755
>> --- a/check
>> +++ b/check
>> @@ -840,6 +840,9 @@ for section in $HOST_OPTIONS_SECTIONS; do
>> =20
>>  	# make sure we record the status of the last test we ran.
>>  	if $err ; then
>> +		if [ ! -f $seqres.dmesg ]; then
>> +			_dmesg_since_test_start >$seqres.dmesg
>> +		fi
>=20
> So this only saves the dmesg of the last test?
>=20
> And I don't think this is necessary, even if it saves the dmesgs of all=

> failed tests, this behavior change requires some more diskspace and may=

> fulfill / more easily.
>=20
> I think if one knows he/she's debugging a hard-to-hit bug, set
> KEEP_DMESG. Or again, make "save dmesg of every failed test" a tunable
> behavior.

Makes sense.

As I just went the same solution.

Thanks,
Qu
>=20
> Thanks,
> Eryu
>=20
>>  		bad=3D"$bad $seqnum"
>>  		n_bad=3D`expr $n_bad + 1`
>>  		tc_status=3D"fail"
>> --=20
>> 2.24.1
>>


--IL0Cnch6ZeCJzmKO1COFp0WImLcl7z4gA--

--mSBrKArHbciMTXK5PKKoqb26D5ybtpkM6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5Ao9EACgkQwj2R86El
/qj0xgf/Slc2ohAEEpb0XHKhbSDITdzh7jMB3AuhdscaFNa/c6v9O7ZGQprnOLlZ
MHEc2KuIKH+2udIBGNbc17aCZu7pYLLQeXCxt82C+kXphkBcGOFrt3JMCZm4XcMe
sIeqxF4y/JMIEDDgAgBwhdymhAua7k5df/IWq0haiiQHdA0CCOz8Q0ELpdzAfiLR
z8p0T1RxxMIdnu3HpfYMiYRX8WNo/W16VxcobDxrCdaAdxJuGl0aUlQNEiwzZy9z
s0mtuTmZrFKI9MMU4zgrACsQlk/lz7OaGYKrnqr9qTa//W1LYJhq9+f+puFgIhAc
Tq39PPJRkkwtsmmuYpWMFbKmKZJMPw==
=WiLC
-----END PGP SIGNATURE-----

--mSBrKArHbciMTXK5PKKoqb26D5ybtpkM6--
