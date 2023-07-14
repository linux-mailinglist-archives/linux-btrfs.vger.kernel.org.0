Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F7E75383B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 12:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbjGNKcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 06:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjGNKcm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 06:32:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F7630DB
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689330751; x=1689935551; i=quwenruo.btrfs@gmx.com;
 bh=Vrc6mmNAdVlkW6fpP8m+q5AaFxAYnMDWpDJ2K5HwvUg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=pMR+Ghi9LYTXnP72dpwmCeWRK/opXc4spF4Ic3www65XquMotg8q86T5ONKZe3h8TKXjhIX
 y3OjPOQog4kBquEwBQOMjCRiDa/x9VDQGZWJSAM9Nfd10mhoob/2VSf6sIB3QumxKoXJuLh11
 H87Ctr6QIY3MErhGT/BjLhQuVZb9qop52nbVuvBxEfMb4ZgK3ca8Bs0e3SuZ8Bcj+8OiTKkcF
 D9iL96H+iH5elk7kAzoKP/Vv+I9qWbdCzK/V7eaD/oScsH5tGtxtFCzy257nnzcQDt1ii6KUq
 yXM5AwNpOQMPVIE0PF14SbgjnQPFqEt5VLjuC4LGiHVAnIV/FhPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZTqg-1qQMEy3erO-00WWCR; Fri, 14
 Jul 2023 12:32:31 +0200
Message-ID: <3414dd0b-7b69-28d4-28c4-3405e9b8139f@gmx.com>
Date:   Fri, 14 Jul 2023 18:32:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1689143654.git.wqu@suse.com>
 <20230713120935.GU30916@twin.jikos.cz> <20230713163908.GW30916@twin.jikos.cz>
 <9251d155-2e2e-a126-579e-2765e98a4a9d@gmx.com>
 <20230713220311.GC20457@suse.cz>
 <6c7b397a-8552-e150-a6fd-95ae73390509@gmx.com>
 <20230714002605.GD20457@suse.cz>
 <1bab3588-9b53-c212-3b45-91ee61f5b820@gmx.com>
 <20230714100349.GF20457@suse.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230714100349.GF20457@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UehBawz9PDq7sNLOGVw1ZUngm6kXq6ZjZN/AEXV+vYZp/G1tEtH
 LE953JoI/73x/pzi0yuZfV8o7Lqk7qXtyfRSP2naOGWJKwQA81Hj5uh5RYfEAMTskSgn5hE
 mPX0v+d/PcJmTUnL4OEEr8hatq/FQL1yqsj9G87Rme01184lm6RHmeLEJsu1QfwhBOoSPrQ
 KEwir6B5FfAUAXmY3e2oQ==
UI-OutboundReport: notjunk:1;M01:P0:RLS05No0e48=;YkL7IuHBZnqHAzqrMfjTtSRHPg0
 2hDIfZ/WII5+1O3PFZxTFRLjQyV9X6BZXlvwciPJt2BRZGy+lBRy0OiMWXdcciudOk8N2BPgc
 GNdpeX1dpmS5TWHaeeSzL4/DNhS91bLNE9/3i+vIHzzGs2KwR41A88MoPAvf91L2Rq7mijyxy
 udjZ9JlMv5kAlWcGTdOuR3fxpEp2RvOkn0lQWDUMkvCYtEb9oeCHlTIMFO/K19LbWW5cZh8C1
 +uP7+KO/n7tBQodyecLOSMScSQUczTndrPKvx0lPtWA68LXul8t+5GCLzF6K5m0n21qbX8v/R
 VuyofzCQlONR4Rf0jPkVCant8M9APXHxDy9h7kYtoDf7rhqbWF9SftpKO/IDMqv11rMRNaxlo
 5rs/3tlRvNW2yIT29vcTh5Ge6/NGYKBi7OmZJ3uyyP6XLDidHx+o3o204LQs2KtXV0qLIbsTR
 JUbQccE7Dt0EILrHX9H2JnKJ3BUTqACpOjO0zRHEkloQhCFpedf26YBfmUJ3aJFvKoIH2whgc
 s5lFZap6s22vumnGbpluU783lhHRzN6BJOaNp32yK5NRoCvn5wMLN7PXMYYO2l5bY6FumQUUs
 5y50/uiRredpjrsZMWNJBBOA2eKkhQok0BW2gJ/a3NYeGTOoEcaXA+63UR3fm2fB1rVT9h5GU
 i3P/hJBl0xyEUgVvHmYHKCZ8WXaAXVlqhLgiSID53DYUppQBbBA5pHiSyJAVy3lzYgkLe5civ
 8LM+nf6APJhyJPFMxejfmCZpJSwlHRZ4GtQ16lj4WCeXk5HqbOrARgWBicTo63rLrMOq6E4Tp
 hmTfwxtn3P2gNeVdXFScCQCQ3TOT+qMMGg7NGpiDcaQ3J+EGzUxmsu/tcadDIgmzVeuAIMgmu
 ocvLNCdm/LmmUoQ1W621ZpmvRd5nr+Bqgzu1+1wxYoipb25AvBLxtuL/XEbiPfmB5Aa+s+Sew
 sIbB+FQ5JLtMq5GLOS8j4Of1Ynk=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/14 18:03, David Sterba wrote:
> On Fri, Jul 14, 2023 at 09:58:00AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/7/14 08:26, David Sterba wrote:
>>> On Fri, Jul 14, 2023 at 08:09:16AM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2023/7/14 06:03, David Sterba wrote:
>>>>> On Fri, Jul 14, 2023 at 05:30:33AM +0800, Qu Wenruo wrote:
>>>>>> On 2023/7/14 00:39, David Sterba wrote:
>>>>>>> 		ref#0: tree block backref root 7
>>>>>>> 	item 14 key (30572544 169 0) itemoff 15815 itemsize 33
>>>>>>> 		extent refs 1 gen 5 flags 2
>>>>>>> 		ref#0: tree block backref root 7
>>>>>>> 	item 15 key (30588928 169 0) itemoff 15782 itemsize 33
>>>>>>> 		extent refs 1 gen 5 flags 2
>>>>>>> 		ref#0: tree block backref root 7
>>>>>>
>>>>>> This looks like an error in memmove_extent_buffer() which I
>>>>>> intentionally didn't touch.
>>>>>>
>>>>>> Anyway I'll try rebase and more tests.
>>>>>>
>>>>>> Can you put your modified commits in an external branch so I can in=
herit
>>>>>> all your modifications?
>>>>>
>>>>> First I saw the crashes with the modified patches but the report is =
from
>>>>> what you sent to the mailinglist so I can eliminate error on my side=
.
>>>>
>>>> Still a branch would help a lot, as you won't want to re-do the usual
>>>> modification (like grammar, comments etc).
>>>
>>> Branch ext/qu-eb-page-clanups-updated-broken at github.
>>
>> Already running the auto group with that branch, and no explosion so fa=
r
>> (btrfs/004 failed to mount with -o atime though).
>>
>> Any extra setup needed to trigger the failure?
>
> I'm not aware of anything different than usual. Patches applied to git,
> built, updated VM and started. I had another branch built and tested and
> it finished the fstests. I can at least bisect which patch does it.

A bisection would be very appreciated.

Although I guess it should be the memcpy_extent_buffer() patch, I didn't
see something obvious right now...

Thanks,
Qu
