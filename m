Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6688E4342CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 03:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhJTBX5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 21:23:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:59215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhJTBX5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 21:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634692900;
        bh=UTzCMckazQQNCpBujVMOI/LrKAYtIq6V5Pkii+mafA8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LLBj+XASMl368pnmJ5YlyFvLCwdBGj7/opBRKGQGWT5wPb7joFe3lQ2QWiVbTzM4w
         HiPcnctj1IeYakGDtvPo87AjusuoVZiwY8ImjIhuLPNpM/Ln92uY6kEsAbn9o4m6Bp
         ovs6x92I7aHdF4RtMZdfzcDohsjQVFkz50lSXIpM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCsPy-1mUAap2FrU-008riS; Wed, 20
 Oct 2021 03:21:40 +0200
Message-ID: <859d9880-e619-13b1-70aa-543a8f9683a6@gmx.com>
Date:   Wed, 20 Oct 2021 09:21:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Content-Language: en-US
To:     Su Yue <l@damenly.su>, Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com>
 <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com>
 <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com>
 <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su>
 <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <35owijrm.fsf@damenly.su>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3C4h3h5U+CoOzq8TUazi3t7j4eeSdTML2zdV6t797TNLRkrTWDc
 pdsVMKDA2yO2NOUt1xAF469O+BFIy056d5UY2u06u0cCdLUyHhMCB6hMJSLaFFLNnW2zBot
 50eGexQT+XS4v0U/CoE3yWcHquWC4qcdEhPHprFE4bNk83n+a/CWVxVK5xjplL+dcaM13wA
 lmbnUqFWAT84THMR3oXPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z39Ai3M8s/s=:Sv5pL3CMt/I+0AROYAoSxC
 CS5/nAsP0/czsqrEui9w8yrq9FcmudckDhxLQr2o1OSMshl27v3sJwThnCzf8SB6Qa2QzD93v
 s4YlBmLI82GfVZHSkaM9xvIWwG60LwEHhSBkPgGSVVaHJLTRCZVf/2diHPP35Q9KgnaGoGKOS
 3MVnuOCJedwInE+pCZuZltWmgFPWRitEHU+6qLoeF5ncrGZnJor1d4tstHEr9OKXMRcOdbx1a
 FV2QKijFHdA3JvQlf0bhap6rVYQ/BbyfVF/DnVo8rLYE+KxAPpP0t5PqT2JVU1TGGaEorE4k/
 sCIHQGw0UJZtINEX6NdFo06pxRGz1dzbhvfsbs39rcBL/59oW64E34ZE1/HkjVug1a4Ip25w2
 Wxtg7tiIIY2Lx1LVt/j/MkBkZJh/Ts/QpAf1OuZtjwyXkGqqai8G9s5WrUgQjGiLQUHa5AqcC
 zLANdCV2j0FRLR2yH5OvxwnFAWi+DrPCBK4/TG2Ao4wBSCWxNrnmxuvwddJ4ft3GQ6/9t18Nq
 qm+pn/AXMezu+msOhw05+ipvF58wU9M7QyaFI55PSJ6KWcqRz7YN/am8u3s4FF6memfVN62o6
 nCFkWxN5RvYn5tLTKsgiyTEuKo0ZYKOB0uI7rAfZnVT2nufMjToZE5/tzpaa2yBQjVuS4UoGl
 7LK8lKfHdzagVzLgDXRokFqAzfNXfsHpiEt5QSmzNmubE0+RgCpY7gxBZ2C4hRowEcRyGw1t8
 c3x5c1K2gDVXw+RsA9qTfhgkVjpbo/8et1FLt7oK+0KA7HlIrscRLl7Mht0Dfi2cq2ElbFlAG
 yi+PtS999kIoV2pVOEqbfQPasOstaPoE5gQwVh4Z9bSlWzyYD8WBkFF9yaf7dEAw5B8f99oXR
 3UDSouIujvyC/WGkiG8cR3SUOZ8AjyqH2te8qrSLZHkn7JeJVvGZQh9EQdjyVkeeYlvTpfEWh
 XqtnMPaTJYjuO3WFbMl7kV0g8VllcXOPsoEyZY/Vq/ysxSNjUF0Cv0byMcyc+ZFoyw/0RDJhl
 AdiiMoXE1PS4wkHWPo0AQsInJuUaSefVu0H3yMZRI32e538cKPmvh2zPDUC6QymO1wZ6akshv
 FlFqTOhDkWZVwE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/20 07:42, Su Yue wrote:
>
> On Tue 19 Oct 2021 at 14:26, Chris Murphy <lists@colorremedies.com> wrot=
e:
>
>> Still working on the kernel core dump and should have something soon
>> (I blew up the VM and had to start over); should I run the 'crash'
>> command on it afterward? Or upload the dump file to e.g. google drive?
>>
> Dump file and vmlinu[zx] kernel file are needed.
>
>> Also, I came across this ext4 issue happening on aarch64 (openstack
>> too), but I have no idea if it's related. And if so, whether it means
>> there's a common problem outside of btrfs?
>> https://github.com/coreos/fedora-coreos-tracker/issues/965
>>
> Already noticed the thing. Let's wait for the vmcore.

No idea at all.

In fact I'm not even familiar with kdump based analyse, and would prefer
to manually add extra debugging output to make sure things are going as
expected.

BTW, where can I find the compiler used for those pre-compiled kernel?
Currently I'm suspecting the toolchain as the root cause.

Thanks,
Qu
>
> Any idea, Qu?
>
> --
> Su
>> I mentioned this bug report up thread:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1949334
>> but to summarize: it has the same btrfs call trace we've been looking
>> at in this email thread, but it's NOT on openstack, but actual
>> hardware (amberwing).
