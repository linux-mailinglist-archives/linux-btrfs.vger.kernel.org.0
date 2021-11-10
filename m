Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097B044BA5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 03:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhKJCgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 21:36:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:47159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhKJCgb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 21:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636511622;
        bh=9tB4gzF7Nr/wk7gpcYIKpXXKYepercLOCq8MsUd1c80=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=cTC5O26kbBSwKQt8cjifFlEDKqi7BOeSWsFHsEYULFwBqCpg8fuvCEOI8YgYQeAEI
         TMpyoV3FXc+Ja/0pEQqC4e6St2pkKiq6QGKVpjecsyR25Rl5JRQ2afzrNLMb8RxTji
         XWf60k8ScUHA+0z1blxYaHFHQtBL46dekJBQGOyU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDXp-1mRqxd2snd-00uVyc; Wed, 10
 Nov 2021 03:33:42 +0100
Message-ID: <ea81c94d-8bb1-5d78-012d-b63ff3f6ab4a@gmx.com>
Date:   Wed, 10 Nov 2021 10:33:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     "S." <sb56637@gmail.com>, linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
In-Reply-To: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Gca2yyq+O6aYvoIBgPtCXmb6v0uqT9xraYpZQn3IqxCHFbd+mf
 nb7DccfGAIukSFCPOHjmdiyZuon4IdoPdxQMlFgPqwes6TeQYnLk+kX4ZK8bmrf2db4owSr
 GHkkvnLZW8zKwtUoe5jujhscDCisixTwEjd3H3OQphqEHr7WPlcjdpTe9IaFJGmgwE52EgJ
 3xRqSUL0W6b+cVkA//rcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JgZbbmzYi5w=:vshDbZWiqcrY+6Mi0aGcW4
 mZsAMlre0jo/YcY0jXH15WE1+sR5FZPJ6PGccuE1zoWWaF5g8hItVl4tIiEIVXnN8jWC6QE0A
 mBG6qq0PehIXwLGboV9YCj9Mn6FjQWLQ3NWOzbAxRCP9NjWaq/eIbWCH7vKUg0fXFEzP2fC1W
 w7x62U83GwYUrzu0HTKm6wg5Yvn+Pah7r9oQU70imHR2QBsyd1114uMPay/xAyy6WQK72jCEq
 m/UnLLkywRYPVmAWMAIQYAwzvDddiUG1iAT626fPuRfqOv+xxlYe+N3Y3GnjVPCVYKXzdKDBK
 dSlbnHicp12R0KLJ0tFlaigXi0NnGWqfdmoG+lbGz7nRGog8l8ILqlkYo4fwnMV+zaGPW8Hmg
 2AKVcOZQQTzFU9OWL2ugKbTs/xNF16qA8etQLwcGVoJymuBtyK/2Xhuk0vJFctCuEVx/sec0X
 ipC957mQtoSJEHDKjoxQlRAJN7nEGk4nrYP4KbxhAkThiLTE7CdBqavRqTRbejR8N6qZR5Ryg
 nRUeqFKvYHStuRA5ng4mVkrc+6oiDeK6Kk+CnHM4x9NVbSJSE6dYm2MFW2eAv4taBKEAL/5WY
 ls8dgKLUqw90VLzlIDAXLYc7dsBpGzBBAJ0EjCbfOlNH+oQkxp9KpI8VAySjWIjI2wj53okSf
 mCuQ9E6+Vc6M7M++fKnQASc4btXDopGvLDpAsa7oauaKsrAtbxmYooICtrZzqvL3BJfV0c1Yp
 bg1c3PMPlUAZAKr9wyTYdBzUH7Z/3alcQpAhgzu3mK2HK4pLFW/jEAVB+HLXSq8/hWPRaL3a0
 LZT/irPOd7hmdrAJ1eF4xuI5CY0ALn1bMtEiQWHDNZM7Q67FB+vS6xN3LLFjRjtLNjkV1NxqB
 oQMytpAYnd4/z/vxb5rF+kEUVZdAgqYd/jnkIiU64utqDUcfMLqc8cU1yzDyat31tl32+d6VG
 VGx4n2hTpDlRAxhh1luqC9ppoGCesgtwulE6Kpr+JxNjtm/fLSifnaZMjrq37CvqesWz7bzKs
 K7IEcweUE6PeQ4B73gAygdErU/FL+t3nGoZQIeEgLDwb7ADXFARKCMQ/EdNBJyiSKztgUcgQv
 6cW6hYBg7BJ3YU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/10 10:17, S. wrote:
> Hi there, I run OpenMediaVault on an old LaCiE NAS with an armel
> processor. It has two HDDs, with the Debian root on an EXT4 partition
> and a simple BtrFS RAID-1 using `/dev/sda3` + `/dev/sdb2` for the
> OpenMediaVault data. Both drives have a few bad blocks, but I assumed
> that the filesystem was working around them, because it was running fine
> for almost 2 years on Buster. The SMART report for both drives says
> `SMART overall-health self-assessment test result: PASSED`. Today I
> upgraded to OpenMediaVault 6 and Debian Bullseye, and the BtrFS volume
> is no longer mountable. Here are my attempts thus far:

Newer kernel (mostly since v5.11?) has much strict sanity check inside
btrfs, thus it can detects things which doesn't show up in older kernels.

>
> https://paste.debian.net/1218866/
>
> For the search engines, these are the key errors:
>
> -----------------------------
>
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.110770] BTRFS critical (device sda3=
): corrupt leaf: root=3D9
> block=3D170459136 slot=3D0, invalid key objectid, have 11018354394740573=
44
> expect to be aligned to 4096

The root is UUID tree, thus the objectid is part of the UUID.

The problem is, the key type is corrupted, from your fsck result:

 >    Invalid key type(EXTENT_ITEM) found in root(UUID_TREE)
 >    ignoring invalid key

This bad key type gets caught by tree-checker, and the mount is rejected.

Further more, EXTENT_ITEM_KEY value is 168, while the correct key types
in UUID tree should be UUID_KEY_SUBVOL (251) or
UUID_KEY_RECEVIED_SUBVOL(252).
Which doesn't seem to be an simple bit flip.

But I still recommend to do a memtest to rule out memory problem.


For the repair, we can rebuilt UUID tree, but unfortunately btrfs-progs
doesn't have such ability yet.

Meanwhile, you can prepare a build environment to build btrfs-progs, I
can soon craft a branch for you to re-init UUID tree to solve the
problem first.

To be extra safe, please provide the dump of your UUID tree:

# btrfs ins dump-tree -t uuid /dev/sda3

Thanks,
Qu

>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.125317] BTRFS error (device sda3): =
block=3D170459136 read time
> tree block corruption detected
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.149595] BTRFS critical (device sda3=
): corrupt leaf: root=3D9
> block=3D170459136 slot=3D0, invalid key objectid, have 11018354394740573=
44
> expect to be aligned to 4096
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.164280] BTRFS error (device sda3): =
block=3D170459136 read time
> tree block corruption detected
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.173099] BTRFS warning (device sda3)=
: failed to read root
> (objectid=3D9): -5
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.268589] BTRFS critical (device sda3=
): corrupt leaf: root=3D9
> block=3D170459136 slot=3D0, invalid key objectid, have 11018354394740573=
44
> expect to be aligned to 4096
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.283207] BTRFS error (device sda3): =
block=3D170459136 read time
> tree block corruption detected
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.298934] BTRFS critical (device sda3=
): corrupt leaf: root=3D9
> block=3D170459136 slot=3D0, invalid key objectid, have 11018354394740573=
44
> expect to be aligned to 4096
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.313575] BTRFS error (device sda3): =
block=3D170459136 read time
> tree block corruption detected
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.322394] BTRFS warning (device sda3)=
: failed to read root
> (objectid=3D9): -5
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.363745] BTRFS error (device sda3): =
parent transid verify
> failed on 78086144 wanted 8060 found 8063
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.390901] BTRFS error (device sda3): =
parent transid verify
> failed on 78086144 wanted 8060 found 8063
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.414379] BTRFS error (device sda3): =
parent transid verify
> failed on 79216640 wanted 8061 found 8063
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.434284] BTRFS error (device sda3): =
parent transid verify
> failed on 79216640 wanted 8061 found 8063
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.465467] BTRFS warning (device sda3)=
: couldn't read tree root
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 86.500332] BTRFS error (device sda3): =
open_ctree failed
>
> -----------------------------
>
>  =C2=A0=C2=A0=C2=A0 root@OpenMediaVault:~# btrfs check /dev/sda3
>  =C2=A0=C2=A0=C2=A0 Opening filesystem to check...
>  =C2=A0=C2=A0=C2=A0 Checking filesystem on /dev/sda3
>  =C2=A0=C2=A0=C2=A0 UUID: 4a057760-998c-4c66-aa6a-2a08c51d5299
>  =C2=A0=C2=A0=C2=A0 [1/7] checking root items
>  =C2=A0=C2=A0=C2=A0 [2/7] checking extents
>  =C2=A0=C2=A0=C2=A0 Invalid key type(EXTENT_ITEM) found in root(UUID_TRE=
E)
>  =C2=A0=C2=A0=C2=A0 ignoring invalid key
>  =C2=A0=C2=A0=C2=A0 [3/7] checking free space cache
>  =C2=A0=C2=A0=C2=A0 [4/7] checking fs roots
>  =C2=A0=C2=A0=C2=A0 [5/7] checking only csums items (without verifying d=
ata)
>  =C2=A0=C2=A0=C2=A0 [6/7] checking root refs
>  =C2=A0=C2=A0=C2=A0 [7/7] checking quota groups skipped (not enabled on =
this FS)
>  =C2=A0=C2=A0=C2=A0 found 704343715840 bytes used, no error found
>  =C2=A0=C2=A0=C2=A0 total csum bytes: 686922316
>  =C2=A0=C2=A0=C2=A0 total tree bytes: 757006336
>  =C2=A0=C2=A0=C2=A0 total fs tree bytes: 14794752
>  =C2=A0=C2=A0=C2=A0 total extent tree bytes: 13795328
>  =C2=A0=C2=A0=C2=A0 btree space waste bytes: 32551835
>  =C2=A0=C2=A0=C2=A0 file data blocks allocated: 707684626432
>  =C2=A0=C2=A0=C2=A0=C2=A0 referenced 707430318080
>
> -----------------------------
>
> Any suggestions? Thanks a lot.
