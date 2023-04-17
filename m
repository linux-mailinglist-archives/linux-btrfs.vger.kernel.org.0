Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436C26E47AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 14:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDQM3I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 08:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjDQM3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 08:29:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C16A4
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 05:29:00 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJhU-1qDl9v18tw-00jIpU; Mon, 17
 Apr 2023 12:54:55 +0200
Message-ID: <974217d6-0246-3732-0fe5-e443c8158edc@gmx.com>
Date:   Mon, 17 Apr 2023 18:54:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Otto Strassen <otto@tostr.ch>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <sY9YYJrpztwzxhv_9p28An7hkWNiF8hHF0we0ToIQ69b3lpaeBc7l77Kd4jYdsXA6Rps73Xa3guq3XA8c3mZdxDIvSwO5Cyh2eeO5Aqh3-s=@tostr.ch>
 <c3bf3d9d-9be4-713f-64b8-769d2a014d1a@gmx.com>
 <BWQf5N5kpHk5W540zTSqzDYn2kLi7lwJt-3odaRz1xs751TcwplGjnVGU-ytnar_lcoaKZHghhONSHAdSPtC98yyq52HXIUTCq1x65RWGwU=@tostr.ch>
 <fb3714a3-ab30-30b0-f336-68e2717b20d8@gmx.com>
 <vU62kpQ14yw_mYWcogz5KZy0j0wZ_1bNBQnJvvc-zqlqZAYpjFderRCnigBCG3F2Sv5g9PKexYTf9_dO8H1OxDkQQg1Vlz4UZzMmkwsx7Z0=@tostr.ch>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Filesystem ro mode, check shows a lot of missing backrefs, no
 idea on how to proceed
In-Reply-To: <vU62kpQ14yw_mYWcogz5KZy0j0wZ_1bNBQnJvvc-zqlqZAYpjFderRCnigBCG3F2Sv5g9PKexYTf9_dO8H1OxDkQQg1Vlz4UZzMmkwsx7Z0=@tostr.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Q2KteQWnIa2s4yYvtva0lNcVMjmdNCv9wCbu6gzliPuAtR9Pszd
 6EqoCHbxelyFwX0NIxMF2Djm03vP+UMtfJyqvmGbYnI0SqF8CS/L2skfnkJJC7UrAIfA/bM
 HFN3XzTUGqpPAvTnWb0IcBm3uqZEBtNaLm3KsdG8QONvsFyJLUY66DoenEkG/bNh6ZbNI4A
 FRd+I9+Fe7h7tPMaf1Oyg==
UI-OutboundReport: notjunk:1;M01:P0:iLHzrhf8+pE=;XwZPpocUmuymhxYmvInO7Ta9lO7
 +/N+B2tNpuOOeultTS+JC/a0IF/N/o7VrfKEVYCoydp8DAHJYlP3DFQFktxLTnpvxtErdo3N8
 hk9cXTMo9Apd8jGCeCUGZfIBL+LFXxRLP8Zcfyaw4puHJp4BXhDh4hDCfcFOXHiIZF+UZdqXD
 8yddIoNM+g0YRBUuu2koiotPuVucy4QZbW8VQT/F6mia37AZm/p2KpSyjHt/NShpk7l60ic6W
 QVPLiPfID6yC7umsXDjVE7f32n0E94EYdW+SXZouXSLqWO1Nne2ra5Vvy6mV7vzNHIDu69W0w
 HkuG+pdBtYo1J9IO7SG4IIX71T/EDikiFiRFu8f/WqfccDUhO7OuGbURsQWcdwj34Jmujhqbm
 GhSjmgzWYzD3jxRUqBfDS85Bq4+0MV/W5zHiarZayxk6M1VMFLhsAP0/XYmBPwgGlEXcCnuH6
 CuJ17FfRaoxdB66h/WokvYi3Hoqd/mfIBrsOGfFj0NsWvOgbfi1ICg6Y1ewgIDqrQgHapKE+2
 ML65m7WjaxlJ3CibRd5znYmF0bmcV+Kwt0G8qc1P9fojXzgUcHJH4EY9Tv2lyWSh3tBL677dX
 gBkCj/cWXCP4GNSk9ZHOjI8XRaQ/hgUv6H8AUATZ8OgKej6V291pz2QjqjMCRWAihfup4GhER
 OUofWKe5fCqlfggq4zdrOWqbmnbH/DEi9yn11vHujVdq2lvK5odcYdnS0SIghrg/ssxS0orXQ
 FeXQ1rtS4V299R1FXKgKprfv1iYVu4qiGm27ErP8bk/Z/l7OJObDGmjrK0tqX2mzuLA6DARSL
 XpyrrrEouf09bzUW5/T5qaDebj+Z4h+6452sbpfM2v7UUZXD/DreBhMC1DbVbTmL0z+GKUHdz
 oa97iwqcjBZu3KaOuGSzBzMBHXOkvtpEkQ5mcmvIHIRKJHK3cVLiKxMYDoeZ67C6D0+8c1g1Q
 G4nOyPuu11FreYQP6PTZiNl3Nn4=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/17 18:10, Otto Strassen wrote:
[...]
> 
>>
> 
>> That's the tradeoff one has to take when sticking to a specific vendor.
>>
> 
>> But if you're going to rebuild, then why not just try "btrfs check
>> --repair" in this case?
> 
> Ok, some development here. I had to hard-poweroff the NAS because it had become completely unresponsive. After that two disks were failed. I removed them, and re-integrated them (no replacement of disks) and md rebuilt the array (no problems). That in itself I find a bit strange, but maybe I did the poweroff at a very bad time?
> 
> Now here is the result from repair etc.
> 
> $ btrfs check --clear-space-cache v2 /dev/mapper/cachedev_0
> # I had to do this before it would let me repair
> 
> $ btrfs check --repair /dev/mapper/cachedev_0
> # Went through the ~50k lines
> <snip>
> backpointer mismatch on [21189054693376 16384]
> 
> owner ref check failed [21189054693376 16384]
> 
> repaired damaged extent references
> 
> Fixed 0 roots.
> 
> block group cache tree generation not match actul 238649, expect 240741
> 
> checking free space cache
> 
> checking fs roots
> 
> checking csums
> 
> checking root refs
> 
> found 20419805880336 bytes used err is 0
> total csum bytes: 938142472
> total tree bytes: 2908684288
> 
> total fs tree bytes: 1667170304
> total extent tree bytes: 178520064
> btree space waste bytes: 427759440
> file data blocks allocated: 28059017342976
>   referenced 26999960571904
> 
> 
> $ btrfs check --readonly /dev/mapper/cachedev_0
> Syno caseless feature on.
> Checking filesystem on /dev/mapper/cachedev_0
> UUID: c14c923f-2038-4841-aa89-504f1044d3be
> checking extents
> Found dropping subvolume ID:2632 dropping progress: key (458271 INODE_REF 457325) level: 1
> Process dropping snap root: key (2632 ROOT_ITEM 0) dropping progress: key (458271 INODE_REF 457325)
> block group cache tree generation not match actul 238649, expect 240741

The result is in fact pretty good.

This means no more extent tree problems.

The weird part is, I can not find any code responsible outputting above 
3 lines, the whole "git log -S" shows no match, I doubt if it's some 
Synology proprietary code?

In that case, I'm not sure what they are handling, especially for the 
"block group cache tree generation" line.

> checking free space cache
> checking fs roots
> checking csums
> checking root refs
> found 20419801194496 bytes used err is 0
> total csum bytes: 938142472
> total tree bytes: 2907209728
> total fs tree bytes: 1667170304
> total extent tree bytes: 177045504
> btree space waste bytes: 427205612
> file data blocks allocated: 28059017342976
>   referenced 26999960571904
> 
> So there is only one problem left, I ran a second repair (You Don't Only Repair Once), to see what would happen. Same result.
> 
> After a reboot the thing is back in ro... So I guess a rebuild it is then?

What's the dmesg of the RO flipping?

Thanks,
Qu

> 
> Thanks and best
> Otto
> 
> 
>>
> 
>> If it doesn't work, go the rebuild as planned.
>> But if it works, you saved a lot of time and should be able to use the
>> fs without any problem (as long as btrfs check --readonly returns no error).
> <snip>
