Return-Path: <linux-btrfs+bounces-2626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C4185F30D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 09:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2488D2842AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BAD2421F;
	Thu, 22 Feb 2024 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b="Os3ntVqJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB46241E0
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590832; cv=none; b=QuOS0OUDpeA6QiAufztA3xusOjiI8OvSq7pAHdZqLv8iJD9AZSjKkQagcGUSQRJVZ7bVpIBb9YSMzf/lM7jTX8MSBHy8jc8o84ZV5HBarAhEknqGnlxNs3zL8sb+py4TQFAaEpqPGn5fnzyQiv6+ZAsPcvZ3GfkzO7UpFNjGt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590832; c=relaxed/simple;
	bh=O64cjeqaJ1Q64+sIrOi/W2HmHmGEj/RlAB6XMRPCMZU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=O3ODfrxjMctHy6teStCdeXt3a2GTRXobr5Wz6JjhP5Q7ZfYpRfMN8I1Lrb19YAcbgxNp/BAnZh9A1uHWuacL4HFKm8YnjF1mu1EoZLhw7BJqhISdnAW74AI17ByXwiV2CvSK+Nr34qpMzNKO/DQHv1ws2nGCWslwknc4VFqkFQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b=Os3ntVqJ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708590821; x=1709195621; i=devzero@web.de;
	bh=O64cjeqaJ1Q64+sIrOi/W2HmHmGEj/RlAB6XMRPCMZU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=Os3ntVqJqJu/79PGuJFZxw6oRhEnPtWQFw8JiDXiw98R2bdZ49zl041aDonn/seD
	 tvF0Y9q/PiZmpb/Rv5xAIa6bw7a8TV7xpkZvN+WiRNIFrf70erEc4FpazEPQZ58du
	 6p8HB4r0K9PrD9xgBPmx5ZT0gG8NxeVqT0C3a/W7Cte5CF3p8E+dfAbQlKIX1wBbQ
	 PaEtDkFQvlEVpm8r/EC862cUpPYgxz4aNdJZ5NZBWXQ9BF8/Hi3b4RYwyrS2oH7s/
	 jtbyoyHCLWfq4rgUhMLgkZFyT6ut2YGIGmrdb9JgDbAidxIcJEIObJ/JThJh8J6Dy
	 57xQRXy0fylTNrcxDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.179.90] ([89.1.196.114]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M604f-1ra4WU1jcx-007NOx; Thu, 22
 Feb 2024 09:33:41 +0100
Message-ID: <39bee23c-65c8-4226-be79-6e035f0a7f49@web.de>
Date: Thu, 22 Feb 2024 09:33:40 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apply different compress/compress-force settings on different
 subvolumes ?
From: Roland <devzero@web.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <5bd227d2-187a-4e0a-9ae8-c199bf6d0c85@web.de>
 <1597160e-0b54-403b-8e9d-9435425f14f3@gmx.com>
 <2790f277-fc10-43fc-b7d3-9a3cef1eced2@web.de>
In-Reply-To: <2790f277-fc10-43fc-b7d3-9a3cef1eced2@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yOFuDXp2hPadbc6ALmPpWwe4SdNVMlYygRCSxEid3iwtvfAjxi0
 tPXQrfcc6UvkI+bexJQye4Vb5EQ+6mSqEvn14nRknKyfpp1xbcwXbuxGm1ptPK4oQfUt55l
 aD88lb6bWsmXWJIWMxTCJFcaKYBiW/iE3LyyPTaREB858qoaBX8X8icIF22HTGIY5NPXK8m
 JBIJOzH63xaNhJRkRZ6zA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zjRyegeY+KU=;qAegD+PF31ctPsfIuPq0Z+eGqqR
 aO/ktQtF2XWspd67gryMggGwlNRhJ1qpfLaRkWT+F8IT8d5NK95tzVr76BC18h49bXBpRdzQP
 Ga1yuvCc/dD0gLn2N6/ALWpfUnnbxOrqd22RsD0jWmhy9PW13UCkvfOq3TLCQnkJXopemeT3/
 93sCoNyCq9Uni30zAeFmocA/cOjwq8rFQNDXA7kpskC160Nh23EniFoZ3whQrsmcinjX1KQkw
 hj6NxMOPGkUqi/SvGalhlD4fYM5Ub2GS6cepOAWTpCgKzF9Car2qfed3IW3B2cqJG6aDqY4Qk
 As5FkpUBq9qtm1kvHqlHoeBP2gLF/x/bOZcS5CZXW3TI17oED22Hue0Izz3fuYEB/pGGQsykB
 4E3CEhAKHupZRPhxDq9ysyssXSUUgUr4TFVZeDkh9sWimWQIJCeKP9L4o9Fgehl3RAZZfGXVj
 MRq8Tkf7yW6VApAWHCeFsLARkxajrpURQJXQkw31wvkyDoqxVhlm3nyKCDGM26FVhrkdtsQCI
 6uOnwO51ZmNLrza1PTd7FC3eZXJMAzT4XCPr6ThWLHqKoEffgiJJccWhEoXLZuUdzh+xJSSb0
 MTewGXzlVIhBbqzRRXNUTQjsjAu/8xdXoTN3Ex7f8yCFAjCk8q6n8zHUjdnkHdCXAVEj2Ktbo
 /JHYKdWT6TfAZPVB7GGwuRT6kd4WY+uYj+AYhLKjS4cTBsOpwDOXafRGGzEG0PFpM7m7WL6JB
 bIR9qNCGmSScB4jzxtys9qZjLbudyuVqZBm2pcsxu3vUl8UEGHQdl5w6pjHzGFvHraF5yUdjU
 MTUe7VQAdhg+m7dmfhNK0rFJFnmhnr8lxDI7GKX8JCn8c=

re-send becaus my answer accidentally contained html and that was
rejected by mailinglist

 >The "compress-force=3D%s" is really confusing against the existing
 >"comrepss=3D%s" option.

yes, it is

 >To me, this sounds like a change which would improve the user interface.
 >And with the new option named determined, I'm pretty happy to add a new
 >prop to skip the heuristic.

fantastic. thank you for positive response

btw,

https://btrfs.readthedocs.io/en/latest/Compression.html

"unless the filesystem is mounted with /compress-force/. In that case
compression will always be attempted on the file only to be later
discarded. This is not optimal and subject to optimizations and further
development."

afaik, zfs is exactly doing that, i.e. it's always using
"compress-force", afaik there is no "more intelligent" heuristics to
determine if data is compressible.

if you choose to have compression, you are tradingcpu cycles for
increased diskspace but also decreased i/o latency and bandwidth. that's
the deal. users excpect that, but they don't expect that they only have
"compression lite" when they use "compress=3Dzstd".

i read some days ago, that zfs plans more cpu friendly check if data is
compressible at all, by first using faster compression algorithm and
then later on recompress with better one (
https://www.truenas.com/community/threads/game-changer-for-zfs-2-2-intelli=
gent-compression-that-saves-cpu-and-space.113247/
) . that sounds interesting.

regards
roland

Am 21.02.24 um 14:15 schrieb Roland:
> Am 21.02.24 um 10:33 schrieb Qu Wenruo:
>
>> =E5=9C=A8 2024/2/21 19:19, Roland =E5=86=99=E9=81=93:
>>> hello,
>>>
>>> what can be the reason , that multiple compress mount option do not
>>> work
>>> on subvolume level , i.e. it's always the first that wins ?
>> In that case, you may want to use "btrfs prop" subcommand to setup
>> compression for each subvolume.
>>
>> The mount option one is really affecting the whole filesystem.
>>>
>>> and why is compress-force silently ignored? (see below)
>> Compress-force has no coresponding per-inode prop option though.
>>
>> But I don't think compress-force would cause much difference against
>> regular compress.
>
> apparently, force-compress can make a big difference (and compress
> only can lead to no compression at all):
>
> https://bugzilla.proxmox.com/show_bug.cgi?id=3D5250#c6
>
>
>>> regarding compress mount option, it seems that this can be overriden
>>> via
>>> subvolume property, which can work around the problem and have multipl=
e
>>> compression settings.
>>>
>>> but how to fix compress-force in the same way, i.e. how can we have
>>> differenty compress-force settings with one btrfs fs ?
>>>
>>> wouldn't it make sense to introduce compress-force property for this ?
>>>
>>> what about replacing compress with compress-force (i.e. make it the
>>> default), as there is not much overhead with modern/fast cpu ?
>>>
>>> i think compress-force / compress is VERY confusing from and end user
>>> perspective - and even worse, i have set "compress" on a subvolume use=
d
>>> for virtual machines and they do not get compressed at all (not a
>>> single
>>> bit) . so i think, compress option is pretty short-sighted and not,
>>> what
>>> an average user would expect (
>>> https://marc.info/?l=3Dlinux-btrfs&m=3D154523409314147&w=3D2 )
>>
>> IIRC compress prop needs to be set to all inodes.
>> If you set it on a directory, only new inodes would inherit the prop,
>> the existing ones won't get the new prop.
>
>
> that's clear, and no different from zfs.
>
> the big advantage of btrfs is, that we have btrfs filesystem
> defragment to recompress everything
> in place, whereas in zfs we need to move it forth and back to a
> different dataset.
>
> regards
> Roland
>
>>
>> Thanks,
>> Qu
>>>
>>> i'd be happy on some feedback. not subscribed to this list, so
>>> please CC.
>>>
>>> roland
>>>
>>>
>>> zstd compression applied to all subvolumes, though specified otherwise=
:
>>>
>>> cat /etc/fstab|grep btrfs
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
>>> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
>>> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
>>> subvol=3Dnone,compress=3Dnone,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
>>> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>>>
>>> mount|grep btrfs
>>> /dev/sdb1 on /btrfs/zstd type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D259,subvol=3D/zstd)
>>>
>>> /dev/sdb1 on /btrfs/lzo type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D257,subvol=3D/lzo)
>>>
>>> /dev/sdb1 on /btrfs/none type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D258,subvol=3D/none)
>>>
>>> /dev/sdb1 on /btrfs/zstd-force type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D260,subvol=3D/zstd-force)
>>>
>>>
>>>
>>> different order in fstab has different result - first wins:
>>>
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
>>> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
>>> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
>>> subvol=3Dnone,compress=3Dnone,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
>>> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>>>
>>> /dev/sdb1 on /btrfs/lzo type btrfs
>>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvo=
lid=3D257,subvol=3D/lzo)
>>>
>>> /dev/sdb1 on /btrfs/zstd type btrfs
>>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvo=
lid=3D259,subvol=3D/zstd)
>>>
>>> /dev/sdb1 on /btrfs/none type btrfs
>>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvo=
lid=3D258,subvol=3D/none)
>>>
>>> /dev/sdb1 on /btrfs/zstd-force type btrfs
>>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvo=
lid=3D260,subvol=3D/zstd-force)
>>>
>>>
>>>
>>> compress-force silently ignored:
>>>
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
>>> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
>>> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
>>> subvol=3Dnone,compress=3Dnone,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
>>> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>>>
>>> /dev/sdb1 on /btrfs/zstd type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D259,subvol=3D/zstd)
>>>
>>> /dev/sdb1 on /btrfs/lzo type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D257,subvol=3D/lzo)
>>>
>>> /dev/sdb1 on /btrfs/none type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D258,subvol=3D/none)
>>>
>>> /dev/sdb1 on /btrfs/zstd-force type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D260,subvol=3D/zstd-force)
>>>
>>>
>>>
>>>
>>> this is the write speed i get with compress-force=3Dzstd on i7-7700
>>>
>>> # dd if=3D/dev/zero of=3Dtest.dat bs=3D1024k count=3D10240 ;time sync
>>> 10240+0 records in
>>> 10240+0 records out
>>> 10737418240 bytes (11 GB, 10 GiB) copied, 3.76111 s, 2.9 GB/s
>>>
>>> real=C2=A0=C2=A0=C2=A0 0m0.224s
>>> user=C2=A0=C2=A0=C2=A0 0m0.000s
>>> sys=C2=A0=C2=A0=C2=A0 0m0.081s
>>>
>>>
>>>

