Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1023E5618
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 10:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbhHJI7F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 04:59:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:46045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238426AbhHJI7E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 04:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628585920;
        bh=i8seo/oe+IiQD1wQiXR4Zhs+9xIji/nLGuLtej5wtJA=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=aMZmRYSJiIpPtKOvguzGL3KH5jxqOHcTWFSLtRhGBw4Sod77zwtazsMbtAkyNO/oL
         dnQnbP6CQc8UJvlrsC81aI+5g1623TOg+QeBslBMf6eAXXvUN57dAEDcgKib2766Gp
         tapP0ot0fMMxLNslwSCKi76TQmvt4HFI/8pKeP20=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Fjb-1m9mQ44051-006Kwj; Tue, 10
 Aug 2021 10:58:40 +0200
Subject: Re: Mixed inline and regular extents caused by btrfs/062
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <db939df7-412d-aaef-c044-62fd2d8b2e7b@gmx.com>
 <2da42f71-b95d-4fb1-be93-be9e58eb1200@suse.com>
 <9d0a719f-2619-aff9-a10c-be03c72ef546@gmx.com>
Message-ID: <0d113abf-bf52-870d-6723-2d7af5e54da1@gmx.com>
Date:   Tue, 10 Aug 2021 16:58:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9d0a719f-2619-aff9-a10c-be03c72ef546@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PQSsW+xqQPGJZJqbhec+6mkAe9Kn1XeGa3hUdgnL6hCC1DPH1g0
 uxGKN7dNx2ttLLugLOvrI9Yq/3UV9ITxybvEFesGu9dS/aYFz5ZBFPRptK3gG/Xr4vYN4CW
 wndFzoxvd/vigb004q3ABrkkZ7JR0ere8l1VtYrVxqpyktMy81lgkTvkptWlJ7jKaPap3zl
 sTo0KJ1I7M/emBfctAI0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lBkyvTBCXa4=:Lm1ZodZsBsvdxWlXA1ykfZ
 PQXFi6zNbz5fx6IsF4YJF5Y821QABxfwPlmDS8ND848++6KAIDqJ1rEOzSMIMntQEESANKDOv
 47Tc0/CCMH2NOQMGcaWWy1lYjE7AcLDVQW7iZIHg1Dd3HP/paHBd4EpA0C0kc1ahDYWa/GIuL
 2TTh23X6WTkA8x+TlWd9q4L8ungG6egSumhCmBmi3dKa0dgIt9dmywUMulGz54MYrPBpekSZ7
 fsnqxMjWqMtoeznxFjCYYwBOikQZ1BwwilAKik57JavTDTRhSKtSJc9pA3zzooYLw6Vng+o1E
 bkqFD3cVC3kwMG/bGPI2OJaHD5xeqxmVOBOkDF/ABB4hkRINd+zHCubPX+V/qA4wXGQlfEFYK
 4aBm5Dh3GAi8cDUeYmIpQVPMqXIwuJFKryx/Ti/gkz9xQTcZ8S16XPU2886zkiTVyyVtYFEaX
 a9bjt4mSD9yeEWNBaFNBnHw7No1L0nTBXF/EZFIasJXVs6QO3DY3WJTH5jFk0PyfsuhMGg9Dz
 BhTgjNDrfIm9LBerEb0HgRT+wROHhCejzxhQHQORoOhaIf+t53o7yq83ohPVUJ1jNSZjwaeTr
 Ln9QXgkocLCiHOqt8IYP9ZTE3SqtaHAfFwl9D7D5CVPs1fzLNpyG6ip/bjTNMucxo8aWsFeNG
 X6KHjk/qAAJgkfvVRZ0IhLEqhK40w1LlllcBHXIHwcVd8treXhUmlAEfGpB8kEX77NHWCrVaF
 XjK/CeSOjMi3UroA8lk8YpK8JXQeIckAlBXbDUlsr14wu2iMYzB/CnmKcKG9v7d5FCfeXEvjY
 C6LZBfBDwqMdQfrREXtUUYmqpvTX0zM00I7zJ0pR/c5WoOZC4X/+1s6jKIyD5/gG1eUR/WqXU
 hEIJ2fLRs2z6bwKvu+afKsNp5EfgqwZ60r9pebSLvsAhwdLjIP/Y8OdktkElfxlSJEexC57fz
 RnQXElD/3pUN6focbZkXU3jT2f6few23ApJ4Y3R9HI0QNKlomoplnffVRtPKzqEKF6H7n7O/c
 b2d+086RuTHUKX7lYHNE89Xt4noZ3lBYoFheCsM5Pyydggou4utfh1vs2CEBo9XQwIYORMG3d
 GExyP33ds2SRezwFb1FCzvkdTGezCly4XpPCGUxpqDKzjf9c1TIq1Av4A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/10 =E4=B8=8B=E5=8D=884:09, Qu Wenruo wrote:
>
>
> On 2021/8/10 =E4=B8=8B=E5=8D=883:46, Nikolay Borisov wrote:
>>
>>
>> On 10.08.21 =D0=B3. 8:49, Qu Wenruo wrote:
>>> Hi,
>>>
>>> Although I understand current kernel can handle mixed inline extent wi=
th
>>> regular extent without problem, but the idea of mixing them is still
>>> making me quite unease.
>>>
>>> Thus I still go testing with modify btrfs-progs to detect such problem=
,
>>> and find out btrfs/062 can cause such mixed extents.
>>>
>>> Since it's not really causing any on-disk data corruption, but just an
>>> inconsistent behavior, I'm wondering do we really need to fix it.
>>> (This is also the only reason why subpage has disabled inline extent
>>> creation completely, just to prevent such problem).
>>>
>>> Any idea on whether we should "fix" the behavior?
>>
>> What do you mean by mixed inline and regular extents?
>
> I mean, one inode has both inlined extent and regular extent.
>
> There is an old btrfs-progs patch to detect such problems:
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/20210504062525.15=
2540-3-wqu@suse.com/
>
>
>
>> AFAICS inline
>> extents are created when you write at the beginning of the file and the
>> size of the write is less than the inline extent threshold? All
>> subsequent writes are going to be regular extents.
>
> But with above patch, the following test cases can cause btrfs-check to
> report such mixed inline and regular extents:
>
> btrfs/004
> btrfs/192
> btrfs/195

> btrfs/205
> generic/269

Above two tests are almost 100% reproducible of such mixed extents,
especially btrfs/205 is pretty short tests.

I guess a fix would be easier to understand the problem.

Thanks,
Qu

>
> (Haven't yet to check the reproducibility)
>
> Currently it won't hurt anyone, but I still don't think the mixed
> behavior is expected.
>
> Thanks,
> Qu
>>
>>>
>>> Thanks,
>>> Qu
>>>
