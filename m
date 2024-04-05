Return-Path: <linux-btrfs+bounces-3955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF278999DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 11:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2369DB2135E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03716087B;
	Fri,  5 Apr 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="b7QuFjYu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E8142E73;
	Fri,  5 Apr 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310679; cv=none; b=eb1UrfivIzVd0mULn4gBbb91W5Ocv6QH9ckc1NTQRwHv65mDsFaGIuRnHiiWx5FBhcLySMt13b7cW38wfxR7puwPzby01CphpGr0YTGInlNcrqP+78s17Mc1A7ipZwl6tifpW6Lcqi22UtQzFKWYKJVV7olGKdU2pbgOoX93cjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310679; c=relaxed/simple;
	bh=xiaxJ4H458SmxoLb6Vr3u/quTUz2bPrqSODJEnYY0Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvXmSH7FAFEkwWwdaDWxnA/eTZPeTu9MFb/dKQwC4Jc8u6kRpHV0NM7KN9wsbQKCiE2peGzdPiG5VUC7I6w85sAizFq2iRnjrXEMCKu8u3RyDFc6WcXbyoDXIBidMSE4DlUPKfz7WFcEydAtBBhOHChpwQP5RVV0AErLAnuoi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=b7QuFjYu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712310664; x=1712915464; i=quwenruo.btrfs@gmx.com;
	bh=xiaxJ4H458SmxoLb6Vr3u/quTUz2bPrqSODJEnYY0Mk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=b7QuFjYuD0JKb0wVfW+S2WUylwu8kK8XujWp/vTqhC4msUEnfiS3QGybP2mqk28+
	 zg3c68wnAUcklIaa+zk8isrMgX3NQEaOqgZQZfUCm07KLlbdlS/7XFVihOpWDU3kc
	 XMMsHxqtIwC4bb1d7CoBl5MkwiEDYhFfjf8iKFRoMM2b7KNc130tYhrXqHeR8UFam
	 kZH9jqWbcV2gczvGvHu3/vcOgGwDFR95Ap0gXsNg+d0Mu7BcXbJs2GPma4ood3rBd
	 qyofeuTT3P5vka/4J63mbiFWeChMB26M7YYIm5P96cbTFVK55O3jJypgr65S1YmjX
	 sg1gQYYGQIYVsY5vVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5eX-1s8q450DP3-00IylO; Fri, 05
 Apr 2024 11:51:04 +0200
Message-ID: <eb9530e1-7626-41fb-978e-b830b46a04f4@gmx.com>
Date: Fri, 5 Apr 2024 20:20:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] common/filter.btrfs: add a new _filter_snapshot
To: Anand Jain <anand.jain@oracle.com>, zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 josef@toxicpanda.com, dsterba@suse.cz
References: <cover.1712306454.git.anand.jain@oracle.com>
 <3d035b4355abc0cf9e95da134d89e3fbb58939d0.1712306454.git.anand.jain@oracle.com>
 <a62dbef2-0371-49e7-b5eb-9bb5fed32a17@gmx.com>
 <37e0ae3f-54b0-45a4-b62a-7caca994c38a@oracle.com>
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
In-Reply-To: <37e0ae3f-54b0-45a4-b62a-7caca994c38a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9qb+tyskxJGyS6Shz0QQZ7IW8OWVitPgJL4CQBFLVTP+YWSGPZZ
 AwZbuxl1q7o9rt7nEN9g16czs5KdO8BzrEf3j4/QpLCkwWJvF47zAbCa3Pwiw/t+1FhZeAi
 odhFV2kALGhXKSCwMZdymP1/PaftH94t0A5wUP/PflPt9ZycuCgT5N8xlhnrJI8wtMswr8o
 v/KYIsvVX5OEc+8lssJaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v2USrTdlGeY=;IdbIZIZNCRfaGPLXI10cbbQa3CG
 7vxBYQ8RNl26NSEFWPFAC/iyZoxnP7bXRdHDIdemDw4YAVantWFOuuOHBKDH2VS6kwjS9Lpyo
 EDsj9YuImchX4fBozxgmQgDZPgFNBccTBJIv+9BXT5gbCeWbMcX4N+1/E6KM2sdcShY1rKEnr
 R6JhMex84zo38aFsGqn9D86T9gDxjl9TrtsqZ7B3ekwRWzr9eyEIX5XtURuGhI04EQasE18Bs
 V4lkUWX6MnLMvbb2S3Iy+8oTr1NGu7iTQ/gCDzVH9odjEDXGL4WDh46/UkBvEezpwdNh5refE
 4EkluhMG07JWrnsd+L9ZeDerDh+/6DZGo1GB+5H7HTdnt2TdFjQ4VSfpTE5C8fddHR1Vno6IQ
 uvLHWW1vKhDSvUQIxWHos2181gYXSLBRNQUdUB4nu/UlTdGHJ1Py8YVuSKkI5C0o41nDB24QV
 kxrZurIiLuXVbdbMV2JsSL6hPfH89kV/VJTceIb9L6TDzot8gzFjxisoR4KONOSol0kaMMT1J
 E4KCiu+3qU1ftnxc/vlxzSZb1JsWvZuJmMDg7sPFvyPNWzWZCh+5jALeAluZVGXSYWifHzCNf
 E69GY64v8GXQpGNfSo63DdE+vh1p2v7u4TrpoQUcb8jN/NxhMp3VDSpE8I1MZw9ySX5CgkG4c
 zR4ZB8Y4NJSsL1La4iOdscdvdNW/7ptALKm34Qxnkzhfkkd5UzkJMxFyLr+p047zS+Uf6jBls
 hAdZJF6GkPmK44bpPFUHAcOOtarB5b5F/VAJRYv1XdmaHSze2b6pR5+eBi7PZWGe44GZLbmlY
 LHzCS6igIUyCvBJq1w3VCt1EWqmzheI4+P/c+Kvce6FV4=



=E5=9C=A8 2024/4/5 19:55, Anand Jain =E5=86=99=E9=81=93:
>
>
> On 4/5/24 16:52, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/4/5 19:15, Anand Jain =E5=86=99=E9=81=93:
>>> As the newer btrfs-progs have changed the output of the command
>>> "btrfs subvolume snapshot," which is part of the golden output,
>>> create a helper filter to ensure the test cases pass on older
>>> btrfs-progs.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> Can we stop the golden output filter game?
>>
>> =C2=A0From day one I'm not a big fan of the golden output idea.
>> For snapshot/subvolume creation, we don't really care about what the
>> output is, we only care if there is any error (which would come from
>> stderr).
>>
>> In that case, why not just redirect the stdout to null?
>>
>> To me, if we really care something from the stdout, we can still save i=
t
>> and let bash/awk/grep to process it, like what we did for various test
>> cases, and then save the result to seqres.full.
>>
>
> This is a bug-fix patch; it's not a good idea to change the concept of
> fstests' golden output. Perhaps an RFC patch about your idea can help
> to discuss and achieve consensus.

Even as bug-fix, a simple redirect to seqres.full and remove the
corresponding line from golden output is very valid to me.

In fact, introducing a filter looks very over-engineered in this
particular case.

>
> Thanks, Anand
>
>
>> Thanks,
>> Qu
>>> ---
>>> =C2=A0 common/filter.btrfs | 9 +++++++++
>>> =C2=A0 tests/btrfs/001=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
>>> =C2=A0 tests/btrfs/152=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>>> =C2=A0 tests/btrfs/168=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>>> =C2=A0 tests/btrfs/202=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 tests/btrfs/302=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 6 files changed, 21 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/common/filter.btrfs b/common/filter.btrfs
>>> index 9ef9676175c9..415ed6dfd088 100644
>>> --- a/common/filter.btrfs
>>> +++ b/common/filter.btrfs
>>> @@ -156,5 +156,14 @@ _filter_device_add()
>>>
>>> =C2=A0 }
>>>
>>> +_filter_snapshot()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 # btrfs-progs commit 5f87b467a9e7 ("btrfs-progs: s=
ubvolume:
>>> output the
>>> +=C2=A0=C2=A0=C2=A0 # prompt line only when the ioctl succeeded") chan=
ged the output
>>> for
>>> +=C2=A0=C2=A0=C2=A0 # btrfs subvolume snapshot, ensure that the latest=
 fstests
>>> continue to
>>> +=C2=A0=C2=A0=C2=A0 # work on older btrfs-progs without the above comm=
it.
>>> +=C2=A0=C2=A0=C2=A0 _filter_scratch | sed -e "s/Create a/Create/g"
>>> +}
>>> +
>>> =C2=A0 # make sure this script returns success
>>> =C2=A0 /bin/true
>>> diff --git a/tests/btrfs/001 b/tests/btrfs/001
>>> index 6c2639990373..cfcf2ade4590 100755
>>> --- a/tests/btrfs/001
>>> +++ b/tests/btrfs/001
>>> @@ -26,7 +26,8 @@ dd if=3D/dev/zero of=3D$SCRATCH_MNT/foo bs=3D1M coun=
t=3D1
>>> &> /dev/null
>>> =C2=A0 echo "List root dir"
>>> =C2=A0 ls $SCRATCH_MNT
>>> =C2=A0 echo "Creating snapshot of root dir"
>>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap |
>>> _filter_scratch
>>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | =
\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 _filter_snapshot
>>> =C2=A0 echo "List root dir after snapshot"
>>> =C2=A0 ls $SCRATCH_MNT
>>> =C2=A0 echo "List snapshot dir"
>>> diff --git a/tests/btrfs/152 b/tests/btrfs/152
>>> index 75f576c3cfca..b89fe361e84e 100755
>>> --- a/tests/btrfs/152
>>> +++ b/tests/btrfs/152
>>> @@ -11,7 +11,7 @@
>>> =C2=A0 _begin_fstest auto quick metadata qgroup send
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>>
>>> =C2=A0 # real QA test starts here
>>> =C2=A0 _supported_fs btrfs
>>> @@ -32,9 +32,9 @@ touch $SCRATCH_MNT/subvol{1,2}/foo
>>>
>>> =C2=A0 # Create base snapshots and send them
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
>>> -=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratc=
h
>>> +=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol1/.snapshots/1 | _filter_snapsh=
ot
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
>>> -=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratc=
h
>>> +=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol2/.snapshots/1 | _filter_snapsh=
ot
>>> =C2=A0 for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG send $SCRATCH_MNT/subv=
ol1/.snapshots/1 2>
>>> /dev/null | \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PRO=
G receive $SCRATCH_MNT/${recv} |
>>> _filter_scratch
>>> diff --git a/tests/btrfs/168 b/tests/btrfs/168
>>> index acc58b51ee39..78bc9b8f81bb 100755
>>> --- a/tests/btrfs/168
>>> +++ b/tests/btrfs/168
>>> @@ -20,7 +20,7 @@ _cleanup()
>>> =C2=A0 }
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>>
>>> =C2=A0 # real QA test starts here
>>> =C2=A0 _supported_fs btrfs
>>> @@ -74,7 +74,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro
>>> false
>>> =C2=A0 # Create a snapshot of the subvolume, to be used later as the
>>> parent snapshot
>>> =C2=A0 # for an incremental send operation.
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1
>>> $SCRATCH_MNT/snap1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 # First do a full send of this snapshot.
>>> =C2=A0 $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/s=
nap1
>>> @@ -88,7 +88,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K"
>>> $SCRATCH_MNT/sv1/baz >>$seqres.full
>>> =C2=A0 # Create a second snapshot of the subvolume, to be used later a=
s
>>> the send
>>> =C2=A0 # snapshot of an incremental send operation.
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1
>>> $SCRATCH_MNT/snap2 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 # Temporarily turn the second snapshot to read-write mode and t=
hen
>>> open a file
>>> =C2=A0 # descriptor on its foo file.
>>> diff --git a/tests/btrfs/202 b/tests/btrfs/202
>>> index 5f0429f18bf9..57ecbe47c0bb 100755
>>> --- a/tests/btrfs/202
>>> +++ b/tests/btrfs/202
>>> @@ -8,7 +8,7 @@
>>> =C2=A0 . ./common/preamble
>>> =C2=A0 _begin_fstest auto quick subvol snapshot
>>>
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>>
>>> =C2=A0 _supported_fs btrfs
>>> =C2=A0 _require_scratch
>>> @@ -28,7 +28,7 @@ _scratch_mount
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scra=
tch
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_sc=
ratch
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT=
/c \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 # Need the dummy entry created so that we get the invalid remov=
al
>>> when we rmdir
>>> =C2=A0 ls $SCRATCH_MNT/c/b
>>> diff --git a/tests/btrfs/302 b/tests/btrfs/302
>>> index f3e6044b5251..52d712ac50de 100755
>>> --- a/tests/btrfs/302
>>> +++ b/tests/btrfs/302
>>> @@ -15,7 +15,7 @@
>>> =C2=A0 . ./common/preamble
>>> =C2=A0 _begin_fstest auto quick snapshot subvol
>>>
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>>
>>> =C2=A0 _supported_fs btrfs
>>> =C2=A0 _require_scratch
>>> @@ -46,7 +46,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
>>> =C2=A0 # Now create a snapshot of the subvolume and make it accessible
>>> from within the
>>> =C2=A0 # subvolume.
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol/=
snap | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol/snap | _filter_snapshot
>>>
>>> =C2=A0 # Now unmount and mount again the fs. We want to verify we are =
able
>>> to read all
>>> =C2=A0 # metadata for the snapshot from disk (no IO failures, etc).
>

