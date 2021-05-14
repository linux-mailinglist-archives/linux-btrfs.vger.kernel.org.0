Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73537380AB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 15:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhENNvT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 09:51:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:51987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhENNvS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 09:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621000204;
        bh=JvvlyzK33cmYSJc0W1n47BjlBXm6oo1iCFHL4L1lpaM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HVFTgE6bDkDz4aQZ6FQhUsvOPD9VInvwba3yp1hVgbneW05eRVZERFrW2hqHOPDB/
         YLHeUOL9XP2WRfw+n15BRyFWGGm7oR9qtBjaOJxEcpzGp+JZSY91yglpv/yRz4AJbC
         YYQRLGtgn3OiiehRg9pg7kH/Sr4mfj3hQR88A1/A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt79F-1lNy7B0EVF-00tSoh; Fri, 14
 May 2021 15:50:04 +0200
Subject: Re: [PATCH] btrfs-progs: do not BUG_ON if btrfs_add_to_fsid succeeded
 to write superblock
To:     Su Yue <l@damenly.su>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <20210511042501.900731-1-l@damenly.su>
 <20210512140135.GR7604@twin.jikos.cz> <k0o3lb1d.fsf@damenly.su>
 <20210514112243.GT7604@suse.cz> <eee9l9iy.fsf@damenly.su>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <347443f7-b26c-04ac-88c2-2d1e490b7115@gmx.com>
Date:   Fri, 14 May 2021 21:50:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <eee9l9iy.fsf@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1MASoc/blUHhHkKoZEof53AYQUXK4xGROxGyDu38GLji8E+hsyL
 06RQ5CMRS67hlhZJEdH13SyyznI6O+deun3cNDbY4c/G2i9HDm8W7+vEOTJxHLj3DwiWje3
 8bZW1I5nzycISYWfPKHtrbU5gdfYg0n0QXmC5Tj3DHWbV3A+4MrSd35RftIPvo//0WBaoUq
 YPTwS9shZi5FfLJYwwKgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bzLDI1onf8c=:LhMiSNTEQVWzBjRe/t1dHq
 McmN+afqYkZsKwxKI8juuW3AP59BfYX/9tfp/eBfN8UWfCy69L2P/YKyQBO/YidLJO3NUK8n8
 vvD1FCRRyn3Z80X/FWv6bntBsiBIj9QnHoE+7jyzmeEkAm8fRn2VR2p4Zh03ojf+siirUnodq
 fZpGnAhw5nnxPvWjpCCiyRCE060+9qAP3/MAHc13W3ELhlAsLFCftbYPuBbgj29PYX/E2j+n1
 svlYKatebEguGJjLPXc/Dmn+CwcCaxFxOei6gJ95CZxM8JJrGLYXqNEYK41eNOpnXREjGR27p
 aiFnhsz14x0ZvBYTCBEzRMEAD6yw9h1ODf5WFRnbCUGOYJrznlO1gfVPT/WNEow9iPbDq8OOR
 8VYQsDCxs5R/NSHC6uQDQXF3heEaAj+gz24yZMMi5QZzSvEeo67wSAP/PDMtLBdRDv2Y2AFdd
 EBcDTZ8qgWxh21RP37kMuFMGR3rEv8sQtvINzbYqApQJcHnp3cwmJ3gBHX80GJYAtZJScWkEK
 Mz8GUkw3If7raUCwU6BVqwQEQ5yK00ZNyNrcdGmCAlL07p3Dnm3MzzBGFpkdyyWY2MSuwclF8
 88XIH2Aitcuqn878vhJScoXKARQkPrpzE1sbrugtdKT+4oPRAdu0ojK658P23ZKgvHvDebqxl
 Tun2POQdMfrqFZsql6SWU0V8Xa04ZIvngjqerArA7G3BK0DAATdT3gBgP+uonZR/9+v66ZHW9
 Pk921lkpLVbIMXh77V2Fy4rqkZchICoaBGp8Ut798/20wcFuQ5/K9cZAfGsiXvfcNHXpbYCFh
 yGi1c6mBDoudIF/o3y3gnP1Zo/04aZL5iU6Aw5cHnTMNeSV6OYdWfp0wbVdcQCML5NTGPzEJs
 baXZrMZub5a4ch75qhHkR+eKxbJiqjwpEpIPy+cVomXIyjb87a1uVZs+PtQHlljyJY1z56bGV
 RskytKH798pw5l0AiYkZgkCLNb7c5kmgABXIG7m6FQu7SJ5vN7k8jfK6VktCuX72hgu4H7ZcJ
 1LPNLiUAJKmqR8vzxmYFx3Fy9FaWD+TgOxRWZAOjQZwc7M5iKyaChXCoAs1rZ1f+SrydOKarn
 ButWJ1nFOLGBARr3QfmMxhNSpNlL4FePGWkGRy0G0HqYsSlQFtUp9zA7tBw3rar4lk4KUfvUq
 mLkmR5fZecEg/yDIwqvPtzMmMWLnEAYjkmjdDtcKyTeoX++eG3meXpmPlWDHPpWjyH+cyQ3Za
 nLxLNP7uDX/bPdKy1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/14 =E4=B8=8B=E5=8D=889:23, Su Yue wrote:
>
> On Fri 14 May 2021 at 19:22, David Sterba <dsterba@suse.cz> wrote:
>
>> On Thu, May 13, 2021 at 08:37:29AM +0800, Su Yue wrote:
>>>
>>> On Wed 12 May 2021 at 22:01, David Sterba <dsterba@suse.cz> wrote:
>>>
>>> > On Tue, May 11, 2021 at 12:25:01PM +0800, Su Yue wrote:
>>> >> Commit 8ef9313cf298 ("btrfs-progs: zoned: implement
>>> >> log-structured
>>> >> superblock") changed to write BTRFS_SUPER_INFO_SIZE bytes to
>>> >> device.
>>> >> The before num of bytes to be written is sectorsize.
>>> >> It causes mkfs.btrfs failed on my 16k pagesize kvm:
>>> >
>>> > What architecture is that?
>>> >
>>> The host chip is Apple m1 so it's arm64 but only supporting 16k and 4k
>>> pagesize. Since btrfs subpage work cares 64k pagesize for now, I
>>> usually run xfstests with 16k pagesize and 16k sectorsize. So far, so
>>> good.
>>
>> Interesting, what's the distro? I haven't found one that would be
>> pre-built with 16k pages so I assume it's built from scratch. Among all
>>
>
> Right, I initially booted the kvm using Ubuntu kernel built with 4k
> pages then compiled 16k pagesize kernel manully.

Are you sure it's really no 64K page support?

For example, maybe it's the fault of the VM UEFI you're using doesn't
support 64K page size?

Thanks,
Qu
>
> --
> Su
>> the page sizes we've seen so far 4k is almost everywhere, 64k is ppc an=
d
>> arm (both native), and sparc has 8k. 16k is a new one, though I don't
>> think it would catch something we haven't seen so far it adds a bit to
>> the CPU capabilities coverage.
>>
>
