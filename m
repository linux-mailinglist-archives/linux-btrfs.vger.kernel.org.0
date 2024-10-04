Return-Path: <linux-btrfs+bounces-8552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02E990189
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 12:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4AB71C21C92
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A67146D6F;
	Fri,  4 Oct 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="g22ulV2T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81488179BB
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038732; cv=none; b=l0MfSbxlATvKMLIASW+EUm8GHgrbN4G39f59v5naFmqutopgglBFMH2zb3m/8oz8c5RVVCw/SPdfZL6Ibhn/JRgFOlojdmfSjZ4GgwNc5u/fQDeSQ8MmrEDyf0f20EHsphS1aYdDrs9fY/IWGbWfRiY0MUWu9ykwxg0vS54FctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038732; c=relaxed/simple;
	bh=8hNtdjozXB6m6xFvZlrxmnyczYAJa3FtuGs1LBeHbo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbzI9SJmcgiWcv6ehC+Td6jqufzl7kTEDFAhZwoSkgDF2LqVlPssUv5+JV8j/gy1nPOPzkbVFk+neRueaZDzIZzW4Sk9/DHopJ0UHiQnB7JVU5PacEpMcruWwbjUob2YZomBkyR+ZXUv1cp9FsvLvfNmLkr6isCysO9XblWNPws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=g22ulV2T; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1728038684;
	bh=TCMkFk/32V/Bj8Be7JpgylHK1U7gJPigtqiQlqL9tso=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=g22ulV2TXiT6qTKdwkaUKwy3F0VTXwmuUtVr9/3GAw5B6lWVSKqd2PabdPPgL8WXy
	 LneBTkI6n+wR0hVxxJfY5vgOgMwL+ioAbWpkFz8v1KdH7veWPcYUngExMCjVlMOX4J
	 fAgy3pyxUMolb/EwtxQqtjL+YzZvwVndMoElaxYU=
X-QQ-mid: bizesmtpip2t1728038680td5jzq4
X-QQ-Originating-IP: 0nKyqLMQ08XhSENnDvb3wo4b8NXOx9iU+WbQoNltifI=
Received: from [IPV6:2408:8214:5910:1b0:1e39:e ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Oct 2024 18:44:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11026431254881787706
Message-ID: <FB5E0995611C933C+e5e8b5f1-cf92-402d-bcfa-7cea30339427@bupt.moe>
Date: Fri, 4 Oct 2024 18:44:38 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] raid1 balancing methods
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, waxhead@dirtcellar.net
References: <cover.1727368214.git.anand.jain@oracle.com>
Content-Language: en-US
From: Yuwei Han <hrx@bupt.moe>
In-Reply-To: <cover.1727368214.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Ml1iSfLyJEsHVu7wWD8b1OZ6u0gtTxkilGvPC5Vaf9114l2EMLzzlkdb
	mvvNVsIbb+i4f7q34E3wy/jRCk5P9YIc8k2e9MMJVPLkn4vEltXdeOQpUY+xQTIma9Pa76T
	PPLBMDae900mquxti7zMehii4BFgTgJEljPxqgXFekBLDEUkARuLLIi5dPQ1IUwGsypS77w
	Y49By0rOlH26ze+7TNGcQZviUQlUxP5t4IhnFuKtdwzoDj8ETMzHx3CHxInqAB2YdmhJKwS
	UZ7PK7cq+p9FBIQoll+4eMtKgZUoyGZxZZ9BLCI1RcPz7JKztWKECbAoMZC8u1KR/kd9zO8
	deCl1tIgkfwabdI+G3st99qf/wL/OWp9VHkCLJPknKyUEOSY7MWeW3/Na9VDYXs1gcr2bBx
	fuJKZ9yJ+MK+QKMmxxTgIxfQf/vXebU0mz3vDFI9XRf2vb2KsARKx6TcUXquUq33v7UcZdb
	PwFg9MOazb4kgpqLyS3f3vnAU4bm1DYiCocuAF+HNCgGhj5i7mdJVoTuHGyp/CWJVzONLdp
	quz+PfBoXK7Ef4r/O4e0AK1vQtoLK7QyJzopQQICHy4MwItQ0+q1NHDHtQIBm9JqcSM+jv3
	WG/Z7HscM/hHs3b75OGEPyT7KQ/AnSFkqq5n9mqK/57DGaqHwsNPvjkQ1rfMWjsupwLqtas
	rRCwOPJMtCiCq6q+CSkalbniKXD9qqs3Wib0C+QGa/i/hQGFbRkctDY09upTccFPv7i9Ycv
	vkQbs1PmMiASXZ0szzx1LFJ94z/PeruHn6POUbnz2K4SOHM/5yNmLV+HimGkwBlHTw+4wlj
	DTPDwe09j3jI+bkMimIKgJRTmThLc9OZL2+7k57m2qlZ/bp9LFh7+UGvJgOQaKgGNXWsE1o
	ziBRW0jtdteV0FvMspc9CJP3IOMu/xMpI30nnKMmxzREb+zwuKVNSw0CADdu4s4YhYI8EsU
	GSXU=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0


在 2024/9/27 17:55, Anand Jain 写道:
> The RAID1-balancing methods helps distribute read I/O across devices, and
> this patch introduces three balancing methods: rotation, latency, and
> devid. These methods are enabled under the `CONFIG_BTRFS_DEBUG` config
> option and are on top of the previously added
> `/sys/fs/btrfs/<UUID>/read_policy` interface to configure the desired
> RAID1 read balancing method.
I am currently testing this on 6.12-rc1 with policy rotation, seems good 
for now.
Would be better if policy can be set in mount options.

HAN Yuwei
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
> $ fio --filename=/btrfs/foo --size=10Gi --direct=1 --rw=randrw --bs=4k \
>    --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
>    --group_reporting --name=iops-test-job --eta-newline=1
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
> . The PID-based balancing method works well for the generic random rw fio
>    workload.
> . The rotation method is ideal when you want to keep both devices active,
>    and it boosts performance in sequential defragmentation scenarios.
> . The latency-based method work well when we have mixed device types or
>    when one device experiences intermittent I/O failures the latency
>    increases and it automatically picks the other device for further Read
>    IOs.
> . The devid method is a more hands-on approach, useful for diagnosing and
>    testing RAID1 mirror synchronizations.
> 
> Anand Jain (3):
>    btrfs: introduce RAID1 round-robin read balancing
>    btrfs: use the path with the lowest latency for RAID1 reads
>    btrfs: add RAID1 preferred read device feature
> 
>   fs/btrfs/sysfs.c   |  94 ++++++++++++++++++++++++++++++-------
>   fs/btrfs/volumes.c | 113 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |  14 ++++++
>   3 files changed, 205 insertions(+), 16 deletions(-)
> 


