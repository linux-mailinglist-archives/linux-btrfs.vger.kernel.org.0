Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A2270E70
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 03:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbfGWBFa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 21:05:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:54097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbfGWBFa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 21:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563843921;
        bh=4Dfu2fYii2YvhYcFnonvFlA4+3PrIGqusITHegaUaaA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZsZGKO9gTH8aVxQv3N7xOnNExIUJTSDj4BAyXoA5c61oJTVGahZeqczVNA2puu93B
         9z5tP6YwpvpEXw0E9UDRR9OygXijk+EyQ6op0+rY3IvvnuuRjJHLghWsHJjHqfRpm4
         ZtLd407nv6eKokFKaZeMjl4nmTMTWz+tF4vkPviA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mw9Q6-1ifURw0ScW-00s6FV; Tue, 23
 Jul 2019 03:05:20 +0200
Subject: Re: [PATCH 2/5] btrfs-progs: fsck-tests: Check if current kernel can
 mount fs with specified sector size
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190705072651.25150-1-wqu@suse.com>
 <20190705072651.25150-3-wqu@suse.com> <20190722170715.GB22308@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <8cb10c5c-3f5d-1e67-bc41-b6fdef35aa6c@gmx.com>
Date:   Tue, 23 Jul 2019 09:05:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722170715.GB22308@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l5NE9XUINuDuQAzuvYOIQaLWFbr1ZuBmv"
X-Provags-ID: V03:K1:ra2yvTgRfBFYOUSvFVmKHnh3XIsv9uKONKcBkzUfSqK9nMH4/hu
 8b5wfZyYCpMycTUFLQVqp68kbYY9sinFjP+NdB4hHszC2Zwxyv26RiqGK5xHSjPWbAx08Pl
 VgnxsHZga5L4cYjg+2zJuqnXu9KtShVoT4THSxHlmFgvTf+l/dfVVVWkpuu5mfNRxj5OoZM
 ocupYUgr4LqqXD+5RN+JQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:04dnaGhoBg4=:7dTg8Bs9aLmmwJnZ8osUU9
 MJGrYJKiitg45VdniogHq8+jaicBP74rzdETBgNhXHlOaLp4P6r9njZQA9IYhhfemRqibdBQS
 ynT3OjbG8iQFA+frFuckv7uSdU/mjRQUty19YopVhHZ7T9Tp4/8FFmoAbSICNdc5qaGJYaA9M
 iSXm6J/gS/niW9R2ZTiG58vx8/zJCWj9L1gaxVvoB+rJ4JQCUUXFbeWIo2dHM5duE/I+wR4Yf
 D5RTr9IXtzk8JYse2IwSAoGg9RvLJhUPY3YleWthx8VdNXW78IhxWm6q2LZsX58aBG65qivqn
 IogpO82w90+60QzweKefrSv/nva/Y8+1y6b6oCVJK+ctWc6xh1ruD3uho7bhFWrHp/33sJ0jn
 afSUDnUBd8RBfegSKaYUe6/wY1KGMncrWip39LvGPHCfgkTHffersREAb137D8E54qdwAncFW
 cckzgvvs4Clk5ZsB6HDeaCc0hlQVm4luqphfFDXEqiJPtN3fqmW0c536gwKi4qut0lSP2FoQK
 taChEFTzo/5S6w24DVDnKfsovOIdDOgkNFHdoJRnTQl5FEjoJ7N6F/1tlDcqKcx1Aw5MzGcmq
 b7UH3496BEFjFwVQ9tBtwYp92rB04KlufK7I0N//ZxWtxKE4JOj5L24Qm5CBVBDB4IK0L2Fdx
 uaWuv+ClbcT4u0VkEFdrfrW8qBzDWNt5FDw6zmkCCGpjmDkJv1vQzQo/lgmzYtyhhqMq2cH8L
 dwqFTJWuk0T444mYdyFKbcsOdybYVoIK6q0XHvibpiep0iX0KaoiI7cEla6gyiybvcmYLG6Z8
 KdITmT0k0z2th5DEj+ab/evDA+hxrrPPnXKzvoow9I1q7ovWrERsGEC82g6mT5yfcvoFpUlvd
 hzVlSdjIEdfK4l8HUtbrgp4kg4LUxBgckKOAYjeD1TKzA3A33aq9PVb0vnkl6O7ICnXuNV9T5
 Mk+tpdlCFAGDPQKh/wtSYUrLWlr5vD8CNfodvVsWwQNDx5MLYmAgdf5cluVJmu6tfYvRtNDuW
 OxxMIi9FhAlwRL0CK0eFCOYse7J4h76CYUqa7xDNNg2LUdTHoeYbEipqJ/axXRDFu/1DWxanF
 S3Tz+uSLN6ldIo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l5NE9XUINuDuQAzuvYOIQaLWFbr1ZuBmv
Content-Type: multipart/mixed; boundary="2hXfTrQpA5LsGWQiYLvXKPAIEeRwqF8tp";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <8cb10c5c-3f5d-1e67-bc41-b6fdef35aa6c@gmx.com>
Subject: Re: [PATCH 2/5] btrfs-progs: fsck-tests: Check if current kernel can
 mount fs with specified sector size
References: <20190705072651.25150-1-wqu@suse.com>
 <20190705072651.25150-3-wqu@suse.com> <20190722170715.GB22308@twin.jikos.cz>
In-Reply-To: <20190722170715.GB22308@twin.jikos.cz>

--2hXfTrQpA5LsGWQiYLvXKPAIEeRwqF8tp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/23 =E4=B8=8A=E5=8D=881:07, David Sterba wrote:
> On Fri, Jul 05, 2019 at 03:26:48PM +0800, Qu Wenruo wrote:
>> [BUG]
>> When doing test on platforms with page size other than 4K (e.g aarch64=

>> can use 64K page size, or ppc64le), certain test wills fail like:
>>       [TEST/fsck]   012-leaf-corruption
>>   mount: /home/adam/btrfs-progs/tests/mnt: wrong fs type, bad option, =
bad superblock on /dev/loop4, missing codepage or helper program, or othe=
r error.
>>   find: '/home/adam/btrfs-progs/tests//mnt/lost+found': No such file o=
r directory
>>   inode 1862 not recovered correctly
>>   test failed for case 012-leaf-corruption
>>
>>       [TEST/fsck]   028-unaligned-super-dev-sizes
>>   failed: mount -t btrfs -o loop ./dev_and_super_mismatch_unaligned.ra=
w.restored /home/adam/btrfs-progs/tests//mnt
>>   test failed for case 028-unaligned-super-dev-sizes
>>
>>       [TEST/fsck]   037-freespacetree-repair
>>   failed: /home/adam/btrfs-progs/mkfs.btrfs -f -n 4k /home/adam/btrfs-=
progs/tests//test.img
>>   test failed for case 037-freespacetree-repair
>>
>> [CAUSE]
>>
>> For fsck/012 and fsck/028, it's caused by the lack of subpage size sec=
tor
>> size support, thus we require kernel page size to match on-disk sector=
 size:
>>   BTRFS error (device loop4): sectorsize 4096 not supported yet, only =
support 65536
>>   BTRFS error (device loop4): superblock contains fatal errors
>>   BTRFS error (device loop4): open_ctree failed
>>
>> For fsck/037, it's mkfs causing the problem as we're using 4k nodesize=
,
>> but on 64K page sized system, we will use 64K sectorsize and cause
>> conflicts.
>>
>> [FIX]
>> Considering it's easier and easier to get aarch64 boards with enough
>> performance (e.g rpi4, rk3399, S922) to compile kernel and run tests,
>> let's skip such tests before widespread complain comes.
>>
>> This patch will introduce a new check, check_prereq_mount_with_sectors=
ize(),
>> which will test if kernel can mount btrfs with specified sectorsize.
>> So that even one day we support subpage sized sectorsize, we won't nee=
d
>> to update test case again.
>>
>> For fsck/037, also specify sector size manually. And since in that cas=
e
>> we still need to mount the fs, also add
>> check_prereq_mount_with_sectorsize() call.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  tests/common                                  | 29 ++++++++++++++++++=
+
>>  tests/fsck-tests/012-leaf-corruption/test.sh  |  1 +
>>  .../028-unaligned-super-dev-sizes/test.sh     |  1 +
>>  .../037-freespacetree-repair/test.sh          |  3 +-
>>  4 files changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/common b/tests/common
>> index 79a16f1e187d..5ad16b69b61d 100644
>> --- a/tests/common
>> +++ b/tests/common
>> @@ -306,6 +306,35 @@ check_prereq()
>>  	fi
>>  }
>> =20
>> +# Require to mount images with speicified sectorsize
>> +# This is to make sure we can run this test on different arch
>> +# (e.g aarch64 with 64K pagesize)
>> +check_prereq_mount_with_sectorsize()
>> +{
>> +	prepare_test_dev 128M
>> +	check_prereq mkfs.btrfs
>> +	setup_root_helper
>> +
>> +	local sectorsize=3D$1
>> +	local loop_opt
>> +
>> +	if [[ -b "$TEST_DEV" ]]; then
>> +		loop_opt=3D""
>> +	elif [[ -f "$TEST_DEV" ]]; then
>> +		loop_opt=3D"-o loop"
>> +	else
>> +		_fail "Invalid \$TEST_DEV: $TEST_DEV"
>> +	fi
>> +
>> +	run_check_mkfs_test_dev -f -s $sectorsize
>> +	$SUDO_HELPER mount -t btrfs $loop_opt "$TEST_DEV" "$TEST_MNT" \
>> +		&> /dev/null
>> +	if [ $? -ne 0 ]; then
>> +		_not_run "kernel doesn't support sectorsize $sectorsize"
>> +	fi
>> +	run_check_umount_test_dev
>> +}
>=20
> I think the reason why each requires the specific 4k size should be
> documented there.

I'll move the comment to each test calling this check.

> This helper hides several things, like forcing 128M on
> the default test device, mkfs and mount. Those are probably inevitable
> to make sure the combination is supported but the helper should be
> independent and not possibly interfere with anything the test could use=
=2E

The only thing may affect test cases is the "prepare_test_dev 128M" call.=

It can be easily avoided by calling this check before real
prepare_test_dev call.

I can update the test cases to co-operate this, and add extra comment
for that.

>=20
> The helper could be added as a separate patch, where the updated tests
> should document the reasons for using it.

No problem, and just in case I will also add comment in each test
calling this check to explain why.

>=20
>> +
>>  check_global_prereq()
>>  {
>>  	which "$1" &> /dev/null
>> diff --git a/tests/fsck-tests/012-leaf-corruption/test.sh b/tests/fsck=
-tests/012-leaf-corruption/test.sh
>> index 68d9f695d4de..d5da1d210f28 100755
>> --- a/tests/fsck-tests/012-leaf-corruption/test.sh
>> +++ b/tests/fsck-tests/012-leaf-corruption/test.sh
>> @@ -107,6 +107,7 @@ check_leaf_corrupt_no_data_ext()
>> =20
>>  setup_root_helper
>> =20
>> +check_prereq_mount_with_sectorsize 4096
>>  generate_leaf_corrupt_no_data_ext test.img
>=20
> So the tests with pre-generated images can't succeed so the test must b=
e
> skipped, unless we have images for all valid page size values.

Or after we can mount 4K sector size fs on 64K page size system.

>=20
>>  check_image test.img
>>  check_leaf_corrupt_no_data_ext test.img
>> diff --git a/tests/fsck-tests/028-unaligned-super-dev-sizes/test.sh b/=
tests/fsck-tests/028-unaligned-super-dev-sizes/test.sh
>> index 4015df2d8570..49fa35241d04 100755
>> --- a/tests/fsck-tests/028-unaligned-super-dev-sizes/test.sh
>> +++ b/tests/fsck-tests/028-unaligned-super-dev-sizes/test.sh
>> @@ -6,6 +6,7 @@
>>  source "$TEST_TOP/common"
>> =20
>>  check_prereq btrfs
>> +check_prereq_mount_with_sectorsize 4096
>>  setup_root_helper
>> =20
>>  check_all_images
>> diff --git a/tests/fsck-tests/037-freespacetree-repair/test.sh b/tests=
/fsck-tests/037-freespacetree-repair/test.sh
>> index 7f547a33512d..32e6651ac705 100755
>> --- a/tests/fsck-tests/037-freespacetree-repair/test.sh
>> +++ b/tests/fsck-tests/037-freespacetree-repair/test.sh
>> @@ -10,6 +10,7 @@ prepare_test_dev 256M
>> =20
>>  check_prereq btrfs
>>  check_prereq mkfs.btrfs
>> +check_prereq_mount_with_sectorsize 4096
>>  check_global_prereq grep
>>  check_global_prereq tail
>>  check_global_prereq head
>> @@ -55,7 +56,7 @@ if ! [ -f "/sys/fs/btrfs/features/free_space_tree" ]=
; then
>>  	exit
>>  fi
>> =20
>> -run_check_mkfs_test_dev -n 4k
>> +run_check_mkfs_test_dev -s 4k -n 4k
>=20
> Can the test be updated so it always succeeds, ie. giving it a valid
> sectorsize/nodesize based on getconf? Besides the hardcoded size values=

> (for the device and files), I don't see anything that would mandate 4k
> sectorsize.

Sure, I could try to test all valid node size combination based on
system page size.

Thanks,
Qu

>=20
>>  run_check_mount_test_dev -oclear_cache,space_cache=3Dv2
>> =20
>>  # create files which will populate the FST
>> --=20
>> 2.22.0


--2hXfTrQpA5LsGWQiYLvXKPAIEeRwqF8tp--

--l5NE9XUINuDuQAzuvYOIQaLWFbr1ZuBmv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl02XUoACgkQwj2R86El
/qgATwf+I16gqEnWglNtY2LLeSaN6Cfo0FH7W6sTBryUluvS8p8dQLg3VjQzuW5r
ojn53/FzfhayAx+RF9p70dubgxI0qW6AVSTqFuR0SGENCI9rFvw9MNzv65yUGKsq
mTbbFFTwTPZSdbSWyMlLIpKfjGcqgRsih38oJECv2wUN0tdfISaPQYOoTWhqTpTV
QvuIvBh5Uj9byaUBS6yXXktrzrqkRUmRTg+JB24/kgEMQ8SA1j5Qu4b8DZPmvwFe
XCGDGMidC61hKWTooyJGJadPePFxlnLAc+saMgij81iJlyIY/seEnfCM3tb+Jam2
ZrQaWBisv0t/x0PUJc5+lvQ9CM+jLQ==
=moVb
-----END PGP SIGNATURE-----

--l5NE9XUINuDuQAzuvYOIQaLWFbr1ZuBmv--
