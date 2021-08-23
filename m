Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715E83F53DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 01:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhHWXzs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 19:55:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:50087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233260AbhHWXzr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 19:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629762902;
        bh=XWCj+Xe6AB8ReqVTQyIw10OW4YWVD3VbRV4Q0Ui1KPI=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=ZxltawsVm/Qbm8l42158znTWcFNUISXzcS4isVH5riBO+ukiznvgNTqJ0/zr3/6gZ
         smQ/UzLNllYURPrf5qd/pO7VPr16cLVZq6wwVLarc6NfKdGchGEKtdEoZ4v7lYPy46
         u81h6JhqV8HIAnei9qZ1rAaXLmMmBUtwtCKGRgLA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBDjA-1mB8mm0nIE-00Cg5t; Tue, 24
 Aug 2021 01:55:02 +0200
To:     weldon@newfietech.com, linux-btrfs@vger.kernel.org
References: <005201d79860$befd1b60$3cf75220$@newfietech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: BTRFS fails mount after power failure
Message-ID: <0be8ec2b-7226-f3d1-a02b-608e757bda24@gmx.com>
Date:   Tue, 24 Aug 2021 07:54:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <005201d79860$befd1b60$3cf75220$@newfietech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fqtzaN5/eFYykBxc65YYG+Wn1ZFwgOl9QEJemomUQ+5+LeltOJ7
 xOhdUkVMtYJ3WQG2npu/yTxPaKAfbCjq9dId55+f3r8QvhzIMH/EgNHQ8L7O3QWgjdc3Jke
 Ey7aU28L/KYEdNmMAmJSQdh6reusn6GoGIL4FfuNdem07IcCpi/BkSSjkr9X7Ohv1zPdwIw
 78ujJdn5YtQsbNKFJlHRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qQbzowhYSe8=:H9w6motU3SMIaKR4JgclxT
 +SV8LrdNjL1wBB64oiFRd1iWTTOmtJgF+Ly1ktwBHOOtjGk1TEX7B7dOakwMBSXDEuAX/10NN
 jdC2Worf7Gk1Q7SWQfwIGNf9cN6mTf2RqaIK9/k2mOoME6vzQ9QUw+1wUM+9CP/5oIwrqG8dP
 8ZwtQ4iv7wA17PHL4Rm5mnB4KHQUxSzDNTiRM2GT3faav3ZpL2a8oLrwXGhvH5VyfuT4J7WVL
 mWVRsIiS2EGgtFx3lnyrUtauDf7Un3PDPYHQJecXiSWo+jyBpHncVbgHO7fIY5lQVO6XeJCyz
 waiikEcdQB8+OLbym0Lw36vkfE/WTt5XCoLom+sojKVd/F8RIPQtB39Yot1Uot8iIpTypeUt0
 bJ5RZUp9Gx/jZM655tyFNIEsxnZMc2vgWNORRatRDzcWrH0KQqDdwF66E9Nd1xgR0D4URaL9w
 5auwhYeylsu369eXrP0Pk0ZN5fCMJnUwbFhwDPWNFPuD7vY5zjKXuQ+aOqIdIMSDp24wHFGsT
 466bC/lfM6PHM0SgR1S6Di3vJMCbbJwWFEg1Yv3Ib9EL+WJaNVGO8ZEHNaZwLI6gKz1xeLDL0
 tPKXse0qa+C5x5hPCKxT/OSm/1nGSDZbpGg4Ap+1ewxosspdTF+d9eaWSfGOvrBafQMbZADeI
 tpgPfTMIgv0YJARkGvttC11Gz7QNfya8LxoOAqWemS6oOlcx9JAeIyaR6ILaeBAljxUa/UqaR
 5SsDtiKnGKIA+fjhdaWqzOlm4jn899nKxoCelRx0+R3P5W9RLQu2qcutyPnZb1i+lFFU9D+Nd
 naHZBgGBe/v+GXQhqOhJ4NK2tTY6tBdzN/pPOnufgyzgcC9x3fuWe3bIYoDFSETfdzCLVY7C5
 H9eCFgPLo7zo0bQNSC4zMAFZ7xjpxthtEQN7qDln8S57lWRJSje8fb+/3OcjKk7dGr4xbDfMj
 yhcegSVi3nncceU7Vd0/BG9O4qboE/J5EQGDRmYD5cgXsxHUtRjOJcpPRxEjQoY1AxVFXiLs0
 O1MJtfc7agfjbLXF4nUnkwpDdntdlnaVareg1e1ZwH08ktRPnbykX9pdL5Lp4yiz6qW61CCtD
 8A9URgCAKH2yQEJsl9h0AjwUynyWj426oc85HkeXwrVej9Gh3arLVhwdA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=884:52, weldon@newfietech.com wrote:
> Good day folks,
>
> I awoke this morning to find that my UPS had died overnight and my Ubunt=
u
> server with a 14.5TB (Raid 5) BTRFS volume went down with it.

RAID5 has known write hole bug, and although that bug won't cause
immediate problems, it slowly degrades the whole array with each
corrupted sector or unexpected power loss.

This would eventually bring down the array with enough degradation.

>=C2=A0 The machine
> rebooted fine and the hardware reports no errors, however the BTRFS volu=
me
> will no longer mount.  The OS boots fine, the 14.5TB volume is for data
> storage only.=C2=A0 gparted shows the volume/partition,=C2=A0 and correc=
tly reports
> space used as well as total size.  I've never encountered this type of i=
ssue
> over the past year while using btrfs and I'm not sure where to start.=C2=
=A0 A
> number of google search results express caution when attempting to
> recover/repair, so I'm hoping for some expert advice.
>
> My dmesg log exceeds the 100,000 bytes restriction, so I'm unable to att=
ach
> it, so please ask if there's anything specific I can include otherwise.
>
> # uname -a
> Linux onyx 5.4.0-81-generic #91-Ubuntu SMP Thu Jul 15 19:09:17 UTC 2021
> x86_64 x86_64 x86_64 GNU/Linux
>
> # btrfs --version
> btrfs-progs v5.4.1
>
> # btrfs fi show
> Label: 'Data'  uuid: 7f500ee1-32b7-45a3-b1e9-deb7e1f59632
>          Total devices 1 FS bytes used 7.17TiB
>          devid    1 size 14.50TiB used 7.40TiB path /dev/sdb1
>
> # dmesg | grep sdb
> [    2.312875] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
> CAPACITY(16).
> [    2.313010] sd 32:0:1:0: [sdb] 31138512896 512-byte logical blocks: (=
15.9
> TB/14.5 TiB)
> [    2.313062] sd 32:0:1:0: [sdb] Write Protect is off
> [    2.313065] sd 32:0:1:0: [sdb] Mode Sense: 61 00 00 00
> [    2.313116] sd 32:0:1:0: [sdb] Cache data unavailable
> [    2.313119] sd 32:0:1:0: [sdb] Assuming drive cache: write through
> [    2.333321] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
> CAPACITY(16).
> [    2.396761]  sdb: sdb1
> [    2.397170] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
> CAPACITY(16).
> [    2.397261] sd 32:0:1:0: [sdb] Attached SCSI disk
> [    4.709963] BTRFS: device label Data devid 1 transid 120260 /dev/sdb1
> [   21.849570] BTRFS info (device sdb1): disk space caching is enabled
> [   21.849573] BTRFS info (device sdb1): has skinny extents
> [   22.023224] BTRFS error (device sdb1): parent transid verify failed o=
n
> 7939752886272 wanted 120260 found 120262
> [   22.047940] BTRFS error (device sdb1): parent transid verify failed o=
n
> 7939752886272 wanted 120260 found 120265

This already shows some mismatch in on-disk data and recovered data from
parity.

This shows the on-disk data and parity have drifted from each other,
exactly the write hole problem.

Furthermore, the disk has newer data than what we expect.

What's the device model? It looks like a misbehavior, not sure if it's
from the hardware, or the btrfs code.
As RAID56 is already marked as unsafe for a while, not that much love
nor code fix is directed to RAID56, thus both cases are possible.

> [   22.047949] BTRFS warning (device sdb1): failed to read tree root
> [   22.089003] BTRFS error (device sdb1): open_ctree failed
>
> root@onyx:/home/weldon# btrfs-find-root /dev/sdb1
> parent transid verify failed on 7939752886272 wanted 120260 found 120262
> parent transid verify failed on 7939752886272 wanted 120260 found 120265
> parent transid verify failed on 7939752886272 wanted 120260 found 120265
> Ignoring transid failure
> WARNING: could not setup extent tree, skipping it
> Couldn't setup device tree
> Superblock thinks the generation is 120260
> Superblock thinks the level is 1
> Well block 7939758882816(gen: 120264 level: 1) seems good, but
> generation/level doesn't match, want gen: 120260 level: 1
> Well block 7939747938304(gen: 120263 level: 1) seems good, but
> generation/level doesn't match, want gen: 120260 level: 1
> Well block 7939756146688(gen: 120262 level: 1) seems good, but
> generation/level doesn't match, want gen: 120260 level: 1
> Well block 7939751559168(gen: 120261 level: 0) seems good, but
> generation/level doesn't match, want gen: 120260 level: 1
>
> *** A large selection of block references was removed due to character
> count... if needed, I can resend with the full output.
>
> Well block 1316967743488(gen: 1293 level: 0) seems good, but
> generation/level doesn't match, want gen: 120260 level: 1
> Well block 1316909662208(gen: 1283 level: 0) seems good, but
> generation/level doesn't match, want gen: 120260 level: 1
> Well block 1316908711936(gen: 1283 level: 0) seems good, but
> generation/level doesn't match, want gen: 120260 level: 1
> root@onyx:/home#
>
> Any help or assistance would be greatly appreciated.  Important data has
> been backed up, however if it's possible to recover without thrashing th=
e
> entire volume, that would be preferred.

First thing first, don't expect too much about magically turning the fs
back to fully functional status.
Transid error is always tricky for btrfs.


But for your case, I'm guessing your sdb1 does not have the latest super
block.
We have newer tree roots on disk, but older super block.

Maybe you would like to try "btrfs ins dump-tree" on all the involved
disks, and find if there is newer super blocks.

Thanks,
Qu
>
> Regards,
> Weldon
>
