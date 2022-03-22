Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD354E49B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 00:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbiCVXlB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 19:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiCVXk7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 19:40:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075656426
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647992366;
        bh=BPf+rqCYHmiP6z7fPSkU+0NVSZREi7tdymCExJaGaM0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LSA/wxpB9Y+0pZvmR/4keGp10poFcB1YrnpX7AALchClpKSUUrMRcshU02C1//OF9
         /Yw2vNcgYvHMmGyYuEWOw2YG272RjNYi5ii2dcPCLKNwkE2+kblTGdovdKKDXN4MF3
         EIjO6TxrCw+R4HI7B+AXABUpZqXlSlcXga9YOS8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRCKC-1nl1453Wzc-00NEAI; Wed, 23
 Mar 2022 00:39:26 +0100
Message-ID: <9d942b5b-f52b-b3bc-954f-710abc9ce556@gmx.com>
Date:   Wed, 23 Mar 2022 07:39:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: failed to read block groups: Input/output error; bad tree block -
 bytenr mismatch;
Content-Language: en-US
To:     Joseph Spagnol <joseph.spagnol@programmer.net>
Cc:     linux-btrfs@vger.kernel.org
References: <trinity-58cb51fa-9b3e-4fd0-9ff7-29da0dd13e14-1647953588232@3c-app-mailcom-lxa08>
 <f1159186-c73d-5102-549d-8e343f1bca0d@gmx.com>
 <trinity-56388cba-8de1-43e3-8e32-a8f8b6d0d246-1647969466534@3c-app-mailcom-lxa08>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <trinity-56388cba-8de1-43e3-8e32-a8f8b6d0d246-1647969466534@3c-app-mailcom-lxa08>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rNuYN/b4L8qPMu5rG+BY5fukOWmO2SbkyaGGspry+0hFYJxLXRl
 f5hiJRZWCkWMBcdFRhHg37RoxSTQw/phHIL6s87l6n0U3v+OeUNp3OnZ2MrcZKY32nvnZS9
 ZxV7LNEa/mZ23JbSW46irYgXEiILlr8l4UotAJ0NRsHVdJjieaRGJUfVWHBtnp5IMBCCFgi
 0vabkkMcuxbmQaNZ0rfqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ojqp8DAJYq8=:37icugZ1xy0v3xKt467gXA
 wN/bMj46VG90CEkt+4AK6XDb3pz1t5UDZ8+iDvgt1CXD+CKfBDkjL4t6qyL9J0X8L3T2XjAoP
 KWPykP7Dlr3ho+2R3l9ihu3C/LlLfvrhuG5ofxNuO9ji1y1qy+HymcLbzaq347aP8/oGi80sA
 7mH0uNB6kjJSSuQrho0Cyemiaqm5UBkyUki44/LPeYkNULa1BVOOf58Y1VkuHDTU/wvQLELNj
 9o2R2PtLy7zWWGtBu1mD02RElkTH414gXcZUd4UXf0NnISvoWdivftCdISH5h14qxXCq7iHZB
 vGZ3B45X1/NDjythuxQVGB4+LhgylJBhMjX9edryOYUrJE3fqtI9MEpws5BXgLnwwUzLb4XGB
 BRpwl+CUa/RecLMUyzRWyIH2VYnce9PAAAvM9hga2sgMTUhhRxIak8BIvNPiera21aJ6x3hk4
 e+BYUo/N1hUXrxEPDcMCxuNDd+VASSehG5WkrKzsYLo98jPoqmNtU/z0jD+9l9Cg/sCYGx9MI
 YcWy+x0pDgnnURnkh4hozT+wrLBzZu0nmdNNu8/rDSwZl7T0MiE0bvgSwyDwGbTmbEPGmq4ii
 mEQCaCDSviS80jR4Ss41bvgnnF9CT5FWTgAF8Pueq4hQqSoza7GJYDlbhEiErw63OGPVnfQAP
 WM3Q3YJaFdtiR3qnub/pc2gvDSHm4DfBrXRcWCKVnz+ULvQLvNE2xcUYoe4MBpVjfA+PSm94g
 ihHJrfN35hN5/OK8+rx4yh1IMorNe0gGr3rv1ZXSem2tX+pKs7if9dmYE4CGLCkuEw/5xseMj
 VnSw94pz99j5fqIX+q4YPx81RLkjnCW3ULWh7RolhNuupU23kkvRGPRxZgfrnedw+9gbJQJBr
 iMqMl3Y3Vvh5DM+pDdGzvFMWKiA6SfqeIeJR0ISV9kQeQdbUyr4hiCBrZzXqDfqOHMCKXRLE1
 Ti5H+rffm7u80XFVBhAcFuXkEqds5nqUUj5ofqUULwN5c43Yxb0yaEAHeHpRsaRw1RJXnTLLp
 TykugxrGPyIHSWlHnaoBZPA1f+BFPmXIeLovL73kedDGxL9h4Xe91PGEbjJNiBZ7kSp8V7nMl
 SsoY4zIQ4XXSa0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/23 01:17, Joseph Spagnol wrote:
> Hello, thanks for the quick response.
> unfortunately the ro mount from a more recent kernel does not work as we=
ll
>
> # uname -r
> 5.16.11-1-default
> # mount -t btrfs -o rescue=3Dall,ro /dev/sda4 /mnt/
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, mis=
sing codepage or helper program, or other error.

Dmesg please.

But I guess there are more errors on the critical trees, thus it failed.

>
> Am not sure this can help but this btrfs partition become like this afte=
r a sudden system freeze.

Without dmesg of that incident, pretty hard to say.

>
> Is there a possibility to check an fix the partition size?
> I believe it could be an issue with the actual size of the partition/par=
titions.

Not sure what you mean here.

Did you changed the partition size without using btrfs device resize?

Thanks,
Qu

>
> Sent:=C2=A0Tuesday, March 22, 2022 at 2:05 PM
> From:=C2=A0"Qu Wenruo" <quwenruo.btrfs@gmx.com>
> To:=C2=A0"Joseph Spagnol" <joseph.spagnol@programmer.net>, linux-btrfs@v=
ger.kernel.org
> Subject:=C2=A0Re: failed to read block groups: Input/output error; bad t=
ree block - bytenr mismatch;
>
> On 2022/3/22 20:53, Joseph Spagnol wrote:
>> Hello, recently one of my btrfs partitions has become unavailable and a=
m not able to mount it.
>>
>> # mount -t btrfs /dev/sda4 /mnt/
>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, mi=
ssing codepage or helper program, or other error.
>>
>> # btrfs-find-root /dev/sda4
>> Couldn't read tree root
>> Superblock thinks the generation is 432440
>> Superblock thinks the level is 1
>> Well block 23235313664(gen: 432440 level: 0) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23231447040(gen: 432439 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23229202432(gen: 432438 level: 0) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23192911872(gen: 432431 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23177084928(gen: 432430 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23149035520(gen: 432429 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23124443136(gen: 432427 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23113547776(gen: 432426 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23080730624(gen: 432425 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23048241152(gen: 432424 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23013031936(gen: 432422 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> .......
>>
>> # btrfsck -b -p /dev/sda4
>> Opening filesystem to check...
>> checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810faf=
8
>> checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810faf=
8
>> bad tree block 23234035712, bytenr mismatch, want=3D23234035712, have=
=3D0
>
> Some range is completely wiped out.
> And that wiped out range is in extent tree.
>
>
> There are several two theories for it:
>
> - Some discard related bug
> It can be the firmware of disk, or btrfs itself.
> Some range got wiped out even we're still needing it.
>
> - Some missing writes
> The write should reach disk but didn't.
> This means the barrier is not working.
> In that case, disk firmware may be the problem.
>
>
>> ERROR: failed to read block groups: Input/output error
>> ERROR: cannot open file system
>>
>> Here are some more details;
>> # uname -a
>> Linux msi-b17-manjaro 5.4.184-1-MANJARO #1 SMP PREEMPT Fri Mar 11 13:59=
:07 UTC 2022 x86_64 GNU/Linux
>> # btrfs --version
>> btrfs-progs v5.16.2
>> # btrfs fi show
>> Label: 'OLDDATA' uuid: 9bc104b4-c889-477f-aae1-4d865cdc0372
>> Total devices 1 FS bytes used 34.20GiB
>> devid 1 size 50.00GiB used 37.52GiB path /dev/sda3
>> Label: 'OPENSUSE' uuid: c3632d30-a117-43ef-8993-88f1933f6676
>> Total devices 1 FS bytes used 24.60GiB
>> devid 1 size 150.00GiB used 31.05GiB path /dev/nvme0n1p4
>> Label: 'DATA' uuid: 4ce61b29-8c8d-4c04-b715-96f0dda809a4
>> Total devices 1 FS bytes used 118.67GiB
>> devid 1 size 200.00GiB used 122.02GiB path /dev/sda4
>> # btrfs fi df /dev/sda4
>> ERROR: not a directory: /dev/sda4
>> # btrfs fi df /data/
>> ERROR: not a btrfs filesystem: /data/
>> ## dmesg.log ##
>> [65500.890756] BTRFS info (device sda4): flagging fs with big metadata =
feature
>> [65500.890766] BTRFS warning (device sda4): 'recovery' is deprecated, u=
se 'usebackuproot' instead
>> [65500.890768] BTRFS info (device sda4): trying to use backup root at m=
ount time
>> [65500.890771] BTRFS info (device sda4): disabling disk space caching
>> [65500.890773] BTRFS info (device sda4): force clearing of disk cache
>> [65500.890775] BTRFS info (device sda4): has skinny extents
>> [65500.893556] BTRFS error (device sda4): bad tree block start, want 23=
235280896 have 0
>> [65500.893593] BTRFS warning (device sda4): failed to read tree root
>> [65500.893852] BTRFS error (device sda4): bad tree block start, want 23=
235280896 have 0
>> [65500.893856] BTRFS warning (device sda4): failed to read tree root
>> [65500.908097] BTRFS error (device sda4): bad tree block start, want 23=
234035712 have 0
>> [65500.908111] BTRFS error (device sda4): failed to read block groups: =
-5
>> [65500.963167] BTRFS error (device sda4): open_ctree failed
>>
>> P.S. I must say that I get the same results when I try to mount the par=
tition from another linux system OpenSuse tumbleweed
>
> There are already at least two tree blocks got wiped.
>
> I won't be surprised if there are more.
>
> For now, only data salvage can be even attempted.
>
> Using newer enough kernel (like from openSUSE tumbleweed), then mount
> with -o rescue=3Dall,ro to see if it can be mounted.
>
> That's more or less the same as btrfs-restore, but more convenient to
> copy things out.
>
> Thanks,
> Qu
>>
>> Is there any way I could rebuild the tree?
>>
>> Thanks in advance
>> Joseph
>>
>>
