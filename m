Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6ED3B5E72
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfIRH5s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 03:57:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:41039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIRH5s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 03:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568793455;
        bh=mikQQizOgSrb2h7+/lo2/Muo1lA04XQ4CsFh92QE9vs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BZv6KNpFjhB2G4uY+Q7eZgorXIWj+Uo68/IPPZIOVq0z1JnJvrub736qwpFAFLt2b
         fYxktWhbeeOxvRlbgDlINVSX58SjA/jvaqKGFAhxr1MxAXBo2TCDpNVwa63hc5oHJo
         sJAJGY6I4jDbrjzn6zHVYf3BlRWba9Iq42P84nps=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Lx8OH-1i7o1f3BKD-016kAF; Wed, 18
 Sep 2019 09:57:35 +0200
Subject: Re: [PATCH 2/2] fstests: btrfs/011: Handle finished scrub/replace
 operation gracefully
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20190918065626.34902-1-wqu@suse.com>
 <20190918065626.34902-2-wqu@suse.com>
 <2b6c6153-d4e0-f776-2c7c-4aa4c6331b39@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <272e4631-f38f-496b-40f5-b39561314872@gmx.com>
Date:   Wed, 18 Sep 2019 15:57:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <2b6c6153-d4e0-f776-2c7c-4aa4c6331b39@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IZnAvDqPhWzEHlqLiAxr8Y82yNduXA6kN"
X-Provags-ID: V03:K1:gkjS2pNuL9BFVGxqQRBkUWGPxwsJD1wUhjaYz8CuWt12ma7weyD
 66KG1myCAx5qb5CJ7H8GCKQMcgLN0FoOzKLFouhnVtTEcShFoI0kKMSU2lMIrrQcEElQoz7
 xvpvK4M35U67nEgfbiAs+17RHu/O+2J+9LPP4+dKwu9LzDu/s4rrkTw5RXjrNOnQQ/rvXYh
 294Tl6z3Nc6npziFWmaDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ajRy7YWmDqk=:gKKjQzWeqPdjo9ymH2PH/c
 VyIyB2j1l0GL2gc9QzpLfU6CBxUt+L7fdhAQJYP+7PZy6Hwkh1A2JnK06ThMP2M8cAIu3JQej
 KMxsDsKD2GKGoD8AOWFchjxnGwrMWSAQKD25+5zdObBINSRZHEeYbJ03HwuBWxyMNSgw+TNhe
 I1Y04SQ77imzFHRRImZVUM8plwjHeiX8Is/J7EYoG62lte8Q6pqSJykLqyRIOBUgaXmqyh9fX
 2vXY0ygwHopscKfh9Q4IF1XrbhmhkXcG5FM4CTzxRYZTDLeK4d0pXWxkG/xr49/s6sHNJbhHg
 uwOcd76ZFcGyQ2oj34aOtZZy2n915b0l/D8nfteWWxMm6JMKMLh380MreG1zEo7yBzDa/EhNc
 ru426vK7gqeWRV13jJAFmqFEFNSGtraVEdOBphND/pFXYYkPMl6QZKFzNaNXbwkbI1Nj7QNzi
 lqIxW4iqhFpD6zqjVwSNihnlmX3dZmva4QX4pdIu3TgiJD8xgMJi73Rz5neZSj/xKf5I5SpgC
 9+ink0Aph/Ixn5LRIo90vcaZRZO3qjrh7GHd6fR214QEq3KlCpyJ3xRWlDor31aArcHQhQWBM
 YWkKsnfvX+uXGmariSxnYF15E/orcRqzgA1CeDO2bfZ9Lpr6hLdCg+1fIT1SYMzwqA9tj4Eor
 X2CWa4Iq5K1MH4XabujaXQPxvHm1uRBpf3YYedo1hm3Vi7HGQIaIpH4Pz7A0qwS5X5Bbrq8+2
 hkPpeFN4iH6gIdl3JWoDJ9MURPzJulWPKsccmay+QKxaudMQIgbO8QyH69izWAKccOJo/0we0
 cUVN+wG66k2Q63xd45OkMURgvcu2wl4Cn8X96zq7dlaLHafCgt5kMM9Y+KhjiYrMJ5JjyFpDz
 yV8NKvNvq181O+16WyYFwnJRGgYc0Dzkaj4yR8IA2tRrOm1sbnGr4KXKsznyNDKIa2Jgh7HCv
 5DTmQ7aGGqA1+DzOAuc3XNdy6FGLb4xGlrND2p4cGqv3TzwE8NYzz8Dpc6fphkqxDastf+jPn
 ePoSKrK9KzzVQZpswjk+k1zTP9cSvYZDVb3krAdY+1t1YZ8m3rJQKM8jYBLJAKal/wGcuohKK
 yPONT4sAkVmKgdHXtein1X3e38kVatupllFm8yk18VZ0E/CE5eSMyLV+V/zCTmbd+KVKnbwWf
 OBrHljMS9PezcTe2KqiRC3Btso7D4jPlH/Jv8WMNTizMSYULAzPxWyHoD0+dH46gQHPk1IxfE
 X83w5zZwYs3Ar+leaUCpWu88ItZ6tZ8utm552GebdcjbED9TegYvBOmEeHwc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IZnAvDqPhWzEHlqLiAxr8Y82yNduXA6kN
Content-Type: multipart/mixed; boundary="QYV3bekAidIfkebyOY3MASZvVMu0ZSTdT"

--QYV3bekAidIfkebyOY3MASZvVMu0ZSTdT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/18 =E4=B8=8B=E5=8D=883:54, Anand Jain wrote:
> On 18/9/19 2:56 PM, Qu Wenruo wrote:
>> [BUG]
>> When btrfs/011 is executed on a fast enough system (fully memory backe=
d
>> VM, with test device has unsafe cache mode), the test can fail like
>> this:
>>
>> =C2=A0=C2=A0 btrfs/011 43s ... [failed, exit status 1]- output mismatc=
h (see
>> /home/adam/xfstests-dev/results//btrfs/011.out.bad)
>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/011.out=C2=A0=C2=A0=C2=A0=C2=A0=
 2019-07-22 14:13:44.643333326 +0800
>> =C2=A0=C2=A0=C2=A0=C2=A0 +++ /home/adam/xfstests-dev/results//btrfs/01=
1.out.bad=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> 2019-09-18 14:49:28.308798022 +0800
>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -1,3 +1,4 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 011
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *** test btrfs replace
>> =C2=A0=C2=A0=C2=A0=C2=A0 -*** done
>> =C2=A0=C2=A0=C2=A0=C2=A0 +failed: '/usr/bin/btrfs replace cancel /mnt/=
scratch'
>> =C2=A0=C2=A0=C2=A0=C2=A0 +(see /home/adam/xfstests-dev/results//btrfs/=
011.full for details)
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>>
>> [CAUSE]
>> Looking into the full output, it shows:
>> =C2=A0=C2=A0 ...
>> =C2=A0=C2=A0 Replace from /dev/mapper/test-scratch1 to /dev/mapper/tes=
t-scratch2
>>
>> =C2=A0=C2=A0 # /usr/bin/btrfs replace start -f /dev/mapper/test-scratc=
h1
>> /dev/mapper/test-scratch2 /mnt/scratch
>> =C2=A0=C2=A0 # /usr/bin/btrfs replace cancel /mnt/scratch
>> =C2=A0=C2=A0 INFO: ioctl(DEV_REPLACE_CANCEL)"/mnt/scratch": not starte=
d
>> =C2=A0=C2=A0 failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>>
>> So this means the replace is already finished before we cancel it.
>> For fast system, it's very common.
>>
>> [FIX]
>> Instead of using _run_btrfs_util_prog which requires 0 as return value=
,
>> we just call "$BTRFS_UTIL_PROG replace cancel" and ignore all its
>> stderr/stdout, and completely rely on "$BTRFS_UTIL_PROG replace status=
"
>> output to verify the work.
>>
>> Furthermore if we finished replac before cancelling it, we should
>> replace again to switch the device back, or after the test case, btrfs=

>> check will fail as there is no valid btrfs on that replaced device.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 tests/btrfs/011 | 16 ++++++++++++++--
>> =C2=A0 1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/btrfs/011 b/tests/btrfs/011
>> index 89bb4d11..858b00e8 100755
>> --- a/tests/btrfs/011
>> +++ b/tests/btrfs/011
>> @@ -148,13 +148,25 @@ btrfs_replace_test()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # background th=
e replace operation (no '-B' option given)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _run_btrfs_util=
_prog replace start -f $replace_options
>> $source_dev $target_dev $SCRATCH_MNT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 1
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _run_btrfs_util_prog repla=
ce cancel $SCRATCH_MNT
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 1s is enough for fast sy=
stem to finish replace, so here we
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # ignore all the output, c=
ompletely rely on later status
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # output to determine
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG replace c=
ancel $SCRATCH_MNT &> /dev/null
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 'repla=
ce status' waits for the replace operation to finish
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # before the st=
atus is printed
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PRO=
G replace status $SCRATCH_MNT > $tmp.tmp 2>&1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat $tmp.tmp >>=
 $seqres.full
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grep -q canceled $tmp.tmp =
|| _fail "btrfs replace status
>> (canceled) failed"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grep -q -e canceled -e fin=
ished $tmp.tmp ||\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _f=
ail "btrfs replace status (canceled) failed"
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If replace finished befo=
re cancel, replace them back or
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # the final fsck after tes=
t case will fail as there is no btrfs
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # on the $source_dev anymo=
re
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if grep -q -e finished $tm=
p.tmp ; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $B=
TRFS_UTIL_PROG replace start -Bf $replace_options \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 $target_dev $source_dev $SCRATCH_MNT
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "${quick}Q=
" =3D "thoroughQ" ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 # On current hardware, the thorough test runs
>>
>=20
> Faced the same problem before. But I don't have a good solution
> to fix. Because the idea of the test case appears to test the replace
> cancel. This change makes it not to error if replace is not running
> in the first place.

Then what about _notrun if we find that replace/scrub finished too early?=


BTW, if we really want to test all regular scrub/replace with
cancel/finish combination, we should split this test into 4 test cases,
then we can completely afford to skip 2 while still allow the finish
cases to run...

Thanks,
Qu

>=20
> Thanks, Anand
>=20


--QYV3bekAidIfkebyOY3MASZvVMu0ZSTdT--

--IZnAvDqPhWzEHlqLiAxr8Y82yNduXA6kN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2B42gACgkQwj2R86El
/qjPkwgAitN5mXmIkv7wBsfbQTp1N1icZjWKRxR9H5Fn8lDnCg5EnMpQ6JfaNunw
DEQPIL2W2GX4rUQ78oZP8gFqz/Upi+G75Y022Myjo0KzzyS+rgLlo8OOnpSYVG80
9tv9v8Xbflu4MNI5XO+Je05Jd/ZunSW4Ru8kCf0BotflVCDqY3I4nRTQXMZhaeU3
WTgkOmvMXEGTryQTO+Z9zhLJoLMhU1x/CF6Ark/QPZIptwmAhx3NWSL7fITcK4O6
VJvtsy0oOkTJ6lixf9+y7GV1UFe6IaRRt4ROQxGyvADOo2+4o56cZgLo1dQzB2qF
V47wy5+KjaYdRKlXVew8RlRoJMr5HQ==
=Zig4
-----END PGP SIGNATURE-----

--IZnAvDqPhWzEHlqLiAxr8Y82yNduXA6kN--
