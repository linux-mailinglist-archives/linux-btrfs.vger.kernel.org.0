Return-Path: <linux-btrfs+bounces-2475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7028A8592BE
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 21:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA481F22419
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427B7F7E1;
	Sat, 17 Feb 2024 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mKBFCJgq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E0433A9;
	Sat, 17 Feb 2024 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708202358; cv=none; b=O5p5pY+L3aWK+VSilDchx28MHe0F1QSGgwfOZ9AJKxyrD52OviJb6O0n7OP8eJepMzKnewUFFj9ufSvBXEOR0TSjnwSeKv+OgOW3FumwWraA/rczTUFIukGGI78tnyLEEcee89Mmbi9yJ9euErDrpIsVUhk7u9DKsgyjcItUfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708202358; c=relaxed/simple;
	bh=5XHGfPMQ7QEK72tJR2yT0FWsYoGir0pOIQNrP63mse0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQkA9EwtZOUB7CxmVzXgjRRzs1Yl5U/gLIpaz++Sv98EvMEJ7s8lKaTmAm/vBlg3/TAlOBZFh9cCJHRVncy61kx6lARGk1ZtttFFOUwQn26CqEPRtsE0L9jwO2Pi8MyPTjMDC2YrjGZI93ta9p/B2A5ALQuR7zgp6cj3OIu4sHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mKBFCJgq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708202348; x=1708807148; i=quwenruo.btrfs@gmx.com;
	bh=5XHGfPMQ7QEK72tJR2yT0FWsYoGir0pOIQNrP63mse0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=mKBFCJgqlu0y8gKgf7WK6dK8Z8KzWM0ts4ZRxoZEBFSrc8lz5RxYkloEJm+ogHw3
	 YkF4VbP2ICMT0UHldmbTff7nJ6CLxOcAvbTq909cS72OJvyeXVjES6A51VRgjMhIg
	 01QWYshab/XDJaAoL2LW9pF0lXpHqmDaylFEZM7a+gbxQxchyHOPJRzzHaZkUP9Ss
	 xAC9GZUS4pFzZwO6IDnxeffjKEXEJ8nbhHnX0oy9rPUOS3yftuIE5z7NE9Do76ELz
	 EjDwsnHlq0VzBZTC0VUhPUGi8j9z1gg3UgGXh87YxWs+hupX4LbijGBUn6NYklGgZ
	 Rf3OB8VxdKVwdzjH2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8obG-1qqvPe09Be-015pG0; Sat, 17
 Feb 2024 21:39:08 +0100
Message-ID: <cdad94b0-6593-440d-96b1-ae4a5df4abb1@gmx.com>
Date: Sun, 18 Feb 2024 07:09:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/016: fix a false alert due to xattrs mismatch
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <ae441bd376587124becd9141ed690598d4ed281a.1703741660.git.wqu@suse.com>
 <CAL3q7H4SoEdTUNpkkotux5ZbNmmjsN8vJsC_JCBsJvsXM_y3Qg@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAL3q7H4SoEdTUNpkkotux5ZbNmmjsN8vJsC_JCBsJvsXM_y3Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iD3n3znbTrEoQrsVLH1eVygwYeHNFwqB+EX/qj/D087ehJkpivg
 cR1chCrX8yx4gFxzEFNqqqrH24UeLBX4gitPYm0+YJIi3FK/tRwtGOo3RGbIosR+EArX6k8
 tbS6/Xupe3A496HhQXbvPqBtzQrO/1UOaS9lcvmXScvjFC5/Z8fvJgJIaYbq+aTSJ5nA42N
 vIK7g8KIBIVVbjK6h1ecw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jbpyU0NQLh4=;xK3WReG8pWm16AnIeFlp+eWANgu
 3MmJz6Q3k1Emmjfup/qrFTsmxgPAG5K+6EKCh9G30A8fhZoRQqjhyTs7QsMa9tdBH4FTKyeIT
 Ilj8gyos7/D++qOb2hCRJqzGeS8G81559MckTYpAkyk08KXdyGAkIk5qSUQxQwaoGh8tZyfpy
 8ZX8IA5mAVsqCMcPR2hefwRGsWl7aQxpIZCt5GFlgOtP4Id8LEGvYJSafDcEBNCkCMyTvnEpI
 GMpGUUU1v8tlgaCK6WE4CsLqHOIgBDJ/dp9TaQ4ubO0T0ppkoNekNAlyJWClNzwoWQJzJSDO1
 Ww55+SD/hCw7C8Cj2mlocWZIWmIzBNXvBu0dNOwm7N1UF5u5pAB1MZUQUWhCNu39vs3C3IKFZ
 HhSTlC5QwflQz5fqSc/WEzkuELxEHAR9SLCQ/GEf4ayjxHaDx4zHZOxpK5y/jteZTI8N/taKe
 v/2I2SGdlkI6kmRTcwkCRPYPI6W+c2LvE9T1hl3dQmQxxAcecqx3iMloByMFyR/MyevniyV61
 Mq9ycEix5TIG/X8Zh62oy/LgUOagbJcfXmRhVLgfFZpNN1dl9XmpBff8nj0H0B7ZIe2g8d0Dg
 4W/FpnivM3MYI3+DaW5nGfFWxKuB5Y5Wp86VCYxYp6KPWmlnfevPzIg25b/Dfm6oincaeJ169
 WGZkrrRdNWSKxf0FLppbnMeX6QOrZMbjSxbfOv5XTvmjTcfwwe2uM19gQG1lPxPbWeWVfE3Ay
 TIfP7lMdIAZIB6TsQSLdjiz8JwK2eDkqWmgNXNRvaUg+QXzB/iGElRaVBDhFAP7ATC1w255Ea
 +uV3soJlx+/817A6p5PoRW8bBFC7QSgj3HX7yP9KGp8zg=



=E5=9C=A8 2024/2/17 22:55, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Dec 28, 2023 at 5:36=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> When running btrfs/016 after any other test case, it would fail on a
>> SELinux enabled environment:
>>
>>    btrfs/015 1s ...  0s
>>    btrfs/016 1s ... [failed, exit status 1]- output mismatch (see ~/xfs=
tests-dev/results//btrfs/016.out.bad)
>>        --- tests/btrfs/016.out   2023-12-28 10:39:36.481027970 +1030
>>        +++ ~/xfstests-dev/results//btrfs/016.out.bad     2023-12-28 15:=
53:10.745436664 +1030
>>        @@ -1,2 +1,3 @@
>>         QA output created by 016
>>        -Silence is golden
>>        +fssum failed
>>        +(see ~/xfstests-dev/results//btrfs/016.full for details)
>>        ...
>>        (Run 'diff -u ~/xfstests-dev/tests/btrfs/016.out ~/xfstests-dev/=
results//btrfs/016.out.bad'  to see the entire diff)
>>    Ran: btrfs/015 btrfs/016
>>    Failures: btrfs/016
>>    Failed 1 of 2 tests
>>
>> [CAUSE]
>> The test case itself would try to use a blank SELinux context for the
>> SCRATCH_MNT, to control the xattrs.
>>
>> But the initial send stream is generated from $TEST_DIR, which may stil=
l
>> have the default SELinux mount context.
>>
>> And such mismatch in the SELinux xattr (source on $TEST_DIR still has
>> the extra xattr, meanwhile the receve end on $SCRATCH_MNT doesn't) woul=
d
>> lead to above mismatch.
>>
>> [FIX]
>> Instead of doing all the edge juggling using $TEST_DIR, this time we do
>> all the work on $SCRATCH_MNT.
>>
>> This means we would generate the initial send stream from $SCRATCH_MNT,
>> then reformat the fs, mount scratch again, receive and verify.
>>
>> This does not only fix the above false alerts, but also simplify the
>> cleanup.
>> We no longer needs to cleanup the extra file for the initial send
>> stream, as they are on the scratch device and would be formatted anyway=
.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/016 | 46 ++++++++++++++++++++++------------------------
>>   1 file changed, 22 insertions(+), 24 deletions(-)
>>
>> diff --git a/tests/btrfs/016 b/tests/btrfs/016
>> index 35609329ba0e..9371b3316332 100755
>> --- a/tests/btrfs/016
>> +++ b/tests/btrfs/016
>> @@ -12,22 +12,11 @@ _begin_fstest auto quick send prealloc
>>   tmp=3D`mktemp -d`
>>   tmp_dir=3Dsend_temp_$seq
>>
>> -# Override the default cleanup function.
>> -_cleanup()
>> -{
>> -       $BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/snap > /de=
v/null 2>&1
>> -       $BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/snap1 > /d=
ev/null 2>&1
>> -       $BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/send > /de=
v/null 2>&1
>> -       rm -rf $TEST_DIR/$tmp_dir
>> -       rm -f $tmp.*
>> -}
>> -
>>   # Import common functions.
>>   . ./common/filter
>>
>>   # real QA test starts here
>>   _supported_fs btrfs
>> -_require_test
>>   _require_scratch
>>   _require_fssum
>>   _require_xfs_io_command "falloc"
>> @@ -41,29 +30,33 @@ export SELINUX_MOUNT_OPTIONS=3D""
>>
>>   _scratch_mount
>>
>> -mkdir $TEST_DIR/$tmp_dir
>> -$BTRFS_UTIL_PROG subvolume create $TEST_DIR/$tmp_dir/send \
>> +mkdir $SCRATCH_MNT/$tmp_dir
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/$tmp_dir/send \
>>          > $seqres.full 2>&1 || _fail "failed subvolume create"
>>
>> -_ddt of=3D$TEST_DIR/$tmp_dir/send/foo bs=3D1M count=3D10 >> $seqres.fu=
ll \
>> +_ddt of=3D$SCRATCH_MNT/$tmp_dir/send/foo bs=3D1M count=3D10 >> $seqres=
.full \
>>          2>&1 || _fail "dd failed"
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $TEST_DIR/$tmp_dir/send \
>> -       $TEST_DIR/$tmp_dir/snap >> $seqres.full 2>&1 || _fail "failed s=
nap"
>> -$XFS_IO_PROG -c "fpunch 1m 1m" $TEST_DIR/$tmp_dir/send/foo
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $TEST_DIR/$tmp_dir/send \
>> -       $TEST_DIR/$tmp_dir/snap1 >> $seqres.full 2>&1 || _fail "failed =
snap"
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/$tmp_dir/send \
>> +       $SCRATCH_MNT/$tmp_dir/snap >> $seqres.full 2>&1 || _fail "faile=
d snap"
>> +$XFS_IO_PROG -c "fpunch 1m 1m" $SCRATCH_MNT/$tmp_dir/send/foo
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/$tmp_dir/send \
>> +       $SCRATCH_MNT/$tmp_dir/snap1 >> $seqres.full 2>&1 || _fail "fail=
ed snap"
>>
>> -$FSSUM_PROG -A -f -w $tmp/fssum.snap $TEST_DIR/$tmp_dir/snap >> $seqre=
s.full \
>> +$FSSUM_PROG -A -f -w $tmp/fssum.snap $SCRATCH_MNT/$tmp_dir/snap >> $se=
qres.full \
>>          2>&1 || _fail "fssum gen failed"
>> -$FSSUM_PROG -A -f -w $tmp/fssum.snap1 $TEST_DIR/$tmp_dir/snap1 >> $seq=
res.full \
>> +$FSSUM_PROG -A -f -w $tmp/fssum.snap1 $SCRATCH_MNT/$tmp_dir/snap1 >> $=
seqres.full \
>>          2>&1 || _fail "fssum gen failed"
>>
>> -$BTRFS_UTIL_PROG send -f $tmp/send.snap $TEST_DIR/$tmp_dir/snap >> \
>> +$BTRFS_UTIL_PROG send -f $tmp/send.snap $SCRATCH_MNT/$tmp_dir/snap >> =
\
>>          $seqres.full 2>&1 || _fail "failed send"
>> -$BTRFS_UTIL_PROG send -p $TEST_DIR/$tmp_dir/snap \
>> -       -f $tmp/send.snap1 $TEST_DIR/$tmp_dir/snap1 \
>> +$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/$tmp_dir/snap \
>> +       -f $tmp/send.snap1 $SCRATCH_MNT/$tmp_dir/snap1 \
>>          >> $seqres.full 2>&1 || _fail "failed send"
>>
>> +_scratch_unmount
>> +_scratch_mkfs > /dev/null 2>&1
>> +_scratch_mount
>> +
>>   $BTRFS_UTIL_PROG receive -f $tmp/send.snap $SCRATCH_MNT >> $seqres.fu=
ll 2>&1 \
>>          || _fail "failed recv"
>>   $BTRFS_UTIL_PROG receive -f $tmp/send.snap1 $SCRATCH_MNT >> $seqres.f=
ull 2>&1 \
>> @@ -74,5 +67,10 @@ $FSSUM_PROG -r $tmp/fssum.snap $SCRATCH_MNT/snap >> =
$seqres.full 2>&1 \
>>   $FSSUM_PROG -r $tmp/fssum.snap1 $SCRATCH_MNT/snap1 >> $seqres.full 2>=
&1 \
>>          || _fail "fssum failed"
>>
>> +# Unset the selinux mount options and restore whatever the default one=
 for
>> +# test device.
>> +unset SELINUX_MOUNT_OPTIONS
>> +_test_cycle_mount
>
> Why do we need to _test_cycle_mount?
>
> We're not using the test device anymore after this change, so
> unsetting SELINUX_MOUNT_OPTIONS should be enough.
>
> A simpler alternative fix would be just to pass -T to fssum, so that
> it ignores xattrs when computing/verifying checksums, which is ok
> since the tests' goal is to verify file data and that the hole
> punching worked.

That makes sense. In that case we can completely remove the
SELINUX_MOUNT_OPTIONS related setup.

> Or just not use fssum and compare md5sum in the
> original fs and the new fs.
>
> Either way, it looks good to me except that confusing part of the
> _test_cycle_mount which seems irrelevant to me.

Thanks for the review, would update this fix soon.

Thanks,
Qu

>
> Thanks.
>
>> +
>>   echo "Silence is golden"
>>   status=3D0 ; exit
>> --
>> 2.43.0
>>
>>
>

