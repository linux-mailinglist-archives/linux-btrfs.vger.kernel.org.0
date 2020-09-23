Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FECD274EBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 03:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgIWBzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 21:55:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:44013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgIWBzQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 21:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600826107;
        bh=XBI+vaXl/AyadSI92JSBqXccJG47lsYXLqeJNLz/B5o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W9fJkkCWWZtCJ8WT4cPeMZHtZEkPxVoqacol5peMnbGLHnBqlhOcL2bglhc5TYi/M
         YFgYajejDu2zbrX+U5mbiTR0cHDyLKzW+7qto/VmKn3o+1NjgmKV9vnwihQh8VsBSy
         h699XfkN7OPTbxQXs86HEdszeNBVRPl3MGWAmCKU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJmGZ-1k1RIp3W7l-00KBa6; Wed, 23
 Sep 2020 03:55:07 +0200
Subject: Re: [PATCH v2] btrfs: Add new test for qgroup assign functionality
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Eryu Guan <guan@eryu.me>
References: <20200922153604.10004-1-realwakka@gmail.com>
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
Message-ID: <de490dbb-6fd2-be19-54b5-7e4a4c5e10c5@gmx.com>
Date:   Wed, 23 Sep 2020 09:55:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922153604.10004-1-realwakka@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lCHTVn048Yvn5fXHtmJW0FXNo8tItfLSY"
X-Provags-ID: V03:K1:kfWfvHFA6RRAM9+9rANPdBiu7XMR+u/hL2kXIXNiXlpnT4c6afy
 GoUw967TpdStvwbaCxqiBseRjfwFC9dvoHfqZcXGlVsy5tl4injngf+ErDPmNQCr0gwB+yu
 6DRXAGq9V9Vk3Fzt3186L4KzAywiijnGJsvFpwQ5EqauyAZk8MPi3KhLgf3Y2KaBkFqDmUm
 GvBo/00d2e80Dw+BI4wAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EKQLV1ZtI98=:b9dBeREKE6ztGGsluEdY6J
 j9m60tXH9PypEf0vPNLeh0RKOS0y1mwdHwMig2xsOOkRAHnODiegHgKlO0OJTln9S8jboyF++
 mhQWyunn9+9G7vuMV7D+djAftk7RLFmXtTpw1cAdyMCovLH8O7SgXKZ9lxzo3O0LEbuE9b/8g
 B/WhqTQRXHYr80ZN9MnsQz82W0K3gVvM5VioAUA0KWTuyjChhBngUwv32PaTAF5z6eBsvuxaX
 mZsTl8bnl+NH/70ghm6/lpY5L35w0t+Y/rb/ziZFALIBb/qbTVqnXQnz2ViuC/PVE01qC8BXK
 ydUR8m8l+XUWvtA/z+t31mbThJtv8Ezaz8uMb4FC7Y4XTZV4DDlxCq9u+Vy1irPVr7J4gCjcu
 k/BBJZkW0crQD910Leqq1xK6yRTp6YK/Joq+/+kKb/IBHVvtQrN1P14QTx4qWVsWSOSNAGeli
 PuoBnAjjqFq0XpUggRoGcDFGmhtSkUGufTew+h/HJGQEAMPnzWAU04p1hEVkatFcwDY4bL2JL
 cozlPqKuMUkWsynUET6PYOsb3R31rfTRceHpJCMaz6UM2LapceS6msM+UL3v9bqjaLTWdsBQY
 H0ZXfKXl09W3D/a8WU3/WAAktsKeL/FnCiMb37IHmVPLFv0MAO9OayVXyvhR/N8siGgK3PCLv
 ha5T2s8vO7lrHWWelDBi5jw6SPeXiWrJbINvUxFSMiuJkyZjf7cWRqX1PXTtI/p/ijL+PQNOn
 GtCVT4ontuLDsK6JelrTSxKX4J2+N2uQqjYdCVTnlJ0BvycXTGCNh4UscGusHn7/HQYUzB+r9
 6LVkLqWiZpUrufQ5Q33v1ayIOWsftsLN/9vU9rWXmsH2oSPKbpW+XFVTfvqALfRfNYOAJafi4
 6vAgq92iyvqbIP9WFojMtQsseGy2UHilRHbHb5cogW8QVLsqHXryz4CClqp3k3K2k4iPmgppX
 3JM5/YvWwXg7UbrSuWi50WIG0p9vMLT2ZjKf/7NOYaKp6cvhbLOWV61HJHcMRE+20iWgrDukB
 i9psDnjBxapR/ECeZz/hsI0C2Au/nFu2MKCoVyyqhppXYt92Kl6D/p1hTkV+8NYmQW/1VM7lf
 iGuMYqAb6Iws39QH6GQ2uacOzxpfEM+vW9sToBM6DtG4xQhDJU7bN74h5gxkJ/STzPfz91uA6
 ShXkZkctXoRZ5A7fwoDdzUYnysYbFCA/0ODc7ziWWBtPUvU0uLqPauMucT9xdXLig4o2q1YHF
 zEge6EbxFfuV4Mjg2LjbizClK1aP7fw1UbLFzUw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lCHTVn048Yvn5fXHtmJW0FXNo8tItfLSY
Content-Type: multipart/mixed; boundary="8bZOQ1CoHgVe5kBznkss6zUXmQhDS2Kw0"

--8bZOQ1CoHgVe5kBznkss6zUXmQhDS2Kw0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/22 =E4=B8=8B=E5=8D=8811:36, Sidong Yang wrote:
> This new test will test btrfs's qgroup assign functionality. The
> test has 3 cases.
>=20
>  - assign, no shared extents
>  - assign, shared extents
>  - snapshot -i, shared extents
>=20
> Each cases create subvolumes and assign qgroup in their own way
> and check with the command "btrfs check".
>=20
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Eryu Guan <guan@eryu.me>
>=20
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2: create new test and use the cases
> ---
>  tests/btrfs/221     | 121 ++++++++++++++++++++++++++++++++++++++++++++=

>  tests/btrfs/221.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 124 insertions(+)
>  create mode 100755 tests/btrfs/221
>  create mode 100644 tests/btrfs/221.out
>=20
> diff --git a/tests/btrfs/221 b/tests/btrfs/221
> new file mode 100755
> index 00000000..7fe5d78f
> --- /dev/null
> +++ b/tests/btrfs/221
> @@ -0,0 +1,121 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.

So, "YOUR NAME HERE" is your name? :)

> +#
> +# FS QA Test 221
> +#
> +# Test the assign functionality of qgroups
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/reflink
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic

It's a btrfs specific test.

> +_supported_os Linux
> +
> +_require_test

You don't need test_dev at all.

> +_require_scratch
> +_require_btrfs_qgroup_report
> +_require_cp_reflink
> +
> +# Test assign qgroup for submodule with shared extents by reflink
> +assign_shared_test()
> +{
> +	echo "=3D=3D=3D qgroup assign shared test =3D=3D=3D" >> $seqres.full
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT

I'm not sure if _run_btrfs_util_prog is still recommended.
IIRC nowadays we recommend to call $BTRFS_UTIL_PROG directly.

Test case btrfs/193 would be the example.

> +	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
> +
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT a)
> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT

"btrfs qgroup assign" can take path directly. This would save your some
lines. E.g:

  # btrfs qgroup create 1/100 /mnt/btrfs/
  # btrfs qgroup assign /mnt/btrfs/ 1/100 /mnt/btrfs/
  # btrfs qgroup  show -pc /mnt/btrfs/
  qgroupid         rfer         excl parent  child
  --------         ----         ---- ------  -----
  0/5          16.00KiB     16.00KiB 1/100   ---
  1/100        16.00KiB     16.00KiB ---     0/5

> +
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT b)
> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT

Shouldn't this assign happens when we have shared extents between the
two subvolumes?

Now you're just testing the basic qgroup functionality of accounting,
not assign.

For real assign tests, what we want is either:
- After assign, qgroup accounting is still correct
  We don't need even to rescan.
  And "btrfs check" will verify the numbers are correct.

- After assign, qgroup accounting is inconsistent
  At least we should either have qgroup inconsistent bit set, or qgroup
  rescan kicked in automatically.
  And "btrfs check" will skip the qgroup numbers.

But in your case, we're assigning two empty subovlumes into the same
qgroup, then do some operations.
This only covers the "assign, no shared extents" case.

> +	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +
> +	_ddt of=3D"$SCRATCH_MNT"/a/file1 bs=3D1M count=3D1 >> $seqres.full 2>=
&1
> +	cp --reflink=3Dalways "$SCRATCH_MNT"/a/file1 "$SCRATCH_MNT"/b/file1 >=
> $seqres.full 2>&1
> +
> +	_scratch_unmount

Since you're unmounting here, why not keep the _scratch_mkfs and
_scratch_unmount pair in the same function?

> +	_run_btrfs_util_prog check $SCRATCH_DEV
> +}
> +
> +# Test assign qgroup for submodule without shared extents
> +assign_no_shared_test()
> +{
> +	echo "=3D=3D=3D qgroup assign no shared test =3D=3D=3D" >> $seqres.fu=
ll
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
> +
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT a)
> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
> +
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT b)
> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
> +
> +	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT

No, we don't want rescan.

And the timing is still wrong.

> +	_scratch_unmount
> +
> +	_run_btrfs_util_prog check $SCRATCH_DEV
> +}
> +
> +# Test snapshot with assigning qgroup for submodule
> +snapshot_test()
> +{
> +	echo "=3D=3D=3D qgroup snapshot test =3D=3D=3D" >> $seqres.full
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT a)
> +
> +	_run_btrfs_util_prog subvolume snapshot -i 0/$subvolid $SCRATCH_MNT/a=
 $SCRATCH_MNT/b
> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT b)

Even we're snapshotting on the source subvolume, since it's empty, we
will only copy the root item, resulting two empty subvolumes without
sharing anything.

You need to at least fill the source subvolumes with some data.
It's better to bump the tree level with some inline extents.

Thanks,
Qu

> +
> +	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +	_scratch_unmount
> +
> +	_run_btrfs_util_prog check $SCRATCH_DEV
> +}
> +
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +assign_no_shared_test
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +assign_shared_test
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +snapshot_test
> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/221.out b/tests/btrfs/221.out
> new file mode 100644
> index 00000000..aa4351cd
> --- /dev/null
> +++ b/tests/btrfs/221.out
> @@ -0,0 +1,2 @@
> +QA output created by 221
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 1b5fa695..cdda38f3 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -222,3 +222,4 @@
>  218 auto quick volume
>  219 auto quick volume
>  220 auto quick
> +221 auto quick qgroup
>=20


--8bZOQ1CoHgVe5kBznkss6zUXmQhDS2Kw0--

--lCHTVn048Yvn5fXHtmJW0FXNo8tItfLSY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9qqvYACgkQwj2R86El
/qjbhAf7Bk/E7QDqlptZ57tKcFSf2LVomW3R4Xu+LWAux7KJFfmaCzy1BYKqAXd+
bKVhLdMXL4xdtMxg02OgjxEXp9WplIABaf4LujCg4optO5JY1IuHMcid6Rd9GVPj
ntRltZnJsIimw9KGRYr5xkJOKm3Zx6HnifRo5jT6Yi2svz5/IMWs6CAz+8f3CuDM
hlIM5yBn3EcPldjZL0zl3irimYDIlQ6thDqs4sZOBGAjeJLIuST2L8s+6r9UN1qh
DckKEEziZ5mvCEKL7FTjh/HzDoPTcFGQMqxcniASYTmXFfRuto8fpWgJfBoJB4X5
nqdblDuyh4y9BXPqbPCB9jS4A1wZEw==
=KMLo
-----END PGP SIGNATURE-----

--lCHTVn048Yvn5fXHtmJW0FXNo8tItfLSY--
