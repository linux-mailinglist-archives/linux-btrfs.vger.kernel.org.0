Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D8E379AC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 01:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhEJXbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 19:31:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:51285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhEJXbr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 19:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620689441;
        bh=zE5qikhTcdQcfsVK9+Ck3QK9WafNakIJmxlVyHkeFPc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EBwKnmSiCVSklsk91rsTZs+sUSdnwTh1+W+hleYA1bn7XnNFGOG1Uw4c6zlTWcVyH
         KGlC38XhXpcv0ShVW87SAI5drZqLWhHdFFcoNocD/bwqbOpnAR6C5oKlIJlzpS4SN/
         kY9DOum7zKPttDt/GoVujkjUIp31KwjUH6od37/A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2wL0-1lf9xs0pcC-003PQq; Tue, 11
 May 2021 01:30:40 +0200
Subject: Re: 5.12, notreelog isn'tt shown in dmesg or /proc/mounts
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtQtidkf2n28Lr2dETV8zcskQtZk5s9tAgGd6XU6sSetSw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <becccbfc-817e-1af1-61ac-14e6aa6bc0b8@gmx.com>
Date:   Tue, 11 May 2021 07:30:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQtidkf2n28Lr2dETV8zcskQtZk5s9tAgGd6XU6sSetSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DuSwL7+xuJa2hxn5ZOEF9Q4ztPQvD3LpNbZEk0rowuciGKfnXZJ
 upaSwTFK6iw5njNonU5UpY30rE7/0tl0dJ1JQihT+/uG+oRHWaBAjJRBchDnMQ6jPKyrzJp
 /qj3N81jSepRtrtG0T2LZMrTfpiEzAiIjrFWIld2dV/6MFdFu/EHSSRvAF+M/KlMmuKU7Jo
 zOt7PjTYtbsJ4NjlnM3PA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:W/suXla2OxA=:E+hMoYXNiOHCGLh8yMYGBe
 6HiDSEJ5wahOF9y0cG3nA9aHNVlMjuLEA0azPRwfEMGEvvhbl3AI4O0TaXcgKLZ0aoZuLBlF3
 ZAfMBFVzteO39/NMsO+Hsn/6ns8MDTtNn8k5/U/lDJJlldC23nyjIqzT+aDrrrqR+T/n2f6Kj
 IqJVji54eZXxA76J4KQo1nxHdLtlM+Y+vs3cIWCXng7H4ru4hfS4DNiOK4X2VKlcfXonB1ppY
 5X0sAOr1xGdFtNVbw4HU3AGdxxjyYDKXLOEUwO2pkFyPDLqcf31JctIyS2POy3wZHEgTwvcSw
 OkS7B0ZSeUDl+WL3RijavoBIKyEoT3RvUooj2hD70FD37sKpuHjB3Nx7KXwTrTC9ws9UOACHZ
 J8Pv/NsDRUzvozeOYjW52D59il5uCB7Lg5u0oZhJlhwQEFv1fkQeeW8dkoMwpx+E6AO78Dr5v
 9GJ0wJNm04SiTfmxax4EfxEpMTAVk3tCBgfRPGrU0+Ct96l+35eexpsySA0kyetH+iDVguqUH
 hbL/JtzD+FvowSamedPkXRqaspWuNpwxlCUd8GZIdkE0plLAEZMMo1sbOF2xobyxomxhNonUs
 bPi+JglHwSY4h7uEPDYSKXc8cyoCdvU8T9kX+86F8S3tcZhVu4xD9x14FfNw0YIW/BthICkwg
 7EacawL2Bnh8EsqJn04+jxJIf5mYzgrURfoTxGzLaDKQw8oJzkkm4yvB78TVwIUmZDfxelUwD
 mxcEvCLc+ocwS9T1lCLMDTj4eBsQ78snI9unRMmN+keDwJORAV4FtpxZCOP+LtUym7t22j6SK
 l8hQOqz8UCpOe5Y6On2iuvx2e8Ihias1o1w2gyVQ4sZfTGQ1JyAh5fUvxoshcGBCVhXO/csU9
 rpL02pFFWgtuTW3iM64cTjtGC5CRsifb+RinM3aUz+tLpuqM34RaiaEKbjVt5NxtIxXacMMTj
 ssxc/9nQIbTFWvriK6fFuJD2XqwjoTLoyi/atg5EI7aNMx5yZ5wB9WROGspansVGow6zckZwm
 EGKaXprumvNGNTiGK/tumJZl9m0YpLEUJScfn68n0+bsHLbdD3AqL04xVD47wouWvQp2JsKj3
 NRJK+2xO65+N9e8FvBvatdFhQdZw91kwzAJMTDYK7f9OL2Fhm3ntpRdnMnzyyCIVXAHAufhnC
 LGghizZ0J91NJCs4mOJ9ojPc5pTy8T9lCIBYzaRP7/nTJp0V6tsMXoDRx2iDM6nnuP6/oyipX
 gLN0yxJ9hwQJP8gNu
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/11 =E4=B8=8A=E5=8D=882:37, Chris Murphy wrote:
> kernel 5.12
>
> $ sudo mount -o notreelog /dev/sdb1 /mnt/0

Is the fs already mounted?

`notreelog` mount option is a global one, which means it must be
specified for the first mount of a btrfs filesystem.

If the btrfs filesystem has already been mounted, just mounting a
subvolume won't change the global option.


>
> dmesg shows no messages
>
> /dev/sdb1 /mnt/0 btrfs
> rw,seclabel,relatime,space_cache=3Dv2,subvolid=3D5,subvol=3D/ 0 0
>
> bcc-tools mountsnoop shows:
> mount            4968    4968    1076068672  mount("/dev/sdb1",
> "/mnt/0", "btrfs", 0x0, "notreelog") =3D 0
>
> Seems like both dmesg and mount info should indicate if notreelog is use=
d?
>
>
It behaves exactly what's expected:

$ sudo dmesg | tail -n 5
[   45.347298] BTRFS info (device dm-4): disabling tree log
[   45.347563] BTRFS info (device dm-4): disk space caching is enabled
[   45.347826] BTRFS info (device dm-4): has skinny extents
[   45.348049] BTRFS info (device dm-4): flagging fs with big metadata
feature
[   45.353132] BTRFS info (device dm-4): checking UUID tree

$ mount | grep mnt
/dev/mapper/test-scratch1 on /mnt/btrfs type btrfs
(rw,relatime,notreelog,space_cache,subvolid=3D5,subvol=3D/)

Thanks,
Qu
