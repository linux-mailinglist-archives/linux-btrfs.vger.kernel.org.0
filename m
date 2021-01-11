Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0CC2F0AA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 01:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbhAKAjs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 19:39:48 -0500
Received: from mout.gmx.net ([212.227.15.18]:39179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbhAKAjr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 19:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610325492;
        bh=ygCeOgtOzPt1DSTw+L5qYPx569B0ga+VR/uYd9dY13s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=auOXjurswYGJ8WWPtS+ZEJ6ypGmYZYY7MabB1PACarngbF4J4DE+87G/n7gSXdgwB
         MRSOYFjUgUlOk614Hhfdw5Je2DqHJWoYxqpGNl4gebLfT7WlMq1MNCMlHMCmvQKleX
         Eujgkz7+mMWsCQxd/KFpA8R4M951460H1vMnLLsQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXXyP-1kS6yB0LTb-00Z2hh; Mon, 11
 Jan 2021 01:38:12 +0100
Subject: Re: [bug] scrub on low disk space leads to Transaction aborted
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0f061eb2-2192-da85-0f34-43faa4e2812f@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <590a8b80-1ec2-e688-64de-b5afc82fd5c7@gmx.com>
Date:   Mon, 11 Jan 2021 08:38:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0f061eb2-2192-da85-0f34-43faa4e2812f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+J3at54PJ7816JSuCPunxxAujSBh66jY3EooMELxfgCLFHL5GiT
 6e60TKJF/IktBwiKX7/aWHt9MKpKAJ+YQPb8KNBIoLRao4mFfQg8fCh1XWtZbeMCM2Ss9yV
 Oc9bWL032bG1r1zA516s3N3JyKnU+rIusfVYAbrsJjD4AaGUyrDO6/la/6En2vSozoO1vkG
 A8WXTeuP8AeqIzB/kf+Dw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qeyP7Dwexxk=:vHnGgwMeU2iJJfBcJH9XUj
 WMrlyujGwU3bTwIuSnFdHW1HbV1G3ryZ8EEsZO8kRTBnAnyydD8aMqlz8bfxYWfcatOlCpumu
 ogkzQoUZ0SVYNVs9jYLbRGMUFn3QsOwBgNM573JcjMnBLHqSDv9vGTH67cWb5mnbLb2tpM03X
 Ixl7Z4Wd9R2n5EjjKiPtMduTsSoGhHxNGSt+yj4gmxEJKPuxr7IGXdT/Q4GAe9IREVWRmkduF
 JxbMGr+docEkbCXE0jnpcDWKI9+tzieBuMfR4gMZIVod6mHI3L1eEfi/jbdIrCMJO3xaY+BbY
 3b5yTwhJrhnBL4d4mrbIQs7H31MQTobaKqDddClZ+Agi09SeNADYUE96Muv6d2ZhKpGbLPy5V
 mcqZfuaKVlV/hDWXuSbXIN/ZoUKO1qlZmHLbVB7gLvR7iabKRnmdJBClsAR/kLlJxWRBFjHzt
 X0fC2wHy5AnQHRWlYRxvzze7KlnWQXZ9/4JNdpi5/ewOY+4x25DHZYif1e6JLXCeZlOvSPjmb
 h501Rbjbb9Ee0LRBlner8SbOHB8vhWPmRwYu0+6pSLSrtb2rt5KoGty+WUEZq803K7ufxvinu
 uCwmCWDts1Hk08sYG4HkWEE0+NqHq9p4AS2B0ksknKPXkmzOhurMrjlAz0+rfn7FweSulwa/n
 TsD2etLF+AIkqY7cJtkfL0d1Ic1/wkN42OmulFpd/6Bn/TKCr8vtmA99uLJl+Uj1BZsRJ/2Eu
 ytMbDcF7n6Pvl027IbPAr8QcqKqMFg7plsV1oD1CH2ExsDVwrMlOH8DndmNCMVpl7swTg7DEw
 ANC9OHjfIyX5NajVozQQvWFte66u9adBNhBX3v+SbELDbGJvTU4b1nv56KJ4PjerExN2nqfJ8
 9dF4e9OXxcmBnl0RWCmw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/9 =E4=B8=8B=E5=8D=884:53, Anand Jain wrote:
>
>  =C2=A0I ran scrub when disk space was low on a btrfs with some raid1 cs=
um
>  =C2=A0errors, on a system with kernel 5.11.0-rc2+. It lead to transacti=
on
>  =C2=A0aborted and rdonly FS.
>

Would you please provide `btrfs fi usage` output?

There is a bug in recent kernel that global rsv is not increased
properly so that we have a much higher chance to exhaust metadata space.

Thanks,
Qu

> [ 2365.314375] ------------[ cut here ]------------
> [ 2365.314385] BTRFS: Transaction aborted (error -28)
> [ 2365.314470] WARNING: CPU: 2 PID: 4672 at fs/btrfs/inode.c:2823
> btrfs_finish_ordered_io+0x8e6/0x950 [btrfs]
> <snap>
> [ 2365.314921] CPU: 2 PID: 4672 Comm: kworker/u8:11 Not tainted
> 5.11.0-rc2+ #3
> [ 2365.314933] Hardware name: LENOVO 20FAS6PN00/20FAS6PN00, BIOS
> N1CET47W (1.15 ) 08/08/2016
> [ 2365.314939] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [ 2365.315093] RIP: 0010:btrfs_finish_ordered_io+0x8e6/0x950 [btrfs]
> <snap>
> [ 2365.315290] Call Trace:
> [ 2365.315309] BTRFS warning (device sda6):
> btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left)=
.
> [ 2365.315305]=C2=A0 finish_ordered_fn+0x15/0x20 [btrfs]
> [ 2365.315532]=C2=A0 btrfs_work_helper+0xcc/0x2f0 [btrfs]
> [ 2365.315763]=C2=A0 process_one_work+0x1ee/0x390
> [ 2365.315781]=C2=A0 worker_thread+0x50/0x3d0
> [ 2365.315797]=C2=A0 kthread+0x114/0x150
> [ 2365.315811]=C2=A0 ? process_one_work+0x390/0x390
> [ 2365.315824]=C2=A0 ? kthread_park+0x90/0x90
> [ 2365.315836]=C2=A0 ret_from_fork+0x22/0x30
> [ 2365.315861] ---[ end trace b0e289a2c3d424e8 ]---
> [ 2365.315871] BTRFS warning (device sda6):
> btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left)=
.
> [ 2365.316713] BTRFS warning (device sda6):
> btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left)=
.
> [ 2365.316796] BTRFS warning (device sda6): Skipping commit of aborted
> transaction.
> [ 2365.316809] BTRFS: error (device sda6) in cleanup_transaction:1938:
> errno=3D-30 Readonly filesystem
> [ 2365.316824] BTRFS info (device sda6): forced readonly
> [ 2365.359195] BTRFS info (device sda6): scrub: not finished on devid 2
> with status: -125
