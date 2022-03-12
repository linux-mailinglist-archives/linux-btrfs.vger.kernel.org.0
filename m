Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA00F4D6C3B
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 04:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiCLDZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 22:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiCLDZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 22:25:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DB2108554
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 19:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647055463;
        bh=ed24zJRktpYq1OX1lqyEFadRy50JDFa2w+QQcr794iM=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=dY7kEQ9jp2SiaafEa+pA0/2an8uCYL3rf4/aPwaq3gnuItgc+1KBqYys7TFomGTan
         OCVezBZOX/Fy5TqiLobmZESHdpepm/JKP61EyUbGOWpF1AcMh5eyhDobDob9nVSyEt
         fa8TZsgLLsNUZl2RYtHDy6pNScjL7H/KV0dl/4bU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeR1-1ngz6D1jut-00Vl1P; Sat, 12
 Mar 2022 04:24:23 +0100
Message-ID: <59c57200-9c77-3b8a-ab9d-11aef96da852@gmx.com>
Date:   Sat, 12 Mar 2022 11:24:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Zygo Blaxell <zblaxell@furryterror.org>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <CAODFU0q+F2Za=pUVsi1uz9CLi4gs-k1hAAndYmVopgmF9673gw@mail.gmail.com>
 <CAODFU0pxmTShj7OrgGH+-_YuObhwoLBrgwVvx-v+WbFerHM01A@mail.gmail.com>
 <e7df8c6e-5185-4bea-2863-211214968153@gmx.com>
 <CAODFU0r=9i2mOwNXVx74GcKUSt4Z6wGqshgD=5bktFhoXCWE4A@mail.gmail.com>
 <YiwIxnCMjsl8BPPA@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
In-Reply-To: <YiwIxnCMjsl8BPPA@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6ydkboeyZ7jwtCCgHCicg+iJhAYiXyb0UqHRJ2v7uhziDFN9lhl
 MIemazK6vxGV2Z0AoYsJmuhuMP7zmY0w2YYnFj1W7ZiiTrO3RfhEs5lsKjUGXVfhDqxnwfM
 lxncYJbu6hAFiVnoU5N3s5ZKPeN3BFshIZscO5FNFHobMSqHq5vDaHFhLkKKd8vJsfxPQRa
 uB01KpSa4dUyouxNTELnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WyIewLm5hLU=:3eQrE8n4pVnAVvmNWiss/t
 qequjAIcQUark8tE4ieXgyy2r3pXfR9Z/dNmFqnWQZLAAwJvFOE0MRRAfl7KCHcmMAFhl83Yx
 yetxD1Vknm19EFcHkrbpc27iB+DZZG4EV3dXweP8uFuv3wwnWdtsIbVaSzi7iR0TtOWDCpmnB
 DB4rR78FpklHvX4aSgoUkRxO9m6h03Omd+c8/WSbeVTU1cno+iWeYwK4PzjMQJe2vWigWotHd
 Gc7g++tj+vV1dULIp4TB5OauzaeVB9AOmxMY+Q6Rw5UrCg0Bt5aeUo6bJzDPD24+diYD28WOd
 nB7YzMVR1RzqkvbHjjHOx0B01NoDka3Uw7a92NrsjvNTaIovtAURRYvt2PJIzQpAWPHvfDuCv
 8bDVlCALqDkaRYLWKh9j20KLL5nhzK6fpU6mDueO6C2r4RxP5sSScyz8GfjNL7qm99E9p9wAC
 6FTcaLhCFOAKnE1xoPCzKVIerJ7b6zkwvZwrgYhXD7lyCmmDUk0LGb0TIqA3CmA0UXmlGPswN
 fst2VrqL+2sR6LI5v/tcmSDluXBE4m0VCnVHdhjqwYxwvOqte726bL23pt6ZN3FaqhNPpnkWZ
 onpaPgxMWMd7QSQ5wlfYXSlcUSPOz7kyzMXHT6VfvWhLlEyP0gdWaWN5OS3vChwRUa38kubqs
 aPNLg4xlNN9bj9MG6xbYlFIbV1TRJxkXeZavruz072Av0bcmTkD0a5loXJQsuy/KtipM0U+qp
 lPfBF72aJOgLbmTr4gQu0l5nKvAKruZ80c9LMDiH0dFJlb9h39O/ezq0LolD5kYtq/8yHTgUY
 CcvPmNpyMcqRA0j/w/TSf63N08m0k03Kfg+6yr1pbKzA1CQxmtVBz5SPUG7zxYhDFuXwkE2Nn
 wWCLF6Hat+e+d6zvgvKre25/h49xBbnKy4ioifc8OhCEmdx6QVxGKZXJz1cmNU3nO75exF3M0
 E5vL6fKoqvA+kMk0ZYm6zWS+LQQmVGGUB9NAuXpbIe9z96XvfcWHL+HeAkdObBsjVJ8pBkJN6
 GtP96O+z/dib2AsNO2XtnWnvnCg9vKa8SYoXSoaapN3MxrgRND1xA1Mcty5qM5itt1YGGcRIo
 /vw+mag0RmX1t4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/12 10:43, Zygo Blaxell wrote:
> On Sat, Mar 12, 2022 at 12:28:10AM +0100, Jan Ziak wrote:
>> On Sat, Mar 12, 2022 at 12:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>> As stated before, autodefrag is not really that useful for database.
>>
>> Do you realize that you are claiming that btrfs autodefrag should not
>> - by design - be effective in the case of high-fragmentation files? If
>> it isn't supposed to be useful for high-fragmentation files then where
>> is it supposed to be useful? Low-fragmentation files?
>
> IMHO it's best to deprecate the in-kernel autodefrag option, and start
> over with a better approach.  The kernel is the wrong place to solve
> this problem, and the undesirable and unfixable things in autodefrag
> are a consequence of that early design error.

I'm having the same feeling exactly.

Especially the current autodefrag is putting its own policy (transid
filter) without providing a mechanism to utilize from user space.

Exactly the opposite what we should do, provide a mechanism not a policy.

Not to mention there are quite some limitations of the current policy.


But unfortunately, even we deprecate it right now, it will takes a long
time to really remove it from kernel.

While on the other hand, we also need to introduce new parameters like
@newer_than, and @max_to_defrag to the ioctl interface.

Which may already eat up the unused bytes (only 16 bytes, while
newer_than needs u64, max_to_defrag may also need to be u64).

And user space tool lacks one of the critical info, where the small
writes are.

So even I can't be more happier to deprecate the autodefrag, we still
need to hang on it for a pretty lone time, before a user space tool
which can do everything the same as autodefrag.

Thanks,
Qu

>
> As far as I can tell, in-kernel autodefrag's only purpose is to provide
> exposure to new and exciting bugs on each kernel release, and a lot of
> uncontrolled IO demands even when it's working perfectly.  Inevitably,
> re-reading old fragments that are no longer in memory will consume RAM
> and iops during writeback activity, when memory and IO bandwidth is leas=
t
> available.  If we avoid expensive re-reading of extents, then we don't
> get a useful rate of reduction of fragmentation, because we can't coales=
ce
> small new exists with small existing ones.  If we try to fix these issue=
s
> one at a time, the feature would inevitably grow a lot of complicated
> and brittle configuration knobs to turn it off selectively, because it's
> so awful without extensive filtering.
>
> All the above criticism applies to abstract ideal in-kernel autodefrag,
> _before_ considering whether a concrete implementation might have
> limitations or bugs which make it worse than the already-bad best case.
> 5.16 happened to have a lot of examples of these, but fixing the
> regressions can only restore autodefrag's relative harmlessness, not
> add utility within the constraints the kernel is under.
>
> The right place to do autodefrag is userspace.  Interfaces already
> exist for userspace to 1) discover new extents and their neighbors,
> quickly and safely, across the entire filesystem; 2) invoke defrag_range
> on file extent ranges found in step 1; and 3) run a while (true)
> loop that periodically performs steps 1 and 2.  Indeed, the existing
> kernel autodefrag implementation is already using the same back-end
> infrastructure for parts 1 and 2, so all that would be required for
> userspace is to reimplement (and start improving upon) part 3.
>
> A command-line utility or daemon can locate new extents immediately with
> tree_search queries, either at filesystem-wide scales, or directed at
> user-chosen file subsets.  Tools can quickly assess whether new extents
> are good candidates for defrag, then coalesce them with their neighbors.
>
> The user can choose between different tools to decide basic policy
> questions like: whether to run once in a batch job or continuously in
> the background, what amounts of IO bandwidth and memory to consume,
> whether to recompress data with a more aggressive algorithm/level, which
> reference to a snapshot-shared extent should be preferred for defrag,
> file-type-specific layout optimizations to apply, or any custom or
> experimental selection, scheduling, or optimization logic desired.
>
> Implementations can be kept simple because it's not necessary for
> userspace tools to pile every possible option into a single implementati=
on,
> and support every released option forever (as required for the kernel).
> A specialist implementation can discard existing code with impunity or
> start from scratch with an experimental algorithm, and spend its life
> in a fork of the main userspace autodefrag project with niche users
> who never have to cope with generic users' use cases and vice versa.
> This efficiently distributes development and maintenance costs.
>
> Userspace autodefrag can be implemented today in any programming languag=
e
> with btrfs ioctl support, and run on any kernel released in the last
> 6 years.  Alas, I don't know of anybody who's released a userspace
> autodefrag tool yet, and it hasn't been important enough to me to build
> one myself (other than a few proof-of-concept prototypes).
>
> For now, I do defrag mostly ad-hoc with 'btrfs fi defrag' on the most
> severely fragmented files (top N list of files with the highest extent
> counts on the filesystem), and ignore fragmentation everywhere else.
>
>
>> -Jan
