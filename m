Return-Path: <linux-btrfs+bounces-12048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F6BA5475D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 11:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8AF188ECE2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119D51FDA84;
	Thu,  6 Mar 2025 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ftdea5MR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3519DF49
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255801; cv=none; b=dgmOvznncdBvLG2mGcL5A3Syu9t/9PVMczNf7yuSbWhaU14mx81FQbNaqKrgQuF4xKNqJqCzUE32P7xFqawwtxI0ql9s6Cxvf4LR35iwKlluBtg7Q7eFtmRS07BDDWz6cyrQ6tPP/IMJ9cvk2Lh8tOSYgVTZObGni125VHVDRUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255801; c=relaxed/simple;
	bh=WZUHTMifkJRZzCaLRXmytcArruiX67d7XY+WvxE5UGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dxBfgcxtrrt3MLaQv15eqbifX95Moi6cX31bz8NYJXygdQXua/y12n0cPr9gdB8kD6pHNzYvbsE4VkGscnWMMUAWxyAhuKlimJHWmuJcSC+LInTPqvL53FguPzfle398t2cpIafh1FkP7jRGKVklp2VWAKk/lmWHexlyY8tSaOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ftdea5MR; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741255791; x=1741860591; i=quwenruo.btrfs@gmx.com;
	bh=NnK98g/4L3k29gxWPsE7VmYU6wfzJydiAJXXACXY+Js=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ftdea5MRHiGssrTZH2uktx059X/zQ5gx/cvkQk2Wm9yztvLZquUqHjQfc1ZUjPUe
	 mc9PHA8WHbZ88+0kIU78BSxJchiAUSb5cKBzDlSptYZmGKfs9V8jp55lqssEWU4J/
	 oQmJLz1i5pR/mP/2QkQoYxtLIG3uVK/WruC7wNO/ZDmJTVlZWtv07zG0F+CpJLmhk
	 d7+LxcXUWJIzZ9SJL6aIQQPU5WtEf1aiVD+rb2wungi4TuuBTVP1qRH23NkcdRiwe
	 91Oyl2xKTlxw/S1XMZv+q6xqebT34pN4gXhr1mbmQaX0x4cmR9Tg82rvyKFT0L0XT
	 nOisT2A+5geySGE3kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mo6qv-1tSJ0O0TcJ-00iS4V; Thu, 06
 Mar 2025 11:09:51 +0100
Message-ID: <35989618-457a-47a6-acf6-7175d86eec08@gmx.com>
Date: Thu, 6 Mar 2025 20:39:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] btrfs: fix unexpected delayed iputs at umount time
 and cleanups
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1741196484.git.fdmanana@suse.com>
 <cover.1741198394.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1741198394.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FVZj4G+WLK3EXznIGxaJuBLjgQ3BB2tqCJOT8FPqwMRgD31pK4t
 PcFLft9sX0uBZ3J+4BzyhVY1O3feAtAUu5x9Ufj2wBPbrxnHVmWUd1/AoevKbgyjShpdfBg
 gcFDi6QT8hlf7d2DsJ02UCkYNmkGxqGckUMLN1zRCgsAtyOHQY0UoKk3HgFW2HCC9iKUAyK
 KbGSI5Y7gX+IFv6aIM1gg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MDbqRaaLYyE=;e+G6+szSMoju45fy7Xeesp1wxM1
 Soj8iXg5pxX/rDaB0MhjmP8goM/1DqKo11njmMYqEQX+3MNbWwkq+17pWTGl855ENnDI8ewgJ
 0Usb1w/KxsxZ0uXGQbcWCYhPxJ05xFCECYSgvI/PlN388KQc2LYc7Z30iwP2UK5H6PuifctgN
 9128DzsHG8I+apOv4RZ5m1jXBJDKRR27d8hkL0eFxY3K+x6ne3slrsMgfwygBTA4SSnO5Bjy8
 K5FOiT9oc3z64nq/k88Cg914R/lOS4zkR3nCRfJlZfMP0a+tu9sKUIncO+vdqTJUnBfokNAhz
 9+R3BHiFDNibz+TsZhYweElZGNS2C0iSdLzzU/bALwokDnQ0bhsV9NiSCqxgl0+zYKt27l+TH
 SQEJ0kKR7X+HlhrEby/PL7nQXENT4N645WzC7mDgH9fIvCFr9eEgEkgDogCrpdZOagNK/LnLl
 0/9x35i5JcLvxCTsTqxgyQ7nOyqjZeYQ8qi4bR4/T/lzwE/gT478BKyfDo7Yv1YCCVz3uHSaB
 X/noZyt37yQ17W/7kSJQcfWrQw8W17wepNoWBriNJttMsygGKNVlXXUboKHx4wtFYc58UxsGF
 PtmFTpzJKFebstHLU34UtI78YcizmWiQXJ2VCuy6MWp4AEQdI0xscfzg1uuUd1tmCcUB+Bwyv
 yUmuL3aIIbPYh09gDy3uDXRLASPTUUGeNel+k5aPOQwdTdLc37L9NpYMjiwSnA9PLTvGU6OH1
 RfaTgGEV4g9kXw8/DN87IDgx1/AKIREA6zzH+sb50WOLFzs4hFciZN2OCqA/8ZoMRWATjIeD2
 u/p4ryv8vHR+RHP1FNdFVOLCJT79f97oe4zA8QWJG247y9w19vzIvZF1MHlWIMBPqIFwryj8S
 /uigls427CVNhb0gLQb+DLnNGIlOKHf8BacFoohmdQUDcJFOJyIPv0Ipj1PWm1+xSu6n4xeDk
 QmUjauJ6Ri3TxbBN+aYEbNF7Uok/OVscS9Dy9S8OtLMaPge6wyB9btZjttmKFQfC8zV03/VnQ
 Fba6Gmxf8HV8WTHcPHIjpEbyTRKvEF5w+a82f3PNr6y44rLy4K2o2V9GB/rJZG8Er4mHsYEo0
 Xq9OMXRPhL7aLjWrCHsnCoNaWz42vJw/Ued7EAt8+EOR8sFPffaKz7EpTEpu9lwG5q7z6/X9/
 6MTbn/ypBd+YuP/5RfNIsUSTUMPvZmyotk9alj+GWus5EpTyyq2dIJ6i8xsDBV6cDdIQ5mpZ6
 Uun9vlIB1HwYLhsi1Gvtnf9BzPxr81vsuAIYtjLgNpn46tRa/1DTuLF5R/C6kmiLXdKAYqY6q
 pgyKJW7vh2rhnaLfTl1qOxOkUBLOMeJmh2B8Q1aFBiBwIlT01I+67dyHjRW1XajUE34VbLOzN
 5F/LU1Mw6lFVf1QjCEbiBlwn6tBvWYObtxl7begdxdHbtY3AtRXWlEpucg



=E5=9C=A8 2025/3/6 04:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Fix a couple races that can result in adding delayed iputs during umount=
 after
> we no longer expect to find any, triggering an assertion failure. Plus a=
 couple
> cleanups. Details in the change logs.
>
> V2: Removed the NULL checks for the workqueues in patches 1 and 2, as th=
ey
>      can never be NULL while at close_ctree() (they can only be NULL in =
error
>      paths from open_ctree()).

BTW, even with this series applied, I can still trigger the delayed iput
ASSERT():

[ 5364.406135] BTRFS warning (device dm-10 state EA): direct IO failed
ino 259 op 0x0 offset 0x14800 len 18432 err no 10
[ 5364.406327] BTRFS warning (device dm-10 state EA): direct IO failed
ino 301 op 0x0 offset 0x112000 len 12288 err no 10
[ 5364.406443] BTRFS warning (device dm-10 state EA): direct IO failed
ino 284 op 0x0 offset 0x129000 len 40960 err no 10
[ 5364.408115] BTRFS warning (device dm-10 state EA): direct IO failed
ino 333 op 0x0 offset 0x43000 len 2048 err no 10
[ 5364.408350] BTRFS warning (device dm-10 state EA): direct IO failed
ino 7914 op 0x0 offset 0x34a000 len 43008 err no 10
[ 5364.636270] BTRFS info (device dm-10 state EA): last unmount of
filesystem 9c4c225e-d4c6-43d0-b8c9-4b3afb5cb3cc
[ 5364.639881] assertion failed: list_empty(&fs_info->delayed_iputs), in
fs/btrfs/disk-io.c:4419
[ 5364.641814] ------------[ cut here ]------------
[ 5364.642733] kernel BUG at fs/btrfs/disk-io.c:4419!
[ 5364.643712] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 5364.644880] CPU: 5 UID: 0 PID: 2672520 Comm: umount Tainted: G
W          6.14.0-rc5-custom+ #224
[ 5364.646787] Tainted: [W]=3DWARN

I have hit this at least twice, on x86_64 with the new experimental 2K
block size.

And this is the latest for-next, which does not have the uncached IO
patch at all.

Since I do not have compression enable for the mount options, I believe
there is some extra causes.

Thanks,
Qu

>
> Filipe Manana (4):
>    btrfs: fix non-empty delayed iputs list on unmount due to endio worke=
rs
>    btrfs: fix non-empty delayed iputs list on unmount due to compressed =
write workers
>    btrfs: move __btrfs_bio_end_io() code into its single caller
>    btrfs: move btrfs_cleanup_bio() code into its single caller
>
>   fs/btrfs/bio.c     | 36 ++++++++++++++----------------------
>   fs/btrfs/disk-io.c | 21 +++++++++++++++++++++
>   2 files changed, 35 insertions(+), 22 deletions(-)
>


