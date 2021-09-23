Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A198F415AFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 11:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbhIWJdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 05:33:43 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:51364 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbhIWJdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 05:33:39 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 4A53D9B817; Thu, 23 Sep 2021 10:32:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1632389526;
        bh=JcmyUrGtNxRsgWNuoygIYrFOeiNZKKY6s0eIjBIiXqg=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=ikFrV7cHJQwO7WITVr+P8MuS5nVSd/AyYSpXS1/uyzTyXVHs7zKpxtoKtVDLK5WEO
         33uGB2BvbFxcKsEtXBofMXqImviIjbHnjmW5Urovjf5yJWsv9ArFNuPDogbML6M548
         z8icKDhjIduXGP50tTMe9xSiYF8ojdpfbAmgid1P10NKJGjeIWPWdbSUXz48oXYmPp
         uTc9XfgcpkCUAsufTVmeHe6IIND7L2JEkx9/Ls6ZYeHEM1C2EpOcKbo+NOnJjio3GR
         AK+13+0p6AvzbQKJxJUf91kCqjC9jTYwE5dI/EkvJ634nmfr1Uji4v3vuN7dJXODsf
         rP9Ovk3n9gg4A==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-4.9 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 6956B9B730;
        Thu, 23 Sep 2021 10:27:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1632389225;
        bh=JcmyUrGtNxRsgWNuoygIYrFOeiNZKKY6s0eIjBIiXqg=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=yVPQ0os8JkhX7a0oFK+ROB27Dl+yjg2JJ8YqgHDbP41n5ZOo9e0n4B6ivZhsBXs2L
         xhTKQdO1EDfbt/PcVWPYk7sQ6TSB4MtGmbT2Zvyf0el7GL8gbGHP/kc9WgPXjnQMCe
         8cXnQDOeTA2jXgwIrJK6Nfk4WgT1Jj8be+dw+tO4qPv+vUyBG8a8nUjCR35aGjLw/r
         TZavUiiKzXIJH2++bHzGY8CYkTcLix34uR+xLSfC+GNae3vYTfIUak75FuuS+6M4HV
         txmgT89/XBd36mckm2dezzvI6KbvacRNX10SvuTpueyDFbbcoNlhAXSRbU1LWlYqwM
         j5QgozgSunuSQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id F35222A0F4F;
        Thu, 23 Sep 2021 10:27:04 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Yuxuan Shui <yshuiv7@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com>
 <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
Subject: Re: btrfs receive fails with "failed to clone extents"
Message-ID: <f6be0b00-4551-037d-2f3e-e0e5913c51d3@cobb.uk.net>
Date:   Thu, 23 Sep 2021 10:27:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/09/2021 02:34, Yuxuan Shui wrote:
> Hi,
> 
> On Thu, Sep 23, 2021 at 12:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2021/9/23 03:37, Yuxuan Shui wrote:
>>> Hi,
>>>
>>> The problem is as the title states. Relevant logs from `btrfs receive -vvv`:
>>>
>>>    mkfile o119493905-1537066-0
>>>    rename o119493905-1537066-0 ->
>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
>>>    utimes shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include
>>>    clone shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
>>> - source=shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
>>> source offset=0 offset=0 length=131072
>>>    ERROR: failed to clone extents to
>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h:
>>> Invalid argument
>>>
>>> stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h,
>>> on the receiving end:
>>>
>>>    File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
>>>    Size: 145904 Blocks: 288 IO Block: 4096 regular file
>>>
>>> Looks to me the range of clone is within the boundary of the source
>>> file. Not sure why this failed?
>>
>> The most common reason is, you have changed the parent subvolume from RO
>> to RW, and modified the parent subvolume, then converted it back to RO.
> 
> This is 100% not the case. I created these snapshots as RO right
> before sending, and definitely haven't
> changed them to RW ever.

The problem isn't with the snapshots on the sending side, it is with the
snapshots on the receiving side. Are you certain the snapshot on the
receiving end has not been touched in any way (in particular, never been
set to "RW" at any time)?

Graham
