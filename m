Return-Path: <linux-btrfs+bounces-6936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7F594395F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 01:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658641C216AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 23:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5211F16DC24;
	Wed, 31 Jul 2024 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TAeWVsbT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB6816C695;
	Wed, 31 Jul 2024 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722468448; cv=none; b=QcuF9DSrX82cTUZdMF4FLjznSj+cQRigDO2uh7EqN7y/dCdKJtR0/qMPaDnU6RUGvS99QkKIuN5pv2v9B3Xw+xWlPIMScd2g6igKO6po5TiqXvuM9H9XRnjikix/WkSDEHC23hRkvUBP6QZG+mNgxZdh8yBcJdMf2Ms3tuagFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722468448; c=relaxed/simple;
	bh=dlaVeLbUlqg7Tje9ufn0i1OIj3UV68RF69ko3PSVK5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KT2hiS4I0C7VQehhAVkG/f3TXT4hz9pIMk+xnG7HbU5uiB/1rDLUzMG6BpgklJBSjwPKnK1hCdOA88m8fQ5yZSfEVF64twoToDN7kL/xYFLn5NnjWxQr/9PB8uhC4V0dQF9GR45qxo6S5SxnI+i4rALqUcddbeXYWIw9MB/bbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TAeWVsbT; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722468437; x=1723073237; i=quwenruo.btrfs@gmx.com;
	bh=oH/itCIzGCwz4Urq+gqsWwPOrSFzThax/NGE3vh8rJw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TAeWVsbTz+gw5+BE8MBZhdvMxKX/nZtlpH/VugwIna7tseSNLcFA0ho4BAfweR+3
	 AiBEv9ieEnBYbytajVzlsE8R32QQZI57a2QBML/1pFR2pwB2yPWuWqlK8om0kiT1L
	 tLdKcSPqXaIfzX8KmbiuPauGYOzQkdAcSSjrySGTkn+DvMVc/4a7+A5Xl6bt33ekG
	 rwEDmENv/DYWSGCBxHG7jH7C/hu0WhQpSM/XBvznhZCcbGARzZAIhWJosQmqYxWeQ
	 Sw/U988tXFbY2o0wn9j6gSdfCoLmd/NR+bVO4LsaHXDeWSTVfpAq7TIqTMWw+a5bU
	 nLzYa7pkdGjJsYnrHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MulqD-1sHDyY0vOF-012vn5; Thu, 01
 Aug 2024 01:27:17 +0200
Message-ID: <37a5f045-b6c1-4d82-83ad-2839c3f5daf7@gmx.com>
Date: Thu, 1 Aug 2024 08:57:14 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/287: wait for subvolume deletion to complete
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <40c169580bd42e96faf11c7ce8805399dd0a180c.1722429630.git.fdmanana@suse.com>
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
In-Reply-To: <40c169580bd42e96faf11c7ce8805399dd0a180c.1722429630.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BL+FNqC0lev/PvYJwLr/F9dsiFbwIOFCyH0x8+twH1oKC5+kB46
 +20V5Wg25ZJob6XmTQYPwq/EBl9gZfIa+kqEcyOnaJC8z1Ba3jKsMiEErUddNnukGC2ovdW
 FjzcC+AFcbg/flIn7yMspw794EAkzXdXlm925CW2gUwNn3mCxZfXFJOQSUA+bWc4SLfxoUT
 2UpvXfIxYZm9gX1yri+7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dqr8809sf80=;kt1YQ44NL1GMIGhoc/avoSz01Or
 WctdLdBcMQ7TKF7tZuD21VXWEo+BqmwXZmF4UO/5Ovhzu6DmgxvCcECdyXWWsVfR7dBROp6Ow
 t17OWqz5f2vjS/z+6RfcjYggagMXcr6i1e3CcrtZ7j0lld8vbxXyrwotYfeBY91I2ruv2oCpq
 3AbVgciEDliNr6FvjM69gHQv9g6ACzpUx7v5BlOboZdbX315CyCMPCHILP7RANU3LEIj63BkL
 fz4E95ldRp9P/Pa7NntNWUGMNDTHMljCsGFMxX7Ci+1i2iHmwhI6KxNTZqcThnU9nWyUUOVrC
 IlqnoL6kCUm59KCMRSnMeO4tzwQif928jdPlgsSRVJVR6kS8gBJ7nqz38l4cczKQAsKZKURrV
 E4RQSJStW+OgsRNiCQOKqYZWCY3G9TAcOHMyb1wRPk1ySwSdx2zi6jvhlvWJdxEb9wfKp/nFp
 qEhob/jQUbCcxn+mb24SEgtwKEWgepQRprCSsDTCuJwMxviwHatUgwJWXqni4j0v9T/3vFa7L
 FLd1jwCPgcyH56zLGwlxKKfacPGbcmoyMNGPMUAKQlPv7WaXkLo9YE5P6thRwMoSZx1OFH7k6
 OtRTNLSWEbeY8jheNb3TFOw2CTct84eYumZlhWkr/1Jxv0ybQQ5r22xXnpBomFLoP7W2ayc4L
 OQj9bRGqW8Fb1hPl4k5FzorJC6aSQXBTQz3/YabBBTIGOIpk4dQoZ3NCHkfZ2gWcfnPZMSpXc
 fFXnXgjSjmpoXvtIuxBu4+ol8MY/trSEQQEC9AOdBBTf6oPZqE0jDnz01v0dOT/e576BCPntz
 Z02ZLxEJtWtTAskx+irZswFQ==



=E5=9C=A8 2024/7/31 22:11, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> The test deletes the subvolume and then immediately calls the logical
> resolve ioctl to confirm the extent is not referenced by the subvolume
> anymore. This however may often fail because the subvolume delete only
> makes the subvolume not accessible to user space anymore, but the actual
> deletion of the subvolume tree, and all its data references, happens in
> the background in the cleaner kthread running in kernel space.
>
> So if by the time we do the query the cleaner kthread has not yet delete=
d
> the subvolume tree, the test fails like this:
>
>    $ ./check btrfs/287
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 5.14.0-btrfs-next-22 #1 SMP Tue=
 Jul 30 16:31:55 WEST 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>
>    btrfs/287 0s ... - output mismatch (see /home/fdmanana/git/hub/xfstes=
ts/results//btrfs/287.out.bad)
>        --- tests/btrfs/287.out	2024-07-30 17:40:49.037599612 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad	20=
24-07-31 13:06:28.275728352 +0100
>        @@ -82,12 +82,18 @@
>         inode 257 offset 20971520 snap2
>         inode 257 offset 12582912 snap2
>         inode 257 offset 4194304 snap2
>        +inode 257 offset 20971520 snap1
>        +inode 257 offset 12582912 snap1
>        +inode 257 offset 4194304 snap1
>         inode 257 offset 20971520 root 5
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out=
 /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see the e=
ntire diff)
>
>    HINT: You _MAY_ be missing kernel fix:
>          0cad8f14d70c btrfs: fix backref walking not returning all inode=
 refs
>
> Fix this by using the "subvolume sync" command to wait for the subvolume
> to be deleted by the cleaner kthread before doing logical resolve querie=
s.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/287 | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/tests/btrfs/287 b/tests/btrfs/287
> index d6c04ea8..e88f4e0a 100755
> --- a/tests/btrfs/287
> +++ b/tests/btrfs/287
> @@ -147,6 +147,27 @@ query_logical_ino -o $second_extent_bytenr | filter=
_snapshot_ids
>   # Now delete the first snapshot and repeat the last 2 queries.
>   $BTRFS_UTIL_PROG subvolume delete -C $SCRATCH_MNT/snap1 | _filter_btrf=
s_subvol_delete
>
> +# Remount with a commit interval of 1s so that we wake up the cleaner k=
thread
> +# (which does the actual subvolume tree deletion) and the transaction u=
sed by
> +# the cleaner kthread to delete the tree gets committed sooner and we w=
ait less
> +# in the subvolume sync command below.
> +_scratch_remount commit=3D1
> +
> +# The subvolume delete only made the subvolume not accessible anymore, =
but its
> +# tree and references to data extents are only deleted when the cleaner=
 kthread
> +# runs, so wait for the cleaner to finish. It isn't enough to pass -C/-=
c (commit
> +# transaction) because the cleaner may run only after the transaction c=
ommit.
> +# Most of the time we don't need this because the transaction kthread w=
akes up
> +# the cleaner kthread, which deletes the subvolume before we query the =
extents
> +# below, as this is a very small filesystem and therefore very fast.
> +# Nevertheless it's racy and on slower machines it may fail often as we=
ll as on
> +# kernels without the reworked async transaction commit (kernel commit
> +# fdfbf020664b ("btrfs: rework async transaction committing"), which la=
nded in
> +# kernel 5.17) which changes timing and substantially increases the cha=
nces that
> +# the cleaner already ran and deleted the subvolume tree by the time we=
 do the
> +# queries below.
> +$BTRFS_UTIL_PROG subvolume sync $SCRATCH_MNT >> $seqres.full
> +
>   # Query the second extent with an offset of 0, should return file offs=
ets 12M
>   # and 20M for the default subvolume (root 5) and file offsets 4M, 12M =
and 20M
>   # for the second snapshot root.

