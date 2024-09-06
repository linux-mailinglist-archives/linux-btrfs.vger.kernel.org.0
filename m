Return-Path: <linux-btrfs+bounces-7881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B68AE96FD8C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 23:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C91B21441
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2715958D;
	Fri,  6 Sep 2024 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lQwptMtK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D841515A848;
	Fri,  6 Sep 2024 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659570; cv=none; b=Gl7f/oXt8uHVqtmwscDP3r/QQmP4IImpDhtGDzKR49C76ezCX0/JEeAgAx41tTt+1J/QEmH73IoRk0IDzsasTlwzU/dtgY+7GCjo4lLAeD735YEGa5EcAEq6cUr4loDdFJ9y+qh75yAVM4XrDR70OArZY8XuLK/BfYsj1C/VXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659570; c=relaxed/simple;
	bh=ZDIbE38CE1F3CgXihnXrhD5jKJb3sfhISkqb0qlyFis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJW52GZ+a4DBVKp4MRD4xTCVzoZezwMhKBPVwW7XtWQvcCiSHjT7XYpnyjdzMaCWPvY1rcGcGGBMXp4g0xyWlqePtwBE6Boal6Jxg/oynx9v2ruHzaDWXSuLRWEaVNMQhasGLgTiENrnlM06bBV4SERC37dNxz0Fe+dfWgOiyfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lQwptMtK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725659560; x=1726264360; i=quwenruo.btrfs@gmx.com;
	bh=9c50sqttDyCMP1dPoKOUl8upqB/kXt2HZdVUyeevta0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lQwptMtKDHMvMN24T4bSQEjBQSeAr2EqMzIvNPgNMzisnq8yqKrhaGxYrdA/0aIH
	 E8lMLI1IoyzKOv4B44xwW6YaeQ3X7y9HgGlcWysokEqzo7rOetKTiocfQ6myDA1Tm
	 Uuy+D8WDv0dTuXxUlsmLkG6En1ANxSNCWeo5vrPjrIA0/yPcIhSlPi46edxWYcU5Z
	 kkXvjry3of4cOiV5lurE3tkOE43sqMofirQzog6JmJ7ZXBJAt0lLMpZyF59vLRq3x
	 E+GxzAbS9mwXS+l4Wic6k/wp1sxlrSv6h75QMX56A6a44St9V8qz1DaNGMD62RDsl
	 IrBEziE7P3V02vEbSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSbx3-1sbItS3meH-00Iuc6; Fri, 06
 Sep 2024 23:52:40 +0200
Message-ID: <bce9fb4c-739a-4f03-ae2c-2d0b235dcd8a@gmx.com>
Date: Sat, 7 Sep 2024 07:22:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/319: make the test work when compression is used
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>
References: <e2aab2e4d87251546d4218e6d124a4fe657203e9.1725550652.git.fdmanana@suse.com>
 <21f138f8-7824-4570-b409-d773bcc7c1fa@gmx.com>
 <CAL3q7H5dJSayuWMYjHRPp_p734D98ykFShe1nwyboGm2i9AQ-Q@mail.gmail.com>
Content-Language: en-US
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
In-Reply-To: <CAL3q7H5dJSayuWMYjHRPp_p734D98ykFShe1nwyboGm2i9AQ-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fIQoqW5CI2iUhoFGr5tBOy35diTjNKxZd5xFK+09uVT+dkI8hYI
 CcSembh9kHVaBY0VuL9cwtLSdihOGcA/DWaA5S09nLsH26dePpfKaY+aVdsnTGHtMHOmOwh
 BkEAs7a0TMrYd0zyNrnhloyt2c4HkltxKAc40XCH62ZdGHuXyXlCEw4EKibllrWn+BTN6sX
 8XBrDyD18XBrunO9vujow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/RFXsYz0jI8=;H838tj3+W+n7ZBNCp+haFqVsMdz
 KeayzkDW0lSmIa04ackroy3oP40F6DQqcFP9VzQBSY4svfLgVL5hqgxTcUk69kfNGPTECrW0Z
 HHi9Ev/c9X+6v/z6KgMNtsCBagvCcqM2wIsj+9N6P6sK/aiO3GIWMNrOA4zqb+7paOkhhAw3w
 Ym/E8fCJUlbOXnQiiWKSp562Rr54j6QgNwcwtw3JBxg8H0NvZRDhapL/cUkuaSg9Y9vRqF9Qs
 tJed5hkyw52q/S3Q0sWuDHv8WtRQoM+CVd5LQBFy+zVGQRnu+T3hxry5P/fm1BC1rbV0S/rQq
 fADd0uyha1glNNaxdvMNqoSH2jN47GTqKeH6JLgy331OIug7YdPoS/gLK26h2dXVlb9NTSrQY
 Y6oftWDxut45+pDgAluGSO0manTnINxGGIIB98lRLLXO7YjE1f7kqUxL8iOxzEte1bjy3xBJ/
 gNIE/4rYnqZniZEmbpVr9PLJDYdLD/c/QI0jomQCtUe+dZigfNGQgrH2KWlDHohW9PL2eA19y
 z5eAM+1slgBNCUKBP5omezQG1K8u2cTLzXAigeR+i7jsh66UTs28khbJoli/KqBjy70b3QGdm
 imtDYCD6MzztSODTpUSzpwlK0wHXzHLZwbZW2UkQu0/EIwgy2hcZrA3tm6ufbhLJnh93uCe9D
 NgQ8n9/++HDSTRbAdIUQuGi6rgEc7A9z3mnnXrRYf/XT6zvGRkt8cpbE8L/qlwgLrvPYjQ6yj
 vPAg1WCKEqIq+tsSemwhf2s288/Q5IYK4rhA1fMfTHSsfby106k5z4h0Tt2mQcibUaM7jv1TQ
 cad/u/lbXktwnUepLEBIpQSA==



=E5=9C=A8 2024/9/6 20:27, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, Sep 6, 2024 at 11:39=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/9/6 01:08, fdmanana@kernel.org =E5=86=99=E9=81=93:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Currently btrfs/319 assumes there is no compression and that the files
>>> get a single extent (1 fiemap line) with a size of 1048581 bytes. Howe=
ver
>>> when testing with compression, for example by passing "-o compress" to
>>> MOUNT_OPTIONS environment variable, we get several extents and two lin=
es
>>> of fiemap output, which makes the test fail since it hardcodes the fie=
map
>>> output:
>>>
>>>     $ MOUNT_OPTIONS=3D"-o compress" ./check btrfs/319
>>>     FSTYP         -- btrfs
>>>     PLATFORM      -- Linux/x86_64 debian0 6.11.0-rc6-btrfs-next-173+ #=
1 SMP PREEMPT_DYNAMIC Tue Sep  3 17:40:24 WEST 2024
>>>     MKFS_OPTIONS  -- /dev/sdc
>>>     MOUNT_OPTIONS -- -o compress /dev/sdc /home/fdmanana/btrfs-tests/s=
cratch_1
>>>
>>>     btrfs/319 1s ... - output mismatch (see /home/fdmanana/git/hub/xfs=
tests/results//btrfs/319.out.bad)
>>>         --- tests/btrfs/319.out        2024-08-12 14:16:55.653383284 +=
0100
>>>         +++ /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad=
 2024-09-05 15:24:53.323076548 +0100
>>>         @@ -6,11 +6,13 @@
>>>          e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
>>>          e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
>>>          File bar fiemap in the original filesystem:
>>>         -0: [0..2055]: shared|last
>>>         +0: [0..2047]: shared
>>>         +1: [2048..2055]: shared|last
>>>          Creating a new filesystem to receive the send stream...
>>>         ...
>>>         (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/319.=
out /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad'  to see th=
e entire diff)
>>>
>>>     HINT: You _MAY_ be missing kernel fix:
>>>           46a6e10a1ab1 btrfs: send: allow cloning non-aligned extent i=
f it ends at i_size
>>>
>>>     Ran: btrfs/319
>>>     Failures: btrfs/319
>>>     Failed 1 of 1 tests
>>>
>>> So change the test to not rely on the fiemap output in its golden outp=
ut
>>> and instead just check if all the extents reported by fiemap have the
>>> shared flag set (failing if there are any without the shared flag).
>>
>> Looks good to me.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Just one minor improvement to make debug a little easier.
>>
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    tests/btrfs/319     | 19 +++++++++++++++----
>>>    tests/btrfs/319.out |  4 ----
>>>    2 files changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/tests/btrfs/319 b/tests/btrfs/319
>>> index 975c1497..7cfd3d00 100755
>>> --- a/tests/btrfs/319
>>> +++ b/tests/btrfs/319
>>> @@ -32,6 +32,19 @@ _require_odirect
>>>    _fixed_by_kernel_commit 46a6e10a1ab1 \
>>>        "btrfs: send: allow cloning non-aligned extent if it ends at i_=
size"
>>>
>>> +check_all_extents_shared()
>>> +{
>>> +     local file=3D$1
>>> +     local fiemap_output
>>> +
>>> +     fiemap_output=3D$($XFS_IO_PROG -r -c "fiemap -v" $file | _filter=
_fiemap_flags)
>>
>> Maybe also save the full unfiltered output to seqres.full?
>
> Hum, why?
>
> Do you think looking at the flags in hexadecimal values instead of
> symbolic names like "shared", "encoded", "last", etc, is easier to
> read?

My bad, I thought that filter only shows the flags, but it turns out
that keeps the filepos and length.

So the filtered one is much better in all aspects.

Thanks,
Qu

>
> Thanks.
>
>>
>> Thanks,
>> Qu
>>
>>> +     echo "$fiemap_output" | grep -qv 'shared'
>>> +     if [ $? -eq 0 ]; then
>>> +             echo -e "Found non-shared extents for file $file:\n"
>>> +             echo "$fiemap_output"
>>> +     fi
>>> +}
>>> +
>>>    send_files_dir=3D$TEST_DIR/btrfs-test-$seq
>>>    send_stream=3D$send_files_dir/snap.stream
>>>
>>> @@ -58,8 +71,7 @@ echo "File digests in the original filesystem:"
>>>    md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
>>>    md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
>>>
>>> -echo "File bar fiemap in the original filesystem:"
>>> -$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap=
_flags
>>> +check_all_extents_shared "$SCRATCH_MNT/snap/bar"
>>>
>>>    echo "Creating a new filesystem to receive the send stream..."
>>>    _scratch_unmount
>>> @@ -72,8 +84,7 @@ echo "File digests in the new filesystem:"
>>>    md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
>>>    md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
>>>
>>> -echo "File bar fiemap in the new filesystem:"
>>> -$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap=
_flags
>>> +check_all_extents_shared "$SCRATCH_MNT/snap/bar"
>>>
>>>    # success, all done
>>>    status=3D0
>>> diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
>>> index 14079dbe..18a50ff8 100644
>>> --- a/tests/btrfs/319.out
>>> +++ b/tests/btrfs/319.out
>>> @@ -5,12 +5,8 @@ Creating snapshot and a send stream for it...
>>>    File digests in the original filesystem:
>>>    e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
>>>    e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
>>> -File bar fiemap in the original filesystem:
>>> -0: [0..2055]: shared|last
>>>    Creating a new filesystem to receive the send stream...
>>>    At subvol snap
>>>    File digests in the new filesystem:
>>>    e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
>>>    e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
>>> -File bar fiemap in the new filesystem:
>>> -0: [0..2055]: shared|last
>

