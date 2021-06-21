Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050D53AE7D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 13:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFULDB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 07:03:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:38275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhFULDA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 07:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624273244;
        bh=gI2od4hfxrNl9MEd31A2pi6a5gcCVYqmaVFslKwBSdA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HT3J3BlI9QdI2CtTwCtm9JBDkwyeyk9c+Kap36UMIO18cjomR+AZnd+j2mwGkllca
         1T4KJ2crZ0SWYNlRA2UfleLUz2Ctj3/Wxih+6/hSCDnBo1mvAXIfRCWhFhM8wtGTp3
         pmQ+nBVX3ovk8RQQRWDL0dAUnGZTiSlKl24vxSbY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8ykW-1lsWVh1Bzi-0066wl; Mon, 21
 Jun 2021 13:00:44 +0200
Subject: Re: Recovering from filesystem errors?
To:     Volker <volker@fsync.org>, linux-btrfs@vger.kernel.org
References: <a2d39735-b54d-a11f-cee3-92f72e3f00b9@fsync.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8c91a6dd-e94f-1214-df5a-9fcaad57d042@gmx.com>
Date:   Mon, 21 Jun 2021 19:00:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a2d39735-b54d-a11f-cee3-92f72e3f00b9@fsync.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y+Q9mlXGezwxeu2KcoI4pauc+vAlvoSY+WY3onk4gA4ZfB1Mhr3
 h36iUlYKfAST1fSJjDL6G2mqE61H/MJzulcMzafVf4cnEKNvmTzBxbJCvPRX04Ckmps2edI
 MFfDi8haB+ShmEtsq+iS1/xgy/9U1Yqx0uir31u2cwT54R1mU41SVZiOCRsLf3vmkbYL3cf
 fQrnJbfqo3/FfI6qoZZxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LlxpgSE2iKE=:7dEnzEvWGv3DKc1F4J3xNy
 WTBgeHz21FS7a6cXIfYF5GU64f7LKXeED3ms3wFoWOutLI7v37vFlKbSHLyDQ/+QOGoPS5NJe
 Ft/BB1YyTWw6zSX5pxUyb3IHxF8y6yXiBpAaEOCnBNDdtq6xz6ri95cenvctLHPtOD82z1yQM
 A/ePeWw7qfN5U9Nn576kjP3c58aJHxdEFMrPvi9I7c5Ms1q6Lxv6eW6dxPaVnhMuuOnUhHZEd
 uhrxdCg7utVPQKVG9gLxk85lwdxsE9cI1kY4XH8Ok9SS7tYeW2s3DGNZXk8ZjJls8f3igybgq
 UUAGC4i/u1+OC5FTulwOc8s5s6rS8Fw0ZgD0soC998C85X937viASa7IaqCiX5s+CnBI2qRGW
 ICW27pQFm8OFXVHlXyELxW8zgAZAhFUzxhc1rwtHuJTR8hMPOe4GQDR33EykbCxkUBAbQkRYI
 xDvuFrePsO6HH7TErSXuhvtbGdztBKCXqJ06OUqLlSKEVsh4JJoVO0r5fnfpvwiI6LY4oRhyY
 PgP3uOgxG1rJd6VjriHU3T/ehSX4Ik46AG0zAG0EF2JDOIgFkoA4OXWXjYXXAwxaqgJKlv9cv
 8CMrAb527K5YtAKbDwhyP8kAZvbEfsIvLZkIqJ94luVHAXI23OoQPtKmV57OkulKsFkp0VeHM
 y5/hdjdfrUfnO8lYdEtKFOcxpoQGVJEXBbST5fJCWqO5nRiPTiATrGey8PNXzTaNcsrnRNz0D
 vVUYWyzXTD7zMmmL1ff97hBoXTV1jFFUcanBvWiNuS4sifjff/kpAluZ1cYeYCIYPS74rT1QC
 ko9IvOODe3VsDPWBRt7tOcQmEgOmL25nSeMUV0PGvfAfOk+ghN8pGrcRqKQBJX/hpOofwEYBX
 ZdmpmSsO4jNjF5S8Y1fXmS8azkFXG84lLtKuvL1kg14Ng3koLLPj+VGWMkvjjbh6qvyUYaXw+
 MI5JSzAgL7zY69lhz5dK5j8Y/dZGz/pFHDkLaxpEoNMRBA3tRG8aLzqJJ4bbys5CvMwXOlQDR
 YGk2vRroanyT13PcnHgDuwVrNnSUEVB55QlJunawlYvDbPokFVmj0x2VB2l02TDErmU4+1zLO
 ebkjSv4SNN3GJoeSGnQBPqUJnusB5WkuFoS5g5NBdVQZVA104BqQ3mejQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/21 =E4=B8=8B=E5=8D=886:41, Volker wrote:
> Hi,
>
> I've been running btrfs for a number of years now on a Debian server
> without problems, but now got into trouble. The filesystem automatically
> switched to read-only due to errors and that's how I noticed. I could
> actually find in the logs of the regularly running scrub that there were
> errors but, shame on me, I didn't notice these log messages before now.
> Now I'm trying to fix the errors, but didn't succeed so far.
>
> After finding the disk read-only, I could remount the disk with "-o
> recovery" and subsequent mounts were successful. However, a new run of
> scrub found errors, as did "btrfs check /dev/sda4":
>
> - errors found in extent allocation tree or chunk allocation
>
> - errors 2000, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir ...
>
> - errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir ...
>

[...]
> [ 1758.383764] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)

This is an obvious memory bitflip:
hex(9223372547127476224) =3D 0x80000076ce9f8000
hex(510283886592)	 =3D 0x00000076cf4a3000

See the high 0x8 bit flip?

So it looks like your memory has some problem.

Any idea what's your kernel version?
For newer kernel we should have write-time tree-check, which should
prevent this, although by an anonying trans abort.
But at least there should be no corrupted data.

I don't have any good idea to recovery though, as the corrupted data has
already reached disk, and I don't believe it's the only memory corruption.=
..

Thanks,
Qu

> [ 1760.720490] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [ 1760.724971] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [54653.918256] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [54654.070094] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [54654.070247] BTRFS: error (device sda4) in
> btrfs_finish_ordered_io:3131: errno=3D-5 IO failure
> [54654.070317] BTRFS info (device sda4): forced readonly
> [89778.620651] BTRFS info (device sda4): disk space caching is enabled
> [89778.861394] BTRFS info (device sda4): bdev /dev/sda4 errs: wr 0, rd
> 0, flush 0, corrupt 23, gen 0
> [89892.442988] BTRFS warning (device sda4): 'recovery' is deprecated,
> use 'usebackuproot' instead
> [89892.443078] BTRFS info (device sda4): trying to use backup root at
> mount time
> [89892.443146] BTRFS info (device sda4): disk space caching is enabled
> [89892.665258] BTRFS info (device sda4): bdev /dev/sda4 errs: wr 0, rd
> 0, flush 0, corrupt 23, gen 0
> [91148.220467] BTRFS info (device sda4): disk space caching is enabled
> [91148.486704] BTRFS info (device sda4): bdev /dev/sda4 errs: wr 0, rd
> 0, flush 0, corrupt 23, gen 0
> [91282.111038] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91282.641833] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91282.642007] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 0
> [91282.942527] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91283.462764] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91283.462922] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 4096
> [91283.879329] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91283.988504] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91283.988680] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 8192
> [91284.087489] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91284.209374] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91284.209509] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 12288
> [91284.467159] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91284.883794] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91284.883933] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 16384
> [91285.268720] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91285.788965] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91285.789110] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 20480
> [91285.965558] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91285.966184] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91285.966355] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 24576
> [91286.053056] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91286.320483] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91286.320623] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 28672
> [91286.710734] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91286.988923] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91286.989049] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 32768
> [91287.615981] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91287.852042] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91287.852183] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 36864
> [91287.917659] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91287.918375] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91287.918514] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 40960
> [91288.033442] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.177533] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.177710] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 45056
> [91288.179205] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.186287] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.186452] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 49152
> [91288.197595] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.310022] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.310739] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 53248
> [91288.311383] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.312427] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.312562] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 57344
> [91288.417985] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.418564] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.418700] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 61440
> [91288.518410] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.672613] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91288.672776] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 65536
> [91288.966621] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.051898] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.052036] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 69632
> [91289.189162] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.190428] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.190539] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 73728
> [91289.211313] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.219394] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.233441] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.242520] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.248080] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.259022] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.265716] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.275883] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.286814] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.294706] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.303355] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.313367] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.329183] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.332623] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.342675] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.343016] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.343283] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.343676] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.346892] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.533529] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.534643] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.611097] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.626089] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.626783] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.627507] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.628022] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.721222] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
> [91289.758805] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.770095] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91289.771051] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
> [91291.394644] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91291.525449] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91291.625608] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
> [91292.332090] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91292.348071] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91292.348545] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
> [91293.447156] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91293.546401] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91293.546612] __btrfs_lookup_bio_sums: 16 callbacks suppressed
> [91293.546614] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 0
> [91293.562215] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
> [91295.396521] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91295.397339] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91295.397472] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 0
> [91295.410498] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
> [91296.878567] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91296.883069] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91296.883243] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 0
> [91296.983154] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
> [91299.528835] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91299.529653] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91299.529822] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 0
> [91299.529993] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
> [91306.044652] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91306.058784] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91306.058958] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 0
> [91306.061188] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
> [91311.833740] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91311.874239] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91311.874412] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 0
> [91311.900869] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
> [91323.112902] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.121408] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.121741] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.122047] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.122176] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 1712128
> [91323.122366] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.122648] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.122975] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.123102] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 1716224
> [91323.123108] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 0
> [91323.141510] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 1712128 csum 0x7e65917e expected csum 0x00000000 mirror 1
> [91323.141544] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
> [91323.142079] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.167226] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.167338] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 1712128
> [91323.181249] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 1712128 csum 0x7e65917e expected csum 0x00000000 mirror 1
> [91323.234935] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.303983] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.304344] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.304719] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.305131] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.305607] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.305959] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.306258] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.306587] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.306940] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.334190] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.348317] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.348458] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 1712128
> [91323.366361] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 1712128 csum 0x7e65917e expected csum 0x00000000 mirror 1
> [91323.366395] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.366777] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.367130] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.367951] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.368080] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 2744320
> [91323.373710] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.374089] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.374483] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.374612] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 1761280
> [91323.415837] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 1761280 csum 0xa27d2b88 expected csum 0x00000000 mirror 1
> [91323.415878] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.416068] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 430080
> [91323.429769] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.429901] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 1703936
> [91323.430090] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 1703936 csum 0x0a8edc47 expected csum 0x00000000 mirror 1
> [91323.430111] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.430316] BTRFS info (device sda4): no csum found for inode
> 1070749910 start 425984
> [91323.430696] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.431417] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 1708032 csum 0x1d350ea4 expected csum 0x00000000 mirror 1
> [91323.431491] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.440961] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.441407] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.441789] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.458131] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 425984 csum 0x708d52c8 expected csum 0x00000000 mirror 1
> [91323.458167] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 430080 csum 0x295c9299 expected csum 0x00000000 mirror 1
> [91323.465224] BTRFS warning (device sda4): csum failed root 5 ino
> 1070749910 off 2744320 csum 0x349a5df4 expected csum 0x00000000 mirror 1
> [91323.531707] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.545737] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.546549] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.547039] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.547595] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.548229] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.605334] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.619574] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.619949] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.620344] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.634451] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.634931] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.635311] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.700115] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.714431] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.714766] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.715213] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.715696] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.716003] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.716445] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.716764] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.763195] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.777742] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.778098] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.785175] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.785737] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.836944] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.851573] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.851922] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.852272] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.852623] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.853052] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.853736] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.854081] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.854587] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.854855] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.855171] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.855464] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.855739] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.856003] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.856261] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.856521] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.856777] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.857037] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.857293] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.857556] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.857812] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.858076] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.858393] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.858656] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.858969] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.859252] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.859515] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.859780] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.860037] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.860297] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.860554] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.860814] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.861070] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.861330] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.861588] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.861830] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.862534] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [91323.862777] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [96544.729579] BTRFS info (device sda4): disk space caching is enabled
> [96544.907903] BTRFS info (device sda4): bdev /dev/sda4 errs: wr 0, rd
> 0, flush 0, corrupt 23, gen 0
> [96564.084355] btrfs_print_data_csum_error: 3 callbacks suppressed
> [96564.084360] BTRFS warning (device sda4): csum failed root 5 ino
> 1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
> [96564.084738] BTRFS warning (device sda4): csum failed root 5 ino
> 1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
> [96569.215362] BTRFS warning (device sda4): csum failed root 5 ino
> 1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
> [96569.215683] BTRFS warning (device sda4): csum failed root 5 ino
> 1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
> [96636.773580] BTRFS warning (device sda4): csum failed root 5 ino
> 1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
> [96641.012152] BTRFS warning (device sda4): csum failed root 5 ino
> 1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
> [96641.012508] BTRFS warning (device sda4): csum failed root 5 ino
> 1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
> [99638.309938] perf: interrupt took too long (2514 > 2500), lowering
> kernel.perf_event_max_sample_rate to 79500
> [99963.456786] btrfs_printk: 55 callbacks suppressed
> [99963.456799] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [99963.461266] BTRFS critical (device sda4): corrupt node: root=3D7
> block=3D644705402880 slot=3D247, bad key order, current
> (18446744073709551606 128 9223372547127476224) next
> (18446744073709551606 128 510283886592)
> [99963.461430] BTRFS: error (device sda4) in
> btrfs_finish_ordered_io:3131: errno=3D-5 IO failure
> [99963.461521] BTRFS info (device sda4): forced readonly
> [118332.979501] perf: interrupt took too long (3149 > 3142), lowering
> kernel.perf_event_max_sample_rate to 63500
>
> # btrfs scrub start -Bd /data/1
> ERROR: there are uncorrectable errors
> scrub device /dev/sda4 (id 1) done
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scrub started at Wed Jun=C2=
=A0 2 04:00:01 2021 and finished after
> 03:58:49
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total bytes scrubbed: 1.11Ti=
B with 3 errors
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error details: csum=3D3
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 corrected errors: 0, uncorre=
ctable errors: 3, unverified errors: 0
> Scrub cancelled at /data/1
>
> # btrfs check /dev/sda4
> [1/7] checking root items
> [2/7] checking extents
> bad block 644705402880
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 5 inode 3512270 errors 2000, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 916764783=
 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 943259148=
 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 969705813=
 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 974995567=
 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 980161404=
 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 992269117=
 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 993044815=
 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 993822406=
 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 106741587=
9 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 106963903=
4 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107027449=
2 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107043355=
3 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107059191=
0 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107075086=
0 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107090611=
2 index 2 namelen 17 name
> grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
> root 5 inode 3512278 errors 2000, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 916764783=
 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 943259148=
 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 969705813=
 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 974995567=
 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 980161404=
 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 992269117=
 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 993044815=
 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 993822406=
 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 106741587=
9 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 106963903=
4 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107027449=
2 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107043355=
3 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107059191=
0 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107075086=
0 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107090611=
2 index 4 namelen 7 name grubenv
> filetype 0 errors 3, no dir item, no dir index
> root 5 inode 3512279 errors 2000, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 916764783=
 index 5 namelen 11 name
> unicode.pf2 filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 943259148=
 index 5 namelen 11 name
> unicode.pf2 filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 969705813=
 index 5 namelen 11 name
> unicode.pf2 filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 974995567=
 index 5 namelen 11 name
> unicode.pf2 filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 980161404=
 index 5 namelen 11 name
> unicode.pf2 filetype 0 errors 3, no dir item, no dir index
> root 5 inode 3512280 errors 2000, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 916764785=
 index 2 namelen 11 name
> unicode.pf2 filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 943259150=
 index 2 namelen 11 name
> unicode.pf2 filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 969705815=
 index 2 namelen 11 name
> unicode.pf2 filetype 0 errors 3, no dir item, no dir index
> [.............................. and many more
> ................................]
> root 5 inode 13212542 errors 2000, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=EF=BF=BD=EF=BF=BD=C2=A0 unresolved ref d=
ir 916786610 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 943280989=
 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 969727650=
 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 975017417=
 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 980183268=
 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 992290605=
 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 993066289=
 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 993844140=
 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 106743663=
7 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 106965982=
0 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107029557=
1 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107045437=
4 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107061297=
7 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107077197=
5 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 107092690=
9 index 3 namelen 49 name
> 7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3,
> no dir item, no dir index
> root 5 inode 13681648 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 9 namelen 2 name 08 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681653 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 10 namelen 2 name 09 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681658 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 11 namelen 2 name 10 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681663 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 12 namelen 2 name 11 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681668 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 13 namelen 2 name 12 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681673 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 14 namelen 2 name 13 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681678 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 15 namelen 2 name 14 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681683 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 16 namelen 2 name 15 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681688 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 17 namelen 2 name 16 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681693 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 18 namelen 2 name 17 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681698 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 19 namelen 2 name 18 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681703 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 20 namelen 2 name 19 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681708 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 21 namelen 2 name 20 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681713 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 22 namelen 2 name 21 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681718 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 23 namelen 2 name 22 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681723 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 24 namelen 2 name 23 filetype
> 2 errors 4, no inode ref
> root 5 inode 13681728 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 13681610 =
index 25 namelen 2 name 24 filetype
> 2 errors 4, no inode ref
> [............................. and many more
> ...............................]
> root 5 inode 1070274489 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 2608501 i=
ndex 86490 namelen 13 name
> _delete.11674 filetype 2 errors 4, no inode ref
> root 5 inode 1070433550 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 2608501 i=
ndex 86491 namelen 7 name daily.3
> filetype 2 errors 4, no inode ref
> root 5 inode 1070591907 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 2608501 i=
ndex 86492 namelen 7 name daily.2
> filetype 2 errors 4, no inode ref
> root 5 inode 1070750857 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 2608501 i=
ndex 86493 namelen 7 name daily.1
> filetype 2 errors 4, no inode ref
> root 5 inode 1070906109 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 2608501 i=
ndex 86494 namelen 7 name daily.0
> filetype 2 errors 4, no inode ref
> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/sda4
> UUID: f3789d71-6576-400f-b729-bd37173b592a
> found 1255738060800 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 10121838592
> total fs tree bytes: 9876291584
> total extent tree bytes: 243253248
> btree space waste bytes: 2333042844
> file data blocks allocated: 1244220567552
>  =C2=A0referenced 1244174794752
>
>
