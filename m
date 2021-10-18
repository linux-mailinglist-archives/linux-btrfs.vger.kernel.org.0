Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2C6431B6A
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 15:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhJRNdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 09:33:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:49627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232756AbhJRNbI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 09:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634563733;
        bh=/TBF35NMSw+mZkcX+dtiswlZ9KmAqnUHfaxwwHR0jRc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=B+GGpc2FypB9ZY5rfCBL8OV5FzydwwMFG7oaUfvOnsLA2iVfK50g2r65JnU6XCnOS
         kYLeGKxGHLIp5XBTgFxjurDbJaHJr/b3cXV3njLeSAdDhSfIfQpEv8fFP5hS8r0z4j
         WnOplTS0lVrN9U2fXJgm2gS9bmKLeYL39auABxus=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2V4P-1miH2x1dp1-013ta6; Mon, 18
 Oct 2021 15:28:53 +0200
Message-ID: <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
Date:   Mon, 18 Oct 2021 21:28:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Content-Language: en-US
To:     Su Yue <l@damenly.su>, Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com>
 <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com>
 <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com>
 <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com>
 <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com>
 <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <bl3mimya.fsf@damenly.su>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ek3vVdUch2BbhiGJvNk9kIrgU7m9G70TySN7rz0nwDq3C1mDlHt
 xYqLI7OIAmzw7jA2G8MLX2bWrSFNVcWN0GLT/aeujeSO3rItSAPhC7+lehjjdzvI2l5d+pf
 PB8lKz3q5pwkBlgA2r5MltTL/akqWTCR4duUoYXgqMt5qQuaOn1QCIUt1GqExILYoBiP6x9
 4Wj7sZGyg0E7Oj71C+HRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gds1uabSGQg=:MqNhkxwf+yUvP3Lgnhk1if
 soqRJMiOjk8SOGvR7Fhs1uZ1+meYu8gqqU3hUZdOwTt9MIlUW4QcQng+zu8Pq6lwctjeOAfYA
 iWN8CWrfEBowYYJLzArpOq4QKzq1cv6C9vSqGa1pQey0g/aCEFC3P/iOnTSEZZp/ADRqVVHE7
 y18cX6PFFVYWGKLdFfvWFYd6L45MqIaoL4tdWiVlkJWvrTxKy750Q61uEjZaJXD+aRc1rWTkn
 vIUopfF5eYLSws041tjov+7COIYGqDXSsBizo+kaa9tGGK3yqB0OEfqYWktOjaazQWfDcvHl2
 UNk/q7g/YaaVVgwI6ICExXOreXT3+rTPV+abDqhDB8Pso9vEIagFcBmLWUEKXAulkrUxqB0gR
 6JSmBGoQEAasNj3kl43O1KRgH6vO/TYyhZDQpniBVqqEk03q5EqCS4Je7Ke+9s7a2BlYLTUU3
 m61/fbjlqAwFPO2xEpFm1OslA0DMlEGGRejTkEvQa9eooxF9xrhSO+m7Sis7NulNdBfFeuk4N
 mhRTJLeyTKMpt4vs67tQetB1CNUpwqj4L8bJrn1/VmvzNvDFkLdEUtsgrz3PPZ21tjfIYVYg9
 XW12O+ZaY0BVLFMrnr3eeEPlmv1HdfOKyBIfCcdu7x4Kvvru7/dCQiLf6Q5HfX+4KtzzQeFXx
 O57OkE/y73Ba4rzXJcEJnQdWwvIwryBPmZVorWJtwJvle9l5F/8g45AanBWn29iR2pIy8ck4P
 sg0STYmzwVRot1y6sHxhQHkJ466JBmJJTGKvCSqUbkq0bdJU8l1TNBHhgr7uDjrnNNw0s8X+w
 FNbOsWwS80ZbdZHMs92VGkCxpczMcEwrZ61KsAuhiaSiYbv0rsGsXuxSdqv/0D7kbYSar1NRQ
 NLjgGTMJ4xH7v5ZSNpOPvgkJ7fVEo9sEWnDbhpLZM782f6CnXnHaBLW5mhzWXoLxH3pteJHo+
 gdbE3+I8V+wRtpvzpxkt7fLaMg+KheQDadWGMSH8X4W5UCOMD0G5ugiXaw95VUmBZbYdXiEKg
 s92sUdkp9yrmJzNFjXpzQDIkmRDjw3nRl25xcSi4gTxknBJdXY4/+pybciwKytpPvzCkJ66hI
 RBIH9tjHTCs+ws=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/18 19:32, Su Yue wrote:
>
> On Sun 17 Oct 2021 at 21:57, Chris Murphy <lists@colorremedies.com> wrot=
e:
>
>> Any update on this problem and whether+what more info is needed?
>>
> It's interesting the OOPS only happens in openstack environment.

Or the toolchain?

I also tried my misc-next build using GCC on my RPI4, fstests with
compression never crashes the kernel.

Thanks,
Qu

> Is it possiable to provide the kernel core dump?
>
> --
> Su
>> Thanks,
>> Chris Murphy
>>
>> On Wed, Oct 13, 2021 at 3:21 PM Chris Murphy <lists@colorremedies.com>
>> wrote:
>>>
>>> From the downstream bug:
>>>
>>> [root@openqa-a64-worker03 adamwill][PROD]#
>>> /usr/src/kernels/5.14.9-300.fc35.aarch64/scripts/faddr2line
>>> /usr/lib/debug/lib/modules/5.14.9-300.fc35.aarch64/vmlinux
>>> submit_compressed_extents+0x38
>>> submit_compressed_extents+0x38/0x3d0:
>>> submit_compressed_extents at
>>> /usr/src/debug/kernel-5.14.9/linux-5.14.9-300.fc35.aarch64/fs/btrfs/in=
ode.c:845
>>>
>>> [root@openqa-a64-worker03 adamwill][PROD]#
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2011928#c26
>>>
>>> Also curious: this problem is only happening in openstack
>>> environments, as if the host environment matters. Does that make
>>> sense?
>>>
>>>
>>> --
>>> Chris Murphy
