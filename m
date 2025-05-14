Return-Path: <linux-btrfs+bounces-13992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7FDAB6179
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 06:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315807B2B24
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 04:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A491F1921;
	Wed, 14 May 2025 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="taIYBEC5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF930191F92;
	Wed, 14 May 2025 04:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747196876; cv=none; b=t3xtpKd7S32/49qHkg77JvpfsetSj8wjXnYqbXHyrVD+PFjnzKSUG09xve2l97pIenSX0lYkEnXrQDNeHNgzZlLZknfPL66GisATryBSpw7Ntyjcj+axX2pXkDNLGKR7E1qARtkNo/ndkq4E4CJaH4M+glcZn9UnG7V6uEQte8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747196876; c=relaxed/simple;
	bh=KFtCo11p6akAIQn4I+Etdm6iUFuXGArX89R8Z4gD4/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sp1AI9y2XLy6WUqkaCksa93CA4GDtXdV88QU6g/+3is6LtMtWJ549SFEq3KdVnRt5F/QOOG1KZ7GTx9JBUD2byBLeEKVzF9TYpuoTNPxlnKxY5UmjydkRrSAn6+v50d5Kjiwv73k0rb6HV1pN1YG6qXI8tzCCYqY+hf8qH+bAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=taIYBEC5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747196872; x=1747801672; i=quwenruo.btrfs@gmx.com;
	bh=r4lEE824JU8/h8vWdaPoxkRgQ8/9fIywrnU1ZjbxEPU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=taIYBEC5xTXq45/iJCZQ5I7N0Jl7FQZPDKoZvFCX8ms3k/2SoIHfd1jmzYVbFZT2
	 MTXffdoSCTmWbAGyQNhB4ASsRO7ef8EnBS0c3vdOawSj+GauXC64+wCXEH//yKiJn
	 Lmk0PSiotm7dh20sT8g8a9wSoY2gk7Rpu0WP0cfmMu9Bcrzte7VGKg3CzitRgOUHZ
	 6+76JBhY/KSUHnaloIj0/Ugd0rScj+oW9gZPqLKHtxE5bupaifNw7y/+QCbqlhd20
	 2bcOolQQA3ZoHTeEX2u2yZXhJNnEgdm2tqKwpZTD6wqrGc30ppMtzV17ASIfZPMsn
	 rPZDLEjsTHF54lDv2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDXp-1v7Ql815un-0110X1; Wed, 14
 May 2025 06:27:51 +0200
Message-ID: <95cb8a81-9cd8-455e-afc5-f4104329e217@gmx.com>
Date: Wed, 14 May 2025 13:57:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/336: misc extra fixes for the testcase
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <9c9683df7928397142cb345ac5bbef2456972bf7.1747185899.git.anand.jain@oracle.com>
 <6c89137d-a835-447a-90db-da7b5e78263b@gmx.com>
 <843f86bc-90ee-42b5-80d0-b9800ac9fd9c@oracle.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <843f86bc-90ee-42b5-80d0-b9800ac9fd9c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YNLmvNyn7Jwx8QVmdQJXkrQCwCuKSaDS4o9GT33J2zZ/dYUVork
 hTXFqKcO6UvtuurAMyQOUCBfMSU5iPVURi9OzeMQpKopeaTTCnJnnaspD7djGfgqTeYLE2o
 U0xVrQaDiwQwXCqzMb9TJAp66OraYaH2vvQdgCA90lY7aO28JhCx/24uY1VeleGL7dIpLM2
 0zrSN1odNT4z2kAUlBOVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7vkhBHCjs9o=;zcZHthsQb6FPrJl4oBqeA8IwxSm
 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
 avKy4UtVQ+8QvUqng2m5AW3hU6WjOszf9d



=E5=9C=A8 2025/5/14 13:49, Anand Jain =E5=86=99=E9=81=93:
>=20
>=20
> On 14/5/25 09:47, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/5/14 11:05, Anand Jain =E5=86=99=E9=81=93:
>>> =C2=A0=C2=A0 Along with adding group dangerous..
>>> =C2=A0=C2=A0 Fix the fixed_by_kernel_commit with the correct commit.
>>> =C2=A0=C2=A0 Use the golden output to check for the expected error.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> Qu, This change is big for the last minute merge time fixes for the
>>> testcase with rbs. Pls review.
>>>
>>> =C2=A0 tests/btrfs/336=C2=A0=C2=A0=C2=A0=C2=A0 | 25 +++++++++++++-----=
=2D------
>>> =C2=A0 tests/btrfs/336.out |=C2=A0 3 ++-
>>> =C2=A0 2 files changed, 15 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/tests/btrfs/336 b/tests/btrfs/336
>>> index f6691bae6bbc..503ff03b377a 100755
>>> --- a/tests/btrfs/336
>>> +++ b/tests/btrfs/336
>>> @@ -8,10 +8,12 @@
>>> =C2=A0 # rescue=3Didatacsums mount option
>>> =C2=A0 #
>>> =C2=A0 . ./common/preamble
>>> -_begin_fstest auto scrub quick
>>> +_begin_fstest auto scrub quick dangerous
>>> -_fixed_by_kernel_commit 6aecd91a5c5b \
>>> -=C2=A0=C2=A0=C2=A0 "btrfs: avoid NULL pointer dereference if no valid=
 extent tree"
>>> +. ./common/filter
>>> +
>>> +_fixed_by_kernel_commit f95d186255b3 \
>>> +=C2=A0=C2=A0=C2=A0 "btrfs: avoid NULL pointer dereference if no valid=
 csum tree"
>>
>> My bad, wrong commit. I'm totally fine with the fix on the group and=20
>> fix commit.
>>
>>> =C2=A0 _require_scratch
>>> =C2=A0 _scratch_mkfs >> $seqres.full
>>> @@ -19,16 +21,15 @@ _scratch_mkfs >> $seqres.full
>>> =C2=A0 _try_scratch_mount "-o ro,rescue=3Dignoredatacsums" > /dev/null=
 2>&1 ||
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _notrun "rescue=3Dignoredatacsums mount=
 option not supported"
>>> -# For unpatched kernel this will cause NULL pointer dereference and=
=20
>>> crash the kernel.
>>> -$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
>>> -# For patched kernel scrub will be gracefully rejected.
>>> -if [ $? -eq 0 ]; then
>>> -=C2=A0=C2=A0=C2=A0 echo "read-only scrub should fail but didn't"
>>> -fi
>>> -
>>> -_scratch_unmount
>>> +filter_scrub_error()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 grep -E "ERROR|Status" | _filter_scratch
>>> +}
>>
>> Again I prefer not to catch exact error.
>>
>> The output message has changed in btrfs-progs commit e578b59bf612=20
>> ("btrfs-progs: convert strerror to implicit %m").
>>
>=20
>> And there is no guarantee it will not change again, nor the kernel may=
=20
>> change the error number/behavior, I just prefer not to play the filter=
=20
>> game on something non-critical.
>=20
> IMO, we have some flexibility with error messages printed to stdout.
> However, to maintain the kABI (Kernel Application Binary Interface)
> across kernel releases, it's must that when a test case expects a
> command to fail due to an ioctl(), we verify the returned error number,
> not the error text.
>=20
> For consistency within fstests, we should stick to this approach unless
> it affects backward compatibility. I've dropped the new filter below.
> Does it look reasonable?
>=20
> -------
> diff --git a/tests/btrfs/336 b/tests/btrfs/336
> index 503ff03b377a..b418ca885e34 100755
> --- a/tests/btrfs/336
> +++ b/tests/btrfs/336
> @@ -21,15 +21,10 @@ _scratch_mkfs >> $seqres.full
>  =C2=A0_try_scratch_mount "-o ro,rescue=3Dignoredatacsums" > /dev/null 2=
>&1 ||
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _notrun "rescue=3Dignoredata=
csums mount option not supported"
>=20
> -filter_scrub_error()
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grep -E "ERROR|Status" | _filter_s=
cratch
> -}
> -
>  =C2=A0# For a patched kernel, scrub will be gracefully rejected. Howeve=
r, for
>  =C2=A0# an unpatched kernel, this will cause a NULL pointer dereference=
 and
>  =C2=A0# crash the kernel.
> -$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT 2>&1 | filter_scrub_error
> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT > /dev/null |=20
> _filter_scratch
>=20
>  =C2=A0# success, all done
>  =C2=A0status=3D0
> diff --git a/tests/btrfs/336.out b/tests/btrfs/336.out
> index 63b53ef43650..982b0adbc3e8 100644
> --- a/tests/btrfs/336.out
> +++ b/tests/btrfs/336.out
> @@ -1,3 +1,2 @@
>  =C2=A0QA output created by 336
>  =C2=A0ERROR: scrubbing SCRATCH_MNT failed for device id 1: ret=3D-1, er=
rno=3D117=20
> (Structure needs
> cleaning)

Although this will not work with older progs (v4.19), but that one=20
should be assumed as EOL, I'm fine with this one.



But I still stand on my previous point, relying on the progs error=20
message (nor kernel message or whatever) is not a reliable way to catch=20
any error.

And we should not spend any more time on the stupid filter game.

Thanks,
Qu

> -Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abo=
rted
> -------
>=20
>=20
> Thanks, Anand
>=20
>=20
>> To me the current make-sure-it-fails behavior is already good enough,=
=20
>> and more future proof.
>=20
>=20
>=20
>> Thanks,
>> Qu
>>
>>> -echo "Silence is golden"
>>> +# For a patched kernel, scrub will be gracefully rejected. However, f=
or
>>> +# an unpatched kernel, this will cause a NULL pointer dereference and
>>> +# crash the kernel.
>>> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT 2>&1 | filter_scrub_err=
or
>>> =C2=A0 # success, all done
>>> =C2=A0 status=3D0
>>> diff --git a/tests/btrfs/336.out b/tests/btrfs/336.out
>>> index 9263628ee7e8..63b53ef43650 100644
>>> --- a/tests/btrfs/336.out
>>> +++ b/tests/btrfs/336.out
>>> @@ -1,2 +1,3 @@
>>> =C2=A0 QA output created by 336
>>> -Silence is golden
>>> +ERROR: scrubbing SCRATCH_MNT failed for device id 1: ret=3D-1,=20
>>> errno=3D117 (Structure needs cleaning)
>>> +Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
borted
>=20
>=20


