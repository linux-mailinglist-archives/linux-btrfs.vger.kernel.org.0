Return-Path: <linux-btrfs+bounces-2608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187B985D93A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 14:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02CB2845E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A166278B68;
	Wed, 21 Feb 2024 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b="GpiJG5pQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7977A03
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521352; cv=none; b=ruB2bOyaxISZcLoDlLESZnganNzY3JWHQpIbwRQOwmeMBz4XtqN9oiFhdYukbdHYskuDwJkfQbZaLRpaqwDxcqJeuuyJqbM9jk9GUJrk8OOkTk7sNF5oxrWAEul3J3R2Hk4ToDtoDd9KA3TBBGLlRXiIIZJFbDC9HSMq9rxyMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521352; c=relaxed/simple;
	bh=EdRAOohke/zYN9xl8rce+/o08xSjgtGRfZcohBXf0Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IP9SaeFGn8OqNDu7XjIqjqE2DrdcOa4XGOcSKHeoQVmSyMZiTzW622YwYVqEHyq2kVpQUva2I0BHUY9GR0PysRn8qN7p8rR6S6XRLUJsoJhu2PnBPQGa3/ZlCrWbu69cJiblBkc4Xqz9uqfeJxDpXUpSdIC0ZYZAJ1itF6yQ9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b=GpiJG5pQ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708521342; x=1709126142; i=devzero@web.de;
	bh=EdRAOohke/zYN9xl8rce+/o08xSjgtGRfZcohBXf0Io=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=GpiJG5pQAH5dT+01x7KsPz0fBoufwPmgnstA7w2d+Wfq2VhExQA8x/wa+k0W38Ft
	 rpjw0YNsnsiT4GBvdmrHr5Eb4UsKpgOrruZdkJe+V7u7TQUerfzUdDe9Bwhi1oH2j
	 SzyMBWiB38gjjEkxzJKlZcEYhbyiKA1ZFqtRzR4ZgHZr6CoQSddGZFJtY8Ua5cKEI
	 vkUWNjXWuWrENOSqesq0mT0e5aTnwxckt8srrDlYsPDiLQjzzZm1xAjPfKKWUlCya
	 wQIj2IeLCS+kQisMmUOcboJqqprsozzDYiRmnsOPjtK/ZRhLumaz1xZ7VqAI9m4Zw
	 yi9jWQEardjOHWkoNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [172.20.35.190] ([37.24.118.138]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MvKXb-1qlVAl0sKH-00qoNV; Wed, 21
 Feb 2024 14:15:42 +0100
Message-ID: <2790f277-fc10-43fc-b7d3-9a3cef1eced2@web.de>
Date: Wed, 21 Feb 2024 14:15:40 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apply different compress/compress-force settings on different
 subvolumes ?
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <5bd227d2-187a-4e0a-9ae8-c199bf6d0c85@web.de>
 <1597160e-0b54-403b-8e9d-9435425f14f3@gmx.com>
From: Roland <devzero@web.de>
In-Reply-To: <1597160e-0b54-403b-8e9d-9435425f14f3@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CSazrZBeY0teF+ds8Sb9Za4ddZ82sei40W8m85DvrZfZ/ngIKr2
 WlIKORlyspsgmqTtIOjUWHRVFNRSp/m73HXbWryX1Pq0E4+b4s/F4C+fUpsIBfR4763HXX2
 CFXAJa4aNTBqqn+inBJmWowbUky0N8SfiS4TNOLv/Z26C9UMSx05obyd/wJpk2IKtN0yXsQ
 JkZkXku5rCbFUOohUYv4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QIPR4Lvetps=;CC7IqjTCbDerdogkFvr0Nz5Mu6R
 6zRj6HXQU6pRkVezn95D57/7pM/ByaUhn8BGfkLNpQ/Ar0Kv6qhpxCkRjBdcU7aUXVXLv+cVQ
 R90W/TxdUXfOGGeOSbt8y6sxembpL0J6ZotjxuvKaNk3y2gmVLrj+KjhoSAqF5IwWhr2PZ0ax
 7y/g/xHVzFbSXY95VJweysbgFnx9ws0bWTGG7SxxzkS5J6m64Cu5QuUx65VmsUf135oepKwm4
 KNV2qo6b0AvYBhpUzEueFCsu0g4rLPses8O0KlukXl+6NIhyPBnlgoBhhcgyJlawmg2CVpXtW
 3q34f8y5QMZvGiO4uqkzF6L/YF9ITQwjAV66KcamjV0CS/3viFHvHngMXiy5sTB/LM2v0HRo4
 OMNLdLB3tYpGSBZBUz4XF/HEEeJwBh8Fmnzt2vZ3Z5pMry2afmTGgFDPWR62bT3XbblVp56zW
 WXBjWdUjjJcODvXLiKR+Ur5TtkYwzud2/RJ/O8LAhEFpDnNReQrQ0Hr5ckmFXkCzAXjfYinvV
 GDjSx3sDE/VHmZ7KES6JnOHGowIDPThH/czVADgcVjTBSTs2QNVEmRs1vm6bbI+Kc4qCOPcRg
 pCZ79OTuppQiHsIIY6YSUjRbinPMEawwW7GTaqPt3BBOzenpQ+iMN3CMA5lGwz0k0Ld1T5d9G
 y7zg6KMUxTMzCv2ai0zXEQB4FJSTUd2xYhbtwbs7l2pcl1GuvO3l9YoQrB8EOuKia2jKc/IED
 6C0oRjmriAiiz2s1FJwRy3POo8ZjwVCqwZeCV922heYngMnlJH4vw0qFp096vuPfvEvgHgvG2
 iwcOBkdKMgvhRqdN/70lzkqIE38uQRL7+wdde/8ZRZcs8=

Am 21.02.24 um 10:33 schrieb Qu Wenruo:

> =E5=9C=A8 2024/2/21 19:19, Roland =E5=86=99=E9=81=93:
>> hello,
>>
>> what can be the reason , that multiple compress mount option do not wor=
k
>> on subvolume level , i.e. it's always the first that wins ?
> In that case, you may want to use "btrfs prop" subcommand to setup
> compression for each subvolume.
>
> The mount option one is really affecting the whole filesystem.
>>
>> and why is compress-force silently ignored? (see below)
> Compress-force has no coresponding per-inode prop option though.
>
> But I don't think compress-force would cause much difference against
> regular compress.

apparently, force-compress can make a big difference (and compress only
can lead to no compression at all):

https://bugzilla.proxmox.com/show_bug.cgi?id=3D5250#c6


>> regarding compress mount option, it seems that this can be overriden vi=
a
>> subvolume property, which can work around the problem and have multiple
>> compression settings.
>>
>> but how to fix compress-force in the same way, i.e. how can we have
>> differenty compress-force settings with one btrfs fs ?
>>
>> wouldn't it make sense to introduce compress-force property for this ?
>>
>> what about replacing compress with compress-force (i.e. make it the
>> default), as there is not much overhead with modern/fast cpu ?
>>
>> i think compress-force / compress is VERY confusing from and end user
>> perspective - and even worse, i have set "compress" on a subvolume used
>> for virtual machines and they do not get compressed at all (not a singl=
e
>> bit) . so i think, compress option is pretty short-sighted and not, wha=
t
>> an average user would expect (
>> https://marc.info/?l=3Dlinux-btrfs&m=3D154523409314147&w=3D2 )
>
> IIRC compress prop needs to be set to all inodes.
> If you set it on a directory, only new inodes would inherit the prop,
> the existing ones won't get the new prop.


that's clear, and no different from zfs.

the big advantage of btrfs is, that we have btrfs filesystem defragment
to recompress everything
in place, whereas in zfs we need to move it forth and back to a
different dataset.

regards
Roland

>
> Thanks,
> Qu
>>
>> i'd be happy on some feedback. not subscribed to this list, so please
>> CC.
>>
>> roland
>>
>>
>> zstd compression applied to all subvolumes, though specified otherwise:
>>
>> cat /etc/fstab|grep btrfs
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
>> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
>> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
>> subvol=3Dnone,compress=3Dnone,defaults 0 1
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
>> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>>
>> mount|grep btrfs
>> /dev/sdb1 on /btrfs/zstd type btrfs
>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,sub=
volid=3D259,subvol=3D/zstd)
>>
>> /dev/sdb1 on /btrfs/lzo type btrfs
>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,sub=
volid=3D257,subvol=3D/lzo)
>>
>> /dev/sdb1 on /btrfs/none type btrfs
>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,sub=
volid=3D258,subvol=3D/none)
>>
>> /dev/sdb1 on /btrfs/zstd-force type btrfs
>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,sub=
volid=3D260,subvol=3D/zstd-force)
>>
>>
>>
>> different order in fstab has different result - first wins:
>>
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
>> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
>> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
>> subvol=3Dnone,compress=3Dnone,defaults 0 1
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
>> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>>
>> /dev/sdb1 on /btrfs/lzo type btrfs
>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D257,subvol=3D/lzo)
>>
>> /dev/sdb1 on /btrfs/zstd type btrfs
>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D259,subvol=3D/zstd)
>>
>> /dev/sdb1 on /btrfs/none type btrfs
>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D258,subvol=3D/none)
>>
>> /dev/sdb1 on /btrfs/zstd-force type btrfs
>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D260,subvol=3D/zstd-force)
>>
>>
>>
>> compress-force silently ignored:
>>
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
>> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
>> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
>> subvol=3Dnone,compress=3Dnone,defaults 0 1
>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
>> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>>
>> /dev/sdb1 on /btrfs/zstd type btrfs
>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,sub=
volid=3D259,subvol=3D/zstd)
>>
>> /dev/sdb1 on /btrfs/lzo type btrfs
>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,sub=
volid=3D257,subvol=3D/lzo)
>>
>> /dev/sdb1 on /btrfs/none type btrfs
>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,sub=
volid=3D258,subvol=3D/none)
>>
>> /dev/sdb1 on /btrfs/zstd-force type btrfs
>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,sub=
volid=3D260,subvol=3D/zstd-force)
>>
>>
>>
>>
>> this is the write speed i get with compress-force=3Dzstd on i7-7700
>>
>> # dd if=3D/dev/zero of=3Dtest.dat bs=3D1024k count=3D10240 ;time sync
>> 10240+0 records in
>> 10240+0 records out
>> 10737418240 bytes (11 GB, 10 GiB) copied, 3.76111 s, 2.9 GB/s
>>
>> real=C2=A0=C2=A0=C2=A0 0m0.224s
>> user=C2=A0=C2=A0=C2=A0 0m0.000s
>> sys=C2=A0=C2=A0=C2=A0 0m0.081s
>>
>>
>>

