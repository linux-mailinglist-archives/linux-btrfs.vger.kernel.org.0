Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4246D361603
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 01:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbhDOXTg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 19:19:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:37667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234735AbhDOXTg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 19:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618528745;
        bh=4GqjWLhgiRRLHApp79wCojDhranRbdYnsGgWQC7voMk=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=XGvKvGk7qLYB1jJZgpBAhetc2XxaFEtUJ7dNTO+5+NmKBdte2Wn5P373czhppbTf4
         xA/gRm+uHyz3Zx7Q0jxnZLqLR/CiHuduilbzVWPBzJqF7j9QQkFpHwwluSX2hPIqdF
         cKOkddCM6/yeUfWSMj1yASecy+VTzTkVV1nrPbF8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvbFs-1lqEFa20SE-00scR7; Fri, 16
 Apr 2021 01:19:05 +0200
To:     riteshh <riteshh@linux.ibm.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
 <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
 <20210328200246.xz23dz5iba2qet7v@riteshh-domain>
 <12dca606-1895-90e0-8b48-6f4ccf8a8a27@gmx.com>
 <20210402083323.u6o3laynn4qcxlq2@riteshh-domain>
 <f1acd25b-c0b6-31b4-f40b-32b44ba9ce4c@gmx.com>
 <20210402084652.b7a4mj2mntxu2xi5@riteshh-domain>
 <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
 <ef2bab00-32ec-9228-9920-c44c2d166654@gmx.com>
 <20210415034444.3fg5j337ee6rvdps@riteshh-domain>
 <20210415145207.y4n3km5a2pawdeb4@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <8bdb27e4-af63-653c-98e5-e6ffa4eee667@gmx.com>
Date:   Fri, 16 Apr 2021 07:19:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415145207.y4n3km5a2pawdeb4@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s6vHQ5rFTpomdE3dVWNLoeCV788GHZ8JhfJQPue+kJf1JOHH1YZ
 G0FbptyXQLycJOruwQeV0yCGK+iQ0TF7iAx6KmJ1jXZh5XRiyqcds+Ed8ipxD2fLy6PzzMi
 enVDnm33dlhM6Z/Qvxv676vq/Ga9GsVe7M9TlSMOTukwxMczrvhMFJ0mSbjBjAm9EOX+uu7
 k+OleqJjOFsKuR2TnDKNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YDZTHPQHyOw=:93bnY6FNejnKhnLS9Yvd4u
 zjgJywPKg//6gxu1mm/OLs6wR5u3N7SjJEO6EKWI3YDvmUi45i3N+DS1CNt+EzQzYADwqxFmK
 1LHHXVv/es3mmlqF950OC/D4EfyQKZW9h+hcWA1xO3xkE/i+dw/CXldogYknsA47pv5b41Oqr
 ZrNjzAiXDWM6ChbTUksUDYqUVNXPmMv8wxCF8AhxDxgeEjys441tkf/VU0eQGVLVgkio7lA4f
 YHI86Ud6Kqd+6b5vY2oxQSJvw2/simmWGLIeb9fK/LoC+Bu/smMngxIZfRvs/1vYya2buF7Kv
 9rxfgCPf45dL0F3RlbYMl+W9QpW3RNgL0LcUdyvAerYwftajH3yMeATmUyFROU/danLIeVf/4
 A5BA2zmdUtSbcfL3sMwqiI9B2e/T8BSO3n/rrJY5aS7zR11WwyrEVbuA5FRs3YTtCYZJyi9uA
 qwchSBpqSi3eGGSdSep5HGqxTJzd2gfuFb5hpQou9iFN08JCmltjRTaMMCVqEeWRdORiM59RQ
 xvvtoZPldAWoFZv1fBENTBlrYwnJ66CDr5Rk+4WIjS3vONyt6/2TwdhvrPMs5nJKDIteWOuNP
 iyoo08LRTGO3+lilm/Htk0b4GWFrH/RdDUGqjMshWdnqwKomnUBcLS47wdVTWbDGHqLs0pMzF
 EXbsGT/oNCMgulz+Zxes/bCMr/ObTbIiSg1qEWfB+yUryTG9JCEaXjmyW7/9CafhKUU3FkTA6
 rstVAwjhiAe4xO4hzwGc+djXvHqDBODFVRxd9b8cMV+zAj1tWiAm6XdnusNv7DCGn8SGycKYv
 x950GKyp0yI8ZzWP3Ox0Mi/TktgLq24+9KG+5YodlTKu8vpRp+FER2vuH17RLX9nVOcg9si9x
 v+n/QBEppKCy3+pb+ZeIhxekLebGED1do+Jm7kUMcTL90PiofP3n4eBpAA9DmvuwR2L7U2CM/
 TUkLxD4Va40pdFY5aNn+1F+MyPIhOsrzaFHg3NBSaOj3c8UES5fkioJk9/jrgg/9PLFLFScKe
 J6DlfcHY+KO8Qv9hjshPHynu6a1XRBruJrUviV7x3I+tmpY8MjSPfj+ijlF9/D+H/va5vn7B9
 G2UWbShUdwsZYLlw9PpIGlYkh1IjL/2N3ODofmUaXO+FQxTZXVbUNcHa92iAXkOzQUJNKG1BL
 4lmNoZH2uHagCYLNld2+gQaVoLaeSaIkMpL3v6PUqh33ejNQlBRMQMv/qED09xr5KZG2ku2xy
 ddF1tfCecJWPQyCml
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/15 =E4=B8=8B=E5=8D=8810:52, riteshh wrote:
> On 21/04/15 09:14AM, riteshh wrote:
>> On 21/04/12 07:33PM, Qu Wenruo wrote:
>>> Good news, you can fetch the subpage branch for better test results.
>>>
>>> Now the branch should pass all generic tests, except defrag and known
>>> failures.
>>> And no more random crash during the tests.
>>
>> Thanks, let me test it on PPC64 box.
>
> I do see some failures remaining with the patch series.
> However the one which is blocking my testing is the tests/generic/095
> I see kernel BUG hitting with below signature.

That's pretty different from my tests.

As I haven't seen such BUG_ON() for a while.


>
> Please let me know if this a known failure?
>
> <xfstests config>
> #:~/work-tools/xfstests$ sudo ./check -g auto
> SECTION       -- btrfs_4k
> FSTYP         -- btrfs
> PLATFORM      -- Linux/ppc64le qemu 5.12.0-rc7-02316-g3490dae50c0 #73 SM=
P Thu Apr 15 07:29:23 CDT 2021
> MKFS_OPTIONS  -- -f -s 4096 -n 4096 /dev/loop3

I see you're using -n 4096, not the default -n 16K, let me see if I can
reproduce that.

But from the backtrace, it doesn't look like the case,
as it happens for data path, which means it's only related to sectorsize.

> MOUNT_OPTIONS -- /dev/loop3 /mnt1/scratch
>
>
> <kernel logs>
> [ 6057.560580] BTRFS warning (device loop3): read-write for sector size =
4096 with page size 65536 is experimental
> [ 6057.861383] run fstests generic/095 at 2021-04-15 14:12:10
> [ 6058.345127] BTRFS info (device loop2): disk space caching is enabled
> [ 6058.348910] BTRFS info (device loop2): has skinny extents
> [ 6058.351930] BTRFS warning (device loop2): read-write for sector size =
4096 with page size 65536 is experimental
> [ 6059.896382] BTRFS: device fsid 43ec9cdf-c124-4460-ad93-933bfd5ddbbd d=
evid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (739641)
> [ 6060.225107] BTRFS info (device loop3): disk space caching is enabled
> [ 6060.226213] BTRFS info (device loop3): has skinny extents
> [ 6060.227084] BTRFS warning (device loop3): read-write for sector size =
4096 with page size 65536 is experimental
> [ 6060.234537] BTRFS info (device loop3): checking UUID tree
> [ 6061.375902] assertion failed: PagePrivate(page) && page->private, in =
fs/btrfs/subpage.c:171
> [ 6061.378296] ------------[ cut here ]------------
> [ 6061.379422] kernel BUG at fs/btrfs/ctree.h:3403!
> cpu 0x5: Vector: 700 (Program Check) at [c0000000260d7490]
>      pc: c000000000a9370c: assertfail.constprop.11+0x34/0x48
>      lr: c000000000a93708: assertfail.constprop.11+0x30/0x48
>      sp: c0000000260d7730
>     msr: 800000000282b033
>    current =3D 0xc0000000260c0080
>    paca    =3D 0xc00000003fff8a00   irqmask: 0x03   irq_happened: 0x01
>      pid   =3D 739712, comm =3D fio
> kernel BUG at fs/btrfs/ctree.h:3403!
> Linux version 5.12.0-rc7-02316-g3490dae50c0 (riteshh@xxxx) (gcc (Ubuntu =
8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 2.30) #73 SM=
P Thu Apr 15 07:29:23 CDT 2021
> enter ? for help
> [c0000000260d7790] c000000000a90280 btrfs_subpage_assert.isra.9+0x70/0x1=
10
> [c0000000260d77b0] c000000000a91064 btrfs_subpage_set_uptodate+0x54/0x11=
0
> [c0000000260d7800] c0000000009c6d0c btrfs_dirty_pages+0x1bc/0x2c0

This is very strange.
As in btrfs_dirty_pages(), the pages passed in are already prepared by
prepare_pages(), which means all of them should have Private set.

Can you reproduce the bug reliable?

BTW, are using running the latest branch, with this commit at top?

commit 3490dae50c01cec04364e5288f43ae9ac9eca2c9
Author: Qu Wenruo <wqu@suse.com>
Date:   Mon Feb 22 14:19:38 2021 +0800

     btrfs: allow read-write for 4K sectorsize on 64K page size systems

As I was updating the patchset until the last minute.

Thanks,
Qu

> [c0000000260d7880] c0000000009c7298 btrfs_buffered_write+0x488/0x7f0
> [c0000000260d79d0] c0000000009cbeb4 btrfs_file_write_iter+0x314/0x520
> [c0000000260d7a50] c00000000055fd84 do_iter_readv_writev+0x1b4/0x260
> [c0000000260d7ac0] c00000000056114c do_iter_write+0xdc/0x2c0
> [c0000000260d7b10] c0000000005c2d2c iter_file_splice_write+0x2ec/0x510
> [c0000000260d7c30] c0000000005c1ba0 do_splice_from+0x50/0x70
> [c0000000260d7c50] c0000000005c37e8 do_splice+0x5a8/0x910
> [c0000000260d7cd0] c0000000005c3ce0 sys_splice+0x190/0x300
> [c0000000260d7d60] c000000000039ba4 system_call_exception+0x384/0x3d0
> [c0000000260d7e10] c00000000000d45c system_call_common+0xec/0x278
> --- Exception: c00 (System Call) at 00007ffff72ef170
>
>
> -ritesh
>
