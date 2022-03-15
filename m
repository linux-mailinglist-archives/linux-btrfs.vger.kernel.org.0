Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7D4DA5F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 00:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352499AbiCOXHX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 19:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352515AbiCOXHW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 19:07:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DDF5D66E
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 16:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647385555;
        bh=BB+8nOrBQ9N6o6r97WQ1sOfjLLVBYK2Z1XIMnWRDBh8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Jj556WkGTWz9AGCSdrHNZlVtTfKMyYiQ0kukC8HFQsqpUltMKd51OAkBDmJa3RUDd
         L2emP0p5kpZgSlX5HZuEtK62f8xQgCL2qLPN7covU53CaX2CzrfGyRGI7s3KcUGiXt
         JPJCL5VOCmD2UUC+vrPNlaDNtLPb+/AgOwyxZlHU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MowGa-1nuFzw2bgE-00qSNl; Wed, 16
 Mar 2022 00:05:55 +0100
Message-ID: <d03d620c-a287-075d-a2e8-77cbdf4dcba5@gmx.com>
Date:   Wed, 16 Mar 2022 07:05:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] btrfs: don't trust sub_stripes from disk
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <d5fb898de7b87629a08f51bf1ca50a2b8f48b95b.1647329345.git.wqu@suse.com>
 <20220315201534.GY12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220315201534.GY12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7swce7DoAAA/UNZXt63iOZpi0Pwg8XnQptXtmjgkqMlfMOgJBw7
 64tKdXCLPvG5AzGovVAMOKt6UksA3Oj+bmMdgxgvYQWfbz/9q88ox+cAKa/t21N9cR4iuNn
 Y3+Lq4ZIbIp4iaD7R+oQDbjFhRXZCvNfnCEGhVsnN67bOyDZaPBfz9+GuPrZz9NDww4RKhl
 RoPEUv9cJNfsIBviKDMAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4YZQpJ/Euks=:MiLLOkC7q2INdDyIZI+jCj
 u9/As8dGRbZltZp6NKT54kIU3c2c3tbbQEJFKJ9zzczIru+grkolUQQ6lMcTFXkQs79hddpMd
 496S4w03oMXb3NaXN+0HNR3P5Jzu6LT+bWXfqPLsjVvpGWNZbcl0kBNzXknNsP9hMJ5irPnRz
 QiUPiwUErKGa2tMqxbqncPJ0WlSMZOfEWl1IhbQmY3el9R36cUNMmG7yWlkJb7vrR62TWH63/
 zE3OZ7MknQz76G/Ww/RU42u+VxDJ9Xn2gFeUHDj7OZGGMwh81nAniA08LWIbclKZyq/Ks4Z1A
 Fnhiz/oyzRbePzGY+YyzOwY0O9KKkLEYAcl4SYRjHUjTdOqJ5hekOjYJjj2aEsFUei67xHkmf
 ygBormPihW1Ue+e+0Lp+6uwhMXfGTWpC2/lOieJK7HjSL7unBNRANKn4+fYcyUQt613hsxieY
 Z3XFZ8uYEJpdWDTqEuZ2ztxzeAPntdfpttriEH7vUZMVuZ9c6qfUxcNZIzVHI9kW1XHXC9fbc
 EH6MD0j2gODnlMIai4svdplU0oHj28jNyyVkEcBgCUu0hLkAWVkCzY0Y4ijoXCE1CU4Udm01e
 0YATjU9ceIHZJs3G9dNVVMjovpmQDz8WoOYKw2Tw6n6yOCVJuMxti8EQhhBWzcQ6AyH4BRors
 /fhTYsucImosl5QNXScLXEJCDxoFE/GngFDCAEaEyYxgDn0ESSk1kNS4sAFdxP8Wi3YSGbsu9
 bi0UKxeQBlb/AUBtuYtUSBxjsbfzrEQ6uzKy5YdC5TeEP34KtlTqIHa55hi7p+tItL/tqQMDO
 19cUKfofLlun51/YLk1IMR6n7Z3Hw4vWj2jXIUEFWkwgk8dED5DJzzqy7sbcz2mwYFqJXRHND
 8g+q6k0pMPC9QrJ+GelQSWXuyYxSjmkp1H+PMl6JX7LL9fvtNg9Jtcydl7LYhcKiTHQO17DJD
 EAeHIVryKv8lUpGt0rG5l4mVuZ9C31zc9kcNNpAlo0EixDCrR78Rc1JxAeFJjM1/3nl/iPRFP
 SBHvSKBZBRxAdx780jH86gQUdkGpqzFORvFICuxPKxb6ZPB7l7NKzoLftQqWvVeBrm8/S5Q+J
 zc5EGEqMVKDIkg=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/16 04:15, David Sterba wrote:
> On Tue, Mar 15, 2022 at 03:32:59PM +0800, Qu Wenruo wrote:
>> [BUG]
>> LKP reported a divide error testing my scrub entrance tests:
>>
>>   BTRFS info (device sdb2): dev_replace from /dev/sdb3 (devid 2) to /de=
v/sdb6 started
>>   divide error: 0000 [#1] SMP KASAN PTI
>>   CPU: 3 PID: 3293 Comm: btrfs Not tainted 5.17.0-rc5-00101-g3626a285f8=
7d #1
>>   Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
>>   RIP: 0010:scrub_stripe (kbuild/src/consumer/fs/btrfs/scrub.c:3448 kbu=
ild/src/consumer/fs/btrfs/scrub.c:3486 kbuild/src/consumer/fs/btrfs/scrub.=
c:3644) btrfs
>>   Code: 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 0c 11 48 89 fa 83 e2 =
07 83 c2 03 38 ca 7c 08 84 c9 0f 85 27 09 00 00 41 8b 5d 1c 99 <f7> fb 48 =
8b 54 24 30 48 c1 ea 03 48 63 e8 48 b8 00 00 00 00 00 fc
>>     0:	00 00                	add    %al,(%rax)
>>     2:	fc                   	cld
>>     3:	ff                   	(bad)
>>     4:	df 48 89             	fisttps -0x77(%rax)
>>     7:	f9                   	stc
>>     8:	48 c1 e9 03          	shr    $0x3,%rcx
>>     c:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
>>    10:	48 89 fa             	mov    %rdi,%rdx
>>    13:	83 e2 07             	and    $0x7,%edx
>>    16:	83 c2 03             	add    $0x3,%edx
>>    19:	38 ca                	cmp    %cl,%dl
>>    1b:	7c 08                	jl     0x25
>>    1d:	84 c9                	test   %cl,%cl
>>    1f:	0f 85 27 09 00 00    	jne    0x94c
>>    25:	41 8b 5d 1c          	mov    0x1c(%r13),%ebx
>>    29:	99                   	cltd
>>    2a:*	f7 fb                	idiv   %ebx		<-- trapping instruction
>>    2c:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
>>    31:	48 c1 ea 03          	shr    $0x3,%rdx
>>    35:	48 63 e8             	movslq %eax,%rbp
>>    38:	48                   	rex.W
>>    39:	b8 00 00 00 00       	mov    $0x0,%eax
>>    3e:	00 fc                	add    %bh,%ah
>>
>> [CAUSE]
>> The offending function is simple_stripe_full_stripe_len(), which handle=
s
>> both RAID0 and RAID10.
>>
>> In that function we will divide by map->sub_stripes.
>>
>> So this means map->sub_stripes is 0.
>>
>> For RAID10 it's impossible as btrfs_check_chunk_valid() will ensure
>> RAID10 chunk has sub_stripes set to 2.
>>
>> But it doesn't check RAID0 (nor any other profiles).
>>
>> With more help from Oliver, it shows that under their environment,
>> SINGLE/DUP profiles also have 0 as their sub_stripes.
>>
>> So it looks like a bug in btrfs-progs, but I can not reproduce nor pin =
down
>> the exact commit.
>>
>> [FIX]
>> >From btrfs_raid_array[], all profiles have either sub_stripes as 1 or =
2
>> (only for RAID10).
>>
>> Thus there is no need to trust the sub_stripe value from disk at all.
>>
>> I'm not yet confident to put such sub_stripes check for all profiles, a=
s
>> there is no concrete evidence to indicate it's a bug in mkfs.btrfs, nor
>> how many users are affected by it.
>>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>>
>> I don't have direct evidence to indicate it's a bug in mkfs.btrfs.
>>
>> But both code review and extra debug patches show Oliver's environment
>> has chunk items with 0 as sub_stripes (for DUP at least).
>>
>> However using the same progs version, I can not reproduce the same
>> behavior at all (still 1 sub_stripes for SINGLE/RAID0/DUP/...)
>>
>> So this is just a preventive method.
>
> This is obviously safer as the values in the table are fixed, but it
> would be also good to find the cause. I think that if it was a bug we'd
> have seen it already but it could also depend on the setup.
>
> Have you noticed any other strange looking values during the analysis?

Not yet.

The current definitive debugging is adding BUG_ON() to each
map->sub_stripe assignment when it got 0 sub_stripes.

The first trigger is from read from sys_chunk_array.

And according to the result from LKP guys, the offending fs is using
default mkfs profile (AKA, DUP for sys chunk).

So currently I'm suspecting the progs is doing something wrong.
But their progs is 5.15.1, and I failed to reproduce using that tag.

Thanks,
Qu
> One weird value would mean it's a bug but if there's like a missing
> whole update in some data structure that would get fixed after first
> write it could be eg. a missing fsync somewhere or a bug on the lower
> layer.
