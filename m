Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA76E6E579F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 04:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjDRCx6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 22:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRCx5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 22:53:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA794C10
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 19:53:55 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQkK-1qbDyr3lPU-00vR2e; Tue, 18
 Apr 2023 04:53:46 +0200
Message-ID: <fca50995-0745-4374-a64a-40378ea95262@gmx.com>
Date:   Tue, 18 Apr 2023 10:53:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH U-BOOT 2/3] btrfs: btrfs_file_read: allow opportunistic
 read until the end
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZD4DV49fqKmPjMjU@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sIh1jY+xxKegfIOAHkc7+Z+Z4KYSaNlURPm/qKCPWqMNLts2zoi
 DiWWoMPHRIyv7eZALpFuyt6mHdtRnLx6DCf+03rH7SQFVlf6QBakHWWlQAPebI2YCfZlLVF
 yf0OgmpnuDCCWyMvhqetDgKGZsUKkEVc2SE53S8+HEN7xrWsoARJ6t4s5v6bjxbhULnYf0W
 pWfjcl2doNRC8fltUH/ug==
UI-OutboundReport: notjunk:1;M01:P0:27rqjwB55ow=;3NdIHKs8mm/S+EWqWj3XpKIrsp1
 xWaldTWNWyFeHvT5GqD13TMyKzoRmZUGT7HVYDWnrnNxxJ3ErhrYeJfUoMoFhF2DoZe4K2J+9
 ZUSaDn9taNp+51ilgm5XoLOvfjFXBg3omEVSthslSnW1wykwoQofideKE+oOE1sJNcg3VPipG
 AFa1GhOYAeXOwnyvs/WCYpDGX5luW1gcRpe4tgG8IdijGlCZm1s8MXVusFW7neu7Cn/gsOA2e
 JyI8CqdSCb/e7bIdvujnTiYfq/mksmAkb3hfhGSCQyG0foGVBFYybZFUXh5TCqwBoESd9uCQb
 dNAAH/G6YXICnDdRJuKxJn5/1ak2Glul0OJW1cnsojZLTfOtKHqz6TdsHqzzSUWLQTXIAOvFF
 sZghLt4Wrq/XzJlQLPvcasxZBovtscwF+PjqzdM9gsGR6gsYk9zJ71sK1/XTcbL157ARz80h0
 LFLqzz9iWxYyW+pKTkV0/yjeErM8BLtaXEMAmI0aVTaWU8U2aZbs/tg1lXzvT1gOXh3Erwl6l
 fGGzEWO6si0YlYDnP7xF1TQeWkDGN8QIMoANxohLNJXoljQsvgGc7+AfH8Ep7xmhfJ3TJVJL+
 TQ5++AAvpBJ5nL3DwJJ+2xkMsCzY3nf5eXzfgltt7AXeJRLyUcGXfKWWR5UEII94LaMP+GFEi
 +tFcs49EGHmvEW8wTTcgUaNHLBDr1PFgCUyLVGKiSy+oqUW9RKWGSl/kqu1iEu/wQfgjifHlz
 UKWDShL22GUWuGjW451ACJdxQfHmyvOnzEyiaGqdgWjtKxwvFbORT+wW9DS9QOrXTneVH7gF7
 9Ae6jkacHENfVy4pWWjfJhqh8l8PxWokqKVS4oRLMjT8kVRSHQQcQ5tBeq+sRsKAJ/AxwQCV+
 YEeOxH0Rnv18IUl2p7QWGhfodxzlYVrmARpBovLP12oVU/YYXoNiRT4WHul99PZyHNQpxwokM
 6tPxW3BffZaxThgAuWuRGsVK6pc=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 10:41, Dominique Martinet wrote:
> Qu Wenruo wrote on Tue, Apr 18, 2023 at 10:02:00AM +0800:
>>>    	/* Read the tailing unaligned part*/
>>
>> Can we remove this part completely?
>>
>> IIRC if we read until the target end, the unaligned end part can be
>> completely removed then.
> 
> The "Read the aligned part" loop stops at aligned_end:
>> while (cur < aligned_end)
> 
> So it should be possible that the last aligned extent we consider does
> not contain data until the end, e.g. an offset that ends with the
> aligned end:
> 
> 0            4096    4123
> [extent1-----|extent2]
> 
> In this case the main loop will only read extent1 and we need the
> "trailing unaligned part" if for extent2.
> 
> I have a feeling the loop could just be updated to go to the end
> `while (cur < end)` as it doesn't seem to care about the end
> alignment... Should I update v2 to do that instead?

Yeah, it would be very awesome if you can remove the tailing part 
completely.

> 
> 
> 
> This made me look at the "Read out the leading unaligned part" initial
> part, and its check only looks at the sector size but it probably has
> the same problem -- we want to make sure we read any leftover from a
> previous extent e.g. this file:

If you're talking about the same problem mentioned in patch 1, then yes, 
any read in the middle of an extent would cause problems.

No matter if it's aligned or not, as btrfs would convert any unaligned 
part into aligned read.

But if we fix the bug you mentioned, I see nothing can going wrong.

Unaligned read is converted into aligned one (then copy the target range 
into the dest buf), and aligned part (including the tailing unaligned 
part) would be properly handled then.

> 0              4096       8192
> [extent1------------------|extent2]
> and reading from 4k with a sectorsize of 4k is probably bad will enter
> the aligned main loop right away...
> And I think that'll fail?...
> Actually not quite sure what's expecting what to be aligned in there,
> but I just tried some partial reads from non-zero offsets and my board
> resets almost all the time so I guess I've found something else to dig
> into.
> This isn't a priority for me right now but I'll look a bit more when I
> have more time if you haven't first.
> 
My initial plan is to merge the tailing part into the aligned loop, but 
since you're already working in this part, feel free to do it.

And I'm very happy to provide any help on this.

Thanks,
Qu
