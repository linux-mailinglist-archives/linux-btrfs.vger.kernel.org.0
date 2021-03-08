Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D43B330ADD
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 11:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhCHKKd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 05:10:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:43127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231760AbhCHKKG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Mar 2021 05:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615198202;
        bh=xHscTZVm8B7PrX3FVrI1uBYVFnpneqYe1n3eF6rS5pA=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=XX9soANJvATKrDTRcArQ1GQz+ZNAXaTaPD9vQVHbvruAm0x0Ep3NKRNXkLWpsCWXY
         emYNHP3MRgmT8AIczODqmPmb06Vr7f4l01CJruC0AngR6RnYukSiBmjsxGtRXPYhVW
         xhcVm+YxbZY6USASlpfuxTjMQ/K6Ln5vsgi4KcgU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXBp-1lW4rI1rtJ-00DVor; Mon, 08
 Mar 2021 11:10:02 +0100
To:     chil L1n <devchill1n@gmail.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CABBhR_6Y=H6Eujw51xkt6_fjAQFjdcp5trVgjtbrNf9iMDxZ0g@mail.gmail.com>
 <PH0PR04MB74168E7E65BDF004A6C06BB39B939@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CABBhR_6mO2e2Bu2TLGTCjY-xG3+Yu34visp9+uqdvKUvpVhG-g@mail.gmail.com>
 <100894a0-51c5-6ba9-7688-32203cb822c6@gmx.com>
 <6c73793c-e855-12c5-9214-7baddbc840c7@gmx.com>
 <CABBhR_7xkonR0AzhKqm4zeY6rKtr04hVn5u_2Nnr9XJ=-f1bOg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs error: write time tree block corruption detected
Message-ID: <d5f7427f-2579-e846-5c80-23b2a0e57539@gmx.com>
Date:   Mon, 8 Mar 2021 18:09:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABBhR_7xkonR0AzhKqm4zeY6rKtr04hVn5u_2Nnr9XJ=-f1bOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wMIEdlCXyP7UQDhW4Tvg86Z3LaR/0F66djf7gI7Uu1v/CHyiBXW
 ChWHOpOMKQ3HHjkzqaq+1HkmSXAKYswaoeEdUbuu2iO32Bo03KqQF1wIWcdh7ow41Z67Knc
 K3++GTT8yckgXZtf/LKTXExOzsLxM7usBCkK5GQYvD5NJuPS+tBDpts0meoHrCzeJQLW9EK
 Sont68r7JIUpoTuAqR0xQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yM5Wd+kE9cs=:h1QxyCwxnjXbyAcP7kWcYC
 tYdBBJPJe/90cJXAxdjlT3UyWdwzUZRg0XMTh1Xk7nJ3kqCTCTHpeywxPG7G+4mNuZ7uy1SEQ
 8HOlzfBzqr6F6RT3/Q3w9Fq87OCTuLEpSd2EpAyPHVtW2fMzZhkA41ZfKB65gGmZD6DeGeTEm
 JbT1vKAdtYaFIP0a5zvjC/Cz/nIl0Pt/teKwMKarMm0KgiGirskLcWTVBt1TZpwomQCEKN4ey
 aBKtXwntLAjcy+2oN4K4JpiPOt9T/I55tbyzuop+xcXmUUFsFe6I3bMsCkyO6TEiFD/y6QJI+
 ftRqGZAAj5Cob5LDS8wxI8DC+bG8TGQx9b92C4VcMi7rG8hmqNAn7YtHA5ZmKifHUbw8+XwJU
 SbHEcF9hA4A1h6+zvHySAWIoAPtY4765Lg/c1B+5zWWitgbMzVm1AaRfDzJHniUbg4AFDesZY
 yMpu8Q1ZNzrlfjBM4xoAmhx+5U6aIntROicJ9RFdDrUcrI7cTR1dfhq0+LW4TvJTbmLjZ4ssO
 hA6KKzyVw+yFuc5JmXsuLh/JmRx4BtZabzLnAO7UT7mtIscsncSkraFqlRlK3XjHaGzm/bQA/
 3p+tiF1DhgtUVZLslqMEQcUqqY+vkAdfME0tXR92by9vIrsNIpeYrWZf/elBOAxzsGaZDNgPq
 kwYTodjKpM6/OXx209ZqW9dd2IF4onIl9F+6iZLer4gC7ft1AspeKKv1oZS91SQmA8ogPkS3O
 AuXdNs+5uJmpiJmgKzvpu3t7AIJorc8BltxKXl+ruqmpV2GlXzR46fgPXHXZZoG6dfjTEvYj7
 NxObYfQeGWU5mk6OjX7a94/3VjJRn37BEcWPPugTPeqMoukIuoTR+XwKn5Sk8UgXKM5Qco/Qt
 ieChAiR7nyQ25EOswutQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/8 =E4=B8=8B=E5=8D=886:02, chil L1n wrote:
> Hi Qu,
>
> Thanks for some explanation.
> Personally, I prefer binary to compare bit-level changes.
> Actually, I also miscounted. I count 3 bit flips.

Yes, you're right, xor also returns 3 bits flips.

But the point is not about directly comparing the two key offsets.

The point is, the bit at 0x200000 can be flipped.

If that's the case, the remaining bits are no longer important anymore,
as that one bit flip just makes the current key to be smaller than the
previous key, which will trigger the problem.

> Isn't that extremely
> unlikely, assuming that each bit flip is independent?
> Nonetheless, I'm running another RAM test with memtester and 6GB RAM
> blocks.... still no errors.
> Will post an update later today.

I'd recommend to run UEFI memtest86.

This should really test the full system RAM, without anything else
affecting the result.
(This also means you are not able to use the computer obviously)

 From my personal experience, especially for write time tree-checker,
it's almost sure the system has something wrong.

The RAM is the most common case, and personally I'm very proud that
tree-checker has detected more than a dozen similar cases and quite a
lot of them turns out to be hardware problems.

Thanks,
Qu
