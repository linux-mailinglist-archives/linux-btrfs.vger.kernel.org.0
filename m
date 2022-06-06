Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709F253EDA5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiFFSLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 14:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFFSLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 14:11:08 -0400
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7727E99809
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 11:11:04 -0700 (PDT)
Received: from [192.168.1.27] ([78.12.29.176])
        by smtp-17.iol.local with ESMTPA
        id yHBrnXWP5ikHEyHBrnqHnj; Mon, 06 Jun 2022 20:11:01 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1654539061; bh=All87qvI4oQ5me9werqWF+pWIx+Y1hBNns495SjaOQY=;
        h=From;
        b=vU0tryCsNpFHCzLJZDc840SgGDM8lrk7jAhKQJ4dJwEFqIh/XqMlsW/VqplIZlDqc
         EBySa0pPg0U3gVDQPqEQFAqABN2PivKRxjEJUVhG4mR0Bu2RvMjE4zwivZfCkwrajf
         xeqLfSOnJwM2OP0ozv2J64Fxk0j7crz1vIKzC8Ot42IAs9wckjcEo7vzF/mc3iVnmA
         n3G3hmnGNegL3k33CpFS29DUjXcwEdEp/zrmrOsCNIoKN6xUjsLQZso80IrBTj69Uw
         7+PLhbCxYkGwWWP+Gphzy200gduPiyd0jaB27z3Oh7aQCwqN8Qrlu4P3F9cqN6vL28
         TNRL5E79CF88w==
X-CNFS-Analysis: v=2.4 cv=Y7A9DjSN c=1 sm=1 tr=0 ts=629e4335 cx=a_exe
 a=j3kPaYAfCNpxz33IBwghmg==:117 a=j3kPaYAfCNpxz33IBwghmg==:17
 a=IkcTkHD0fZMA:10 a=7TWMlPWzzBHSqczCwEcA:9 a=QEXdDO2ut3YA:10
Message-ID: <128e0119-088b-7a10-c874-551196df4c56@libero.it>
Date:   Mon, 6 Jun 2022 20:10:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Lukas Straub <lukasstraub2@web.de>
Cc:     Martin Raiber <martin@urbackup.org>,
        Paul Jones <paul@pauljones.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220601102532.D262.409509F4@e16-tech.com>
 <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
 <20220601170741.4B12.409509F4@e16-tech.com>
 <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
 <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <6cbc718d-4afb-87e7-6f01-a1d06a74ab9e@gmx.com>
 <01020181209a0f8e-b97fa255-3146-4ced-b9c9-a6627a21d6e1-000000@eu-west-1.amazonses.com>
 <f56d4b11-1788-e4b5-35fa-d17b46a46d00@gmx.com>
 <20220603093207.6722d77a@gecko>
 <8c318892-0d36-51bb-18e0-a762dd75b723@gmx.com>
 <252577ba-1659-62f8-fc44-fea506eb97b7@gmx.com>
 <c4c298bf-ca54-1915-c22f-a6d87fc5a78f@gmx.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <c4c298bf-ca54-1915-c22f-a6d87fc5a78f@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDIdGx4wyj4GUeaHWo9bcCOsVpseM/Jn0lnC2pLpPfgmeuhJ4JqhrbksVhaqY0OPPQ8C4R53pvjub63ppDlmhTrG/7rrFvR+kxDNyqQdSJSRHh53BvP4
 mGzYVWyclw85iqBVBpufwJWSE1FEIqYvDT3UrQFWuP5WGsDxlyLjeA/Tedb26Uoppzhn5uJRW5rfhAKLaJnhTeqk3W/3Wfw4T5kC5pBFgOX6b4IQVeT5hfbF
 OsJxGmNaY526s4oLMkKMO2LextMoEuOXJ0rtfHdpT82xbDJ5jNWPA6W5hMntKtz65wZwo9ZXHkOlTKcglSv4Xex0dULInTXLmVqww3/f75zCj7bGsHHeTgQ1
 20NeRTuP
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

On 06/06/2022 13.21, Qu Wenruo wrote:
> 
> 
> On 2022/6/6 16:16, Qu Wenruo wrote:
>>
>>
> [...]
>>>>
>>>> Hello Qu,
>>>>
>>>> If you don't care about the write-hole, you can also use a dirty bitmap
>>>> like mdraid 5/6 does. There, one bit in the bitmap represents for
>>>> example one gigabyte of the disk that _may_ be dirty, and the bit is
>>>> left
>>>> dirty for a while and doesn't need to be set for each write. Or you
>>>> could do a per-block-group dirty bit.
>>>
>>> That would be a pretty good way for auto scrub after dirty close.
>>>
>>> Currently we have quite some different ideas, but some are pretty
>>> similar but at different side of a spectrum:
>>>
>>>      Easier to implement        ..     Harder to implement
>>> |<- More on mount time scrub   ..     More on journal ->|
>>> |                    |    |    \- Full journal
>>> |                    |    \--- Per bg dirty bitmap
>>> |                    \----------- Per bg dirty flag
>>> \--------------------------------------------------- Per sb dirty flag
>>
>> In fact, recently I'm checking the MD code (including their MD-raid5).
>>
>> It turns out they have write-intent bitmap, which is almost the per-bg
>> dirty bitmap in above spectrum.
>>
>> In fact, since btrfs has all the CoW and checksum for metadata (and part
>> of its data), btrfs scrub can do a much better job than MD to resilver
>> the range.
>>
>> Furthermore, we have a pretty good reserved space (1M), and has a pretty
>> reasonable stripe length (1GiB).
>> This means, we only need 32KiB for the bitmap for each RAID56 stripe,
>> much smaller than the 1MiB we reserved.
>>
>> I think this can be a pretty reasonable middle ground, faster than full
>> journal, while the amount to scrub should be reasonable enough to be
>> done at mount time.

Raid5 is "single fault proof". This means that it can sustain only one
failure *at time* like:
1) unavailability of a disk (e.g. data disk failure)
2) a missing write in the stripe (e.g. unclean shutdown)

a) Until now (i.e. without the "bitmap intent"), even if these failures happen
in different days (i.e. not at the same time), the result may be a "write hole".

b) With the bitmap intent, the write hole requires that 1) and 2) happen
at the same time. But this would be not anymore a "single fault", with only an
exception: if these failure have a common cause (e.g. a power
failure which in turn cause the dead of a disk). In this case this has to be
considered "single fault".

But with a battery backup (i.e. no power failure), the likelihood of b) became
negligible.

This to say that a write intent bitmap will provide an huge
improvement of the resilience of a btrfs raid5, and in turn raid6.

My only suggestions, is to find a way to store the bitmap intent not in the
raid5/6 block group, but in a separate block group, with the appropriate level
of redundancy.

This for two main reasons:
1) in future BTRFS may get the ability of allocating this block group in a
dedicate disks set. I see two main cases:
a) in case of raid6, we can store the intent bitmap (or the journal) in a
raid1C3 BG allocated in the faster disks. The cons is that each block has to be
written 3x2 times. But if you have an hybrid disks set (some ssd and some hdd,
you got a noticeable gain of performance)
b) another option is to spread the intent bitmap (or the journal) in *all* disks,
where each disks contains only the the related data (if we update only disk #1
and disk #2, we have to update only the intent bitmap (or the journal) in
disk #1 and  disk #2)


2) having a dedicate bg for the intent bitmap (or the journal), has another big
advantage: you don't need to change the meaning of the raid5/6 bg. This means
that an older kernel can read/write a raid5/6 filesystem: it sufficient to ignore
the intent bitmap (or the journal)



> 
> Furthermore, this even allows us to go something like bitmap tree, for
> such write-intent bitmap.
> And as long as the user is not using RAID56 for metadata (maybe even
> it's OK to use RAID56 for metadata), it should be pretty safe against
> most write-hole (for metadata and CoW data only though, nocow data is
> still affected).
> 
> Thus I believe this can be a valid path to explore, and even have a
> higher priority than full journal.
> 
> Thanks,
> Qu
> 



-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
