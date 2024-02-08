Return-Path: <linux-btrfs+bounces-2240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC2184DD01
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8613BB25A5A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A16BB53;
	Thu,  8 Feb 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mcVi0zzg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A13171B4;
	Thu,  8 Feb 2024 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384753; cv=none; b=nU3YJHuQttNUAggcA/VKupCYWgJa4D7gcD9iAaSuCtuwbFbUTYfMEz+rKJz8+8FNUukjJUIynJlByKkKRI9uFyB+OaWW8Al7PKysrqpzAtAim1rKHRbxKD2wWuJpNQefn/BZBhqDysz0JbhO0Z0Ucup9bmNpYeCpYu12O5VV4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384753; c=relaxed/simple;
	bh=8uePzy/nMZYJRLzmZd0F1LhxfhdAQbzd6OP8BrVGdZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUkBqNCFxZYuvE94lAmMH4sYOmzZyJvVyCvghfdqyW5SkO8RF+ny4ln+9CXzyxpMUP8Lrmcadxlf1K+epHr774gGbZJ8ZZxPURcwkId0v9pMroIItA16TK9N6eOEoUzMftjmqUqLYKohIe3+1kX26Q1Jo53kYMgCsyRBh38lilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mcVi0zzg; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707384742; x=1707989542; i=quwenruo.btrfs@gmx.com;
	bh=8uePzy/nMZYJRLzmZd0F1LhxfhdAQbzd6OP8BrVGdZM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=mcVi0zzgz/RBXppskPeKmRPliiTWkVEPls0h3K4ftIiYV4nyhzA88CBZlalO9S2H
	 WpY7CFIs8zkRqoZ0HpVqvyJAEvFM1ufQmdqOIgDXjPLor4LY3s+Rx4ynx6N4KF9Eu
	 lMTMLngBaQHZr5ErWcFjaTmmyyHyIC9D6OBziP9pihAw9XoXWDnp6Ta37SI4fOz5P
	 0VJSGtlOHqrNTlhwwP6uMBsldkMC68twCD9bEmm8OBjCpdWThKYHjgIzP8HOPNAGG
	 1hGkVmzoHm5cGrdUj4U4JeP58HssApwuoiKAsvyJq1HrL9zuhIOivJ308w5pdiEc0
	 GKAy/2G+nx2lE21IUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwYu-1qiEUj05ym-00uMxF; Thu, 08
 Feb 2024 10:32:21 +0100
Message-ID: <50f685a8-3545-4a74-bc23-da6e49063678@gmx.com>
Date: Thu, 8 Feb 2024 20:02:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kdave-btrfs-devel:dev/fixinclude-to-send] [btrfs] a9e57fc34c:
 xfstests.btrfs.303.fail
To: kernel test robot <oliver.sang@intel.com>, Boris Burkov <boris@bur.io>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, David Sterba <dsterba@suse.com>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <202402081613.c4636ea9-oliver.sang@intel.com>
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
In-Reply-To: <202402081613.c4636ea9-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CeCurXhaJ3jFDwti9TPoKS8bgHUJJBzy2usxx9QPqVOjI/rCGzV
 YA6QdSrqhGn7+g0KsTGvIeo8W/9t74KXuoM8JcuhV8dDQLICppDTWo3gasnLguL4J7Lqetz
 9DVNtmPL7p+84SceACtlcbrOiVZYLpkLu3PVMeLTHgBWBOrMaPohS5Zf0q7bFfkLRLZ4o04
 qe30QpPxBoJtc8jepeAVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TyfdmrTUUNg=;DQ6ofjCtiogjLPC7gXrhJ+HLDk9
 wcCXTX7vNaDy9c9QV5ChEjRABy4U9yqo5HS9uVrQQZNMu5OJ6GDeI4W/wsUU8GI1zj2rDko3e
 oR8HsPcV3cS0nJ5NzWTwyr9nxDJ2h4f3o6otxjvwsarZKvE6BjDKGjYiGvtekJNjpWpsSC4AZ
 scNclMx4Eid9mDVQA186z99B4NeFTu9/fGH0d9EHywPuAjZjN4DlHqJWzx657gwz36olPlBi5
 iMj9mVQKreCIagb5JBtAAaNopk919u7zlU16cK9B4MwTGHsneVscN7ZBld6t9uFnrJkI2esfc
 UahUeUdu7ltpbqcE1KSuSiTj8PWhSFmY2MLB+EAvgKGPyAktI18EHi671McjtMUdaKPaVVrNs
 cR3ly11G/2TD/KgPPX9n+qH8a9741c7BNevqEXYgBqGKLS47NClo2VNMfg+FxLlpC6Aomd3Zl
 13LSV2y/PKro+Nrz+RS3ATVS49DsNVAH4lSq+kSn7pCPASzDC2Nl53nz0lCDSUeWtQ8ZC9itL
 g8G6ffuEQREIF9EMKrVL0liQuGBlhreFyb1e1cZt1rz3m/tAWCMGlUsZcngW04GCW4eCAqLAA
 TdkEpg8Zw0aHjsHrTO2A3tzsqUEgdO8c1HYJy5oBuCU7eoiGvdraFaJfpN5aRprDkYqqmW/Tw
 ppfwJKqj2TckpBOvf3R7S5DrDuUfjWg7ZNn7D9qkzsITZ347WsKuiIzJaKeYkgpr+19v2Q3dZ
 xzf62xQAkG8BvBNponTgsecQObFlujkR5WFU0tvcZqAOgvfVfSEOvXDZpkU/L/NnevKgMmf//
 hdb2YNlRKSxcZtkykSwaPQ8PhIeu6NftAjQgqPw/k+9XU=



On 2024/2/8 19:02, kernel test robot wrote:
>
>
> Hello,
>
> kernel test robot noticed "xfstests.btrfs.303.fail" on:

That's exactly why Boris deleted this test case, and we believe that's
the correct way to go:

https://lore.kernel.org/linux-btrfs/20240204071605.qt6famqusr7til43@dell-p=
er750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m6068ab539f705e2777614a9abca8c6=
33cf138b8e

Thanks,
Qu
>
> commit: a9e57fc34cc3c8a898d742086a94a0f66c683bee ("btrfs: forbid creatin=
g subvol qgroups")
> https://github.com/kdave/btrfs-devel.git dev/fixinclude-to-send
>
> in testcase: xfstests
> version: xfstests-x86_64-c46ca4d1-1_20240205
> with following parameters:
>
> 	disk: 6HDD
> 	fs: btrfs
> 	test: btrfs-group-30
>
>
>
> compiler: gcc-12
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GH=
z (Haswell) with 8G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202402081613.c4636ea9-oliver.sa=
ng@intel.com
>
> 2024-02-06 17:08:46 export TEST_DIR=3D/fs/sdb1
> 2024-02-06 17:08:46 export TEST_DEV=3D/dev/sdb1
> 2024-02-06 17:08:46 export FSTYP=3Dbtrfs
> 2024-02-06 17:08:46 export SCRATCH_MNT=3D/fs/scratch
> 2024-02-06 17:08:46 mkdir /fs/scratch -p
> 2024-02-06 17:08:46 export SCRATCH_DEV_POOL=3D"/dev/sdb2 /dev/sdb3 /dev/=
sdb4 /dev/sdb5 /dev/sdb6"
> 2024-02-06 17:08:46 sed "s:^:btrfs/:" //lkp/benchmarks/xfstests/tests/bt=
rfs-group-30
> 2024-02-06 17:08:46 ./check btrfs/300 btrfs/301 btrfs/302 btrfs/303 btrf=
s/304 btrfs/305 btrfs/306 btrfs/307 btrfs/308 btrfs/309
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.8.0-rc2-00014-ga9e57fc34cc3 =
#1 SMP PREEMPT_DYNAMIC Tue Feb  6 21:49:37 CST 2024
> MKFS_OPTIONS  -- /dev/sdb2
> MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch
>
> btrfs/300       [not run] unshare --keep-caps --map-auto --map-root-user=
: command not found, should be in util-linux
> btrfs/301       [not run] simple quotas not available
> btrfs/302        13s
> btrfs/303       - output mismatch (see /lkp/benchmarks/xfstests/results/=
/btrfs/303.out.bad)
>      --- tests/btrfs/303.out	2024-02-05 17:37:40.000000000 +0000
>      +++ /lkp/benchmarks/xfstests/results//btrfs/303.out.bad	2024-02-06 =
17:09:21.788971907 +0000
>      @@ -1,2 +1,3 @@
>       QA output created by 303
>      +ERROR: unable to create quota group: Invalid argument
>       Silence is golden
>      ...
>      (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/303.out /lkp/ben=
chmarks/xfstests/results//btrfs/303.out.bad'  to see the entire diff)
>
> ...
>
> Failures: btrfs/303
> Failed 1 of 10 tests
>
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240208/202402081613.c4636ea9-o=
liver.sang@intel.com
>
>
>

