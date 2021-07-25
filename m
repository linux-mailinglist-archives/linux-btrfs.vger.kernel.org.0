Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C317F3D50AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 01:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhGYXJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 19:09:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:37295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhGYXJe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 19:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627257002;
        bh=cjU50OrO8hfxCu6/UE+6sT/fJQdjbfNHqj6k7w4Hh+Q=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=KQk9aUfWq+fz7CIsUoZPjcdncN+OjwCVpYiPPcZrimvuyzAsd6g5V8FBOPNnnnFd6
         cnomttXb5ZrTDh2wqSw7Sz4BVdiF1vif+QjMFCHXvZPRKCUCALM5YaCdiheFdMC4Mc
         i2sJ9MtgEnNsybPKHjPIIlilIiUmIL4UMAew2lO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1lJYot1wBm-00pOBu; Mon, 26
 Jul 2021 01:50:02 +0200
To:     Dave T <davestechshop@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: BTRFS scrub reports an error but check doesn't find any errors.
Message-ID: <33666874-d0ea-3fd1-cffd-e16ddee305a9@gmx.com>
Date:   Mon, 26 Jul 2021 07:49:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bR7mEr6TLdKM8W+QPypTMOsLXT8SEtxdvtMqLHaGYOa17DVFD5q
 T9sx5BJpSZ37Pm2d6u2BGGzJX95u/CXGLyt6VJHgPpwcEptOVwTPOYvUZqpANC+ODgBXtXG
 48k85u2YUqrQqG+lWh1IiDej+AB1HwxOdw4NeHBw4aEGVmwdjEE7HljMiHlZ93a1EUqG3ql
 CsCJv8c/zKGuHnt0voktg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tn46S3IkS40=:xHDyJjjVVkrWLQzmPNVQYF
 V6nDgGLuchlErDcyqqK7UZM0YwBukXHM5oDYsBjUMHuZpUMQ6CBreR39SAiWjZDK2AnAxC+mf
 5Ux6J2JxUuHX8TTYRLbUR77VezNQ+51pwUE3VQkm21yjKWiBzcBS5PQ84+nw1QhCivjivUuir
 0IHFueEgAhFtEyjdjL0/+6mBgkFLyjHI4iyAEKf5M2e5MPJ8lm3GDtDe3apLNrai3mVNM7EO3
 mIrqiqrEv4u1EYRrJsNBni9nfwvVChaTw3bIMsIwEIedX9oGhl2i15BMsDQtYKPMoLUp/Istp
 RY/uwkAsg53zEjTpI640DbeqUoLNZgGIULtQtTV74UqsHtpZDyjjFSmIFx/xsjfGopntWoeO1
 HCevdmZWfEWtnejc3zG2XFzZorJnGnPM943De41mnHPsTzC4GbVXtsgdUM9WHEiVdFvGWARyQ
 Zjs7SPFpbLFlqDsvpBZ4QV3dv1KOlcw8KwHdYp3xv4or7hnpg1kY1QiXBquctqwZmQy/gCiU8
 l/kJEBj7mCDXGF6grWcKCZVtlne889cKJ/HUPgygtT/BKriOSNkd97oPejTiMSk/cNOrCJjtx
 QVN5oOyatFT/AXxnNoD1+67mjQqc6WhQ/v2N1ZP2tCTUC1NZxqqskm8LnlbZiipu60df697Ge
 RuAvp0Qr1+nU8/hERlCvuvN8ILQDc85FgEA0UJ9ls4rewOPJiM4wh3qIyvPcA/erp0ZmZ17oq
 W2vMxsxltGFS32vnSUPjxS1ZTPmbRki6Uvw4JgnMfmDIQtWO+I+VLmxjfSEPtsuWW+/JZGqwB
 oa4cxLZE57KEjoMv0int262ynrQisCLdSECpez1ttJBoZbnu8G7BdQxZ0QNoH4suu5ggTeWtG
 yk2l0tmqEkoXMTOO0eYrv+NRUFUBPGDE28PNkaIgE+7N7JpFRv94xFKBiwE8YUnDrBTLdpYaW
 od0WG0ffBCIuZS4IHGUXU8dz4mmjpV+DIGQwy9yIFIZIlJjiOPzJqpRaMXxsgtr4bVJhCjNGa
 xGWxQ2yVd/eZVXvprCl6lxWHNo9ccORs/JWU8KDnjrxNLpRixafseaFf2D1F3ByH43PFeKyR+
 EYjvJG7Laz0Yk3wMtadv2WkDEijIoNJp+aBiOuiT3WSQJs1TyIoMcyw/w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8A=E5=8D=881:39, Dave T wrote:
> What does the list recommend I do in this case?
>
> starting btrfs scrub ...
> scrub done for 56cea9cf-5374-4a43-b19d-6b0b143dc635
> Scrub started:    Sun Jul 25 00:40:43 2021
> Status:           finished
> Duration:         2:52:45
> Total to scrub:   1.26TiB
> Rate:             113.72MiB/s
> Error summary:    read=3D1

Scrub checks the csum for data and metadata, while btrfs-check only
checks the metadata, it doesn't check the csum of data, unless with
=2D-check-data-csum option.

>    Corrected:      0
>    Uncorrectable:  1
>    Unverified:     0
> ERROR: there are uncorrectable errors
>
> dmesg | grep "checksum error at" | tail -n 20
> (no output)

I'm more interested in this problem, scrub finds one csum error but no
output is pretty weird already.

>
> # dmesg | grep -i checksum
> [  +0.001698] xor: automatically using best checksumming function   avx
> (not related to BTRFS, right?)
>
> # btrfs fi us /path/to/xyz
> Overall:
>      Device size:                   2.73TiB
>      Device allocated:              1.26TiB
>      Device unallocated:            1.47TiB
>      Device missing:                  0.00B
>      Used:                          1.12TiB
>      Free (estimated):              1.60TiB      (min: 888.70GiB)
>      Free (statfs, df):             1.60TiB
>      Data ratio:                       1.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>      Multiple profiles:                  no
>
> Data,single: Size:1.25TiB, Used:1.11TiB (89.38%)
>     /dev/mapper/userluks    1.25TiB
>
> Metadata,DUP: Size:6.00GiB, Used:5.26GiB (87.67%)
>     /dev/mapper/userluks   12.00GiB
>
> System,DUP: Size:32.00MiB, Used:160.00KiB (0.49%)
>     /dev/mapper/userluks   64.00MiB
>
> Unallocated:
>     /dev/mapper/userluks    1.47TiB
>
> # btrfs check /dev/mapper/xyz
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/xyz
> UUID: 56cea9cf-5374-4a43-b19d-6b0b143dc635
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 1230187327496 bytes used, no error found

Since btrfs-check reports no error, it means if there is some real
error, it's in data, not metadata.

And since no error message, the only way to catch the problem is through
"btrfs device stats" command to see which device gets is error
accounting increased.

And since the values are accumulated after the creation of the fs, it
may not be that obvious.

So you may want to record the output, run scrub again, then compare the
output to determine which device is affected.


Or, you can use "btrfs check --check-data-csum" to do a "scrub" in user
space.

Thanks,
Qu
> total csum bytes: 1195610680
> total tree bytes: 5648285696
> total fs tree bytes: 4011016192
> total extent tree bytes: 379256832
> btree space waste bytes: 827370015
> file data blocks allocated: 5497457123328
>   referenced 5523039584256
>
> If more info is needed, please let me know. Recommendations and advice
> are appreciated.
> Thank you.
>
