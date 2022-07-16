Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA51576B20
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jul 2022 02:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiGPAer (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 20:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiGPAeq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 20:34:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F95423BE7
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657931676;
        bh=/rfWBPAX6gRyescsz+4k6g9iqAMavGcYUUmKACXf2k0=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=NLGd2VFkPJ4uqwvOK4fqvJDLzLNXVK9pTUvhVFkAZg/+FVKecJ4LK4+azpRuZNvnr
         mWRwONGYIO1ixAJD95ql2YFQ4qP7W1AIlwh3GVwzX4vzCxEF3YYmiPeVyUe3AW//LZ
         RBi8KvUeICQ8PPBD4r0OHkHRFvt9XYT3vD2YFFNs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QWG-1o882l3ZJ2-004VX9; Sat, 16
 Jul 2022 02:34:36 +0200
Message-ID: <1dcfecba-92fc-6f49-bdea-705896ece036@gmx.com>
Date:   Sat, 16 Jul 2022 08:34:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Thiago Ramon <thiagoramon@gmail.com>, kreijack@inwind.it
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAO1Y9woJUhuQ+Q2yWSvscnBJb9D5cYiBaY-WG3Re=7V=OzWVhw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
In-Reply-To: <CAO1Y9woJUhuQ+Q2yWSvscnBJb9D5cYiBaY-WG3Re=7V=OzWVhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lnNykYkyDRx2Zcvq8kQCOkeqeeh2O3I2RRWCKSFAhpipucbHT1v
 D7ZTnnQt3RvQJwBITBPIm4lhzCA1fnkcZMrkHTEn+lN7ocdmFjpGPksPACzze197iNJvquT
 VZgcm33eYbgEUn4AE7DNMSVEzwuoIqOFRMIK5uPMLyVssS6310hyNWpKGCYfl1J58yH2xcj
 MFJ4l+g1QvL50K03tuXWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K9x0T9s7Fco=:wq2mGiIAo0sshsh7cnaEYT
 TdaZnJe1YluqGjz/n+a2FdByQvarnvXRoYv18eCJQfvuEB9Qcuvd7hm/rrPc7RNbj1AX5lLoe
 b4SFV+IBQLN8ELgZTwGkFnAxLuQBv/QshgQ15dxM0aX5v4Loyx4g5t5RbQsgFYj0sB2qlDnr2
 pT2SPTfez9V2ZEdgfYdpSA5hOW6umfD7nnIhAWrWFA/mYN4YPu27A/GkX6rcQutKcjpiCCGk5
 0GhExIfXPgPTTVnaTiTMzjiZA7cDvRkVWzsa62Qir/riNqOH1szavzOYwIh+iBafuTyyEnYbr
 xNxE18eCGUItUOF8Oi4PoDtKYcFX4qUREuN2lvKqa+xe+JZg9pW/xletd2VYsk7aUeC8FCBf5
 XYAvFHcKdbkPwKFfYjJCkhPU+mWarY0TF6HV7zjO13XZEGE9rJbPtx/foN3kNUCZCP7HU2ddL
 YMTZqcNkrIcrr9kpsoQfyZhbIMr6EHlndqIYDmdyBrPSRMe0lUQ/YulFZjKsevJv10ul/TkzR
 oNZD7+twQ0yXZ1wLb1NhkKjc6wQ4KhoTf6szo9HZ9t4ifSNlqe+AEUY8GFaNuaFxeVMg+vudm
 DhuBbpOovER4Dkb2bvuB3Qe2E+qC+OVqW21P2XM7IDCyADdgJ6RLfgb4rfGX4+95Gr3eBY1/D
 jOQK8y4tOwLrTSpw9+v7heXu49Bta2iXL1A/l9iOwixul6CwAOUmv+GKIRFkKIXjINYyG/0Pd
 Wi5oCDGinS7vQWowIFVZufD4S2C+jwUcYr5FdZPqesTclF6yh44A7dDiERrJsaR7dcVUKkYcC
 vuZE+yrw75WXJnOFsZgzpUX0EJwEZPydkbwNEOiOLQ4vnbv8+JkxEUenvBfj5I1HLkDbg1xP+
 IfOV9oDVa1lXl6sns2mHW6urPy4CuaFf3eZ7A8b4fdrW6GIp5Afeb5Bn9M5rqKvG+34vwKV4F
 0o9oXSqs6QedsEafzy22HfrVblVZ9Iliwklbw1VdlGOxl/5WWn4vQkrzYtWC8cjc+z0yLw1AR
 1/8s+MpJ1MsLsmYvvXPIXH8lcwkAvM+qdW6Se3Qx/ioxAEEuX9MG0JEeIMQVeacCilxRL9E/D
 QLqwAUfcbMu14WICfjknDWWnniHiZIBtyDAvvSPRAXR18zEwqK4cm+mNA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/16 03:08, Thiago Ramon wrote:
> As a user of RAID6 here, let me jump in because I think this
> suggestion is actually a very good compromise.
>
> With stripes written only once, we completely eliminate any possible
> write-hole, and even without any changes on the current disk layout
> and allocation,

Unfortunately current extent allocator won't understand the requirement
at all.

Currently the extent allocator although tends to use clustered free
space, when it can not find a clustered space, it goes where it can find
a free space. No matter if it's a substripe write.


Thus to full stripe only write, it's really the old idea about a new
extent allocator to avoid sub-stripe writes.

Nowadays with the zoned code, I guess it is now more feasible than previou=
s.

Now I think it's time to revive the extent allcator idea, and explore
the extent allocator based idea, at least it requires no on-disk format
change, which even write-intent still needs a on-disk format change (at
least needs a compat ro flag)

Thanks,
Qu

> there shouldn't be much wasted space (in my case, I
> have a 12-disk RAID6, so each full stripe holds 640kb, and discounting
> single-sector writes that should go into metadata space, any
> reasonable write should fill that buffer in a few seconds).
>
> The additional suggestion of using smaller stripe widths in case there
> isn't enough data to fill a whole stripe would make it very easy to
> reclaim the wasted space by rebalancing with a stripe count filter,
> which can be easily automated and run very frequently.
>
> On-disk format also wouldn't change and be fully usable by older
> kernels, and it should "only" require changes on the allocator to
> implement.
>
> On Fri, Jul 15, 2022 at 2:58 PM Goffredo Baroncelli <kreijack@libero.it>=
 wrote:
>>
>> On 14/07/2022 09.46, Johannes Thumshirn wrote:
>>> On 14.07.22 09:32, Qu Wenruo wrote:
>>>> [...]
>>>
>>> Again if you're doing sub-stripe size writes, you're asking stupid thi=
ngs and
>>> then there's no reason to not give the user stupid answers.
>>>
>>
>> Qu is right, if we consider only full stripe write the "raid hole" prob=
lem
>> disappear, because if a "full stripe" is not fully written it is not
>> referenced either.
>>
>>
>> Personally I think that the ZFS variable stripe size, may be interestin=
g
>> to evaluate. Moreover, because the BTRFS disk format is quite flexible,
>> we can store different BG with different number of disks. Let me to mak=
e an
>> example: if we have 10 disks, we could allocate:
>> 1 BG RAID1
>> 1 BG RAID5, spread over 4 disks only
>> 1 BG RAID5, spread over 8 disks only
>> 1 BG RAID5, spread over 10 disks
>>
>> So if we have short writes, we could put the extents in the RAID1 BG; f=
or longer
>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by len=
gth
>> of the data.
>>
>> Yes this would require a sort of garbage collector to move the data to =
the biggest
>> raid5 BG, but this would avoid (or reduce) the fragmentation which affe=
ct the
>> variable stripe size.
>>
>> Doing so we don't need any disk format change and it would be backward =
compatible.
>>
>>
>> Moreover, if we could put the smaller BG in the faster disks, we could =
have a
>> decent tiering....
>>
>>
>>> If a user is concerned about the write or space amplicfication of sub-=
stripe
>>> writes on RAID56 he/she really needs to rethink the architecture.
>>>
>>>
>>>
>>> [1]
>>> S. K. Mishra and P. Mohapatra,
>>> "Performance study of RAID-5 disk arrays with data and parity cache,"
>>> Proceedings of the 1996 ICPP Workshop on Challenges for Parallel Proce=
ssing,
>>> 1996, pp. 222-229 vol.1, doi: 10.1109/ICPP.1996.537164.
>>
>> --
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>
