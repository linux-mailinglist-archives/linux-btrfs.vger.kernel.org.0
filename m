Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE7B6127
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 12:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfIRKMR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 06:12:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:45799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbfIRKMR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 06:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568801528;
        bh=USkFEAc/kar2q5SCV05Pdppx5e1UiLm6OJ2sYpd9YVI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XBD6BMwGdycZFHAR1j+z+r/55qNZ0dxuetK75mrqyhvaUvl+ccX9Sr1cP3cysVbXJ
         4FUTyNy0Enm5+VCH1Qt+PeqJcOdf4KTGBIc6xeGQXtppEDxRr8hIMwDuYPzSn+edVh
         69PobbXwgAgbeQqUJW4NsTd44bfl/6kGtoox/pGc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MKHtm-1iB5Af0K2w-001eV7; Wed, 18
 Sep 2019 12:12:07 +0200
Subject: Re: [PATCH 2/2] fstests: btrfs/011: Handle finished scrub/replace
 operation gracefully
To:     Eryu Guan <eguan@linux.alibaba.com>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20190918065626.34902-1-wqu@suse.com>
 <20190918065626.34902-2-wqu@suse.com>
 <20190918084734.GA52397@e18g06458.et15sqa>
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
Message-ID: <a4330728-fb49-b051-517e-9a36971394a1@gmx.com>
Date:   Wed, 18 Sep 2019 18:12:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190918084734.GA52397@e18g06458.et15sqa>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oaFs74FNEHU3lwNOplW4ruKi0m9i5IUcr"
X-Provags-ID: V03:K1:pBMoF4rAf6R2Y6vOZavgeJfimrsntFHPDRGUZAuVuuhcPZUELq1
 Kry+r41Rvxsm4XnFCLwrGN7lKWea2cNNORJK21sWE+tqGhgPwNFsjiluckzvDglD1MRwmG9
 xAuVlMdEh878YVcyzAhaY7oJVtYTW2Zz+VmEGO/85nAC+7um958cu9Sn0/q7LnUPjsmqS4A
 o7woFjHWMzDoGXK3ePUYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JobewiRu2g8=:9amzh8LvoG6Ykz6xSxARHI
 KDL98gfm9bqjWDBwpg0EmNoGJ2rgJ5AsHKuK4KObBt4QuETjgRxFIRu1z3cncFlIf2ijMOQ46
 xq+/c9ras6pFIigGQ6/ndB6ZgVMFzB6qEH5gUD/4/Pl1GinLdoKWloZgaqX9PILEBBoH0w2fl
 8Y4S//YuXs9wWvu4AXoNpTUo08rZH/Nh7av01fdoMx+wqA369VZ9xBYj2KapZx+XUibA30JK8
 wbfgDPRNPIC0N9qQx77Ddx+EAGFJj9flAGC+sjegCr4jJ5LMH/DSZ0kOGH4Ja7L1/BGWGJAcw
 2zXwwwWmzWhXRmODPQ2SJe86WPI9Z/3KuNUP7h2A/gelIiev6TV509oNuFWedHCxWEoLAsuRp
 Z2LARE7NIBsLeYbq+8oyXZjw7bqxdphQfunk3daVsSrtOl0KLGdhQklPdkeTW9swStE4VXgR6
 lzVHuTEaOStUdh7D3Bpi4LV/sJ8msJVqLbhRGcUXnfzbfMQd3DQeONvCbxbYWp7C+rSC2uXNM
 b9tlMzmoSuCHmWRBWVtyWRr3E6I0SmoyeIHwdRiht4ydLpZMjNErVSCe8Nmg9N9tMjbonXaqJ
 W/HbDnBVf4wT5A/y9XBdh6rDOb0f1OxD/MjQ/63YAGHUIGwbS4f6Q700ZgbRq3hcP2CuHlIIO
 ETvEKQfUqrbw57WsgvPTkxrsvUOPNUCMDst/16tYhzeb+B8UY20bBaN6Yy8R8z3M/ycovbCp4
 pMcJT2nyuux1Fm6k+Q07AHTFINIEiUi+S0wzdntc5n3SruPfwjdkYW0yaKPj17DRhRFmT4R9Q
 S2xPxHtZSwbsPC0ofeOUK/5DUMlEZXVhPsmOb2swDzIYHaOhyGGydlS3fEIQk2o64uxpfLDny
 JvIq7FBeZ3fKtaI5ebxE1qsRlVjAJn8wGH6jNHqsDbL9NLcVv1k1TtH9p0J1hf8wFMAIMQ2rD
 TathXgk+7kvrkUda2GKitNgWeOJp1DPO/4h0lr0AWBa4cVCjP7MKDcddf+21nxD2oDR/PydaL
 putMjwol2y9nFQjjMGnMc6b2+/ml7t/IPCU22JGt2dXQ43Tn9OXKfNZxD1vwZFXBZa/ZyNvkm
 SjW1TE/T2xKTuyaVXuSgHdcICggJboSKWH1rrVY4YkhynQj/KdtxPSBGliRf9HYMZNEdOX8HP
 AX9eLfnYyEpbBmH1QnEoRBoHK3pK7DSBPxI5qkvV3V7A9RCkY1wEjzGfWm8H/LYOlEAmXNsoA
 GyyC5I+eohHpjNQfd3LMdWlevufoIK/r1vI3QhpOIOA8QIbuoR5DzFMUyQtI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oaFs74FNEHU3lwNOplW4ruKi0m9i5IUcr
Content-Type: multipart/mixed; boundary="zNFmtSXEhqJUPgtM9TiyofspimBaEJSLq"

--zNFmtSXEhqJUPgtM9TiyofspimBaEJSLq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/18 =E4=B8=8B=E5=8D=884:47, Eryu Guan wrote:
> On Wed, Sep 18, 2019 at 02:56:26PM +0800, Qu Wenruo wrote:
>> [BUG]
>> When btrfs/011 is executed on a fast enough system (fully memory backe=
d
>> VM, with test device has unsafe cache mode), the test can fail like
>> this:
>>
>>   btrfs/011 43s ... [failed, exit status 1]- output mismatch (see /hom=
e/adam/xfstests-dev/results//btrfs/011.out.bad)
>>     --- tests/btrfs/011.out     2019-07-22 14:13:44.643333326 +0800
>>     +++ /home/adam/xfstests-dev/results//btrfs/011.out.bad      2019-0=
9-18 14:49:28.308798022 +0800
>>     @@ -1,3 +1,4 @@
>>      QA output created by 011
>>      *** test btrfs replace
>>     -*** done
>>     +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>>     +(see /home/adam/xfstests-dev/results//btrfs/011.full for details)=

>>     ...
>>
>> [CAUSE]
>> Looking into the full output, it shows:
>>   ...
>>   Replace from /dev/mapper/test-scratch1 to /dev/mapper/test-scratch2
>>
>>   # /usr/bin/btrfs replace start -f /dev/mapper/test-scratch1 /dev/map=
per/test-scratch2 /mnt/scratch
>>   # /usr/bin/btrfs replace cancel /mnt/scratch
>>   INFO: ioctl(DEV_REPLACE_CANCEL)"/mnt/scratch": not started
>>   failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>>
>> So this means the replace is already finished before we cancel it.
>> For fast system, it's very common.
>=20
> Does generate heavier load & more data make replace operation last
> longer? e.g. make more 'noise' by running fsstress instead of dumping
> /dev/urandom before starting replace.

That's a great idea.

In fact we can try to write as much data as possible for 3s (using
Direct IO), so that we know we have some data which will take at least
3s to read/write.

I'd take a try on this method.

Thanks,
Qu
>=20
> And does sleep shorter time (0.5s?) before cancel work?
>=20
> Thanks,
> Eryu
>=20
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
>>  tests/btrfs/011 | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/btrfs/011 b/tests/btrfs/011
>> index 89bb4d11..858b00e8 100755
>> --- a/tests/btrfs/011
>> +++ b/tests/btrfs/011
>> @@ -148,13 +148,25 @@ btrfs_replace_test()
>>  		# background the replace operation (no '-B' option given)
>>  		_run_btrfs_util_prog replace start -f $replace_options $source_dev =
$target_dev $SCRATCH_MNT
>>  		sleep 1
>> -		_run_btrfs_util_prog replace cancel $SCRATCH_MNT
>> +		# 1s is enough for fast system to finish replace, so here we
>> +		# ignore all the output, completely rely on later status
>> +		# output to determine
>> +		$BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT &> /dev/null
>> =20
>>  		# 'replace status' waits for the replace operation to finish
>>  		# before the status is printed
>>  		$BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
>>  		cat $tmp.tmp >> $seqres.full
>> -		grep -q canceled $tmp.tmp || _fail "btrfs replace status (canceled)=
 failed"
>> +		grep -q -e canceled -e finished $tmp.tmp ||\
>> +			_fail "btrfs replace status (canceled) failed"
>> +
>> +		# If replace finished before cancel, replace them back or
>> +		# the final fsck after test case will fail as there is no btrfs
>> +		# on the $source_dev anymore
>> +		if grep -q -e finished $tmp.tmp ; then
>> +			$BTRFS_UTIL_PROG replace start -Bf $replace_options \
>> +				$target_dev $source_dev $SCRATCH_MNT
>> +		fi
>>  	else
>>  		if [ "${quick}Q" =3D "thoroughQ" ]; then
>>  			# On current hardware, the thorough test runs
>> --=20
>> 2.22.0


--zNFmtSXEhqJUPgtM9TiyofspimBaEJSLq--

--oaFs74FNEHU3lwNOplW4ruKi0m9i5IUcr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2CAvIACgkQwj2R86El
/qgjqgf/f8Y4KNRBN6eKxH9hs40YvAS5xEYbijP7GzwR4irKcSmZxcdRVORnUEvG
31vTi1hx3njSOHJf/RXJr5juxvXxLapcApTGyEKcKmj+TjEBujAW1jbbTCu3KdTj
kNrIBmQtku/O2EgHuO0q6gd1XG4SkPZrbsY9m/HJHEELN3aTVeJLxzYhjE/Sy1lb
2i0FKGQO/EHRjqufcadAi14zUsm+tgKG1EANZWJSjcrEx3vkJcpxx8P0UFcQr6J3
deID+vdJCCslcjkX0q2eNFpYjWjE128Yrz7aPkYnK8f11oET+xAgeen2cJUCQ1CF
d0TAOHyuGCOZQp8IOa7gNWawWtKEjA==
=QqfT
-----END PGP SIGNATURE-----

--oaFs74FNEHU3lwNOplW4ruKi0m9i5IUcr--
