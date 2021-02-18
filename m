Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739AB31E7E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 10:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhBRJVs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 04:21:48 -0500
Received: from mout.gmx.net ([212.227.17.22]:51975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhBRJA6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 04:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613638750;
        bh=SS3XzTU02x2x0dlCeYeAnFRlX2+WtXQRoMTAMh6D42s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Wnqqt6lrxOx4HIt+kNP//Lcu8AP9SO67bZgV/ej5Iqfn+ExvqRKZOxqbnYA20r3Mz
         9URLXap//L4/z9JXo34pg04ZZzi0m4jJy2lbyyoEXRcaN5KT08XnQRS75pCn/I5DTK
         TcbDu2/pHNG8i2XXH18/OoaPUrLyuNGTcDEPi7X4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mGB-1lwlj41atX-017EJV; Thu, 18
 Feb 2021 09:59:10 +0100
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <mtwofibp.fsf@damenly.su>
 <CAMj6ewNYSnFUFPER06qweZaypWC6qVHmUX7gYxRXO7Gbuw_16A@mail.gmail.com>
 <CAMj6ewMSw+UzZHhEEN=rhxN8O3pN9gWA05usAodk2xX5+s-Qjw@mail.gmail.com>
 <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com>
 <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
 <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com>
 <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
 <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com>
 <b06c1665-7547-2321-3863-4c68c9818f90@gmx.com>
 <CAMj6ewOze4Ngw7ydj_Ry2nLeyvWs_dB=fuGJ2zBdCEepTiC6yA@mail.gmail.com>
 <c6c8cb80-455a-181b-ada5-83001d387044@gmx.com>
 <CAMj6ewP-xUUa2G448HhPDPV9ZB7XiYVf4eCv+SMMtLH5MzTJ8g@mail.gmail.com>
 <08061b36-c49d-9604-49dc-7e85720b5040@gmx.com>
 <CAMj6ewM2wr2tRrMjRk+sztH0nD7RG1J4tXKfoekg3-rqEL3RWA@mail.gmail.com>
 <50599154-2ab4-2184-7562-f0758cf216eb@gmx.com>
 <CAMj6ewPGbkxH-OdsRt+xKQyLUUgR3J7dV7Xcf9XMq2-E=n3-tA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b040e855-c0a6-cd75-c26a-4ed73ffeb08d@gmx.com>
Date:   Thu, 18 Feb 2021 16:59:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj6ewPGbkxH-OdsRt+xKQyLUUgR3J7dV7Xcf9XMq2-E=n3-tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+cMdBXVhKHlMwWkWepy9Noxw8yHtMDMMNRlV8RrQ/MT0HTSrYNY
 8tx/E0utOgzJ1NcKS5IKqeLbdxrJOnOc7NvdbbhI9JlIiUXEqc6/gywAaJRRkyL/kCY5Vfn
 VJyZ6AUasMJgWGvUXdskZJgxjOvg/CbxGGF8w4AgK9BdCrK7ytAopCuw0/5+hy2aDOkZWki
 X/JJJK1hVFtWyKbXKJFOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kp+7LbPdYxI=:aKwPjuGLj75RxbPIJ6Umas
 /O4WH0Xve8pH8Bi0t5eaM8+MlyweUMJBmHFXWZAEuWHQ4Rac0xrF5go2krrC+OeDRH0lW381a
 M73FdBk5MjM53Q0wUHlRrEW23b6bcRFHrfPMV7LUjrCAcxgkgPRA1joLg9lCU+kf/2oq90cuV
 D3CFY6hVyGLFlnxV+sP2hhoefwq65si5DCaclpjuvQ4sgQvCN3idivq72l9k/fYvzz1WBg2Fh
 pM2mg2RpKedZgzvSGLixnNK1nE1V0OsqYXWicLHaogfmBqB9fCTvbnh+wc7te1ZA7NOnHOkgP
 wX1a+JjtObQyJhOyV6PKilz+cBcazU6DjZ7JYMA1peqYnghKR/7NizA51l1sfUM7jqg7/A/9T
 ihG8mLqU+C1MPKUP2V2V6kvmg+rAXXhvkKjyjLOttiyULC+NZxcSd5EDjd0Jc99dIcLtLMn6C
 Gak3nTAuqWl864zNX3Oz9icb98Izuwl0n4Ak7R/GKg7CyDpbuVBZoQPjvhmxv2h1VwhxqyEms
 zR89fMHyHQ11r/RkZtImLjn+49X6mtRlut0sCS46vWIs3of4qRV7BPhgAeqHdQMtT8jCRFfQG
 LKHCegJWbmPAw9QzykITPEIpU6DNruV4/vwKeiKZC7qwku49GmbG48ngBPrNB87UJsmWHzHnz
 /hmvZDAg1iYdqSle7Wf7/1SlrJOSI6EGxEkteT69Dgjn2U/fNdYiEiZjPceXJo5P2Y8NF2ZKs
 g1SOb/YOokliRgaCBNjIjyrGUzP85W9hPu5s5JhKLBn7Klwhs8QNSSzLrZoPpjYXLYDRrrNmM
 /vIpTDabY+KDvNvA718pXokaUa37qHtyiuSz55sFVuAZ54lFQfa88pp8b/vCnNsF3Tn+Hi9ZI
 tlDK+lWCwnvrx59HdBNg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/18 =E4=B8=8B=E5=8D=884:52, Erik Jensen wrote:
> On Thu, Feb 18, 2021 at 12:38 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>> We got it!
>>
>> The eb->start mismatch with page_offset(), this means something is wron=
g
>> with page->index.
>>
>> Considering page->index is just unsigned long thus when we initialize
>> page->index using a real u64, we truncated some high bits.
>>
>> And when we get it back to u64, the truncated bits leads to above resul=
t.
>>
>> The fix would be pretty tricky and with MM guys involved, and may need =
a
>> much longer time.
>>
>> I guess this is a known bug, as page->index limit means we can't handle
>> files over 4T on 32bit systems, even if the underlying fs can handle it
>> (just like what you hit).
>>
>> Thanks,
>> Qu
>
> Thanks for digging into it! Is there an existing bug or discussion I
> can follow, or any other way I can be of assistance?
>

Just send a mail to the fs-devel mail list, titled "page->index
limitation on 32bit system?".

I guess your experience as a real world user would definitely bring more
weight to the discussion.

Thanks,
Qu
