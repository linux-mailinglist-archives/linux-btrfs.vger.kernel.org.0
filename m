Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C526156D2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 01:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgBJAaj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 19:30:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:41267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgBJAaj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Feb 2020 19:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581294631;
        bh=GGdynS1LQ/z3msVZqffC2S6i6d7k1iCfPJm1XUk0C4g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ie5GjPHHBfh+0i4UmLPYa15ZZp7qAdgBX1sOOWM/wVX6ADsK4fIHZ4pWHF6R8PzmI
         R+SqH6hFjr9JljaoeyZMCohcXMccs869jPIQsjFLm8fK4gv7f0d+BTNIV9sNYIhg4B
         IE98IOej7wiyqwZUQhQCkEJBWDpJEbVaAs+Ya+R8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnJhO-1jjs5i3ULk-00jHEp; Mon, 10
 Feb 2020 01:30:31 +0100
Subject: Re: [PATCH 2/2] fstests: btrfs: Fix a bug where test case can't grab
 the 2nd device when glob is used
To:     Eryu Guan <guaneryu@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20200120070938.30247-1-wqu@suse.com>
 <20200120070938.30247-2-wqu@suse.com> <20200209155255.GG2697@desktop>
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
Message-ID: <5068f488-72e0-4187-64e1-d8f53323abf1@gmx.com>
Date:   Mon, 10 Feb 2020 08:30:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200209155255.GG2697@desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wryjpwLhei6sZdOPOn96Dvu0vkEio5jhF"
X-Provags-ID: V03:K1:Ytt+d71sLTof6hp1jL0tl+TbxUegZF9kdvqijisUpEDDVmJkvaA
 PsEU63udVM/uLvDj7upou3SvO3s0oVHW3u21k6E0LlOLbgElY9Uk3XohkAbt6BNcmBqHbPg
 Nvuh9+QRQkQH/kaQv7XzWWhmnly3L0w+IGrmAj3weix5A3pY/Z691dBbniu6B1sKMdL5b5p
 EogF9eeJ0YXiQW5OEzn4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2EPqmW+OYPU=:jFPpRlzb2FWnFwgOsawShF
 J46JO7nNvRjiSnozkUeB9xkFjbciiKcFaEYuO7xEbMgJQbop0varcdQ5ZO+VfslILCkw3jcwb
 XH5kSZTvhO3GR4tS3DIX8N6QYslmD7Y0L1qeOOOv1/SQvTuUW2aJYQJd67vCL08EXhXjShCJ2
 OkVMGdK2teMfaIeiZgnen1j8Fyjwr8s73Zc/xTq/feUv9wwBFU7gJRAE2zLVdwEoh0m4/o3Ox
 NCzGKxK/JXgQ4bmak1L5uymGtPhFtc5uT8ZqK33gMIKwbCqf0edektXziYHVbLoS+VVcS2i/v
 sSpHsA44sWXBp5DYwauWPvq5X0t7N1Qu+6074lnB0kxjnLkIAon7ISbMr+SVWagWGWtik+11m
 +H27OT1BrGO1vIv+5BORqa+ZICz8zpDLf3cEf18rbs3bmJMj18ROAZAkKqzQpOT6GEwak/8GM
 EG3tDFRRBszJiMEIchAr/5Q/eXJGrJPp3ToosFk5Tn2d0b6N8i/hsPY4tguWwr39l5vyrH2oU
 TR+SqTPRUSzxelKpzWeRqvzUTIk/nzEzhAhGImw/MzIl0MbNJy6QIAscKmjaoVfSuAzboucz8
 Pr5mQesHOM7vZdERndO3uu5Qe4Q8gwqHIqQz4I1QpSSLA+r+hvtiGmZh1ngJvWF6eeqH1hvme
 RuimTaEBK2ikcj62b9buxqM7JMSSpoB2DUVYjBCqc5AcLxIGm11sAtdXEWbE9Ca3dRo0YXYOG
 loP30xvuOUbf9tWfLyNz4Y/q7SYHNRddXE0DmF3OB44iKimbYc/z8Tv0nhZoRNPhUHmkKdOCe
 Ye7mrKH5EnFiz8MVwe36sBwKMKrv3yTtaS/6/Kt9PxTChnvKqFn8vgV0Kco5QVHjiaIKYvecJ
 Ds224U8gU1Grd4wbMWSOedtMzOpttnPQY946xf0N0wkkgmRc3OipDKF0Ri/Arp+oaP5w6CY6f
 TFkHX3DGhEkBlNvRNSsSJGbG386n+xV1m/JXW9rU8wzUDn96KaOEJ2tbYa3pCuytoLwBk9XJZ
 vT7i3qsVADXXJkftqeCHh333KUOndX5bGbR1ArcpwpqHJR3JprkD9NDun3x6hz7uYXrNoElYR
 vh66q89TDed5CzoAGB2v0UV1IKgvw+UHfxPKj+Kb1pNgQpt8FwiunbsIv5BQmvhntBQMdIV7g
 zoV61ra1w6+y/YWgmlqnwae+6jIOv3pdi+4Bjs5Vj+skCuwBqoyY07d0vX/nb4Uw1cD+4+36a
 CwOxJxxjwH3GplyHM
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wryjpwLhei6sZdOPOn96Dvu0vkEio5jhF
Content-Type: multipart/mixed; boundary="0E9xMCoZ7dmkW9E7smndk0Tj0vF0Ph0xa"

--0E9xMCoZ7dmkW9E7smndk0Tj0vF0Ph0xa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/9 =E4=B8=8B=E5=8D=8811:52, Eryu Guan wrote:
> On Mon, Jan 20, 2020 at 03:09:38PM +0800, Qu Wenruo wrote:
>> If SCRATCH_DEV_POOL is definted using glob, e.g.
>> SCRATCH_DEV_POOL=3D"/dev/mapper/test-scratch[123456]", then btrfs/175 =
will
>=20
> I don't think this is necessary, and I think it's not a problem that
> fstests should resolve.
>=20
> Usually Config file is not always changing, setting SCRATCH_DEV_POOL
> correctly for once should be fine. A simple command could expand the
> device list for you:
>=20
>     [root@fedoravm xfstests]# ls /dev/mapper/testvg-lv[1234567]
>     /dev/mapper/testvg-lv1  /dev/mapper/testvg-lv2 /dev/mapper/testvg-l=
v3  /dev/mapper/testvg-lv4 /dev/mapper/testvg-lv5  /dev/mapper/testvg-lv6=
 /dev/mapper/testvg-lv7
>=20
> Then just copy/paste the device list.

Then at least adding some comment for how to set SCRATCH_DEV_POOL would
help.

Thanks,
Qu
>=20
> Thanks,
> Eryu
>=20
>> fail like this:
>> btrfs/175 15s ... - output mismatch (see results//btrfs/175.out.bad)
>>     --- tests/btrfs/175.out     2019-10-22 15:18:14.085632007 +0800
>>     +++ results//btrfs/175.out.bad      2020-01-20 14:53:56.518567916 =
+0800
>>     @@ -6,3 +6,4 @@
>>      Single on multiple devices
>>      swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
>>      Single on one device
>>     +ERROR: checking status of : No such file or directory
>>     ...
>>     (Run 'diff -u tests/btrfs/175.out results//btrfs/175.out.bad'  to =
see the entire diff)
>>
>> This is caused by the extra quotation mark (and the complexity nature =
of
>> bash glob).
>>
>>   # SCRATCH_DEV_POOL=3D"/dev/mapper/test-scratch[123]"
>>   # echo ${SCRATCH_DEV_POOL}
>>   /dev/mapper/test-scratch1 /dev/mapper/test-scratch2 /dev/mapper/test=
-scratch3
>>   # echo "${SCRATCH_DEV_POOL}"
>>   /dev/mapper/test-scratch[123]
>>
>> To fix the problem, remove the quotation mark out of
>> ${SCRATCH_DEV_POOL} or $SCRATCH_DEV_POOL for all related test cases.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> The weirdest thing is, only btrfs/17[56], all other related test cases=

>> pass without any problem.
>>
>> Maybe it's time to provide a proper wrapper to do such thing?
>> ---
>>  tests/btrfs/140 | 2 +-
>>  tests/btrfs/141 | 2 +-
>>  tests/btrfs/142 | 2 +-
>>  tests/btrfs/143 | 2 +-
>>  tests/btrfs/157 | 2 +-
>>  tests/btrfs/158 | 2 +-
>>  tests/btrfs/175 | 2 +-
>>  tests/btrfs/176 | 6 +++---
>>  8 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/tests/btrfs/140 b/tests/btrfs/140
>> index f0db8022cb48..0e6c91019854 100755
>> --- a/tests/btrfs/140
>> +++ b/tests/btrfs/140
>> @@ -65,7 +65,7 @@ get_devid()
>>  get_device_path()
>>  {
>>  	local devid=3D$1
>> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
>> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>>  }
>> =20
>>  _scratch_dev_pool_get 2
>> diff --git a/tests/btrfs/141 b/tests/btrfs/141
>> index c8c184ba29b0..5678e6513f80 100755
>> --- a/tests/btrfs/141
>> +++ b/tests/btrfs/141
>> @@ -65,7 +65,7 @@ get_devid()
>>  get_device_path()
>>  {
>>  	local devid=3D$1
>> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
>> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>>  }
>> =20
>>  _scratch_dev_pool_get 2
>> diff --git a/tests/btrfs/142 b/tests/btrfs/142
>> index db0a3377a1ed..ae480352c4d9 100755
>> --- a/tests/btrfs/142
>> +++ b/tests/btrfs/142
>> @@ -66,7 +66,7 @@ get_devid()
>>  get_device_path()
>>  {
>>  	local devid=3D$1
>> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
>> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>>  }
>> =20
>>  start_fail()
>> diff --git a/tests/btrfs/143 b/tests/btrfs/143
>> index 0388a52899c9..9e1e7ea0874d 100755
>> --- a/tests/btrfs/143
>> +++ b/tests/btrfs/143
>> @@ -73,7 +73,7 @@ get_devid()
>>  get_device_path()
>>  {
>>  	local devid=3D$1
>> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
>> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>>  }
>> =20
>>  SYSFS_BDEV=3D`_sysfs_dev $SCRATCH_DEV`
>> diff --git a/tests/btrfs/157 b/tests/btrfs/157
>> index 634370b97ec0..c60d05ce36f3 100755
>> --- a/tests/btrfs/157
>> +++ b/tests/btrfs/157
>> @@ -70,7 +70,7 @@ get_devid()
>>  get_device_path()
>>  {
>>  	local devid=3D$1
>> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
>> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>>  }
>> =20
>>  _scratch_dev_pool_get 4
>> diff --git a/tests/btrfs/158 b/tests/btrfs/158
>> index d6df9eaa7dea..179c620b223f 100755
>> --- a/tests/btrfs/158
>> +++ b/tests/btrfs/158
>> @@ -62,7 +62,7 @@ get_devid()
>>  get_device_path()
>>  {
>>  	local devid=3D$1
>> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
>> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>>  }
>> =20
>>  _scratch_dev_pool_get 4
>> diff --git a/tests/btrfs/175 b/tests/btrfs/175
>> index d13be3e95ed4..e1c3c28fe5a4 100755
>> --- a/tests/btrfs/175
>> +++ b/tests/btrfs/175
>> @@ -63,7 +63,7 @@ _scratch_mount
>>  # Create the swap file, then add the device. That way we know it's al=
l on one
>>  # device.
>>  _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
>> -scratch_dev2=3D"$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
>> +scratch_dev2=3D"$(echo ${SCRATCH_DEV_POOL} | awk '{ print $2 }')"
>>  $BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
>>  swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
>>  swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
>> diff --git a/tests/btrfs/176 b/tests/btrfs/176
>> index 196ba2b8bdf6..c2d67c6f807a 100755
>> --- a/tests/btrfs/176
>> +++ b/tests/btrfs/176
>> @@ -39,9 +39,9 @@ _require_scratch_swapfile
>>  # We check the filesystem manually because we move devices around.
>>  rm -f "${RESULT_DIR}/require_scratch"
>> =20
>> -scratch_dev1=3D"$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $1 }')"
>> -scratch_dev2=3D"$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
>> -scratch_dev3=3D"$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $3 }')"
>> +scratch_dev1=3D"$(echo ${SCRATCH_DEV_POOL} | awk '{ print $1 }')"
>> +scratch_dev2=3D"$(echo ${SCRATCH_DEV_POOL} | awk '{ print $2 }')"
>> +scratch_dev3=3D"$(echo ${SCRATCH_DEV_POOL} | awk '{ print $3 }')"
>> =20
>>  echo "Remove device"
>>  _scratch_mkfs >> $seqres.full 2>&1
>> --=20
>> 2.24.1
>>


--0E9xMCoZ7dmkW9E7smndk0Tj0vF0Ph0xa--

--wryjpwLhei6sZdOPOn96Dvu0vkEio5jhF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5ApCIACgkQwj2R86El
/qiJwggAov6j9mkNQpe3v9U+ljzxtXU2Ks39JKhvfQ7c4M9qSimbFaDFi4dxBlbP
yOn2IxUcTyyD8wRFdmayDoG4aHpFPRFmC5x1ZD/KKcoTRyTRH42glTxWn3Rl4czS
IqgQbhOubZq3Eamp6QyaAEOQJ5YCjfFQ9tCOhu+jyAh8xsG0q4a7zMGY/Hh5HofY
cHljm8T2OdF8rbEJ4Ql3NDxl7E6AHYISUHJ/yFki/CADxv8Xg5mRQoD0zMRGwQmO
4LGBcfPRo3gm62nsNDDyKFX3hwMLJDinZ3LvJr4YBzPw47J8UaExvYvldk1iqBRS
LGQiBIcF/dt92ZCJNpeqDghD92lr7g==
=JCPf
-----END PGP SIGNATURE-----

--wryjpwLhei6sZdOPOn96Dvu0vkEio5jhF--
