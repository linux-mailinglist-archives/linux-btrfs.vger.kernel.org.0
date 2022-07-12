Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEEA571AE2
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiGLNN0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiGLNNZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 09:13:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5791B4184
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657631595;
        bh=kI0gV3TIXScR5HBmmhAwBl2ecC/rL9BqgjuRiHeXczY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ND4gzJ59HOdzGr3Do8+LXx9slNbB9dpCpVHaVuC/f+RhDO80Q+NuvUBijZTHzfVKA
         MdDbEvuXAqc4KhiLqIUM2wKp7Ov1G44TGsF6tRpkbKHpbM660HpGcmB9i1SUTUG43E
         ioeoiQKdc9Vjhrkmp0j97vB/wRJyEfQmJl4GwnHk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3mt-1o0Qhl3Po3-00TYJW; Tue, 12
 Jul 2022 15:13:15 +0200
Message-ID: <fbd58f24-02ba-3c84-0c05-4de5f44d779c@gmx.com>
Date:   Tue, 12 Jul 2022 21:13:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: BIG_METADATA - dont understand fix or implications
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>,
        Peter Allebone <allebone@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAGSM=J8K7_GfaqL3-7obOSytNhtoqmJ1GQrOKAUgE2dF7OehTg@mail.gmail.com>
 <2ba98b68-f22b-5013-8c4b-47b5c62ed437@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <2ba98b68-f22b-5013-8c4b-47b5c62ed437@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C+GO1U9Z1Y4UXRvad/iMdmzslk5H1K8oj0vuavmGOElA0y2/4gb
 pyCpqhzePP7D4VmXbhLfBYkuasLQW60N1wxxPbox+uSGY0saXOIFay0oNF2BxaZLk1/mc/t
 oeGp61N2isqNzoQm13VYonQzcNNSLoonYMiAkJERCSndyPI01yY7i+IzFnTJEnKrNKwuqxh
 uuJd0oWgulX+k7dtFsZQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VqxkAFYu470=:bvWlXQKe8p2mj4dQ6ZJAfS
 +57Sr5jL++ja/06ybHT+5p/MJKueb+w21COuaUFR/+H1mICz0euuXYBGPY7WqLIFEfqNrb0hv
 WfMzoLNasu/Vd3BryU5YUAczdZPKXUhTou1dMkK/sFfa5JXpRlmjKRTWrsfFcinQWmSPbR81Z
 ZlE23jc+dtxd906vO3jBDfg6UsUHzCkXSNdmMc9iGyeFcuoKKNdakP/I8NFwEAeNHvVVqrHk6
 kEBXLm9x2AhV1AoQlGyoEdFPUFqrhw1cB88Z+S8gYQBDeZ6RzNBRpnBBwgUs+S2/ZbRcprMrB
 EU7HORbzaXW6/OstFHz6MrWnHG4YEhPKle9MQQZRZpZC1B0RP31o+ZpXtQLY0R3L4svOIdmkO
 GFURR4Jd8vcR2/PaTmL9smu/+E3OXlEt5hvA/hlt907/omv36ZJSo+zWU1VdgCSHxjw3vfK9t
 uu39iPT9xjwMDgTiiiz6lWO/OorRUaDMC7ieO0d3UplzWBMJ4qEdH2u0L8KTouydsTGQgxSUu
 nZOyRIhgOKn2zOYaHm2sOmZm/5ABA/SLadUbTbHfqZUCIFIuG0buiuGsN+PCK54TjBje/VXIG
 XSNnvTvtYznAV/3HXO6DiBd36cG1/WuGJQoI8mMStrjb0ohSlDfiLrSpFxCwxBCv26UzRNwG5
 ZgMRYkQ6xBCJcLt4PqZ+laEjZou6OtcF387uj2QWzTu9Jt6sfihxdvK0P/3n0rO7d5MiXglgI
 zQxp9ev6g9876CBVEkFcB2rBOs0XhIDMH650Wwd5maQ+Z29hkCI5ihy1iCxGnRDHNCy1ziK0h
 cszb3UYrKB8ktYNvsgfsAHSZQy87UadDSax/NGwPG2dCQ+K3/YN0JqPyWmqkYqvW447wwTcfY
 uUFvk8kTgv+Y2i9BBqj4Nk9Nvsmn+LTGeWOV+V9C1vlZZF4AqdHub1A47lf2BInqVvMNpx4+0
 3YtInunjUwNZerBfoLtL19i4H0GP2LXN/Hmt+6fCD2LFofw2cesZrs6pskVZKX3FGfi5VhyOR
 prbqJEdzG22DkvXjQp0Yk8s8en6B61wzd5/9egCyE14BnNdNXAtqOiVU5WNs69exmUaRpoRbO
 mVqz6XWAI5+tE/WyJuyOlRrdmbU/oupHL/aBBwBHlv33wBCo+p5KysEGg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/12 21:05, Nikolay Borisov wrote:
>
>
> On 12.07.22 =D0=B3. 15:24 =D1=87., Peter Allebone wrote:
>> Hi there,
>>
>> Apologies in advance, I dont understand how I am affected by this
>> issue here:
>>
>> https://lore.kernel.org/linux-btrfs/20220623142641.GQ20633@twin.jikos.c=
z/
>>
>> I have a problem where if I run "sudo btrfs inspect-internal
>> dump-super /dev/sdbx" on some disks it=C2=A0 shows the BIG_METADATA fla=
g
>> and some disks it does not. I posted about it here on reddit:
>>
>> https://www.reddit.com/r/btrfs/comments/vo8run/why_does_the_inspectinte=
rnal_command_not_show_big/
>>
>>
>> My concern is what effect does this have and how do I fix it, once the
>> patch makes its way down to me. Is there any concern with data on that
>> disk changing in an unexpected way?
>>
>> Many thanks for any insight you can shed. I did read the thread but
>> was not able to easily follow or understand what was implied or what
>> would happen to someone affected by the issue.
>>
>> Thank you again in advance. Sorry for emailing in. Hope that is ok. I
>> was just concerned.
>
> If you are using recent kernels i.e stable ones then there are no
> practical implications, because as soon as you mount the filesystem with
> a kernel which has the patch this flag would be correctly set. As said
> in the changelog of the patch this can be a potential problem for
> pre-3.10 kernels (very old) so the conclusion is you have nothing too
> worry about.

I just went checking v3.9 and v3.5, if there is no such flag, kernel
will still mount the fs and setting the flag.

So it doesn't seem to cause any compatibility problems at all.

Thanks,
Qu
>
>>
>> Kind regards
>> Peter
