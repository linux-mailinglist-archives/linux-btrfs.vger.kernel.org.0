Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AEF2F2505
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 02:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbhALAmK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 19:42:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:52035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbhALAmF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 19:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610412017;
        bh=clUr2PJTHTEHLWQ5abgYb0hMfMOF1gJK0OWicOIcqYc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Wt9CuWcFc6h0qpvZOB+NBy75aZb5bMqQnYLg0+o7XGNbbUS+Eh2/QYve8ECXXV6pM
         E/hnkhduc7NR7Se/xhu9f6CrZConafYVNMNweovKgL38tGARIIPASU9F/PXwbaZ29U
         8hI4SB6anH36iw4Mi6ggCwxA8EJWM4yXciifbGlQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVeMA-1kXW9k1ETk-00RaTa; Tue, 12
 Jan 2021 01:40:17 +0100
Subject: Re: Btrfs compression ratio > 34:1 possible?
To:     Ole Tange <tange@gnu.org>, linux-btrfs@vger.kernel.org
References: <CA+4vN7xn4h8HjnkE5wpKw6VMrf9NCLCyheme2PspgheG3DmmvA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7b4cded9-01fa-4dff-8aaf-fcedc3b27562@gmx.com>
Date:   Tue, 12 Jan 2021 08:40:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CA+4vN7xn4h8HjnkE5wpKw6VMrf9NCLCyheme2PspgheG3DmmvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7vyKbeqYMfMJ56wgUsaqXvZGPiNBIHoT4ZEuGoV0xy6vE8Fj7vq
 5tM3aQDUsnQpUGtf6jvVeM9mqkPyRC3Nk99pePqdCMgCDCmEVhOGBykIo6DDRgJMjvxJt6C
 BbPvoajLaUsauT0o3aQ7jUUji8UARc0wjTeq6ZaWXrqb8GfXMvUYMoHmVj6gYiKB1U+pORo
 dB1bT2omPPAQXv3iyCL1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0erEQnq82BI=:KItHMhvI9y5p8DI3JwIZKM
 SloqyUdPweFmzmdwQx9aytMUnTLMg1giomi8YDM7balNIvzvko4GMA2iwCFqptjMB1cC72r8X
 FHtytSPu94OcxpLJAsnfoG0pbfOcFQI3k2LU2f0Bb3uDoUUEXi4/ELoC3jn2EXXNvHC1NQpwA
 /h9GVyeIYyouB3ngRrxw07PFKSIVljL7Hf8OIggUZz+3jpt9jWDjEkJpftm1ct6EgyOWe9whm
 UyD3Z3bEeUYP7hjfo96XcAcMhwFrVkzZV7u8B5ozfUbeDUvrM5y9ybRJkfRCwHrKLbXAsJK3g
 LaT6pvXb+cyTiBfvbProT+EGaXmciL1qzy7IKU19BpWyWwJmlGy42cYaDXtbojJ4Op69IZqrf
 LjgTc7TNY0oSRUn6f16GOXEApXM7RoOwPc864w7Iw4nFpds4Vo5GKK0rVW9GbyzT5YfpvCt2z
 2wIjZ/Q7ZgNXiUAv/lZ5vKLjVevIqzNxsp21FBHPx8lL1yySm8fWNFpcyjfgbDTnED1UQ9MBg
 MKI3WiYe3kXbsPfx3WutqXj15CX3Fx+5tZXm/MaR8fu+I5BMBbnv9AKW6lNKpPCN9AzJzuXKj
 NZ+CGhuzNpfqn+XYs0yJW1/4Mbis+s6Dt4v9AbqQW7MuA5K8ZwfYPGNer/XHLjLxEcq+JqcRd
 k1HW8FuEQtl6JRhEAaDmVrXr08KRioTIZcyGS4tnqGYyVo1KknvRVCwQFa3CZ4CRaS92jrjTv
 CrahghbSXeW7pM48ksCdFEkbAlldJaMMRn89kJQ+4lTaeUcb5KSlhgnUgOgkwlEnmD5W0Nz5R
 vS8NPxEownGKRgiq30NY1ApUfDh9qofr8aS7ZIj3rv0wqMeRMYiu6nt4GMdubyv6/WCQuMloa
 k2lpRMOoZhllb3Htxi4A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/12 =E4=B8=8A=E5=8D=887:32, Ole Tange wrote:
> I am trying to use Btrfs' compression on some highly compressible data.
>
> I try to make zstd give better performance than 34:1.
>
> This:
>
>     $ truncate -s 1T /tmp/btrfs
>     $ mkfs.btrfs /tmp/btrfs
>     $ mount -o compress=3Dzstd:9  /tmp/btrfs /mnt/btrfs
>     $ head -c 10G /dev/zero > /mnt/btrfs/zero
>     $ du /tmp/btrfs
>     313672k
>
> shows a compression ratio of 10737418240/312724/1024 =3D 33.5:1
>
> But if I run:
>
>     $ head -c 10G /dev/zero | zstd | wc -c
>     336655
>
> I get a compression ratio of 10737418240/336655 =3D 31894:1
>
> That is around 1000 times better.
>
> I understand there is some overhead in Btrfs, so it is expected that
> it is not possible to reach the full ratio. But it seems there is
> little to no difference in using 'compress=3Dzstd:9' and
> 'compress=3Dzstd:3' on highly compressible data.
>
> My guess is, that data is chopped up in small blocks (1k?) that are
> each compressed. If so: Is it possible to make these blocks bigger? I
> think that would make sense in general when using higher compression
> values.

For compressed data, btrfs has a size limit for data extent, which is
128K. The number is to balance between compression ratio and extra
decompression for CoWed extents.

On the other hand, btrfs (any fs) has its minimal block size, and it's
4K for x86_64.

So the upper limit you can get is 128K / 4K =3D 32.

Thanks,
Qu

>
>
> /Ole
>
