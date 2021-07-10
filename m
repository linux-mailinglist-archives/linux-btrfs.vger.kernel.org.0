Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B54B3C3404
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jul 2021 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhGJJyG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jul 2021 05:54:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:48599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhGJJyF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jul 2021 05:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625910651;
        bh=rNCVxBHmPctS53HeFKMd6n0XPmTA2Jg1L06jL0bdLhc=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=GQmFNAdOA5vgsM5r04A4O1Kcd3bubhhIfQyj+LtuT/tk3o4V8Y8E9QnkyG8Y+J0eB
         QY5+skj1MYx5vfSlzqvqvlfM0J25NfnNDIr+nnhI2Rz86tSo0OIK2j1w4Dz+eMGAH1
         76XoFkQxiXDWP83czYL8jPs722+vUl76Y+vvsVXo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKUp-1ljeLN14DX-00Logm; Sat, 10
 Jul 2021 11:50:50 +0200
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1625043706.git.dsterba@suse.com>
 <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
 <e6a4b354-879b-a767-3f21-2535e38e8571@gmx.com>
 <YOfwuQPtXScmFULF@infradead.org>
 <dbddba2c-9242-d8ab-3969-86e7b2974727@gmx.com>
 <CAEg-Je9ESQ+Qvq7uVvV_K3ZGgNrD-kYzJMJif=3e5cCe8p6aXg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/6] Remove highmem allocations, kmap/kunmap
Message-ID: <95974239-b63e-75af-0720-7fdb10e9fbe5@gmx.com>
Date:   Sat, 10 Jul 2021 17:50:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je9ESQ+Qvq7uVvV_K3ZGgNrD-kYzJMJif=3e5cCe8p6aXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5pVkTgbkJT560B47gb8jIXtNN+1HprewJir3i++TSnHnJdIeTk1
 uP0q4h+AlLGXNER7cuWf/LDlLptl418aq3NQ9V8NfPJja6loKgNx3Fctob1HqvpIsfwsvzS
 l6jLPFLAevdnLLnx0ra4TY2P6Tb+erwQp+mzVBNjDt5+DTUfsnUnLRFwLfpK7lJCDk1R9SU
 vy4CXEVZ4rAP/7lKFse/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FQwY6iRzwkA=:+BiEtXuWlg4s9gPdnyTinE
 6EJDo9nTf2SwE+xOjrVu8efgSobNWLm4PgjxpyBLVTA5+G+TK8fgPMv9WOE7/RwuIWyfi6qy7
 MZoFHfeGoDmuI+6RNvj+4b3ToKgMobv6+bR7qJmPpe/4g2uUyru5rc2EmYQtcRX9OBfHelH+T
 JF26wgH9/0mLBBokyiMNweS3fhVkTC95TiZvRWsOzHTTyshYphl39SoFx4X1Lo3ujwxh4DQ7i
 +DvT0oCrCnikQhNkSxo0AGSUl9mmq7rY7HoTesZbCJLg92tgX/6p5Ov9tu+IoYEzHHYRur1yv
 XK+xs6F+nRoJyHqoqPu2DY5CcQwzbeGyqSvdN9doHJjHlwnpV4VC1xambjbScIkb2jXZZX1W2
 CxIdmUt1YQj/heZKyKU4GaShwRteWz45g0sAwL8soSOyVcxaa8bV07IJRhNNHO8kWrErWi1yQ
 3RasRXfT+/EvE6FpZhghh/t28UyMK3zU9387PT124XfbaBNNRmV3uXVlFJGd73IBPv8Wlt/e9
 pIhqzIW5dUHTCg5BoSDhOJwz5iA3KZwLA/1XM/f4cuNcuK/at7+nLJ2NqI8FM6bKlym1yrPoa
 5GhUZY/AgAX8OL5zhs7j/TKqVaxIXDXmEGI08s/wo4pFLy/hfFHyd0kHqoY7ppeKru444xUqC
 dT+S84Gtkj4APdX8xh17nkOkI/ue+uZo7NisocSSDe/SerHN++Hu3WDmIG8Js8mU8uM952p28
 1nZ1Ape2cEDZp+w+k6biJXQgD6qUVNZtDQBZLttzVVGhRo1vDnTszpZyGhzdT6vYuPUYFYpZ3
 690471+lRSK1mqqDMvS43L3PM4sSHGmdQeODNP8pJrBwYW5ecxgZMlXgu0u7GsgjBcdIBHzUX
 a+/UbwczXM5ehi6440XIdUTIET8m1IlucD7OGLN4akavN0KNeNI5JitEgNRf3Y5OzkLZw5o3b
 Wf6lVi7W3qs0+ftHpXbUKD454kHt1Kp8ybzlp2Tm7hrHse1Lcq7ZTfL47zEjl6ufPcvxdOXkW
 04hF80ul+RT6Wc76uH10Azb1hoOvPYrR2jJ3pi5kvYdDPk1qrX6sn0eK49xERYz0W4D/j4Hnb
 1B5bPBt80emP0qKOPd2121PkRuTHQDFi+bq21bKSKPXpA5eEXMvTjGF6w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/9 =E4=B8=8B=E5=8D=888:15, Neal Gompa wrote:
> On Fri, Jul 9, 2021 at 3:12 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2021/7/9 =E4=B8=8B=E5=8D=882:46, Christoph Hellwig wrote:
>>> On Fri, Jul 09, 2021 at 07:53:39AM +0800, Qu Wenruo wrote:
>>>> Sorry, I can't see the reason why it would cause performance drop or
>>>> higher memory usage.
>>>>
>>>> The point of HIGHMEM is to work on archs where system can only access
>>>> memory below 4G reliably, any memory above 4G must be manually mapped
>>>> into the 4G range before access.
>>>>
>>>> AFAIK it's only x86 using PAE needs this, and none of the ARM SoC use=
s
>>>> such feature.
>>>
>>> Arm calls it LPAE, but otherwise it is the same.
>>>
>> Yeah, and I have never seen any toy ARM boards using LPAE neither.
>>
>> Either those boards have too small memory to bother (<=3D 4G), or they =
go
>> directly aarch64.
>> (And most boards are even aarch64 with <=3D 4G ram, like RK3399 or Amlo=
gic
>> SoCs, they are aarch64 but only support up to 4G physical RAM).
>>
>
> Raspberry Pi uses LPAE, I believe (RPi OS is 32-bit for support for
> all RPi models).
>
>
>
OK, you got me.

I thought everyone would just go upstream kernel for RPI4, but obviously
there are tons of guys still relying on the vendor kernel to provide
things like its VC4 user space tools.

But in that case, it's still not a big deal.

For RPI4 with <=3D4G ram, it's no difference.

For RPI4 with 8G ram, it will bring some impact, but I don't believe it
will be that big. We at most allocate 128K (which is super rare) for a
compressed extent.

And if the first 2 sectors can't compress well, we won't try again on
compressing the file, thus under most case it should be way smaller than
64K.
Not to mention such memory usage is transient, only when we read/write
compressed extent such memory is allocated.
And when the read/write is finished, the memory also get freed.


Don't forget that, our biggest memory usage, inode pages are all
allocated without HIGHMEM, just like XFS.
If it's causing problems, then it would have already caused more series
performance impact.

Thanks,
Qu
