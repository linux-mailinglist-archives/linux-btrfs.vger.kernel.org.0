Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5299F65F074
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 16:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjAEPt7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 10:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjAEPts (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 10:49:48 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Jan 2023 07:49:41 PST
Received: from libero.it (smtp-35.italiaonline.it [213.209.10.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553DD5F4A3
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 07:49:41 -0800 (PST)
Received: from [192.168.1.10] ([109.115.99.168])
        by smtp-35.iol.local with ESMTPA
        id DSTtpmJyXvBy9DSTtpAK1P; Thu, 05 Jan 2023 16:48:38 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1672933718; bh=7qy4BrdbMgU8u11IoIhzDIOG/pimV4ZFUqU4t+JqID4=;
        h=From;
        b=xIExUNOP+rFSTMnjckAImVapmUXcJahNKSRPMb96D769A2yD7Bw3FaCukfKldkCir
         hTszKW4HSJ6QK9aS43y7tDVtsd3O6qv6lA7argBywJ3xdau9kDTjc26w0SUYe02KYN
         bMr9g4EFqlu4ViNFDkjXCLCd7ximRzRtMdNjXb/xQGrk5EWFd6nyQTPAWj6/crV1P2
         wLoQwlAkU7qHAQY6tGoKq2VPgIRT+XYJsX4NvqGlOXjbKqD8yuq8mg3kccUDFy3LuA
         mrEN0n55ScitxzOLMsvpGg7mRWz19KSOFMOmLhdU8VywmR3x+rqTwS1sRSBtH4auo+
         VT3re9uwJKOvw==
X-CNFS-Analysis: v=2.4 cv=MquXV0We c=1 sm=1 tr=0 ts=63b6f156 cx=a_exe
 a=QSCPwyis7r+KPoQOe0NQ+A==:117 a=QSCPwyis7r+KPoQOe0NQ+A==:17
 a=IkcTkHD0fZMA:10 a=0_aahQn49O7BzZe8FlMA:9 a=QEXdDO2ut3YA:10
Message-ID: <0de3f1eb-4131-774b-74bc-ab2cfdd022de@inwind.it>
Date:   Thu, 5 Jan 2023 16:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: File system can't mount
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Robert LeBlanc <robert@leblancnet.us>,
        linux-btrfs@vger.kernel.org
References: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
 <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
 <4f134378-4298-bc28-c17a-8415ffdc19e9@gmx.com>
 <50ecc4dc-fbf1-8fca-5484-27de33a2ed85@gmx.com>
From:   Antonio Muci <a.mux@inwind.it>
In-Reply-To: <50ecc4dc-fbf1-8fca-5484-27de33a2ed85@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEdzLa8nkN9P/hjEPxAode5AuRBNrsuFDAai+Xq4Rce6qI4sd9cBIBuGz/BbMtovsKVHy1sFeRw7p0ilTjpgdG8iljit393sMGK7FZoqM9T4oHM+IFCU
 i5l3+Gp7S5dVisAKduUGrSXKs7+Ol2omjvZricXb3r4UMbNFC7NNWkZ53YALkdJ6p7NyIaI+7Oshx+LlobnRFhWB81yT8BG+YQmSjBn7O1bUHDcMNxbDZV8L
 SScxDEtHUAZEk8G4zae9yWiKoyyAu//bFjFXCNSqFU8=
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/01/23 13:08, Qu Wenruo wrote:
> 
> 
> On 2023/1/5 14:44, Qu Wenruo wrote:
>>
>> On 2023/1/5 13:24, Robert LeBlanc wrote:
>>> On Wed, Jan 4, 2023 at 10:11 PM Robert LeBlanc <robert@leblancnet.us> 
>>> wrote:
>>>>
>>>> [...]
>>>>
>>>> #:~/code/btrfs-progs$ sudo ./btrfs check /dev/mapper/1EV13X7B
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/mapper/1EV13X7B
>>>> UUID: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
>>>> [1/7] checking root items
>>>> [2/7] checking extents
>>>> WARNING: tree block [12462950961152, 12462950977536) is not nodesize
>>>> aligned, may cause problem for 64K page system
>>>> ERROR: add_tree_backref failed (extent items tree block): File exists
>>>> ERROR: add_tree_backref failed (non-leaf block): File exists
>>>> tree backref 12462950957056 root 7 not found in extent tree
>>>> incorrect global backref count on 12462950957056 found 1 wanted 0
>>>> backpointer mismatch on [12462950957056 1]
> 
> And there are two extent items involved in the case.
> 
> The number 12462950961152 is the incorrect backref, while extent 
> 12462950957056 is the correct extent item which misses the backref item.
> 
> I'm afraid that, there could be a memory bitflip:
> 
> 12462950957056 = 0xb55c1c3c000
> 12462950961152 = 0xb55c1c3d000
> 
> The difference is one bit flipped in the larger one.
> 
> Thus I strongly recommended to do a memtest before trying anything else.
> 
> Thanks,
> Qu


Hi Qu,

I've been lurking the mailing list for a long time now (thanks everyone 
btw: it is really a teaching experience), and I conditioned myself to 
convert in hex whatever number I find in the logs in order to look for 
bitflips.

In this case, however, even if I understand your explanation, I would 
not have been able to deduce it by simply reading the logs. Maybe having 
them also in hex would have helped a bit, but I am not really sure (how 
to realize that 12462950961152 is the incorrect backref?).

Is there any way to give more hints to the user in the error messages? 
Where to look?

Thanks
Antonio


>>>> extent item 12462950961152 has multiple extent items
>>>> ref mismatch on [12462950961152 16384] extent item 1, found 2
>>>> backref 12462950961152 root 7 not referenced back 0x56292931ae60
>>>> incorrect global backref count on 12462950961152 found 1 wanted 2
>>>> backpointer mismatch on [12462950961152 16384]
>>>> owner ref check failed [12462950961152 16384]
>>>> bad metadata [12462950961152, 12462950977536) crossing stripe boundary
>>>> data backref 12493662797824 root 13278 owner 193642 offset 0 num_refs
>>>> 0 not found in extent tree
>>>> incorrect local backref count on 12493662797824 root 13278 owner
>>>> 193642 offset 0 found 1 wanted 0 back 0x562920287070
>>>> incorrect local backref count on 12493662797824 root 17592186057694
>>>> owner 193642 offset 0 found 0 wanted 1 back 0x562929472ba0
>>>> backref disk bytenr does not match extent record,
>>>> bytenr=12493662797824, ref bytenr=0
>>>> backpointer mismatch on [12493662797824 24576]
>>>> ERROR: errors found in extent allocation tree or chunk allocation
>>>> [3/7] checking free space cache
>>>> there is no free space entry for 12462950957056-12462950961152
>>>> cache appears valid but isn't 12461878018048
>>>> [4/7] checking fs roots
>>>> [5/7] checking only csums items (without verifying data)
>>>> [6/7] checking root refs
>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>> found 13920420491265 bytes used, error(s) found
>>>> total csum bytes: 13555483180
>>>> total tree bytes: 17152835584
>>>> total fs tree bytes: 1858191360
>>>> total extent tree bytes: 563019776
>>>> btree space waste bytes: 1424108973
>>>> file data blocks allocated: 28183758581760
>>>> referenced 19476700778496
>>>>
>>>> #:~/code/btrfs-progs$ git rev-parse HEAD
>>>> 1169f4ee63d900b25d9828a539cee4f59f8e9ad7
>>>> ```
>>>>
>>>> dmesg output:
>>>> ```
>>>> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): using crc32c
>>>> (crc32c-intel) checksum algorithm
>>>> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): allowing 
>>>> degraded mounts
>>>> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): disk space
>>>> caching is enabled
>>>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>>>> /dev/mapper/8HJK8KGH errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
>>>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>>>> /dev/mapper/8HHW90DY errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
>>>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>>>> /dev/mapper/1EV13X7B errs: wr 0, rd 0, flush 0, corrupt 18, gen 2
>>>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>>>> /dev/mapper/K1KLMBZN errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
>>>> [Wed Jan  4 19:52:41 2023] BTRFS critical (device dm-5): corrupt leaf:
>>>> block=45382409060352 slot=31 extent bytenr=12462950973440 len=16384
>>>> previous extent [12462950961152 169 0] overlaps current extent
>>>> [12462950973440 169 0]
>>>> [Wed Jan  4 19:52:41 2023] BTRFS error (device dm-5): read time tree
>>>> block corruption detected on logical 45382409060352 mirror 2
>>>> [Wed Jan  4 19:52:41 2023] BTRFS critical (device dm-5): corrupt leaf:
>>>> block=45382409060352 slot=31 extent bytenr=12462950973440 len=16384
>>>> previous extent [12462950961152 169 0] overlaps current extent
>>>> [12462950973440 169 0]
>>
>> Sometimes I have to say, tree-checker is more to-the-point than 
>> btrfs-check.
>>
>> It's very plain that one metadata backref item overlaps with the 
>> previous one.
>>
>> Which can be very problematic (the content of tree block overlapping 
>> is not a good thing at all).
>>
[...]
