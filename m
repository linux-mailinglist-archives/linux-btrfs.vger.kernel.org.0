Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D793B2FCCC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 09:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbhATIdO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 03:33:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:45147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730925AbhATIcm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 03:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611131463;
        bh=1O8NvNDA9rhM5Dptix7f+eyHns8XqExOyr+3VYLetLY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=P3z4dki8dUCntwyOtI0sx/koWoUPVIZKUL0VAV+4vSAi1l1L9jbBpizeESTvpQIbG
         4xbXA3wDufagp386aoWhEd9DSF8cy67x3zuZQoCk9PveLqInVfM5QcLx/68hCsNOyj
         KPUQ+2STWd7CbOKEcLjBiTmuUi3zDnEXbY1vhQkk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lY1-1l1Jg63ISB-000uvd; Wed, 20
 Jan 2021 09:31:03 +0100
Subject: Re: "bad tree block start" when trying to mount on ARM
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk>
 <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com>
 <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
 <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com>
 <CAMj6ewMqXLtrBQgTJuz04v3MBZ0W95fU4pT0jP6kFhuP830TuA@mail.gmail.com>
 <218f6448-c558-2551-e058-8a69caadcb23@gmx.com>
 <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
 <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com>
 <CAMj6ewNDQFzXsvF5c1=raJc11iMvMKcHH=AbkUkrNeV2e3XGVg@mail.gmail.com>
 <CAMj6ewPiEvXbtHC1auSfRag5QGtYJxwH_Hvoi2t_18uDSxzm8w@mail.gmail.com>
 <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com>
Message-ID: <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
Date:   Wed, 20 Jan 2021 16:30:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rHVmP99W1GB3y9Q/xuVKp+ZtKKfcqZ1Lg9zmElR6ia3NRVbLgR7
 VIN5inBOOmcd3lnGrzjtxcsbWaUbPG0cjy/I2HLD/aBiU8Kvni7zfOZyJt/h62obaACW+op
 CweYlPTXVtJS5M6QB/42d9XaGbIsDvCgvMTJNVlO9cKc/6fmr378U/DaFQbd6RF4TCcNQkX
 z63OKkVZZUs2EvL9pp/ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VsFcFT/2a9Q=:mDknY7P+1SDOkXgnv95Hbd
 IhLb/Xt2J4LZSR9fQYV5htjN+hbOZY+rHDEVyHRpxrWsOuniV0kPHhbBsHI3UsAiQL2b7/ReJ
 GdnixV8Ge5FqxPJ75CJziKfAzEqfmFBAZz7aHufBT9ErsmuC9M9ObHHs2VqFK/nIK4pZfqccm
 fqppVqk2lahgo15WweEtzSBeiseqMdGc84jK3LlL+uc8N4vkLQb1uLJnxLEGLvvbZE467JHzZ
 Bh0LGSgpmNXGPm65+GmTfo0Jftvhk6p9aYwFp+Tq5zxrudSwiOqPnQEI0KjvD22Icmgnm0QLU
 +VFhF7njhcwO+4qbxnVGFNp3mj8eM8uYbDp78EXYzRZSwKOYvdU+/8ilWLVseITIhNjXTtDPa
 FSdXZgxWYRK/P1fJUjMxOhueMtkrbM1pM8xr6/D3enFQLb1DfHO+OxKJyBWzLXig2KMg3G3e0
 r9WCgeIixs76YJO2+UoBf7TOHAgDUWLMWxOesFZ1lWZM/kf6O+bd10zWiqGjTDBrzjO8R27Ub
 kOvZY3mxv+Z+hlvJRxerGTZ4sGtqtwgrleh90T7D34yoRvQfoSqdAbNqRLTGPkCWleavLybSj
 2DMcbm9vtSlkYpsKM93R3BYZHVVB0OAHlJN1+sDBLuuX29Pfd1Kj/yMX+hcjgoF/HMZsYnGOe
 PW0qolbPgvd8XLst12UAKhXY2QvPMghuTu2oLaqq63ZThPRaIw2zDBhEM5WM/s31YRyfBc1wu
 USnTom+Io+XQKutk4OCuYDyCHGcWtr+iznBrclRFzq1d+4pqLpmOIQDBOYjceBNcBMJmeKyvQ
 WkwTzHd1eaXmrx9mypgSWHkXaTQixLhAVCKuYnXXteeWBLdsaGL8yOMoXwEkYzsM3odQD0QpG
 ofi8Xfo0L1u0fbI3DjhQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/20 =E4=B8=8B=E5=8D=884:21, Qu Wenruo wrote:
>
>
> On 2021/1/19 =E4=B8=8B=E5=8D=885:28, Erik Jensen wrote:
>> On Mon, Jan 18, 2021 at 9:22 PM Erik Jensen <erikjensen@rkjnsn.net>
>> wrote:
>>>
>>> On Mon, Jan 18, 2021 at 4:12 AM Erik Jensen <erikjensen@rkjnsn.net>
>>> wrote:
>>>>
>>>> The offending system is indeed ARMv7 (specifically a Marvell ARMADA=
=C2=AE
>>>> 388), but I believe the Broadcom BCM2835 in my Raspberry Pi is
>>>> actually ARMv6 (with hardware float support).
>>>
>>> Using NBD, I have verified that I receive the same error when
>>> attempting to mount the filesystem on my ARMv6 Raspberry Pi:
>>> [ 3491.339572] BTRFS info (device dm-4): disk space caching is enabled
>>> [ 3491.394584] BTRFS info (device dm-4): has skinny extents
>>> [ 3492.385095] BTRFS error (device dm-4): bad tree block start, want
>>> 26207780683776 have 3395945502747707095
>>> [ 3492.514071] BTRFS error (device dm-4): bad tree block start, want
>>> 26207780683776 have 3395945502747707095
>>> [ 3492.553599] BTRFS warning (device dm-4): failed to read tree root
>>> [ 3492.865368] BTRFS error (device dm-4): open_ctree failed
>>>
>>> The Raspberry Pi is running Linux 5.4.83.
>>>
>>
>> Okay, after some more testing, ARM seems to be irrelevant, and 32-bit
>> is the key factor. On a whim, I booted up an i686, 5.8.14 kernel in a
>> VM, attached the drives via NBD, ran cryptsetup, tried to mount, and=E2=
=80=A6
>> I got the exact same error message.
>>
> My educated guess is on 32bit platforms, we passed incorrect sector into
> bio, thus gave us garbage.

To prove that, you can use bcc tool to verify it.
biosnoop can do that:
https://github.com/iovisor/bcc/blob/master/tools/biosnoop_example.txt

Just try mount the fs with biosnoop running.
With "btrfs ins dump-tree -t chunk <dev>", we can manually calculate the
offset of each read to see if they matches.
If not match, it would prove my assumption and give us a pretty good
clue to fix.

Thanks,
Qu

>
> Is this bug happening only on the fs, or any other btrfs can also
> trigger similar problems on 32bit platforms?
>
> Thanks,
> Qu
