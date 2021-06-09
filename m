Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1683A08E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 03:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhFIBHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 21:07:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:50065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhFIBHR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Jun 2021 21:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623200722;
        bh=7d9D8DmznuAcCVgRyVZobDfuxf7iNpQ26qeOVrfii04=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=TWgPsd7+1+cVAwVAURplCkEm8S6ADPDWtomolMO+84u3K/dLlh9QpjlMZ4ZemClVD
         H0EyaqG8QvrZF0Fil/eqJFf/qVmpL1hlkqF5UVnk9ImZ8Ede3l4TzAizJEbpUGjnbB
         BFuC/Gvt/JZCkN2xcn0wb1eRtywJitpHY3XZ+Hw0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4zAs-1lA8Af1bHw-010umv; Wed, 09
 Jun 2021 03:05:22 +0200
Subject: Re: Write time tree block corruption detected
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     auxsvr <auxsvr@gmail.com>, linux-btrfs@vger.kernel.org
References: <1861574.PYKUYFuaPT@localhost.localdomain>
 <3113674.aeNJFYEL58@localhost.localdomain>
 <4655545.31r3eYUQgx@localhost.localdomain>
 <b45698d3-b208-bcec-52b4-5c8e70804148@gmx.com>
Message-ID: <b5596fac-26a1-5c5a-5653-62175073484a@gmx.com>
Date:   Wed, 9 Jun 2021 09:05:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b45698d3-b208-bcec-52b4-5c8e70804148@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PvWwJqlvDDkmV0ul5HKDl7I3hciV1E+OmwQ5ESl3hARyqgXBLrr
 CPxfBbpQnEVmgWBz7JOQbmbtu4uULBV2s08hDtAvgQc1PkC7rTPi60SFKr80afPLNRSeQNI
 eXfNLuXEYqQsRCGDSAtS+rBUjHgyrw2BHxY89BM0LGpK/MOFHjqYjz+pCUOBEaZcul9zLWM
 /JGpTuvThRAEWy/fnSzGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hL7R8ifz9c8=:m3HQdYx3aWBUFqKdf4dk3m
 S3IW4RL1b4pLQrUDqwqAyjPlXoLJXc9rvBMFh1nfs46bIiP6j0YCURP4eEiVQib35gBJRDb3F
 TXBLYxVVmU41FsL/Mkwd9LwejNN4bB3CdidfjIH8pyZ9BKdwDjMpWKOjG/eFk39LUsUFwKFqs
 FHZajhJftb3sa/dZyXpHZg2UAkNqPA6uK+nm1YAUSYGB1UF/U4AYDQ8urrJWf76c0yEFd8EKc
 8c45Nmz6igj527qd9BORV3ulCGjc0d1osTQcCfLegc6jIn20ULZXn5sTJLjh2OC4yTeyBhbYA
 VQAEW+c/al31DpQRNp7YB91xXVIq4nvN3z/Y0TLz7MQgDT93/xQohvfv6eHwlkKjxA5QhntBO
 jUpSKCEPzvRBtL1eDLGW/PqDneyaUFglFDTHdX+YXxPikLgbccoLygZz5hIDxMvCE1yKM0ioH
 G47DQnX/jdkL1azlNuO+AKEIz03VefIq81htI+oE0S7ZL9lfW4YHXuFhM3oPEa6CoKe/v607I
 s3CdfluIaWiB2KY4VwLvOX3GvkOUO2HmQMC4BUbhNK2IFGhyJDF5TCKJWEj0CcvSzFaRCUzW3
 L7Bkkn5H6PfPTc42YxjBXIwgXPggliFP23FUJvkSrWufMxSHiGeY2dGMEt5d3V4IYMYb1y81X
 bZnTNARvfBha5PmqJyQGyfzphTc9TBZczy9hDkUrsRSaZxKk6zGOzigng2m/NSsLXKdsVfiS/
 65lCOV/pN9MuNJQCaDfULokKPrEUvKvfMdkN6uSTxACAhOLg8SxHGo4HYXhRugU47AUDjrBHQ
 HcD9XUs0XfzAA2UXGdjRKmsTK1m7Cem5kuUVd5AfM3BYY+3budE1eGVVWfmE3MiuMLfLE6nrm
 AxLF3f9yRKEyHKRFO9qMKRjNFKQgXCp56yFEsHXkf2ybrkXJVLQlhuL+ivfB3Q/k34h7gXhfQ
 1xITL6NBn4mnQwUBF1t9cTx8ebsNy/L2x63oREEtwOdSPDq8vwvI6kJRR6QNNgNpqxnMerHsh
 XHb0C0cF0fncnan5PFfCIJUyiT+bGEoid9J9AhZjGFZsiG6TjzeUKIhsyxs6cVGnLaauvcRYL
 f4SVJHsVVgQuSmr0G2lbXG3iI3s712YUXvyte11moKqX6wX2zu16Rd7bQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/9 =E4=B8=8A=E5=8D=886:39, Qu Wenruo wrote:
>
>
> On 2021/6/8 =E4=B8=8B=E5=8D=8810:45, auxsvr wrote:
>> On Monday, 7 June 2021 14:55:10 EEST you wrote:
>>> It seems that every time free space is less than 1 GiB and I use
>>> zypper, I get a similar corruption message.
>>
>> Correction: I just got:
>>
>> [26355.330817] BTRFS critical (device sda2): corrupt leaf: root=3D3
>> block=3D537007243264 slot=3D0 devid=3D1 invalid bytes used: have 645031=
52640
>> expect [0, 64424509440]
>
> The line itself should explain itself, we're over allocating the device.
>
>> [26355.330819] BTRFS error (device sda2): block=3D537007243264 write
>> time tree block corruption detected
>
> Mind to dump the device tree?
>
> You can dump it with the following command, and the output contains
> nothing confidential, but only device extent layout:
>
> # btrfs ins dump-tree -t dev /dev/sda2

Sorry, you may also need to dump the super block:

# btrfs ins dump-super /dev/sda2

One of my concern is, the device used bytes may differ between super
block and device tree.

Thanks,
Qu
>
>>
>> and:
>>
>> # btrfs fi df /
>> Data, single: total=3D55.98GiB, used=3D43.04GiB
>> System, single: total=3D32.00MiB, used=3D16.00KiB
>> Metadata, single: total=3D2.00GiB, used=3D1.17GiB
>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>
>> # btrfs fi show /
>> Label: none=C2=A0 uuid: 44c67fa4-e2c4-4da5-9d07-98959ff77bc4
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS byt=
es used 44.22GiB
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=
=A0 1 size 60.00GiB used 60.07GiB path /dev/sda2
>
> My current guess is, there is something wrong in the past, leaving the
> accounting wrong.
>
> It leaves some ghost used bytes, thus causing the problem.
>
> Your previous btrfs-check is able to detect that, but unfortunately we
> don't have the ability to repair it in btrfs-check right now.
>
> I'll work on repair ability soon, thus if you can keep the fs, there is
> a high chance to repair it.
>
> Thanks,
> Qu
>
>>
>> 60.07GiB used again!
>>
>> Regards,
>> Petros
>>
>>
>>
>>
