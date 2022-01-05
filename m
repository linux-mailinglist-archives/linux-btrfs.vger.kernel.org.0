Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2C485008
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 10:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiAEJaf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 04:30:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:57363 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233716AbiAEJab (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 04:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641375024;
        bh=M0HPVzrddRLHoMOPjjWOUh8vN/gudBjPKTT304Urqp8=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=LpxK/70bXJFjuQWVr/LLZbca7Q7SUk8iIsJLD5xWijDFEyKICEfCPvphF5pcy07+i
         EjBX9AI2GdSt2qpilpobqYo2zU3lBLimoYBNKmYaI8+qRibZnA8CWu5bSeFhSmpwZU
         BF36av8/QYMTqJx3HK28tXC4798E2/4JbwioAwMQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOA3F-1mkvLC1jRZ-00OTrA; Wed, 05
 Jan 2022 10:30:24 +0100
Message-ID: <74fcaf5f-13f9-dfa0-0576-8a6da3cc8060@gmx.com>
Date:   Wed, 5 Jan 2022 17:30:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Sahil Kang <sahil.kang@asilaycomputing.com>,
        linux-btrfs@vger.kernel.org
References: <20220105083006.2793559-1-sahil.kang@asilaycomputing.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/1] btrfs: reuse existing pointers from btrfs_ioctl
In-Reply-To: <20220105083006.2793559-1-sahil.kang@asilaycomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dSa5Xz1tRdaPuTGk24Wa91CjsMUgfpuUfN7KP/Yh/nkmd2TLibM
 PhkRgGHp0axyRiOGYcOAuT/IFIQjAvgYYFdr+uZuqqXfebGE6mhgf92RUB2gmgVp5u0RERH
 axpHUfc1g/ixBwIz5BJ6bW8WwKi5co+IYe/UQd0q10Chu08Xh4LXEU9otVommBFdkE2WZvg
 gh3Byx1MEUvyvDzDWTiRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qpojk2fgE0o=:sg3bbtKMOrwD392paJEZIR
 tABtBzr0fz+lbLbcJ2epE1DDMnWs5feobdb/OGVvePG5NzpoE3Er0GSrQwgAL4P1MM0IyzW/+
 69a5Dp9xl93zdzAZr8m7Lar8wN+V4NOexZmcv7Yx4zxTGZsW44h3f7iuHnZquRNXFx12kC6sc
 C4ifQHNwqfLjGUpZLCE6Sw403ECEivw/PmfdWjFQYnMK25lyOcpSDWPspLBPiUgKM2+i+FY84
 978PN786gyjJQFTqfd89oS+PkUE7fAq8fud/YFeD+XkPksEouyOnQF492RnLvz1ebV9+csWuW
 /83QAQaj82VHrw0a7vob4XnvbmHOUdPhgjzM7O16LOqMccXJVf7RRV2Jj4Un61xuCksIzHT+y
 O0/hehMziPqa5+9DUTVRjGNtlrADDOdnUowpXMUdSHuTx/snj4VrZaszQGI32NnmpsrLJulIb
 OTvR8I8NXljy3WHQNGkDrBNOTybPUNv2ynUoMKDCm8mTuYtCBf7pKytHojTcbcb8DPVqPqqWP
 H4TeswhnkeCjNEGZsSX3WrRQdlZ7ME6RH534pD5g1h6/rrDpMVeq796sdb5SEfT5l/oS4mdxx
 0KcwDrKjsfzbC0UjcK4/9xZzv2ObYdQTf8LyMT3on3fBl3fyhe8FZQbRxhoaLY9UpyXhcUueQ
 da9JuRTkC//RjcowJrMDCLX+xrbK+r+mIJn+aPI+17UkZeXsTtDdYnVyHrBISTLk8nJSEYuCe
 Joa1shwW8Lk1gMoy1uLTm9A2ChRnKq/wOQRsKrWGMuLeFtsLUUxHRbYdh51kQHV4Q39AVnABp
 Vito7GkfLIElPAr9sAOFYogwyNZsXwQOk0sOe9rk5XMatpYOhV6uSZF2hWUd2j/n/EGFJBu7b
 m3yFCOSV2bUAswQf+CF7LnQdLINLsIqqDHXRasCFT757SK8pXfTc6pIzvBfKT+7gNagrbrOMy
 rd73902tCbbNQkns5Fsn4kt4vUtp1+Kk8TCOQwTYJUdYCe7KnRsOU3+yhRfEqKLD1cxcVpaUi
 Dr5SjrIicFpcjLzDen+ku6EU2IzA9MaoLXDvF6WVpVZtV1/4HrXmrTGwsHEJgyYvfJBr1C/Ao
 zUcCr6FOc9Teig=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/5 16:30, Sahil Kang wrote:
> This is a small cleanup that reuses some of the existing pointers and
> removes the duplicated dereferencing.

Some quick glance indeed shows that we have pretty inconsistent
arguments for a lot of ioctls, mostly switching between file/inode.

So the cleanup looks good to me.

But I also find that, there are ioctl sub-routines that requires file as
it needs to call mnt_want_write_file().

I know I'm asking for too much, but maybe it's a good idea to separate
those ioctl sub-routines into two types:

- Those write ioctls which need @file to do mnt_want_write_file() check
   So they can use the existing @file argument as usual

- Those read-only ioctls which don't need @file at all
   Then pass @inode/@root to those functions.
   (Personally speaking I prefer to pass @inode and let sub-routines to
    handle the root grabbing)

Anyway, your patch looks like a good initial step.

Will give more detailed review on the patch.

Thanks,
Qu

>
> There are other subfunctions that have similar/identical dereferencing
> as the enclosing btrfs_ioctl, but I'm not sure if changing those is
> welcomed since it would require changing their arg count. Right now,
> all of the sub ioctl functions have essentially the same signature.
>
> For example, reusing the pointers for btrfs_ioctl_set_fslabel would
> require passing in *fs_info and *root, in addition to its current
> args.
>
> Sahil Kang (1):
>    btrfs: reuse existing pointers from btrfs_ioctl
>
>   fs/btrfs/ioctl.c | 28 +++++++++++-----------------
>   1 file changed, 11 insertions(+), 17 deletions(-)
>
