Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A99A411311
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhITKsE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 06:48:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:46317 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232491AbhITKsE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 06:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632134795;
        bh=ziq8O1Qc5w5Ib81AMv5f2S9L6iobHz+t/goRPnO8L6o=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=WJW90Rami4bWgQ5yWWqEK5cUOaBBq1sNHxni75KSCwsP9dBxE61nrGkiU3XuCsM/v
         exoYDDetZvia8cfnuPm/4GmxmL5gVGdZHOPy5dgdF5AucWi4/uatNEUlQ2qiwVvHAm
         k3xNFkuM0KTL0INJdUjNYro+WUh2OH+L61It9eKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQMuR-1mFIPT3Pvt-00MKHX; Mon, 20
 Sep 2021 12:46:35 +0200
Message-ID: <e28ecf10-99c3-ce99-f3c1-218175646c2d@gmx.com>
Date:   Mon, 20 Sep 2021 18:46:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Select DUP metadata by default on single devices.
Content-Language: en-US
To:     dsterba@suse.cz, Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <9809e10.87861547.17bfad90f99@tnonline.net>
 <20210920090914.GB9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20210920090914.GB9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bn6Br2ovKeZC5/ymUWrJDVEROJJXM9MV8MENNESxQ/sw/l0oW7i
 Cwn4P7KOE5plK8kZVPhDf3anU4vYcHOl5ZwgbXSi2uPO72cE9ROyvqOkLErSVV996WjEgwc
 L/s7jee71AnQttdg7HRuJOIGoen/hKB2h71zYt2tscm3hDfFLuqbP0GIlH8si+CV8Sf44j7
 9LJvwLGKCmOyxofOlM7rA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eq4M587cpMw=:IjGhRJ/S4rgwXdbx48m2Vq
 ZHLgfcAeo2BsJQtOquA1rgQ6bJGCBODL88OeOtO25txo7qhQgwJpVmYnRxdpOD7nLxkNByhib
 ugphBEePbtQgjqVEo/XjeDe/Wpgr4GZp2A+4Ez2KrOGot4WgjPjSISAXzbbzSm1YQ5wfFN+Hk
 Q7UvnxodXCBSkp5EdXnZHucKqasj9OuyCNX3+chlcYWz49DRxo0IT5qOcOntsBphX6+Mv1BRS
 wEQGfish9m33H2gf8l3dBZQcgP4ncYdApw7TgiwdPd21FSQGkvpm0SGDgEBzeiTZLtaYjXbcW
 WZvN10Ua6STaCeZkc8FYgZd99EPnnZC2ZZyd0Ya5ZgF541HVMvX9nxJ/t3if+OtArTabnef1d
 IqTyRpzdf1hDiAxtslFInMnej2bhS51EmdIO1Q4zsuklDjGdCmLVkjYXgLB4uvLW+CEs5Obcf
 LmviZuq2czLiIth/s/ELhz7UZnpehRAq96ROUNmkYBhW0NIk3NOb4wsqLzQS2uF6h/FyvvjyW
 NoyNdDfbQ1w8xK1AK+4PNePn/xuznP6iP2VYPgFDlyvH59kBAeH/rvEJW0YYF0MxJBycfvOIy
 lTM8pELdatk/Bo4lmxwDHq9VGlsG/8uBG4P4pfgY2zWDQEeevs5/4V44lIYxyoiD2I4A5NMkC
 yfo9sP3OUsesyzMpFb/WbsYRWtah+VlrEBOX1tZ8d39p3+WiPstLSqvti3JAduJJkPrmzl5Pl
 LeWV1SytsOB9oXiCI9hWZ7QeWEwG2uc5XSv9/GeLYSjQwa6Dr3MolxLA+DmTmzhOo7GhuaWrq
 xloTN5/CHCAGOrl40vlo2Rs0hceDIzAloxj7t+ZQY+0Q738cyA/RQMCDqzY1w2q1VQ4BX/FOT
 dVmXYnrEW1TUyYY2guZA4mlPRRTUMmXTidpaFnRmhCkmLPutJruwqk8kUSdnAp5h+d/H6c1vp
 mHsU3n0FOC8eVoIoqlri8LAO0b+pZ+gOGI4iYYWLhj+DCIjIpzFDGS+814zvWEBaz2L6EEDqj
 saBNFa7i9JpMFZaOPrj4iKEETPK29ILuBiFJF1yNEjBCBFN9x+12bBYo36+LW0IgjjanY0XYD
 NcsJ5eL6SfG45Y=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/20 17:09, David Sterba wrote:
> On Sat, Sep 18, 2021 at 11:38:54PM +0200, Forza wrote:
>> Hello everyone,
>>
>> I'd like to revisit the topic I opened on Github(*) a year ago, where
>> I suggested that DUP metadata profile ought to be the default choice
>> when doing mkfs.btrfs on single devices.
>>
>> Today we have much better write endurance on flash based media so the
>> added writes should not matter in the grand scheme of things. Another
>> factor is disk encryption where mkfs.btrfs cannot differentiate a
>> plain SSD from a luks/dm-crypt device. Encryption effectively removes
>> the possibility for the SSD to dedupe the metadata blocks.
>>
>> Ultimately, I think it is better to favour defaults that gives most
>> users better fault tolerance, rather than using SINGLE mode for
>> everyone because of the chance that some have deduplicating hardware
>> (which would potentially negate the benefit of DUP metadata).
>>
>> One remark against DUP has been that both metadata copies would end up
>> in the same erase block. However, I think that full erase block
>> failures are in minority of the possible failure modes, at least from
>> what I've seen on the mailing list and at #btrfs. It is more common to
>> have single block errors, and for those we are protected with DUP
>> metadata.
>>
>> Zygo made a very good in-depth explanation about several different
>> failure modes in the Github issue.
>>
>> I would like voice my wish to change the defaults to DUP metadata on
>> all single devices and I hope that the developers now can find
>> consensus to make this change.
>
> I agree with the change, there's enough evidence for it.
>
> The test was not done for SSDs specifically but to see if a device is
> 'rotational' as noted by sysfs file. This also caught NBDs or other
> block devices that were emulated or hidden under some other layer.
>
> This brings some usability issues, we may perhaps want to add a warning
> that the device is detected as non-rotational, but that's all I see we
> can do right now.
>
> There was a discussion somewhere about a mode or command that would try
> to guess what kind of device is it and suggest best options. That would
> mean to examine the device vendor or look if it's eg. dm-crypt or
> network-backed device or whatever. That should help distro partitioning
> tools to suggest more appropriate options for mkfs, as there's
> opposition to tweak the defaults.
>
> Regarding the timing, 5.15 at the earliest and I think we can do a big
> defaults update. Some of the features have been out for a long time and
> got enabled manually.
>
> So:
> - DUP by default for metadata on single device

Awesome.

> - single by default for data on multiple devices (now it's raid0)

Is there any discussion/thread on that part?

As I'm not that aware about this.

> - free-space-tree on
> - no-holes on
>
> I'd vote for one version doing the whole switch rather than doing the
> changes by one.
>

I'm fine on DUP and FST.

On no-holes I'd prefer more feedback from Filipe as he has exposed some
no-holes related problem some time ago.

Thanks,
Qu
