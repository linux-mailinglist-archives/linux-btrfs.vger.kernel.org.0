Return-Path: <linux-btrfs+bounces-8844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F24F7999BEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 07:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74D71F218FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 05:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C7D1F1310;
	Fri, 11 Oct 2024 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BB9UnuO0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C21CB523
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 05:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728622818; cv=none; b=Ii2006UvdW3ID1aqQlBYqFOl4HGGB7wntJ42/hVadeGQnPuYNhR2rdDTeyRKyokdwnvspOy7Hx3o5DHu1P94WDEeDLh6u+bXcE3dmFJzDTvLbQLbFBb/qfdGDyE+9LPnQ3Wp59f5Zuz6w3ifTaWpku3nbZF3lqQTdRNAduz6TVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728622818; c=relaxed/simple;
	bh=EolAOdcgFk8aIhDktFX/L6I9xzUPHXWkhfXNXrrnL40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6JHm+YuKeZc23PSMQYpV32Z+2GR+3ovJXYuTOUok9EKf9BtkUCWBvkXz274qKLGVXIXoWBZvI8iG/4IrP1o/ZMERdH23uN/S3OXyYmCMKDOK1ScP6vQMPmIcMdepJme+/otFd9vHgbzQsiK3B4WNlI3V+SFileZlmhZY3mKbgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BB9UnuO0; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728622799; x=1729227599; i=quwenruo.btrfs@gmx.com;
	bh=mAT0TXK9q8wQNHTrJGBTVhrxJImWx64sAPzBgnFGbwY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BB9UnuO0/H5QMgD3m8ZBrV2VW92qg/MMnVpLrJINeGU3g5Rlk6kXjCd0pndGO6ii
	 2b5whxCObmodV8Owjt181OapcfRtpPxxOLu8rtrhb2Vn4xYYmddaj7b2yMIheee3M
	 2cDZ6SDFin+M7p73OqPtlPe9dd3Mvvmycq2sNslCIqjj0P0mlrpLuksrtwEP9MP+C
	 TS5qyz2idNVbrdREn9W+kpIYVKbYMzuNMkg5SrRhMb77e+TlFFXLKEiD+w7ouQIgo
	 cawBMquFQ6YmrAZI+5DlL/Orez2X/Ujfg47wo6xK/KxwG9bcjOLr+vIhZMWLprKX8
	 g4Ml/pMNTOMwrLMzmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVN6t-1tRUNd2yAR-00UqTV; Fri, 11
 Oct 2024 06:59:59 +0200
Message-ID: <92545054-d640-4b8f-8026-d3ecd04c1eee@gmx.com>
Date: Fri, 11 Oct 2024 15:29:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] raid1 balancing methods
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
References: <cover.1728608421.git.anand.jain@oracle.com>
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
In-Reply-To: <cover.1728608421.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vifGGvBJR7HhDpw8eliQrhurKkcjs/azOX7bwNdnHn6eK7t1FD9
 p0SrFOEMDEasTzln9Z/kbbfAFUBXGcw4FdltSB8mLJOqDOfFiki6jcvEWOOiVPIYRojSX2b
 KrecW4PXbwuw/wEa6+slGCgpn67PdAd3zK2kpoeOafX+GG0sq3Q4D4Vm9gwOqehuU22xGqR
 MXBd7vTmKucK8mlSRmcAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pI2wkDpxvjo=;mbO/+7FzSCWRcrECSigbADhPkd7
 6hzGmzGxSDRFyqGol/00XBfPvCG7uk8XuYLTqnXNFR6H/lVM3zQGzWcXLZhsQT/u+mdN3gxrL
 aaDwEhztZ8yAvhapUYyx8l5MpPF/ZkA6MbF0NeeryDARDqqWZHru1RgjrdToeIRGQkZO0tZ64
 zAw95elRJ2u55LkPPw0zrcyAviLv/W04Phh2YK1kpLQzWn+HNCVZl7dli7Wfeg62PM9HZsAqp
 BY2W5fUjCsGHRZTANXnQYy8zc3WKsUASlwZ3xbvgOaXcPYBYfRwbBPrm5QX2tgPZdOblFvvVZ
 StICnu6ISc4siwgNb6dovr1/S0OdGQZU7+Ze6qvtBrOy0yk1N4SSi4XuTt48jR2gs7bT9NtcD
 qxIayqHG6EvYsJ8b/pxjAJRqRVnBO3UkUn7PqsQ9dfShNrg2T0IH740uAof5We6qeiYgbNnFD
 BOf2q1g/T4aGi+I4Nm1V021fxycN/1fkFdrE8cNguT+VwY9Jhv/HKbfvZ6qUlKCFIsqRiVEw7
 0YVeqVtSRBeKradDH3UOAgAOV4JSzZ+ccP4rhvEwyjE4dIkME/ACm4GavBkNx2/SpGMRB8qw9
 fxZS4i4S2XCBXi9gIFKjEisNRP1XE8e2iNaZwwW7Ys4YZxN1u+5XAtwjEEqe7TkPuqh5jduBl
 KEOmiP13Kf+rrTlWq7vQ7AW9Czroi18cgCF+cYrSJUWJyjLh0Aq3j4s4HG6WskDExOcATzfEN
 WBPeGgIgeaINmVVd+7oYH4Nhk5Bdju07mXgeQK+X91hJrLctUbirJUHOZ/nF4Knj6LieBjjhE
 /FVo4/m+Zne2WxHEKvVeaGlg==



=E5=9C=A8 2024/10/11 13:19, Anand Jain =E5=86=99=E9=81=93:
> v2:
> 1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of CONFIG_BTRF=
S_DEBUG.
> 2. Correct the typo from %est_wait to %best_wait.
> 3. Initialize %best_wait to U64_MAX and remove the check for 0.
> 4. Implement rotation with a minimum contiguous read threshold before
>     switching to the next stripe. Configure this, using:
>
>          echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read=
_policy
>
>     The default value is the sector size, and the min_contiguous_read
>     value must be a multiple of the sector size.

Overall, I'm fine with the latency and preferred device policies.

Meanwhile I'd prefer the previous version of round-robin, without the
min_contiguous_read.

That looks a little overkilled, and I think we should keep the policy as
simple as possible for now.

Mind to share why the min_contiguous_read is introduced in this update?

In the future, we should go the same method as sched_ext, by pushing the
complex policies to eBPF programs.


Another future improvement is the interface, I'm fine with the sysfs
knob for an experimental feature.

But from my last drop_subtree_threshold experience, sysfs is not going
to be a user-friendly interface. It really relies on some user space
daemon to set.

I'd prefer something more persistent, like some XATTR but inside root
tree, and go with prop interfaces.
But that can all be done in the future.

Thanks,
Qu
>
> 5. Tested FIO random read/write and defrag compression workloads with
>     min_contiguous_read set to sector size, 192k, and 256k.
>
>     RAID1 balancing method rotation is better for multi-process workload=
s
>     such as fio and also single-process workload such as defragmentation=
.
>
>       $ fio --filename=3D/btrfs/foo --size=3D5Gi --direct=3D1 --rw=3Dran=
drw --bs=3D4k \
>          --ioengine=3Dlibaio --iodepth=3D256 --runtime=3D120 --numjobs=
=3D4 \
>          --time_based --group_reporting --name=3Diops-test-job --eta-new=
line=3D1
>
>
> |         |            |            | Read I/O count  |
> |         | Read       | Write      | devid1 | devid2 |
> |---------|------------|------------|--------|--------|
> | pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
> | rotation|            |            |        |        |
> |     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
> |   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
> |   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
> |  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
> | devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |
>
>     rotation RAID1 balancing technique performs more than 2x better for
>     single-process defrag.
>
>        $ time -p btrfs filesystem defrag -r -f -c /btrfs
>
>
> |         | Time  | Read I/O Count  |
> |         | Real  | devid1 | devid2 |
> |---------|-------|--------|--------|
> | pid     | 18.00s| 3800   | 0      |
> | rotation|       |        |        |
> |     4096|  8.95s| 1900   | 1901   |
> |   196608|  8.50s| 1881   | 1919   |
> |   262144|  8.80s| 1881   | 1919   |
> | latency | 17.18s| 3800   | 0      |
> | devid:2 | 17.48s| 0      | 3800   |
>
> Rotation keeps all devices active, and for now, the Rotation RAID1
> balancing method is preferable as default. More workload testing is
> needed while the code is EXPERIMENTAL.
> While Latency is better during the failing/unstable block layer transpor=
t.
> As of now these two techniques, are needed to be further independently
> tested with different worloads, and in the long term we should be merge
> these technique to a unified heuristic.
>
> Rotation keeps all devices active, and for now, the Rotation RAID1
> balancing method should be the default. More workload testing is needed
> while the code is EXPERIMENTAL.
>
> Latency is smarter with unstable block layer transport.
>
> Both techniques need independent testing across workloads, with the goal=
 of
> eventually merging them into a unified approach? for the long term.
>
> Devid is a hands-on approach, provides manual or user-space script contr=
ol.
>
> These RAID1 balancing methods are tunable via the sysfs knob.
> The mount -o option and btrfs properties are under consideration.
>
> Thx.
>
> --------- original v1 ------------
>
> The RAID1-balancing methods helps distribute read I/O across devices, an=
d
> this patch introduces three balancing methods: rotation, latency, and
> devid. These methods are enabled under the `CONFIG_BTRFS_DEBUG` config
> option and are on top of the previously added
> `/sys/fs/btrfs/<UUID>/read_policy` interface to configure the desired
> RAID1 read balancing method.
>
> I've tested these patches using fio and filesystem defragmentation
> workloads on a two-device RAID1 setup (with both data and metadata
> mirrored across identical devices). I tracked device read counts by
> extracting stats from `/sys/devices/<..>/stat` for each device. Below is
> a summary of the results, with each result the average of three
> iterations.
>
> A typical generic random rw workload:
>
> $ fio --filename=3D/btrfs/foo --size=3D10Gi --direct=3D1 --rw=3Drandrw -=
-bs=3D4k \
>    --ioengine=3Dlibaio --iodepth=3D256 --runtime=3D120 --numjobs=3D4 --t=
ime_based \
>    --group_reporting --name=3Diops-test-job --eta-newline=3D1
>
> |         |            |            | Read I/O count  |
> |         | Read       | Write      | devid1 | devid2 |
> |---------|------------|------------|--------|--------|
> | pid     | 29.4MiB/s  | 29.5MiB/s  | 456548 | 447975 |
> | rotation| 29.3MiB/s  | 29.3MiB/s  | 450105 | 450055 |
> | latency | 21.9MiB/s  | 21.9MiB/s  | 672387 | 0      |
> | devid:1 | 22.0MiB/s  | 22.0MiB/s  | 674788 | 0      |
>
> Defragmentation with compression workload:
>
> $ xfs_io -f -d -c 'pwrite -S 0xab 0 1G' /btrfs/foo
> $ sync
> $ echo 3 > /proc/sys/vm/drop_caches
> $ btrfs filesystem defrag -f -c /btrfs/foo
>
> |         | Time  | Read I/O Count  |
> |         | Real  | devid1 | devid2 |
> |---------|-------|--------|--------|
> | pid     | 21.61s| 3810   | 0      |
> | rotation| 11.55s| 1905   | 1905   |
> | latency | 20.99s| 0      | 3810   |
> | devid:2 | 21.41s| 0      | 3810   |
>
> . The PID-based balancing method works well for the generic random rw fi=
o
>    workload.
> . The rotation method is ideal when you want to keep both devices active=
,
>    and it boosts performance in sequential defragmentation scenarios.
> . The latency-based method work well when we have mixed device types or
>    when one device experiences intermittent I/O failures the latency
>    increases and it automatically picks the other device for further Rea=
d
>    IOs.
> . The devid method is a more hands-on approach, useful for diagnosing an=
d
>    testing RAID1 mirror synchronizations.
>
> Anand Jain (3):
>    btrfs: introduce RAID1 round-robin read balancing
>    btrfs: use the path with the lowest latency for RAID1 reads
>    btrfs: add RAID1 preferred read device
>
>   fs/btrfs/disk-io.c |   4 ++
>   fs/btrfs/sysfs.c   | 116 +++++++++++++++++++++++++++++++++++++++------
>   fs/btrfs/volumes.c | 109 ++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |  16 +++++++
>   4 files changed, 230 insertions(+), 15 deletions(-)
>


