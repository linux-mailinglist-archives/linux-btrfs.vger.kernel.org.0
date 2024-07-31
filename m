Return-Path: <linux-btrfs+bounces-6938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951F943968
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 01:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BC21C21B58
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 23:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2842A16D9C4;
	Wed, 31 Jul 2024 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="b4I8E768"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A51BC4E;
	Wed, 31 Jul 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722468641; cv=none; b=qks2R5zO0tLrIXQpwTOISVPbtTifrz3KD/rgFZOMYwvKjCf4AxGycmG1TVgTeT1dIqQNFP5lKrSYfEK6Buig5c3X556YWkQ3LS3SqXWO42ZWt6Gq/HPpNKVvFfXHD0y7Mr4vmlDSD5RI4gB2NlZes7HLsIcotfNvWoGIXOpf+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722468641; c=relaxed/simple;
	bh=v3TEAXNudixVfadw8/RzsMdx7CPFg+Ui/giunLwfECY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTUtozH73a8icnakJCiFb+CpR+ypX2nFD92EywuTLJ7BAmgdvdA2NYZeRfNrg6aXp7Dxi5MhMVZ889q9BD1/Z58qBziDZxINW7CZQt6o5uN4h7KdzMxrD6o0HCsnv0ovVDy05bnGh6JriDY1r3/mFlsRTMtkMQhWiJ0l72Fnfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=b4I8E768; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722468632; x=1723073432; i=quwenruo.btrfs@gmx.com;
	bh=JT2uQ+q1/4Ln70dhQtS54ChfvLXFFrtXShm3ivriJ8A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b4I8E7680coQjwrB35IINzHXm+EyhqjCwl8czO9QV8N79McJWcT7uBKcKbcPMx25
	 QmRbcOyLhenDBGCXN4t/syeWLYSFsBKQhcBTczsuChMlFchIghqBRlw6t4ECPRhoP
	 nVHPi81u8Yf5SiwHH2ma0AgnwIRLRz5cwQeREOBT8O0dYXqQHE0MYZMyXNTwwmH/y
	 DxAH7pL//HTC3wvsQKKONliZdW8LJLIjddkDnLKObBDHovWj002otjKPp+k+7o89s
	 875aJpUQDl34h/6I1lp2UWsGuH15UaXP1zCLyoGKjs2pp94Rq7Qmt6k8h5/bnbAzO
	 qvAmoW4FmmLO5+kfYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Ma20k-1snaXT1ZSe-00PBW4; Thu, 01
 Aug 2024 01:30:31 +0200
Message-ID: <b0876bf8-08ae-4b34-82bb-5f044a135f5b@gmx.com>
Date: Thu, 1 Aug 2024 09:00:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: remove unnecessary stdout/stderr redirection for
 run_check calls
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <742c2d98a000e324106a9f5bd3498f2985bb2706.1722441541.git.fdmanana@suse.com>
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
In-Reply-To: <742c2d98a000e324106a9f5bd3498f2985bb2706.1722441541.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:In0AOQH4+ScM2Es9I+Q4qVy3D/ratqyfa0net/SvnyBNkmNeuNe
 Ksrefau2gIJbcbZe1Yb/kGCfgk7NsAEFBYeOopOdxydYcBNhu6SBWxa5Z+RLCQgqRqzk8Ej
 5MN3BEWLhvUtYfo+/4Z7K9pLd2483JFEXZfyxz7LfA+7uGXFlEon4T9avt1jLLNPMrD/8VD
 EodbX0mAn4QcVUqfneOFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rLmG4H7OpHI=;E8Mn5WR9cb66Stgb9zuakmtvKBs
 noWote+vNxHxRXu7Ii1atkVyrMLcSjQBQoSWbCxnG6FOPxdcn5dfyvlPeUq76kMDw3vg0Jb8a
 TYcQHc/7w/h9ZjvH6i+4oStHGYB95MhYOCq0DY6+xPManIpG5ZBBwJHU1mERsQLAeZA8vxbLO
 30YnUXd4J/OEUHisdVi5V4aNnl3OgkP15ebz6YQXXQPOq6Ks80kBQLXmkGU5ApkcSTk+R2IIz
 o/af5UBFQDmyvehy+n/LDpIPh78sXmvuptpGOEfYdcdrO5mK/YDaKKvWlXU8AEWW2X+w/AgYE
 Ak9ZOGfEPd35Ccw/6KP/OQRs1CMbkyD+vf80ilcWu4DbFvBbkdVJCu4YNax+Bwrj9xBHh33DY
 lXHq5Ud4x+rnPM0sRlEMvLyc2bVU+Uwvwgfn/l+QzsYtRn8GiMQF4IN0plz8Jq1qcjUXwga36
 Plna+ZV1UPpGFiTwoqEFGcRxt70wHxneYvkoSHKSlIPTcNLonYp7sbQFQd/Zrhpi6ABfkO6Mr
 +L2/etwbomAKx1TKaoXaxcgJ10faq/HkRZud2f+f1LKX0vCKbgjs0K0YqN1eMonfhgn1tWVYv
 tQFLAZ1FsJSwVo85CKM4VQWApPRQMxFUOl3YHTfEv5B9q9bi88BhkWvmWjaybeooUQjC9kWHW
 NHfXihd2QhiYzl4JUiBR9c4tmBGE6N5d1sVxiK0v5F40sVHB5+guZ5zSZOZX+gco8HeXpKFRl
 O4R4lFBH3OBBQzonw8kHTmifT3+4He43MFzMqSpEK+PizYTYWM0oYBVTuJuaKYgjLLRrQlYkT
 j2U0FpSoHpb5RcnC/A16NvyA==



=E5=9C=A8 2024/8/1 01:29, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> It's pointless, and confusing, to have calls to run_check redirect the
> stdout and/or stderr, because run_check already redirects it:
>
>     $ cat common/rc
>     (...)
>     run_check()
>     {
>         echo "# $@" >> $seqres.full 2>&1
>         "$@" >> $seqres.full 2>&1 || _fail "failed: '$@'"
>     }
>     (...)
>
> So remove those redirections.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/004   | 4 ++--
>   tests/btrfs/030   | 4 ++--
>   tests/btrfs/038   | 6 +++---
>   tests/btrfs/039   | 4 ++--
>   tests/btrfs/040   | 4 ++--
>   tests/btrfs/057   | 6 ++----
>   tests/btrfs/284   | 2 +-
>   tests/generic/482 | 2 +-
>   8 files changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/tests/btrfs/004 b/tests/btrfs/004
> index e89697d2..5a2ce993 100755
> --- a/tests/btrfs/004
> +++ b/tests/btrfs/004
> @@ -165,7 +165,7 @@ workout()
>   	_btrfs subvolume snapshot $SCRATCH_MNT \
>   		$SCRATCH_MNT/$snap_name
>
> -	run_check _scratch_unmount >/dev/null 2>&1
> +	run_check _scratch_unmount
>   	_scratch_mount "-o compress=3Dlzo"
>
>   	# make some noise but ensure we're not touching existing data
> @@ -179,7 +179,7 @@ workout()
>   	# now make more files to get a higher tree
>   	run_check $FSSTRESS_PROG -d $clean_dir -w -p $procs -n 2000 \
>   		$FSSTRESS_AVOID
> -	run_check _scratch_unmount >/dev/null 2>&1
> +	run_check _scratch_unmount
>   	_scratch_mount "-o atime"
>
>   	if [ $do_bg_noise -ne 0 ]; then
> diff --git a/tests/btrfs/030 b/tests/btrfs/030
> index bedbb728..0c84000a 100755
> --- a/tests/btrfs/030
> +++ b/tests/btrfs/030
> @@ -150,10 +150,10 @@ _scratch_mkfs >/dev/null 2>&1
>   _scratch_mount
>
>   _btrfs receive -f $tmp/1.snap $SCRATCH_MNT
> -run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.=
full
> +run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
>
>   _btrfs receive -f $tmp/2.snap $SCRATCH_MNT
> -run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.=
full
> +run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
>
>   _scratch_unmount
>   _check_btrfs_filesystem $SCRATCH_DEV
> diff --git a/tests/btrfs/038 b/tests/btrfs/038
> index bdef4f41..1e6defa9 100755
> --- a/tests/btrfs/038
> +++ b/tests/btrfs/038
> @@ -76,13 +76,13 @@ _scratch_mkfs >/dev/null 2>&1
>   _scratch_mount
>
>   _btrfs receive -f $tmp/1.snap $SCRATCH_MNT
> -run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.=
full
> +run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
>
>   _btrfs receive -f $tmp/clones.snap $SCRATCH_MNT
> -run_check $FSSUM_PROG -r $tmp/clones.fssum $SCRATCH_MNT/clones_snap 2>>=
 $seqres.full
> +run_check $FSSUM_PROG -r $tmp/clones.fssum $SCRATCH_MNT/clones_snap
>
>   _btrfs receive -f $tmp/2.snap $SCRATCH_MNT
> -run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.=
full
> +run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
>
>   _scratch_unmount
>   _check_btrfs_filesystem $SCRATCH_DEV
> diff --git a/tests/btrfs/039 b/tests/btrfs/039
> index e7cea325..2306ffe0 100755
> --- a/tests/btrfs/039
> +++ b/tests/btrfs/039
> @@ -91,10 +91,10 @@ _scratch_mkfs >/dev/null 2>&1
>   _scratch_mount
>
>   _btrfs receive -f $tmp/1.snap $SCRATCH_MNT
> -run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.=
full
> +run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
>
>   _btrfs receive -f $tmp/2.snap $SCRATCH_MNT
> -run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.=
full
> +run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
>
>   _scratch_unmount
>   _check_btrfs_filesystem $SCRATCH_DEV
> diff --git a/tests/btrfs/040 b/tests/btrfs/040
> index 5d346be3..4fc4db44 100755
> --- a/tests/btrfs/040
> +++ b/tests/btrfs/040
> @@ -84,10 +84,10 @@ _scratch_mkfs >/dev/null 2>&1
>   _scratch_mount
>
>   _btrfs receive -f $tmp/1.snap $SCRATCH_MNT
> -run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.=
full
> +run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
>
>   _btrfs receive -f $tmp/2.snap $SCRATCH_MNT
> -run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.=
full
> +run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
>
>   _scratch_unmount
>   _check_btrfs_filesystem $SCRATCH_DEV
> diff --git a/tests/btrfs/057 b/tests/btrfs/057
> index 07e60557..6c399946 100755
> --- a/tests/btrfs/057
> +++ b/tests/btrfs/057
> @@ -19,14 +19,12 @@ _scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqr=
es.full 2>&1
>   _scratch_mount
>
>   # -w ensures that the only ops are ones which cause write I/O
> -run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p 5 -n 1000 \
> -		$FSSTRESS_AVOID >&/dev/null
> +run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p 5 -n 1000 $FSSTRESS_AVOI=
D
>
>   _btrfs subvolume snapshot $SCRATCH_MNT \
>   	$SCRATCH_MNT/snap1
>
> -run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w -p 5 -n 1000 \
> -       $FSSTRESS_AVOID >&/dev/null
> +run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w -p 5 -n 1000 $FSSTRES=
S_AVOID
>
>   _btrfs quota enable $SCRATCH_MNT
>   _btrfs quota rescan -w $SCRATCH_MNT
> diff --git a/tests/btrfs/284 b/tests/btrfs/284
> index 19ffbbe6..6c554f32 100755
> --- a/tests/btrfs/284
> +++ b/tests/btrfs/284
> @@ -50,7 +50,7 @@ run_send_test()
>   	# Use a single process so that in case of failure it's easier to
>   	# reproduce by using the same seed (logged in $seqres.full).
>   	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -p 1 -n $((LOAD_FACTOR * 200=
)) \
> -		  -w $FSSTRESS_AVOID -x "$snapshot_cmd" >> $seqres.full
> +		  -w $FSSTRESS_AVOID -x "$snapshot_cmd"
>
>   	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap=
2 \
>   			 >> $seqres.full
> diff --git a/tests/generic/482 b/tests/generic/482
> index 04026c4c..54fee07d 100755
> --- a/tests/generic/482
> +++ b/tests/generic/482
> @@ -77,7 +77,7 @@ _log_writes_mkfs >> $seqres.full 2>&1
>   _log_writes_mark mkfs
>
>   _log_writes_mount
> -run_check $FSSTRESS_PROG $fsstress_args > /dev/null 2>&1
> +run_check $FSSTRESS_PROG $fsstress_args
>   _log_writes_unmount
>
>   _log_writes_remove

