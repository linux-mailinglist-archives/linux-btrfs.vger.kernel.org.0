Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B24E3F1A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 14:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiCVNGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 09:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiCVNGq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 09:06:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9511080205
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 06:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647954315;
        bh=vEwbb4YZpTeJ5+ZtxKN4Kaiv2kaPVgSiZHcAOF8zG9w=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=LiNDUCI51xBFsDDgFqkeFuduPyx2jpezcHzrftYSE9lQrurzgglRWuNl48J4l5bgq
         K4YRkgcbTcpzxxVXDDOeSZD14p33zM8r8QdVOjm2D78biUsI8HJ3DMQrCS2547BKIv
         iEccIqCYtbUl1HHo+nb3UjVM/g4qltgNoDsZe8RY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mxm3Q-1oIIq41i50-00zJPf; Tue, 22
 Mar 2022 14:05:15 +0100
Message-ID: <f1159186-c73d-5102-549d-8e343f1bca0d@gmx.com>
Date:   Tue, 22 Mar 2022 21:05:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: failed to read block groups: Input/output error; bad tree block -
 bytenr mismatch;
Content-Language: en-US
To:     Joseph Spagnol <joseph.spagnol@programmer.net>,
        linux-btrfs@vger.kernel.org
References: <trinity-58cb51fa-9b3e-4fd0-9ff7-29da0dd13e14-1647953588232@3c-app-mailcom-lxa08>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <trinity-58cb51fa-9b3e-4fd0-9ff7-29da0dd13e14-1647953588232@3c-app-mailcom-lxa08>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sPpBt2tIkqrTeWX+0eWhO+fubf91ywl5vFHDbzbGarNr4/2ZxPB
 iCwzTSeXtQVJ7kUq2aAc+cvi42k5IPwk3YZ9ptMfjDwAJzJl3EbwXxNF+gqhCKCBl/hkyZ2
 Hkt9MPil0pzHJxZVBKEMgCqS4nZTe0FfIFA6CjCd5UxNuPrt5ZHZidJ+rRDvwLfK+X2hfRZ
 WUxushIORLM+4/CScQDyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7h6v9Q8D2+Q=:P/kYUonMvi+peyYxtwgA3F
 Ws882ncxFQPb3Ahj3oDjPUDUVy353WJskWwmIQ1Zftn6Mwm6atFHBZsUG1uGudI2c6RCNy1q/
 2YestO7XJK3EGMUd/4NrPAoYX6/s5GOkZjylC6kkQYEpCjKRjS6Dx9dwtqdii7Xw389q1k/J0
 /vVq9AiqLwNbHj6Xd24rjrFpsrF2HQOQUExpHEe7awj+fd4sdLDcmLCvXDI/y5U0RT9x5eXxi
 XB6xSnxPx3CtgF7kgpmg0QoxrtObbg4KnRNIop4/bMC7YZhECfSedlRJie+RRpMyTO1yC1vGQ
 lB7XXKEnu/tP0oJacp7bY5yaM5QtkLN5a2g81GQnWn8xyKll+paGUI7GoHOZxXQVFrn+raLdg
 kBc0lxrATxdTR1noXwqEdFvbgrsK8hzSzogG9pOsbmFGeih317LLOgUUB5jIAbN4FGFa2pLSJ
 5/Bvz5pZGyuVuWzYw281qhta2Q/LwqkJ2gCPRftKH5Aq/U2UkNrmZcdgkqiCYrCmS/aUYVPNq
 ztMXN0LymhHNV89rVucAHqBc3SqMW1T4VGRSWQSViuMORipsb18EV7hPVowfabqfFDzQGXHDD
 HcNvrqlWUWdKmphlBmRhzKOkW6ocz3WBTGBBHrWhmLbpTdNgfcKqo7roueB7P0cKgM0RrKv+C
 rU6OadJr980BZkEvVt0umwYoSKhzvbjUcFTqYSsd+KcpiIC2xIc+cjbUaR96fR44cUzauSolE
 VNMNhDh0FHa4SaVG+TjtxXNSx4d87Hn1JpcPuenDU8wFDNpQS+lmoX7yLF62B92593N6js6PF
 P3syzAtx3QoigM+jljqekT341l8/F8A0UN5payjk0s87VoNMOsLk+nl1980TznNmkUodEp6xi
 cYNix3NL1u6nm8fq9XxUKv2TPCCw5w9le8ENMJBeCuPxJY9s1OQth7YWMB5FLSPGIBuIWi4si
 56mhE792VVR/7K3AMMjq1u6vOQRWiMcL3fvCeHKqmEoBq2wzjtb//JbWRMC6KR1M7D2uuDAyu
 XffvYuWbsGNXcpvAoIr+g6oyhwtYiRbp2a+arGEYyfmRyzSMt4OAm1/ceEdK0fLlBgNvYzbAv
 FXOEFEh3ziIoIw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/22 20:53, Joseph Spagnol wrote:
> Hello, recently one of my btrfs partitions has become unavailable and am=
 not able to mount it.
>
> # mount -t btrfs /dev/sda4 /mnt/
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, mis=
sing codepage or helper program, or other error.
>
> # btrfs-find-root /dev/sda4
> Couldn't read tree root
> Superblock thinks the generation is 432440
> Superblock thinks the level is 1
> Well block 23235313664(gen: 432440 level: 0) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23231447040(gen: 432439 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23229202432(gen: 432438 level: 0) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23192911872(gen: 432431 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23177084928(gen: 432430 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23149035520(gen: 432429 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23124443136(gen: 432427 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23113547776(gen: 432426 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23080730624(gen: 432425 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23048241152(gen: 432424 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23013031936(gen: 432422 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> .......
>
> # btrfsck -b -p /dev/sda4
> Opening filesystem to check...
> checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810faf8
> checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810faf8
> bad tree block 23234035712, bytenr mismatch, want=3D23234035712, have=3D=
0

Some range is completely wiped out.
And that wiped out range is in extent tree.


There are several two theories for it:

- Some discard related bug
   It can be the firmware of disk, or btrfs itself.
   Some range got wiped out even we're still needing it.

- Some missing writes
   The write should reach disk but didn't.
   This means the barrier is not working.
   In that case, disk firmware may be the problem.


> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
>
> Here are some more details;
> # uname -a
> Linux msi-b17-manjaro 5.4.184-1-MANJARO #1 SMP PREEMPT Fri Mar 11 13:59:=
07 UTC 2022 x86_64 GNU/Linux
> # btrfs --version
> btrfs-progs v5.16.2
> # btrfs fi show
> Label: 'OLDDATA'  uuid: 9bc104b4-c889-477f-aae1-4d865cdc0372
>          Total devices 1 FS bytes used 34.20GiB
>          devid    1 size 50.00GiB used 37.52GiB path /dev/sda3
> Label: 'OPENSUSE'  uuid: c3632d30-a117-43ef-8993-88f1933f6676
>          Total devices 1 FS bytes used 24.60GiB
>          devid    1 size 150.00GiB used 31.05GiB path /dev/nvme0n1p4
> Label: 'DATA'  uuid: 4ce61b29-8c8d-4c04-b715-96f0dda809a4
>          Total devices 1 FS bytes used 118.67GiB
>          devid    1 size 200.00GiB used 122.02GiB path /dev/sda4
> # btrfs fi df /dev/sda4
> ERROR: not a directory: /dev/sda4
> # btrfs fi df /data/
> ERROR: not a btrfs filesystem: /data/
> ## dmesg.log ##
> [65500.890756] BTRFS info (device sda4): flagging fs with big metadata f=
eature
> [65500.890766] BTRFS warning (device sda4): 'recovery' is deprecated, us=
e 'usebackuproot' instead
> [65500.890768] BTRFS info (device sda4): trying to use backup root at mo=
unt time
> [65500.890771] BTRFS info (device sda4): disabling disk space caching
> [65500.890773] BTRFS info (device sda4): force clearing of disk cache
> [65500.890775] BTRFS info (device sda4): has skinny extents
> [65500.893556] BTRFS error (device sda4): bad tree block start, want 232=
35280896 have 0
> [65500.893593] BTRFS warning (device sda4): failed to read tree root
> [65500.893852] BTRFS error (device sda4): bad tree block start, want 232=
35280896 have 0
> [65500.893856] BTRFS warning (device sda4): failed to read tree root
> [65500.908097] BTRFS error (device sda4): bad tree block start, want 232=
34035712 have 0
> [65500.908111] BTRFS error (device sda4): failed to read block groups: -=
5
> [65500.963167] BTRFS error (device sda4): open_ctree failed
>
> P.S. I must say that I get the same results when I try to mount the part=
ition from another linux system OpenSuse tumbleweed

There are already at least two tree blocks got wiped.

I won't be surprised if there are more.

For now, only data salvage can be even attempted.

Using newer enough kernel (like from openSUSE tumbleweed), then mount
with -o rescue=3Dall,ro to see if it can be mounted.

That's more or less the same as btrfs-restore, but more convenient to
copy things out.

Thanks,
Qu
>
> Is there any way I could rebuild the tree?
>
> Thanks in advance
> Joseph
>
>
