Return-Path: <linux-btrfs+bounces-9119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49919ADAFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 06:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086DD1C20FBF
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 04:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C816DEA2;
	Thu, 24 Oct 2024 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Z01KGdja"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366116130C
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744790; cv=none; b=tiw647LK1rw6IueNuPmPwBjSugKuJTBQFG/SALlTcrxj74l+PhSEQAM6n/eVd1n5JjISNqlYuhMWSvMy1pJ/XzjE9evKW6pRkjsTDIGGV/nXixQ84xa1skqVfQbCIY6cfpFROwd4iLwY+vlPAAJH2cASzG8Vj4Gd7UtuCtuUc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744790; c=relaxed/simple;
	bh=W/4dMQ/N14dzTK355zht4+nY0TcHm1JiB262jv4+Ocs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcDa1OIihJ3XcNQLZjNm4IlQn2OiRQKg3vVhHr7BIpv+gszBiViPgrFwMIF0dLJ6TZEowWLWNbvULtE/N/ip10aAi4YWL66M3faQrluCU8iO+LxtE9l7+GferSij+BCJgBdy3N2syQVN3Bln3nFzy4Gl2PiSPZhnGGCitoLND9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Z01KGdja; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729744772; x=1730349572; i=quwenruo.btrfs@gmx.com;
	bh=zm18A+sZ5S+Vz4TMRtWOxZ0jJebC0zqypeXoQFdCFWY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z01KGdjaq3u44s5iTesJL+RC8PIXCRLDNh3WWXH1b8lgJSd/pfa2AO0cQbdNTbLN
	 zOA9Of0rNynZRFGpAMNY8YGxFlp+7aKgVFUQfx37YD5D1fB4H7xDGIq5u+MNhrcfZ
	 w0bgo8Pf5Axznx0QbmB5jEn41NsCbhnCc+og8bt9qFKrk7erzl3ot+PUPX0nyIdCt
	 OTJjKfEKLLpY1hT42kb1x1q3r6IU19dwCd6f9jdGp0Qg0yKHTjK/O3Z9sfaOTucxX
	 xf/3Z0W5Emcn0gQVio8BWyXo17TjTBCazCTmC+r1zGchuAyq1u5zgZyIvU4IEEuC7
	 Kd9e5PF9/FFCxgv4EQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMXUN-1tMjIK3e7D-00RcYn; Thu, 24
 Oct 2024 06:39:32 +0200
Message-ID: <4ac82503-83db-4ac1-a14d-7195a1a4d880@gmx.com>
Date: Thu, 24 Oct 2024 15:09:27 +1030
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
In-Reply-To: <cover.1728608421.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K9ii/NHN8Kiwh0drwKa2/3HHZEfn31q95UfeI0eb1EIdcu5tzBd
 s5vpkoMx1CLpVMo1QCGMdH+25dyE03/bXi28o2pyF+OgfrXZgDrNtg6zWVmS0dLWX6vHy33
 big6M23e3tDognXg3KNiDLNbBGTcDGSeVk+GI3lpJ7HewTM6fs+PaHVlxmssuOicH5zoVMH
 HcrCaUZ0383C8kRdq6q5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S27pmGqZ2vg=;lG+M1pn2etHjPpiQaUCtNYSBr5v
 m7ubVMVZXKj1KUpwI9h+IdneVFCEPXmrWGmq6H2eE3myto5x2OOaUU6W3rjlJ+2j6/32AFe56
 TfjPLXIQx3mbzJTbVW5AABnYnBEWSb14m9j8UDfwB9FwhtldS2Uz1jaJLjC/GwKgsiJ+P50h8
 qRVPq8eFxgRNH650sn5SUdrT7LNAH/aUG+B+ZgUGWMEXtunhs7OHb2mJnDsSmUaW65CP1KkOw
 9Vvy30Tzz3V/klgRrZsCjqZ+AYBUgaGLcYIfvZCAGRrUFMZptRoA/8p0k2p7CJk/FPOGEY9dv
 dDS/26iJvQsnLYu4QYeclkM3i3gtVI0X/0pnMABKsxGHMDzrUIHDSk9tHG3uabq8SlGPfT7Wv
 uecy+zbkwy0CAsQaMytMMXv2YvguHsXiTq2kV/IbRqkZvvPRIqV2Uz4JJTYSPtze5M1Q4aVrP
 T1cyQ0uOkWWzEycveZehaPABEg9nHyK1E6Nq+KjC0r+5LLIDDgL0ksL9VU75V5TivEwcZbvV1
 N6HBXeR3lluhzxKfS2Yr+MnspETgLoT3JQPRotyATXyRrq21WjdnPhJA7CxMLyXnZGDeMG40d
 INfWZtVDz8CX+F3zISjseI8NZwIofo/tPAECUfFwp6xwfW3/5vKZR7ZUpBiu+7weIEQ4mXNNs
 Q369FYf/LgAUe6VQWF0aJfvheM0sEazplR2wdUdVY3uDwiCJTJUk2ipelhmh1zhJgnc6PIRua
 DyYCQhJxcaelmKVwVS+oTHAZguvx+8qMJyCdDkjhOL5RsUB6WG5zE2j5rHxrJLxSWyl2FIczT
 Rac9S2pGb8/v2qr8mfnKSAfA==



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

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although not 100% happy with the min_contiguous_read setting, since it's
an optional one and still experimental, I'm fine with series so far.


Just want to express my concern about going mount option.

I know sysfs is not a good way to setup a lot of features, but mount
option is way too committed to me, even under experimental features.

But I also understand without mount option it can be pretty hard to
setup the read policy for fstests runs.

So I'd prefer to have some on-disk solution (XATTR or temporary items)
to save the read policy.
It's less committed compared to mount option (aka, much easier to revert
the change with breaking any compatibility), and can help for future
features.

Thanks,
Qu
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


