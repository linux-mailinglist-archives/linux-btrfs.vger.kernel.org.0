Return-Path: <linux-btrfs+bounces-2601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02885D2DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 09:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5482C1F237BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B24C3CF7C;
	Wed, 21 Feb 2024 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b="ZO9FACUz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA043A1D3
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505712; cv=none; b=kuR7v4MhJpcx/YRLm6/G2FaeCfjUd7lwAAjD0CHrOtGUgOv0/fIE3AeYgJL3B9UcZpI6WhaiwihdIkG7DLx9anl9GmvDdUmfvJp75FB9z3zd66t5vA4JkmqI+e78oN6SeKL6qzV31dQpYOWIzKX4VSKnO77P35iIW+VOUmbr1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505712; c=relaxed/simple;
	bh=MMF/WsyFM/shbz4fuK3W+vPfZOKCLFxI1ewBKIvwQko=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HCIkA9DHCTag4zBaVHCmRK0PYPTu/eNMMT06ukjEJk+WgwHoa4yOy1DrJK1wGTePgRohKB8bj84Sr9WbGLpf2HS8r/r1wwkDm0b0FcCI6kQPMoEbRXBtXJtHheLX4cOdk1D2YiHyx+zhTOtW7oSn0yOybfinXfxcrcSfU1ml0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b=ZO9FACUz; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708505707; x=1709110507; i=devzero@web.de;
	bh=MMF/WsyFM/shbz4fuK3W+vPfZOKCLFxI1ewBKIvwQko=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=ZO9FACUz5bigQHeS0T+xY8+2wM53mshXdqn2WgAFgfBz9ORZIqntq1qgKPosPb8v
	 0UF45p/24gCN4GgW3pRxxVesEWB5nE/BJ3SKn8OBSe3xi6ZkX7/IXpyrapPmP/JCF
	 WNiVDyOi7ouacv1bVuMr2jeJNU6xu5Sq4tcC8pUCSH+/4ktI5aC1bVNXaiYdxbb3O
	 CSCPJvEZp9QsvhDSa5HD+BG8WD0PeOu83NhFC+KXcG9OL6+O/nGNQhbsoxWogj9nx
	 cTsrO629SpJ3QlHIN+YM/Q5AmpzsdYgkW8zYAzuSI7uWEwLO7HXXMfl3gY9FBu/M4
	 j5jxrsJjVqnl9+gNAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.179.90] ([89.0.45.80]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6YNJ-1raDC10M7F-0078rn for
 <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 09:49:56 +0100
Message-ID: <5bd227d2-187a-4e0a-9ae8-c199bf6d0c85@web.de>
Date: Wed, 21 Feb 2024 09:49:54 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
From: Roland <devzero@web.de>
Subject: apply different compress/compress-force settings on different
 subvolumes ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+B/nL4NxU3nQkffyEfwkKpjPxsXuqdQmP6D95KDEgIX5zd0Uy8/
 dJgMJGmWTBygZwKpmjlw7JVyAh3/PHSEnV+aRCQ+C+LyjCaGpTsNHIAsicdJ7IItgn8vzA4
 X9CWm2GpL+INH8XdSdi+Ur1/uBBWn78k2HG4MGqWCjPWcKHE8M926rgWQqHGkwOjG3Sdnzn
 rfGXzmqrRDewmMbKXIwYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3d24x9ZX4YI=;BdDvtua/MV9CPeTQIWIXdH9okRn
 gx5O8X9Jp0Ror6S+daVTVfoMtPJlEiIUDMb3OJqzD9FLUg5VCLYE/ZIUP6BjNrbBzchypIcS3
 /s2bMWnEnGVp+AkmFGSkqlrzfwy7J9gAeMVuzgIxJ0ZRQzItI+FxeNsKr+9f+ju3wQ1cXLtBc
 daZhA83aka4FLOZH3g0e84IYlJOf9VKMhFEeLJt8EdshFAN4y9UQtEggBgRGvZ5I+hWWuNZJK
 Kb0uO9Sjm3cq/kCGKI+SQfHCwbhcauBXJ3QjjNgTsvBbyKkKopZLhImAhP40FP5YQ+/ALd/LI
 XBRKtkVs9lx6Zps7NxQ8X6U0mKB7/2YBxVOnNxYp3Tl8VDG04HX0pjeoEfrSNMGNZZTBbhH0c
 iUR0gIMGQvhz5nkoAHzeTyq3yBBRQ7SnsRCWx3pvXjwIa3MIm+cTgv5875cTmIu1voiePXWuh
 SbhMH1msvJ7IyhgVixLKWpls7hV9b8BcEPcYfMFpydrhBwRXgw5My6yjfZcuCjtm9TYgLkiDQ
 977XgDquhDW45nlc7YeK74s3L2eOSze0hy43QosztDfNUJDDZtMK7ZOOP/LE/9LhSP8uyeOOB
 YMuuVL48NKVSm+D8N3px2xQw2EkW4EvMQ8b6qyBxb5LH6xZJGCJGfKK7tZ07qZvyfht/OmBr4
 ry1z3gs/ImeWfWBU8VSvfad5dCNIWKuBl+T65aNs4tCj6Wq0Fe1usO1guOUV94A7tlQeepAsM
 xU2tkTAnVMwIIFa65BR/yw4Uu+uqMOdNNhDMi/g2bDGGiwKdQTcq0TGUnvJX3gX5Ov5xcrBSh
 mQNsMaAs9MtYSg4v2AxGW2RH1eFdHeeEIzkLw97TY2WJI=

hello,

what can be the reason , that multiple compress mount option do not work
on subvolume level , i.e. it's always the first that wins ?

and why is compress-force silently ignored? (see below)

regarding compress mount option, it seems that this can be overriden via
subvolume property, which can work around the problem and have multiple
compression settings.

but how to fix compress-force in the same way, i.e. how can we have
differenty compress-force settings with one btrfs fs ?

wouldn't it make sense to introduce compress-force property for this ?

what about replacing compress with compress-force (i.e. make it the
default), as there is not much overhead with modern/fast cpu ?

i think compress-force / compress is VERY confusing from and end user
perspective - and even worse, i have set "compress" on a subvolume used
for virtual machines and they do not get compressed at all (not a single
bit) . so i think, compress option is pretty short-sighted and not, what
an average user would expect (
https://marc.info/?l=3Dlinux-btrfs&m=3D154523409314147&w=3D2 )

i'd be happy on some feedback. not subscribed to this list, so please CC.

roland


zstd compression applied to all subvolumes, though specified otherwise:

cat /etc/fstab|grep btrfs
UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
subvol=3Dzstd,compress=3Dzstd,defaults 0 1
UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
subvol=3Dlzo,compress=3Dlzo,defaults 0 1
UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
subvol=3Dnone,compress=3Dnone,defaults 0 1
UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1

mount|grep btrfs
/dev/sdb1 on /btrfs/zstd type btrfs
(rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D259,subvol=3D/zstd)
/dev/sdb1 on /btrfs/lzo type btrfs
(rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D257,subvol=3D/lzo)
/dev/sdb1 on /btrfs/none type btrfs
(rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D258,subvol=3D/none)
/dev/sdb1 on /btrfs/zstd-force type btrfs
(rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D260,subvol=3D/zstd-force)


different order in fstab has different result - first wins:

UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
subvol=3Dlzo,compress=3Dlzo,defaults 0 1
UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
subvol=3Dzstd,compress=3Dzstd,defaults 0 1
UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
subvol=3Dnone,compress=3Dnone,defaults 0 1
UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1

/dev/sdb1 on /btrfs/lzo type btrfs
(rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvolid=
=3D257,subvol=3D/lzo)
/dev/sdb1 on /btrfs/zstd type btrfs
(rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvolid=
=3D259,subvol=3D/zstd)
/dev/sdb1 on /btrfs/none type btrfs
(rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvolid=
=3D258,subvol=3D/none)
/dev/sdb1 on /btrfs/zstd-force type btrfs
(rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvolid=
=3D260,subvol=3D/zstd-force)


compress-force silently ignored:

UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
subvol=3Dzstd,compress=3Dzstd,defaults 0 1
UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
subvol=3Dlzo,compress=3Dlzo,defaults 0 1
UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
subvol=3Dnone,compress=3Dnone,defaults 0 1
UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1

/dev/sdb1 on /btrfs/zstd type btrfs
(rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D259,subvol=3D/zstd)
/dev/sdb1 on /btrfs/lzo type btrfs
(rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D257,subvol=3D/lzo)
/dev/sdb1 on /btrfs/none type btrfs
(rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D258,subvol=3D/none)
/dev/sdb1 on /btrfs/zstd-force type btrfs
(rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subvol=
id=3D260,subvol=3D/zstd-force)



this is the write speed i get with compress-force=3Dzstd on i7-7700

# dd if=3D/dev/zero of=3Dtest.dat bs=3D1024k count=3D10240 ;time sync
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB, 10 GiB) copied, 3.76111 s, 2.9 GB/s

real=C2=A0=C2=A0=C2=A0 0m0.224s
user=C2=A0=C2=A0=C2=A0 0m0.000s
sys=C2=A0=C2=A0=C2=A0 0m0.081s



