Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685E7486E5F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 01:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbiAGANj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 19:13:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:37655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232819AbiAGANj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jan 2022 19:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641514390;
        bh=EyPi8Y3Gc+gTu2ILQBh3edI82bKKE2zEKRdiyUFahW4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RcqA07djH1Kg19mjjHZT9kQEF5PBB0i+eBHqAXaC6T9NjHBCkybTynF/giLuDnIBk
         o1hL4kgES4Z+FDB0zoVkVRjNS/wyuVImH+OQgV2PL8ZzWlZMoLIAl+pPrvfVK52dtb
         Xsa+hpVlC6iKG5amEr6vxBqPsdcEcJXZXxPodJTY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MStCe-1mxUEN0uR4-00UK15; Fri, 07
 Jan 2022 01:13:10 +0100
Message-ID: <db88497c-ea17-27ca-6158-2a987acb7a1c@gmx.com>
Date:   Fri, 7 Jan 2022 08:13:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
Content-Language: en-US
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, Hector Martin <marcan@marcan.st>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <6c7a6762-6bec-842b-70b4-4a53297687d1@gmx.com>
 <CAEg-Je9UJDJ=hvLLqQDsHijWnxh1Z1CwaLKCFm+-bLTfCFingg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAEg-Je9UJDJ=hvLLqQDsHijWnxh1Z1CwaLKCFm+-bLTfCFingg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:anCYYKhzpZMxqykyFCq+8YxKtyr10cQ84WLxzimaPuneijGdCqz
 DCTt+qxKufcuCSCYh5BvF0kfQ7B0Ov4gS934FXjKQjR28CPsyZEYGntV8kpnaTxozhsyQRC
 PmkBHzOARVbxjBbf8Gsxv62DXHnI2kJv+jLn2ZfjzaKplUnXZJaOCfBKAPin1Ic1yimFXpN
 iHdKDG80XWbzbUv4D+TQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HhiphtxHIBA=:jKABz3jdZsxi6EwxEaeBRz
 /vugjzSA51qNzCKgJwvYaZa2YSql73GgHl83okMs26BXff4nbudCZBsGEKWxwZXwfbG6X0RCc
 7ZqRNly6LqVLWdgP03qj0D3t1BR7lzWByjCbE6zAdXaLVodjh6K75ihOiNQO2WBfyDz7qnmcX
 mlPLUhIFTKDlZU6FgKxB8bUHGLSNKRPnqaaBDPdzs7Rv+xggVOMbyz+/CfbrSRdQxnmiMXjTv
 dnsN+qmcMtklx2FKtAht9pdsgmGOB1HrHc5WUuGfOdEreSYKmRmjztIrtWoR9eHws0Dzbz7zN
 465Xbz9zbOPnEfp4Y+8HhJe9S1QeBOD1Ex0TFoVfrA9TGaSgApBs9Po5dC8H2Ia0vAxmlqOWZ
 ik9jJHgVDg6m/6jPVQTF20+blPD1aQ8osdqUTz+8DROWqjJD2QzSHRTb9ZuGBQRW3lCkNJ1FK
 zkNrPJXv0xpY4Lx4oAlUZECuudUudNJNQv+/41YIb+DeMq51xYqYntsNRKMMdqEak/NhbtIdI
 e8VE4TVb/5f2Ylvu+6OD85RxjdcbVT5a9rq1YT0LAh/O899lnI00oz5NWppzgstdqCW/iD49R
 8qTZ5bx3jU1NEDjnUH/7qFeX5V9UdB/HC4puVARS23Z7FFf7iZ+YtfV0Ga3wDYqcbDsUfWP75
 +3vXsOOZN7SgtMCI88jFddjtWd6RtMIX1NlXny5YhphJrOtSANWJstJp1qOuGKAYaoxx/MBMH
 7GfknbMczRPnhbprQ1Z68yC1wTkUnOhBs3f5d60ruWjSoJcccxt/cles38CuRyuP3z8V/Sqzp
 8V+3J6T7c7SaBTcXJjLCKVx/6jCZTK3rHzewI6iC04ioXD4TKgZGw8cGl8PYBf5JDzYYVp0if
 4tc9RiHfvCrFnhJ3DFB3oLDICGDWS7OR5Spz19FI7sN6suUSGMjHvEkwIbd+SBoC7ZCKYle6L
 Er/fry33el3L1GNK6G4UH0ABvT5k0o1L1NUu9enWZ13N8Tg/QemjSkEm+ZlRXtPtIZLZGPP25
 DPa/jDJ6GD1G1N8iAXD8pf8hLJD1wYQ7ElBvUlj05p6amX4OB7/VyDfCFUE90ZyzHhB9yWgn2
 Hha+O/UqdMb8Nc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/7 00:31, Neal Gompa wrote:
> On Wed, Jan 5, 2022 at 7:05 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> Hi Christophe,
>>
>> I'm recently enhancing the subpage support for btrfs, and my current
>> branch should solve the problem for btrfs to support larger page sizes.
>>
>> But unfortunately my current test environment can only provide page siz=
e
>> with 64K or 4K, no 16K or 128K/256K support.
>>
>> Mind to test my new branch on 128K page size systems?
>> (256K page size support is still lacking though, which will be addresse=
d
>> in the future)
>>
>> https://github.com/adam900710/linux/tree/metadata_subpage_switch
>>
>
> The Linux Asahi folks have a 16K page environment (M1 Macs)...

Su Yue kindly helped me testing 16K page size, and it's pretty OK there.

So I'm not that concerned.

It's 128K page size that I'm a little concerned, and I have not machine
supporting that large page size to do the test.

Thanks,
Qu

>
> Hector, could you look at it too?
>
>
>
