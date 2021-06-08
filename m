Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521FA3A0739
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 00:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhFHWlv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 18:41:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:55479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235467AbhFHWlp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Jun 2021 18:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623191989;
        bh=nnLy+FVe0Vb46Ll8Y/Q+UdwsJL4EXgA4Cm9UxQ7dzBY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fBR7qP1PBXdbcm8uRqwrCqNfAT/HnqAIqAWKMyfo8+q3n46i4islHpttMhlqE0OCj
         ezhnGTfLyjnSTz04/yO4qvJXPZwaCaZ9zW3yJtb2jJu2PrHgxXTqfs+L8sTOMg43i+
         5zzhBB7rmCZbo6q0qV2Mky1C656OEqWHFc8EfMDo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRRT-1ls0mF0Cx1-00XwNB; Wed, 09
 Jun 2021 00:39:48 +0200
Subject: Re: Write time tree block corruption detected
To:     auxsvr <auxsvr@gmail.com>, linux-btrfs@vger.kernel.org
References: <1861574.PYKUYFuaPT@localhost.localdomain>
 <3113674.aeNJFYEL58@localhost.localdomain>
 <4655545.31r3eYUQgx@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b45698d3-b208-bcec-52b4-5c8e70804148@gmx.com>
Date:   Wed, 9 Jun 2021 06:39:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4655545.31r3eYUQgx@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b8+I9aFtBqnf1N07F9314ln0zc67UHnpKoxzsp0JAAdxycJzXtD
 O2I2D4NaoOsMnJF4tUCI6LwPVyjcHZe25XaoXCZw2tsvObl2WOilyi5i6GKo+uZgPdoGFdh
 L8WYHGo0NEUnjJJlgLJ9Bg/p6XdRWWpNmg/s6Dr3kOkQ8j1CbIGaQQBv+XKEYOjSVJGJoBE
 Y78mm0C6NfN7OvuuGKq5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vyacB4gZxZI=:y+qdPPKeEzXHm4Kd5u2MkO
 Ok3dISVqzDkDdjaXuzgfyYop6mK2XW3WmiGKX3ZLJofiI3HJ2EwJDMgyvW0Os1JXB+UGydgBS
 XlXupNBPScF/MQAFjGxftlxHq3JY1EzWZ8bwkXzJbGIWkrlYDI4Z0b6PY3rNXJDBILBeIy5jr
 79n2YFbk8fSDuxpirBV3aMinojdwdtJYBxw7diCmFGIrp417ktcgIeZ2WHlD9k5Go9yHGTNpm
 NBFv/C3tU3AdqGlpAvzpb81e2urH9qHh1IjakPbBe7OoqMT6S1Bx/HPccVnCW5F8Qb0fBrNjK
 6j8hmjriaRbA4vgiQp5aQDZ34LHgExmV9boKlzJJpOizo1gFdIYrLo1xQk6RYsQUr5RS7Iox+
 koPgSiuFZGcvmlEqu1fK8vWR2qGoQfJg0uAWBxGzGese06WMqsV3Q6n/CFJqxnbWLrVcadeut
 /+iagXjCghKfXxMIcIOz2PJeR8rVtH4C6PX8GVlZawOW3Way5mup+W07U84A4xdyG/+KewnPv
 +H7zipz9xbY9675rU/+/mcoqNvBCVRrr36e7cSH9zd4ZcsiXGBaoyQV5qq2MQWYa+zNR0IOb8
 r8ZoQ0mdVW6UBbofSbDhHQEuZPKOVPdDCT8wPnXupCWUEhKYiVBU9T3hm1mstxxu0mvifz9dB
 mBozNPNtIPCxvRt7tCkkwxXIOgwoDkcC5nvcTe26surCSj9r+auFDq/u2CQ2hiSGw9al9wHsb
 /OERxwX78uhkp3ifgye+wb7bZBV3++Mp7hOv7gmXf1lmWtmdapuXaxIO2LhRUf3aGNog/G/rf
 wbihxNvp11TljU3GidI1XZFyu2jmRBVILC9ym0cuPJxTeSoWE2ir3IrbszGAuTB3H+P4pHanw
 ev1A+RYUu0W/vhJpNhiDcTb/TmlIg9HPIjJ90PCxsNNRQOHC3ium5q1ZlfDc/qqiCpHbxc43i
 gRc5QpB/6M9yLcvNB9Hh8TSwsMQdOCElvECiyUoKLvHmjSzb5aDC2Rv25Groj2xH2Rko+OYnH
 TnrTr87CRPEqK8krT3InknZB9lsBgPV9ORBQkwCCDqeIvOYHgX0eb2a48EG0XgOVfodlxouRM
 Kne9Te6WdO7njiHXybn9QswcYEW1Y8PaA+SH4llm0mOEOtMprKkCUSIYw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/8 =E4=B8=8B=E5=8D=8810:45, auxsvr wrote:
> On Monday, 7 June 2021 14:55:10 EEST you wrote:
>> It seems that every time free space is less than 1 GiB and I use zypper=
, I get a similar corruption message.
>
> Correction: I just got:
>
> [26355.330817] BTRFS critical (device sda2): corrupt leaf: root=3D3 bloc=
k=3D537007243264 slot=3D0 devid=3D1 invalid bytes used: have 64503152640 e=
xpect [0, 64424509440]

The line itself should explain itself, we're over allocating the device.

> [26355.330819] BTRFS error (device sda2): block=3D537007243264 write tim=
e tree block corruption detected

Mind to dump the device tree?

You can dump it with the following command, and the output contains
nothing confidential, but only device extent layout:

# btrfs ins dump-tree -t dev /dev/sda2

>
> and:
>
> # btrfs fi df /
> Data, single: total=3D55.98GiB, used=3D43.04GiB
> System, single: total=3D32.00MiB, used=3D16.00KiB
> Metadata, single: total=3D2.00GiB, used=3D1.17GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> # btrfs fi show /
> Label: none  uuid: 44c67fa4-e2c4-4da5-9d07-98959ff77bc4
>          Total devices 1 FS bytes used 44.22GiB
>          devid    1 size 60.00GiB used 60.07GiB path /dev/sda2

My current guess is, there is something wrong in the past, leaving the
accounting wrong.

It leaves some ghost used bytes, thus causing the problem.

Your previous btrfs-check is able to detect that, but unfortunately we
don't have the ability to repair it in btrfs-check right now.

I'll work on repair ability soon, thus if you can keep the fs, there is
a high chance to repair it.

Thanks,
Qu

>
> 60.07GiB used again!
>
> Regards,
> Petros
>
>
>
>
