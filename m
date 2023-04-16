Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ADA6E3495
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Apr 2023 02:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDPAXb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Apr 2023 20:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDPAXa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Apr 2023 20:23:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FA435A8
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 17:23:28 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbox-1py3QT1Fk3-00P5dI; Sun, 16
 Apr 2023 02:23:27 +0200
Message-ID: <352ecefe-cf65-ce53-dd25-15445e3f484e@gmx.com>
Date:   Sun, 16 Apr 2023 08:23:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: scrub/balance a specif LBA range
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Torstein Eide <torsteine@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAL5DHTGEzg2evkVEQMfcCo+kyq_7XcgGJfjLcH6OaQWrvqMAiQ@mail.gmail.com>
 <182e4a51-53c2-94e5-71c8-3125832dd2ec@gmx.com>
In-Reply-To: <182e4a51-53c2-94e5-71c8-3125832dd2ec@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0YlDjXY0zFcl8JI3A7x8I4hoOrPnhPSEma8cUeZzq5Dwt/TLNL6
 aX0GqtqL/lkKz9sQE5X1P0C0F8aZwfQ1Ve1KszWULiNON9kc+RC0xRwbqJ1og1FB7JOXMGc
 p4CQxigiSpxjmr+qlff3S2HBWUly756ngnImibIgugYi5E3lpx+uC58BCZ0CPN0H4tX6wbg
 /TKH83Wl8tX1WJU5K4B3w==
UI-OutboundReport: notjunk:1;M01:P0:aez7czLVKLQ=;GDG/KNQ55O2cQh9Nu2kR8bKqwXg
 rseIroNokkdLhRiCeAmyCXvmN1RuW7KrXsUvSIX7UfuI39eRnvggniSiyA6eUlWvVo85xqgjH
 nscKSyAO5q/d4ZnaT+zHNoP811dIPX4nhAhJgX8qkb3UiX4XAApZ02t1BTk8XiPcTvVqEpS8s
 FKSPnLIhfhq55VaPmwxwP9IgA9X1bcr5b3OMY/OOe2vflJZygUjZIkma1Cg6WFx82/2I8hSFl
 eM+F1ZPeJAz7Aco7e2/xOeckW4xVdFy6WbL2Q0TgItExvdqJjn1Gg12kTOXosryblbR2ev/zy
 aiQVp2isYwTZ7mF6RHp+vBtziMUK6nXhGfbCBYAnRWIbv4byUc3y05mUFiKfy7uuav6455+EH
 DwKcUx9fS4nTnVp47Rw/u1aCmn0sasU3yo0Xpq6BTfvIe/DEujIyXPAlQjTluqpZTOrIZA4SL
 WbIzY2qgn9+cgrI9i3xj105gSIjSBh4/24qYDZX11lqx8QDZ/K54LYBTUv1vVt8oV2DVgei6T
 dm80bwRnnRxGX3dc8Aa3dWxRvxc0ctFKRuWkfB0F30I4y0DtScErRvsM7ukcF2c6SBm0ww9pM
 jfC0cZ/hNfvdTfrcx3mslJ/oIVyhXxMin3mH1PTCvOqbLqblIRWvVoWC3uDR10z7Vd+1Ki1rh
 2Y5Vz+4SZfvwVyH+u0SDXTQoQYvI4Tig4d0pdcg8s4eQoHMRzcYUuFrzlXD9vgi3HlahkxrPG
 vf+VDFh0qoRg+t9mLYy4maebt/l8is5Q9suSfmA7+KMMIT9OY9OAgp9d5pyPAQBTlAI6c+r15
 AfQOgBpEdRiImnw143h0IZ8E/0fvrxRpp2OZce2i8uwwbDASPXI4FajiiXM0sdqbcRJ9AEOBf
 oOiEmOUvbR7rFioJjWLUgfGOIXycjgitNVtzNCEWdUdRyWpEtQyJaxHAqmul/xC5uPXWVfh83
 G7ngs8si/KpAW/9wCadqQRDfcq8=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/16 08:16, Qu Wenruo wrote:
> 
> 
> On 2023/4/16 02:59, Torstein Eide wrote:
>> Hi
>> I have a disk with "Pending Sector remap".
>> That can be view with:
>>
>> ``smartctl -l defects  /dev/sdd``
>>
>> ````
>> Pending Defects log (GP Log 0x0c)
>> Index                LBA    Hours
>>      0        11454997800        -
>> ....
>>      7        11454997807        -
>>      8        11455002752        -
>> ....
>>     15        11455002759        -
>>     16        11464481352        -
>> ....
>>     31        11464486423        -
>>     32        11480702000        -
>> ....
>>      39        11480702007        -
>> ````
>>
>> Can I tell btrfs scrub or balance to move files on these locations?
>> I was thinking the balance `drange` may work but was unsure of the
>> correct format.
> 
> You can use balance to only balance a logical range.

s/logical/physical/

> 
> And it's indeed the drange option.
> 
> Although you may need to specify the option for both metadata, data and 
> system, or go --full-balance to make sure all chunks are covered.
> 
> Thanks,
> Qu
> 
