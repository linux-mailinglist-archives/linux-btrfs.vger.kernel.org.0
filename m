Return-Path: <linux-btrfs+bounces-10130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E3E9E87C1
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 21:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7779328198F
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 20:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFFB189F3B;
	Sun,  8 Dec 2024 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="itKwDSIA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47217142903
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733689617; cv=none; b=aIsU06YtGiOU1oyxUIt2mTcBGF5Vbg1BNCVptqv1UEnpPPWnCnNbA+gVKQQ095ITeg7/9cHQ9ayReb++fO8wijkbm57yEKow3K4YpVRmjccavqYpzdAK3qedGbBUg/ORI3RIydjzZB53nIeXwAFeNjqzDYUY3JiQvjX7avCZdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733689617; c=relaxed/simple;
	bh=rKbTBZj28Il6g2Larv2BPrrZ1CvlkuAGHe+wrYllG5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dySj53pFsd8E0zNpJy4Ett8ERc7wON7UWWIhIvkTdgxGeaGr6i4SWxVofSFikTXEklvJrCTvTjifJR5H5Gl5L1v/MitXZB/qzY7LwbsUYivGYLd4m7mLQ4Hb3nmw51sJzVxGDpYFfzB/sCLUfbKjggZP+26DP/ytkE29toE06ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=itKwDSIA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733689611; x=1734294411; i=quwenruo.btrfs@gmx.com;
	bh=mgjjG5bNVs6v8qd6qZhdZvvmLBZGlv3033aX2ma8zrI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=itKwDSIA4IKahd68lpTf/QCO2caOCQ0e7Bn1RfR8rdLhMMSgGexxmWqO/dlEpAiJ
	 kpe08i0f8Btj4E/sQtJnal1y7MYK6Ob4DyIEFDwMKTrvE0oicp7OP94orwHvduYZ0
	 HR+Nfr7DFDIb0S3Nbu0xsqoKaOyjSzHVMdIpalJQRkXnwQg7MFYcmBIP1hqqfXboM
	 uqFyU3X7G4Yn/FremUze9xRTjklfCD37ek5+Y6mQHyKNGjrDUSS05OpAfT1G7oDLy
	 BP+xuKM5ylbbA6Ejp3Iq3bHIhozTy3aT+glmyiDVjFgkwp5SkhmjTOA4gCNfbPfTb
	 AUH63u/2hOxZtUqeaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2O1-1tpbx41D1d-00qLif; Sun, 08
 Dec 2024 21:26:51 +0100
Message-ID: <c5ec9e5e-9113-490d-84c3-82ded6baa793@gmx.com>
Date: Mon, 9 Dec 2024 06:56:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: clear space cache v1 fails with Unable to find block group for 0
To: j4nn <j4nn.xda@gmail.com>, linux-btrfs@vger.kernel.org
References: <CADhu7iD1LOT=93o1DhFYBeDHTKW9SuYdSmz8VXvsE4vf285tDg@mail.gmail.com>
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
In-Reply-To: <CADhu7iD1LOT=93o1DhFYBeDHTKW9SuYdSmz8VXvsE4vf285tDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Uv/BYC5HT/YNI6tDq+Imb8oENcNdrKuUS+MpBAiLqGRniaZCYY
 GHF4YTwjXHIBWLdqC3RFgstujdeuMcTylRrBTi6+DB7/G6ry8CNIb6g0E79iSEe+0NswQoQ
 WwvmYIwoxwUCDuNV7mlGPogbXExsNbP6coHnRX6072HHgPg6j2tKCgNpy30CY3NfbO6VDS9
 gS8y5HaW7BL/7qUV8uW/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8nGfkLZWcXI=;Pud2KAXdSeOxLmwxzKWEQXcyz3a
 E/P72CO3y+ezkW0lwTYyGt1PdZ7Dsu/XkODw6GFdnY97802A+grnafL5BQ9tMlzZ8ohRSs1s3
 B0mPOqCzVlywL2FqDrjyA/RUJT3oo2h5l4hH7IheMESkwu0TvHNfX4vDCHrUMu5C7p82L8gYH
 LZBV0JlbtRz3YKEKDoTcMx+4gWv36dS7TDNS/Et0m3iIgxgdq7eB5lMmBYv0sBB7xbSTiM/Ug
 6vrxlfDvvON07yFfbMdxbGjiukFC0QEQZZL3tOOJuWBn0eDVIWeN5YbsT00MNUlDlhgZ4xLMF
 nm2EwhqBjhKk4jP9zbl0z1IlX9zc9kd8Mac3TCvVUO64NM1tG5gTeew5NewTiZ0V391ofc8qE
 MMsKpRqQgXq4otLFhR8xrhSaQvcyKD1e9Sgq5DcIuxQLAbGfY/h2a0nYMxfWHEn1n6xExUQB8
 K3yY2zuHUSKHG1dWIL+7ULXK6ZmTAMBvRk7+ma9HHQXehPqbCx4+VrQmVvLY2mon7eALVa2St
 xLg69mtVH6FF1pHKMK8XaMlH/kdciZXWZPScwNdhX1uSo0FBUtjQmWGeu6mtVkqzeuthIhRlZ
 7tibDtuwF5qIu8YBLORPjbrzOXjLmnUMETRWFIiejUVBWBkY61TkKevrjPnraNWXE9rLW8GCv
 InsEErhsMe5HGG+WjAeiDV2ViIWjottLBJprWeOwrFrLZQD+tL8wE2KVbPA6u4tyUFC2juO0M
 Dv+Vygb6Rp5/TAASORwWEr69cG25mLWfVYv68Nq5xVQHX6e2s3YMJKr/DzhZZ7VhTNNIXT9tM
 LyUXwS3VCrtoQknxeTq1EXiRjWrMBo1kzINreeYQrZirHhtGk0fcj7GZKEvnzx0Rc40qPMA8u
 Z1Yf/UqEQNnLRT6+9jPwCWUdVm/wOUJpVKNE7LO1CgkklEmKy3r+iVVc/L5J8UenFxQ6Gm/rb
 5hw4Kx/atbFjN1i9RJyHr0+FBAXn/q7B0B5qy9bV7nX0zKePK823lA6YsMRb0kcDlV6SkrhIo
 /HD6+12o3ouN6PY52IexUkpzHF+ZMwmId6By8qxrHccF0vlm4RUIMA3n0pGgdIoG6g8vvrZVk
 uMiAUD5TYgTrAeX1lQip9Y3NpGpOsC



=E5=9C=A8 2024/12/9 02:32, j4nn =E5=86=99=E9=81=93:
> Hi,
>
> I am trying to switch 8TB raid1 btrfs from space cache v1 to v2, but
> the clear space cache v1 fails as following:
>
> gentoo ~ # btrfs filesystem df /mnt/data
> Data, RAID1: total=3D7.36TiB, used=3D7.00TiB
> System, RAID1: total=3D64.00MiB, used=3D1.11MiB
> Metadata, RAID1: total=3D63.00GiB, used=3D57.37GiB
> Metadata, DUP: total=3D5.00GiB, used=3D1.18GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
> WARNING:    Metadata: raid1, dup
> gentoo ~ # umount /mnt/data
>
> gentoo ~ # time btrfs rescue clear-space-cache v1 /dev/mapper/wdrb-bdata
> Unable to find block group for 0
> Unable to find block group for 0
> Unable to find block group for 0

This is a common indicator of -ENOSPC.

But according to the fi df output, we should have quite a lot of
metadata space left.

The only concern is the DUP metadata, which may cause the space
reservation code not to work in progs.

Have you tried to convert the DUP metadata first?

And `btrfs fi usage` output please.

> ERROR: failed to clear free space cache
> extent buffer leak: start 9587384418304 len 16384
>
> real    7m8.174s
> user    0m6.883s
> sys     0m9.322s
>
>
> Here some info:
>
> gentoo ~ # uname -a
> Linux gentoo 6.12.3-gentoo-x86_64 #1 SMP PREEMPT_DYNAMIC Sun Dec  8
> 00:12:56 CET 2024 x86_64 AMD Ryzen 9 5950X 16-Core Processor
> AuthenticAMD GNU/Linux
> gentoo ~ # btrfs --version
> btrfs-progs v6.12
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=
=3Dbuiltin
> gentoo ~ # btrfs filesystem show /mnt/data
> Label: 'rdata'  uuid: 1dfac20a-3f84-4149-aba0-f160ab633373
>         Total devices 2 FS bytes used 7.06TiB
>         devid    1 size 8.00TiB used 7.26TiB path /dev/mapper/wdrb-bdata
>         devid    2 size 8.00TiB used 7.25TiB path /dev/mapper/wdrc-cdata
> gentoo ~ # dmesg | tail -n 6
> [31008.980706] BTRFS info (device dm-0): first mount of filesystem
> 1dfac20a-3f84-4149-aba0-f160ab633373
> [31008.980726] BTRFS info (device dm-0): using crc32c (crc32c-intel)
> checksum algorithm
> [31008.980731] BTRFS info (device dm-0): disk space caching is enabled
> [31008.980734] BTRFS warning (device dm-0): space cache v1 is being
> deprecated and will be removed in a future release, please use -o
> space_cache=3Dv2
> [31009.994687] BTRFS info (device dm-0): bdev /dev/mapper/wdrb-bdata
> errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
> [31009.994696] BTRFS info (device dm-0): bdev /dev/mapper/wdrc-cdata
> errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
>
> Completed scrub (which corrected 4 errors), btrfs check completed
> without errors:
>
> gentoo ~ # btrfs scrub status /mnt/data
> UUID:             1dfac20a-3f84-4149-aba0-f160ab633373
> Scrub started:    Fri Dec  6 13:12:36 2024
> Status:           finished
> Duration:         16:11:22
> Total to scrub:   14.92TiB
> Rate:             268.35MiB/s
> Error summary:    verify=3D4
>   Corrected:      4
>   Uncorrectable:  0
>   Unverified:     0
> gentoo ~ # umount /mnt/data
>
> gentoo ~ # time btrfs check -p /dev/mapper/wdrb-bdata
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/wdrb-bdata
> UUID: 1dfac20a-3f84-4149-aba0-f160ab633373
> [1/7] checking root items                      (0:06:57 elapsed,
> 34253945 items checked)
> [2/7] checking extents                         (0:23:08 elapsed,
> 3999596 items checked)
> [3/7] checking free space cache                (0:04:25 elapsed, 7868
> items checked)
> [4/7] checking fs roots                        (1:03:46 elapsed,
> 3215533 items checked)
> [5/7] checking csums (without verifying data)  (0:11:58 elapsed,
> 15418322 items checked)
> [6/7] checking root refs                       (0:00:00 elapsed, 52
> items checked)
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 8199989936128 bytes used, no error found
> total csum bytes: 7940889876
> total tree bytes: 65528446976
> total fs tree bytes: 52856799232
> total extent tree bytes: 3578331136
> btree space waste bytes: 10797983857
> file data blocks allocated: 21632555483136
> referenced 9547690319872
>
> real    111m10.370s
> user    10m28.442s
> sys     6m44.888s
>
> Tried some balance as found example posted, not really sure if that shou=
ld help:
>
> gentoo ~ # btrfs balance start -dusage=3D10 /mnt/data
> Done, had to relocate 32 out of 7467 chunks

The balance doesn't do much, the overall chunk layout is still the same.
>
> gentoo ~ # btrfs filesystem df /mnt/data
> Data, RAID1: total=3D7.19TiB, used=3D7.00TiB
> System, RAID1: total=3D64.00MiB, used=3D1.08MiB
> Metadata, RAID1: total=3D63.00GiB, used=3D57.36GiB
> Metadata, DUP: total=3D5.00GiB, used=3D1.18GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
> WARNING:    Metadata: raid1, dup
>
> But it did not help:
>
> gentoo ~ # time btrfs rescue clear-space-cache v1 /dev/mapper/wdrb-bdata
> Unable to find block group for 0
> Unable to find block group for 0
> Unable to find block group for 0
> ERROR: failed to clear free space cache
> extent buffer leak: start 7995086045184 len 16384
>
> real    6m58.515s
> user    0m6.270s
> sys     0m9.586s

Migrating to v2 cache doesn't really need to manually clear the v1 cache.

Just mounting with "space_cache=3Dv2" option will automatically purge the
v1 cache, just as explained in the man page:

   If v2 is enabled, and v1 space cache will be cleared (at the first
   mount)

If you want to dig deeper, the implementation is done in
btrfs_set_free_space_cache_v1_active() which calls
cleanup_free_space_cache_v1() if @active is false.

Thanks,
Qu
>
> Any idea how to fix this?
> Thanks.
>


