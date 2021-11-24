Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E549745BD0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 13:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245209AbhKXMfK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 07:35:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:46669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244497AbhKXMcK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 07:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637756937;
        bh=umPeZBoZEOcT4rfVs6eViQ0ntrZeRQeoL93WyBc+D2Q=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=R3slRl0sIhND+yMv60Hs76mGYyek0NIpZYR76F1MbrvQpXZm5j8Js4BlJy5LJ1Hyo
         G3g6tZh2qtuIpUKmXBBku3t/D0/x80CoTwNwOs79+WyAEo14WgFgyruxS4JZAS92Yp
         JGEUDGWLaUe/72rrVPBlVzhY1Bvx8Jz9CYng90k0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmDEm-1mPZ8K2Psu-00iEaE; Wed, 24
 Nov 2021 13:28:57 +0100
Message-ID: <e094e7d5-7f4c-2583-db85-fe296ce24528@gmx.com>
Date:   Wed, 24 Nov 2021 20:28:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211124065219.33409-1-wqu@suse.com>
 <CAL3q7H7FB96c753TniOvZwqqOvvT0MFiyjg0=Ev9wHThD4z-Kw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] fstests: btrfs/049: add regression test for
 compress-force mount options
In-Reply-To: <CAL3q7H7FB96c753TniOvZwqqOvvT0MFiyjg0=Ev9wHThD4z-Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XVBQo4AI52mJSz9QOGupT3KlyemLa368svbllcNmlGIWv7/JoG4
 2rivz4qwQeIB27nQkS9moiAA4827E564QmR8ftIWq8igGmVuyCoOCTCEaA1eSgMnSuhwovR
 fovdbYHok/mZQuAnU3aue1LpkJ+YB/Ka292CxOwWivSFnDvMfvbwT3iAe0p6WO+O1Mwq5EO
 7R8bmG5ndDvQPNTdO3b5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ibTmjLJQpFw=:fbiHEVGTxkFYj2bB/L8zyE
 L+0ZImFCsNK5xV0gdCDGaJ7DSlXlTaYqtEcgrR2Edfn0PSt4UyI6ut4ekRDJjkA97xvJ20nxc
 HHHeqkUJw53PGJyclO9qjpn5F5Mki0UpYtTxgAK9OhVoGrKQ9Z2zUC2iQyg0DopMbA/lYSEq+
 knLdFzl39PlUF66fxO5shpehSy8EYOmczmH6yAj3adw38V8iGrirdBdMVBLFPthkHfCaSwrAq
 1epHbdnUEvF9tRGjz2TSCcpu/TF64wNTGymqCF8HJ6K8UP/nC3djV73qR7VCuC3FPKzbuOMRZ
 M72mX6zwDZO2ZsTx63gzpw5kCgikfMOOBSusKmJWAoJtouxVOcmHNQbQ2fMxg6Q33OeFJ6fu4
 8M4svoV+8Uk02h4hckhI6eQe+6LPxf0sRWt7CNsmjUsh8blV5lCD7/pzOB/EAGVwYW6LGy/UI
 712kBndidmn9kqToaPDtQnB+Tz7B23qEyfPNJnwMg8HMfVawIowTXqfz80R2CJ2vLf7umvfov
 Z+mvLhTtXJIuXH1mPqW+DzlTMRi3UGiY73e3A/jZXu6FnsP0pCGx9yjXE2moUnDRd7ZmOqnsw
 AYj8xP/co3y/4kZ4aiEyfB+I98CtHEyfy8gNr+y9o8Pab9MUPk1j1qxyz75SXoR3/ETKQI/6p
 7nH/SW9f47XWv8TNhIEwmHgsjsefY8R80+LDRfCM0e/kcihjYeLYVyNcz/2NlBYqQzN+oULm6
 4KGdKdX4iA94iWIUO4um2JREXiyIpBvbkONxpgL84KlMjCPHpSGiDzTBKEwEUl+DQR1d45o6Y
 z4WY6M0z4Kw2rX9KAagvrWmklKjpRqoBw4lJ+kjq329Me4PPCVkaUTJc8aNLpA8J1B5+bCSjs
 eWO8YBn01QyPDntVzfHt5qeYoIYDUNlGF/8HIf5oTIr+kYuoKDchD3Xb1Bn77dmsVNmg2oleK
 phxzGlyFA2UP/RmtRpBJIT7Tu2YPN8wxjq1Ng5WNimKKdF/Kt34/slLx5nySUHZ2+SlNsY84q
 Vr/51X+B2hSXc8wE1SPs1fOJn9XNKKC85v+QH+bRt2OIkJXCe6dq2B8sFmQxmzVP0Ngn7RfLK
 sbpaWXhIKE+teU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/24 19:22, Filipe Manana wrote:
> On Wed, Nov 24, 2021 at 9:24 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Since kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress_pa=
ges()
>> compatible"), lzo compression no longer respects the max compressed pag=
e
>> limit, and can cause kernel crash.
>>
>> The upstream fix is 6f019c0e0193 ("btrfs: fix a out-of-bound access in
>> copy_compressed_data_to_page()").
>>
>> This patch will add such regression test for all possible compress-forc=
e
>> mount options, including lzo, zstd and zlib.
>>
>> And since we're here, also make sure the content of the file matches
>> after a mount cycle.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Also test zlib and zstd
>> - Add file content verification check
>> ---
>>   tests/btrfs/049     | 56 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/049.out |  6 +++++
>>   2 files changed, 62 insertions(+)
>>   create mode 100755 tests/btrfs/049
>>
>> diff --git a/tests/btrfs/049 b/tests/btrfs/049
>> new file mode 100755
>> index 00000000..264e576f
>> --- /dev/null
>> +++ b/tests/btrfs/049
>> @@ -0,0 +1,56 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 049
>> +#
>> +# Test if btrfs will crash when using compress-force mount option agai=
nst
>> +# incompressible data
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick compress dangerous
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -r -f $tmp.*
>> +}
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch
>> +
>> +pagesize=3D$(get_page_size)
>> +workload()
>> +{
>> +       local compression
>> +       compression=3D$1
>
> Could be shorter by doing it in one step:
>
> local compression=3D$1
>
>> +
>> +       echo "=3D=3D=3D Testing compress-force=3D$compression =3D=3D=3D=
"
>> +       _scratch_mkfs -s "$pagesize">> $seqres.full
>> +       _scratch_mount -o compress-force=3D"$compression"
>> +       $XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 $pagesize" \
>> +               "$SCRATCH_MNT/file" > /dev/null
>> +       md5sum "$SCRATCH_MNT/file" > "$tmp.$compression"
>
> This doesn't really check if everything we asked to write was actually w=
ritten.
> pwrite(2), write(2), etc, return the number of bytes written, which
> can be less than what we asked for.
>
> And using the checksum verification in that way, we are only checking
> that what we had before unmounting is the same after mounting again.
> I.e. we are not checking that what was actually written is what we
> have asked for.
>
> We could do something like:
>
> data=3D$(dd count=3D4096 bs=3D1 if=3D/dev/urandom)
> echo -n "$data" > file

The reason I didn't want to use dd is it doesn't have good enough
wrapper in fstests.
(Thus I guess that's also the reason why you use above command to
workaround it)

If you're really concerned about the block size, it can be easily
changed using "-b" option of pwrite, to archive the same behavior of the
dd command.

Furthermore, since we're reading from urandom, isn't it already ensured
we won't get blocked nor get short read until we're reading very large
blocks?

Thus a very basic filter on the pwrite should be enough to make sure we
really got page sized data written.

Thanks,
Qu

>
> _scratch_cycle_mount
>
> check that the the md5sum of file is the same as:  echo -n "$data" | md5=
sum
>
> As it is, the test is enough to trigger the original bug, but having
> such additional checks is more valuable IMO for the long run, and can
> help prevent other types of regressions too.
>
> Thanks Qu.
>
>
>> +
>> +       # When unpatched, compress-force=3Dlzo would crash at data writ=
eback
>> +       _scratch_cycle_mount
>> +
>> +       # Make sure the content matches
>> +       md5sum -c "$tmp.$compression" | _filter_scratch
>> +       _scratch_unmount
>> +}
>> +
>> +workload lzo
>> +workload zstd
>> +workload zlib
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
>> index cb0061b3..258f3c09 100644
>> --- a/tests/btrfs/049.out
>> +++ b/tests/btrfs/049.out
>> @@ -1 +1,7 @@
>>   QA output created by 049
>> +=3D=3D=3D Testing compress-force=3Dlzo =3D=3D=3D
>> +SCRATCH_MNT/file: OK
>> +=3D=3D=3D Testing compress-force=3Dzstd =3D=3D=3D
>> +SCRATCH_MNT/file: OK
>> +=3D=3D=3D Testing compress-force=3Dzlib =3D=3D=3D
>> +SCRATCH_MNT/file: OK
>> --
>> 2.34.0
>>
>
>
