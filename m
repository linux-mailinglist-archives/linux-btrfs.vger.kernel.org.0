Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817016E57D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 05:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjDRDVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 23:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDRDVP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 23:21:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7501B659A
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 20:21:13 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzBp-1q6YQT0mZ7-00HxfZ; Tue, 18
 Apr 2023 05:21:04 +0200
Message-ID: <58fdd612-d2ac-1a77-25e5-59e8f7b668a2@gmx.com>
Date:   Tue, 18 Apr 2023 11:21:00 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH U-BOOT 2/3] btrfs: btrfs_file_read: allow opportunistic
 read until the end
In-Reply-To: <ZD4Jiagu0sWIPZDa@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ntqc1aJ7qg2UL2zz7BQKrZmXdwrSIcJbCWMkKPYcNXEcEDD8wWo
 YLKdUfg12SE8MkZhP5bm/govtDnK7GrFTYYzHtm/oysFu/ZpD17YWQnieqBOH0u1rai+7kg
 Iwgw/v2F1pRPrARb9Jar/QHlP828tgTjQ76vHtk6GqcLEsvk49M3nrAq8wMYAYf0mgv4y97
 Eru4du7HMFIS+WM/dT+bw==
UI-OutboundReport: notjunk:1;M01:P0:/SijsJih2mE=;Yk37zA3z/V+TbKc176Ek88kkqma
 bjVliYZ3yzSAMIy+2dDzj4tBBXM6MI0MZYIZPzPbWaTwGtn2zCiTZyJQfcYiN/uZ5oZtL8UH7
 0aSk5uoH+MkczhCaH9Z/whotozQaXTrJg53qfiqMNyUysD35Dtz8arMsFuWP5l7oFCeva7BjA
 ZWZAsMAerxRpj4hQfZT/lHSHIeHacRq85WDAQZ08Fm0b3J9FLc1VgumA7teITGppqkByRLsUG
 7JlUCc9vME+pj+8PUsCIXl6UGcTU5bi6YfKqtR/yTghHmI+sHmmdIBILL+pmNY9G9IAzzKS1h
 Zsj3fg8ImbUOM5pOJrO9/oGomJB8XSvLWpnUBln5P+iS53JO5JRLroKbQjsAsuU1gxtz7MviP
 MA8WxTzc+59zmd7Y7DitijCv0NQBDH6TwZ4gyDxJ8uj7RAH6pOmSmQUOcz+idCHCqPmVljxyL
 +6XQayxFr2Hc4Dzr+oxu3JrEh8an902DFm5UZQ2UQjAnHqwtFZAOY1xkh8q89PLmqhQ8wyQpP
 6X2Ubx8lpp1g4cJiPsLQaS958lwkUqbVMZO0+QMZLNhRVf190bpwIIvzvCs175bLJ6otxKRF5
 pXpRH9IA/8r0KrgjneUp8O1pBK+y9TlZE0N9d8Wcw2y+RrkoAPSXf+s474gPT0L2a0WQ/Sljq
 FrzO++YN7AOFzPsZC3LECRt248wPf+8V5X+4o5LMPkVHfVBocpLhbDIKEd/gjAEd0FElm33C1
 brJwhYLmlU7Gmlevrj84hjhUIxXWn26cYyycgYaGOlIeP93+zCWGvn67qjki8d3hd/gBsj0lO
 3a1ygx1nspVKbMK+Y6saw3WkF+cUjAJ6ABpvHt/fh1zVyu0n3jYD5D+oekpz9B48gMvV2hNdZ
 /B005yHjWiaF4Xee+1equXMrdDaymi7tHsO5BHTD+Gi2GpZe7NkjPQ2sjvQ8jxNvuohECTf7Q
 ao7mT/NZEE+zLEmt5ZRXq1GrOwI=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 11:07, Dominique Martinet wrote:
> Qu Wenruo wrote on Tue, Apr 18, 2023 at 10:53:41AM +0800:
>>> I have a feeling the loop could just be updated to go to the end
>>> `while (cur < end)` as it doesn't seem to care about the end
>>> alignment... Should I update v2 to do that instead?
>>
>> Yeah, it would be very awesome if you can remove the tailing part
>> completely.
> 
> Ok, will give it a try.
> I'll want to test this a bit so might take a day or two as I have other
> work to finish first.
> 
>>> This made me look at the "Read out the leading unaligned part" initial
>>> part, and its check only looks at the sector size but it probably has
>>> the same problem -- we want to make sure we read any leftover from a
>>> previous extent e.g. this file:
>>
>> If you're talking about the same problem mentioned in patch 1, then yes, any
>> read in the middle of an extent would cause problems.
> 
> No, was just thinking the leading part being a separate loop doesn't
> seem to make sense either as the code shouldn't care about sector size
> alignemnt but about full extents.

The main concern related to the leading unaligned part is, we need to 
skip something unaligned from the beginning , while all other situations 
never need to skip such case (they at most skip the tailing part).

Maybe we can do some extra calculation to handle it, but I'm not in a 
hurry to address the leading part.

Another thing is, for all other fs-ish interface (kernel/fuse etc), they 
all read/write in certain block size, then handle unaligned part from a 
higher layer.
Thus I prefer to have most things handled in an aligned fashion, and 
only handle the unaligned part specially.

But if you can find an elegant way to handle all cases, that would be 
really awesome!

Thanks,
Qu

> If the main loop handles everything correctly then the leading if can
> also be removed along with "read_and_truncate_page" that would no longer
> be used.
> 
> I'll give this a try as well and report back.
> 
>> No matter if it's aligned or not, as btrfs would convert any unaligned part
>> into aligned read.
> 
> Yes I don't see where it would fail (except that my board does crash),
> I guess that at this point I should spend some time building a qemu
> u-boot and hooking up gdb will be faster..
> 
>> My initial plan is to merge the tailing part into the aligned loop, but
>> since you're already working in this part, feel free to do it.
> 
> Yes, sure -- removing the if is easy, I'd just rather not make it fail
> for someone else :)
> 
