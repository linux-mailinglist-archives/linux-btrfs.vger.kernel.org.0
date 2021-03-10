Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D8E33323B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 01:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCJASn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 19:18:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:60089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhCJASX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Mar 2021 19:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615335500;
        bh=2Alx6/D1eZaZ/mIFQ/jVk+hhq83QuiRQViOamnOIvN4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FZ/5SQVFppnfU/OWs0Bxl9Otd9m+2X9/2f4HqyOYaqFpg0l6N05y3i/IfUeJa52vJ
         STrSSA3blVdXTQeJTt7Wgs22b/klU29SANof1V3vgAnxMDGTuapvsM447CjxV0yRJk
         4+s6k2cRvk4gLGMVqIMYf0oObL1SZ0w9WEQCor50=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWics-1lDHEZ3qa8-00X0Be; Wed, 10
 Mar 2021 01:18:20 +0100
Subject: Re: [PATCH] btrfs-progs: output sectorsize related warning message
 into stdout
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210309073909.74043-1-wqu@suse.com>
 <20210309133325.GH7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <49c16359-3ce0-c021-608d-b05c9d4c1fda@gmx.com>
Date:   Wed, 10 Mar 2021 08:18:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309133325.GH7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9SUyfJB7fu5Yr87wHphLKh62WyvLiIe6R6Wk9dl197pOhGXm+GV
 lnEADU0bzdwtCeFxEDV2oRBc/Y2TRp6I5W/bPM6xEzFmFgtAZGg7oUYIHmTkkzgo67y9mBH
 ZTXDpRtJsJlXIYowhT9eySFs2P6W/8gXXTEqQnHJsJ71YiC9Sn8PpMVVRCRggkmMY78l7/6
 uS3Bw4tRHYDlaqJIp83/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kVu4BdKWQd8=:u2J14m0v4XNJwYDOP9xOwg
 1/XR2vV/f7ckbBlh9A27nqy9GhjaM37vRo/hPRhsaCLpi7xhpO2Wi5rv0IKeFzM2GkJT2X9SU
 XIj5KXM/6ipCUpdZYR5VcXRzGAD6956uNuLNw8IpN/KDh+lSwqEhEl/t2+uNcOOdLXj5p5vl/
 38SratkX2yJLC9Wb5XIvPmDe8C//UOvrK0ZIIsXjK9xzYwS99KUnbEpC+yoM8DIBiapax7lAf
 RqcuB99wgy4J1d/NAMPi9uBw+mao3ThYTrWnEE8ETlH4niagfQS61e6iXfkTkPvxlqzaDzkaf
 o6Tw7GDS7pvv9m+WYXhesydSrtCOZ/TmoG7k+nomG1Lcp3KmGPe/krW66xQyg0HxS/EW7ln+O
 boV088ZbzAergsJyiP2UPEEkkQ+8P8JxzF3hdKXio1Lww4bSGbcpBbTKC3uoK6hmzYXSlpUB3
 w564u8gwOwjMiHsjUFSupaiIdKmmXWoDMzdZTrNSKbtXoZh2mKmpjlGJ6ZWazkafMlJwGcXwV
 5GqaZ1q41qE3QkfErTRH8atlnu9MHkyoEgask9lXJRugrlA9r4lgZNgmMDkX6/Z3u1abIveqH
 /jYbmoIsaeGZA8Ifk2z802PRIVBOCy9+DRVfOn0DUxj6W7m9aEeJGVD7X33OYZqNYAWRF0P7E
 7G808pJ0b8gQgkZ3lF27Iison6b/Xg/ERmRW+n2gPiWyscCltnZb1zowiqz3JWODv7GilbksL
 KQZ7OBiM1jmVm1kvhILu/1q8pJPqn0wTQqQqmSjFd6h6bMy7DTwN9HypF+ySnQ7K87G04xn/C
 oMoPX801GNFvSAr2jgIERNo6mRLwJrBUKkbaKZlwTw3NBHjkWTmACo6eUHzkIQGblDdedGdAz
 nQpGTSHn3OsJ6QEcCEcg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/9 =E4=B8=8B=E5=8D=889:33, David Sterba wrote:
> On Tue, Mar 09, 2021 at 03:39:09PM +0800, Qu Wenruo wrote:
>> Since commit 90020a760584 ("btrfs-progs: mkfs: refactor how we handle
>> sectorsize override") we have extra warning message if the sectorsize o=
f
>> mkfs doesn't match page size.
>>
>> But this warning is show as stderr, which makes a lot of fstests cases
>> failure due to golden output mismatch.
>
> Well, no. Using message helpers in progs is what we want to do
> everywhere, working around fstests output matching design is fixing the
> problem in the wrong place. That this is fragile has been is known and
> I want to keep the liberty to adjust output in progs as users need, not
> as fstests require.

OK, then I guess the best way to fix the problem is to add sysfs
interface to export supported rw/ro sectorsize.

It shouldn't be that complex and would be small enough for next merge
window.

Thanks,
Qu
>
> I can compare two different approaches of testsuites, fstests vs
> btrfs-progs and I can say that the number of false positives on fstests
> side was much higher and actually making the whole testing experience
> much worse, up to ignoring test failures because they were not failures
> at all because the tests are not robust enoughh. In btrfs-progs there
> have been like 1 or 2 silent test breakages (unexpected pass) but that
> led to stronger checks of the expected or unexpected output.
>
