Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EFF407D01
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 13:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhILLQE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 07:16:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:56933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhILLQE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 07:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631445285;
        bh=v/+RrihDt6qnYSgO81oq4rp+VxZSSNTw04fjJEMnqio=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=ZHAeaV83mSs50wBNJbs17e2/iIDraTs8BuiswDLsC5ZrWYzKnZpVMm1ctGEqD8O3v
         DJxvJpaOGal8zwFrxkG5JhTWOMUZ6kYgFBcm6TSrX9KxXUIeYpJtUr2udun4hLvDuh
         CVBPmfKgPflfnNTl9vI/QRXxp75fxoetsJgkP3c4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5G9n-1n5lLd3jLp-011AWe; Sun, 12
 Sep 2021 13:14:45 +0200
To:     =?UTF-8?Q?Niccol=c3=b2_Belli?= <darkbasic@linuxsystems.it>,
        linux-btrfs@vger.kernel.org
References: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Unmountable / uncheckable Fedora 34 btrfs: failed to read block
 groups: -5 open_ctree failed
Message-ID: <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
Date:   Sun, 12 Sep 2021 19:14:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/SVj+iufnx++CyX7nFU3M4aHZKPAbuM3pIQ/MIiuzqT+uRx6Ssy
 3l4xaq2GqErML1zGfndaOMP/ToRIqpeUDpLGiyFJ4ehBrZ78tUdZsjp1jJVQpMqhsZc1Kpo
 K7yP3MVIzCb+mbL1scPknqHO4Kn0mJLLelEu7p23n1bWgA4/6MoUi60ROkzkgT0+ixpmncN
 5V9lMLLmdVpu3bE+trQNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FW5C8tRrRHA=:JTWc57cxNLpYLwyZ1tEmTQ
 pTpPp6wlpVvZiQaTsc+AjyNMQnjQ2f8qX4v/izt6kOe5Kyy7BgubbOe+USxrJb2DEoSiukaiL
 eR6ZUaEqXSFCpkKCEdKWZDcBkAgG+zc5m+wCsXhzCEb5Hr4ayzjg2nIKswth2w10TY3Zo/DNY
 ot7FaHy7gLYAk6+B9WUHrTowGXZZH31LR8XulmKBcacDEWYxqAZOzltmyI3AVjhcbs4GbLvJv
 14QCEpCNQW0dUvfXLiGR5uw404Nbb60U1JzWbW+nNrIyO0t3JzA3/RikKHMnSl6IQl2EP8Xp4
 Kg+325iMutRcjZlijdrcnEV0SpHn+0GLEP9MVlJRzAvCdl0Djs2x0nneVholf5puQK25+WqtA
 d2nsP7avYdy75OnqsSbcb1Jx68iMnRVDq8rtDRKs8oPy12eI2uEv4U/VbEQEMD/A1C4UhuUYC
 vkB6m/uTFzSBu86jW9eNRruW5NiHzWZAZHS/uwftxWpdXRUoF3eTMgnKxn9uKc0mH/iPr/GCH
 waf3KqJdN/QEs88X+oYzVeaZP1Ykh7xSafOB3s/unZNN77On9jJVEA5jWkGKOUGmfE9SsAJCk
 0rsWdmslONRRTNruQnUAHNw3jXFnN2ux2cz9meu0Ay2R7B9Iz44kPu7c/x4Hzt6Kptvf6PVMw
 9Rh5pH2kZUfigl6NTuKvNlT8Y+wgLwuTSTIXAB/wlUnCVaouN/yKvW6yF2ekW0vrLH86w5VEU
 k/45q2cRf3LoqXOSbJk0/snLRa26wo74qs2WuU+A5tbyBW1Bh+CZjP6sl0/j7Zp1HnCcLoCPH
 CZAa1CI9Y6mGVdzyZS0OStpqFZpY1yY8shb+DCv8HILKYxTd9bnN4COhVQH8YroSUV+Fq7NA8
 9m5t4kDP2ZEN0ppngxtzcFV6G72AK1mtZpN5yTKh+tfc+mP46/UL3z4W3Z6WC2/lPmEdPQS0r
 mPwM/RnzJBB9do+8SNiMIrNZ6G5N3zv6/4g4Jtu9loiIx3THS7Op0PJZIhoQlAYTMf8Jg4/Dy
 2yBbGzB8BjYGZA8amFeBmlWKX3+Ezl+GdQmxsERoTOREwYBnnYUWsSBGOrhJVNeGcM6pv7J+U
 TJIMD2cBB6zVNk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/12 =E4=B8=8B=E5=8D=886:27, Niccol=C3=B2 Belli wrote:
> Unfortunately my Fedora's btrfs partition failed again. Yet no idea of
> the culprit because memtest passes and the drive is good.
> The system freezed and I had to reset (magic Sysrq keys didn't work
> either), being welcomed by an unmountable fs.
>
> This is what I get when I try to mount it:
>
> $ sudo mount /dev/nvme0n1p6 /mnt/
> mount: /mnt: wrong fs type, bad option, bad superblock on
> /dev/nvme0n1p6, missing codepage or helper program, or other error.
>
> [=C2=A0 375.964495] BTRFS info (device nvme0n1p6): disk space caching is=
 enabled
> [=C2=A0 375.964499] BTRFS info (device nvme0n1p6): has skinny extents
> [=C2=A0 375.977169] BTRFS warning (device nvme0n1p6): checksum verify fa=
iled
> on 21348679680 wanted 0xd05bf9be found 0x2874489b level 1

This is very strange.

Not transid error, not tree-checker, but purely csum mismatch.

Furthermore, it's csum mismatch means, its bytenr and fsid is correct,
just csum mismatch.

It's not something wrong in the content (in runtime memory), but really
just csum mismatch.

This really means, something in the tree block content is not correct,
thus not matching the inlined csum. Exactly the thing csum is designed
to detect.

Normally for metadata, we use DUP thus you have your chance to recovery
from such real data corruption, but unfortunately for NVME SSD, we
default to SINGLE, without any extra copies.

> [=C2=A0 375.977179] BTRFS error (device nvme0n1p6): failed to read block
> groups: -5

This is again in extent tree.

> [=C2=A0 375.978953] BTRFS error (device nvme0n1p6): open_ctree failed
>
> Check fails to run:
>
> $ sudo btrfs check /dev/nvme0n1p6
> Opening filesystem to check...
> checksum verify failed on 21348679680 wanted 0xd05bf9be found 0x2874489b
> checksum verify failed on 21348679680 wanted 0xd05bf9be found 0x2874489b
> Csum didn't match
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
>
> usebackuproot didn't help either:
>
> $ sudo mount -o rescue=3Dusebackuproot /dev/nvme0n1p6 /mnt/
> mount: /mnt: wrong fs type, bad option, bad superblock on
> /dev/nvme0n1p6, missing codepage or helper program, or other error.
>
> I tried btrfs rescue but it didn't lead to a mountable fs:
>
> $ sudo btrfs rescue super-recover /dev/nvme0n1p6
> All supers are valid, no need to recover
>
> $ sudo btrfs rescue zero-log /dev/nvme0n1p6
> Clearing log on /dev/nvme0n1p6, previous log_root 21344239616, level 0

None of these really helps.
>
> $ sudo btrfs rescue chunk-recover /dev/nvme0n1p6
> Scanning: DONE in dev0
> Check chunks successfully with no orphans
> Chunk tree recovered successfully

This can be even a little dangerous.

>
> I did manage to recover some data with btrfs restore (no idea how much
> of it):
>
> $ sudo btrfs restore /dev/nvme0n1p6
> /run/media/liveuser/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6_resto=
re/
> Skipping snapshot snapshot
> [...lots of snapper snapshots]
> Skipping snapshot root
>
> I really did want to use rescue=3Dskipbg
> (https://lwn.net/Articles/822242/) or rescue=3Donlyfs
> (https://lwn.net/ml/linux-btrfs/20200701144438.7613-1-josef@toxicpanda.c=
om/)
> but it seems that neither managed to reach upstream :(

No, it's already in the upstream, in v5.11.

Just a different name, "rescue=3Dibadroots" or "rescue=3Dignorebadroots".
And it get enhanced to handle the exact case you're hitting, in v5.14.


So please try first using "rescue=3Dibadroots" (need to be mounted with
RO), then check your fs.

The core thing is to ensure everything, include csum tree (by reading
all your data), all your files/directories are fine.

Then you can try to rebuild extent tree.
But for now I prefer to do the rescue mount first, then consider the
next step.


Really, this looks like a data corruption not detected by SSD controller
but detected by btrfs.

Thanks,
Qu

>
> btrfs restore really sucks compared to the previous recovery options
> because it gives you no way to list your subvolumes or to recover a
> specific snapshot.
>
> I've also looked at
> https://en.opensuse.org/SDB:BTRFS#How_to_repair_a_broken.2Funmountable_b=
trfs_filesystem
> to see if I had any other options left, but it seems I will have to
> reinstall from scratch.
>
> We truly need a better way to recovery-mount partitions, along w/ better
> tools to at least *try* fixing them.
>
> Niccolo'
