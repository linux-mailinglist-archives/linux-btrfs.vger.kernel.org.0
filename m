Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8993B170C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFWJkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 05:40:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:35367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhFWJkU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 05:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624441080;
        bh=96K544oKIRAIoAM9ooyqENEv0yARH+PoD2NPiPRP5k4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NWMkHqEGcoKIC8GiXwK+EticwvmbZh23X2zO1CHsqtMs6WE9ss7KxdIobmMWQ4cBU
         KDZAEFN0LLDvyD4MoSsx0xIo3a8Kg2enlL80BNuyLzg9NBAZe5ilR/sdZVrn/DeVoi
         XW13bY1dHgKZsAFLR7FzMhreYQPJv0ADJZO6fiRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1lcq9B3kiM-00PuWf; Wed, 23
 Jun 2021 11:38:00 +0200
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or
 rebalance
To:     Asif Youssuff <yoasif@gmail.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com>
 <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
 <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com>
 <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
 <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com>
 <CAHw5_hkUhV8OvrdZOWTnQU_ksh3z94+ivskyw_h069HwYhvNXg@mail.gmail.com>
 <CAHw5_hmUda4hO7=sNQNWtSxyyzm7i9MU50nsQkrZRw7fsAW3NA@mail.gmail.com>
 <e12010fe-6881-c01c-f05f-899b8b76c4fd@gmx.com>
 <CAHw5_hmeUWf0RdqXcFjfSEEeK4+jTb1yxRuRB5JSnK1Avha0JQ@mail.gmail.com>
 <83e8fa57-fc20-bc5b-8a63-3153327961a6@gmx.com>
 <CAHw5_hm+UX2EHSdZHcMXWMNYxOtccKMQ1qtfbu1gKUm-WZFXYg@mail.gmail.com>
 <CAJCQCtTW0tR-55UkkE=r0ONQucCO7_An2ASOQeBjZiZXtPrLSg@mail.gmail.com>
 <CAHw5_hnLSwMBqNxE6pPvau+-9LQoCmWp7fy6vuxtT-UPPLL4Fw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4d1f2c32-521a-aab4-7da9-6a0a8d3ecdc6@gmx.com>
Date:   Wed, 23 Jun 2021 17:37:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHw5_hnLSwMBqNxE6pPvau+-9LQoCmWp7fy6vuxtT-UPPLL4Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FK8CdQEH93Egk/15YTc6DrxSibX5d+ryeJMcKmEjE/iL+fIcxfa
 2DHXYDGanZ7bUikv+nqeqpdlOJlOlhg3xSdQv6H2sDs3ZnieSi0RezdVJ7k0Zh03WI2JSM0
 2yX/bquwEyDUV2bpInedr/3HIPiu8QCbh41VxHZfN1Kw+jlZRYS/V71dH107ktwtVda6Hd6
 icT/XadSCtgIxbuVsKtTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8tmAjbbYA4g=:oy5DOEbCfZ28G1j+sZA3AR
 ZgnvXAn+aFcrsiSKNbwDGuKrFit4tKMW5aJbtJyadVS6/7oZ0i3c0eT/DZzcauFi+GPayDXlW
 Q3LIvL/JJy91twwciShig1KUZj65PTnlq9IzzGHtCnHs+FNdO1AqgZCe16SG99tkGpN0KKv4Q
 eOf2u4exRyVrM+PDzaSfFJjDfNNWywp0A1PTKQaZvmeZKJwdEW2OlqohG4iE1BXl6e/Cjy7Qu
 0o1hfhsrj14uhjLdwQ/a+4d/03EUmPvvRN6VSCsHywtp2KfiGAiG5waI6Lftx+glwU9g2c8n0
 4Ze5Z3lqwuO8xu1dscMLznmrsIA5qe9Zg6/+tsQU2lfUZfWDFW8gQAtFux5e6HMIR3HODYhLC
 AZ1Zuk3mO53qdWhG62gMZi9BdBrnpy6sa5CPVjnumhtAS/RExajomX+B1nUPY1N44umBzc2YM
 F2xCEkxpdQSllotZEMA4uhzNCHnH1yUVhP6y/beprVuzYhCOtGcA11lsUycUvNyYufSCfQ5e0
 waTWLj0HvBnSeT8UCkXoXBfAy4q0bj6eenJrzdDcBYkabPqyabMKmqbUiq1yfInXoDs6IEiRU
 6NJVImho5+fFdT3rLas0scmmqGhPSN5rHXWN9bWxaiTHzSN9n4/fpGLo0J3D5ISGNEW0HadXN
 r7vH7KLrg/AStDZWqpNA+cwyV153s35DXRBz4SIbyhnXIsH6Mmqw3lHbxBMMI9KNpKvn5/oZd
 rjwZBbdlaLfdoIB6mpq0XvSgNbBbxzLwGYQGT9mSo1FMQH94/UwQ6QCx0KYpSdOTOTj7Bj8VW
 4IaB0Is3oFbsEmdzedqj0wjbNreu6jN/aFsOlZg2ew/OkwOuROJJqzWPmVM4vzFfA2K7JVzE5
 md00mVQNOEAiuFyspI1NilCVpQZYaNNXZnRpKLWdePPp17ZkdakdRWhMoL+HaRa5QhoAWpCNs
 GeB1LWi4IjiMG5qcYiMMz8fWrEKbp+/OwRJybH6/2HbjBIjuXKF28QgPWEAKpuAz/rQMfwn4G
 heT5dS09hFG8KVfNt9QYxpuAFtJVQNqtDQCYIp05927czb1I+NJEfyjTul4RSnBwHoq0EEyod
 NHxJc7boQB1QWbyjDGvDhJlvr5i/AgnKVt+pN2WPx7qD3oyF4mwZ1B/+w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/23 =E4=B8=8B=E5=8D=885:32, Asif Youssuff wrote:
> On Tue, Jun 22, 2021 at 5:33 PM Chris Murphy <lists@colorremedies.com> w=
rote:
>>
>> On Tue, Jun 22, 2021 at 12:37 AM Asif Youssuff <yoasif@gmail.com> wrote=
:
>>
>>> I went ahead and also created two partitions each on the two new usb
>>> disks (for a two of four new partitions) and added them to the btrfs
>>> filesystem using "btrfs device add", then removing a snapshot followed
>>> by a "btrfs fi sync". The filesystem still goes ro after a while.
>>
>> Yeah Qu is correct, and I had it wrong. Two devices have enough space
>> for a new metadata BG, but no other disks. And it requires four. All
>> you need is to add two but it won't even let you add one before it
>> goes ro. So it's stuck. Until there is a kernel fix for this, it's
>> permanently read-only (unless we're missing some other work around).
>
> Hmm, would this be something that would be fixed in the near term?
> Just wondering how long I'd have to leave this as ro.
>
> Happy to continue to try any other ideas of course, but I'd rather not
> destroy the fs and start over.

The problem is, I don't see why we can't do anything, including adding a
new device.

 From the fi df output, we still have around 512M metadata free space,
it means unless there is something wrong with globalrsv, we should be
able to add new devices, which doesn't require much new space.

For the worst case, I can craft a btrfs-progs program to manually
degrade all your RAID1C3/C4 chunks to SINGLE.

By that you can have tons of space left, but that should be the last
thing to do IMHO.

Currently I prefer to find a way to stop all background work like
balance/subvolume deletion, and try to add two new devices to the array,
then continue.

I still can't get why "btrfs device add" would success while "btrfs fi
show" shows no new device.

The new devices to add are really blank new devices, right? Not some
disks already used by btrfs?

Thanks,
Qu
>
>>
>>
>>> Would mounting as degraded make it possible to add the disks and have
>>> it stick?
>>
>> No, that's even more fragile and you're sure to run into myriad
>> degraded raid5 bugs, not least of which are the bogus errors. And it
>> won't be obvious which ones are important and which ones are not.
>>
>>
>> --
>> Chris Murphy
>
>
>
