Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B26E5A33
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 09:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjDRHPY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 03:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDRHPT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 03:15:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AF51FC3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 00:15:16 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEV3I-1pYmIg1CbS-00Fxpz; Tue, 18
 Apr 2023 09:15:08 +0200
Message-ID: <aadd02ae-bb62-f0d2-6ec8-847c2181cd7a@gmx.com>
Date:   Tue, 18 Apr 2023 15:15:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-2-47ba9839f0cc@codewreck.org>
 <6c82ddd9-0e3d-4213-5cd3-af7ad69ebe48@gmx.com>
 <ZD4DV49fqKmPjMjU@codewreck.org>
 <fca50995-0745-4374-a64a-40378ea95262@gmx.com>
 <ZD4Jiagu0sWIPZDa@codewreck.org>
 <58fdd612-d2ac-1a77-25e5-59e8f7b668a2@gmx.com>
 <ZD4UP8oqlU0sP6Tt@codewreck.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH U-BOOT 2/3] btrfs: btrfs_file_read: allow opportunistic
 read until the end
In-Reply-To: <ZD4UP8oqlU0sP6Tt@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xyEKbOmdNMWF6vvxOT6LlIWMjspZVUEjs/U38V/yVHbnV8n4M1p
 khjLGVjB7jr1ygHQ2q3gpfCDgn4j2SfcSr6xvKdC3FfFs+JzEviboD9CX8JMxOELCXrjhLd
 SjdvODj8uK29H+5UDkLkaoPzRPmHgPuPDX3A/y5qfd7nmy+NRQGnAK4xVII03u0CX4YF01u
 ozmuWyrYmbXGNtg30kGLA==
UI-OutboundReport: notjunk:1;M01:P0:3ZryUKa/duE=;nZwCWyXpkN6sWNiQTaMDIgVLGW5
 O0s4bGYC7DPKrWoOGqfEjTeRqshC3Ty4wrivyahkfjnESUcKXLxmv3iXjVX8WK1FLcyE07YYW
 x1CeZi6qm/mRynkQOMwfv1qGTqzXlWj5rEBMnf+gYZdRdgh3LLV6IOdLQLfxP4XPPobGo1SHg
 giJPaI6VbZmyqTkVN13kzj4KQTrtokHHi2mOSLDcAjPL/pSdm/7hru7QLySxrk0MH2ZbSo1aO
 gkY76bQmIRYXVCKwg++e7GyAZvkKhwifqukFdLArSYiie3pqe8ZiZ0SuGkZSiRFqXbNwPSman
 8sEwi2vwPgQUWcRU4BQTm3u3bmZUfEISScuchVn57D9lzhCZHMMPGzZSdKXVyRn13BQpcZP8i
 M+NLT90S2rpE3amtSqQYWSHHaCFQYwzmsDFqAaniIguAtZDZQAhFUgTfezxYWdTQZUnuLsh3X
 jM1WDQhlv2/rwblGwOA9efqG7+5HRL4s304gtwxhObwUaskPkvEAudIuhkFq8OzkibthEc48M
 Y41FVqsk8invPAWeG0rIsIcsGhb63hyKyB3GyuhzJK3E9bqZztAfnGy/NLP70T9xZXv4n6zVu
 qpNhQk3KETMUMZd2emlELqIU8K6Z8T9L72b+v9k8HkpKLlSdQ88SFxsZcDd39zi9JIob2+rGT
 Qb0E1gc5PPVveRi7hoq6rtOu4NBYfPDv5vNYOOcLpGii8oej0+1TZgy0GawR+KL3BNbyb8UVJ
 G82Ow0VGhN9Mp8CuE9XBEFZMeTunZPHtjAOv5CBtinOa5QvFqQpjykn0LrwYvDbg9GHZj9Yoi
 wcedpfv3gdW8YuTtWRxbyvw/6hogpMUBu8oUufHOCKbg/A2G/+Lko1c7/Q7yoF/OsRkCDu9R2
 nUGmWZui6C429n/ptSzeEdJetX7NwC3OK2R+jmZKKf9sx49Gm4gIFJRqMIiertxwiW6GufuOk
 WMbbRQVTPu7LEYXsYhL9Arsk6e0=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 11:53, Dominique Martinet wrote:
> Qu Wenruo wrote on Tue, Apr 18, 2023 at 11:21:00AM +0800:
>>> No, was just thinking the leading part being a separate loop doesn't
>>> seem to make sense either as the code shouldn't care about sector size
>>> alignemnt but about full extents.
>>
>> The main concern related to the leading unaligned part is, we need to skip
>> something unaligned from the beginning , while all other situations never
>> need to skip such case (they at most skip the tailing part).
> 
> Ok, there is one exception for inline extents apparently.. But I'm not
> still not convinced the `aligned_start != file_offset` check is enough
> for that either; I'd say it's unlikely but the inline part can be
> compressed, so we could have a file which has > 4k (sectorsize) of
> expanded data, so a read from the 4k offset would skip the special
> handling and fail (reading the whole extent in dest)

Btrfs inline has a limit to sectorsize.

That means, inlined compressed extent can at most be 4K sized (if 4K is 
our sector size).

So that won't be a problem.

> 
> Even if that's not possible, reading just the first 10 bytes of an
> inline extent will be aligned and go through the main loop which just
> reads the whole extent, so it'll need the same handling as the regular
> btrfs_read_extent_reg handling at which point it might just as well
> handle start offset too.

If we just read 10 bytes, the aligned part should handle it well.

My real concern is what if we read 10 bytes at offset 10 bytes.

If this can be handled in the same way of aligned read (and still be 
reasonable readable), then it would be awesome.

> 
> 
> That aside taking the loop in order:
> - lookup_data_extent doesn't care (used in heading/tail)
> - skipping holes don't care as they explicitely put cursor at start of
> next extent (or bail out if nothing next)
> - inline needs fixing anyway as said above
> - PREALLOC or nothing on disk also goes straight to next and is ok
> - ah, I see what you meant now, we need to substract the current
> position within the extent to extent_num_bytes...
> That's also already a problem, though; to take the same example:
> 0                 8k           16k
> [extent1          | extent2 ... ]
> reading from 4k onwards will try to read
> min(extent_num_bytes, end-cur) = min(8k, 12k) = 8k
> from the 4k offset which goes over the end of the extent.

That's indeed a problem.

As most of the Uboot fs drivers only care read the whole file, never 
really utilize the ability to read part of the file, that path is not 
properly tested.
(Some driver, IIRC ubifs?, doesn't even allow read with non-zero offset)

Thanks,
Qu

> 
> That could actually be my resets from the previous mail.
> 
> 
> So either the first check should just lookup the extent and check that
> extent start matches current offset instead of checking for sectorsize
> alignment, or we can just fix the loop and remove the first if.
> 
