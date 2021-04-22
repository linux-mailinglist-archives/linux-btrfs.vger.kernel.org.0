Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89573676A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 02:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbhDVA6X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 20:58:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:45483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240973AbhDVA6W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 20:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619053062;
        bh=JAhHlMVSPbunNNnezwKSWgVTTdhQMfzeAHZL+Pq0w64=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XSl4cDasUxcpbJbEtlH/QElaudI027rw57HmekRQDoCec16kFh1YbThJhCy/ND5pW
         yZ2BuW0nHO5H9dPMFg7cWomc7AoA1ImOKuQNnBoatbH3UauRIly4FK8p6fFu59dRGM
         YCnJrOI2c0IzBzUpQj54s63+UIenpgWNFBE3sQ8o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOzOw-1lycif3kRo-00PQZf; Thu, 22
 Apr 2021 02:57:42 +0200
Subject: Re: 'ls /mnt/scratch/' freeze(deadlock?) when run xfstest(btrfs/232)
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <9b4400ca-d0a3-621d-591c-dc377d0bed58@gmx.com>
 <e8886729-6f82-eca9-d752-0e81145794fe@gmx.com>
 <20210422083231.755B.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <aa9ffab6-02cb-16a0-794c-80a990c4f999@gmx.com>
Date:   Thu, 22 Apr 2021 08:57:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210422083231.755B.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rNwB5G6roxuLsCNVonIczTNb2f6t61iW9gpYZ7PxOMVkxJSlfFG
 1/NUK5Xg06Xgn86OAA6RQDGQNUsWb5JG1u/WNKzZzSdOPXuHueKx3tX2VzNiMl7sQiOBkmf
 ONdxF6g8DvZFq87LoSXL2CZGFwc0CHWNNYISWHfinPWwVMrcYw7RMz6lzehOdDOVpYz0Yz/
 JqY9GSZJYGSaAolL0EbhA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ztTwt+jU7sQ=:zo0xt7MoF8Faek4ZpnNmlf
 ot4b9RacALQJ4Lu85h1Iy1REz053O7EIqeM3d/KIIg7gk1SRtDkhOw0ARe54lW+SgLfyEZp6C
 ZpmE1Qyot74YXzZ9Un7qfrr1csmTBWVnD+iHNseKchJJwIM0ZIDUnwixcmuDiZfeKAceoJMyP
 hv4JDu4ihPOD4thR+iYrch3/Le4EIJ1LEdCRbJvyrhIptw7zHxdXM42NSIkPdpQ9PAACgJtgx
 AwuHAQAFvEpvm2u4mRfHkIiL76RWvMIBxZF1vE7AR568sguvQMmCu5D/vunR8neqUgOSRvTLp
 KtUmdq9s/ZHfbU385mQWbUSB/zdcRDaSoyUW9oDrqZUhXVJXeJChfqbTguSitVVAj07WOmzwo
 D6H87ApLhE/DB4dlk/hiU4N14g8ta+DX1fiKnlUdBSmAntufUlKlymkQg3v6QA3R0nPRAy0En
 rTwp9R5XdQJbPIf/3nTZkKg4Zi4NR3Pjh7jgFOJRgLzxIxAjR5xGx7gQVmzHvs7kp/Ng2G85a
 fJYjl52WQ17emF3CtXlDGLXf7HxTojBzALbUV2WLJB9zLntAPqEVv3hLIOZckmwA+3xbHGd/X
 Yy++QIaIwmpufVp/zuA0dhkk5D2FsGCwCGOXMPiIAyh0fxmFug3k+gdnm3r8qETRgEE5fHv9B
 l8KBtXJYNf3N1xygnuwRCSGKWSKK7Q/3gXVbJWFXChwbyyezvv879vdsre0wPKcYMkGTywxrq
 CL3q1t0AlduEpGacX7i02g4oSVM7uqtzgdp5oo9+2AWniC2m/B1Q9LEX6kU7PA0HED+IAAC3q
 skarXnOxP76SmbhNo1GFiu2TzLvg8gqbeIRWDh310bLXGW3fT58HC7u2damgOHPMtm93cd95l
 LJf56AMYduM9HNw82LGGo6AJs8EXLZKa2MSmiL0uqkvTBjprjCReUk9tZkgD3863Ntqvb+fu0
 UK8pPizrfrEc3j4sg7ApfueL1uI4ut9+xDOABSxS2cgozlbLVyqvdeJjYrXVrv+G6annQd81Y
 8OyFxQ6iuH6sFqNgjndyaeJ/y3/Lk17bywBW5XLfruz7TbqC5eWR/cUb2L46wd3jZdMAFbVpA
 0ozhVWUuenWxrM6O0Zjn/Qkr/UbIUuzJToXz0OH778aqrzpIntzLbUyOqSnFT3siSQKrF/9SA
 6xrlGHGoUhTWLEkDc2vAr6xzyLJly6QIXu0AWzZdLrsZHWW+v316tMWnCgfx/h50oEv7JX+tt
 IU0tfxHpbLtPUK8rq
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/22 =E4=B8=8A=E5=8D=888:32, Wang Yugui wrote:
> Hi,
>
>>>>> we run xfstest on two server with this patch.
>>>>> one passed the tests.
>>>>> but one got a btrfs/232 error.
>>>>>
>>>>> btrfs/232 32s ... _check_btrfs_filesystem: filesystem on
>>>>> /dev/nvme0n1p1is inconsistent
>>>>> (see /usr/hpc-bio/xfstests/results//btrfs/232.full for details)
>>>>> ...
>>>>> [4/7] checking fs roots
>>>>> root 5 inode 337 errors 400, nbytes wrong
>>>>> ERROR: errors found in fs roots
>>>>
>>>> Ok, that's a different problem caused by something else.
>>>> It's possible to be due to the recent refactorings for preparation to
>>>> subpage block size.
>>>
>>> This error looks exactly what I have seen during subpage development.
>>> The subpage bug is caused by incorrect btrfs_invalidatepage() though,
>>> and not yet merged into misc-next anyway.
>>>
>>> I guess it's some error path not clearing extent states correctly, thu=
s
>>> leaving the inode nbytes accounting wrong.
>>>
>>> BTW, the new @in_reclaim_context parameter for start_delalloc_inodes()
>>> is already in misc-next:
>>> commit 3d45f221ce627d13e2e6ef3274f06750c84a6542
>>> Author: Filipe Manana <fdmanana@suse.com>
>>> Date:?? Wed Dec 2 11:55:58 2020 +0000
>>>
>>>   ?? btrfs: fix deadlock when cloning inline extent and low on free
>>> metadata space
>>>
>>> We only need to make btrfs_start_delalloc_snapshot() to accept the new
>>> parameter and pass in_reclaim_context =3D true for qgroup.
>>
>> Strangely, on my subpage branch, with new @in_reclaim_context parameter
>> added to btrfs_start_delalloc_snapshot(), I can't reproduce the nbytes
>> mismatch error in 32 runs loop.
>> I guess one of the refactor around ordered extents and invalidatepage
>> may fix the problem by accident.
>>
>> Mind to test my subpage branch
>> (https://github.com/adam900710/linux/tree/subpage) with the attached di=
ff?
>
> The attached diff( more in_reclaim_context) seems a replacement for
> https://pastebin.com/raw/U9GUZiEf (less in_reclaim_context).

The attached diff is for subpage branch, as misc-next already has the
parameter introduced for another bug.
Thus only a small part is needed for subpage branch.

>
> so I  will firstly test with the attached diff but drop
> https://pastebin.com/raw/U9GUZiEf.
>
> The test of whole subpage branch will be done later.

So far, I also tested the older misc-next branch, and unable to
reproduce the problem.
I guess some patch in misc-next has already solved the problem.

If possible it would be better to provide the branch you're on so that
we could do more tests to pin down the bug.

Thanks,
Qu

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/22
>
>
