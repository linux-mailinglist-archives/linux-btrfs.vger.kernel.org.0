Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE352E0737
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Dec 2020 09:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgLVIa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Dec 2020 03:30:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:35879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgLVIa1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Dec 2020 03:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608625725;
        bh=9DQ2iwpmghqHd1zp6UfUM9DIbrXnqj5FhI3t/ETmVZk=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=NlvXTFMdjpiXPchym9fDgqTdGHTufybsG2PX0WqylVMUC5PI6r+9drRkVpmkNP9gA
         cJBiCaTKsRQEkbcC9gtYJrCv4hKAKLnlxNSNS65nRHVmcCsv/fYCF8vPaoau6nZJt+
         PGMsW2KOHwK2r0fIJDtXw1fqwxK2vJxOrVdQwGKc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzyJ-1kLr3D1xRX-00dT7U; Tue, 22
 Dec 2020 09:28:45 +0100
To:     =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactcode.de>,
        linux-btrfs@vger.kernel.org
References: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [BUG] 500-2000% performance regression w/ 5.10
Message-ID: <55e24dfb-8985-b972-2cd5-7b810661672d@gmx.com>
Date:   Tue, 22 Dec 2020 16:28:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WOupkePiS1K7p5N0T6fAd/q5Air/+9JEWRXGnNeinZKSCsc6f89
 6l6tCy6S9TZLxw0xTer+9t3g3g1Ysmr3mQNTAheF+b1BhXWLAOdAJNI8RwrMQPiL8x3A1Hf
 at2WDNCcpdq98CxdBmRa6tio3w/WITnO5AwLNEt0PS8ICQmMyrltZAzHrN7d12WTbY1cnzZ
 gUR4PyVkudxkwBjJAFKaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:W5sfgKz6ejE=:eWBuJll6G3RnGwUj6Yw+EP
 Dge5reZxRlqLgVbZ6ru6nunK0SthpgMAcy96cG0E56C/YcSnP+NIOvxXfTgv70JC3FxKskER1
 gVRjxlL095uovUAmkRzH5GT57fB8842Jz5gG2ZmWugUgEtkNgsPcRIpKc6BxbWGwEyMo3cIt+
 Xt0POxAylKPBJnLkFwog87k0frzzQZNZPTnzmVOHerT1IA1kr4CO4JXzjmKlfXgC8r+FbB5OV
 4TQ2B/e/jkjmBLvh8y28K4pPCU0aS3AtDF59lnnLRzPTLK+2UX1cs9IfOUqeN05ms/DFcbXzJ
 kOqHPe48mE20FRrtinHvqmJk01swqWG8Tz/chXn3bH7z6aLzS8kq4HoZJ6RAL68cPNQaQXXC9
 ThL+3YLr9/89oFyEsWA3jsSS0xvwVC8VdwWcD+GAC7uE4sdJHvm4u/2UTe/zrmHUTZkrKxRFZ
 Rrry6548n8sT6ogSFz6tWDjP4LfwV1MnPOd1RVfZ1zgReQ2lSHKh+y4bRp5IDWOXuTD2HafwG
 77hWpVpVR9MOjcFaSTbDhWa/G7RaSWm1SKg+AUufzRDjlZ/HXDxH46Frp6fB5DDvtZD1pN+km
 ZfwZIoWqTzfgshOdEdpysyPyZxt1pErx6mqWofmvmGUqS40ZpQOslrzY8g48Mp4nPXkzpSeRy
 hnSGWNL1UBOdEkaxkuXNY/O6UIkx1xOfoe+cw5JANiQuhNa4yQbsOw5bK2W9p8TlHYpbVEBTj
 bTWsqgtTVkVvkjBgKRT4DFWA19fO/Ev1b0Ldn5EgBjdQ6HuyfKr2BhmU3dyD+Vu2PwGmW57v2
 LcQIT2GfKUL9W3sULAMw2LNzp/Bu6okfTRbIOsobqRTNzjaG5dHHYzZltn9iYyptTlt2viQBM
 WlZed6e75IEnGSa5HvQQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/22 =E4=B8=8A=E5=8D=883:45, Ren=C3=A9 Rebe wrote:
> Hey there,
>
> as a long time btrfs user I noticed some some things became very slow
> w/ Linux kernel 5.10. I found a very simple test case, namely extracting
> a huge tarball like:
>
>    tar xf /usr/src/t2-clean/download/mirror/f/firefox-84.0.source.tar.zs=
t
>
> Why my external, USB3 road-warrior SSD on a Ryzen 5950x this
> went from ~15 seconds w/ 5.9 to nearly 5 minutes in 5.10, or 2000%
>
> To rule out USB, I also tested a brand new PCIe 4.0 SSD, with
> a similar, albeit not as shocking regression from 5.2 seconds
> to ~34 seconds or=E2=88=AB~650%.
>
> Somehow testing that in a VM did over virtio did not produce
> as different results, although it was already 35 seconds slow
> with 5.9.
>
> # first bad commit: [38d715f494f2f1dddbf3d0c6e50aefff49519232]
>    btrfs: use btrfs_start_delalloc_roots in shrink_delalloc

This means metadata space is not enough and we go shrink_delalloc() to
free some metadata space.

My concern is, why we need to go shrink_delalloc() in the first place.

Normally either the fs has enough unallocated space (thus we can
over-commit) or has enough unused metadata space.

We only need to shrink delalloc if we have no unallocated space, and not
enough space for the over-estimated metadata reserve.


Would you please try to provide the `btrfs fi usage` output of your test
drive?
My initial guess is, this is related to fs usage/layout.

Thanks,
Qu
>
> Now just this single commit does obviously not revert cleanly,
> and I did not have the time today to look into the rather more
> complex code today.
>
> I hope this helps improve this for the next release, maybe you
> want to test on bare metal, too.
>
> Greetings,
> 	Ren=C3=A9	https://youtu.be/NhUMdvLyKJc
>
