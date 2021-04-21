Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAA3675A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 01:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243503AbhDUXU0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 19:20:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:56653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234867AbhDUXU0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 19:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619047186;
        bh=T6n2WTiFX0+N/g4Ec4NiWq/j8mjtpSm25z7IdEhthdw=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=CRGrAsvaNKli3D6xQa5ZMc3ouRoMnbKhNlmwvGrI+ygfxkVTeprYqjEW3Rf6RO6oP
         0f0nuNzTy5WizaLrz1Dk+kGVxIjPn35ZqCBcuWtZIxgzTdkjK/l6D+B3HroONlLjbB
         ybA6eaeaHnKDMJxonmjSmdp32pYuu4ZD7lKcxB7s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mzhj9-1lMLU82ojp-00vfFK; Thu, 22
 Apr 2021 01:19:46 +0200
To:     fdmanana@gmail.com, Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210421201725.577C.409509F4@e16-tech.com>
 <CAL3q7H6V+x_Pu=bxTFGsuZLHf2mh_DOcthJx7HCSYCL79rjzxw@mail.gmail.com>
 <20210421235733.9C11.409509F4@e16-tech.com>
 <CAL3q7H7j7eZ0r1xYJiQGr3+yuwnqkpbRoA3HxY=e8Ut8VDRCRA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: 'ls /mnt/scratch/' freeze(deadlock?) when run xfstest(btrfs/232)
Message-ID: <9b4400ca-d0a3-621d-591c-dc377d0bed58@gmx.com>
Date:   Thu, 22 Apr 2021 07:19:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7j7eZ0r1xYJiQGr3+yuwnqkpbRoA3HxY=e8Ut8VDRCRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eM9I+Qr4bFzIKS/q0tNAgpVvdIygjvoEaovJ3PceSrrtllnZg5X
 Xj4QheQUPHCi4ZPRgZzg+LeIbOFWrLYrl1JFtYVn5hP7FdvuDkdUr6d5vKE/s5Ypll07pkg
 qNyzdq4YxNyEhe23hNmJ5P+9/isw2M5GvRsOTt7JTdDnoFmU7i8oB35j4ibcDKTlC3oiTzK
 Xys6fB6+ba/dXtq3zpWcA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cPeW/CFg6LI=:S8H4/nkFQUpiD3xMTTitZQ
 J+27zNvt8zbNuBdTNkwMvQ1JNUE/MNWBPvfVngp01EzgHiTnIiGz0H6Ig2VOk8J03P7Gr+Pww
 BwCZw16XWdRBZsg8iX3+aLuewTdPU99hQ7Pna4vGsCM0eUw3nT9ysM6iDwA8TkzrOzJhBADNj
 4pTPqbuwDJVC8LFh+pj4T3v6XUVp5BkOCm8OF1g0W3gFlGBUdgYhs+k1cTZ10i7KyegIzVofy
 envJMxrlzSWaLAzmVhE2k5yABTvsnkkpT9lXDXWCgEdP2zmf132NlaWKeX0G0T5LaBteJEJBP
 MBJtqjO2A+QPndn4OJjjTvYKeqyjciBGwGC2F0HrxGVRpI4Hk15TjpRBqx08NsP947nIBdj2Q
 KeCvhg70saNeDO0GVORF+4gsBslUIfaJi76iwv573D9FX7dDbVfGAdNt26c3VWcHdg6tWwKri
 l6ntEq9CuowLiSoKSz8AZQVdS+L4vcjMo2XGzWm7LQdDwaBurerX+Q7ARb533FAg4BldPPtQF
 u4OuCNYWR2Njw7YRPK1wi+43oKQ+pJ0UHwkBjeyOugEQFWB8cMiyQNoT9AF2NXh/Gdh9yQV57
 u+GLgI/9Sdi2Xn+ENJTC5U9FT+vj5p4XcY7094fgoclo++uRFRud/549yAa9nxDGh/d1QyNiX
 hrwL38M25RvkcBhEw4+PW18ltAW8l9BCb+aoEgzSPADMzVUWKo7cMtS++CAKomXtIyTwWLsZn
 Fy7YcTYCqQ71Pb8821Z6fr69VuG1AWUQY8Ot2sXALuTWEM47P9rnzyLoShZC/wSr8rvBrTZv2
 u5NbajOOnAzjkxTrr1yiY+POVuEuc3lPclRBqFRF3ZC2uGkRfNCGbQJ6a4Tml1pdUypgCg5nv
 w9ft+UBZ8BWAwmlRIe9o0Y12ZCkVB9rl0jFCyZxPzV2Yj2B1T2/w6vllsziLwQg0vJX8q0rGz
 mlWegW9UhXsLCj+ULKtytfkRrXLDQu3f8WIsJXzKkPdYyNUfwvQeO4loivifNk5b+afKeJw0w
 DQ6eerhsS4ttFULdm1C2jW5nP7fIdZERXTNIl7x11d5BC7Q9kwCFgf+a0B2icjN4KV8ftS3Hl
 ffiWfdcg6JCUnKF9fF9ooHdI4HUkb9xPBBEYusU+Kl9sk5utpxhMTjNoWV9uyHX9rki7qx5t2
 7hv3ArtWgOVCHNxs7mVuzC49aVsx17bBA8evZvzCYlMt0YBO8ZNFtcVjos+gaML5d2aOVznv1
 6BFOgbAtoc4ElJ32f
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/22 =E4=B8=8A=E5=8D=8812:03, Filipe Manana wrote:
> On Wed, Apr 21, 2021 at 4:57 PM Wang Yugui <wangyugui@e16-tech.com> wrot=
e:
>>
>> Hi,
>>
>>> That's the problem, qgroup flushing triggers writeback for an inode
>>> for which we have a page dirtied and locked.
>>> This should fix it:  https://pastebin.com/raw/U9GUZiEf
>>>
>>> Try it out and I'll write a changelog later.
>>> Thanks.
>>
>> we run xfstest on two server with this patch.
>> one passed the tests.
>> but one got a btrfs/232 error.
>>
>> btrfs/232 32s ... _check_btrfs_filesystem: filesystem on /dev/nvme0n1p1=
 is inconsistent
>> (see /usr/hpc-bio/xfstests/results//btrfs/232.full for details)
>> ...
>> [4/7] checking fs roots
>> root 5 inode 337 errors 400, nbytes wrong
>> ERROR: errors found in fs roots
>
> Ok, that's a different problem caused by something else.
> It's possible to be due to the recent refactorings for preparation to
> subpage block size.

This error looks exactly what I have seen during subpage development.
The subpage bug is caused by incorrect btrfs_invalidatepage() though,
and not yet merged into misc-next anyway.

I guess it's some error path not clearing extent states correctly, thus
leaving the inode nbytes accounting wrong.

BTW, the new @in_reclaim_context parameter for start_delalloc_inodes()
is already in misc-next:
commit 3d45f221ce627d13e2e6ef3274f06750c84a6542
Author: Filipe Manana <fdmanana@suse.com>
Date:   Wed Dec 2 11:55:58 2020 +0000

     btrfs: fix deadlock when cloning inline extent and low on free
metadata space

We only need to make btrfs_start_delalloc_snapshot() to accept the new
parameter and pass in_reclaim_context =3D true for qgroup.

Thanks,
Qu
>
> Will try to look into that later.
>
> Thanks.
>
>> ...
>>
>> Best Regards
>> Wang Yugui (wangyugui@e16-tech.com)
>> 2021/04/21
>>
>
>
