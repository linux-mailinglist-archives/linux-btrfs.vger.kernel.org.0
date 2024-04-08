Return-Path: <linux-btrfs+bounces-4019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFE289B71B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 07:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124301C20F28
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 05:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB1379D2;
	Mon,  8 Apr 2024 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Dg/oGIlF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE66FB9;
	Mon,  8 Apr 2024 05:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712553418; cv=none; b=mNaaFkxIxNfdDSgusVp0IczKe3rWIiVOdrXxgM+FN0kfjJUX9U/Urw78Ofc8zxFU074NXU1/+4/+FYKUHzI0pjZKptNJ1//ec63rX5cwOe70yALzPvTf6jjKbs9fHGG5CeyD506Uu+QXiqqtc6SP1FHtxy6R5V3e81L4PfxU8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712553418; c=relaxed/simple;
	bh=v29XtkG0+49Wl0K/EJrgeRDL4BuORumB+q0BpmUUyuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nWSqTxbIJeLuOwknBHLSPpA7iUbimEr9iWDk4w0Mu3Xo6ApcXAABGhQn1hwrGmOORBM6JDEN1m7DMItu+svV0PpSxX6JxRybuUMqIRtewdfpsAU8k1if1MkWRIa7/i3+fFY4YVqtMaG+jIiiTwh/RWPZcGQt95ChWnic1QrqNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Dg/oGIlF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712553408; x=1713158208; i=quwenruo.btrfs@gmx.com;
	bh=v29XtkG0+49Wl0K/EJrgeRDL4BuORumB+q0BpmUUyuk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Dg/oGIlFlMcZYyjragN5g8Ox+ZoxQ6tV5RvzpMrzf3T5gL3qStFbgCxTmSGtJsJ6
	 7d35cd+Os6SEUYswRKMrj1vcs3aky3zdMau6T9lVVyzGEv4AYJh0BHzrJJbEsXaDl
	 /5/W9SSKg6o516dSydCPofiIRAxPXVC0PEOsBarD6K5ZlzYhOffgpPaALtobnkRY2
	 XtbSdsWwElEC8FEfXcxhWI74TXRnZksat3J1w9vLL71zWHBGBOARKWaN9Z7zY3qnP
	 cBWh7qu+uIIGv7hOy3nYeGc0++Em8tZFQd/o03z9SAFrqBbbob4M3dWSSFtV1D7Xo
	 qWKy2uVnem7rpC0O0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wuq-1rqNRr0G7Y-005ZsM; Mon, 08
 Apr 2024 07:16:47 +0200
Message-ID: <2214904c-6801-48fe-95cb-2d6a27931d3b@gmx.com>
Date: Mon, 8 Apr 2024 14:46:43 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: redirect stdout of "btrfs subvolume
 snapshot" to fix output change
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240406051847.75347-1-wqu@suse.com>
 <8824a2ee-7325-4a14-ac64-dcedc03c14b9@oracle.com>
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
In-Reply-To: <8824a2ee-7325-4a14-ac64-dcedc03c14b9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q6FkVIPU5ow49ePyCbyeVsRQdWwRfRgETf8en4ExuPgfzEYpZVk
 R1PpfOTgzAN+wWZpmuB4kyj2TMudMRG9f4dP9UDxpQwAVa9iMlzrOhVF3jR8EsNYIRq8V/u
 1R7HN6Cn0a4HQSJlgUeM5U03fouAxukfALdqxG6g5PRpAvy/Z7e0p8AkADdmKzL/3ehIiz7
 CqBEJ52F5FgneCOlmSrQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nqJUJdyxZd8=;SP0lM/MB3EnEQG0dbkf311xdtDu
 B+vw+TDvUkt1HB0OI6I/ai/4l5osWwmMJTF3v/Mr6JHvzUYJTCOJmEBptahI6K1OO9EDmBdm3
 i/o0KxXz6em2RFpuhquhurKaNepfcvbL4Tgs5+prwbfdeOVoYprhXGjg5ayPkj0QmbgLeMSh/
 95fWskgunjgdn82BK4xJ2c9pKg2opXUrzOOlyKUHtj/ySCHsKox2UG+RQ82e97/1MJs0OftfC
 6VywGHe8dM2INjHpuyGxJgtgQHEN8NN8RS4xvGGnfrrJJMXzlIz0Wg42wRzTHN+O90FmIEIFL
 LDdsCoBM71Jp7cGQ27r+DaiEO7w4HTAseaH7GF6zKQXW3/9hjSsfxp0KKVq7aE87qtWlVRwB4
 /U089IZSObZi6Ty8YYcj6iWNihfhZgz5K3SIxxYa3BgKUlXFacYcXkAgM7xdrAjBtnXEg5Akd
 7/Noqn9/pelQW0UqQjwXbSV2VmjUm7GlyR3YZqMYeQp96YeBh25pJtrYhHNaLxpodN9jyTJwa
 azS6hq9U5QzEsgC4X2VJEu9jXklzw2faIFT9Kw3xfnUhCzbVIQGphyj0XWswbW7OKZGus1qSC
 4q7kUTqz/eo17+OK0z15uqmhc/0q3gpsZKfOibzoqfQqwOmgSTxByw62/qPz+Z063e5DLKxFU
 fVFZGE177KQs7YEepX1jVENdys1u7ce6V/ROrF/ESZUu2VtCyzVFyY5mLngSIWON4Whdh5k8f
 K8exr0hZKB48b94iLS0SpaxKktwitHiINeOzmu1u8iXaXVooMZU1cUYkb4O94c6qMKr+8Gf3J
 DbN4iWoomw0gOZYDYGhditUEvj4lteKvJincskur5dKpQ=



=E5=9C=A8 2024/4/8 14:16, Anand Jain =E5=86=99=E9=81=93:
> On 4/6/24 13:18, Qu Wenruo wrote:
>> [BUG]
>> All the touched test cases would fail after btrfs-progs commit
>> 5f87b467a9e7 ("btrfs-progs: subvolume: output the prompt line only when
>> the ioctl succeeded") due to golden output mismatch.
>>
>> [CAUSE]
>> Although the patch I sent to the mail list doesn't change the output at
>> all but only a timing change, David uses this patch to unify the output
>> of "btrfs subvolume create" and "btrfs subvolume snapshot".
>>
>> Unfortunately this changes the output and causes mismatch with
>> golden output.
>>
>> [FIX]
>> Just redirect stdout of "btrfs subvolume snapshot" to $seqres.full.
>> Any error from "btrfs subvolume" subgroup would lead to error messages
>> into stderr, and cause golden output mismatch.
>>
>> This can be comprehensively greped by
>> 'grep -IR "Create a" tests/btrfs/*.out' command.
>>
>> In fact, we have around 274 "btrfs subvolume snapshot|create" calls in
>> the
>> existing test cases, meanwhile only around 61 calls are populating
>> golden output (22 for subvolume creation, and 39 for snapshot creation)=
.
>>
>> Thus majority of the snapshot/subvolume creation is not populating
>> golden output already.
>>
>
> While golden output is better verification method in terms of
> accuracy, but, it falls short in verifying command exit codes.
> I personally think the run_btrfs_progs approach is better for
> 'btrfs subvolume snapshot'. It allows us to verify the command
> status without relying on the stdout.
> But, past discussions favored the golden output verification
> method instead of run_btrfs_progs.

I do no think the old conclusion is really fitting "btrfs subvolume"
command group.

>
> Thanks, Anand
>
>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> This is just a quick fix for the test failures, if accepted, further
>> cleanup would be done for unnecessary golden output for "btrfs
>> subvolume" subgroup.
>>
>> v2:
>> - Revert the change of btrfs/208.out
>> =C2=A0=C2=A0 That was part of the later cleanup, wrongly included in th=
e fix.
>> ---
>
>
>> =C2=A0 tests/btrfs/001=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 tests/btrfs/001.out | 1 -
>> =C2=A0 tests/btrfs/152=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>> =C2=A0 tests/btrfs/152.out | 2 --
>> =C2=A0 tests/btrfs/168=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0 tests/btrfs/168.out | 2 --
>> =C2=A0 tests/btrfs/169=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>> =C2=A0 tests/btrfs/169.out | 2 --
>> =C2=A0 tests/btrfs/170=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +--
>> =C2=A0 tests/btrfs/170.out | 1 -
>> =C2=A0 tests/btrfs/187=C2=A0=C2=A0=C2=A0=C2=A0 | 5 +++--
>> =C2=A0 tests/btrfs/187.out | 3 +--
>> =C2=A0 tests/btrfs/188=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>> =C2=A0 tests/btrfs/188.out | 2 --
>> =C2=A0 tests/btrfs/189=C2=A0=C2=A0=C2=A0=C2=A0 | 9 +++++----
>> =C2=A0 tests/btrfs/189.out | 2 --
>> =C2=A0 tests/btrfs/191=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0 tests/btrfs/191.out | 2 --
>> =C2=A0 tests/btrfs/200=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----
>> =C2=A0 tests/btrfs/200.out | 2 --
>> =C2=A0 tests/btrfs/202=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 tests/btrfs/202.out | 1 -
>> =C2=A0 tests/btrfs/203=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----
>> =C2=A0 tests/btrfs/203.out | 2 --
>> =C2=A0 tests/btrfs/226=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 tests/btrfs/226.out | 1 -
>> =C2=A0 tests/btrfs/276=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 tests/btrfs/276.out | 1 -
>> =C2=A0 tests/btrfs/280=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
>> =C2=A0 tests/btrfs/280.out | 1 -
>> =C2=A0 tests/btrfs/281=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 tests/btrfs/281.out | 1 -
>> =C2=A0 tests/btrfs/283=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 tests/btrfs/283.out | 1 -
>> =C2=A0 tests/btrfs/287=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0 tests/btrfs/287.out | 2 --
>> =C2=A0 tests/btrfs/293=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++--
>> =C2=A0 tests/btrfs/293.out | 2 --
>> =C2=A0 tests/btrfs/300=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 tests/btrfs/300.out | 1 -
>> =C2=A0 tests/btrfs/302=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 tests/btrfs/302.out | 1 -
>> =C2=A0 tests/btrfs/314=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 tests/btrfs/314.out | 2 --
>> =C2=A0 44 files changed, 48 insertions(+), 77 deletions(-)
>>
>> diff --git a/tests/btrfs/001 b/tests/btrfs/001
>> index 6c263999..7d79c454 100755
>> --- a/tests/btrfs/001
>> +++ b/tests/btrfs/001
>> @@ -26,7 +26,7 @@ dd if=3D/dev/zero of=3D$SCRATCH_MNT/foo bs=3D1M count=
=3D1 &>
>> /dev/null
>> =C2=A0 echo "List root dir"
>> =C2=A0 ls $SCRATCH_MNT
>> =C2=A0 echo "Creating snapshot of root dir"
>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap |
>> _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap >>
>> $seqres.full
>> =C2=A0 echo "List root dir after snapshot"
>> =C2=A0 ls $SCRATCH_MNT
>> =C2=A0 echo "List snapshot dir"
>> diff --git a/tests/btrfs/001.out b/tests/btrfs/001.out
>> index c782bde9..9b493fab 100644
>> --- a/tests/btrfs/001.out
>> +++ b/tests/btrfs/001.out
>> @@ -3,7 +3,6 @@ Creating file foo in root dir
>> =C2=A0 List root dir
>> =C2=A0 foo
>> =C2=A0 Creating snapshot of root dir
>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> =C2=A0 List root dir after snapshot
>> =C2=A0 foo
>> =C2=A0 snap
>> diff --git a/tests/btrfs/152 b/tests/btrfs/152
>> index 75f576c3..d26cd77a 100755
>> --- a/tests/btrfs/152
>> +++ b/tests/btrfs/152
>> @@ -32,12 +32,12 @@ touch $SCRATCH_MNT/subvol{1,2}/foo
>> =C2=A0 # Create base snapshots and send them
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
>> -=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol1/.snapshots/1 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
>> -=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol2/.snapshots/1 >> $seqres.full
>> =C2=A0 for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG send $SCRATCH_MNT/subvo=
l1/.snapshots/1 2>
>> /dev/null | \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG receive $S=
CRATCH_MNT/${recv} | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG receive $S=
CRATCH_MNT/${recv} >> $seqres.full
>> =C2=A0 done
>> =C2=A0 # Now do 10 loops of concurrent incremental send/receives
>> diff --git a/tests/btrfs/152.out b/tests/btrfs/152.out
>> index a95bb579..33dd36e8 100644
>> --- a/tests/btrfs/152.out
>> +++ b/tests/btrfs/152.out
>> @@ -5,8 +5,6 @@ Create subvolume 'SCRATCH_MNT/recv1_1'
>> =C2=A0 Create subvolume 'SCRATCH_MNT/recv1_2'
>> =C2=A0 Create subvolume 'SCRATCH_MNT/recv2_1'
>> =C2=A0 Create subvolume 'SCRATCH_MNT/recv2_2'
>> -Create a readonly snapshot of 'SCRATCH_MNT/subvol1' in
>> 'SCRATCH_MNT/subvol1/.snapshots/1'
>> -Create a readonly snapshot of 'SCRATCH_MNT/subvol2' in
>> 'SCRATCH_MNT/subvol2/.snapshots/1'
>> =C2=A0 At subvol 1
>> =C2=A0 At subvol 1
>> =C2=A0 At subvol 1
>> diff --git a/tests/btrfs/168 b/tests/btrfs/168
>> index acc58b51..97d00ba9 100755
>> --- a/tests/btrfs/168
>> +++ b/tests/btrfs/168
>> @@ -74,7 +74,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro fal=
se
>> =C2=A0 # Create a snapshot of the subvolume, to be used later as the pa=
rent
>> snapshot
>> =C2=A0 # for an incremental send operation.
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1
>> $SCRATCH_MNT/snap1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 # First do a full send of this snapshot.
>> =C2=A0 $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/sn=
ap1
>> @@ -88,7 +88,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K"
>> $SCRATCH_MNT/sv1/baz >>$seqres.full
>> =C2=A0 # Create a second snapshot of the subvolume, to be used later as=
 the
>> send
>> =C2=A0 # snapshot of an incremental send operation.
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1
>> $SCRATCH_MNT/snap2 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 # Temporarily turn the second snapshot to read-write mode and th=
en
>> open a file
>> =C2=A0 # descriptor on its foo file.
>> diff --git a/tests/btrfs/168.out b/tests/btrfs/168.out
>> index 6cfce8cd..f7eca2d7 100644
>> --- a/tests/btrfs/168.out
>> +++ b/tests/btrfs/168.out
>> @@ -1,9 +1,7 @@
>> =C2=A0 QA output created by 168
>> =C2=A0 Create subvolume 'SCRATCH_MNT/sv1'
>> =C2=A0 At subvol SCRATCH_MNT/sv1
>> -Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
>> =C2=A0 At subvol SCRATCH_MNT/snap1
>> -Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
>> =C2=A0 At subvol SCRATCH_MNT/snap2
>> =C2=A0 At subvol sv1
>> =C2=A0 OK
>> diff --git a/tests/btrfs/169 b/tests/btrfs/169
>> index 009fdaee..c215f281 100755
>> --- a/tests/btrfs/169
>> +++ b/tests/btrfs/169
>> @@ -43,8 +43,8 @@ $XFS_IO_PROG -f -c "falloc -k 0 4M" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c "pwrite=
 -S 0xea 0 1M" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_M=
NT/foobar | _filter_xfs_io
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>> $SCRATCH_MNT/snap1 2>&1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1=
 \
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/sna=
p1
>> 2>&1 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> @@ -54,7 +54,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap
>> $SCRATCH_MNT/snap1 2>&1 \
>> =C2=A0 $XFS_IO_PROG -c "fpunch 1M 2M" $SCRATCH_MNT/foobar
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>> $SCRATCH_MNT/snap2 2>&1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2=
.snap \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_M=
NT/snap2 2>&1 | _filter_scratch
>> diff --git a/tests/btrfs/169.out b/tests/btrfs/169.out
>> index ba77bf0a..a6df713a 100644
>> --- a/tests/btrfs/169.out
>> +++ b/tests/btrfs/169.out
>> @@ -1,9 +1,7 @@
>> =C2=A0 QA output created by 169
>> =C2=A0 wrote 1048576/1048576 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> =C2=A0 At subvol SCRATCH_MNT/snap1
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>> =C2=A0 At subvol SCRATCH_MNT/snap2
>> =C2=A0 File digest in the original filesystem:
>> =C2=A0 d31659e82e87798acd4669a1e0a19d4f=C2=A0 SCRATCH_MNT/snap2/foobar
>> diff --git a/tests/btrfs/170 b/tests/btrfs/170
>> index ab105d36..29a15162 100755
>> --- a/tests/btrfs/170
>> +++ b/tests/btrfs/170
>> @@ -45,8 +45,7 @@ echo "File digest after write:"
>> =C2=A0 md5sum $SCRATCH_MNT/foobar | _filter_scratch
>> =C2=A0 # Create a snapshot of the subvolume where our file is.
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
>> 2>&1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
>> 2>&1 >> $seqres.full
>> =C2=A0 # Cleanly unmount the filesystem.
>> =C2=A0 _scratch_unmount
>> diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
>> index 4c5fd87a..8ad959f3 100644
>> --- a/tests/btrfs/170.out
>> +++ b/tests/btrfs/170.out
>> @@ -3,6 +3,5 @@ wrote 131072/131072 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 File digest after write:
>> =C2=A0 85054e9e74bc3ae186d693890106b71f=C2=A0 SCRATCH_MNT/foobar
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> =C2=A0 File digest after mounting the filesystem again:
>> =C2=A0 85054e9e74bc3ae186d693890106b71f=C2=A0 SCRATCH_MNT/foobar
>> diff --git a/tests/btrfs/187 b/tests/btrfs/187
>> index d3cf05a1..86c411b6 100755
>> --- a/tests/btrfs/187
>> +++ b/tests/btrfs/187
>> @@ -152,7 +152,7 @@ done
>> =C2=A0 wait ${create_pids[@]}
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>> $SCRATCH_MNT/snap1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 # Add some more files, so that that are substantial differences
>> between the
>> =C2=A0 # two test snapshots used for an incremental send later.
>> @@ -184,7 +184,7 @@ done
>> =C2=A0 wait ${setxattr_pids[@]}
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>> $SCRATCH_MNT/snap2 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 full_send_loop 5 &
>> =C2=A0 full_send_pid=3D$!
>> @@ -221,5 +221,6 @@ wait $balance_pid
>> =C2=A0 #
>> =C2=A0 _dmesg_since_test_start | grep -E -e '\bBTRFS error \(device .*?=
\):'
>> +echo "Silence is golden"
>> =C2=A0 status=3D0
>> =C2=A0 exit
>> diff --git a/tests/btrfs/187.out b/tests/btrfs/187.out
>> index ab522cfe..331a07c6 100644
>> --- a/tests/btrfs/187.out
>> +++ b/tests/btrfs/187.out
>> @@ -1,3 +1,2 @@
>> =C2=A0 QA output created by 187
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>> +Silence is golden
>> diff --git a/tests/btrfs/188 b/tests/btrfs/188
>> index fcaf84b1..1578095a 100755
>> --- a/tests/btrfs/188
>> +++ b/tests/btrfs/188
>> @@ -44,8 +44,8 @@ _scratch_mount
>> =C2=A0 $XFS_IO_PROG -f -c "pwrite -S 0xab 0 500K" $SCRATCH_MNT/foobar |
>> _filter_xfs_io
>> =C2=A0 $XFS_IO_PROG -c "falloc -k 1200K 800K" $SCRATCH_MNT/foobar
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
>> 2>&1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base =
\
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/bas=
e
>> 2>&1 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> @@ -54,7 +54,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap
>> $SCRATCH_MNT/base 2>&1 \
>> =C2=A0 $XFS_IO_PROG -c "fpunch 0 500K" $SCRATCH_MNT/foobar
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>> $SCRATCH_MNT/incr 2>&1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.=
snap \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/incr 2>&1 | _filter_scratch
>> diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
>> index 260988e6..99eb3133 100644
>> --- a/tests/btrfs/188.out
>> +++ b/tests/btrfs/188.out
>> @@ -1,9 +1,7 @@
>> =C2=A0 QA output created by 188
>> =C2=A0 wrote 512000/512000 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>> =C2=A0 At subvol SCRATCH_MNT/base
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>> =C2=A0 At subvol SCRATCH_MNT/incr
>> =C2=A0 File digest in the original filesystem:
>> =C2=A0 816df6f64deba63b029ca19d880ee10a=C2=A0 SCRATCH_MNT/incr/foobar
>> diff --git a/tests/btrfs/189 b/tests/btrfs/189
>> index ec6e56fa..618de266 100755
>> --- a/tests/btrfs/189
>> +++ b/tests/btrfs/189
>> @@ -45,8 +45,9 @@ $XFS_IO_PROG -f -c "pwrite -S 0xc7 0 2M"
>> $SCRATCH_MNT/bar | _filter_xfs_io
>> =C2=A0 $XFS_IO_PROG -f -c "pwrite -S 0x4d 0 2M" $SCRATCH_MNT/baz |
>> _filter_xfs_io
>> =C2=A0 $XFS_IO_PROG -f -c "pwrite -S 0xe2 0 2M" $SCRATCH_MNT/zoo |
>> _filter_xfs_io
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
>> 2>&1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base =
\
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> +
>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/bas=
e
>> 2>&1 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> @@ -70,8 +71,8 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1600K 0
>> 128K" $SCRATCH_MNT/zoo \
>> =C2=A0 # operations.
>> =C2=A0 $XFS_IO_PROG -c "truncate 710K" $SCRATCH_MNT/bar
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
>> 2>&1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr =
\
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.=
snap \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/incr 2>&1 | _filter_scratch
>> diff --git a/tests/btrfs/189.out b/tests/btrfs/189.out
>> index 79c70b03..b4984d37 100644
>> --- a/tests/btrfs/189.out
>> +++ b/tests/btrfs/189.out
>> @@ -7,13 +7,11 @@ wrote 2097152/2097152 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 wrote 2097152/2097152 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>> =C2=A0 At subvol SCRATCH_MNT/base
>> =C2=A0 linked 131072/131072 bytes at offset 655360
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 linked 131072/131072 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>> =C2=A0 At subvol SCRATCH_MNT/incr
>> =C2=A0 At subvol base
>> =C2=A0 At snapshot incr
>> diff --git a/tests/btrfs/191 b/tests/btrfs/191
>> index 3c565d0a..c01abb5a 100755
>> --- a/tests/btrfs/191
>> +++ b/tests/btrfs/191
>> @@ -44,7 +44,7 @@ $XFS_IO_PROG -c "pwrite -S 0xb8 512K 512K"
>> $SCRATCH_MNT/foo | _filter_xfs_io
>> =C2=A0 # Create the base snapshot and the parent send stream from it.
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>> $SCRATCH_MNT/mysnap1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/mys=
nap1
>> 2>&1 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> @@ -55,7 +55,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xb8 0 1M"
>> $SCRATCH_MNT/bar | _filter_xfs_io
>> =C2=A0 # Create the second snapshot, used for the incremental send, bef=
ore
>> doing the
>> =C2=A0 # file deduplication.
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>> $SCRATCH_MNT/mysnap2 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 # Now before creating the incremental send stream:
>> =C2=A0 #
>> diff --git a/tests/btrfs/191.out b/tests/btrfs/191.out
>> index 4269803c..471c05da 100644
>> --- a/tests/btrfs/191.out
>> +++ b/tests/btrfs/191.out
>> @@ -3,11 +3,9 @@ wrote 524288/524288 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 wrote 524288/524288 bytes at offset 524288
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
>> =C2=A0 At subvol SCRATCH_MNT/mysnap1
>> =C2=A0 wrote 1048576/1048576 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
>> =C2=A0 deduped 524288/524288 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 deduped 524288/524288 bytes at offset 524288
>> diff --git a/tests/btrfs/200 b/tests/btrfs/200
>> index 5ce3775f..520e7f21 100755
>> --- a/tests/btrfs/200
>> +++ b/tests/btrfs/200
>> @@ -51,8 +51,8 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K"
>> $SCRATCH_MNT/foo \
>> =C2=A0 $XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/ba=
r \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_xfs_io
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
>> 2>&1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base =
\
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/bas=
e
>> 2>&1 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> @@ -63,8 +63,8 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap
>> $SCRATCH_MNT/base 2>&1 \
>> =C2=A0 $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MN=
T/bar \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_xfs_io
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
>> 2>&1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr =
\
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.=
snap \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/incr 2>&1 | _filter_scratch
>> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
>> index 3eec567e..306d9b24 100644
>> --- a/tests/btrfs/200.out
>> +++ b/tests/btrfs/200.out
>> @@ -5,11 +5,9 @@ linked 65536/65536 bytes at offset 65536
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 wrote 65536/65536 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>> =C2=A0 At subvol SCRATCH_MNT/base
>> =C2=A0 linked 65536/65536 bytes at offset 65536
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>> =C2=A0 At subvol SCRATCH_MNT/incr
>> =C2=A0 At subvol base
>> =C2=A0 At snapshot incr
>> diff --git a/tests/btrfs/202 b/tests/btrfs/202
>> index 5f0429f1..1c8c5647 100755
>> --- a/tests/btrfs/202
>> +++ b/tests/btrfs/202
>> @@ -28,7 +28,7 @@ _scratch_mount
>> =C2=A0 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scrat=
ch
>> =C2=A0 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scr=
atch
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/=
c \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 # Need the dummy entry created so that we get the invalid remova=
l
>> when we rmdir
>> =C2=A0 ls $SCRATCH_MNT/c/b
>> diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
>> index 7f33d49f..28d52e3f 100644
>> --- a/tests/btrfs/202.out
>> +++ b/tests/btrfs/202.out
>> @@ -1,4 +1,3 @@
>> =C2=A0 QA output created by 202
>> =C2=A0 Create subvolume 'SCRATCH_MNT/a'
>> =C2=A0 Create subvolume 'SCRATCH_MNT/a/b'
>> -Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
>> diff --git a/tests/btrfs/203 b/tests/btrfs/203
>> index e506118e..e4ec533f 100755
>> --- a/tests/btrfs/203
>> +++ b/tests/btrfs/203
>> @@ -43,8 +43,8 @@ _scratch_mount
>> =C2=A0 # file in the parent snapshot.
>> =C2=A0 $XFS_IO_PROG -f -c "pwrite -S 0xf1 0 64K" $SCRATCH_MNT/foobar |
>> _filter_xfs_io
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
>> 2>&1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base =
\
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/bas=
e
>> 2>&1 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> @@ -69,8 +69,8 @@ $XFS_IO_PROG -c "pwrite -S 0xab 512K 64K" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c "reflin=
k $SCRATCH_MNT/foobar 448K 192K 192K" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_M=
NT/foobar | _filter_xfs_io
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
>> 2>&1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr =
\
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.=
snap \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_M=
NT/incr 2>&1 | _filter_scratch
>> diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
>> index 58739a98..67ec1bd7 100644
>> --- a/tests/btrfs/203.out
>> +++ b/tests/btrfs/203.out
>> @@ -1,7 +1,6 @@
>> =C2=A0 QA output created by 203
>> =C2=A0 wrote 65536/65536 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>> =C2=A0 At subvol SCRATCH_MNT/base
>> =C2=A0 wrote 65536/65536 bytes at offset 524288
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> @@ -15,7 +14,6 @@ wrote 65536/65536 bytes at offset 786432
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 linked 196608/196608 bytes at offset 196608
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>> =C2=A0 At subvol SCRATCH_MNT/incr
>> =C2=A0 File foobar digest in the original filesystem:
>> =C2=A0 2b76b23b62fdbbbcae1ee37eec84fd7d
>> diff --git a/tests/btrfs/226 b/tests/btrfs/226
>> index 7034fcc7..017ff479 100755
>> --- a/tests/btrfs/226
>> +++ b/tests/btrfs/226
>> @@ -51,7 +51,7 @@ $XFS_IO_PROG -s -c "pwrite -S 0xab 0 64K" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_M=
NT/f2 | _filter_xfs_io
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/sn=
ap \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 # Write into the range of the first extent so that that range no
>> longer has a
>> =C2=A0 # shared extent.
>> diff --git a/tests/btrfs/226.out b/tests/btrfs/226.out
>> index c63982b0..815217ac 100644
>> --- a/tests/btrfs/226.out
>> +++ b/tests/btrfs/226.out
>> @@ -13,7 +13,6 @@ wrote 65536/65536 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 wrote 65536/65536 bytes at offset 65536
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> =C2=A0 wrote 65536/65536 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 pwrite: Resource temporarily unavailable
>> diff --git a/tests/btrfs/276 b/tests/btrfs/276
>> index f15f2082..b484d20e 100755
>> --- a/tests/btrfs/276
>> +++ b/tests/btrfs/276
>> @@ -105,7 +105,7 @@ sync
>> =C2=A0 echo "Number of non-shared extents in the whole file:
>> $(count_not_shared_extents)"
>> =C2=A0 # Creating a snapshot.
>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap |
>> _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap >>
>> $seqres.full
>> =C2=A0 # We have a snapshot, so now all extents should be reported as s=
hared.
>> =C2=A0 echo "Number of shared extents in the whole file:
>> $(count_shared_extents)"
>> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
>> index 352e06b4..e30ca188 100644
>> --- a/tests/btrfs/276.out
>> +++ b/tests/btrfs/276.out
>> @@ -1,6 +1,5 @@
>> =C2=A0 QA output created by 276
>> =C2=A0 Number of non-shared extents in the whole file: 2000
>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> =C2=A0 Number of shared extents in the whole file: 2000
>> =C2=A0 wrote 65536/65536 bytes at offset 524288
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> diff --git a/tests/btrfs/280 b/tests/btrfs/280
>> index fc049adb..41d3caa7 100755
>> --- a/tests/btrfs/280
>> +++ b/tests/btrfs/280
>> @@ -37,7 +37,8 @@ _scratch_mount -o compress
>> =C2=A0 $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo |
>> _filter_xfs_io
>> =C2=A0 # Create a RW snapshot of the default subvolume.
>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap |
>> _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap \
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 echo
>> =C2=A0 echo "File foo fiemap before COWing extent:"
>> diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
>> index 5371f3b0..c5ecf688 100644
>> --- a/tests/btrfs/280.out
>> +++ b/tests/btrfs/280.out
>> @@ -1,7 +1,6 @@
>> =C2=A0 QA output created by 280
>> =C2=A0 wrote 134217728/134217728 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> =C2=A0 File foo fiemap before COWing extent:
>> diff --git a/tests/btrfs/281 b/tests/btrfs/281
>> index ddc7d9e8..c9efeb67 100755
>> --- a/tests/btrfs/281
>> +++ b/tests/btrfs/281
>> @@ -53,7 +53,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 0 64K"
>> $SCRATCH_MNT/foo \
>> =C2=A0 echo "Creating snapshot and a send stream for it..."
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT=
/snap \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send --compressed-data -f $send_stream
>> $SCRATCH_MNT/snap 2>&1 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> diff --git a/tests/btrfs/281.out b/tests/btrfs/281.out
>> index 2585e3e5..0b775689 100644
>> --- a/tests/btrfs/281.out
>> +++ b/tests/btrfs/281.out
>> @@ -6,7 +6,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX
>> ops/sec)
>> =C2=A0 linked 65536/65536 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 Creating snapshot and a send stream for it...
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> =C2=A0 At subvol SCRATCH_MNT/snap
>> =C2=A0 Creating a new filesystem to receive the send stream...
>> =C2=A0 At subvol snap
>> diff --git a/tests/btrfs/283 b/tests/btrfs/283
>> index 118df08b..2ddd95bc 100755
>> --- a/tests/btrfs/283
>> +++ b/tests/btrfs/283
>> @@ -58,7 +58,7 @@ $XFS_IO_PROG -c "pwrite -S 0xcd -b 64K 64K 64K"
>> $SCRATCH_MNT/foo | _filter_xfs_i
>> =C2=A0 echo "Creating snapshot and a send stream for it..."
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT=
/snap \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_stream $SCRATCH_MNT/snap 2>&1 |
>> _filter_scratch
>> diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
>> index 286dae33..7c7d9f73 100644
>> --- a/tests/btrfs/283.out
>> +++ b/tests/btrfs/283.out
>> @@ -4,7 +4,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX
>> ops/sec)
>> =C2=A0 wrote 65536/65536 bytes at offset 65536
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 Creating snapshot and a send stream for it...
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> =C2=A0 At subvol SCRATCH_MNT/snap
>> =C2=A0 Creating a new filesystem to receive the send stream...
>> =C2=A0 At subvol snap
>> diff --git a/tests/btrfs/287 b/tests/btrfs/287
>> index 64e6ef35..33f4a341 100755
>> --- a/tests/btrfs/287
>> +++ b/tests/btrfs/287
>> @@ -112,9 +112,9 @@ query_logical_ino -o $bytenr
>> =C2=A0 # Now create two snapshots and then do some queries.
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>> $SCRATCH_MNT/snap1 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>> $SCRATCH_MNT/snap2 \
>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 snap1_id=3D$(_btrfs_get_subvolid $SCRATCH_MNT snap1)
>> =C2=A0 snap2_id=3D$(_btrfs_get_subvolid $SCRATCH_MNT snap2)
>> diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
>> index 30eac8fa..4814594f 100644
>> --- a/tests/btrfs/287.out
>> +++ b/tests/btrfs/287.out
>> @@ -41,8 +41,6 @@ resolve first extent +3M offset with ignore offset
>> option:
>> =C2=A0 inode 257 offset 16777216 root 5
>> =C2=A0 inode 257 offset 8388608 root 5
>> =C2=A0 inode 257 offset 2097152 root 5
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>> =C2=A0 resolve first extent:
>> =C2=A0 inode 257 offset 16777216 snap2
>> =C2=A0 inode 257 offset 8388608 snap2
>> diff --git a/tests/btrfs/293 b/tests/btrfs/293
>> index 06f96dc4..a6bd68e6 100755
>> --- a/tests/btrfs/293
>> +++ b/tests/btrfs/293
>> @@ -32,9 +32,11 @@ swap_file=3D"$SCRATCH_MNT/swapfile"
>> =C2=A0 _format_swapfile $swap_file $(($(_get_page_size) * 64)) >> $seqr=
es.full
>> =C2=A0 echo "Creating first snapshot..."
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>> $SCRATCH_MNT/snap1 | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1=
 \
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 echo "Creating second snapshot..."
>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 |
>> _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 \
>> +=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0 echo "Activating swap file... (should fail due to snapshots)"
>> =C2=A0 _swapon_file $swap_file 2>&1 | _filter_scratch
>> diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
>> index fd04ac91..5da7accc 100644
>> --- a/tests/btrfs/293.out
>> +++ b/tests/btrfs/293.out
>> @@ -1,8 +1,6 @@
>> =C2=A0 QA output created by 293
>> =C2=A0 Creating first snapshot...
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> =C2=A0 Creating second snapshot...
>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>> =C2=A0 Activating swap file... (should fail due to snapshots)
>> =C2=A0 swapon: SCRATCH_MNT/swapfile: swapon failed: Invalid argument
>> =C2=A0 Deleting first snapshot...
>> diff --git a/tests/btrfs/300 b/tests/btrfs/300
>> index 8a0eaecf..4ea22a01 100755
>> --- a/tests/btrfs/300
>> +++ b/tests/btrfs/300
>> @@ -43,7 +43,7 @@ $BTRFS_UTIL_PROG subvolume create subvol;
>> =C2=A0 touch subvol/{1,2,3};
>> =C2=A0 $BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
>> =C2=A0 touch subvol/subsubvol/{4,5,6};
>> -$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
>> +$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot > /dev/null;
>> =C2=A0 "
>> =C2=A0 find $test_dir/. -printf "%M %u %g ./%P\n"
>> diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
>> index 6e94447e..8611f606 100644
>> --- a/tests/btrfs/300.out
>> +++ b/tests/btrfs/300.out
>> @@ -1,7 +1,6 @@
>> =C2=A0 QA output created by 300
>> =C2=A0 Create subvolume './subvol'
>> =C2=A0 Create subvolume 'subvol/subsubvol'
>> -Create a snapshot of 'subvol' in './snapshot'
>> =C2=A0 drwxr-xr-x fsgqa fsgqa ./
>> =C2=A0 drwxr-xr-x fsgqa fsgqa ./subvol
>> =C2=A0 -rw-r--r-- fsgqa fsgqa ./subvol/1
>> diff --git a/tests/btrfs/302 b/tests/btrfs/302
>> index f3e6044b..5dcd5295 100755
>> --- a/tests/btrfs/302
>> +++ b/tests/btrfs/302
>> @@ -46,7 +46,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
>> =C2=A0 # Now create a snapshot of the subvolume and make it accessible =
from
>> within the
>> =C2=A0 # subvolume.
>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol/s=
nap | _filter_scratch
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol/s=
nap >> $seqres.full
>> =C2=A0 # Now unmount and mount again the fs. We want to verify we are a=
ble
>> to read all
>> =C2=A0 # metadata for the snapshot from disk (no IO failures, etc).
>> diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
>> index 8770aefc..e89d1297 100644
>> --- a/tests/btrfs/302.out
>> +++ b/tests/btrfs/302.out
>> @@ -1,4 +1,3 @@
>> =C2=A0 QA output created by 302
>> =C2=A0 Create subvolume 'SCRATCH_MNT/subvol'
>> -Create a readonly snapshot of 'SCRATCH_MNT/subvol' in
>> 'SCRATCH_MNT/subvol/snap'
>> =C2=A0 OK
>> diff --git a/tests/btrfs/314 b/tests/btrfs/314
>> index 887cb69e..719a930a 100755
>> --- a/tests/btrfs/314
>> +++ b/tests/btrfs/314
>> @@ -43,7 +43,7 @@ send_receive_tempfsid()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000'=
 ${src}/foo |
>> _filter_xfs_io
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $=
{src} ${src}/snap1 | \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _fil=
ter_testdir_and_scratch
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo Send ${src} | _filter_testdir_and_s=
cratch
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG send -f ${sendfile} ${s=
rc}/snap1 2>&1 | \
>> diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
>> index 21963899..8a311671 100644
>> --- a/tests/btrfs/314.out
>> +++ b/tests/btrfs/314.out
>> @@ -3,7 +3,6 @@ QA output created by 314
>> =C2=A0 From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_=
mnt
>> =C2=A0 wrote 9000/9000 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> =C2=A0 Send SCRATCH_MNT
>> =C2=A0 At subvol SCRATCH_MNT/snap1
>> =C2=A0 Receive TEST_DIR/314/tempfsid_mnt
>> @@ -14,7 +13,6 @@ Recv:=C2=A0=C2=A0=C2=A0 42d69d1a6d333a7ebdf64792a555e=
392
>> TEST_DIR/314/tempfsid_mnt/snap1/foo
>> =C2=A0 From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_=
MNT
>> =C2=A0 wrote 9000/9000 bytes at offset 0
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in
>> 'TEST_DIR/314/tempfsid_mnt/snap1'
>> =C2=A0 Send TEST_DIR/314/tempfsid_mnt
>> =C2=A0 At subvol TEST_DIR/314/tempfsid_mnt/snap1
>> =C2=A0 Receive SCRATCH_MNT
>
>

