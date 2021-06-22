Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E723B0340
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFVLxB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 07:53:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:33827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhFVLxB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 07:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624362642;
        bh=jVb+8g0nF2nJ2UnRN0rFgwGfwvj3YuQWBQx+xUxG1NA=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=HgecdVksQSonmodYDNAUeTiTy6sW1m55HyD5UAhGhC+01KSVvIwsru8wGXo11E+Go
         tBa/MAqlrrS800WvDIuECQTX3L2pf567SS2rmCyTkNqEU3pSDq72b3cvzwpQl2SAQR
         1NIb4EYczuS1f0W+L997kgvXtw0RIGMwGtR6eepI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuDXz-1l7fXY45r3-00ucK4; Tue, 22
 Jun 2021 13:50:42 +0200
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210617051450.206704-1-wqu@suse.com>
 <20210617164703.GW28158@twin.jikos.cz>
 <d184445f-a1a1-3f17-c33d-ffe3fc066c66@gmx.com>
 <20210622111403.GF28158@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v4 0/9] btrfs: compression: refactor and enhancement
 preparing for subpage compression support
Message-ID: <ae3df571-4eeb-d046-6a90-ac67158d4067@gmx.com>
Date:   Tue, 22 Jun 2021 19:50:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622111403.GF28158@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1y4/WFs3kc0vmxsF8LSh0ljZKjX381A21bwUO3jP0FaJkvtnh95
 F2XmoCzjZ+rIB9g8DXJjfx99PTGWMSTCOpYn6REW/YkzIZTIymYMMmds4N+HZlAVBmSSHC1
 qfi3dWXFLVmJpx5NwlO+g6RvfV3T6DJGxAaBcRbNYTyBVnPgFrCIe+EIspqijrnlU6CYsEo
 egRikvcvZnH01tbkS0X4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zh2rCr4fLx8=:7apkXVFyQqHXNw/l9OOjJN
 lHLU4CLyaOeaIIwUhpGzRKua3KeAxmojsDHcD/yJSsV8UBBe69CKxEN9eOGvz/Y8a6lGvVvtx
 vMjqCULEBjljD2Q/+TQYYXyAVCtBMikiCu8PPifksriqD0yV2KECdp0yUUxs9nv/yVHA/20vP
 w1cLtvz7HKyUBy1iy5CG9MSwK5qAMV+nqGHdXOuqVkm+ZoMIOTUaQq5vK1PXMAmd8SeBSq46S
 ZkusaujkNSDw+43Orr5VNwVuyPiY6jmpZPE15uc5ECgGs/TmeU0urgMss/ArLMlvnXWCrRMif
 s7C9Mm7S9TWljnt9tyU/guD8TNbLZdtsghgKwqN3lLOfpgLf/JHvbaNFdxeFyVgfkvtXQVlqA
 +RCwfDvqOFBbEDCJa3Os8NS4l5qKRIOVdqTVKCkw7eKNyFQX2y7R6kCeZtpPm1HFKEclMrpir
 nFqf14e5YqKOrGm4zpOG5d0W9fejWHHlNgGhiXKIXLbr/fqpxvzYkI+bCBZNM5CXMC8EEu7b8
 010UHfLRfnwFnU4VXrlzKgR5f5EeO0m6KY9EI/6zmWUqeGA4EdZBO/OO6hNkgtNGQLb39GMVQ
 RnXGoNUvvosLXT6O081tL27zMYL/kV32Yrlo8/I3eJyuPPxsWFhFue4hZ6M4Ogn9M6t+H/1Sb
 cvSLSmr9TdKI5vZoOraLEqkm0CLZ+1x9UJVGUZ6AX4E4daNwrWV9T/1vpyEZPJadmLSLarizp
 z7PPGRVp1CUTZXNw6H/CpNj1lhszN2qjZqTVPc4uYfcC0eTW8OpcCqMPOmsVwxK7/IG/hJZOB
 Os8sW72quazIoVudDZ/lyGuyIWNK3Yn2iRvE+T48eZqT5QcvIESDEiCp32fyUVx8lz1cIkiwu
 B85WvkLmDewfNZAoaRjOSTK6HTofbN5lNF3vt2vUwTSsBZf+Sa0w1Z8mhtkroHMKXJiybYYY3
 FKkf1JMwi+kh0/12Pfx3STGlkdrPhalwEy0ZOcH/+xjaT+MOfrkawPK/FB8H5VeFncavEKzQH
 s+6jKo38tmw685jdbrD0pnpMir8wggwBTO36Xb2k71kgXyLgph+CQRNBx1VZg459rAsIKvqgw
 UTmXZk7jKg1LDcM8R/iWty3WiKeuP6YFcAi43z6VzjxhoDuaQZbTk/RwA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/22 =E4=B8=8B=E5=8D=887:14, David Sterba wrote:
> On Fri, Jun 18, 2021 at 06:46:51AM +0800, Qu Wenruo wrote:
>>> I went through it several times, the changes are scary, but the overal=
l
>>> direction is IMHO the right one, not to say it's fixing the difficult
>>> BUG_ONs.
>>>
>>> I'll put it to for-next once it passes a few rounds of fstests. Taking
>>> it to 5.14 could be risky if we don't have enough review and testing,
>>> time is almost up before the code freeze.
>>>
>> Please don't put it into 5.14.
>>
>> It's really a preparation for subpage compression support.
>> However we don't even have subpage queued for v5.14, thus I'm not in a
>> hurry.
>
> Ok, no problem. As merge window is close I'll keep the compression and
> subpage out of for-next until rc1 is out, the timestamped for-next
> snapshots branches could contain it so we can start testing.
>
Sounds great.

Although the biggest challenge for testing is the hardware.

I guess even with subpage merged into upstream in v5.14, it won't really
get many tests from real world, unlike x86_64 that every guys in the
mail list is testing on.

Although we have cheap ARM SoC boards in recent days, there aren't
really much good candidates for us to utilize.

Either they don't have fast enough CPUs (2x 2GHz+ A72 or more) or don't
have even a single PCIe lane for NVME, or don't have good enough
upstream kernel support.

So far RPI CM4 would be a pretty good candidate, and I'm already using
it, but without overclocking and good heatsink, its CPU can be a little
bit slow, and the PCIe2.0 x1 lane is far from enough.

But I totally understand how difficult it could be for even kernel
developers to setup all the small things up.

Like TTY, libvirt, edk2 firmware for VM, RPI specific boot sequence etc.

Thus even subpage get merged, I still think we need way more rounds of
upstream release to really get some feedback.

Thanks,
Qu
